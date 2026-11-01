local bunco = SMODS.Mods['Bunco']

local function bunco_planet_badge(self)
    return bunco.config.fixed_badges and localize('k_planet_q') or localize('k_dwarf_planet')
end

----------
--TAROTS--
----------

-- The Sky DX
SMODS.ConsumableDX{
	set = 'Tarot', atlas = 'bunco_tarots_dx', key = 'c_bunc_sky_dx',
    pos = {x=0,y=0},
    config = {suit_conv = 'bunc_Fleurons', max_highlighted = 5},

    type_badge = function(self) return 'Tarot?' end,

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
    pos = {x=1,y=0},
    config = {suit_conv = 'bunc_Halberds', max_highlighted = 5},

    type_badge = function(self) return 'Tarot?' end,

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
    pos = {x=0,y=0},
    nb_curse = 2,
    config = {suit_conv = 'bunc_Fleurons'},
    unique = true,

    type_badge = function(self) return 'Tarot?' end,

    loc_vars = function(self, info_queue, center)
        SMODS.ConsumableCU.loc_vars(self, info_queue, center)
        local fool_c = G.P_CENTERS["c_bunc_sky_dx"] or nil
        local created_card = fool_c and localize{type = 'name_text', key = fool_c.key, set = fool_c.set} or localize('k_none')
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
    pos = {x=1,y=0},
    nb_curse = 2,
    config = {suit_conv = 'bunc_Halberds'},
    unique = true,

    type_badge = function(self) return 'Tarot?' end,

    loc_vars = function(self, info_queue, center)
        SMODS.ConsumableCU.loc_vars(self, info_queue, center)
        local fool_c = G.P_CENTERS["c_bunc_abyss_dx"] or nil
        local created_card = fool_c and localize{type = 'name_text', key = fool_c.key, set = fool_c.set} or localize('k_none')
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
SMODS.PlanetDX{atlas = 'bunco_planets_dx', key = 'c_bunc_quaoar_dx', pos = {x=0,y=0}, config = {hand_type = 'bunc_Spectrum', softlock = true}, type_badge = bunco_planet_badge}

-- Haumea DX
SMODS.PlanetDX{atlas = 'bunco_planets_dx', key = 'c_bunc_haumea_dx', pos = {x=1,y=0}, config = {hand_type = 'bunc_Straight Spectrum', softlock = true}, type_badge = bunco_planet_badge}

-- Sedna DX
SMODS.PlanetDX{atlas = 'bunco_planets_dx', key = 'c_bunc_sedna_dx', pos = {x=2,y=0}, config = {hand_type = 'bunc_Spectrum House', softlock = true}, type_badge = bunco_planet_badge}

-- Makemake DX
SMODS.PlanetDX{atlas = 'bunco_planets_dx', key = 'c_bunc_makemake_dx', pos = {x=3,y=0}, config = {hand_type = 'bunc_Spectrum Five', softlock = true}, type_badge = bunco_planet_badge}

-------------
--SPECTRALS--
-------------

-- Cleanse DX
SMODS.ConsumableDX{
	set = 'Spectral', atlas = 'bunco_spectrals_dx', key = 'c_bunc_cleanse_dx',
    pos = {x=0,y=0},
    config = {},
    cost = 6,

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

function DXT.load_bunco_dx()
    sendInfoMessage("Bunco Loaded", 'DX')
    
    SMODS.Atlas({key = 'bunco_tarots_dx', path = 'Bunco_Tarots_dx.png', px = 71, py = 95})
    SMODS.Atlas({key = 'bunco_planets_dx', path = 'Bunco_Planets_dx.png', px = 71, py = 95})
    SMODS.Atlas({key = 'bunco_spectrals_dx', path = 'Bunco_Spectrals_dx.png', px = 71, py = 95})
    SMODS.Atlas({key = 'bunco_tarots_cu', path = 'Bunco_Tarots_cu.png', px = 71, py = 95})
    
    G.BADGE_COL['sky_bu'] = HEX('d6901a')
    G.BADGE_COL['abyss_bu'] = HEX('6e3c63')
end