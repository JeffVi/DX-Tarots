local js_mod = SMODS.current_mod
local js_config = assert(NFS.load(js_mod.path..'config.lua')())--js_mod.config

local bunco = SMODS.Mods['Bunco']

----------
--TAROTS--
----------

-- The Sky DX
SMODS.ConsumableDX{
	set = 'Tarot', atlas = 'bunco_tarots_dx', key = 'c_bunc_sky_dx',
	loc_txt = {
        name = "The Sky DX",
        text = {
            "Converts up to",
            "{C:attention}#1#{} selected cards",
            "to {V:1}#2#{}"
        }
    },
    pos = {x=0,y=0},
    config = {suit_conv = 'bunc_Fleurons', max_highlighted = 5},

    set_card_type_badge = function(self, card, badges)
        badges[1] = create_badge('Tarot?', get_type_colour(self or card.config, card), nil, 1.2)
        SMODS.ConsumableDX.set_card_type_badge(self, card, badges)
    end,

    loc_vars = function(self, info_queue, center)
        SMODS.ConsumableDX.loc_vars(self, info_queue, center)
        return {vars = {self.config.max_highlighted, localize(self.config.suit_conv, 'suits_plural'), colours = {G.C.SUITS[self.config.suit_conv]}}}
    end,

    use = function(self)
        enable_exotics()

        for i=1, #G.hand.highlighted do
            local percent = 1.15 - (i-0.999)/(#G.hand.highlighted-0.998)*0.3
            G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.15, func = function()
                G.hand.highlighted[i]:flip();play_sound('card1', percent);G.hand.highlighted[i]:juice_up(0.3, 0.3);
            return true end }))
        end
        delay(0.2)
        for i=1, #G.hand.highlighted do
            G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.1, func = function()
                G.hand.highlighted[i]:change_suit(self.config.suit_conv);
            return true end }))
        end
        for i=1, #G.hand.highlighted do
            local percent = 0.85 + ( i - 0.999 ) / ( #G.hand.highlighted - 0.998 ) * 0.3
            G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.15, func = function()
                G.hand.highlighted[i]:flip(); play_sound('tarot2', percent, 0.6); G.hand.highlighted[i]:juice_up(0.3, 0.3);
            return true end }))
        end
        G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.2, func = function()
            G.hand:unhighlight_all();
        return true end }))
        delay(0.5)
    end,

    in_pool = function()
        return G.GAME and G.GAME.Exotic
    end,
}

-- The Abyss DX
SMODS.ConsumableDX{
	set = 'Tarot', atlas = 'bunco_tarots_dx', key = 'c_bunc_abyss_dx',
	loc_txt = {
        name = "The Abyss DX",
        text = {
            "Converts up to",
            "{C:attention}#1#{} selected cards",
            "to {V:1}#2#{}"
        }
    },
    pos = {x=1,y=0},
    config = {suit_conv = 'bunc_Halberds', max_highlighted = 5},

    set_card_type_badge = function(self, card, badges)
        badges[1] = create_badge('Tarot?', get_type_colour(self or card.config, card), nil, 1.2)
        SMODS.ConsumableDX.set_card_type_badge(self, card, badges)
    end,

    loc_vars = function(self, info_queue, center)
        SMODS.ConsumableDX.loc_vars(self, info_queue, center)
        return {vars = {self.config.max_highlighted, localize(self.config.suit_conv, 'suits_plural'), colours = {G.C.SUITS[self.config.suit_conv]}}}
    end,

    use = function(self)
        enable_exotics()

        for i=1, #G.hand.highlighted do
            local percent = 1.15 - (i-0.999)/(#G.hand.highlighted-0.998)*0.3
            G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.15, func = function()
                G.hand.highlighted[i]:flip();play_sound('card1', percent);G.hand.highlighted[i]:juice_up(0.3, 0.3);
            return true end }))
        end
        delay(0.2)
        for i=1, #G.hand.highlighted do
            G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.1, func = function()
                G.hand.highlighted[i]:change_suit(self.config.suit_conv);
            return true end }))
        end
        for i=1, #G.hand.highlighted do
            local percent = 0.85 + ( i - 0.999 ) / ( #G.hand.highlighted - 0.998 ) * 0.3
            G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.15, func = function()
                G.hand.highlighted[i]:flip(); play_sound('tarot2', percent, 0.6); G.hand.highlighted[i]:juice_up(0.3, 0.3);
            return true end }))
        end
        G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.2, func = function()
            G.hand:unhighlight_all();
        return true end }))
        delay(0.5)
    end,

    in_pool = function()
        return G.GAME and G.GAME.Exotic
    end,
}

-- The Cursed Sky
SMODS.ConsumableCU{
	set = 'Tarot', atlas = 'bunco_tarots_cu', key = 'c_bunc_sky_cu',
	loc_txt = {
        name = "The Cursed Sky",
        text = {
            "{V:1}#1#{} cannot",
            "get {C:attention}debuffed{}. Creates a",
            "copy of {C:tarot}The Sky{} {C:dark_edition}DX{}",
            "{C:inactive}(Must have room)"
        }
    },
    pos = {x=0,y=0},
    nb_curse = 2,
    config = {suit_conv = 'bunc_Fleurons'},
    unique = true,

    set_card_type_badge = function(self, card, badges)
        badges[1] = create_badge('Tarot?', get_type_colour(self or card.config, card), nil, 1.2)
        SMODS.ConsumableCU.set_card_type_badge(self, card, badges)
    end,

    loc_vars = function(self, info_queue, center)
        SMODS.ConsumableCU.loc_vars(self, info_queue, center)
        local fool_c = G.P_CENTERS["c_bunc_sky_dx"] or nil
        local created_card = fool_c and localize{type = 'name_text', key = fool_c.key, set = fool_c.set..fool_c.extra_type} or localize('k_none')
        if fool_c then
            info_queue[#info_queue+1] = fool_c
        end
        return {vars = {localize(self.config.suit_conv, 'suits_plural'), colours = {G.C.SUITS[self.config.suit_conv]}, created_card}}
    end,

    use = function(self, card, area, copier)
        local used_tarot = copier or card
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
    end,

    can_use = function(self)
        return true
    end,

    in_pool = function()
        return G.GAME and G.GAME.Exotic
    end,
}

-- The Cursed Abyss
SMODS.ConsumableCU{
	set = 'Tarot', atlas = 'bunco_tarots_cu', key = 'c_bunc_abyss_cu',
	loc_txt = {
        name = "The Cursed Sky",
        text = {
            "{V:1}#1#{} cannot",
            "get {C:attention}debuffed{}. Creates a",
            "copy of {C:tarot}The Abyss{} {C:dark_edition}DX{}",
            "{C:inactive}(Must have room)"
        }
    },
    pos = {x=1,y=0},
    nb_curse = 2,
    config = {suit_conv = 'bunc_Halberds'},
    unique = true,

    set_card_type_badge = function(self, card, badges)
        badges[1] = create_badge('Tarot?', get_type_colour(self or card.config, card), nil, 1.2)
        SMODS.ConsumableCU.set_card_type_badge(self, card, badges)
    end,

    loc_vars = function(self, info_queue, center)
        SMODS.ConsumableCU.loc_vars(self, info_queue, center)
        local fool_c = G.P_CENTERS["c_bunc_abyss_dx"] or nil
        local created_card = fool_c and localize{type = 'name_text', key = fool_c.key, set = fool_c.set..fool_c.extra_type} or localize('k_none')
        if fool_c then
            info_queue[#info_queue+1] = fool_c
        end
        return {vars = {localize(self.config.suit_conv, 'suits_plural'), colours = {G.C.SUITS[self.config.suit_conv]}, created_card}}
    end,

    use = function(self, card, area, copier)
        local used_tarot = copier or card
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
    end,

    can_use = function(self)
        return true
    end,

    in_pool = function()
        return G.GAME and G.GAME.Exotic
    end,
}

-----------
--PLANETS--
-----------

-- Quaoar DX
SMODS.ConsumableDX{
	set = 'Planet', atlas = 'bunco_planets_dx', key = 'c_bunc_Quaoar_dx',
	loc_txt = {
        name = "Quaoar DX",
        text = {
            "{s:0.8}({s:0.8,V:1}lvl.#1#{s:0.8}){} Level up {C:dark_edition}x2{}",
            "{C:attention}#2#",
            "{C:mult}+#3#{} Mult and",
            "{C:chips}+#4#{} chips"
        }
    },
    pos = {x=0,y=0},
    config = {hand_type = 'bunc_Spectrum', softlock = true},

    loc_vars = function(self, info_queue, center)
        SMODS.ConsumableDX.loc_vars(self, info_queue, center)
        local loc_vars = {
            G.GAME.hands[self.config.hand_type].level, localize(self.config.hand_type, 'poker_hands'), G.GAME.hands[self.config.hand_type].l_mult * 2, G.GAME.hands[self.config.hand_type].l_chips * 2,
            colours = {(G.GAME.hands[self.config.hand_type].level==1 and G.C.UI.TEXT_DARK or G.C.HAND_LEVELS[math.min(7, G.GAME.hands[self.config.hand_type].level)])}
        }
        return {vars = loc_vars}
    end,

    set_card_type_badge = function(self, card, badges)
        badges[1] = create_badge(bunco.config.fixed_badges and localize('k_planet_q') or localize('k_dwarf_planet'), get_type_colour(self or card.config, card), nil, 1.2)
        SMODS.ConsumableDX.set_card_type_badge(self, card, badges)
    end,

    use = function(self, card, area, copier)
        local used_tarot = copier or card
        update_hand_text({sound = 'button', volume = 0.7, pitch = 0.8, delay = 0.3}, {handname=localize(self.config.hand_type, 'poker_hands'),chips = G.GAME.hands[self.config.hand_type].chips, mult = G.GAME.hands[self.config.hand_type].mult, level=G.GAME.hands[self.config.hand_type].level})
        level_up_hand(used_tarot, self.config.hand_type, false, 2)
        update_hand_text({sound = 'button', volume = 0.7, pitch = 1.1, delay = 0}, {mult = 0, chips = 0, handname = '', level = ''})
    end,
}

-- Haumea DX
SMODS.ConsumableDX{
	set = 'Planet', atlas = 'bunco_planets_dx', key = 'c_bunc_Haumea_dx',
	loc_txt = {
        name = "Haumea DX",
        text = {
            "{s:0.8}({s:0.8,V:1}lvl.#1#{s:0.8}){} Level up {C:dark_edition}x2{}",
            "{C:attention}#2#",
            "{C:mult}+#3#{} Mult and",
            "{C:chips}+#4#{} chips"
        }
    },
    pos = {x=1,y=0},
    config = {hand_type = 'bunc_Straight Spectrum', softlock = true},

    loc_vars = function(self, info_queue, center)
        SMODS.ConsumableDX.loc_vars(self, info_queue, center)
        local loc_vars = {
            G.GAME.hands[self.config.hand_type].level, localize(self.config.hand_type, 'poker_hands'), G.GAME.hands[self.config.hand_type].l_mult * 2, G.GAME.hands[self.config.hand_type].l_chips * 2,
            colours = {(G.GAME.hands[self.config.hand_type].level==1 and G.C.UI.TEXT_DARK or G.C.HAND_LEVELS[math.min(7, G.GAME.hands[self.config.hand_type].level)])}
        }
        return {vars = loc_vars}
    end,

    set_card_type_badge = function(self, card, badges)
        badges[1] = create_badge(bunco.config.fixed_badges and localize('k_planet_q') or localize('k_dwarf_planet'), get_type_colour(self or card.config, card), nil, 1.2)
        SMODS.ConsumableDX.set_card_type_badge(self, card, badges)
    end,

    use = function(self, card, area, copier)
        local used_tarot = copier or card
        update_hand_text({sound = 'button', volume = 0.7, pitch = 0.8, delay = 0.3}, {handname=localize(self.config.hand_type, 'poker_hands'),chips = G.GAME.hands[self.config.hand_type].chips, mult = G.GAME.hands[self.config.hand_type].mult, level=G.GAME.hands[self.config.hand_type].level})
        level_up_hand(used_tarot, self.config.hand_type, false, 2)
        update_hand_text({sound = 'button', volume = 0.7, pitch = 1.1, delay = 0}, {mult = 0, chips = 0, handname = '', level = ''})
    end,
}

-- Sedna DX
SMODS.ConsumableDX{
	set = 'Planet', atlas = 'bunco_planets_dx', key = 'c_bunc_Sedna_dx',
	loc_txt = {
        name = "Sedna DX",
        text = {
            "{s:0.8}({s:0.8,V:1}lvl.#1#{s:0.8}){} Level up {C:dark_edition}x2{}",
            "{C:attention}#2#",
            "{C:mult}+#3#{} Mult and",
            "{C:chips}+#4#{} chips"
        }
    },
    pos = {x=2,y=0},
    config = {hand_type = 'bunc_Spectrum House', softlock = true},

    loc_vars = function(self, info_queue, center)
        SMODS.ConsumableDX.loc_vars(self, info_queue, center)
        local loc_vars = {
            G.GAME.hands[self.config.hand_type].level, localize(self.config.hand_type, 'poker_hands'), G.GAME.hands[self.config.hand_type].l_mult * 2, G.GAME.hands[self.config.hand_type].l_chips * 2,
            colours = {(G.GAME.hands[self.config.hand_type].level==1 and G.C.UI.TEXT_DARK or G.C.HAND_LEVELS[math.min(7, G.GAME.hands[self.config.hand_type].level)])}
        }
        return {vars = loc_vars}
    end,

    set_card_type_badge = function(self, card, badges)
        badges[1] = create_badge(bunco.config.fixed_badges and localize('k_planet_q') or localize('k_dwarf_planet'), get_type_colour(self or card.config, card), nil, 1.2)
        SMODS.ConsumableDX.set_card_type_badge(self, card, badges)
    end,

    use = function(self, card, area, copier)
        local used_tarot = copier or card
        update_hand_text({sound = 'button', volume = 0.7, pitch = 0.8, delay = 0.3}, {handname=localize(self.config.hand_type, 'poker_hands'),chips = G.GAME.hands[self.config.hand_type].chips, mult = G.GAME.hands[self.config.hand_type].mult, level=G.GAME.hands[self.config.hand_type].level})
        level_up_hand(used_tarot, self.config.hand_type, false, 2)
        update_hand_text({sound = 'button', volume = 0.7, pitch = 1.1, delay = 0}, {mult = 0, chips = 0, handname = '', level = ''})
    end,
}

-- Makemake DX
SMODS.ConsumableDX{
	set = 'Planet', atlas = 'bunco_planets_dx', key = 'c_bunc_Makemake_dx',
	loc_txt = {
        name = "Makemake DX",
        text = {
            "{s:0.8}({s:0.8,V:1}lvl.#1#{s:0.8}){} Level up {C:dark_edition}x2{}",
            "{C:attention}#2#",
            "{C:mult}+#3#{} Mult and",
            "{C:chips}+#4#{} chips"
        }
    },
    pos = {x=3,y=0},
    config = {hand_type = 'bunc_Spectrum Five', softlock = true},

    loc_vars = function(self, info_queue, center)
        SMODS.ConsumableDX.loc_vars(self, info_queue, center)
        local loc_vars = {
            G.GAME.hands[self.config.hand_type].level, localize(self.config.hand_type, 'poker_hands'), G.GAME.hands[self.config.hand_type].l_mult * 2, G.GAME.hands[self.config.hand_type].l_chips * 2,
            colours = {(G.GAME.hands[self.config.hand_type].level==1 and G.C.UI.TEXT_DARK or G.C.HAND_LEVELS[math.min(7, G.GAME.hands[self.config.hand_type].level)])}
        }
        return {vars = loc_vars}
    end,

    set_card_type_badge = function(self, card, badges)
        badges[1] = create_badge(bunco.config.fixed_badges and localize('k_planet_q') or localize('k_dwarf_planet'), get_type_colour(self or card.config, card), nil, 1.2)
        SMODS.ConsumableDX.set_card_type_badge(self, card, badges)
    end,

    use = function(self, card, area, copier)
        local used_tarot = copier or card
        update_hand_text({sound = 'button', volume = 0.7, pitch = 0.8, delay = 0.3}, {handname=localize(self.config.hand_type, 'poker_hands'),chips = G.GAME.hands[self.config.hand_type].chips, mult = G.GAME.hands[self.config.hand_type].mult, level=G.GAME.hands[self.config.hand_type].level})
        level_up_hand(used_tarot, self.config.hand_type, false, 2)
        update_hand_text({sound = 'button', volume = 0.7, pitch = 1.1, delay = 0}, {mult = 0, chips = 0, handname = '', level = ''})
    end,
}

-------------
--SPECTRALS--
-------------

-- Cleanse DX
SMODS.ConsumableDX{
	set = 'Spectral', atlas = 'bunco_spectrals_dx', key = 'c_bunc_cleanse_dx',
	loc_txt = {
        name = "Cleanse DX",
        text = {
            "Add {C:dark_edition}Fluorescent{} to",
            "{C:attention}all{} cards in hand",
            "{C:inactive}(If they have no edition)"
        }
    },
    pos = {x=0,y=0},
    config = {},
    cost = 6,

    set_card_type_badge = function(self, card, badges)
        badges[1] = create_badge(localize('k_spectral'), get_type_colour(self or card.config, card), nil, 1.2)
        SMODS.ConsumableDX.set_card_type_badge(self, card, badges)
    end,

    loc_vars = function(self, info_queue, center)
        SMODS.ConsumableDX.loc_vars(self, info_queue, center)
        info_queue[#info_queue+1] = G.P_CENTERS.e_bunc_fluorescent
        return {}
    end,

    use = function(self, card, area, copier)
        local used_tarot = copier or card
        used_tarot:juice_up(0.3, 0.5)
        local edition = {bunc_fluorescent = true}
        for i = 1, #G.hand.cards do
            G.E_MANAGER:add_event(Event({func = function()
                local _card = G.hand.cards[i]
                if not _card.edition then 
                    _card:set_edition(edition, true)
                end
            return true end }))
        end
    end,

    can_use = function(self)
        return (G.STATE == G.STATES.SELECTING_HAND or G.STATE == G.STATES.TAROT_PACK or G.STATE == G.STATES.SPECTRAL_PACK or G.STATE == G.STATES.PLANET_PACK)
    end,
}


function LoadBuncoDX()
    sendInfoMessage("Bunco Loaded", 'DX')
    
    SMODS.Atlas({key = 'bunco_tarots_dx', path = 'Bunco_Tarots_dx.png', px = 71, py = 95})
    SMODS.Atlas({key = 'bunco_planets_dx', path = 'Bunco_Planets_dx.png', px = 71, py = 95})
    SMODS.Atlas({key = 'bunco_spectrals_dx', path = 'Bunco_Spectrals_dx.png', px = 71, py = 95})
    SMODS.Atlas({key = 'bunco_tarots_cu', path = 'Bunco_Tarots_cu.png', px = 71, py = 95})
    
    G.localization.misc.labels['sky_bu'] = "Fleurons Buff"
    G.localization.misc.labels['abyss_bu'] = "Halberds Buff"
    G.BADGE_COL['sky_bu'] = HEX('d6901a')
    G.BADGE_COL['abyss_bu'] = HEX('6e3c63')
end