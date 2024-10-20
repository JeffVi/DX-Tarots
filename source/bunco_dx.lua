-- Manage card UI if DX
local generate_card_ui_ref = generate_card_ui
function generate_card_ui(_c, full_UI_table, specific_vars, card_type, badges, hide_desc, main_start, main_end)
    
    local first_pass = not full_UI_table
    local info_queue = {}

    if _c.config and (_c.config.type == '_dx' or _c.config.type == '_cu') and (_c.atlas == 'bunco_tarots_dx' or _c.atlas == 'bunco_planets_dx' or _c.atlas == 'bunco_spectrals_dx' or _c.atlas == 'bunco_tarots_cu') then    -- Overwrite

        -- Just copy-paste for now... TODO
        if first_pass then 
            full_UI_table = {
                main = {},
                info = {},
                type = {},
                name = nil,
                badges = badges or {}
            }
        end
        
        local desc_nodes = (not full_UI_table.name and full_UI_table.main) or full_UI_table.info
        local name_override = nil
        local info_queue = {}

        if full_UI_table.name then
            full_UI_table.info[#full_UI_table.info+1] = {}
            desc_nodes = full_UI_table.info[#full_UI_table.info]
        end

        if not full_UI_table.name then
            if specific_vars and specific_vars.no_name then
                full_UI_table.name = true
            elseif card_type == 'Locked' then
                full_UI_table.name = localize{type = 'name', set = 'Other', key = 'locked', nodes = {}}
            elseif card_type == 'Undiscovered' then 
                full_UI_table.name = localize{type = 'name', set = 'Other', key = 'undiscovered_'..(string.lower(_c.set)), name_nodes = {}}
            elseif specific_vars and (card_type == 'Default' or card_type == 'Enhanced') then
                if (_c.name == 'Stone Card') then full_UI_table.name = true end
                if (specific_vars.playing_card and (_c.name ~= 'Stone Card')) then
                    full_UI_table.name = {}
                    localize{type = 'other', key = 'playing_card', set = 'Other', nodes = full_UI_table.name, vars = {localize(specific_vars.value, 'ranks'), localize(specific_vars.suit, 'suits_plural'), colours = {specific_vars.colour}}}
                    full_UI_table.name = full_UI_table.name[1]
                end
            elseif card_type == 'Booster' then
                
            else
                full_UI_table.name = localize{type = 'name', set = _c.set.._c.config.type, key = _c.key, nodes = full_UI_table.name}
            end
            full_UI_table.card_type = card_type or _c.set
        end 

        local loc_vars = {}
        if main_start then 
            desc_nodes[#desc_nodes+1] = main_start 
        end
        
        if _c.set == 'Tarot' then
            if _c.name == 'The Sky DX' then loc_vars = {_c.config.max_highlighted}
            elseif _c.name == 'The Abyss DX' then loc_vars = {_c.config.max_highlighted}
            elseif _c.name == "The Cursed Sky" then
                local fool_c = G.P_CENTERS["c_bunc_sky_dx"] or nil
                local created_card = fool_c and localize{type = 'name_text', key = fool_c.key, set = fool_c.set..fool_c.config.type} or localize('k_none')
                if fool_c then
                        info_queue[#info_queue+1] = fool_c
                end
                loc_vars = {localize(_c.config.suit_conv, 'suits_plural'), colours = {G.C.SUITS[_c.config.suit_conv]}}
            elseif _c.name == "The Cursed Abyss" then
                local fool_c = G.P_CENTERS["c_bunc_abyss_dx"] or nil
                local created_card = fool_c and localize{type = 'name_text', key = fool_c.key, set = fool_c.set..fool_c.config.type} or localize('k_none')
                if fool_c then
                        info_queue[#info_queue+1] = fool_c
                end
                loc_vars = {localize(_c.config.suit_conv, 'suits_plural'), colours = {G.C.SUITS[_c.config.suit_conv]}}
            end
            localize{type = 'descriptions', key = _c.key, set = _c.set.._c.config.type, nodes = desc_nodes, vars = loc_vars}
        elseif _c.set == 'Planet' then
            loc_vars = {
                G.GAME.hands[_c.config.hand_type].level,localize(_c.config.hand_type, 'poker_hands'), G.GAME.hands[_c.config.hand_type].l_mult * 2, G.GAME.hands[_c.config.hand_type].l_chips * 2,
                colours = {(G.GAME.hands[_c.config.hand_type].level==1 and G.C.UI.TEXT_DARK or G.C.HAND_LEVELS[math.min(7, G.GAME.hands[_c.config.hand_type].level)])}
            }
            localize{type = 'descriptions', key = _c.key, set = _c.set.._c.config.type, nodes = desc_nodes, vars = loc_vars}
        elseif _c.set == 'Spectral' then
            if _c.name == 'Cleanse DX' then info_queue[#info_queue+1] = G.P_CENTERS.e_bunc_fluorescent end
            localize{type = 'descriptions', key = _c.key, set = _c.set.._c.config.type, nodes = desc_nodes, vars = loc_vars}
        end
        

        if main_end then 
            desc_nodes[#desc_nodes+1] = main_end 
        end

        --Fill all remaining info if this is the main desc
        if not ((specific_vars and not specific_vars.sticker) and (card_type == 'Default' or card_type == 'Enhanced')) then
            if desc_nodes == full_UI_table.main and not full_UI_table.name then
                localize{type = 'name', key = _c.key, set = _c.set.._c.config.type, nodes = full_UI_table.name} 
                if not full_UI_table.name then full_UI_table.name = {} end
            elseif desc_nodes ~= full_UI_table.main then 
                desc_nodes.name = localize{type = 'name_text', key = name_override or _c.key, set = name_override and 'Other' or _c.set.._c.config.type} 
            end
        end

        if first_pass and not (_c.set == 'Edition') and badges then
            for k, v in ipairs(badges) do
                if v == 'foil' then info_queue[#info_queue+1] = G.P_CENTERS['e_foil'] end
                if v == 'holographic' then info_queue[#info_queue+1] = G.P_CENTERS['e_holo'] end
                if v == 'polychrome' then info_queue[#info_queue+1] = G.P_CENTERS['e_polychrome'] end
                if v == 'negative' then info_queue[#info_queue+1] = G.P_CENTERS['e_negative'] end
                if v == 'bunc_glitter' then info_queue[#info_queue+1] = G.P_CENTERS['e_bunc_glitter'] end
                if v == 'bunc_fluorescent' then info_queue[#info_queue+1] = G.P_CENTERS['e_bunc_fluorescent'] end
                if v == 'negative_consumable' then info_queue[#info_queue+1] = {key = 'e_negative_consumable', set = 'Edition', config = {extra = 1}} end
                if v == 'gold_seal' then info_queue[#info_queue+1] = {key = 'gold_seal', set = 'Other'} end
                if v == 'blue_seal' then info_queue[#info_queue+1] = {key = 'blue_seal', set = 'Other'} end
                if v == 'red_seal' then info_queue[#info_queue+1] = {key = 'red_seal', set = 'Other'} end
                if v == 'purple_seal' then info_queue[#info_queue+1] = {key = 'purple_seal', set = 'Other'} end
                if v == 'eternal' then info_queue[#info_queue+1] = {key = 'eternal', set = 'Other'} end
                if v == 'pinned_left' then info_queue[#info_queue+1] = {key = 'pinned_left', set = 'Other'} end
            end
        end

        for _, v in ipairs(info_queue) do
            generate_card_ui(v, full_UI_table)
        end
    
        return full_UI_table

    else    -- Do not overwrite
        return generate_card_ui_ref(_c, full_UI_table, specific_vars, card_type, badges, hide_desc, main_start, main_end)
    end
end

-- override

local card_use_consumeable_ref = Card.use_consumeable
function Card.use_consumeable(self, area, copier)

    if self.ability.type == '_dx' and self.config.center and (self.config.center.atlas == 'bunco_tarots_dx' or self.config.center.atlas == 'bunco_planets_dx' or self.config.center.atlas == 'bunco_spectrals_dx') then  -- Manage DX
        stop_use()
        if not copier then set_consumeable_usage(self) end
        if self.debuff then return nil end
        local used_tarot = copier or self
            
        if used_tarot.edition then
            if used_tarot.edition.foil then
                add_tag(Tag('tag_bunc_chips'))
                play_sound('generic1')
            elseif used_tarot.edition.holo then
                add_tag(Tag('tag_bunc_mult'))
                play_sound('generic1')
            elseif used_tarot.edition.polychrome then
                add_tag(Tag('tag_bunc_xmult'))
                play_sound('generic1')
            elseif used_tarot.edition.bunc_glitter then
                add_tag(Tag('tag_bunc_xchips'))
                play_sound('generic1')
            end
        end

        if self.ability.consumeable.max_highlighted then
            update_hand_text({immediate = true, nopulse = true, delay = 0}, {mult = 0, chips = 0, level = '', handname = ''})
        end
        
        if self.ability.consumeable.mod_conv or self.ability.consumeable.suit_conv then
            enable_exotics()
            G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
                play_sound('tarot1')
                used_tarot:juice_up(0.3, 0.5)
                return true end }))
            for i=1, #G.hand.highlighted do
                local percent = 1.15 - (i-0.999)/(#G.hand.highlighted-0.998)*0.3
                G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() G.hand.highlighted[i]:flip();play_sound('card1', percent);G.hand.highlighted[i]:juice_up(0.3, 0.3);return true end }))
            end
            delay(0.2)
            if self.ability.consumeable.suit_conv then
                for i=1, #G.hand.highlighted do
                    G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.1,func = function() G.hand.highlighted[i]:change_suit(self.ability.consumeable.suit_conv);return true end }))
                end
            end

            for i=1, #G.hand.highlighted do
                local percent = 0.85 + (i-0.999)/(#G.hand.highlighted-0.998)*0.3
                G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() G.hand.highlighted[i]:flip();play_sound('tarot2', percent, 0.6);G.hand.highlighted[i]:juice_up(0.3, 0.3);return true end }))
            end
            G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.2,func = function() G.hand:unhighlight_all(); return true end }))
            delay(0.5)
        end
        if self.ability.consumeable.hand_type then
            update_hand_text({sound = 'button', volume = 0.7, pitch = 0.8, delay = 0.3}, {handname=localize(self.ability.consumeable.hand_type, 'poker_hands'),chips = G.GAME.hands[self.ability.consumeable.hand_type].chips, mult = G.GAME.hands[self.ability.consumeable.hand_type].mult, level=G.GAME.hands[self.ability.consumeable.hand_type].level})
            level_up_hand(used_tarot, self.ability.consumeable.hand_type)
            update_hand_text({sound = 'button', volume = 0.7, pitch = 1.1, delay = 0}, {mult = 0, chips = 0, handname = '', level = ''})
        end
        if self.ability.name == 'Cleanse DX' then
            local edition = {bunc_fluorescent = true}
            for i = 1, #G.hand.cards do
                G.E_MANAGER:add_event(Event({func = function()
                    local _card = G.hand.cards[i]
                    if not _card.edition then 
                        _card:set_edition(edition, true)
                    end
                return true end }))
            end
            self:juice_up(0.3, 0.5)
        end
    elseif self.ability.type == '_cu' and self.config.center and self.config.center.atlas == 'bunco_tarots_cu' then      -- Manage curses
        stop_use()
        if not copier then set_consumeable_usage(self) end
        if self.debuff then return nil end
        local used_tarot = copier or self
        
        if SMODS.Mods and SMODS.Mods['Bunco'] and used_tarot.edition then
            if used_tarot.edition.foil then
                add_tag(Tag('tag_bunc_chips'))
                play_sound('generic1')
            elseif used_tarot.edition.holo then
                add_tag(Tag('tag_bunc_mult'))
                play_sound('generic1')
            elseif used_tarot.edition.polychrome then
                add_tag(Tag('tag_bunc_xmult'))
                play_sound('generic1')
            elseif used_tarot.edition.bunc_glitter then
                add_tag(Tag('tag_bunc_xchips'))
                play_sound('generic1')
            end
        end

        if self.ability.name == 'The Cursed Sky' then
            G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
                if G.consumeables.config.card_limit > #G.consumeables.cards then
                    play_sound('timpani')
                    if G.consumeables.config.card_limit > #G.consumeables.cards then 
                        local card = create_card('Tarot_dx', G.consumeables, nil, nil, nil, nil, 'c_bunc_sky_dx', 'sky')
                        card:add_to_deck()
                        G.consumeables:emplace(card)
                    end
                    used_tarot:juice_up(0.3, 0.5)
                end
            return true end }))
        end

        if self.ability.name == 'The Cursed Abyss' then
            G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
                if G.consumeables.config.card_limit > #G.consumeables.cards then
                    play_sound('timpani')
                    if G.consumeables.config.card_limit > #G.consumeables.cards then 
                        local card = create_card('Tarot_dx', G.consumeables, nil, nil, nil, nil, 'c_bunc_abyss_dx', 'abyss')
                        card:add_to_deck()
                        G.consumeables:emplace(card)
                    end
                    used_tarot:juice_up(0.3, 0.5)
                end
            return true end }))
        end

        G.GAME.used_cu_augments[self.config.center_key] = (G.GAME.used_cu_augments[self.config.center_key] or 0) + 1
    else -- Call vanilla
        card_use_consumeable_ref(self, area, copier)
    end
end

local card_can_use_consumeable_ref = Card.can_use_consumeable
function Card.can_use_consumeable(self, any_state, skip_check)

    if (self.ability.type == '_dx' or self.ability.type == '_cu') and (self.config.center and (self.config.center.atlas == 'bunco_tarots_dx' or self.config.center.atlas == 'bunco_tarots_cu' or self.config.center.atlas == 'bunco_planets_dx' or self.config.center.atlas == 'bunco_spectrals_dx')) then

        if not skip_check and ((G.play and #G.play.cards > 0) or
            (G.CONTROLLER.locked) or
            (G.GAME.STOP_USE and G.GAME.STOP_USE > 0))
            then  return false end

        if G.STATE ~= G.STATES.HAND_PLAYED and G.STATE ~= G.STATES.DRAW_TO_HAND and G.STATE ~= G.STATES.PLAY_TAROT or any_state then

            if self.ability.name == 'The Cursed Sky' or self.ability.name == 'The Cursed Abyss' then
                return true
            end
            if self.ability.consumeable.hand_type then
                return true
            end
            if G.STATE == G.STATES.SELECTING_HAND or G.STATE == G.STATES.TAROT_PACK or G.STATE == G.STATES.SPECTRAL_PACK or G.STATE == G.STATES.PLANET_PACK then
                if self.ability.consumeable.max_highlighted then
                    if self.ability.consumeable.mod_num >= #G.hand.highlighted and #G.hand.highlighted >= (self.ability.consumeable.min_highlighted or 1) then
                        return true
                    end
                end
                if self.ability.name == 'Cleanse DX' then
                    return true
                end
            end
        end
        return false

    else -- Call vanilla
        return card_can_use_consumeable_ref(self, any_state, skip_check)
    end
end

function load_bunco_dx_cu_consumables()

    G.localization.descriptions.Tarot_dx.c_bunc_sky_dx = {
        name = "The Sky DX",
        text = {
            "Converts up to",
            "{C:attention}#1#{} selected cards",
            "to {C:bunc_fleurons}Fleurons{}"
        }
    }
    G.localization.descriptions.Tarot_dx.c_bunc_abyss_dx = {
        name = "The Abyss DX",
        text = {
            "Converts up to",
            "{C:attention}#1#{} selected cards",
            "to {C:bunc_halberds}Halberds{}"
        }
    }
    
    G.localization.descriptions.Tarot_cu.c_bunc_sky_cu = {
        name = "The Cursed Sky",
        text = {
            "{V:1}#1#{} cannot",
            "get {C:attention}debuffed{}. Creates a",
            "copy of {C:tarot}The Sky{} {C:dark_edition}DX{}",
            "{C:inactive}(Must have room)"
        }
    }
    G.localization.descriptions.Tarot_cu.c_bunc_abyss_cu = {
        name = "The Cursed Abyss",
        text = {
            "{V:1}#1#{} cannot",
            "get {C:attention}debuffed{}. Creates a",
            "copy of {C:tarot}The Abyss{} {C:dark_edition}DX{}",
            "{C:inactive}(Must have room)"
        }
    }
    

    G.localization.descriptions.Planet_dx.c_bunc_Quaoar_dx = {
        name = "Quaoar DX",
        text = {
            "{s:0.8}({s:0.8,V:1}lvl.#1#{s:0.8}){} Level up {C:dark_edition}x2{}",
            "{C:attention}#2#",
            "{C:mult}+#3#{} Mult and",
            "{C:chips}+#4#{} chips"
        }
    }
    G.localization.descriptions.Planet_dx.c_bunc_Haumea_dx = {
        name = "Haumea DX",
        text = {
            "{s:0.8}({s:0.8,V:1}lvl.#1#{s:0.8}){} Level up {C:dark_edition}x2{}",
            "{C:attention}#2#",
            "{C:mult}+#3#{} Mult and",
            "{C:chips}+#4#{} chips"
        }
    }
    G.localization.descriptions.Planet_dx.c_bunc_Sedna_dx = {
        name = "Sedna DX",
        text = {
            "{s:0.8}({s:0.8,V:1}lvl.#1#{s:0.8}){} Level up {C:dark_edition}x2{}",
            "{C:attention}#2#",
            "{C:mult}+#3#{} Mult and",
            "{C:chips}+#4#{} chips"
        }
    }
    G.localization.descriptions.Planet_dx.c_bunc_Makemake_dx = {
        name = "Makemake DX",
        text = {
            "{s:0.8}({s:0.8,V:1}lvl.#1#{s:0.8}){} Level up {C:dark_edition}x2{}",
            "{C:attention}#2#",
            "{C:mult}+#3#{} Mult and",
            "{C:chips}+#4#{} chips"
        }
    }
    
    G.localization.descriptions.Spectral_dx.c_bunc_cleanse_dx = {
        name = "Cleanse DX",
        text = {
            "Add {C:dark_edition}Fluorescent{} to",
            "{C:attention}all{} cards in hand",
            "{C:inactive}(If they have no edition)"
        }
    }


    -- DX
    G.P_CENTERS.c_bunc_sky_dx =         {order = 23,    discovered = true, cost = 5, consumeable = true, name = "The Sky DX", pos = {x=0,y=0}, set = "Tarot", effect = "Suit Conversion", cost_mult = 1.0, config = {type = '_dx', max_highlighted = 5, suit_conv = 'bunc_Fleurons'}, atlas = 'bunco_tarots_dx'}
    G.P_CENTERS.c_bunc_abyss_dx =       {order = 24,    discovered = true, cost = 5, consumeable = true, name = "The Abyss DX", pos = {x=1,y=0}, set = "Tarot", effect = "Suit Conversion", cost_mult = 1.0, config = {type = '_dx', max_highlighted = 5, suit_conv = 'bunc_Halberds'}, atlas = 'bunco_tarots_dx'}

    G.P_CENTERS.c_bunc_sky_cu =         {order = 24,    discovered = true, cost = 5, consumeable = true, name = "The Cursed Sky", pos = {x=0,y=0}, set = "Tarot", effect = "Suit Conversion", cost_mult = 1.0, config = {type = '_cu', suit_conv = 'bunc_Fleurons', unique = true, nb_curse = 2}, atlas = 'bunco_tarots_cu'}
    G.P_CENTERS.c_bunc_abyss_cu =       {order = 25,    discovered = true, cost = 5, consumeable = true, name = "The Cursed Abyss", pos = {x=1,y=0}, set = "Tarot", effect = "Suit Conversion", cost_mult = 1.0, config = {type = '_cu', suit_conv = 'bunc_Halberds', unique = true, nb_curse = 2}, atlas = 'bunco_tarots_cu'}


    G.P_CENTERS.c_bunc_Quaoar_dx =      {order = 13,    discovered = true, cost = 5, consumeable = true, freq = 1, name = "Quaoar DX", pos = {x=0,y=0}, set = "Planet", effect = "Hand Upgrade", cost_mult = 1.0, config = {type = '_dx', hand_type = 'h_bunc_Spectrum', softlock = true}, atlas = 'bunco_planets_dx'}
    G.P_CENTERS.c_bunc_Haumea_dx =      {order = 14,    discovered = true, cost = 5, consumeable = true, freq = 1, name = "Haumea DX", pos = {x=1,y=0}, set = "Planet", effect = "Hand Upgrade", cost_mult = 1.0, config = {type = '_dx', hand_type = 'h_bunc_Straight Spectrum', softlock = true}, atlas = 'bunco_planets_dx'}
    G.P_CENTERS.c_bunc_Sedna_dx =       {order = 15,    discovered = true, cost = 5, consumeable = true, freq = 1, name = "Sedna DX", pos = {x=2,y=0}, set = "Planet", effect = "Hand Upgrade", cost_mult = 1.0, config = {type = '_dx', hand_type = 'h_bunc_Spectrum House', softlock = true}, atlas = 'bunco_planets_dx'}
    G.P_CENTERS.c_bunc_Makemake_dx =    {order = 16,    discovered = true, cost = 5, consumeable = true, freq = 1, name = "Makemake DX", pos = {x=3,y=0}, set = "Planet", effect = "Hand Upgrade", cost_mult = 1.0, config = {type = '_dx', hand_type = 'h_bunc_Spectrum Five', softlock = true}, atlas = 'bunco_planets_dx'}

    G.P_CENTERS.c_bunc_cleanse_dx =     {order = 20,    discovered = true, cost = 6, consumeable = true, name = "Cleanse DX", pos = {x=0,y=0}, set = "Spectral", config = {type = '_dx', unique = true}, atlas = 'bunco_spectrals_dx'}

    -- Update tables
    G.P_CENTER_POOLS.Tarot_dx = {}
    G.P_CENTER_POOLS.Tarot_cu = {}
    G.P_CENTER_POOLS.Planet_dx = {}
    G.P_CENTER_POOLS.Spectral_dx = {}
    G.P_CENTER_POOLS.Booster_dx = {}

    for k, v in pairs(G.P_CENTERS) do
        v.key = k
        if not v.wip then 
            if v.set == 'Tarot' or v.set == 'Planet' or v.set == 'Spectral' or v.set == 'Booster' then
                if v.config and (v.config.type ==  '_dx' or v.config.type ==  '_cu') then
                    table.insert(G.P_CENTER_POOLS[v.set..v.config.type], v)
                end
            end
        end
    end
    
    table.sort(G.P_CENTER_POOLS["Tarot_dx"], function (a, b) return a.order < b.order end)
    table.sort(G.P_CENTER_POOLS["Tarot_cu"], function (a, b) return a.order < b.order end)
    table.sort(G.P_CENTER_POOLS["Planet_dx"], function (a, b) return a.order < b.order end)
    table.sort(G.P_CENTER_POOLS["Spectral_dx"], function (a, b) return a.order < b.order end)
    table.sort(G.P_CENTER_POOLS["Booster_dx"], function (a, b) return a.order < b.order end)
end

function LoadBuncoDX()
    sendDebugMessage("Bunco DX Loaded")
    
    local js_mod = SMODS.findModByID("JeffDeluxeConsumablesPack")
    SMODS.Atlas({key = 'bunco_tarots_dx', path = 'Bunco_Tarots_dx.png', px = 71, py = 95})
    SMODS.Atlas({key = 'bunco_planets_dx', path = 'Bunco_Planets_dx.png', px = 71, py = 95})
    SMODS.Atlas({key = 'bunco_spectrals_dx', path = 'Bunco_Spectrals_dx.png', px = 71, py = 95})
    SMODS.Atlas({key = 'bunco_tarots_cu', path = 'Bunco_Tarots_cu.png', px = 71, py = 95})
    
    G.localization.misc.labels['sky_bu'] = "Fleurons Buff"
    G.localization.misc.labels['abyss_bu'] = "Halberds Buff"
    G.BADGE_COL['sky_bu'] = HEX('d6901a')
    G.BADGE_COL['abyss_bu'] = HEX('6e3c63')

    load_bunco_dx_cu_consumables()
end