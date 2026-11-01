----------
--TAROTS--
----------

-- The Fool DX
SMODS.ConsumableDX{
	set = 'Tarot', atlas = 'Van_dx', key = 'c_fool_dx',
    pos = {x=0,y=0},

    loc_vars = function(self, info_queue, center)
        SMODS.ConsumableDX.loc_vars(self, info_queue, center)
        local fool_c = G.GAME.last_tarot_planet and G.P_CENTERS[G.GAME.last_tarot_planet] or nil
        local last_tarot_planet = fool_c and localize{type = 'name_text', key = fool_c.key, set = fool_c.set} or localize('k_none')
        local colour = (not fool_c or fool_c.name == 'The Fool') and G.C.RED or G.C.GREEN
        main_end = {
            {n=G.UIT.C, config={align = "bm", padding = 0.02}, nodes={
                {n=G.UIT.C, config={align = "m", colour = colour, r = 0.05, padding = 0.05}, nodes={
                    {n=G.UIT.T, config={text = ' '..last_tarot_planet..' ', colour = G.C.UI.TEXT_LIGHT, scale = 0.3, shadow = true}},
                }}
            }}
        }
        if not (not fool_c or fool_c.name == 'The Fool') then
            info_queue[#info_queue+1] = fool_c
        end
        return {vars = {last_tarot_planet}}
    end,

    use = function(self, card, area, copier)
        local used_tarot = copier or card
        G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
            if G.consumeables.config.card_limit > #G.consumeables.cards then
                play_sound('timpani')
                local card = create_card('Tarot_Planet', G.consumeables, nil, nil, nil, nil, G.GAME.last_tarot_planet, 'fool')
                card:add_to_deck()
                G.consumeables:emplace(card)
                if G.consumeables.config.card_limit > #G.consumeables.cards then 
                    card = create_card('Tarot_Planet', G.consumeables, nil, nil, nil, nil, G.GAME.last_tarot_planet, 'fool')
                    card:add_to_deck()
                    G.consumeables:emplace(card)
                end
                used_tarot:juice_up(0.3, 0.5)
            end
            return true end }))
    end,

    can_use = function(self)
        return (#G.consumeables.cards < G.consumeables.config.card_limit or self.area == G.consumeables) and G.GAME.last_tarot_planet and G.GAME.last_tarot_planet ~= 'c_fool'
    end,
}

-- The Magician DX
SMODS.ConsumableDX{
	set = 'Tarot', atlas = 'Van_dx', key = 'c_magician_dx',
    pos = {x=1,y=0},
    config = {mod_conv = 'm_lucky', max_highlighted = 4},

    loc_vars = function(self, info_queue, center)
        SMODS.ConsumableDX.loc_vars(self, info_queue, center)
        info_queue[#info_queue+1] = G.P_CENTERS[self.config.mod_conv]
        return {vars = {self.config.max_highlighted, localize{type = 'name_text', set = 'Enhanced', key = self.config.mod_conv}}}
    end,
}

-- The High Priestess DX
SMODS.ConsumableDX{
	set = 'Tarot', atlas = 'Van_dx', key = 'c_high_priestess_dx',
    pos = {x=2,y=0},
    config = {planets = 2},

    loc_vars = function(self, info_queue, center)
        SMODS.ConsumableDX.loc_vars(self, info_queue, center)
        return {vars = {self.config.planets}}
    end,

    use = function(self, card, area, copier)
        local used_tarot = copier or card
        for i = 1, math.min(self.config.planets, G.consumeables.config.card_limit - #G.consumeables.cards) do
            G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
                if G.consumeables.config.card_limit > #G.consumeables.cards then
                    play_sound('timpani')
                    local card = create_card('Planet_dx', G.consumeables, nil, nil, nil, nil, nil, 'pri')
                    card:add_to_deck()
                    G.consumeables:emplace(card)
                    used_tarot:juice_up(0.3, 0.5)
                end
                return true end }))
        end
        delay(0.6)
    end,

    can_use = function(self)
        return true
    end,
}

-- The Empress DX
SMODS.ConsumableDX{
	set = 'Tarot', atlas = 'Van_dx', key = 'c_empress_dx',
    pos = {x=3,y=0},
    config = {mod_conv = 'm_mult', max_highlighted = 4},

    loc_vars = function(self, info_queue, center)
        SMODS.ConsumableDX.loc_vars(self, info_queue, center)
        info_queue[#info_queue+1] = G.P_CENTERS[self.config.mod_conv]
        return {vars = {self.config.max_highlighted, localize{type = 'name_text', set = 'Enhanced', key = self.config.mod_conv}}}
    end,
}

-- The Emperor DX
SMODS.ConsumableDX{
	set = 'Tarot', atlas = 'Van_dx', key = 'c_emperor_dx',
    pos = {x=4,y=0},
    config = {tarots = 2},

    loc_vars = function(self, info_queue, center)
        SMODS.ConsumableDX.loc_vars(self, info_queue, center)
        return {vars = {self.config.tarots}}
    end,

    use = function(self, card, area, copier)
        local used_tarot = copier or card
        for i = 1, math.min(self.config.tarots, G.consumeables.config.card_limit - #G.consumeables.cards) do
            G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
                if G.consumeables.config.card_limit > #G.consumeables.cards then
                    play_sound('timpani')
                    local card = create_card('Tarot_dx', G.consumeables, nil, nil, nil, nil, nil, 'emp')
                    card:add_to_deck()
                    G.consumeables:emplace(card)
                    used_tarot:juice_up(0.3, 0.5)
                end
                return true end }))
        end
        delay(0.6)
    end,

    can_use = function(self)
        return true
    end,
}

-- The Hierophant DX
SMODS.ConsumableDX{
	set = 'Tarot', atlas = 'Van_dx', key = 'c_heirophant_dx',
    pos = {x=5,y=0},
    config = {mod_conv = 'm_bonus', max_highlighted = 4},

    loc_vars = function(self, info_queue, center)
        SMODS.ConsumableDX.loc_vars(self, info_queue, center)
        info_queue[#info_queue+1] = G.P_CENTERS[self.config.mod_conv]
        return {vars = {self.config.max_highlighted, localize{type = 'name_text', set = 'Enhanced', key = self.config.mod_conv}}}
    end,
}

-- The Lovers DX
SMODS.ConsumableDX{
	set = 'Tarot', atlas = 'Van_dx', key = 'c_lovers_dx',
    pos = {x=6,y=0},
    config = {mod_conv = 'm_wild', max_highlighted = 4},

    loc_vars = function(self, info_queue, center)
        SMODS.ConsumableDX.loc_vars(self, info_queue, center)
        info_queue[#info_queue+1] = G.P_CENTERS[self.config.mod_conv]
        return {vars = {self.config.max_highlighted, localize{type = 'name_text', set = 'Enhanced', key = self.config.mod_conv}}}
    end,
}

-- The Chariot DX
SMODS.ConsumableDX{
	set = 'Tarot', atlas = 'Van_dx', key = 'c_chariot_dx',
    pos = {x=7,y=0},
    config = {mod_conv = 'm_steel', max_highlighted = 2},

    loc_vars = function(self, info_queue, center)
        SMODS.ConsumableDX.loc_vars(self, info_queue, center)
        info_queue[#info_queue+1] = G.P_CENTERS[self.config.mod_conv]
        return {vars = {self.config.max_highlighted, localize{type = 'name_text', set = 'Enhanced', key = self.config.mod_conv}}}
    end,
}

-- Justice DX
SMODS.ConsumableDX{
	set = 'Tarot', atlas = 'Van_dx', key = 'c_justice_dx',
    pos = {x=8,y=0},
    config = {mod_conv = 'm_glass', max_highlighted = 2},

    loc_vars = function(self, info_queue, center)
        SMODS.ConsumableDX.loc_vars(self, info_queue, center)
        info_queue[#info_queue+1] = G.P_CENTERS[self.config.mod_conv]
        return {vars = {self.config.max_highlighted, localize{type = 'name_text', set = 'Enhanced', key = self.config.mod_conv}}}
    end,
}

-- The Hermit DX
SMODS.ConsumableDX{
	set = 'Tarot', atlas = 'Van_dx', key = 'c_hermit_dx',
    pos = {x=9,y=0},
    config = {extra = 30},

    loc_vars = function(self, info_queue, center)
        SMODS.ConsumableDX.loc_vars(self, info_queue, center)
        return {vars = {self.config.extra}}
    end,

    use = function(self, card, area, copier)
        local used_tarot = copier or card
        G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
            play_sound('timpani')
            used_tarot:juice_up(0.3, 0.5)
            ease_dollars(math.max(0, math.min(DXT.to_number(G.GAME.dollars) * 2, self.config.extra)), true)
            return true end }))
        delay(0.6)
    end,

    can_use = function(self)
        return true
    end,
}

-- The Wheel of Fortune DX
SMODS.ConsumableDX{
	set = 'Tarot', atlas = 'Van_dx', key = 'c_wheel_of_fortune_dx',
    pos = {x=0,y=1},
    config = {extra = 2},

    loc_vars = function(self, info_queue, center)
        SMODS.ConsumableDX.loc_vars(self, info_queue, center)
        info_queue[#info_queue+1] = G.P_CENTERS.e_foil
        info_queue[#info_queue+1] = G.P_CENTERS.e_holo
        info_queue[#info_queue+1] = G.P_CENTERS.e_polychrome
        return {vars = {SMODS.get_probability_vars(center, 1, self.config.extra, 'wheel_of_fortune')}}
    end,

    use = function(self, card, area, copier)
        local used_tarot = copier or card
        local temp_pool = self.eligible_strength_jokers or {}
        if SMODS.pseudorandom_probability(used_tarot, 'wheel_of_fortune', 1, self.config.extra, 'wheel_of_fortune') then 
            G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
                local over = false
                local eligible_card = pseudorandom_element(temp_pool, pseudoseed('wheel_of_fortune'))
                local edition = poll_edition('wheel_of_fortune', nil, true, true)
                eligible_card:set_edition(edition, true)
                check_for_unlock({type = 'have_edition'})
                used_tarot:juice_up(0.3, 0.5)
            return true end }))
        else
            G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
                attention_text({
                    text = localize('k_nope_ex'),
                    scale = 1.3, 
                    hold = 1.4,
                    major = used_tarot,
                    backdrop_colour = G.C.SECONDARY_SET.Tarot,
                    align = (G.STATE == G.STATES.TAROT_PACK or G.STATE == G.STATES.SPECTRAL_PACK) and 'tm' or 'cm',
                    offset = {x = 0, y = (G.STATE == G.STATES.TAROT_PACK or G.STATE == G.STATES.SPECTRAL_PACK) and -0.2 or 0},
                    silent = true
                    })
                    G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.06*G.SETTINGS.GAMESPEED, blockable = false, blocking = false, func = function()
                        play_sound('tarot2', 0.76, 0.4);return true end}))
                    play_sound('tarot2', 1, 0.4)
                    used_tarot:juice_up(0.3, 0.5)
            return true end }))
        end
        delay(0.6)
    end,

    can_use = function(self)
        return next(self.eligible_strength_jokers)
    end,

    update = function(self, card, dt)
        if G.STAGE and G.STAGE == G.STAGES.RUN then
            self.eligible_strength_jokers = EMPTY(self.eligible_strength_jokers)
            for k, v in pairs(G.jokers.cards) do
                if v.ability.set == 'Joker' and (not v.edition) then
                    table.insert(self.eligible_strength_jokers, v)
                end
            end
        end
    end,
}

-- Strength DX
SMODS.ConsumableDX{
	set = 'Tarot', atlas = 'Van_dx', key = 'c_strength_dx',
    pos = {x=1,y=1},
    config = {mod_conv = 'up_rank', max_highlighted = 4},

    loc_vars = function(self, info_queue, center)
        SMODS.ConsumableDX.loc_vars(self, info_queue, center)
        return {vars = {self.config.max_highlighted}}
    end,

    use = function(self, card, area, copier)
        local used_tarot = copier or card
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.4,
            func = function()
                play_sound('tarot1')
                used_tarot:juice_up(0.3, 0.5)
                return true
            end
        }))
        for i = 1, #G.hand.highlighted do
            local percent = 1.15 - (i - 0.999) / (#G.hand.highlighted - 0.998) * 0.3
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.15,
                func = function()
                    G.hand.highlighted[i]:flip(); play_sound('card1', percent); G.hand.highlighted[i]:juice_up(0.3,
                        0.3); return true
                end
            }))
        end
        delay(0.2)
        for i = 1, #G.hand.highlighted do
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.1,
                func = function()
                    local _card = G.hand.highlighted[i]
                    local rank_data = SMODS.Ranks[_card.base.value]
                    local behavior = rank_data.strength_effect or { fixed = 1, ignore = false, random = false }
                    local new_rank
                    if behavior.ignore or not next(rank_data.next) then
                        return true
                    elseif behavior.random then
                        -- TODO doesn't respect in_pool
                        new_rank = pseudorandom_element(rank_data.next, pseudoseed('strength'))
                    else
                        local ii = (behavior.fixed and rank_data.next[behavior.fixed]) and behavior.fixed or 1
                        new_rank = rank_data.next[ii]
                    end
                    assert(SMODS.change_base(_card, nil, new_rank))
                    return true
                end
            }))
        end
        for i = 1, #G.hand.highlighted do
            local percent = 0.85 + (i - 0.999) / (#G.hand.highlighted - 0.998) * 0.3
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.15,
                func = function()
                    G.hand.highlighted[i]:flip(); play_sound('tarot2', percent, 0.6); G.hand.highlighted[i]
                        :juice_up(
                            0.3, 0.3); return true
                end
            }))
        end
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.2,
            func = function()
                G.hand:unhighlight_all(); return true
            end
        }))
        delay(0.5)
    end,
}

-- The Hanged Man DX
SMODS.ConsumableDX{
	set = 'Tarot', atlas = 'Van_dx', key = 'c_hanged_man_dx',
    pos = {x=2,y=1},
    config = {remove_card = true, max_highlighted = 4},

    loc_vars = function(self, info_queue, center)
        SMODS.ConsumableDX.loc_vars(self, info_queue, center)
        return {vars = {self.config.max_highlighted}}
    end,
    
    use = function(self, card, area, copier)
        local used_tarot = copier or card
        local destroyed_cards = {}
        for i=#G.hand.highlighted, 1, -1 do
            destroyed_cards[#destroyed_cards+1] = G.hand.highlighted[i]
        end
        G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
            play_sound('tarot1')
            used_tarot:juice_up(0.3, 0.5)
            return true end }))
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.2,
            func = function() 
                SMODS.destroy_cards(destroyed_cards)
                return true end }))
        delay(0.3)
    end,
}

-- Death DX
SMODS.ConsumableDX{
	set = 'Tarot', atlas = 'Van_dx', key = 'c_death_dx',
    pos = {x=3,y=1},
    config = {mod_conv = 'card', max_highlighted = 3, min_highlighted = 2},

    loc_vars = function(self, info_queue, center)
        SMODS.ConsumableDX.loc_vars(self, info_queue, center)
        info_queue[#info_queue+1] = G.P_CENTERS[self.config.mod_conv]
        return {vars = {self.config.max_highlighted}}
    end,

    use = function(self, card, area, copier)
        local used_tarot = copier or card
        local rightmost = G.hand.highlighted[1]
        G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
            play_sound('tarot1')
            used_tarot:juice_up(0.3, 0.5)
            return true end }))
        for i=1, #G.hand.highlighted do
            local percent = 1.15 - (i-0.999)/(#G.hand.highlighted-0.998)*0.3
            G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() G.hand.highlighted[i]:flip();play_sound('card1', percent);G.hand.highlighted[i]:juice_up(0.3, 0.3);return true end }))
        end
        delay(0.2)
        G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
            play_sound('tarot1')
            used_tarot:juice_up(0.3, 0.5)
            return true end }))
        for i=1, #G.hand.highlighted do if G.hand.highlighted[i].T.x > rightmost.T.x then rightmost = G.hand.highlighted[i] end end
        for i=1, #G.hand.highlighted do
            G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.1,func = function()
                if G.hand.highlighted[i] ~= rightmost then
                    copy_card(rightmost, G.hand.highlighted[i])
                end
                return true end }))
        end
        for i=1, #G.hand.highlighted do
            local percent = 0.85 + (i-0.999)/(#G.hand.highlighted-0.998)*0.3
            G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() G.hand.highlighted[i]:flip();play_sound('tarot2', percent, 0.6);G.hand.highlighted[i]:juice_up(0.3, 0.3);return true end }))
        end
        G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.2,func = function() G.hand:unhighlight_all(); return true end }))
        delay(0.5)
    end,
}

-- Temperance DX
SMODS.ConsumableDX{
	set = 'Tarot', atlas = 'Van_dx', key = 'c_temperance_dx',
    pos = {x=4,y=1},
    config = {extra = 60},

    loc_vars = function(self, info_queue, center)
        SMODS.ConsumableDX.loc_vars(self, info_queue, center)
        local _money = 0
        if G.jokers then
            for i = 1, #G.jokers.cards do
                if G.jokers.cards[i].ability.set == 'Joker' then
                    _money = _money + G.jokers.cards[i].sell_cost * 2
                end
            end
        end
        return {vars = {self.config.extra, math.min(self.config.extra, _money)}}
    end,

    use = function(self, card, area, copier)
        local used_tarot = copier or card
        G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
            play_sound('timpani')
            used_tarot:juice_up(0.3, 0.5)
            ease_dollars(self.money, true)
            return true end }))
        delay(0.6)
    end,

    can_use = function(self)
        return true
    end,

    update = function(self, card, dt)
        if G.STAGE == G.STAGES.RUN then
            self.money = 0
            for i = 1, #G.jokers.cards do
                if G.jokers.cards[i].ability.set == 'Joker' then
                    self.money = self.money + (G.jokers.cards[i].sell_cost * 2)
                end
            end
            self.money = math.min(self.money, self.config.extra)
        else
            self.money = 0
        end
    end,
}

-- The Devil DX
SMODS.ConsumableDX{
	set = 'Tarot', atlas = 'Van_dx', key = 'c_devil_dx',
    pos = {x=5,y=1},
    config = {mod_conv = 'm_gold', max_highlighted = 2},

    loc_vars = function(self, info_queue, center)
        SMODS.ConsumableDX.loc_vars(self, info_queue, center)
        info_queue[#info_queue+1] = G.P_CENTERS[self.config.mod_conv]
        return {vars = {self.config.max_highlighted, localize{type = 'name_text', set = 'Enhanced', key = self.config.mod_conv}}}
    end,
}

-- The Tower DX
SMODS.ConsumableDX{
	set = 'Tarot', atlas = 'Van_dx', key = 'c_tower_dx',
    pos = {x=6,y=1},
    config = {mod_conv = 'm_stone', max_highlighted = 2},

    loc_vars = function(self, info_queue, center)
        SMODS.ConsumableDX.loc_vars(self, info_queue, center)
        info_queue[#info_queue+1] = G.P_CENTERS[self.config.mod_conv]
        return {vars = {self.config.max_highlighted, localize{type = 'name_text', set = 'Enhanced', key = self.config.mod_conv}}}
    end,
}

-- The Star DX
SMODS.ConsumableDX{
	set = 'Tarot', atlas = 'Van_dx', key = 'c_star_dx',
    pos = {x=7,y=1},
    config = {suit_conv = 'Diamonds', max_highlighted = 5},

    loc_vars = function(self, info_queue, center)
        SMODS.ConsumableDX.loc_vars(self, info_queue, center)
        return {vars = {self.config.max_highlighted, localize(self.config.suit_conv, 'suits_plural'), colours = {G.C.SUITS[self.config.suit_conv]}}}
    end,
}

-- The Moon DX
SMODS.ConsumableDX{
	set = 'Tarot', atlas = 'Van_dx', key = 'c_moon_dx',
    pos = {x=8,y=1},
    config = {suit_conv = 'Clubs', max_highlighted = 5},

    loc_vars = function(self, info_queue, center)
        SMODS.ConsumableDX.loc_vars(self, info_queue, center)
        return {vars = {self.config.max_highlighted, localize(self.config.suit_conv, 'suits_plural'), colours = {G.C.SUITS[self.config.suit_conv]}}}
    end,
}

-- The Sun DX
SMODS.ConsumableDX{
	set = 'Tarot', atlas = 'Van_dx', key = 'c_sun_dx',
    pos = {x=9,y=1},
    config = {suit_conv = 'Hearts', max_highlighted = 5},

    loc_vars = function(self, info_queue, center)
        SMODS.ConsumableDX.loc_vars(self, info_queue, center)
        return {vars = {self.config.max_highlighted, localize(self.config.suit_conv, 'suits_plural'), colours = {G.C.SUITS[self.config.suit_conv]}}}
    end,
}

-- Judgement DX
SMODS.ConsumableDX{
	set = 'Tarot', atlas = 'Van_dx', key = 'c_judgement_dx',
    pos = {x=0,y=2},

    loc_vars = function(self, info_queue, center)
        SMODS.ConsumableDX.loc_vars(self, info_queue, center)
        return {}
    end,

    use = function(self, card, area, copier)
        local used_tarot = copier or card
        G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
            play_sound('timpani')
            local rarity = 0.8
            local card = create_card('Joker', G.jokers, false, rarity, nil, nil, nil, 'jud')
            card:add_to_deck()
            G.jokers:emplace(card)
            used_tarot:juice_up(0.3, 0.5)
            return true end }))
        delay(0.6)
    end,

    can_use = function(self)
        return (#G.jokers.cards < G.jokers.config.card_limit or self.area == G.jokers)
    end,
}

-- The World DX
SMODS.ConsumableDX{
	set = 'Tarot', atlas = 'Van_dx', key = 'c_world_dx',
    pos = {x=1,y=2},
    config = {suit_conv = 'Spades', max_highlighted = 5},

    loc_vars = function(self, info_queue, center)
        SMODS.ConsumableDX.loc_vars(self, info_queue, center)
        return {vars = {self.config.max_highlighted, localize(self.config.suit_conv, 'suits_plural'), colours = {G.C.SUITS[self.config.suit_conv]}}}
    end,
}

-----------
--PLANETS--
-----------

-- Mercury DX
SMODS.PlanetDX{key = 'c_mercury_dx', pos = {x=0,y=3}, config = {hand_type = 'Pair'}}

-- Venus DX
SMODS.PlanetDX{key = 'c_venus_dx', pos = {x=1,y=3}, config = {hand_type = 'Three of a Kind'}}

-- Earth DX
SMODS.PlanetDX{key = 'c_earth_dx', pos = {x=2,y=3}, config = {hand_type = 'Full House'}}

-- Mars DX
SMODS.PlanetDX{key = 'c_mars_dx', pos = {x=3,y=3}, config = {hand_type = 'Four of a Kind'}}

-- Jupiter DX
SMODS.PlanetDX{key = 'c_jupiter_dx', pos = {x=4,y=3}, config = {hand_type = 'Flush'}}

-- Saturn DX
SMODS.PlanetDX{key = 'c_saturn_dx', pos = {x=5,y=3}, config = {hand_type = 'Straight'}}

-- Uranus DX
SMODS.PlanetDX{key = 'c_uranus_dx', pos = {x=6,y=3}, config = {hand_type = 'Two Pair'}}

-- Neptune DX
SMODS.PlanetDX{key = 'c_neptune_dx', pos = {x=7,y=3}, config = {hand_type = 'Straight Flush'}}

-- Pluto DX
SMODS.PlanetDX{key = 'c_pluto_dx', pos = {x=8,y=3}, config = {hand_type = 'High Card'}, type_badge = 'k_dwarf_planet'}

-- Planet X DX
SMODS.PlanetDX{key = 'c_planet_x_dx', pos = {x=9,y=2}, config = {hand_type = 'Five of a Kind', softlock = true}, type_badge = 'k_planet_q'}

-- Ceres DX
SMODS.PlanetDX{key = 'c_ceres_dx', pos = {x=8,y=2}, config = {hand_type = 'Flush House', softlock = true}, type_badge = 'k_dwarf_planet'}

-- Eris DX
SMODS.PlanetDX{key = 'c_eris_dx', pos = {x=3,y=2}, config = {hand_type = 'Flush Five', softlock = true}, type_badge = 'k_dwarf_planet'}

-------------
--SPECTRALS--
-------------

-- Familiar DX
SMODS.ConsumableDX{
	set = 'Spectral', atlas = 'Van_dx', key = 'c_familiar_dx',
    pos = {x=0,y=4},
    config = {max_highlighted = 2, min_highlighted = 2, remove_card = true, extra = 5},
    cost = 6,

    loc_vars = function(self, info_queue, center)
        SMODS.ConsumableDX.loc_vars(self, info_queue, center)
        return {vars = {self.config.extra}}
    end,

    use = function(self, card, area, copier)
        local used_tarot = copier or card
        local destroyed_cards = {}
        for i=#G.hand.highlighted, 1, -1 do
            destroyed_cards[#destroyed_cards+1] = G.hand.highlighted[i]
        end
        G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
            play_sound('tarot1')
            used_tarot:juice_up(0.3, 0.5)
            return true end }))
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.2,
            func = function() 
                SMODS.destroy_cards(destroyed_cards)
                return true end }))
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.7,
            func = function() 
                local cards = {}
                for i=1, self.config.extra do
                    cards[i] = true
                    local _suit, _rank = nil, nil
                    _rank = pseudorandom_element({'J', 'Q', 'K'}, pseudoseed('familiar_create'))
                    _suit = pseudorandom_element({'S','H','D','C'}, pseudoseed('familiar_create'))
                    _suit = _suit or 'S'; _rank = _rank or 'A'
                    local cen_pool = {}
                    for k, v in pairs(G.P_CENTER_POOLS["Enhanced"]) do
                        if v.key ~= 'm_stone' then 
                            cen_pool[#cen_pool+1] = v
                        end
                    end
                    create_playing_card({front = G.P_CARDS[_suit..'_'.._rank], center = pseudorandom_element(cen_pool, pseudoseed('spe_card'))}, G.hand, nil, i ~= 1, {G.C.SECONDARY_SET.Spectral})
                end
                playing_card_joker_effects(cards)
                return true end }))
        delay(0.3)
    end,
}

-- Grim DX
SMODS.ConsumableDX{
	set = 'Spectral', atlas = 'Van_dx', key = 'c_grim_dx',
    pos = {x=1,y=4},
    config = {max_highlighted = 2, min_highlighted = 2, remove_card = true, extra = 4},
    cost = 6,

    loc_vars = function(self, info_queue, center)
        SMODS.ConsumableDX.loc_vars(self, info_queue, center)
        return {vars = {self.config.extra}}
    end,

    use = function(self, card, area, copier)
        local used_tarot = copier or card
        local destroyed_cards = {}
        for i=#G.hand.highlighted, 1, -1 do
            destroyed_cards[#destroyed_cards+1] = G.hand.highlighted[i]
        end
        G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
            play_sound('tarot1')
            used_tarot:juice_up(0.3, 0.5)
            return true end }))
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.2,
            func = function() 
                SMODS.destroy_cards(destroyed_cards)
                return true end }))
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.7,
            func = function() 
                local cards = {}
                for i=1, self.config.extra do
                    cards[i] = true
                    local _suit, _rank = nil, nil
                    _rank = 'A'
                    _suit = pseudorandom_element({'S','H','D','C'}, pseudoseed('grim_create'))
                    _suit = _suit or 'S'; _rank = _rank or 'A'
                    local cen_pool = {}
                    for k, v in pairs(G.P_CENTER_POOLS["Enhanced"]) do
                        if v.key ~= 'm_stone' then 
                            cen_pool[#cen_pool+1] = v
                        end
                    end
                    create_playing_card({front = G.P_CARDS[_suit..'_'.._rank], center = pseudorandom_element(cen_pool, pseudoseed('spe_card'))}, G.hand, nil, i ~= 1, {G.C.SECONDARY_SET.Spectral})
                end
                playing_card_joker_effects(cards)
                return true end }))
        delay(0.3)
    end,
}

-- Incantation DX
SMODS.ConsumableDX{
	set = 'Spectral', atlas = 'Van_dx', key = 'c_incantation_dx',
    pos = {x=2,y=4},
    config = {max_highlighted = 2, min_highlighted = 2, remove_card = true, extra = 6},
    cost = 6,

    loc_vars = function(self, info_queue, center)
        SMODS.ConsumableDX.loc_vars(self, info_queue, center)
        return {vars = {self.config.extra}}
    end,

    use = function(self, card, area, copier)
        local used_tarot = copier or card
        local destroyed_cards = {}
        for i=#G.hand.highlighted, 1, -1 do
            destroyed_cards[#destroyed_cards+1] = G.hand.highlighted[i]
        end
        G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
            play_sound('tarot1')
            used_tarot:juice_up(0.3, 0.5)
            return true end }))
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.2,
            func = function() 
                SMODS.destroy_cards(destroyed_cards)
                return true end }))
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.7,
            func = function() 
                local cards = {}
                for i=1, self.config.extra do
                    cards[i] = true
                    local _suit, _rank = nil, nil
                    _rank = pseudorandom_element({'2', '3', '4', '5', '6', '7', '8', '9', 'T'}, pseudoseed('incantation_create'))
                    _suit = pseudorandom_element({'S','H','D','C'}, pseudoseed('incantation_create'))
                    _suit = _suit or 'S'; _rank = _rank or 'A'
                    local cen_pool = {}
                    for k, v in pairs(G.P_CENTER_POOLS["Enhanced"]) do
                        if v.key ~= 'm_stone' then 
                            cen_pool[#cen_pool+1] = v
                        end
                    end
                    create_playing_card({front = G.P_CARDS[_suit..'_'.._rank], center = pseudorandom_element(cen_pool, pseudoseed('spe_card'))}, G.hand, nil, i ~= 1, {G.C.SECONDARY_SET.Spectral})
                end
                playing_card_joker_effects(cards)
                return true end }))
        delay(0.3)
    end,
}

-- Talisman DX
SMODS.ConsumableDX{
	set = 'Spectral', atlas = 'Van_dx', key = 'c_talisman_dx',
    pos = {x=3,y=4},
    config = {max_highlighted = 3, extra = 'Gold'},
    cost = 6,

    loc_vars = function(self, info_queue, center)
        SMODS.ConsumableDX.loc_vars(self, info_queue, center)
        info_queue[#info_queue+1] = {key = 'gold_seal', set = 'Other'}
        return {}
    end,

    use = function(self, card, area, copier)
        local used_tarot = copier or card
        for i=#G.hand.highlighted, 1, -1 do
            local conv_card = G.hand.highlighted[i]
            G.E_MANAGER:add_event(Event({func = function()
                play_sound('tarot1')
                used_tarot:juice_up(0.3, 0.5)
                return true end }))
                    
            G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.1,func = function()
                conv_card:set_seal(self.config.extra, nil, true)
                return true end }))
        end
        delay(0.5)
        G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.2,func = function() G.hand:unhighlight_all(); return true end }))
    end,
}

-- Aura DX
SMODS.ConsumableDX{
	set = 'Spectral', atlas = 'Van_dx', key = 'c_aura_dx',
    pos = {x=4,y=4},
    config = {max_highlighted = 3},
    cost = 6,

    loc_vars = function(self, info_queue, center)
        SMODS.ConsumableDX.loc_vars(self, info_queue, center)
        info_queue[#info_queue+1] = G.P_CENTERS.e_foil
        info_queue[#info_queue+1] = G.P_CENTERS.e_holo
        info_queue[#info_queue+1] = G.P_CENTERS.e_polychrome
        return {}
    end,

    use = function(self, card, area, copier)
        local used_tarot = copier or card
        used_tarot:juice_up(0.3, 0.5)
        for i=1, #G.hand.highlighted do
            G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
                local over = false
                local edition = poll_edition('aura', nil, true, true)
                local aura_card = G.hand.highlighted[i]
                aura_card:set_edition(edition, true)
            return true end }))
        end
    end,
}

-- Wraith DX
SMODS.ConsumableDX{
	set = 'Spectral', atlas = 'Van_dx', key = 'c_wraith_dx',
    pos = {x=5,y=4},
    config = {},
    cost = 6,

    loc_vars = function(self, info_queue, center)
        SMODS.ConsumableDX.loc_vars(self, info_queue, center)
        return {}
    end,

    use = function(self, card, area, copier)
        local used_tarot = copier or card
        G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
            play_sound('timpani')
            local card = create_card('Joker', G.jokers, nil, 0.99, nil, nil, nil, 'wra')
            card:add_to_deck()
            G.jokers:emplace(card)
            used_tarot:juice_up(0.3, 0.5)
            return true end }))
        delay(0.6)
    end,

    can_use = function(self)
        return (#G.jokers.cards < G.jokers.config.card_limit or self.area == G.jokers)
    end,
}

-- Sigil DX
SMODS.ConsumableDX{
	set = 'Spectral', atlas = 'Van_dx', key = 'c_sigil_dx',
    pos = {x=6,y=4},
    config = {max_highlighted = 1},
    cost = 6,

    loc_vars = function(self, info_queue, center)
        SMODS.ConsumableDX.loc_vars(self, info_queue, center)
        return {}
    end,

    use = function(self, card, area, copier)
        local used_tarot = copier or card
        local _suit = G.hand.highlighted[1].base.suit
        G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
            play_sound('tarot1')
            used_tarot:juice_up(0.3, 0.5)
            return true end }))
        for i=1, #G.hand.cards do
            local percent = 1.15 - (i-0.999)/(#G.hand.cards-0.998)*0.3
            G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() G.hand.cards[i]:flip();play_sound('card1', percent);G.hand.cards[i]:juice_up(0.3, 0.3);return true end }))
        end
        delay(0.2)
        for i = 1, #G.hand.cards do
            G.E_MANAGER:add_event(Event({
                func = function()
                    local _card = G.hand.cards[i]
                    assert(SMODS.change_base(_card, _suit))
                    return true
                end
            }))
        end
        for i=1, #G.hand.cards do
            local percent = 0.85 + (i-0.999)/(#G.hand.cards-0.998)*0.3
            G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() G.hand.cards[i]:flip();play_sound('tarot2', percent, 0.6);G.hand.cards[i]:juice_up(0.3, 0.3);return true end }))
        end
        delay(0.5)
    end,
}

-- Ouija DX
SMODS.ConsumableDX{
	set = 'Spectral', atlas = 'Van_dx', key = 'c_ouija_dx',
    pos = {x=7,y=4},
    config = {max_highlighted = 1},
    cost = 6,

    loc_vars = function(self, info_queue, center)
        SMODS.ConsumableDX.loc_vars(self, info_queue, center)
        return {}
    end,

    use = function(self, card, area, copier)
        local used_tarot = copier or card
        local _rank = G.hand.highlighted[1].base.value
        G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
            play_sound('tarot1')
            used_tarot:juice_up(0.3, 0.5)
            return true end }))
        for i=1, #G.hand.cards do
            local percent = 1.15 - (i-0.999)/(#G.hand.cards-0.998)*0.3
            G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() G.hand.cards[i]:flip();play_sound('card1', percent);G.hand.cards[i]:juice_up(0.3, 0.3);return true end }))
        end
        delay(0.2)
        for i = 1, #G.hand.cards do
            G.E_MANAGER:add_event(Event({
                func = function()
                    local _card = G.hand.cards[i]
                    assert(SMODS.change_base(_card, nil, _rank))
                    return true
                end
            }))
        end
        for i=1, #G.hand.cards do
            local percent = 0.85 + (i-0.999)/(#G.hand.cards-0.998)*0.3
            G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() G.hand.cards[i]:flip();play_sound('tarot2', percent, 0.6);G.hand.cards[i]:juice_up(0.3, 0.3);return true end }))
        end
        delay(0.5)
    end,
}

-- Ectoplasm DX
SMODS.ConsumableDX{
	set = 'Spectral', atlas = 'Van_dx', key = 'c_ectoplasm_dx',
    pos = {x=8,y=4},
    config = {},
    cost = 6,

    loc_vars = function(self, info_queue, center)
        SMODS.ConsumableDX.loc_vars(self, info_queue, center)
        info_queue[#info_queue+1] = G.P_CENTERS.e_negative
        return {}
    end,

    use = function(self, card, area, copier)
        local used_tarot = copier or card
        local temp_pool = self.eligible_strength_jokers or {}
        G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
            local over = false
            local eligible_card = pseudorandom_element(temp_pool, pseudoseed('ectoplasm'))
            local edition = {negative = true}
            local _first_dissolve = nil
            for k, v in ipairs(G.consumeables.cards) do
                if v.start_dissolve and not v.ability.eternal then v:start_dissolve(nil, _first_dissolve);_first_dissolve = true end
            end
            eligible_card:set_edition(edition, true)
            check_for_unlock({type = 'have_edition'})
            used_tarot:juice_up(0.3, 0.5)
        return true end }))
        delay(0.6)
    end,

    can_use = function(self)
        return next(self.eligible_strength_jokers)
    end,

    update = function(self, card, dt)
        if G.STAGE and G.STAGE == G.STAGES.RUN then
            self.eligible_strength_jokers = EMPTY(self.eligible_strength_jokers)
            for k, v in pairs(G.jokers.cards) do
                if v.ability.set == 'Joker' and (not v.edition) then
                    table.insert(self.eligible_strength_jokers, v)
                end
            end
        end
    end,
}

-- Immolate DX
SMODS.ConsumableDX{
	set = 'Spectral', atlas = 'Van_dx', key = 'c_immolate_dx',
    pos = {x=9,y=4},
    config = {max_highlighted = 5, min_highlighted = 5, remove_card = true, extra = {destroy = 5, dollars = 20}},
    cost = 6,

    loc_vars = function(self, info_queue, center)
        SMODS.ConsumableDX.loc_vars(self, info_queue, center)
        return {vars = {self.config.extra.destroy, self.config.extra.dollars}}
    end,

    use = function(self, card, area, copier)
        local used_tarot = copier or card
        local destroyed_cards = {}
        for i=#G.hand.highlighted, 1, -1 do
            destroyed_cards[#destroyed_cards+1] = G.hand.highlighted[i]
        end
        G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
            play_sound('tarot1')
            used_tarot:juice_up(0.3, 0.5)
            return true end }))
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.2,
            func = function() 
                SMODS.destroy_cards(destroyed_cards)
                return true end }))
        delay(0.5)
        ease_dollars(self.config.extra.dollars)
    end,
}

-- Ankh DX
SMODS.ConsumableDX{
	set = 'Spectral', atlas = 'Van_dx', key = 'c_ankh_dx',
    pos = {x=0,y=5},
    config = {},
    cost = 6,

    loc_vars = function(self, info_queue, center)
        SMODS.ConsumableDX.loc_vars(self, info_queue, center)
        if G.jokers and G.jokers.cards then
            for k, v in ipairs(G.jokers.cards) do
                if (v.edition and v.edition.negative) and (G.localization.descriptions.Other.remove_negative)then 
                    info_queue[#info_queue+1] = G.P_CENTERS.e_negative
                    main_end = {}
                    localize{type = 'other', key = 'remove_negative', nodes = main_end, vars = {}}
                    main_end = main_end[1]
                    break
                end
            end
        end
        return {}
    end,

    use = function(self, card, area, copier)
        local used_tarot = copier or card
        local chosen_joker = pseudorandom_element(G.jokers.cards, pseudoseed('ankh_choice'))
        G.E_MANAGER:add_event(Event({trigger = 'before', delay = 0.4, func = function()
            local card = copy_card(chosen_joker, nil, nil, nil, chosen_joker.edition and chosen_joker.edition.negative)
            card:start_materialize()
            card:add_to_deck()
            if card.edition and card.edition.negative then
                card:set_edition(nil, true)
            end
            G.jokers:emplace(card)
            return true end }))
    end,

    can_use = function(self)
        return (#G.jokers.cards) > 0 and (#G.jokers.cards < G.jokers.config.card_limit)
    end,
}

-- Deja Vu DX
SMODS.ConsumableDX{
	set = 'Spectral', atlas = 'Van_dx', key = 'c_deja_vu_dx',
    pos = {x=1,y=5},
    config = {max_highlighted = 3, extra = 'Red'},
    cost = 6,

    loc_vars = function(self, info_queue, center)
        SMODS.ConsumableDX.loc_vars(self, info_queue, center)
        info_queue[#info_queue+1] = {key = 'red_seal', set = 'Other'}
        return {}
    end,

    use = function(self, card, area, copier)
        local used_tarot = copier or card
        for i=#G.hand.highlighted, 1, -1 do
            local conv_card = G.hand.highlighted[i]
            G.E_MANAGER:add_event(Event({func = function()
                play_sound('tarot1')
                used_tarot:juice_up(0.3, 0.5)
                return true end }))
                    
            G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.1,func = function()
                conv_card:set_seal(self.config.extra, nil, true)
                return true end }))
        end
        delay(0.5)
        G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.2,func = function() G.hand:unhighlight_all(); return true end }))
    end,
}

-- Hex DX
SMODS.ConsumableDX{
	set = 'Spectral', atlas = 'Van_dx', key = 'c_hex_dx',
    pos = {x=2,y=5},
    config = {},
    cost = 6,

    loc_vars = function(self, info_queue, center)
        SMODS.ConsumableDX.loc_vars(self, info_queue, center)
        info_queue[#info_queue+1] = G.P_CENTERS.e_polychrome
        return {}
    end,

    use = function(self, card, area, copier)
        local used_tarot = copier or card
        local temp_pool = self.eligible_strength_jokers or {}
        G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
            local over = false
            local eligible_card = pseudorandom_element(temp_pool, pseudoseed('ectoplasm'))
            local edition = {polychrome = true}
            eligible_card:set_edition(edition, true)
            check_for_unlock({type = 'have_edition'})
            used_tarot:juice_up(0.3, 0.5)
        return true end }))
        delay(0.6)
    end,

    can_use = function(self)
        return next(self.eligible_strength_jokers)
    end,

    update = function(self, card, dt)
        if G.STAGE and G.STAGE == G.STAGES.RUN then
            self.eligible_strength_jokers = EMPTY(self.eligible_strength_jokers)
            for k, v in pairs(G.jokers.cards) do
                if v.ability.set == 'Joker' and (not v.edition) then
                    table.insert(self.eligible_strength_jokers, v)
                end
            end
        end
    end,
}

-- Trance DX
SMODS.ConsumableDX{
	set = 'Spectral', atlas = 'Van_dx', key = 'c_trance_dx',
    pos = {x=3,y=5},
    config = {max_highlighted = 3, extra = 'Blue'},
    cost = 6,

    loc_vars = function(self, info_queue, center)
        SMODS.ConsumableDX.loc_vars(self, info_queue, center)
        info_queue[#info_queue+1] = {key = 'blue_seal', set = 'Other'}
        return {}
    end,

    use = function(self, card, area, copier)
        local used_tarot = copier or card
        for i=#G.hand.highlighted, 1, -1 do
            local conv_card = G.hand.highlighted[i]
            G.E_MANAGER:add_event(Event({func = function()
                play_sound('tarot1')
                used_tarot:juice_up(0.3, 0.5)
                return true end }))
                    
            G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.1,func = function()
                conv_card:set_seal(self.config.extra, nil, true)
                return true end }))
        end
        delay(0.5)
        G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.2,func = function() G.hand:unhighlight_all(); return true end }))
    end,
}

-- Medium DX
SMODS.ConsumableDX{
	set = 'Spectral', atlas = 'Van_dx', key = 'c_medium_dx',
    pos = {x=4,y=5},
    config = {max_highlighted = 3, extra = 'Purple'},
    cost = 6,

    loc_vars = function(self, info_queue, center)
        SMODS.ConsumableDX.loc_vars(self, info_queue, center)
        info_queue[#info_queue+1] = {key = 'purple_seal', set = 'Other'}
        return {}
    end,

    use = function(self, card, area, copier)
        local used_tarot = copier or card
        for i=#G.hand.highlighted, 1, -1 do
            local conv_card = G.hand.highlighted[i]
            G.E_MANAGER:add_event(Event({func = function()
                play_sound('tarot1')
                used_tarot:juice_up(0.3, 0.5)
                return true end }))
                    
            G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.1,func = function()
                conv_card:set_seal(self.config.extra, nil, true)
                return true end }))
        end
        delay(0.5)
        G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.2,func = function() G.hand:unhighlight_all(); return true end }))
    end,
}

-- Cryptid DX
SMODS.ConsumableDX{
	set = 'Spectral', atlas = 'Van_dx', key = 'c_cryptid_dx',
    pos = {x=5,y=5},
    config = {extra = 4, max_highlighted = 1},
    cost = 6,

    loc_vars = function(self, info_queue, center)
        SMODS.ConsumableDX.loc_vars(self, info_queue, center)
        return {vars = {self.config.extra}}
    end,

    use = function(self, card, area, copier)
        local used_tarot = copier or card
        G.E_MANAGER:add_event(Event({
            func = function()
                local _first_dissolve = nil
                local new_cards = {}
                for i = 1, self.config.extra do
                    G.playing_card = (G.playing_card and G.playing_card + 1) or 1
                    local _card = copy_card(G.hand.highlighted[1], nil, nil, G.playing_card)
                    _card:add_to_deck()
                    G.deck.config.card_limit = G.deck.config.card_limit + 1
                    table.insert(G.playing_cards, _card)
                    G.hand:emplace(_card)
                    _card:start_materialize(nil, _first_dissolve)
                    _first_dissolve = true
                    new_cards[#new_cards+1] = _card
                end
                playing_card_joker_effects(new_cards)
                return true
            end
        })) 
    end,
}

-- The Soul DX
SMODS.ConsumableDX{
	set = 'Spectral', atlas = 'Van_dx', key = 'c_soul_dx',
    pos = {x=2,y=2},
    soul_pos = {x=0,y=1},
    config = {},
    cost = 6,
    hidden = true,
    soul_set = 'Spectral_dx',

    loc_vars = function(self, info_queue, center)
        SMODS.ConsumableDX.loc_vars(self, info_queue, center)
        return {}
    end,

    use = function(self, card, area, copier)
        local used_tarot = copier or card
        G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
            play_sound('timpani')
            local card = create_card('Joker', G.jokers, true, nil, nil, nil, nil, 'sou')
            local edition = {negative = true}
            card:set_edition(edition, true)
            card:add_to_deck()
            G.jokers:emplace(card)
            check_for_unlock{type = 'spawn_legendary'}
            used_tarot:juice_up(0.3, 0.5)
            return true end }))
        delay(0.6)
    end,

    can_use = function(self)
        return true
    end,

    set_sprites = function(self, _card, _front)
        _card.children.floating_sprite = Sprite(_card.T.x, _card.T.y, _card.T.w, _card.T.h, G.ASSET_ATLAS['centers'], _card.config.center.soul_pos)
        _card.children.floating_sprite.role.draw_major = _card
        _card.children.floating_sprite.states.hover.can = false
        _card.children.floating_sprite.states.click.can = false
    end,
}

-- Black Hole DX
SMODS.ConsumableDX{
	set = 'Spectral', atlas = 'Van_dx', key = 'c_black_hole_dx',
    pos = {x=9,y=3},
    config = {},
    cost = 6,
    hidden = true,
    soul_set = 'Planet_dx',

    loc_vars = function(self, info_queue, center)
        SMODS.ConsumableDX.loc_vars(self, info_queue, center)
        return {}
    end,

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
            level_up_hand(used_tarot, k, true, 3)
        end
        update_hand_text({sound = 'button', volume = 0.7, pitch = 1.1, delay = 0}, {mult = 0, chips = 0, handname = '', level = ''})
    end,

    can_use = function(self)
        return true
    end,
}

------------
--BOOSTERS--
------------

-- DX Boosters of a kind share everything but their sprite, price, size and shop weight
local function dx_boosters(def, variants)
    for _, variant in ipairs(variants) do
        local booster = {}
        for k, v in pairs(def) do booster[k] = v end
        for k, v in pairs(variant) do booster[k] = v end
        -- The game finds some packs by name, like vanilla ones (Astronomer: "Celestial")
        booster.name = booster.kind..' Pack DX'
        SMODS.BoosterDX(booster)
    end
end

-- Arcana Packs DX
dx_boosters({
    kind = 'Arcana', atlas = 'Van_Booster_dx',
    group_key = "k_arcana_pack",
    draw_hand = true,

    ease_background_colour = function(self) ease_background_colour_blind(G.STATES.TAROT_PACK) end,
    particles = function(self)
        G.booster_pack_sparkles = Particles(1, 1, 0,0, {
            timer = 0.015,
            scale = 0.2,
            initialize = true,
            lifespan = 1,
            speed = 1.1,
            padding = -1,
            attach = G.ROOM_ATTACH,
            colours = {G.C.WHITE, lighten(G.C.PURPLE, 0.4), lighten(G.C.PURPLE, 0.2), lighten(G.C.GOLD, 0.2)},
            fill = true
        })
        G.booster_pack_sparkles.fade_alpha = 1
        G.booster_pack_sparkles:fade(1, 0)
    end,

    create_card = function(self, card)
        -- Add an increased chance for dx card
        local dx_modifier = pseudorandom(pseudoseed('force_dx'..G.GAME.round_resets.ante)) > 0.35
        local _card
        if G.GAME.used_vouchers.v_omen_globe and pseudorandom('omen_globe') > 0.8 then
            _card = {set = (dx_modifier and "Spectral_dx" or "Spectral"), area = G.pack_cards, skip_materialize = true, soulable = true, key_append = "ardx1"}
        else
            _card = {set = (dx_modifier and "Tarot_dx" or "Tarot"), area = G.pack_cards, skip_materialize = true, soulable = true, key_append = "ardx1"}
        end
        return _card
    end,
}, {
    {key = 'p_arcana_normal_1_dx', pos = {x=0,y=0}, cost = 6, config = {extra = 4, choose = 1}, weight = 1},
    {key = 'p_arcana_normal_2_dx', pos = {x=1,y=0}, cost = 6, config = {extra = 4, choose = 1}, weight = 1, loc_key = 'p_arcana_normal_1_dx'},
    {key = 'p_arcana_normal_3_dx', pos = {x=2,y=0}, cost = 6, config = {extra = 4, choose = 1}, weight = 1, loc_key = 'p_arcana_normal_1_dx'},
    {key = 'p_arcana_normal_4_dx', pos = {x=3,y=0}, cost = 6, config = {extra = 4, choose = 1}, weight = 1, loc_key = 'p_arcana_normal_1_dx'},
    {key = 'p_arcana_jumbo_1_dx', pos = {x=0,y=2}, cost = 8, config = {extra = 6, choose = 1}, weight = 1},
    {key = 'p_arcana_jumbo_2_dx', pos = {x=1,y=2}, cost = 8, config = {extra = 6, choose = 1}, weight = 1, loc_key = 'p_arcana_jumbo_1_dx'},
    {key = 'p_arcana_mega_1_dx', pos = {x=2,y=2}, cost = 10, config = {extra = 6, choose = 2}, weight = 0.25},
    {key = 'p_arcana_mega_2_dx', pos = {x=3,y=2}, cost = 10, config = {extra = 6, choose = 2}, weight = 0.25, loc_key = 'p_arcana_mega_1_dx'},
})

-- Celestial Packs DX
dx_boosters({
    kind = 'Celestial', atlas = 'Van_Booster_dx',
    group_key = "k_celestial_pack",

    ease_background_colour = function(self) ease_background_colour_blind(G.STATES.PLANET_PACK) end,
    particles = function(self)
        G.booster_pack_stars = Particles(1, 1, 0,0, {
            timer = 0.07,
            scale = 0.1,
            initialize = true,
            lifespan = 15,
            speed = 0.1,
            padding = -4,
            attach = G.ROOM_ATTACH,
            colours = {G.C.WHITE, HEX('a7d6e0'), HEX('fddca0')},
            fill = true
        })
        G.booster_pack_meteors = Particles(1, 1, 0,0, {
            timer = 2,
            scale = 0.05,
            lifespan = 1.5,
            speed = 4,
            attach = G.ROOM_ATTACH,
            colours = {G.C.WHITE},
            fill = true
        })
    end,

    create_card = function(self, card, i)
        -- Add an increased chance for dx card
        local dx_modifier = pseudorandom(pseudoseed('force_dx'..G.GAME.round_resets.ante)) > 0.35

        if G.GAME.used_vouchers.v_telescope and i == 1 then
            local _planet, _hand, _tally = nil, nil, 0
            for k, v in ipairs(G.handlist) do
                if G.GAME.hands[v].visible and G.GAME.hands[v].played > _tally then
                    _hand = v
                    _tally = G.GAME.hands[v].played
                end
            end
            if _hand then
                for k, v in pairs(G.P_CENTER_POOLS.Planet) do
                    if v.config.hand_type == _hand then
                        _planet = v.key
                    end
                end
            end
            _card = {set = "Planet", area = G.pack_cards, skip_materialize = true, soulable = true, key = _planet, key_append = "pldx1"}
        else
            _card = {set = (dx_modifier and "Planet_dx" or "Planet"), area = G.pack_cards, skip_materialize = true, soulable = true, key_append = "pldx1"}
        end
        return _card
    end,
}, {
    {key = 'p_celestial_normal_1_dx', pos = {x=0,y=1}, cost = 6, config = {extra = 4, choose = 1}, weight = 1},
    {key = 'p_celestial_normal_2_dx', pos = {x=1,y=1}, cost = 6, config = {extra = 4, choose = 1}, weight = 1, loc_key = 'p_celestial_normal_1_dx'},
    {key = 'p_celestial_normal_3_dx', pos = {x=2,y=1}, cost = 6, config = {extra = 4, choose = 1}, weight = 1, loc_key = 'p_celestial_normal_1_dx'},
    {key = 'p_celestial_normal_4_dx', pos = {x=3,y=1}, cost = 6, config = {extra = 4, choose = 1}, weight = 1, loc_key = 'p_celestial_normal_1_dx'},
    {key = 'p_celestial_jumbo_1_dx', pos = {x=0,y=3}, cost = 8, config = {extra = 6, choose = 1}, weight = 1},
    {key = 'p_celestial_jumbo_2_dx', pos = {x=1,y=3}, cost = 8, config = {extra = 6, choose = 1}, weight = 1, loc_key = 'p_celestial_jumbo_1_dx'},
    {key = 'p_celestial_mega_1_dx', pos = {x=2,y=3}, cost = 10, config = {extra = 6, choose = 2}, weight = 0.25},
    {key = 'p_celestial_mega_2_dx', pos = {x=3,y=3}, cost = 10, config = {extra = 6, choose = 2}, weight = 0.25, loc_key = 'p_celestial_mega_1_dx'},
})

-- Spectral Packs DX
dx_boosters({
    kind = 'Spectral', atlas = 'Van_Booster_dx',
    group_key = "k_spectral_pack",
    draw_hand = true,

    ease_background_colour = function(self) ease_background_colour_blind(G.STATES.SPECTRAL_PACK) end,
    particles = function(self)
        G.booster_pack_sparkles = Particles(1, 1, 0,0, {
            timer = 0.015,
            scale = 0.1,
            initialize = true,
            lifespan = 3,
            speed = 0.2,
            padding = -1,
            attach = G.ROOM_ATTACH,
            colours = {G.C.WHITE, lighten(G.C.GOLD, 0.2)},
            fill = true
        })
        G.booster_pack_sparkles.fade_alpha = 1
        G.booster_pack_sparkles:fade(1, 0)
    end,

    create_card = function(self, card, i)
        -- Add an increased chance for dx card
        local dx_modifier = pseudorandom(pseudoseed('force_dx'..G.GAME.round_resets.ante)) > 0.35

        local _card = create_card(dx_modifier and "Spectral_dx" or "Spectral", G.pack_cards, nil, nil, true, true, nil, 'spedx')
        return _card
    end,
}, {
    {key = 'p_spectral_normal_1_dx', pos = {x=0,y=4}, cost = 6, config = {extra = 3, choose = 1}, weight = 0.3},
    {key = 'p_spectral_normal_2_dx', pos = {x=1,y=4}, cost = 6, config = {extra = 3, choose = 1}, weight = 0.3, loc_key = 'p_spectral_normal_1_dx'},
    {key = 'p_spectral_jumbo_1_dx', pos = {x=2,y=4}, cost = 8, config = {extra = 5, choose = 1}, weight = 0.3},
    {key = 'p_spectral_mega_1_dx', pos = {x=2,y=4}, cost = 8, config = {extra = 5, choose = 2}, weight = 0.07},
})

-- Standard Packs DX
dx_boosters({
    kind = 'Standard', atlas = 'Van_Booster_dx',
    group_key = "k_standard_pack",

    ease_background_colour = function(self) ease_background_colour_blind(G.STATES.STANDARD_PACK) end,
    particles = function(self)
        G.booster_pack_sparkles = Particles(1, 1, 0,0, {
            timer = 0.015,
            scale = 0.3,
            initialize = true,
            lifespan = 3,
            speed = 0.2,
            padding = -1,
            attach = G.ROOM_ATTACH,
            colours = {G.C.BLACK, G.C.RED},
            fill = true
        })
        G.booster_pack_sparkles.fade_alpha = 1
        G.booster_pack_sparkles:fade(1, 0)
    end,

    create_card = function(self, card, i)
        local dx_modifier = pseudorandom(pseudoseed('force_dx'..G.GAME.round_resets.ante)) > 0.35
        local edition_rate = dx_modifier and 6 or 3
        local _edition = poll_edition('standard_edition'..G.GAME.round_resets.ante, edition_rate, true)
        local seal_rate = dx_modifier and 30 or 15
        local _seal = SMODS.poll_seal({mod = seal_rate})
        local _card = {set = "Enhanced", edition = _edition, seal = _seal, area = G.pack_cards, skip_materialize = true, soulable = true, key_append = "stadx"}

        return _card
    end,
}, {
    {key = 'p_standard_normal_1_dx', pos = {x=0,y=6}, cost = 6, config = {extra = 4, choose = 1}, weight = 1},
    {key = 'p_standard_normal_2_dx', pos = {x=1,y=6}, cost = 6, config = {extra = 4, choose = 1}, weight = 1, loc_key = 'p_standard_normal_1_dx'},
    {key = 'p_standard_normal_3_dx', pos = {x=2,y=6}, cost = 6, config = {extra = 4, choose = 1}, weight = 1, loc_key = 'p_standard_normal_1_dx'},
    {key = 'p_standard_normal_4_dx', pos = {x=3,y=6}, cost = 6, config = {extra = 4, choose = 1}, weight = 1, loc_key = 'p_standard_normal_1_dx'},
    {key = 'p_standard_jumbo_1_dx', pos = {x=0,y=7}, cost = 8, config = {extra = 6, choose = 1}, weight = 1},
    {key = 'p_standard_jumbo_2_dx', pos = {x=1,y=7}, cost = 8, config = {extra = 6, choose = 1}, weight = 1, loc_key = 'p_standard_jumbo_1_dx'},
    {key = 'p_standard_mega_1_dx', pos = {x=2,y=7}, cost = 10, config = {extra = 6, choose = 2}, weight = 0.25},
    {key = 'p_standard_mega_2_dx', pos = {x=3,y=7}, cost = 10, config = {extra = 6, choose = 2}, weight = 0.25, loc_key = 'p_standard_mega_1_dx'},
})

-- Buffoon Packs DX
dx_boosters({
    kind = 'Buffoon', atlas = 'Van_Booster_dx',
    group_key = "k_buffoon_pack",

    ease_background_colour = function(self) ease_background_colour_blind(G.STATES.BUFFOON_PACK) end,

    create_card = function(self, card)
        local dx_modifier = pseudorandom(pseudoseed('force_dx'..G.GAME.round_resets.ante)) > 0.35
        local edition_rate = dx_modifier and 3 or 1.5
        local _edition = poll_edition('standard_edition'..G.GAME.round_resets.ante, edition_rate, true)
        local _rarity = pseudorandom('rarity'..G.GAME.round_resets.ante..(_append or '')) + (dx_modifier and 0.3 or 0)
        local _card = {set = "Joker", edition = _edition, rarity = _rarity, area = G.pack_cards, skip_materialize = true, soulable = true, key_append = "bufdx"}

        return _card
    end,
}, {
    {key = 'p_buffoon_normal_1_dx', pos = {x=0,y=8}, cost = 6, config = {extra = 3, choose = 1}, weight = 0.6},
    {key = 'p_buffoon_normal_2_dx', pos = {x=1,y=8}, cost = 6, config = {extra = 3, choose = 1}, weight = 0.6, loc_key = 'p_buffoon_normal_1_dx'},
    {key = 'p_buffoon_jumbo_1_dx', pos = {x=2,y=8}, cost = 8, config = {extra = 5, choose = 1}, weight = 0.6},
    {key = 'p_buffoon_mega_1_dx', pos = {x=3,y=8}, cost = 10, config = {extra = 5, choose = 2}, weight = 0.15},
})
