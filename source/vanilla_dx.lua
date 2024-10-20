----------
--TAROTS--
----------

-- The Fool DX
SMODS.ConsumableDX{
	set = 'Tarot', atlas = 'Van_dx', key = 'c_fool_dx',
	loc_txt = {
        name = "The Fool DX",
        text = {
            "Creates up to {C:attention}2{} copies of",
            "the last {C:tarot}Tarot{} or {C:planet}Planet{}",
            "card used during this run",
            "{s:0.8,C:tarot}The Fool{s:0.8} excluded"
        }
    },
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
	loc_txt = {
        name = "The Magician DX",
        text = {
            "Enhances {C:attention}#1#{}",
            "selected cards to",
            "{C:attention}#2#s"
        }
    },
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
	loc_txt = {
        name = "The High Priestess DX",
        text = {
            "Creates up to {C:attention}#1#",
            "random {C:planet}Planet{} {C:dark_edition}DX{} cards",
            "{C:inactive}(Must have room)"
        }
    },
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
	loc_txt = {
        name = "The Empress DX",
        text = {
            "Enhances {C:attention}#1#",
            "selected cards to",
            "{C:attention}#2#s"
        }
    },
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
	loc_txt = {
        name = "The Emperor DX",
        text = {
            "Creates up to {C:attention}#1#",
            "random {C:tarot}Tarot{} {C:dark_edition}DX{} cards",
            "{C:inactive}(Must have room)"
        }
    },
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
	loc_txt = {
        name = "The Hierophant DX",
        text = {
            "Enhances up to {C:attention}#1#",
            "selected cards to",
            "{C:attention}#2#s"
        }
    },
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
	loc_txt = {
        name = "The Lovers DX",
        text = {
            "Enhances {C:attention}#1#{} selected",
            "cards into",
            "{C:attention}#2#s"
        }
    },
    pos = {x=6,y=0},
    config = {mod_conv = 'm_wild', max_highlighted = 2},

    loc_vars = function(self, info_queue, center)
        SMODS.ConsumableDX.loc_vars(self, info_queue, center)
        info_queue[#info_queue+1] = G.P_CENTERS[self.config.mod_conv]
        return {vars = {self.config.max_highlighted, localize{type = 'name_text', set = 'Enhanced', key = self.config.mod_conv}}}
    end,
}

-- The Chariot DX
SMODS.ConsumableDX{
	set = 'Tarot', atlas = 'Van_dx', key = 'c_chariot_dx',
	loc_txt = {
        name = "The Chariot DX",
        text = {
            "Enhances {C:attention}#1#{} selected",
            "cards into",
            "{C:attention}#2#s"
        }
    },
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
	loc_txt = {
        name = "Justice DX",
        text = {
            "Enhances {C:attention}#1#{} selected",
            "cards into",
            "{C:attention}#2#s"
        }
    },
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
	loc_txt = {
        name = "The Hermit DX",
        text = {
            "Triples money",
            "{C:inactive}(Max of {C:money}$#1#{C:inactive})"
        }
    },
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
            ease_dollars(math.max(0,math.min(G.GAME.dollars * 2, self.config.extra)), true)
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
	loc_txt = {
        name = "The Wheel of Fortune DX",
        text = {
            "{C:green}#1# in #2#{} chance to add",
            "{C:dark_edition}Foil{}, {C:dark_edition}Holographic{}, or",
            "{C:dark_edition}Polychrome{} edition",
            "to a random {C:attention}Joker"
        }
    },
    pos = {x=0,y=1},
    config = {extra = 2},

    loc_vars = function(self, info_queue, center)
        SMODS.ConsumableDX.loc_vars(self, info_queue, center)
        info_queue[#info_queue+1] = G.P_CENTERS.e_foil
        info_queue[#info_queue+1] = G.P_CENTERS.e_holo
        info_queue[#info_queue+1] = G.P_CENTERS.e_polychrome
        return {vars = {G.GAME.probabilities.normal, self.config.extra}}
    end,

    use = function(self, card, area, copier)
        local used_tarot = copier or card
        local temp_pool = self.eligible_strength_jokers or {}
        if pseudorandom('wheel_of_fortune') < G.GAME.probabilities.normal/self.config.extra then 
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
        self.eligible_strength_jokers = EMPTY(self.eligible_strength_jokers)
        for k, v in pairs(G.jokers.cards) do
            if v.ability.set == 'Joker' and (not v.edition) then
                table.insert(self.eligible_strength_jokers, v)
            end
        end
    end,
}

-- Strength DX
SMODS.ConsumableDX{
	set = 'Tarot', atlas = 'Van_dx', key = 'c_strength_dx',
	loc_txt = {
        name = "Strength DX",
        text = {
            "Increases rank of",
            "up to {C:attention}#1#{} selected",
            "cards by {C:attention}1"
        }
    },
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
	loc_txt = {
        name = "The Hanged Man DX",
        text = {
            "Destroys up to",
            "{C:attention}#1#{} selected cards"
        }
    },
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
                for i=#G.hand.highlighted, 1, -1 do
                    local card = G.hand.highlighted[i]
                    if card.ability.name == 'Glass Card' then 
                        card:shatter()
                    else
                        card:start_dissolve(nil, i == #G.hand.highlighted)
                    end
                end
                for i = 1, #G.jokers.cards do
                    G.jokers.cards[i]:calculate_joker({remove_playing_cards = true, removed = destroyed_cards, name = 'The Hanged Man DX'})
                end
                return true end }))
        delay(0.3)
    end,
}

-- Death DX
SMODS.ConsumableDX{
	set = 'Tarot', atlas = 'Van_dx', key = 'c_death_dx',
	loc_txt = {
        name = "Death DX",
        text = {
            "Select {C:attention}#1#{} cards,",
            "convert the {C:attention}left{} cards",
            "into the {C:attention}right{} card",
            "{C:inactive}(Drag to rearrange)"
        }
    },
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
	loc_txt = {
        name = "Temperance DX",
        text = {
            "Gives double the total sell",
            "value of all current",
            "Jokers {C:inactive}(Max of {C:money}$#1#{C:inactive})",
            "{C:inactive}(Currently {C:money}$#2#{C:inactive})"
        }
    },
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
	loc_txt = {
        name = "The Devil DX",
        text = {
            "Enhances {C:attention}#1#{} selected",
            "cards into",
            "{C:attention}#2#s"
        }
    },
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
	loc_txt = {
        name = "The Tower DX",
        text = {
            "Enhances {C:attention}#1#{} selected",
            "cards into",
            "{C:attention}#2#s"
        }
    },
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
	loc_txt = {
        name = "The Star DX",
        text = {
            "Converts up to",
            "{C:attention}#1#{} selected cards",
            "to {V:1}#2#{}"
        }
    },
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
	loc_txt = {
        name = "The Moon DX",
        text = {
            "Converts up to",
            "{C:attention}#1#{} selected cards",
            "to {V:1}#2#{}"
        }
    },
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
	loc_txt = {
        name = "The Sun DX",
        text = {
            "Converts up to",
            "{C:attention}#1#{} selected cards",
            "to {V:1}#2#{}"
        }
    },
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
	loc_txt = {
        name = "Judgement DX",
        text = {
            "Creates a random",
            "{C:green}uncommon{} {C:attention}Joker{} card",
            "{C:inactive}(Must have room)"
        }
    },
    pos = {x=0,y=2},

    loc_vars = function(self, info_queue, center)
        SMODS.ConsumableDX.loc_vars(self, info_queue, center)
        return {vars = {self.config.tarots}}
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
	loc_txt = {
        name = "The World DX",
        text = {
            "Converts up to",
            "{C:attention}#1#{} selected cards",
            "to {V:1}#2#{}"
        }
    },
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