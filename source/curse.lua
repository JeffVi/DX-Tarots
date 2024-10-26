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
                "this round",
                "{C:attention}#2#{}"
            }
        },
        cu_mouth = {
            name = "The Mouth",
            text = {
                "{X:red,C:white} X#1# {} Mult if hand type",
                "is different than the",
                "first played this round",
                "{C:attention}#2#{}"
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
                "amount instead of applying a new {X:black,C:white}curse{}",
                "{C:inactive}(Currently: #2#){}"
            }
        },
    }

    G.localization.descriptions.CurseLiftCondition = {
        cu_hook = {
            name = "Lift condition",
            text = {
                "Discard {C:red}#1#{} cards",
                "{C:inactive}(Progress: #2#/#1#){}"
            }
        },
        cu_wall = {
            name = "Lift condition",
            text = {
                "Score more than",
                "{C:attention}150%{} of blind size",
                "{C:attention}#1#{} times",
                "{C:inactive}(Progress: #2#/#1#){}"
            }
        },
        cu_wheel = {
            name = "Lift condition",
            text = {
                "Play {C:blue}#1#{} hands",
                "containing at least",
                "3 {C:attention}face down{} cards",
                "{C:inactive}(Progress: #2#/#1#){}"
            }
        },
        cu_arm = {
            name = "Lift condition",
            text = {
                "Play {C:attention}#1# levels{} worth",
                "of poker hands",
                "{C:inactive}(Progress: #2#/#1#){}"
            }
        },
        cu_psychic = {
            name = "Lift condition",
            text = {
                "Play {C:blue}#1#{} hands",
                "containing {C:attention}5 cards{}",
                "{C:inactive}(Progress: #2#/#1#){}"
            }
        },
        cu_goad = {
            name = "Lift condition",
            text = {
                "Play {C:blue}#1#{} hands with",
                "no scoring {C:spades}Spade{} card",
                "{C:inactive}(Progress: #2#/#1#){}"
            }
        },
        cu_water = {
            name = "Lift condition",
            text = {
                "Defeat {C:attention}#1#{} blinds without",
                "using any discard",
                "{C:inactive}(Progress: #2#/#1#){}"
            }
        },
        cu_eye = {
            name = "Lift condition",
            text = {
                "Defeat {C:attention}#1#{} blinds without",
                "playing any repeated hand",
                "{C:inactive}(Progress: #2#/#1#){}"
            }
        },
        cu_mouth = {
            name = "Lift condition",
            text = {
                "Defeat {C:attention}#1#{} blinds with",
                "only one played hand",
                "{C:inactive}(Progress: #2#/#1#){}"
            }
        },
        cu_plant = {
            name = "Lift condition",
            text = {
                "Play {C:blue}#1#{} hands with",
                "no scoring {C:attention}face{} card",
                "{C:inactive}(Progress: #2#/#1#){}"
            }
        },
        cu_needle = {
            name = "Lift condition",
            text = {
                "Defeat {C:attention}#1#{} blinds without",
                "any hand remaining",
                "{C:inactive}(Progress: #2#/#1#){}"
            }
        },
        cu_head = {
            name = "Lift condition",
            text = {
                "Play {C:blue}#1#{} hands with",
                "no scoring {C:hearts}Heart{} card",
                "{C:inactive}(Progress: #2#/#1#){}"
            }
        },
        cu_tooth = {
            name = "Lift condition",
            text = {
                "Play {C:blue}#1#{} cards",
                "{C:inactive}(Progress: #2#/#1#){}"
            }
        },
        cu_ox = {
            name = "Lift condition",
            text = {
                "Defeat {C:attention}#1#{} blinds without",
                "triggering this curse",
                "{C:inactive}(Progress: #2#/#1#){}"
            }
        },
        cu_house = {
            name = "Lift condition",
            text = {
                "Play {C:blue}#1#{}",
                "face down cards",
                "{C:inactive}(Progress: #2#/#1#){}"
            }
        },
        cu_club = {
            name = "Lift condition",
            text = {
                "Play {C:blue}#1#{} hands with",
                "no scoring {C:clubs}Club{} card",
                "{C:inactive}(Progress: #2#/#1#){}"
            }
        },
        cu_fish = {
            name = "Lift condition",
            text = {
                "Discard {C:red}#1#{}",
                "face down cards",
                "{C:inactive}(Progress: #2#/#1#){}"
            }
        },
        cu_window = {
            name = "Lift condition",
            text = {
                "Play {C:attention}#1#{} hands with",
                "no scoring {C:diamonds}Diamond{} card",
                "{C:inactive}(Progress: #2#/#1#){}"
            }
        },
        cu_manacle = {
            name = "Lift condition",
            text = {
                "Play {C:blue}#1#{} hands with",
                "{C:attention}5 scoring cards{}",
                "{C:inactive}(Progress: #2#/#1#){}"
            }
        },
        cu_serpent = {
            name = "Lift condition",
            text = {
                "Draw {C:attention}#1#{} cards",
                "{C:inactive}(Progress: #2#/#1#){}"
            }
        },
        cu_pillar = {
            name = "Lift condition",
            text = {
                "Play {C:blue}#1#{} hands containing",
                "a {C:attention}debuffed scoring{} card",
                "{C:inactive}(Progress: #2#/#1#){}"
            }
        },
        cu_flint = {
            name = "Lift condition",
            text = {
                "Play {C:blue}#1#{} hands",
                "{C:inactive}(Progress: #2#/#1#){}"
            }
        },
        cu_mark = {
            name = "Lift condition",
            text = {
                "Discard {C:red}#1#{} hands",
                "containing at least",
                "{C:attention}3 face down{} cards",
                "{C:inactive}(Progress: #2#/#1#){}"
            }
        },
    }
end

---------------------------
-------- Overrides --------
---------------------------

local function override()

    -- Track final curse usage
    local Game_init_game_object_ref = Game.init_game_object
    function Game.init_game_object(self)

        local ret = Game_init_game_object_ref(self)
        ret.final_curse = false
        return ret
    end

    -- Track curses usage
    local Game_start_run_ref = Game.start_run
    function Game.start_run(self, args)
        
        Game_start_run_ref(self, args)

        local saveTable = args.savetext or nil

        G.GAME.curses = {}
        G.HUD_curses = {}
        
        if saveTable then 
            local curses = saveTable.GAME.saved_curses or {}
            for k, v in ipairs(curses) do
                local _curse = Curse('cu_wall')
                _curse:load(v)
                add_curse(_curse)
            end
        end
    end

    -- Manage pool if Curse pool
    local get_current_pool_ref  = get_current_pool
    function get_current_pool(_type, _rarity, _legendary, _append)

        if _type == 'Curse' then
            --create the pool
            G.ARGS.TEMP_POOL = EMPTY(G.ARGS.TEMP_POOL)
            local _pool, _starting_pool, _pool_key, _pool_size = G.ARGS.TEMP_POOL, nil, '', 0
        
            _starting_pool, _pool_key = G.P_CENTER_POOLS[_type], _type..(_append or '')
        
            --cull the pool
            for k, v in ipairs(_starting_pool) do
                local add = nil
                if _type == 'Curse' then
                    add = true
                    --if v.name == G.P_BLINDS[G.GAME.round_resets.blind_choices.Boss].name then add = nil
                    if v.config.type == 'final_curse' then add = nil
                    else
                        for kt, vt in ipairs(G.GAME.curses) do
                            if v.name == vt.name then
                                add = nil
                                break
                            end
                        end
                    end
                elseif _type == 'Final_Curse' then
                    if v.config.type == 'final_curse' then add = true end
                end
        
                if v.no_pool_flag and G.GAME.pool_flags[v.no_pool_flag] then add = nil end
                if v.yes_pool_flag and not G.GAME.pool_flags[v.yes_pool_flag] then add = nil end
                
                if add and not G.GAME.banned_keys[v.key] then 
                    _pool[#_pool + 1] = v.key
                    _pool_size = _pool_size + 1
                else
                    _pool[#_pool + 1] = 'UNAVAILABLE'
                end
            end
        
            --if pool is empty, return a final curse
            if _pool_size == 0 then
                _pool = EMPTY(G.ARGS.TEMP_POOL)
                if _type == 'Curse' then _pool[#_pool + 1] = "cu_final_vessel"  -- Only one for now TODO
                else _pool[#_pool + 1] = "cu_wall"    -- Should never happen...
                end
            end
        
            return _pool, _pool_key..G.GAME.round_resets.ante

        else
            -- Use normal pool
            local _pool, _pool_key = get_current_pool_ref(_type, _rarity, _legendary, _append)
            return _pool, _pool_key
        end
    end

    -- Save curses
    local save_run_ref = save_run
    function save_run()

        if G.F_NO_SAVING ~= true then
            local curses = {}
            for k, v in ipairs(G.GAME.curses) do
                if (type(v) == "table") and v.is and v:is(Curse) then 
                    local curseSer = v:save()
                    if curseSer then curses[k] = curseSer end
                end
            end
        
            G.GAME.saved_curses = curses
        end
        
        save_run_ref()
    end

    -- Manage usage of cursed consumables
    local card_use_consumeable_ref = Card.use_consumeable
    function Card.use_consumeable(self, area, copier)
        
        card_use_consumeable_ref(self, area, copier)
        
        -- Create curse if needed
        if self.config.center.nb_curse then
            for i = 1, self.config.center.nb_curse, 1
            do
                G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.2, func = function()
                    play_sound('timpani')
                    self:juice_up(0.3, 0.5)
                    create_curse()
                    return true end }))
                G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.8, func = function()
                    attention_text({
                        text = 'Cursed',
                        scale = 1.3, 
                        hold = 1.4,
                        major = self,
                        backdrop_colour = G.C.SECONDARY_SET.Tarot,
                        align = (G.STATE == G.STATES.TAROT_PACK or G.STATE == G.STATES.SPECTRAL_PACK) and 'tm' or 'cm',
                        offset = {x = 0, y = (G.STATE == G.STATES.TAROT_PACK or G.STATE == G.STATES.SPECTRAL_PACK) and -0.2 or 0},
                        silent = true
                        })
                        G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.06*G.SETTINGS.GAMESPEED, blockable = false, blocking = false, func = function()
                            play_sound('tarot2', 0.76, 0.4);return true end}))
                        play_sound('tarot2', 1, 0.4)
                        self:juice_up(0.3, 0.5)
                return true end }))
            end
        end
    end

    ----- Curses effects -----

    -- Manage curses debuff
    function custom_debuff_card(card)
        if not (G.GAME.blind and G.GAME.blind.name ~= '') then
            return false
        end
        -- We only debuff playing cards
        if (card.area == G.consumeables or card.area == G.jokers) then
            return false
        end
        card.ability.debuff_by_curse_rolls = card.ability.debuff_by_curse_rolls or {}
        if G.GAME.curses then
            for _, curse in ipairs(G.GAME.curses) do
                if curse.config.type == 'curse' and (curse.lifts < curse.config.lift) then
                    if curse.name == 'The Goad' and card:is_suit('Spades', true)
                    or curse.name == 'The Plant' and card:is_face(true)
                    or curse.name == 'The Head' and card:is_suit('Hearts', true)
                    or curse.name == 'The Club' and card:is_suit('Clubs', true)
                    or curse.name == 'The Window' and card:is_suit('Diamonds', true)
                    or curse.name == 'The Pillar' and card.ability.played_this_ante then
                        if card.ability.debuff_by_curse_rolls[curse.name] == nil then
                            card.ability.debuff_by_curse_rolls[curse.name] = is_curse_triggered(curse)
                        end
                    else
                        -- clear this roll, the card might have changed such that
                        -- it isn't affected by the curse anymore
                        -- (such as using a Tarot card)
                        card.ability.debuff_by_curse_rolls[curse.name] = nil
                    end
                end
            end
        end
        -- OR all rolls to obtain final value of debuff_by_curse
        for k, v in pairs(card.ability.debuff_by_curse_rolls) do
            if v then return true end
        end
        return false
    end

    ---------- state_events ----------

    -- Manage curses
    local G_FUNCS_draw_from_deck_to_hand_ref = G.FUNCS.draw_from_deck_to_hand
    function G.FUNCS.draw_from_deck_to_hand(e)

        local _e = e
        if (G.GAME.curses) then
            for k, v in pairs(G.GAME.curses) do
                if v.config.type == 'curse' and (v.lifts < v.config.lift) then
                    if v.name == "The Serpent" and not v.triggered then
                        if not (G.STATE == G.STATES.TAROT_PACK or G.STATE == G.STATES.SPECTRAL_PACK) then
                            if not v.triggered and (G.GAME.current_round.hands_played > 0 or G.GAME.current_round.discards_used > 0) then
                                v.triggered = true
                                _e = math.min(#G.deck.cards, v.config.extra)
                                v:juice_up(0.3, 0.2)
                                play_sound('tarot2', 0.76, 0.4)
                            end
                        end
                    end
                end
                if v.config.type == 'curse' then
                    if v.name == "The Serpent" then
                        if not (G.STATE == G.STATES.TAROT_PACK or G.STATE == G.STATES.SPECTRAL_PACK) then
                            local draws = _e or math.min(#G.deck.cards, G.hand.config.card_limit - #G.hand.cards)
                            v.lifts = v.lifts + draws
                        end
                    end
                end
            end
        end

        G_FUNCS_draw_from_deck_to_hand_ref(_e)
        
        G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.2, func = function()
            if (G.GAME.curses) then
                for k, v in pairs(G.GAME.curses) do
                    if v.config.type == 'curse' then
                        if v.name == "The Fish" then
                            v.triggered = false
                        end
                    end
                end
            end
        return true end }))
    end

    -- Manage curses
    local G_FUNCS_discard_cards_from_highlighted_ref = G.FUNCS.discard_cards_from_highlighted
    function G.FUNCS.discard_cards_from_highlighted(e, hook)

        local highlighted_cards = G.hand.highlighted
        local highlighted_count = math.min(#G.hand.highlighted, G.discard.config.card_limit - #G.play.cards)
        local face_down_cards = 0
        for i = 1, highlighted_count, 1 do
            face_down_cards = face_down_cards + ((highlighted_cards[i].ability.wheel_flipped and 1) or 0)
        end
        
        if (G.GAME.curses) then
            for k, v in pairs(G.GAME.curses) do
                if v.config.type == 'curse' then
                    if v.name == 'The Hook' then
                        v.lifts = v.lifts + (highlighted_count or 0)
                    end
                    if v.name == 'The Fish' then
                        v.lifts = v.lifts + face_down_cards
                    end
                    if v.name == 'The Mark' then
                        v.lifts = v.lifts + ((face_down_cards > 2) and 1 or 0)
                    end
                end
            end
        end

        G_FUNCS_discard_cards_from_highlighted_ref(e, hook)
    end

    ---------- Blind ----------

    -- Manage curses
    local blind_debuff_hand_ref = Blind.debuff_hand
    function Blind.debuff_hand(self, cards, hand, handname, check)
        
        local text, disp_text, poker_hands, scoring_hand, non_loc_disp_text = G.FUNCS.get_poker_hand_info(cards)

        if (G.GAME.curses) then
            local update_debuffs = false -- curses that debuff cards might be lifted
            for k, v in pairs(G.GAME.curses) do
                local already_lifted = v.lifts >= v.config.lift
                if v.config.type == 'curse' and (v.lifts < v.config.lift) then
                    if v.name == 'The Psychic' and #cards < 5 and not check then
                        v.triggered = true
                    end
                    if v.name == 'The Eye' then
                        if v.ability.hand[handname] and not check then
                            v.triggered = true
                        end
                        if not check then v.ability.hand[handname] = true end
                        v.ability.indicate_trig = v.ability.hand[handname]
                    end
                    if v.name == 'The Mouth' then
                        if v.ability.hand and v.ability.hand ~= handname and not check then
                            v.triggered = true
                        end
                        if (not check) and v.ability.hand == nil then v.ability.hand = handname end
                    end
                    if v.name == 'The Arm' then
                        if G.GAME.hands[handname].level > 1 then
                            if not check and is_curse_triggered(v) then
                                level_up_hand(v, handname, nil, -1)
                                v:juice_up(0.3, 0.2)
                                play_sound('tarot2', 0.76, 0.4)
                            end
                        end
                    end
                    if v.name == 'The Ox' then
                        if handname == G.GAME.current_round.most_played_poker_hand then
                            if not check then
                                v.triggered = true
                                G.E_MANAGER:add_event(Event({
                                    trigger = 'after',
                                    delay =  0.7,
                                    func = (function() 
                                            ease_dollars(-v.config.extra, true)
                                            v:juice_up(0.3, 0.2)
                                            play_sound('tarot2', 0.76, 0.4)
                                        return true
                                    end)
                                }))
                            end
                        end 
                    end
                end
                if v.config.type == 'curse' and not check then
                    if v.name == 'The Arm' then
                        v.lifts = v.lifts + G.GAME.hands[handname].level
                    end
                    if v.name == 'The Psychic' and #cards == 5 then
                        v.lifts = v.lifts + 1
                    end
                    if v.name == 'The Manacle' and #scoring_hand == 5 then
                        v.lifts = v.lifts + 1
                    end
                    if v.name == 'The Goad' then
                        local scoring = false
                        for i = 1, #scoring_hand do
                            if scoring_hand[i]:is_suit('Spades', true) then scoring = true end
                        end
                        v.lifts = v.lifts + (scoring and 0 or 1)
                    end
                    if v.name == 'The Head' then
                        local scoring = false
                        for i = 1, #scoring_hand do
                            if scoring_hand[i]:is_suit('Hearts', true) then scoring = true end
                        end
                        v.lifts = v.lifts + (scoring and 0 or 1)
                    end
                    if v.name == 'The Club' then
                        local scoring = false
                        for i = 1, #scoring_hand do
                            if scoring_hand[i]:is_suit('Clubs', true) then scoring = true end
                        end
                        v.lifts = v.lifts + (scoring and 0 or 1)
                    end
                    if v.name == 'The Window' then
                        local scoring = false
                        for i = 1, #scoring_hand do
                            if scoring_hand[i]:is_suit('Diamonds', true) then scoring = true end
                        end
                        v.lifts = v.lifts + (scoring and 0 or 1)
                    end
                    if v.name == 'The Plant' then
                        local scoring = false
                        for i = 1, #scoring_hand do
                            if scoring_hand[i]:is_face(true) then scoring = true end
                        end
                        v.lifts = v.lifts + (scoring and 0 or 1)
                    end
                    if v.name == 'The Pillar' then
                        local scoring = false
                        for i = 1, #scoring_hand do
                            if scoring_hand[i].debuff then scoring = true end
                        end
                        v.lifts = v.lifts + (scoring and 1 or 0)
                    end
                    if (
                        v.name == 'The Goad' or v.name == 'The Head'
                        or v.name == 'The Club' or v.name == 'The Window'
                        or v.name == 'The Plant' or v.name == 'The Pillar'
                    ) and not already_lifted and v.lifts >= v.config.lift then
                        update_debuffs = true
                    end
                    if v.name == 'The Flint' then
                        v.lifts = v.lifts + 1
                    end
                    if v.name == 'The Tooth' then
                        v.lifts = v.lifts + #cards
                    end
                end
            end
            if update_debuffs then
                for _, v in ipairs(G.playing_cards) do
                    self:debuff_card(v)
                end
            end
        end

        return blind_debuff_hand_ref(self, cards, hand, handname, check)
    end

    -- Manage curses
    local blind_press_play_ref = Blind.press_play
    function Blind.press_play(self)

        local highlighted_cards = G.hand.highlighted
        local highlighted_count = math.min(#G.hand.highlighted, G.discard.config.card_limit - #G.play.cards)
        local face_down_cards = 0
        for i = 1, highlighted_count, 1 do
            face_down_cards = face_down_cards + ((highlighted_cards[i].ability.wheel_flipped and 1) or 0)
        end

        if (G.GAME.curses) then
            for k, v in pairs(G.GAME.curses) do
                if v.config.type == 'curse' and (v.lifts < v.config.lift) then
                    if v.name == "The Hook" then
                        G.E_MANAGER:add_event(Event({ func = function()
                            local any_selected = nil
                            local _cards = {}
                            v.triggered = true
                            for kc, vc in ipairs(G.hand.cards) do
                                _cards[#_cards+1] = vc
                            end
                            for i = 1, v.config.extra do
                                if G.hand.cards[i] then 
                                    local selected_card, card_key = pseudorandom_element(_cards, pseudoseed('hook'))
                                    G.hand:add_to_highlighted(selected_card, true)
                                    table.remove(_cards, card_key)
                                    any_selected = true
                                    play_sound('card1', 1)
                                end
                            end
                            if any_selected then G.FUNCS.discard_cards_from_highlighted(nil, true) end
                            v.triggered = false
                            v:juice_up(0.3, 0.2)
                            play_sound('tarot2', 0.76, 0.4)
                        return true end })) 
                        delay(0.7)
                    end
                    if v.name == "The Tooth" then
                        G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.2, func = function()
                        for i = 1, #G.play.cards do
                            if is_curse_triggered(v) then
                                G.E_MANAGER:add_event(Event({func = function() 
                                    G.play.cards[i]:juice_up()
                                    v:juice_up(0.3, 0.2)
                                    return true end })) 
                                ease_dollars(-1)
                                delay(0.23)
                            end
                        end
                        return true end }))
                    end
                    if v.name == 'The Fish' then 
                        v.triggered = true
                    end
                end
                if v.config.type == 'curse' then
                    if v.name == "The Wheel" then
                        v.lifts = v.lifts + ((face_down_cards > 2) and 1 or 0)
                    end
                    if v.name == "The House" then
                        v.lifts = v.lifts + face_down_cards
                    end
                end
            end
        end

        return blind_press_play_ref(self)
    end

    -- Manage curses
    local blind_set_blind_ref = Blind.set_blind
    function Blind.set_blind(self, blind, reset, silent)

        blind_set_blind_ref(self, blind, reset, silent)
        
        if (G.GAME.curses) then
            for k, v in pairs(G.GAME.curses) do
                -- Temp fix! For some reason, the animation of the last curse is removed at specific events. Force it back until the problem is solved. TODO
                if not G.ANIMATIONS[v.curse_sprite] then table.insert(G.ANIMATIONS, v.curse_sprite) end

                if v.config.type == 'curse' and (not reset) and (not silent) and (v.lifts < v.config.lift) then
                    if v.name == "The Wall" then
                        v.triggered = true
                        self.chips = math.floor(self.chips * v.config.extra)
                        self.chip_text = number_format(self.chips)
                        G.E_MANAGER:add_event(Event({
                            trigger = 'after',
                            delay =  0.7,
                            func = (function() 
                                    v:juice_up(0.3, 0.2)
                                    play_sound('tarot2', 0.76, 0.4)
                                return true
                            end)
                        }))
                    end
                    if v.name == "The Water" then
                        v.triggered = true
                        G.E_MANAGER:add_event(Event({
                            trigger = 'after',
                            delay =  0.7,
                            func = (function() 
                                    ease_discard(-v.config.extra)
                                    v:juice_up(0.3, 0.2)
                                    play_sound('tarot2', 0.76, 0.4)
                                return true
                            end)
                        }))
                    end
                    if v.name == "The Needle" and G.GAME.current_round.hands_left > 0 then
                        v.triggered = true
                        G.E_MANAGER:add_event(Event({
                            trigger = 'after',
                            delay =  0.7,
                            func = (function() 
                                    ease_hands_played(-v.config.extra)
                                    v:juice_up(0.3, 0.2)
                                    play_sound('tarot2', 0.76, 0.4)
                                return true
                            end)
                        }))
                    end
                    if v.name == "The Manacle" and not v.triggered then
                        if G.GAME.current_round.hands_left > v.config.extra then
                            v.triggered = true
                            G.E_MANAGER:add_event(Event({
                                trigger = 'after',
                                delay =  0.7,
                                func = (function() 
                                        G.hand:change_size(-1)
                                        v:juice_up(0.3, 0.2)
                                        play_sound('tarot2', 0.76, 0.4)
                                    return true
                                end)
                            }))
                        end
                    end
                    -- if (v.name == 'The Goad' or v.name == 'The Plant' or v.name == 'The Head' or v.name == 'The Club' or v.name == 'The Window' or v.name == 'The Pillar') and not v.triggered then
                    --     v.triggered = true
                    --     G.E_MANAGER:add_event(Event({
                    --         trigger = 'after',
                    --         delay =  0.7,
                    --         func = (function() 
                    --                 v:juice_up(0.3, 0.2)
                    --                 play_sound('tarot2', 0.76, 0.4)
                    --             return true
                    --         end)
                    --     }))
                    -- end
                end

                if v.config.type == 'final_curse' and (not reset) and (not silent) then
                    if v.name == "Violet Vessel" then
                        v.triggered = true
                        self.chips = math.floor(self.chips * (v.config.extra^v.ability.exp))
                        self.chip_text = number_format(self.chips)
                        G.E_MANAGER:add_event(Event({
                            trigger = 'after',
                            delay =  0.7,
                            func = (function() 
                                    v:juice_up(0.3, 0.2)
                                    play_sound('tarot2', 0.76, 0.4)
                                return true
                            end)
                        }))
                    end
                end
            end
        end
    end

    -- Manage curses
    local blind_stay_flipped_ref = Blind.stay_flipped
    function Blind.stay_flipped(self, area, card)
        
        if (G.GAME.curses) then
            for k, v in pairs(G.GAME.curses) do
                if v.config.type == 'curse'and (v.lifts < v.config.lift) then
                    if area == G.hand then
                        if v.name == 'The Wheel' and is_curse_triggered(v) then
                            v:juice_up(0.3, 0.2)
                            play_sound('tarot2', 0.76, 0.4)
                            return true
                        end
                        if v.name == 'The House' and G.GAME.current_round.hands_played == 0 and G.GAME.current_round.discards_used == 0 and area == G.hand and is_curse_triggered(v) then
                            v:juice_up(0.3, 0.2)
                            play_sound('tarot2', 0.76, 0.4)
                            return true
                        end
                        if v.name == 'The Fish' and v.triggered and is_curse_triggered(v) then 
                            v:juice_up(0.3, 0.2)
                            play_sound('tarot2', 0.76, 0.4)
                            return true
                        end
                        if v.name == 'The Mark' and card:is_face(true) and is_curse_triggered(v) then
                            v:juice_up(0.3, 0.2)
                            play_sound('tarot2', 0.76, 0.4)
                            return true
                        end
                    end
                end
            end
        end
        return blind_stay_flipped_ref(self, area, card)
    end

    -- Manage curses
    local blind_modify_hand_ref = Blind.modify_hand
    function Blind.modify_hand(self, cards, poker_hands, text, mult, hand_chips)

        local _mult, _hand_chips, _modded = blind_modify_hand_ref(self, cards, poker_hands, text, mult, hand_chips)
        
        if (G.GAME.curses) then
            for k, v in pairs(G.GAME.curses) do
                if v.config.type == 'curse' and (v.lifts < v.config.lift) then
                    if v.name == "The Flint" then
                        G.E_MANAGER:add_event(Event({
                            trigger = 'after',
                            delay =  0.7,
                            func = (function() 
                                    v:juice_up(0.3, 0.2)
                                    play_sound('tarot2', 0.76, 0.4)
                                return true
                            end)
                        }))
                        _mult = math.max(math.floor(_mult*v.config.extra + 0.5), 1)
                        _hand_chips = math.max(math.floor(_hand_chips*v.config.extra + 0.5), 0)
                        _modded = true
                    end
                end
            end
        end
        return _mult, _hand_chips, _modded
    end

    -- Manage curses resets
    local blind_defeat_ref = Blind.defeat
    function Blind.defeat(self, silent)
        
        for k, v in pairs(G.playing_cards) do
            v.ability.debuff_by_curse_rolls = nil
        end

        blind_defeat_ref(self, silent)
        
        if (G.GAME.curses) then
            for k, v in pairs(G.GAME.curses) do
                if v.config.type == 'curse' then
                    if v.name == "The Manacle" and v.triggered then
                        G.hand:change_size(1)
                    end
                    if v.name == 'The Eye' then
                        local trig_count = 0
                        for kh, vh in pairs(v.ability.hand) do
                            trig_count = trig_count + (vh and 1 or 0)
                        end
                        v.lifts = v.lifts + ((G.GAME.current_round.hands_played <= trig_count) and 1 or 0)
                        v.ability.hand = {
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
                        v.ability.indicate_trig = false
                    end
                    if v.name == 'The Mouth' then
                        v.ability.hand = nil
                        v.lifts = v.lifts + ((G.GAME.current_round.hands_played <= 1) and 1 or 0)
                    end
                    if v.name == 'The Wall' then
                        local overkill = G.GAME.chips - G.GAME.blind.chips
                        v.lifts = v.lifts + ((overkill > (G.GAME.blind.chips / 2)) and 1 or 0)
                    end
                    if v.name == 'The Water' then
                        v.lifts = v.lifts + ((G.GAME.current_round.discards_used == 0) and 1 or 0)
                    end
                    if v.name == 'The Needle' then
                        v.lifts = v.lifts + ((G.GAME.current_round.hands_left == 0) and 1 or 0)
                    end
                    if v.name == 'The Ox' and not v.triggered then
                        v.lifts = v.lifts + 1
                    end
                    v.triggered = false
                end
            end
        end
    end

    ---------- back ----------

    -- Manage curses
    local back_trigger_effect_ref = Back.trigger_effect
    function Back.trigger_effect(self, args)

        if args and args.context == 'final_scoring_step' then
            if (G.GAME.curses) then
                for k, v in pairs(G.GAME.curses) do
                    if v.config.type == 'curse' then
                        if (v.name == 'The Psychic' or v.name == 'The Eye' or v.name == 'The Mouth') and v.triggered then
                            args.mult = math.max(1, math.floor(args.mult * v.config.extra))
                            G.E_MANAGER:add_event(Event({
                                trigger = 'after',
                                delay =  0.7,
                                func = (function() 
                                        v:juice_up(0.3, 0.2)
                                        play_sound('tarot2', 0.76, 0.4)
                                    return true
                                end)
                            }))
                            update_hand_text({delay = 0}, {mult = args.mult, chips = args.chips})
                            v.triggered = false
                            delay(0.7)
                        end
                        if v.name == "The Manacle" and v.triggered then
                            if G.GAME.current_round.hands_left <= v.config.extra then
                                v.triggered = false
                                G.hand:change_size(1)
                            end
                        end
                    end
                end
            end
            -- Check for other effects
            local nu_chip, nu_mult = back_trigger_effect_ref(self, args)
            nu_mult = nu_mult or args.mult
            nu_chip = nu_chip or args.chips
            return nu_chip, nu_mult
        end
        
        return back_trigger_effect_ref(self, args)
    end

end

---------------------------
-------- Setup --------
---------------------------

function setup_curses()
    
    -- Curses
    G.P_CURSES = {
        cu_ox =              {name = 'The Ox',       set = 'Curse', discovered = true, min_ante = nil, order = 1, config = {type = 'curse', extra = 5, lift = 3}, pos = {x = 0,y = 2}},
        cu_hook =            {name = 'The Hook',     set = 'Curse', discovered = true, min_ante = nil, order = 2, config = {type = 'curse', extra = 1, lift = 60}, pos = {x = 0,y = 7}},
        cu_mouth =           {name = 'The Mouth',    set = 'Curse', discovered = true, min_ante = nil, order = 3, config = {type = 'curse', extra = 0.6, lift = 3}, pos = {x = 0,y = 18}},
        cu_fish =            {name = 'The Fish',     set = 'Curse', discovered = true, min_ante = nil, order = 4, config = {type = 'curse', chanceN = 2, chanceD = 5, lift = 25}, pos = {x = 0,y = 5}},
        cu_club =            {name = 'The Club',     set = 'Curse', discovered = true, min_ante = nil, order = 5, config = {type = 'curse', chanceN = 2, chanceD = 5, lift = 12}, pos = {x = 0,y = 4}},
        cu_manacle =         {name = 'The Manacle',  set = 'Curse', discovered = true, min_ante = nil, order = 6, config = {type = 'curse', extra = 1, lift = 7}, pos = {x = 0,y = 8}},
        cu_tooth =           {name = 'The Tooth',    set = 'Curse', discovered = true, min_ante = nil, order = 7, config = {type = 'curse', chanceN = 2, chanceD = 5, lift = 40}, pos = {x = 0,y = 22}},
        cu_wall =            {name = 'The Wall',     set = 'Curse', discovered = true, min_ante = nil, order = 8, config = {type = 'curse', extra = 1.5, lift = 2}, pos = {x = 0,y = 9}},
        cu_house =           {name = 'The House',    set = 'Curse', discovered = true, min_ante = nil, order = 9, config = {type = 'curse', chanceN = 2, chanceD = 3, lift = 15}, pos = {x = 0,y = 3}},
        cu_mark =            {name = 'The Mark',     set = 'Curse', discovered = true, min_ante = nil, order = 10, config = {type = 'curse', chanceN = 1, chanceD = 2, lift = 7}, pos = {x = 0,y = 23}},

        cu_wheel =           {name = 'The Wheel',    set = 'Curse', discovered = true, min_ante = nil, order = 11, config = {type = 'curse', chanceN = 1, chanceD = 8, lift = 5}, pos = {x = 0,y = 10}},
        cu_arm =             {name = 'The Arm',      set = 'Curse', discovered = true, min_ante = nil, order = 12, config = {type = 'curse', chanceN = 1, chanceD = 6, lift = 40}, pos = {x = 0,y = 11}},
        cu_psychic =         {name = 'The Psychic',  set = 'Curse', discovered = true, min_ante = nil, order = 13, config = {type = 'curse', extra = 0.6, lift = 12}, pos = {x = 0,y = 12}},
        cu_goad =            {name = 'The Goad',     set = 'Curse', discovered = true, min_ante = nil, order = 14, config = {type = 'curse', chanceN = 2, chanceD = 5, lift = 12}, pos = {x = 0,y = 13}},
        cu_water =           {name = 'The Water',    set = 'Curse', discovered = true, min_ante = nil, order = 15, config = {type = 'curse', extra = 1, lift = 3}, pos = {x = 0,y = 14}},
        cu_eye =             {name = 'The Eye',      set = 'Curse', discovered = true, min_ante = nil, order = 16, config = {type = 'curse', extra = 0.6, lift = 3}, pos = {x = 0,y = 17}},
        cu_plant =           {name = 'The Plant',    set = 'Curse', discovered = true, min_ante = nil, order = 17, config = {type = 'curse', chanceN = 2, chanceD = 5, lift = 12}, pos = {x = 0,y = 19}},
        cu_needle =          {name = 'The Needle',   set = 'Curse', discovered = true, min_ante = nil, order = 18, config = {type = 'curse', extra = 1, lift = 3}, pos = {x = 0,y = 20}},
        cu_head =            {name = 'The Head',     set = 'Curse', discovered = true, min_ante = nil, order = 19, config = {type = 'curse', chanceN = 2, chanceD = 5, lift = 12}, pos = {x = 0,y = 21}},
        cu_window =          {name = 'The Window',   set = 'Curse', discovered = true, min_ante = nil, order = 20, config = {type = 'curse', chanceN = 2, chanceD = 5, lift = 12}, pos = {x = 0,y = 6}},

        cu_serpent =         {name = 'The Serpent',  set = 'Curse', discovered = true, min_ante = nil, order = 21, config = {type = 'curse', extra = 2, lift = 40}, pos = {x = 0,y = 15}},
        cu_pillar =          {name = 'The Pillar',   set = 'Curse', discovered = true, min_ante = nil, order = 22, config = {type = 'curse', chanceN = 2, chanceD = 5, lift = 9}, pos = {x = 0,y = 16}},
        cu_flint =           {name = 'The Flint',    set = 'Curse', discovered = true, min_ante = nil, order = 23, config = {type = 'curse', extra = 0.75, lift = 20}, pos = {x = 0,y = 24}},
        
        cu_final_vessel =    {name = 'Violet Vessel',set = 'Curse', discovered = true, min_ante = nil, order = 24, config = {type = 'final_curse', extra = 1.5}, pos = {x=0, y=29}},
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
    G.localization.descriptions.Other.liftedCurse = {
        name = "Lifted",
        text = {
            "The {X:black,C:white}Curse{}",
            "was {C:attention}lifted!{}",
            "{C:inactive}(Progress: #2#/#1#){}"
        }
    }
    G.localization.misc.labels['cursed'] = "Cursed Version"
    G.BADGE_COL['cursed'] = G.C.BLACK
    
    -- Manage get_badge_colour
    get_badge_colour(foil)
    G.BADGE_COL['curse'] = G.C.BLACK

    G.localization.misc.labels['curse'] = "Curse"

    override()
end

--Class
Curse = Object:extend()

--Class Methods
function Curse:init(_curse)
    self.key = _curse
    local proto = G.P_CURSES[_curse]
    self.config = copy_table(proto.config)
    self.pos = proto.pos
    self.name = proto.name
    self.tally = G.GAME.curse_tally or 0
    self.triggered = false
    self.lifts = 0
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
        triggered = self.triggered,
        lifts = self.lifts,
        ability = self.ability
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
    self.lifts = curse_savetable.lifts
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
                _self.config.h_popup_config ={align = 'cl', offset = {x=-0.1,y=0}, parent = _self}
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
    elseif name_to_check == 'The Mouth' then loc_vars = {self.config.extra, (self.ability and self.ability.hand and '('..localize(self.ability.hand, 'poker_hands')..')') or ""}
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
    elseif name_to_check == 'The Eye' then loc_vars = {self.config.extra, (self.ability and self.ability.indicate_trig and "(Active)") or "(Inactive)"}
    elseif name_to_check == 'The Plant' then loc_vars = {self.config.chanceN, self.config.chanceD}
    elseif name_to_check == 'The Needle' then loc_vars = {self.config.extra}
    elseif name_to_check == 'The Head' then loc_vars = {self.config.chanceN, self.config.chanceD}
    elseif name_to_check == 'The Window' then loc_vars = {self.config.chanceN, self.config.chanceD}
    elseif name_to_check == 'The Serpent' then loc_vars = {self.config.extra}
    elseif name_to_check == 'The Pillar' then loc_vars = {self.config.chanceN, self.config.chanceD}
    elseif name_to_check == 'The Flint' then loc_vars = {math.floor(100 - self.config.extra * 100)}
    elseif name_to_check == 'Violet Vessel' then loc_vars = {math.floor((self.config.extra^(self.ability.exp or 1)) * 100 - 100), (self.ability.exp or 1)}
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
            new_curse.ability.indicate_trig = false
        end
    end
end

function is_curse_triggered(curse)

    if curse and curse.config and curse.config.chanceN and curse.config.chanceD then
        return pseudorandom(pseudoseed('cu'..curse.name..G.GAME.round_resets.ante)) < (curse.config.chanceN / curse.config.chanceD)
    else
        return false
    end
end

-- Display in collection
local function create_UIBox_your_collection_curses()
  local curse_matrix = {
    {},{},{},{},{},{},
  }
  local curse_tab = {}
  for k, v in pairs(G.P_CURSES) do
    curse_tab[#curse_tab+1] = v
  end

  table.sort(curse_tab, function (a, b) return a.order < b.order end)

  for k, v in ipairs(curse_tab) do
    local temp_curse = Curse(v.key)
    local temp_curse_ui, temp_curse_sprite = temp_curse:generate_UI()
    curse_matrix[math.ceil((k-1)/4+0.001)][1+((k-1)%4)] = {n=G.UIT.C, config={align = "cm", padding = 0.2}, nodes={
      temp_curse_ui,
    }}
  end

  local t = create_UIBox_generic_options({ back_func = 'your_collection', contents = {
    {n=G.UIT.C, config={align = "cm", r = 0.2, colour = G.C.BLACK, padding = 0.2, emboss = 0.05}, nodes={
      {n=G.UIT.C, config={align = "cm"}, nodes={
        {n=G.UIT.R, config={align = "cm"}, nodes={
          {n=G.UIT.R, config={align = "cm"}, nodes=curse_matrix[1]},
          {n=G.UIT.R, config={align = "cm"}, nodes=curse_matrix[2]},
          {n=G.UIT.R, config={align = "cm"}, nodes=curse_matrix[3]},
          {n=G.UIT.R, config={align = "cm"}, nodes=curse_matrix[4]},
          {n=G.UIT.R, config={align = "cm"}, nodes=curse_matrix[5]},
          {n=G.UIT.R, config={align = "cm"}, nodes=curse_matrix[6]},
        }}
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

-- Add Curse display
local create_UIBox_your_collection_ref = create_UIBox_your_collection
function create_UIBox_your_collection()

    -- Get the vanilla UI
    local t = create_UIBox_your_collection_ref()

    -- Insert a new tab
    table.insert(
        t.nodes[1].nodes[1].nodes[1].nodes[2].nodes, 2, 
        UIBox_button({button = 'your_collection_curses', label = {'Curses'}, minw = 5, id = 'your_collection_curses'})
    )

    return t
end