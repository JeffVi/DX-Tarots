--Class
Curse = Object:extend()

--Class Methods
function Curse:init(_curse, for_collection, _blind_type)
    self.key = _curse
    local proto = G.P_CURSES[_curse]
    self.config = copy_table(proto.config)
    self.pos = proto.pos
    self.name = proto.name
    self.tally = G.GAME.curse_tally or 0
    self.triggered = false
    G.curseid = G.curseid or 0
    self.ID = G.curseid
    G.curseid = G.curseid + 1
    self.ability = {}
    G.GAME.curse_tally = G.GAME.curse_tally and (G.GAME.curse_tally + 1) or 1
end

function Curse:save()
    return {
        key = self.key,
        tally = self.tally,
        triggered = self.triggered
    }
end

function Curse:load(curse_savetable)
    self.key = curse_savetable.key
    local proto = G.P_CURSES[self.key]
    self.config = copy_table(proto.config)
    self.pos = proto.pos
    self.name = proto.name
    self.tally = curse_savetable.tally
    self.ability = curse_savetable.ability
    self.triggered = curse_savetable.triggered
    G.GAME.curse_tally = math.max(self.tally, G.GAME.curse_tally) + 1

    -- Prevent having same boss and curse
    --G.GAME.banned_keys["bl"..string.sub(curse_savetable.key, 3, -1)] = true
end

function Curse:juice_up(_scale, _rot)
    if self.curse_sprite then self.curse_sprite:juice_up(_scale, _rot) end
end

function Curse:generate_UI(_size)
    _size = _size or 0.65

    local curse_sprite_tab = nil

    local curse_sprite = AnimatedSprite(0,0,_size*1,_size*1,G.ANIMATION_ATLAS["blind_chips"], self.pos or G.P_BLINDS.bl_small.pos)
    curse_sprite.T.scale = 1
    curse_sprite_tab = {n= G.UIT.C, config={align = "cm", ref_table = self, group = self.tally}, nodes={
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
                _self.config.h_popup_config ={align = 'cl', offset = {x=-0.1,y=0},parent = _self}
                Node.hover(_self)
                if _self.children.alert then 
                    _self.children.alert:remove()
                    _self.children.alert = nil
                    if self.key and G.P_CURSES[self.key] then G.P_CURSES[self.key].alerted = true end
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

function Curse:get_uibox_table(curse_sprite)
    curse_sprite = curse_sprite or self.curse_sprite
    local name_to_check, loc_vars, badges = self.name, {}, {}
    if name_to_check == 'The Ox' then loc_vars = {self.config.extra, localize(G.GAME.current_round.most_played_poker_hand, 'poker_hands')}
    elseif name_to_check == 'The Hook' then loc_vars = {self.config.extra}
    elseif name_to_check == 'The Mouth' then loc_vars = {self.config.extra}
    elseif name_to_check == 'The Fish' then loc_vars = {self.config.chanceN, self.config.chanceD}
    elseif name_to_check == 'The Club' then loc_vars = {self.config.chanceN, self.config.chanceD}
    elseif name_to_check == 'The Manacle' then loc_vars = {self.config.extra}
    elseif name_to_check == 'The Tooth' then loc_vars = {self.config.chanceN, self.config.chanceD}
    elseif name_to_check == 'The Wall' then loc_vars = {math.floor(self.config.extra * 100 - 100)}
    elseif name_to_check == 'The House' then loc_vars = {self.config.chanceN, self.config.chanceD}
    elseif name_to_check == 'The Mark' then loc_vars = {self.config.chanceN, self.config.chanceD}
    elseif name_to_check == 'The Wheel' then loc_vars = {self.config.chanceN, self.config.chanceD}
    elseif name_to_check == 'The Arm' then loc_vars = {self.config.chanceN, self.config.chanceD}
    elseif name_to_check == 'The Psychic' then loc_vars = {self.config.extra}
    elseif name_to_check == 'The Goad' then loc_vars = {self.config.chanceN, self.config.chanceD}
    elseif name_to_check == 'The Water' then loc_vars = {self.config.extra}
    elseif name_to_check == 'The Eye' then loc_vars = {self.config.extra}
    elseif name_to_check == 'The Plant' then loc_vars = {self.config.chanceN, self.config.chanceD}
    elseif name_to_check == 'The Needle' then loc_vars = {self.config.extra}
    elseif name_to_check == 'The Head' then loc_vars = {self.config.chanceN, self.config.chanceD}
    elseif name_to_check == 'The Window' then loc_vars = {self.config.chanceN, self.config.chanceD}
    elseif name_to_check == 'The Serpent' then loc_vars = {self.config.extra}
    elseif name_to_check == 'The Pillar' then loc_vars = {self.config.chanceN, self.config.chanceD}
    elseif name_to_check == 'The Flint' then loc_vars = {math.floor(100 - self.config.extra * 100)}
    elseif name_to_check == 'Violet Vessel' then loc_vars = {math.floor((self.config.extra^self.ability.exp) * 100 - 100), self.ability.exp}
    end
    curse_sprite.ability_UIBox_table = generate_card_ui(G.P_CURSES[self.key], nil, loc_vars, 'curse', badges)
    return curse_sprite
end

function Curse:remove_from_game()
    local curse_key = nil
    for k, v in pairs(G.GAME.curses) do
        if v == self then curse_key = k end
    end
    table.remove(G.GAME.curses, curse_key)
end

function Curse:remove()
    self:remove_from_game()
    local HUD_curse_key = nil
    for k, v in pairs(G.HUD_curses) do
        if v == self.HUD_curse then HUD_curse_key = k end
    end

    if HUD_curse_key then 
        if G.HUD_curses and G.HUD_curses[HUD_curse_key+1] then
            if HUD_curse_key == 1 then
                G.HUD_curses[HUD_curse_key+1]:set_alignment({type = 'bri',
                offset = {x=0.7,y=0},
                xy_bond = 'Weak',
                major = G.ROOM_ATTACH})
            else
                G.HUD_curses[HUD_curse_key+1]:set_role({
                xy_bond = 'Weak',
                major = G.HUD_curses[HUD_curse_key-1]})
            end
        end
        table.remove(G.HUD_curses, HUD_curse_key)
    end

    self.HUD_curse:remove()
end

local function setUpLocalizationCurses()

    G.localization.descriptions.Curse = {
        cu_hook = {
            name = "The Hook",
            text = {
                "{C:red}Discards #1#{} random",
                "cards per hand played"
            }
        },
        cu_wall = {
            name = "The Wall",
            text = {
                "Increase Blind",
                "size by {C:attention}#1#%{}"
            }
        },
        cu_wheel = {
            name = "The Wheel",
            text = {
                "{C:attention}#1# in #2#{} cards get",
                "drawn {C:attention}face down{}",
                "{C:inactive}(Fixed probability){}"
            }
        },
        cu_arm = {
            name = "The Arm",
            text = {
                "{C:attention}#1# in #2# chance{} to",
                "{C:attention}decrease{} level of",
                "played poker hand",
                "{C:inactive}(Fixed probability){}"
            }
        },
        cu_psychic = {
            name = "The Psychic",
            text = {
                "{X:red,C:white} X#1# {} Mult if playing",
                "less than {C:attention}5 cards{}"
            }
        },
        cu_goad = {
            name = "The Goad",
            text = {
                "{C:attention}#1# in #2# chance{} for",
                "each {C:spades}Spade{} card to",
                "be {C:attention}debuffed{}",
                "{C:inactive}(Fixed probability){}"
            }
        },
        cu_water = {
            name = "The Water",
            text = {
                "{C:red}-#1#{} discard"
            }
        },
        cu_eye = {
            name = "The Eye",
            text = {
                "{X:red,C:white} X#1# {} Mult if hand type",
                "was already played",
                "this round"
            }
        },
        cu_mouth = {
            name = "The Mouth",
            text = {
                "{X:red,C:white} X#1# {} Mult if hand type",
                "is different than the",
                "first played this round"
            }
        },
        cu_plant = {
            name = "The Plant",
            text = {
                "{C:attention}#1# in #2# chance{} for",
                "each {C:attention}face{} card to",
                "be {C:attention}debuffed{}",
                "{C:inactive}(Fixed probability){}"
            }
        },
        cu_needle = {
            name = "The Needle",
            text = {
                "{C:blue}-#1#{} hand"
            }
        },
        cu_head = {
            name = "The Head",
            text = {
                "{C:attention}#1# in #2# chance{} for",
                "each {C:hearts}Heart{} card to",
                "be {C:attention}debuffed{}",
                "{C:inactive}(Fixed probability){}"
            }
        },
        cu_tooth = {
            name = "The Tooth",
            text = {
                "{C:attention}#1# in #2# chance{} to",
                "lose {C:money}$1{} for",
                "each card played",
                "{C:inactive}(Fixed probability){}"
            }
        },
        cu_ox = {
            name = "The Ox",
            text = {
                "Lose {C:money}$#1#{} if played",
                "hand is a {C:attention}#2#{}",
                "{C:inactive}(Updated each Ante){}"
            }
        },
        cu_house = {
            name = "The House",
            text = {
                "{C:attention}#1# in #2# chance{} for each",
                "card of first hand to",
                "be {C:attention}drawn face down{}",
                "{C:inactive}(Fixed probability){}"
            }
        },
        cu_club = {
            name = "The Club",
            text = {
                "{C:attention}#1# in #2# chance{} for",
                "each {C:clubs}Club{} card to",
                "be {C:attention}debuffed{}",
                "{C:inactive}(Fixed probability){}"
            }
        },
        cu_fish = {
            name = "The Fish",
            text = {
                "Cards drawn after playing a",
                "hand have a {C:attention}#1# in #2# chance{} of",
                "being {C:attention}drawn face down{}",
                "{C:inactive}(Fixed probability){}"
            }
        },
        cu_window = {
            name = "The Window",
            text = {
                "{C:attention}#1# in #2# chance{} for",
                "each {C:diamonds}Diamond{} card to",
                "be {C:attention}debuffed{}",
                "{C:inactive}(Fixed probability){}"
            }
        },
        cu_manacle = {
            name = "The Manacle",
            text = {
                "{C:attention}-1 Hand Size{} if more",
                "than {C:blue}#1#{} hand remaining"
            }
        },
        cu_serpent = {
            name = "The Serpent",
            text = {
                "After the first Play or",
                "Discard, always draw {C:attention}#1#{} cards"
            }
        },
        cu_pillar = {
            name = "The Pillar",
            text = {
                "Cards played this Ante",
                "have a {C:attention}#1# in #2# chance{}",
                " of being {C:attention}debuffed{}",
                "{C:inactive}(Fixed probability){}"
            }
        },
        cu_flint = {
            name = "The Flint",
            text = {
                "Base {C:blue}Chips{} and",
                "{C:red}Mult{} are reduced",
                "by {C:attention}#1#%{}"
            }
        },
        cu_mark = {
            name = "The Mark",
            text = {
                "{C:attention}#1# in #2# chance{} for each",
                "{C:attention}face{} card to be",
                "drawn {C:attention}face down{}",
                "{C:inactive}(Fixed probability){}"
            }
        },
        cu_final_vessel = {
            name = "Violet Vessel",
            text = {
                "Increase Blind size by {C:attention}#1#%{}",
                "Getting a {X:black,C:white}curse{} will {C:attention}increase{} this",
                "ammount instead of applying a new {X:black,C:white}curse{}",
                "{C:inactive}(Currently: #2#){}"
            }
        },
    }
end

function setUpCurses()
    
    -- Curses
    G.P_CURSES = {
        cu_ox =              {name = 'The Ox',       set = 'Curse', discovered = true, min_ante = nil, order = 1, config = {type = 'curse', extra = 5}, pos = {x = 0,y = 2}},
        cu_hook =            {name = 'The Hook',     set = 'Curse', discovered = true, min_ante = nil, order = 2, config = {type = 'curse', extra = 1}, pos = {x = 0,y = 7}},
        cu_mouth =           {name = 'The Mouth',    set = 'Curse', discovered = true, min_ante = nil, order = 3, config = {type = 'curse', extra = 0.6}, pos = {x = 0,y = 18}},
        cu_fish =            {name = 'The Fish',     set = 'Curse', discovered = true, min_ante = nil, order = 4, config = {type = 'curse', chanceN = 1, chanceD = 2}, pos = {x = 0,y = 5}},
        cu_club =            {name = 'The Club',     set = 'Curse', discovered = true, min_ante = nil, order = 5, config = {type = 'curse', chanceN = 1, chanceD = 2}, pos = {x = 0,y = 4}},
        cu_manacle =         {name = 'The Manacle',  set = 'Curse', discovered = true, min_ante = nil, order = 6, config = {type = 'curse', extra = 1}, pos = {x = 0,y = 8}},
        cu_tooth =           {name = 'The Tooth',    set = 'Curse', discovered = true, min_ante = nil, order = 7, config = {type = 'curse', chanceN = 2, chanceD = 5}, pos = {x = 0,y = 22}},
        cu_wall =            {name = 'The Wall',     set = 'Curse', discovered = true, min_ante = nil, order = 8, config = {type = 'curse', extra = 1.4}, pos = {x = 0,y = 9}},
        cu_house =           {name = 'The House',    set = 'Curse', discovered = true, min_ante = nil, order = 9, config = {type = 'curse', chanceN = 2, chanceD = 3}, pos = {x = 0,y = 3}},
        cu_mark =            {name = 'The Mark',     set = 'Curse', discovered = true, min_ante = nil, order = 10, config = {type = 'curse', chanceN = 1, chanceD = 2}, pos = {x = 0,y = 23}},

        cu_wheel =           {name = 'The Wheel',    set = 'Curse', discovered = true, min_ante = nil, order = 11, config = {type = 'curse', chanceN = 1, chanceD = 9}, pos = {x = 0,y = 10}},
        cu_arm =             {name = 'The Arm',      set = 'Curse', discovered = true, min_ante = nil, order = 12, config = {type = 'curse', chanceN = 1, chanceD = 6}, pos = {x = 0,y = 11}},
        cu_psychic =         {name = 'The Psychic',  set = 'Curse', discovered = true, min_ante = nil, order = 13, config = {type = 'curse', extra = 0.6}, pos = {x = 0,y = 12}},
        cu_goad =            {name = 'The Goad',     set = 'Curse', discovered = true, min_ante = nil, order = 14, config = {type = 'curse', chanceN = 1, chanceD = 2}, pos = {x = 0,y = 13}},
        cu_water =           {name = 'The Water',    set = 'Curse', discovered = true, min_ante = nil, order = 15, config = {type = 'curse', extra = 1}, pos = {x = 0,y = 14}},
        cu_eye =             {name = 'The Eye',      set = 'Curse', discovered = true, min_ante = nil, order = 16, config = {type = 'curse', extra = 0.6}, pos = {x = 0,y = 17}},
        cu_plant =           {name = 'The Plant',    set = 'Curse', discovered = true, min_ante = nil, order = 17, config = {type = 'curse', chanceN = 1, chanceD = 2}, pos = {x = 0,y = 19}},
        cu_needle =          {name = 'The Needle',   set = 'Curse', discovered = true, min_ante = nil, order = 18, config = {type = 'curse', extra = 1}, pos = {x = 0,y = 20}},
        cu_head =            {name = 'The Head',     set = 'Curse', discovered = true, min_ante = nil, order = 19, config = {type = 'curse', chanceN = 1, chanceD = 2}, pos = {x = 0,y = 21}},
        cu_window =          {name = 'The Window',   set = 'Curse', discovered = true, min_ante = nil, order = 20, config = {type = 'curse', chanceN = 1, chanceD = 2}, pos = {x = 0,y = 6}},

        cu_serpent =         {name = 'The Serpent',  set = 'Curse', discovered = true, min_ante = nil, order = 21, config = {type = 'curse', extra = 2}, pos = {x = 0,y = 15}},
        cu_pillar =          {name = 'The Pillar',   set = 'Curse', discovered = true, min_ante = nil, order = 22, config = {type = 'curse', chanceN = 1, chanceD = 2}, pos = {x = 0,y = 16}},
        cu_flint =           {name = 'The Flint',    set = 'Curse', discovered = true, min_ante = nil, order = 23, config = {type = 'curse', extra = 0.7}, pos = {x = 0,y = 24}},
        
        cu_final_vessel =    {name = 'Violet Vessel',set = 'Curse', discovered = true, min_ante = nil, order = 23, config = {type = 'final_curse', extra = 1.5}, pos = {x=0, y=29}},
    }

    G.P_CENTER_POOLS.Curse = {}

    for k, v in pairs(G.P_CURSES) do
        v.key = k
        if not v.wip then 
            table.insert(G.P_CENTER_POOLS[v.set], v)
        end
    end

    table.sort(G.P_CENTER_POOLS["Curse"], function (a, b) return a.order < b.order end)

    setUpLocalizationCurses()

    G.localization.descriptions.Other.cursed = {
        name = "Cursed Version",
        text = {
            "Get a random",
            "{X:black,C:white} curse {} if used",
            "{C:attention}(x#1#){}"
        }
    }
    
    -- Manage get_badge_colour
    get_badge_colour(foil)
    G.BADGE_COL['curse'] = G.C.BLACK

    G.localization.misc.labels['curse'] = "Curse"
end

function add_curse(_curse)
    G.HUD_curses = G.HUD_curses or {}
    local curse_sprite_ui = _curse:generate_UI()
    G.HUD_curses[#G.HUD_curses+1] = UIBox{
        definition = {n=G.UIT.ROOT, config={align = "cm",padding = - 0.12, colour = G.C.CLEAR}, nodes={
          curse_sprite_ui
        }},
        config = {
          align = G.HUD_curses[1] and 'tm' or 'bri',
          offset = G.HUD_curses[1] and {x=0,y=0} or {x=1.27,y=-0.5},
          major = G.HUD_curses[1] and G.HUD_curses[#G.HUD_curses] or G.ROOM_ATTACH}
    }
    
    G.GAME.curses[#G.GAME.curses+1] = _curse
    _curse.HUD_curse = G.HUD_curses[#G.HUD_curses]
end

function create_curse()
    
    -- Check if we already pulled the final curse
    if G.GAME.final_curse then
        -- Increase its exp
        for k, v in pairs(G.GAME.curses) do
            if v.config.type == 'final_curse' then
                v.ability.exp = v.ability.exp + 1
                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    delay =  0.7,
                    func = (function() 
                            v:juice_up(0.3, 0.2)
                            play_sound('tarot2', 0.76, 0.4)
                        return true
                    end)
                }))
                break
            end
        end
    else
        -- Create curse
        local _pool, _pool_key = get_current_pool('Curse')
        local _curse = pseudorandom_element(_pool, pseudoseed(_pool_key))
        local it = 1
        while _curse == 'UNAVAILABLE' do
            it = it + 1
            _curse = pseudorandom_element(_pool, pseudoseed(_pool_key..'_resample'..it))
        end

        local new_curse = Curse(_curse)

        -- Check is this is a final curse or a regular curse
        if new_curse.config.type == 'final_curse' then
                G.GAME.final_curse = true
                new_curse.ability.exp = 1
        end
        -- Add curse
        add_curse(new_curse)
    
        -- Prevent having same boss and curse
        --G.GAME.banned_keys["bl"..string.sub(_curse, 3, -1)] = true
    
        if new_curse.name == 'The Eye' then
            new_curse.ability.hand = {
                ["Flush Five"] = false,
                ["Flush House"] = false,
                ["Five of a Kind"] = false,
                ["Straight Flush"] = false,
                ["Four of a Kind"] = false,
                ["Full House"] = false,
                ["Flush"] = false,
                ["Straight"] = false,
                ["Three of a Kind"] = false,
                ["Two Pair"] = false,
                ["Pair"] = false,
                ["High Card"] = false,
            }
        end
    end
end