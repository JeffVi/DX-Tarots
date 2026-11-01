-- Mod metadata is defined in DX-Tarots.json

----------------------------------------------
------------MOD CODE -------------------------

---------- local functions & variables ----------

DXT = DXT or {}

-- Plain Lua number of a value that may be a Talisman big number (hand levels, chips, dollars...)
function DXT.to_number(value)
    if type(value) == 'table' and to_number then return to_number(value) end
    return value
end

local enhanced_prototype_centers = {}
local js_mod = SMODS.current_mod
local js_config = js_mod.config
DXT.config = js_config

-- Chance (or shop weight for the boosters) of the DX and Cursed versions at the Normal level
local base_rates = {tarot_dx = 0.1, tarot_cu = 0.07, planet_dx = 0.12, spectral_dx = 0.15, booster_dx = 0.1}
-- Multipliers of the levels available in the settings: Off, Low, Normal, High, Very high
local rate_levels = {0, 0.5, 1, 2, 3}

function DXT.rate(key)
    return base_rates[key] * (rate_levels[js_config[key..'_level']] or 1)
end
js_mod.prefix_config = {key = false, atlas = false, shader = false, card_key = false}

-- Enhancement values permanently increased by the cursed tarots (by config.extra per use)
local cu_enhancement_buffs = {
    {tarot = 'c_empress_cu', enhancement = 'm_mult', field = 'mult'},
    {tarot = 'c_heirophant_cu', enhancement = 'm_bonus', field = 'bonus'},
    {tarot = 'c_chariot_cu', enhancement = 'm_steel', field = 'h_x_mult'},
    {tarot = 'c_justice_cu', enhancement = 'm_glass', field = 'Xmult'},
    {tarot = 'c_devil_cu', enhancement = 'm_gold', field = 'h_dollars'},
    {tarot = 'c_tower_cu', enhancement = 'm_stone', field = 'bonus'},
}

-- Set enhancements to vanilla values plus the cursed tarots used this run (vanilla only if reset)
-- Already enhanced cards keep their own values, see DXT.buff_enhanced_cards
function DXT.update_cu_buffs(reset)
    local used = (not reset and G.GAME and G.GAME.used_cu_augments) or {}
    for _, b in ipairs(cu_enhancement_buffs) do
        local extra = G.P_CENTERS[b.tarot] and G.P_CENTERS[b.tarot].config.extra or 0
        G.P_CENTERS[b.enhancement].config[b.field] = enhanced_prototype_centers[b.enhancement] + extra * (used[b.tarot] or 0)
    end
end

-- Add a cursed tarot buff to the cards already enhanced
function DXT.buff_enhanced_cards(tarot_key)
    for _, b in ipairs(cu_enhancement_buffs) do
        if b.tarot == tarot_key then
            for _, v in pairs(G.playing_cards) do
                if v.config.center_key == b.enhancement then
                    v.ability[b.field] = v.ability[b.field] + G.P_CENTERS[b.tarot].config.extra
                end
            end
        end
    end
end

local function setUpDX()

    -- Add consumables
    G.P_CENTER_POOLS.Tarot_dx = {}
    G.P_CENTER_POOLS.Tarot_cu = {}
    G.P_CENTER_POOLS.Planet_dx = {}
    G.P_CENTER_POOLS.Spectral_dx = {}

    -- Save vanilla enhanced centers
    for _, b in ipairs(cu_enhancement_buffs) do
        enhanced_prototype_centers[b.enhancement] = G.P_CENTERS[b.enhancement].config[b.field]
    end

    -- Manage get_badge_colour
    get_badge_colour(foil)
    G.BADGE_COL['unique'] = G.C.ETERNAL
    G.BADGE_COL['star_bu'] = G.C.SUITS.Diamonds
    G.BADGE_COL['moon_bu'] = G.C.SUITS.Clubs
    G.BADGE_COL['sun_bu'] = G.C.SUITS.Hearts
    G.BADGE_COL['world_bu'] = G.C.SUITS.Spades
end

-- Should be called after everithing was overrided...
local function loadDXCUModule()

    -- Load modules
    assert(load(NFS.load(js_mod.path .. "source/api/dx_cu_api.lua")))()
    assert(load(NFS.load(js_mod.path .. "source/vanilla/vanilla_dx.lua")))()
    assert(load(NFS.load(js_mod.path .. "source/vanilla/vanilla_cu.lua")))()

end

local function loadCursesModule()

    -- Load modules
    assert(load(NFS.load(js_mod.path .. "source/api/curse_api.lua")))()
    assert(load(NFS.load(js_mod.path .. "source/vanilla/vanilla_curses.lua")))()
    
    -- Add curses
    DXT.setup_curses()
end

local function loadBuncoModule()

    if SMODS.Mods and (SMODS.Mods['Bunco'] or {}).can_load  then
        
        -- Load modules
        assert(load(NFS.load(js_mod.path .. "source/bunco/bunco_dx.lua")))()
        
        -- Add new dx stuff
        DXT.load_bunco_dx()
    end
end

---------- planet editions ----------

-- Mod loaded, whatever the case of its id
local function mod_loaded(id)
    id = string.lower(id)
    for mod_id, mod in pairs(SMODS.Mods or {}) do
        if string.lower(mod_id) == id and mod.can_load then return true end
    end
    return false
end

-- Hand values may be Talisman big numbers (tables): only plain numbers are rounded
local function clamp(value, min)
    if type(value) == 'number' then return math.floor(math.max(value, min)) end
    return value
end

local hand_minimums = {chips = 0, mult = 1}

local operations = {
    add = {prefix = '+', apply = function(value, amount) return value + amount end},
    mult = {prefix = 'x', apply = function(value, amount) return value * amount end},
    pow = {prefix = '^', apply = function(value, amount) return value ^ amount end},
}

-- Steamodded effect keys an edition may return, and how they change the leveled up hand
local edition_effects = {
    {keys = {'chips', 'h_chips', 'chip_mod'}, param = 'chips', op = 'add'},
    {keys = {'x_chips', 'xchips', 'Xchip_mod'}, param = 'chips', op = 'mult'},
    {keys = {'e_chips', 'echips', 'Echip_mod'}, param = 'chips', op = 'pow'},
    {keys = {'mult', 'h_mult', 'mult_mod'}, param = 'mult', op = 'add'},
    {keys = {'x_mult', 'xmult', 'Xmult', 'x_mult_mod', 'Xmult_mod'}, param = 'mult', op = 'mult'},
    {keys = {'e_mult', 'emult', 'Emult_mod'}, param = 'mult', op = 'pow'},
}

-- Editions without a scoring effect (they change the card values instead)
local special_editions = {
    -- Cryptid Oversaturated: doubles values
    e_cry_oversat = function(card, preview)
        return {{param = 'chips', op = 'mult', amount = 2}, {param = 'mult', op = 'mult', amount = 2}}
    end,
    -- Cryptid Glitched: random values
    e_cry_glitched = function(card, preview)
        if preview then
            return {{param = 'chips', op = 'mult', text = 'x...'}, {param = 'mult', op = 'mult', text = 'x...'}}
        end
        local hellno = pseudorandom('dx_glitched') < 1 / 3
        local factor = hellno and (pseudorandom('dx_glitched', 1, 10) / 10) or (pseudorandom('dx_glitched', 11, 100) / 10)
        return {{param = 'chips', op = 'mult', amount = factor}, {param = 'mult', op = 'mult', amount = factor}}
    end,
}

-- Changes of the hand given by the card edition, from what the edition does when scored
-- preview: only to display them, without rolling random values (Black Hole)
local function edition_changes(card, preview)
    local key = card.edition and card.edition.key
    local edition = key and G.P_CENTERS[key]
    if not edition then return {} end
    if special_editions[key] then return special_editions[key](card, preview) end
    if type(edition.calculate) ~= 'function' then return {} end

    -- Modded editions may expect a real scoring context: ignore their errors
    local ok, effect = pcall(edition.calculate, edition, card, {pre_joker = true, main_scoring = true, cardarea = G.play})
    local changes = {}
    while ok and type(effect) == 'table' do
        for _, e in ipairs(edition_effects) do
            for _, k in ipairs(e.keys) do
                if effect[k] ~= nil then changes[#changes + 1] = {param = e.param, op = e.op, amount = effect[k]} end
            end
        end
        effect = effect.extra
    end
    return changes
end

local function change_text(change)
    return change.text or (operations[change.op].prefix..tostring(change.amount))
end

local function show_edition(card, changes, value, delay_time)
    local sound = G.P_CENTERS[card.edition.key].sound
    G.E_MANAGER:add_event(Event({trigger = 'after', delay = delay_time, func = function()
        if type(sound) == 'table' then play_sound(sound.sound, sound.per, sound.vol)
        else play_sound(sound or 'foil1') end
        card:juice_up(0.8, 0.5)
        return true end }))
    for _, change in ipairs(changes) do
        update_hand_text({delay = 0}, {[change.param] = value(change), StatusText = true})
    end
end

function DXT.planet_editions_enabled()
    return js_config.planet_edition_enabled and not mod_loaded('aurinko')
end

-- Apply the planet card edition to the hand
function DXT.apply_planet_editions(card, hand, instant)
    local changes = edition_changes(card)
    if not changes[1] then return end
    local h = G.GAME.hands[hand]
    for _, change in ipairs(changes) do
        h[change.param] = clamp(operations[change.op].apply(h[change.param], change.amount), hand_minimums[change.param])
    end
    if not instant then
        -- Added values show the new total, multipliers show themselves
        show_edition(card, changes, function(change)
            return change.op == 'add' and h[change.param] or change_text(change)
        end, 0.3)
        delay(1.3)
    end
end

-- Display the planet card edition without a specific hand (Black Hole)
function DXT.show_planet_editions(card)
    local changes = edition_changes(card, true)
    if changes[1] then show_edition(card, changes, change_text, 0.9) end
end

---------- mod init ----------

local function overrides()

    ---------- game ----------

    -- Restore vanilla enhancements
    local Game_delete_run_ref = Game.delete_run
    function Game.delete_run(self)

        DXT.update_cu_buffs(true)
        Game_delete_run_ref(self)
    end

    -- Apply cursed tarots buffs of the loaded run
    local Game_start_run_ref = Game.start_run
    function Game.start_run(self, args)

        DXT.update_cu_buffs(true)
        Game_start_run_ref(self, args)
        DXT.update_cu_buffs()
    end

    ---------- common_events ----------

    -- Chance to upgrade a created card to its DX/Cursed version
    local function upgrade_roll(rate)
        return pseudorandom('upgrade_card'..G.GAME.round_resets.ante) > math.min(1, math.max(0, 1 - rate))
    end

    -- Planet cards (more likely with the hand level) and Black Hole may have an edition
    local function poll_planet_edition(card, key_append)
        local hand_type = card.ability.consumeable.hand_type
        local mod = hand_type and (1 + 0.07 * math.min(7, DXT.to_number(G.GAME.hands[hand_type].level))) or 1
        if G.GAME.used_cu_augments and G.GAME.used_cu_augments.c_high_priestess_cu then
            mod = mod * G.P_CENTERS.c_high_priestess_cu.config.prob_mult * G.GAME.used_cu_augments.c_high_priestess_cu
        end
        card:set_edition(poll_edition('edi'..(key_append or '')..G.GAME.round_resets.ante, math.max(1, mod), true))
        check_for_unlock({type = 'have_edition'})
    end

    -- Set a chance to change pool from normal to DX/Cursed
    local create_card_ref = create_card
    function create_card(_type, area, legendary, _rarity, skip_materialize, soulable, forced_key, key_append)

        local new_type = _type
        local new_forced_key = forced_key

        if forced_key then
            -- Give a chance to the planet forced by Telescope to be DX, if its DX version exists
            local dx_center = G.P_CENTERS[forced_key..'_dx']
            if _type == 'Planet' and G.GAME.used_vouchers.v_telescope and G.STATE == G.STATES.PLANET_PACK and upgrade_roll(DXT.rate('planet_dx'))
            and dx_center and dx_center.extra_type == '_dx' then
                new_forced_key = dx_center.key
                new_type = 'Planet_dx'
            end
        else
            if new_type == 'Tarot' and upgrade_roll(DXT.rate('tarot_dx')) then new_type = 'Tarot_dx' end
            if (new_type == 'Tarot' or new_type == 'Tarot_dx') and upgrade_roll(DXT.rate('tarot_cu')) then new_type = 'Tarot_cu' end
            if new_type == 'Planet' and upgrade_roll(DXT.rate('planet_dx')) then new_type = 'Planet_dx' end
            if new_type == 'Spectral' and upgrade_roll(DXT.rate('spectral_dx')) then new_type = 'Spectral_dx' end
        end

        local created_card = create_card_ref(new_type, area, legendary, _rarity, skip_materialize, soulable, new_forced_key, key_append)
        local center = created_card.config and created_card.config.center

        -- manage unique cards
        if js_config.unique_enabled and center and center.unique and center.key then
            G.GAME.banned_keys[center.key] = true
        end

        if DXT.planet_editions_enabled() and created_card.ability.consumeable then
            local is_planet = (_type == 'Planet' or _type == 'Planet_dx') and created_card.ability.consumeable.hand_type
            local is_black_hole = center and (center.key == 'c_black_hole' or center.key == 'c_black_hole_dx')
            if is_planet or is_black_hole then poll_planet_edition(created_card, key_append) end
        end

        return created_card
    end

    -- Manage unique boosters
    local get_pack_ref = get_pack
    function get_pack(_key, _type)

        local center = get_pack_ref(_key, _type)
        if js_config.unique_enabled and center and center.unique and center.key then
            G.GAME.banned_keys[center.key] = true
        end
        return center
    end

    -- Apply planet edition to the leveled up hand
    local level_up_hand_ref = level_up_hand
    function level_up_hand(card, hand, instant, amount, statustext)

        level_up_hand_ref(card, hand, instant, amount, statustext)
        if DXT.planet_editions_enabled() and card and card.ability and card.ability.consumeable and card.edition then
            DXT.apply_planet_editions(card, hand, instant)
        end
    end

    ---------- Card ----------

    -- Blank voucher
    local card_apply_to_run_ref = Card.apply_to_run
    function Card.apply_to_run(self, center)

        if js_config.spectral_on_blank then
            local center_table = {
                name = center and center.name or self and self.ability.name,
                extra = center and center.config.extra or self and self.ability.extra
            }
            if center_table.name == 'Blank' then
                G.E_MANAGER:add_event(Event({func = function()
                    G.GAME.spectral_rate = G.GAME.spectral_rate + 1
                    return true end }))
            end
        end

        card_apply_to_run_ref(self, center)
    end

    -- Saves old curse rolls
    local card_set_ability_ref = Card.set_ability
    function Card.set_ability(self, center, initial, delay_sprites)

        local old_curse_rolls = self.ability and self.ability.debuff_by_curse_rolls
        card_set_ability_ref(self, center, initial, delay_sprites)
        if old_curse_rolls then
            self.ability.debuff_by_curse_rolls = old_curse_rolls
            if not initial then G.GAME.blind:debuff_card(self) end
        end
    end

    -- Show another version of the card, hidden if not discovered yet
    local function show_version(card, center)
        if not center.discovered then
            card.children.center = nil
            card.bypass_discovery_center = false
            card.params.discover = false
            card.params.bypass_discovery_center = false
        end
        card:set_ability(center, true)
    end

    -- Cycle Vanilla/DX/Cursed in collection
    local card_click_ref = Card.click
    function Card.click(self)

        card_click_ref(self)
        local center = self.config.center
        if self.area and self.area.config and self.area.config.collection and center.consumeable then
            local suffixes = {'', '_dx', '_cu'}
            local current = (center.extra_type == '_dx' and 2) or (center.extra_type == '_cu' and 3) or 1
            local base_key = current == 1 and center.key or string.sub(center.key, 1, -4)
            -- Next existing version, back to vanilla after the last one
            for i = 1, 2 do
                local suffix = suffixes[(current + i - 1) % 3 + 1]
                local next_center = G.P_CENTERS[base_key..suffix]
                if next_center and (next_center.extra_type or '') == suffix then
                    show_version(self, next_center)
                    break
                end
            end
        end
    end

    -- Enhanced wild cards description
    SMODS.Enhancement:take_ownership('m_wild', {
        loc_vars = function(self, info_queue, card)
            if G.GAME and G.GAME.used_cu_augments and G.GAME.used_cu_augments.c_lovers_cu then return {key = 'm_wild_cu'} end
        end,
    }, true)

    -- Enhanced wild cards copy the rank of the card on their left (Cursed Lovers)
    local card_get_id_ref = Card.get_id
    function Card.get_id(self)
        if G.GAME.used_cu_augments and G.GAME.used_cu_augments.c_lovers_cu and self.ability.effect == 'Wild Card' and not self.vampired and not self.debuffed and (self.area == G.hand or self.area == G.play) then
            -- Sort a copy, the game's card lists keep their order
            local cards = {}
            for i, card in ipairs((self.area == G.hand and G.hand.highlighted) or G.play.cards) do cards[i] = card end
            table.sort(cards, function(a, b) return a.T.x < b.T.x end)
            for i = 2, #cards do
                if cards[i] == self then return cards[i-1]:get_id() end
            end
        end
        return card_get_id_ref(self)
    end

    ---------- cardarea ----------

    -- Manage enhanced wild cards
    local cardarea_align_cards_ref = CardArea.align_cards
    function CardArea.align_cards(self)

        if G.GAME.used_cu_augments and G.GAME.used_cu_augments.c_lovers_cu and self == G.hand and G.STATE == G.STATES.SELECTING_HAND then
            self:parse_highlighted()
        end
        cardarea_align_cards_ref(self)
    end
    
    -- Manage Black Hole planet edition
    if not mod_loaded('aurinko') then
        SMODS.Consumable:take_ownership('c_black_hole', {
            use = function(self, card, area, copier)
                local used_tarot = copier or card
                update_hand_text({sound = 'button', volume = 0.7, pitch = 0.8, delay = 0.3}, {handname=localize('k_all_hands'),chips = '...', mult = '...', level=''})
                G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.2, func = function()
                    play_sound('tarot1')
                    used_tarot:juice_up(0.8, 0.5)
                    G.TAROT_INTERRUPT_PULSE = true
                    return true end }))
                update_hand_text({delay = 0}, {mult = '+', StatusText = true})
                G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.9, func = function()
                    play_sound('tarot1')
                    used_tarot:juice_up(0.8, 0.5)
                    return true end }))
                update_hand_text({delay = 0}, {chips = '+', StatusText = true})
                G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.9, func = function()
                    play_sound('tarot1')
                    used_tarot:juice_up(0.8, 0.5)
                    G.TAROT_INTERRUPT_PULSE = nil
                    return true end }))
                update_hand_text({sound = 'button', volume = 0.7, pitch = 0.9, delay = 0}, {level='+3'})
                if DXT.planet_editions_enabled() then DXT.show_planet_editions(used_tarot) end
                delay(1.3)
                for k, v in pairs(G.GAME.hands) do
                    level_up_hand(used_tarot, k, true, 1)
                end
                update_hand_text({sound = 'button', volume = 0.7, pitch = 1.1, delay = 0}, {mult = 0, chips = 0, handname = '', level = ''})
            end,
        }, true)
    end
end

-- Suits protected from debuffs by the cursed tarots
local suit_buffs = {
    Diamonds = 'c_star_cu',
    Clubs = 'c_moon_cu',
    Hearts = 'c_sun_cu',
    Spades = 'c_world_cu',
    bunc_Fleurons = 'c_bunc_sky_cu',
    bunc_Halberds = 'c_bunc_abyss_cu',
}

-- Steamodded calculation for the whole mod, called for every context
js_mod.calculate = function(self, context)
    if context.debuff_card then
        local card = context.debuff_card
        local buff = card.base and suit_buffs[card.base.suit]
        -- Cards protected by the Oil alchemical of CodexArcanum
        if (buff and G.GAME.used_cu_augments and G.GAME.used_cu_augments[buff]) or (card.ability and card.ability.oil) then
            return {prevent_debuff = true}
        end
    end
    return DXT.calculate_curses(context)
end

-- Collection pages of the DX and Cursed cards, which are not in the vanilla pools
local collection_pages = {
    {pool = 'Tarot_dx', label = 'b_dxt_tarot_dx', colour = 'Tarot'},
    {pool = 'Tarot_cu', label = 'b_dxt_tarot_cu', colour = 'Tarot'},
    {pool = 'Planet_dx', label = 'b_dxt_planet_dx', colour = 'Planet'},
    {pool = 'Spectral_dx', label = 'b_dxt_spectral_dx', colour = 'Spectral'},
}

local function collection_tally(pool)
    local tally = {tally = 0, of = 0}
    for _, v in ipairs(SMODS.collection_pool(pool)) do
        tally.of = tally.of + 1
        if v.discovered then tally.tally = tally.tally + 1 end
    end
    return tally
end

for _, page in ipairs(collection_pages) do
    G.FUNCS['your_collection_dxt_'..page.pool] = function(e)
        G.SETTINGS.paused = true
        G.FUNCS.overlay_menu{
            definition = SMODS.card_collection_UIBox(G.P_CENTER_POOLS[page.pool], {6, 6}, {back_func = 'your_collection_other_gameobjects'}),
        }
    end
end

-- Buttons in the "Other" page of the collection, and in the mod page
js_mod.custom_collection_tabs = function()
    local tabs = {}
    for _, page in ipairs(collection_pages) do
        local tally = collection_tally(G.P_CENTER_POOLS[page.pool])
        if tally.of > 0 then
            tabs[#tabs + 1] = UIBox_button({button = 'your_collection_dxt_'..page.pool, label = {localize(page.label)}, count = tally,
                minw = 5, id = 'your_collection_dxt_'..page.pool, colour = G.C.SECONDARY_SET[page.colour]})
        end
    end
    local curses = 0
    for _ in pairs(G.P_CURSES) do curses = curses + 1 end
    tabs[#tabs + 1] = UIBox_button({button = 'your_collection_curses', label = {localize('b_curses')}, count = {tally = curses, of = curses},
        minw = 5, id = 'your_collection_curses', colour = G.C.BLACK})
    return tabs
end

G.FUNCS.dxt_change_rate_level = function(args)
    js_config[args.cycle_config.ref_value] = args.to_key
end

-- Settings tab in the Mods menu, values are saved by Steamodded
js_mod.config_tab = function()
    local function rate_cycle(key)
        return create_option_cycle({label = localize('dxt_'..key..'_rate'), options = localize('ml_dxt_rate_levels'), opt_callback = 'dxt_change_rate_level',
            ref_value = key..'_level', current_option = js_config[key..'_level'], w = 3, scale = 0.7, colour = G.C.RED})
    end
    local function toggle(key)
        return create_toggle({label = localize('dxt_'..key), info = localize('ml_dxt_'..key..'_info'), ref_table = js_config, ref_value = key})
    end
    return {n = G.UIT.ROOT, config = {r = 0.1, minw = 8, minh = 6, align = "tm", padding = 0.2, colour = G.C.BLACK}, nodes = {
        {n = G.UIT.C, config = {align = "tm", padding = 0.1}, nodes = {
            rate_cycle('tarot_dx'),
            rate_cycle('tarot_cu'),
            rate_cycle('planet_dx'),
            rate_cycle('spectral_dx'),
            rate_cycle('booster_dx'),
        }},
        {n = G.UIT.C, config = {align = "tm", padding = 0.1}, nodes = {
            toggle('planet_edition_enabled'),
            toggle('spectral_on_blank'),
            toggle('unique_enabled'),
        }},
    }}
end

sendInfoMessage("Deluxe Consumables Cards Loaded", 'DX')

-- DX/Curses Sprites

SMODS.Atlas({key = 'Van_dx', path = 'Tarots_dx.png', px = 71, py = 95})
SMODS.Atlas({key = 'Van_cu', path = 'Tarots_cu.png', px = 71, py = 95})
SMODS.Atlas({key = 'Van_Booster_dx', path = 'booster_dx.png', px = 71, py = 95})

SMODS.UndiscoveredSprite { key = 'Tarot_dx', atlas = 'Van_dx', pos = G.t_undiscovered.pos }
SMODS.UndiscoveredSprite { key = 'Tarot_cu', atlas = 'Van_cu', pos = G.t_undiscovered.pos }
SMODS.UndiscoveredSprite { key = 'Planet_dx', atlas = 'Van_dx', pos = G.p_undiscovered.pos }
SMODS.UndiscoveredSprite { key = 'Spectral_dx', atlas = 'Van_dx', pos = G.s_undiscovered.pos }

setUpDX()

-------------------------------
---------- OVERRIDES ----------
-------------------------------

overrides()

loadDXCUModule()

loadCursesModule()

loadBuncoModule()

----------------------------------------------
------------MOD CODE END----------------------
