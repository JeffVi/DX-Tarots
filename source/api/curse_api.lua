-- Curses: permanent maluses for the run, given by the cursed tarots, lifted by meeting a condition
--
-- G.P_CURSES[key]     definitions, registered with DXT.Curse{...}
-- G.GAME.dxt_curses   state of the curses of the run, plain tables saved with the game:
--                     {key, lifts, triggered, ability, tally}
-- def:calculate(curse, context) is called for every Steamodded context (see DXT.calculate_curses),
-- active or lifted: each definition checks DXT.is_curse_active itself for its effects
--
-- The curses are defined in one file per extension (vanilla_curses.lua, bunco_curses.lua...),
-- with the helpers of DXT.curse_utils

G.P_CURSES = {}
local curse_order = 0

-- Register a curse definition
function DXT.Curse(def)
    curse_order = curse_order + 1
    def.set = 'Curse'
    def.discovered = true
    def.order = curse_order
    def.config = def.config or {}
    def.config.type = def.config.type or 'curse'
    G.P_CURSES[def.key] = def
    return def
end

---------------------------
-------- Helpers ----------
---------------------------

local function curse_def(curse)
    return G.P_CURSES[curse.key]
end

-- A curse is active until lifted, the final curse is never lifted
function DXT.is_curse_active(curse)
    local def = curse_def(curse)
    return def.config.type ~= 'curse' or curse.lifts < def.config.lift
end
local active = DXT.is_curse_active

-- Fixed probability roll (not affected by probability effects, as written on the curses)
function DXT.is_curse_triggered(curse)
    local cfg = curse_def(curse).config
    if cfg.chanceN and cfg.chanceD then
        return pseudorandom(pseudoseed('cu'..curse_def(curse).name..G.GAME.round_resets.ante)) < (cfg.chanceN / cfg.chanceD)
    end
    return false
end
local triggered = DXT.is_curse_triggered

local function lift(curse, amount)
    curse.lifts = curse.lifts + (amount or 1)
end

-- Displayed curses (HUD), by curse state
local views = setmetatable({}, {__mode = 'k'})

local function juice(curse)
    if views[curse] then views[curse]:juice_up(0.3, 0.2) end
    play_sound('tarot2', 0.76, 0.4)
end

local function juice_later(curse, delay_time)
    G.E_MANAGER:add_event(Event({trigger = 'after', delay = delay_time or 0.7, func = function()
        juice(curse)
        return true end }))
end

-- A hand is played (not only selected)
local function hand_played(context)
    return context.debuff_hand and not context.check
end

local function any_scoring(context, check)
    for _, card in ipairs(context.scoring_hand or {}) do
        if check(card) then return true end
    end
    return false
end

-- Face down cards among the played or discarded cards
local function face_down_count(cards)
    local count = 0
    for i = 1, math.min(#cards, G.discard.config.card_limit - #G.play.cards) do
        if cards[i].ability.wheel_flipped then count = count + 1 end
    end
    return count
end

local function to_hand(context)
    return context.stay_flipped and context.to_area == G.hand
end

-- Increase the blind size (The Wall, Violet Vessel)
local function increase_blind_size(curse, mult)
    local chips = G.GAME.blind.chips * mult
    G.GAME.blind.chips = type(chips) == 'number' and math.floor(chips) or chips
    G.GAME.blind.chip_text = number_format(G.GAME.blind.chips)
    juice_later(curse)
end

-- X Mult malus at the end of the scoring (The Psychic, The Eye, The Mouth)
local function mult_malus(curse, context)
    if context.final_scoring_step and curse.triggered then
        curse.triggered = false
        juice_later(curse)
        return {xmult = curse_def(curse).config.extra}
    end
end

-- Curses with a chance to debuff some cards, lifted by playing hands without scoring them
local function debuff_curse(def, debuffs)
    def.config = {chanceN = 2, chanceD = 5, lift = 12}
    def.debuffs = debuffs
    def.loc_vars = function(self, curse) return {self.config.chanceN, self.config.chanceD} end
    def.calculate = function(self, curse, context)
        if hand_played(context) and not any_scoring(context, debuffs) then lift(curse) end
    end
    return DXT.Curse(def)
end

-- Helpers for the curse definition files (vanilla_curses.lua, bunco_curses.lua...)
DXT.curse_utils = {
    views = views,
    lift = lift,
    juice = juice,
    juice_later = juice_later,
    hand_played = hand_played,
    any_scoring = any_scoring,
    face_down_count = face_down_count,
    to_hand = to_hand,
    increase_blind_size = increase_blind_size,
    mult_malus = mult_malus,
    debuff_curse = debuff_curse,
}

---------------------------
------- Calculation -------
---------------------------

-- Debuff of a playing card by the active curses, rolled once per card and blind
local function debuff_card(card)
    if not (G.GAME.blind and G.GAME.blind.name ~= '') or card.area == G.consumeables or card.area == G.jokers then return end
    local rolls = card.ability.debuff_by_curse_rolls or {}
    card.ability.debuff_by_curse_rolls = rolls
    local debuffed = false
    for _, curse in ipairs(G.GAME.dxt_curses) do
        local def = curse_def(curse)
        if def and def.debuffs then
            if active(curse) and def.debuffs(card) then
                if rolls[curse.key] == nil then rolls[curse.key] = triggered(curse) end
            else
                -- The card or the curse changed (Tarot card, lifted curse...)
                rolls[curse.key] = nil
            end
            debuffed = debuffed or rolls[curse.key] or false
        end
    end
    if debuffed then return {debuff = true} end
end

local function on_lifted(curse, def)
    juice_later(curse)
    if def.debuffs then
        -- Outside of the current calculation, so every curse is evaluated again
        G.E_MANAGER:add_event(Event({func = function()
            for _, v in ipairs(G.playing_cards) do SMODS.recalc_debuff(v) end
            return true end }))
    end
end

-- Animated sprites of the HUD are sometimes removed from G.ANIMATIONS, add them back
local function keep_animations()
    for _, view in pairs(views) do
        local found = false
        for _, v in ipairs(G.ANIMATIONS) do
            if v == view.curse_sprite then found = true; break end
        end
        if not found and view.curse_sprite then table.insert(G.ANIMATIONS, view.curse_sprite) end
    end
end

-- Called from the mod calculate for every Steamodded context
function DXT.calculate_curses(context)

    -- Cursed consumables give curses
    if context.using_consumeable and context.consumeable.config.center.nb_curse then
        DXT.curse_consumeable(context.consumeable)
    end

    local curses = G.GAME.dxt_curses
    if not (curses and curses[1]) then return end

    if context.debuff_card then return debuff_card(context.debuff_card) end
    if context.setting_blind then keep_animations() end
    if context.blind_defeated then
        for _, v in ipairs(G.playing_cards) do
            v.ability.debuff_by_curse_rolls = nil
        end
    end

    local effects = {}
    for _, curse in ipairs(curses) do
        local def = curse_def(curse)
        if def then
            local was_active = active(curse)
            local eff = def:calculate(curse, context)
            if eff then effects[#effects + 1] = eff end
            if was_active and not active(curse) then on_lifted(curse, def) end
            if context.blind_defeated and def.config.type == 'curse' then curse.triggered = false end
        end
    end
    if effects[1] then return SMODS.merge_effects(effects) end
end

---------------------------
-------- Display ----------
---------------------------

local CurseView = Object:extend()

function CurseView:init(curse)
    self.curse = curse
    self.def = curse_def(curse)
end

function CurseView:juice_up(_scale, _rot)
    if self.curse_sprite then self.curse_sprite:juice_up(_scale, _rot) end
end

function CurseView:generate_UI(_size)
    _size = _size or 0.65

    local atlas = G.ANIMATION_ATLAS[self.def.atlas or 'blind_chips'] or G.ANIMATION_ATLAS['blind_chips']
    local curse_sprite = AnimatedSprite(0,0,_size*1,_size*1,atlas, self.def.pos or G.P_BLINDS.bl_small.pos)
    curse_sprite.T.scale = 1
    local curse_sprite_tab = {n= G.UIT.C, config={align = "cm", ref_table = self, group = self.curse.tally}, nodes={
        {n=G.UIT.O, config={w=_size*1,h=_size*1, colour = G.C.BLUE, object = curse_sprite, focus_with_object = true}},
    }}
    curse_sprite:define_draw_steps({
        {shader = 'dissolve', shadow_height = 0.05},
        {shader = 'dissolve'},
    })
    curse_sprite.float = true
    curse_sprite.states.hover.can = true
    curse_sprite.states.drag.can = false
    curse_sprite.states.collide.can = true
    curse_sprite.states.visible = true
    curse_sprite.config = {curse = self, force_focus = true}

    curse_sprite.hover = function(_self)
        if not G.CONTROLLER.dragging.target or G.CONTROLLER.using_touch then
            if not _self.hovering and _self.states.visible then
                _self.hovering = true
                if _self == curse_sprite then
                    _self.hover_tilt = 3
                    _self:juice_up(0.05, 0.02)
                    play_sound('paper1', math.random()*0.1 + 0.55, 0.42)
                    play_sound('tarot2', math.random()*0.1 + 0.55, 0.09)
                end

                self:get_uibox_table(curse_sprite)
                _self.config.h_popup =  G.UIDEF.card_h_popup(_self)
                _self.config.h_popup_config ={align = 'cl', offset = {x=-0.1,y=0}, parent = _self}
                Node.hover(_self)
                if _self.children.alert then
                    _self.children.alert:remove()
                    _self.children.alert = nil
                    self.def.alerted = true
                    G:save_progress()
                end
            end
        end
    end
    curse_sprite.stop_hover = function(_self) _self.hovering = false; Node.stop_hover(_self); _self.hover_tilt = 0 end

    curse_sprite:juice_up()
    self.curse_sprite = curse_sprite

    return curse_sprite_tab, curse_sprite
end

function CurseView:get_uibox_table(curse_sprite)
    curse_sprite = curse_sprite or self.curse_sprite
    local loc_vars = self.def.loc_vars and self.def:loc_vars(self.curse) or {}
    curse_sprite.ability_UIBox_table = generate_card_ui(self.def, nil, loc_vars, 'curse', {})
    return curse_sprite
end

local function add_to_hud(curse)
    G.HUD_curses = G.HUD_curses or {}
    local view = CurseView(curse)
    views[curse] = view
    G.HUD_curses[#G.HUD_curses+1] = UIBox{
        definition = {n=G.UIT.ROOT, config={align = "cm",padding = - 0.12, colour = G.C.CLEAR}, nodes={
          (view:generate_UI())
        }},
        config = {
          align = G.HUD_curses[1] and 'tm' or 'bri',
          offset = G.HUD_curses[1] and {x=0,y=0} or {x=1.27,y=-0.5},
          major = G.HUD_curses[1] and G.HUD_curses[#G.HUD_curses] or G.ROOM_ATTACH}
    }
    view.HUD_curse = G.HUD_curses[#G.HUD_curses]
end

---------------------------
-------- Curses API -------
---------------------------

-- State of a curse of the run
function DXT.find_curse(key)
    for _, curse in ipairs(G.GAME and G.GAME.dxt_curses or {}) do
        if curse.key == key then return curse end
    end
end

-- Add a curse to the run
function DXT.add_curse(key)
    local def = G.P_CURSES[key]
    local curse = {key = key, lifts = 0, triggered = false, ability = {}, tally = G.GAME.curse_tally or 0}
    G.GAME.curse_tally = (G.GAME.curse_tally or 0) + 1
    if def.config.type == 'final_curse' then
        G.GAME.final_curse = true
        curse.ability.exp = 1
    end
    table.insert(G.GAME.dxt_curses, curse)
    add_to_hud(curse)
    return curse
end

-- Give a random curse, or make the final curse stronger once every curse was given
function DXT.create_curse()
    if G.GAME.final_curse then
        for _, curse in ipairs(G.GAME.dxt_curses) do
            if curse_def(curse).config.type == 'final_curse' then
                curse.ability.exp = curse.ability.exp + 1
                juice_later(curse)
                break
            end
        end
        return
    end

    local held, keys, final_key = {}, {}, nil
    for _, curse in ipairs(G.GAME.dxt_curses) do held[curse.key] = true end
    for key, def in pairs(G.P_CURSES) do
        if def.config.type == 'final_curse' then final_key = final_key or key
        elseif not held[key] and not G.GAME.banned_keys[key] then keys[#keys + 1] = key end
    end
    table.sort(keys, function(a, b) return G.P_CURSES[a].order < G.P_CURSES[b].order end)
    DXT.add_curse(keys[1] and pseudorandom_element(keys, pseudoseed('Curse'..G.GAME.round_resets.ante)) or final_key)
end

-- Curses given by a used cursed consumable
function DXT.curse_consumeable(card)
    for i = 1, card.config.center.nb_curse do
        G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.2, func = function()
            play_sound('timpani')
            card:juice_up(0.3, 0.5)
            DXT.create_curse()
            return true end }))
        G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.8, func = function()
            attention_text({
                text = localize('k_cursed'),
                scale = 1.3,
                hold = 1.4,
                major = card,
                backdrop_colour = G.C.SECONDARY_SET.Tarot,
                align = (G.STATE == G.STATES.TAROT_PACK or G.STATE == G.STATES.SPECTRAL_PACK) and 'tm' or 'cm',
                offset = {x = 0, y = (G.STATE == G.STATES.TAROT_PACK or G.STATE == G.STATES.SPECTRAL_PACK) and -0.2 or 0},
                silent = true
                })
                G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.06*G.SETTINGS.GAMESPEED, blockable = false, blocking = false, func = function()
                    play_sound('tarot2', 0.76, 0.4);return true end}))
                play_sound('tarot2', 1, 0.4)
                card:juice_up(0.3, 0.5)
        return true end }))
    end
end

-- Debug, from the DebugPlus console: eval DXT.debug_add_curse('cu_wall')
function DXT.debug_add_curse(key)
    if not G.P_CURSES[key] then return 'Unknown curse '..tostring(key) end
    if G.P_CURSES[key].config.type == 'final_curse' and G.GAME.final_curse then
        DXT.create_curse()
        return 'Increased '..key
    end
    if DXT.find_curse(key) then return key..' is already in this run' end
    DXT.add_curse(key)
    return 'Added '..key
end

-- Debug: lift a curse of the run, eval DXT.debug_lift_curse('cu_wall')
function DXT.debug_lift_curse(key)
    local curse = DXT.find_curse(key)
    if not curse then return 'No curse '..tostring(key)..' in this run' end
    local def = curse_def(curse)
    if def.config.type ~= 'curse' then return key..' cannot be lifted' end
    if active(curse) then
        curse.lifts = def.config.lift
        on_lifted(curse, def)
    end
    return 'Lifted '..key
end

---------------------------
--------- Run setup -------
---------------------------

function DXT.setup_curses()

    G.BADGE_COL['cursed'] = G.C.BLACK
    -- Manage get_badge_colour
    get_badge_colour(foil)
    G.BADGE_COL['curse'] = G.C.BLACK

    local Game_init_game_object_ref = Game.init_game_object
    function Game.init_game_object(self)

        local ret = Game_init_game_object_ref(self)
        ret.dxt_curses = {}
        ret.final_curse = false
        return ret
    end

    -- Display the curses of the run
    local Game_start_run_ref = Game.start_run
    function Game.start_run(self, args)

        Game_start_run_ref(self, args)

        -- Saves from previous versions
        G.GAME.dxt_curses = G.GAME.dxt_curses or G.GAME.saved_curses or {}
        G.GAME.saved_curses = nil
        G.GAME.curses = nil

        G.HUD_curses = {}
        for k in pairs(views) do views[k] = nil end
        for _, curse in ipairs(G.GAME.dxt_curses) do
            if G.P_CURSES[curse.key] then add_to_hud(curse) end
        end
    end

    -- Curses limiting the draw (modifies_draw), like The Serpent blind: Steamodded must not refill the hand
    if SMODS.blind_modifies_draw then
        local blind_modifies_draw_ref = SMODS.blind_modifies_draw
        function SMODS.blind_modifies_draw(key)
            if blind_modifies_draw_ref(key) then return true end
            for _, curse in ipairs(G.GAME and G.GAME.dxt_curses or {}) do
                local def = G.P_CURSES[curse.key]
                if def and def.modifies_draw and def:modifies_draw(curse) then return true end
            end
            return false
        end
    end
end

---------------------------
------- Collection --------
---------------------------

local function create_UIBox_your_collection_curses()
  local curse_tab = {}
  for k, v in pairs(G.P_CURSES) do
    curse_tab[#curse_tab+1] = v
  end

  -- Final curse last, after the curses added by other files (bunco_curses.lua...)
  table.sort(curse_tab, function (a, b)
    local a_final, b_final = a.config.type == 'final_curse', b.config.type == 'final_curse'
    if a_final ~= b_final then return b_final end
    return a.order < b.order
  end)

  -- 6 rows, more columns when curses are added by other mods (Bunco)
  local columns = math.max(4, math.ceil(#curse_tab / 6))
  local curse_matrix = {}
  for k, v in ipairs(curse_tab) do
    local temp_curse_ui = CurseView({key = v.key, lifts = 0, triggered = false, ability = {}, tally = k}):generate_UI()
    local row = math.ceil(k / columns)
    curse_matrix[row] = curse_matrix[row] or {}
    curse_matrix[row][1+((k-1)%columns)] = {n=G.UIT.C, config={align = "cm", padding = 0.2}, nodes={
      temp_curse_ui,
    }}
  end
  local curse_rows = {}
  for _, row in ipairs(curse_matrix) do
    curse_rows[#curse_rows+1] = {n=G.UIT.R, config={align = "cm"}, nodes=row}
  end

  local t = create_UIBox_generic_options({ back_func = 'your_collection_other_gameobjects', contents = {
    {n=G.UIT.C, config={align = "cm", r = 0.2, colour = G.C.BLACK, padding = 0.2, emboss = 0.05}, nodes={
      {n=G.UIT.C, config={align = "cm"}, nodes={
        {n=G.UIT.R, config={align = "cm"}, nodes=curse_rows}
      }}
    }}
  }})
  return t
end

G.FUNCS.your_collection_curses = function(e)
  G.SETTINGS.paused = true
  G.FUNCS.overlay_menu{
    definition = create_UIBox_your_collection_curses(),
  }
end

