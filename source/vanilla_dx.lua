local js_mod = SMODS.current_mod
local js_config = assert(NFS.load(js_mod.path..'config.lua')())--js_mod.config

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

    set_card_type_badge = function(self, card, badges)
        badges[1] = create_badge(localize('k_tarot'), get_type_colour(self or card.config, card), nil, 1.2)
        SMODS.ConsumableDX.set_card_type_badge(self, card, badges)
    end,

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

    set_card_type_badge = function(self, card, badges)
        badges[1] = create_badge(localize('k_tarot'), get_type_colour(self or card.config, card), nil, 1.2)
        SMODS.ConsumableDX.set_card_type_badge(self, card, badges)
    end,

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

    set_card_type_badge = function(self, card, badges)
        badges[1] = create_badge(localize('k_tarot'), get_type_colour(self or card.config, card), nil, 1.2)
        SMODS.ConsumableDX.set_card_type_badge(self, card, badges)
    end,

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

    set_card_type_badge = function(self, card, badges)
        badges[1] = create_badge(localize('k_tarot'), get_type_colour(self or card.config, card), nil, 1.2)
        SMODS.ConsumableDX.set_card_type_badge(self, card, badges)
    end,

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

    set_card_type_badge = function(self, card, badges)
        badges[1] = create_badge(localize('k_tarot'), get_type_colour(self or card.config, card), nil, 1.2)
        SMODS.ConsumableDX.set_card_type_badge(self, card, badges)
    end,

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

    set_card_type_badge = function(self, card, badges)
        badges[1] = create_badge(localize('k_tarot'), get_type_colour(self or card.config, card), nil, 1.2)
        SMODS.ConsumableDX.set_card_type_badge(self, card, badges)
    end,

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
    config = {mod_conv = 'm_wild', max_highlighted = 4},

    set_card_type_badge = function(self, card, badges)
        badges[1] = create_badge(localize('k_tarot'), get_type_colour(self or card.config, card), nil, 1.2)
        SMODS.ConsumableDX.set_card_type_badge(self, card, badges)
    end,

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

    set_card_type_badge = function(self, card, badges)
        badges[1] = create_badge(localize('k_tarot'), get_type_colour(self or card.config, card), nil, 1.2)
        SMODS.ConsumableDX.set_card_type_badge(self, card, badges)
    end,

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

    set_card_type_badge = function(self, card, badges)
        badges[1] = create_badge(localize('k_tarot'), get_type_colour(self or card.config, card), nil, 1.2)
        SMODS.ConsumableDX.set_card_type_badge(self, card, badges)
    end,

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

    set_card_type_badge = function(self, card, badges)
        badges[1] = create_badge(localize('k_tarot'), get_type_colour(self or card.config, card), nil, 1.2)
        SMODS.ConsumableDX.set_card_type_badge(self, card, badges)
    end,

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

    set_card_type_badge = function(self, card, badges)
        badges[1] = create_badge(localize('k_tarot'), get_type_colour(self or card.config, card), nil, 1.2)
        SMODS.ConsumableDX.set_card_type_badge(self, card, badges)
    end,

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

    set_card_type_badge = function(self, card, badges)
        badges[1] = create_badge(localize('k_tarot'), get_type_colour(self or card.config, card), nil, 1.2)
        SMODS.ConsumableDX.set_card_type_badge(self, card, badges)
    end,

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

    set_card_type_badge = function(self, card, badges)
        badges[1] = create_badge(localize('k_tarot'), get_type_colour(self or card.config, card), nil, 1.2)
        SMODS.ConsumableDX.set_card_type_badge(self, card, badges)
    end,

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

    set_card_type_badge = function(self, card, badges)
        badges[1] = create_badge(localize('k_tarot'), get_type_colour(self or card.config, card), nil, 1.2)
        SMODS.ConsumableDX.set_card_type_badge(self, card, badges)
    end,

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

    set_card_type_badge = function(self, card, badges)
        badges[1] = create_badge(localize('k_tarot'), get_type_colour(self or card.config, card), nil, 1.2)
        SMODS.ConsumableDX.set_card_type_badge(self, card, badges)
    end,

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

    set_card_type_badge = function(self, card, badges)
        badges[1] = create_badge(localize('k_tarot'), get_type_colour(self or card.config, card), nil, 1.2)
        SMODS.ConsumableDX.set_card_type_badge(self, card, badges)
    end,

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

    set_card_type_badge = function(self, card, badges)
        badges[1] = create_badge(localize('k_tarot'), get_type_colour(self or card.config, card), nil, 1.2)
        SMODS.ConsumableDX.set_card_type_badge(self, card, badges)
    end,

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

    set_card_type_badge = function(self, card, badges)
        badges[1] = create_badge(localize('k_tarot'), get_type_colour(self or card.config, card), nil, 1.2)
        SMODS.ConsumableDX.set_card_type_badge(self, card, badges)
    end,

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

    set_card_type_badge = function(self, card, badges)
        badges[1] = create_badge(localize('k_tarot'), get_type_colour(self or card.config, card), nil, 1.2)
        SMODS.ConsumableDX.set_card_type_badge(self, card, badges)
    end,

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

    set_card_type_badge = function(self, card, badges)
        badges[1] = create_badge(localize('k_tarot'), get_type_colour(self or card.config, card), nil, 1.2)
        SMODS.ConsumableDX.set_card_type_badge(self, card, badges)
    end,

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

    set_card_type_badge = function(self, card, badges)
        badges[1] = create_badge(localize('k_tarot'), get_type_colour(self or card.config, card), nil, 1.2)
        SMODS.ConsumableDX.set_card_type_badge(self, card, badges)
    end,

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

    set_card_type_badge = function(self, card, badges)
        badges[1] = create_badge(localize('k_tarot'), get_type_colour(self or card.config, card), nil, 1.2)
        SMODS.ConsumableDX.set_card_type_badge(self, card, badges)
    end,

    loc_vars = function(self, info_queue, center)
        SMODS.ConsumableDX.loc_vars(self, info_queue, center)
        return {vars = {self.config.max_highlighted, localize(self.config.suit_conv, 'suits_plural'), colours = {G.C.SUITS[self.config.suit_conv]}}}
    end,
}

-----------
--PLANETS--
-----------


-- Mercury DX
SMODS.ConsumableDX{
	set = 'Planet', atlas = 'Van_dx', key = 'c_mercury_dx',
	loc_txt = {
        name = "Mercury DX",
        text = {
            "{s:0.8}({s:0.8,V:1}lvl.#1#{s:0.8}){} Level up {C:dark_edition}x2{}",
            "{C:attention}#2#",
            "{C:mult}+#3#{} Mult and",
            "{C:chips}+#4#{} chips"
        }
    },
    pos = {x=0,y=3},
    config = {hand_type = 'Pair'},

    loc_vars = function(self, info_queue, center)
        SMODS.ConsumableDX.loc_vars(self, info_queue, center)
        local loc_vars = {
            G.GAME.hands[self.config.hand_type].level, localize(self.config.hand_type, 'poker_hands'), G.GAME.hands[self.config.hand_type].l_mult * 2, G.GAME.hands[self.config.hand_type].l_chips * 2,
            colours = {(G.GAME.hands[self.config.hand_type].level==1 and G.C.UI.TEXT_DARK or G.C.HAND_LEVELS[math.min(7, G.GAME.hands[self.config.hand_type].level)])}
        }
        return {vars = loc_vars}
    end,

    set_card_type_badge = function(self, card, badges)
        badges[1] = create_badge(localize('k_planet'), get_type_colour(self or card.config, card), nil, 1.2)
        SMODS.ConsumableDX.set_card_type_badge(self, card, badges)
    end,

    use = function(self, card, area, copier)
        local used_tarot = copier or card
        update_hand_text({sound = 'button', volume = 0.7, pitch = 0.8, delay = 0.3}, {handname=localize(self.config.hand_type, 'poker_hands'),chips = G.GAME.hands[self.config.hand_type].chips, mult = G.GAME.hands[self.config.hand_type].mult, level=G.GAME.hands[self.config.hand_type].level})
        level_up_hand(used_tarot, self.config.hand_type, false, 2)
        update_hand_text({sound = 'button', volume = 0.7, pitch = 1.1, delay = 0}, {mult = 0, chips = 0, handname = '', level = ''})
    end,
}

-- Venus DX
SMODS.ConsumableDX{
	set = 'Planet', atlas = 'Van_dx', key = 'c_venus_dx',
	loc_txt = {
        name = "Venus DX",
        text = {
            "{s:0.8}({s:0.8,V:1}lvl.#1#{s:0.8}){} Level up {C:dark_edition}x2{}",
            "{C:attention}#2#",
            "{C:mult}+#3#{} Mult and",
            "{C:chips}+#4#{} chips"
        }
    },
    pos = {x=1,y=3},
    config = {hand_type = 'Three of a Kind'},

    loc_vars = function(self, info_queue, center)
        SMODS.ConsumableDX.loc_vars(self, info_queue, center)
        local loc_vars = {
            G.GAME.hands[self.config.hand_type].level, localize(self.config.hand_type, 'poker_hands'), G.GAME.hands[self.config.hand_type].l_mult * 2, G.GAME.hands[self.config.hand_type].l_chips * 2,
            colours = {(G.GAME.hands[self.config.hand_type].level==1 and G.C.UI.TEXT_DARK or G.C.HAND_LEVELS[math.min(7, G.GAME.hands[self.config.hand_type].level)])}
        }
        return {vars = loc_vars}
    end,

    set_card_type_badge = function(self, card, badges)
        badges[1] = create_badge(localize('k_planet'), get_type_colour(self or card.config, card), nil, 1.2)
        SMODS.ConsumableDX.set_card_type_badge(self, card, badges)
    end,

    use = function(self, card, area, copier)
        local used_tarot = copier or card
        update_hand_text({sound = 'button', volume = 0.7, pitch = 0.8, delay = 0.3}, {handname=localize(self.config.hand_type, 'poker_hands'),chips = G.GAME.hands[self.config.hand_type].chips, mult = G.GAME.hands[self.config.hand_type].mult, level=G.GAME.hands[self.config.hand_type].level})
        level_up_hand(used_tarot, self.config.hand_type, false, 2)
        update_hand_text({sound = 'button', volume = 0.7, pitch = 1.1, delay = 0}, {mult = 0, chips = 0, handname = '', level = ''})
    end,
}

-- Earth DX
SMODS.ConsumableDX{
	set = 'Planet', atlas = 'Van_dx', key = 'c_earth_dx',
	loc_txt = {
        name = "Earth DX",
        text = {
            "{s:0.8}({s:0.8,V:1}lvl.#1#{s:0.8}){} Level up {C:dark_edition}x2{}",
            "{C:attention}#2#",
            "{C:mult}+#3#{} Mult and",
            "{C:chips}+#4#{} chips"
        }
    },
    pos = {x=2,y=3},
    config = {hand_type = 'Full House'},

    loc_vars = function(self, info_queue, center)
        SMODS.ConsumableDX.loc_vars(self, info_queue, center)
        local loc_vars = {
            G.GAME.hands[self.config.hand_type].level, localize(self.config.hand_type, 'poker_hands'), G.GAME.hands[self.config.hand_type].l_mult * 2, G.GAME.hands[self.config.hand_type].l_chips * 2,
            colours = {(G.GAME.hands[self.config.hand_type].level==1 and G.C.UI.TEXT_DARK or G.C.HAND_LEVELS[math.min(7, G.GAME.hands[self.config.hand_type].level)])}
        }
        return {vars = loc_vars}
    end,

    set_card_type_badge = function(self, card, badges)
        badges[1] = create_badge(localize('k_planet'), get_type_colour(self or card.config, card), nil, 1.2)
        SMODS.ConsumableDX.set_card_type_badge(self, card, badges)
    end,

    use = function(self, card, area, copier)
        local used_tarot = copier or card
        update_hand_text({sound = 'button', volume = 0.7, pitch = 0.8, delay = 0.3}, {handname=localize(self.config.hand_type, 'poker_hands'),chips = G.GAME.hands[self.config.hand_type].chips, mult = G.GAME.hands[self.config.hand_type].mult, level=G.GAME.hands[self.config.hand_type].level})
        level_up_hand(used_tarot, self.config.hand_type, false, 2)
        update_hand_text({sound = 'button', volume = 0.7, pitch = 1.1, delay = 0}, {mult = 0, chips = 0, handname = '', level = ''})
    end,
}

-- Mars DX
SMODS.ConsumableDX{
	set = 'Planet', atlas = 'Van_dx', key = 'c_mars_dx',
	loc_txt = {
        name = "Mars DX",
        text = {
            "{s:0.8}({s:0.8,V:1}lvl.#1#{s:0.8}){} Level up {C:dark_edition}x2{}",
            "{C:attention}#2#",
            "{C:mult}+#3#{} Mult and",
            "{C:chips}+#4#{} chips"
        }
    },
    pos = {x=3,y=3},
    config = {hand_type = 'Four of a Kind'},

    loc_vars = function(self, info_queue, center)
        SMODS.ConsumableDX.loc_vars(self, info_queue, center)
        local loc_vars = {
            G.GAME.hands[self.config.hand_type].level, localize(self.config.hand_type, 'poker_hands'), G.GAME.hands[self.config.hand_type].l_mult * 2, G.GAME.hands[self.config.hand_type].l_chips * 2,
            colours = {(G.GAME.hands[self.config.hand_type].level==1 and G.C.UI.TEXT_DARK or G.C.HAND_LEVELS[math.min(7, G.GAME.hands[self.config.hand_type].level)])}
        }
        return {vars = loc_vars}
    end,

    set_card_type_badge = function(self, card, badges)
        badges[1] = create_badge(localize('k_planet'), get_type_colour(self or card.config, card), nil, 1.2)
        SMODS.ConsumableDX.set_card_type_badge(self, card, badges)
    end,

    use = function(self, card, area, copier)
        local used_tarot = copier or card
        update_hand_text({sound = 'button', volume = 0.7, pitch = 0.8, delay = 0.3}, {handname=localize(self.config.hand_type, 'poker_hands'),chips = G.GAME.hands[self.config.hand_type].chips, mult = G.GAME.hands[self.config.hand_type].mult, level=G.GAME.hands[self.config.hand_type].level})
        level_up_hand(used_tarot, self.config.hand_type, false, 2)
        update_hand_text({sound = 'button', volume = 0.7, pitch = 1.1, delay = 0}, {mult = 0, chips = 0, handname = '', level = ''})
    end,
}

-- Jupiter DX
SMODS.ConsumableDX{
	set = 'Planet', atlas = 'Van_dx', key = 'c_jupiter_dx',
	loc_txt = {
        name = "Jupiter DX",
        text = {
            "{s:0.8}({s:0.8,V:1}lvl.#1#{s:0.8}){} Level up {C:dark_edition}x2{}",
            "{C:attention}#2#",
            "{C:mult}+#3#{} Mult and",
            "{C:chips}+#4#{} chips"
        }
    },
    pos = {x=4,y=3},
    config = {hand_type = 'Flush'},

    loc_vars = function(self, info_queue, center)
        SMODS.ConsumableDX.loc_vars(self, info_queue, center)
        local loc_vars = {
            G.GAME.hands[self.config.hand_type].level, localize(self.config.hand_type, 'poker_hands'), G.GAME.hands[self.config.hand_type].l_mult * 2, G.GAME.hands[self.config.hand_type].l_chips * 2,
            colours = {(G.GAME.hands[self.config.hand_type].level==1 and G.C.UI.TEXT_DARK or G.C.HAND_LEVELS[math.min(7, G.GAME.hands[self.config.hand_type].level)])}
        }
        return {vars = loc_vars}
    end,

    set_card_type_badge = function(self, card, badges)
        badges[1] = create_badge(localize('k_planet'), get_type_colour(self or card.config, card), nil, 1.2)
        SMODS.ConsumableDX.set_card_type_badge(self, card, badges)
    end,

    use = function(self, card, area, copier)
        local used_tarot = copier or card
        update_hand_text({sound = 'button', volume = 0.7, pitch = 0.8, delay = 0.3}, {handname=localize(self.config.hand_type, 'poker_hands'),chips = G.GAME.hands[self.config.hand_type].chips, mult = G.GAME.hands[self.config.hand_type].mult, level=G.GAME.hands[self.config.hand_type].level})
        level_up_hand(used_tarot, self.config.hand_type, false, 2)
        update_hand_text({sound = 'button', volume = 0.7, pitch = 1.1, delay = 0}, {mult = 0, chips = 0, handname = '', level = ''})
    end,
}

-- Saturn DX
SMODS.ConsumableDX{
	set = 'Planet', atlas = 'Van_dx', key = 'c_saturn_dx',
	loc_txt = {
        name = "Saturn DX",
        text = {
            "{s:0.8}({s:0.8,V:1}lvl.#1#{s:0.8}){} Level up {C:dark_edition}x2{}",
            "{C:attention}#2#",
            "{C:mult}+#3#{} Mult and",
            "{C:chips}+#4#{} chips"
        }
    },
    pos = {x=5,y=3},
    config = {hand_type = 'Straight'},

    loc_vars = function(self, info_queue, center)
        SMODS.ConsumableDX.loc_vars(self, info_queue, center)
        local loc_vars = {
            G.GAME.hands[self.config.hand_type].level, localize(self.config.hand_type, 'poker_hands'), G.GAME.hands[self.config.hand_type].l_mult * 2, G.GAME.hands[self.config.hand_type].l_chips * 2,
            colours = {(G.GAME.hands[self.config.hand_type].level==1 and G.C.UI.TEXT_DARK or G.C.HAND_LEVELS[math.min(7, G.GAME.hands[self.config.hand_type].level)])}
        }
        return {vars = loc_vars}
    end,

    set_card_type_badge = function(self, card, badges)
        badges[1] = create_badge(localize('k_planet'), get_type_colour(self or card.config, card), nil, 1.2)
        SMODS.ConsumableDX.set_card_type_badge(self, card, badges)
    end,

    use = function(self, card, area, copier)
        local used_tarot = copier or card
        update_hand_text({sound = 'button', volume = 0.7, pitch = 0.8, delay = 0.3}, {handname=localize(self.config.hand_type, 'poker_hands'),chips = G.GAME.hands[self.config.hand_type].chips, mult = G.GAME.hands[self.config.hand_type].mult, level=G.GAME.hands[self.config.hand_type].level})
        level_up_hand(used_tarot, self.config.hand_type, false, 2)
        update_hand_text({sound = 'button', volume = 0.7, pitch = 1.1, delay = 0}, {mult = 0, chips = 0, handname = '', level = ''})
    end,
}

-- Uranus DX
SMODS.ConsumableDX{
	set = 'Planet', atlas = 'Van_dx', key = 'c_uranus_dx',
	loc_txt = {
        name = "Uranus DX",
        text = {
            "{s:0.8}({s:0.8,V:1}lvl.#1#{s:0.8}){} Level up {C:dark_edition}x2{}",
            "{C:attention}#2#",
            "{C:mult}+#3#{} Mult and",
            "{C:chips}+#4#{} chips"
        }
    },
    pos = {x=6,y=3},
    config = {hand_type = 'Two Pair'},

    loc_vars = function(self, info_queue, center)
        SMODS.ConsumableDX.loc_vars(self, info_queue, center)
        local loc_vars = {
            G.GAME.hands[self.config.hand_type].level, localize(self.config.hand_type, 'poker_hands'), G.GAME.hands[self.config.hand_type].l_mult * 2, G.GAME.hands[self.config.hand_type].l_chips * 2,
            colours = {(G.GAME.hands[self.config.hand_type].level==1 and G.C.UI.TEXT_DARK or G.C.HAND_LEVELS[math.min(7, G.GAME.hands[self.config.hand_type].level)])}
        }
        return {vars = loc_vars}
    end,

    set_card_type_badge = function(self, card, badges)
        badges[1] = create_badge(localize('k_planet'), get_type_colour(self or card.config, card), nil, 1.2)
        SMODS.ConsumableDX.set_card_type_badge(self, card, badges)
    end,

    use = function(self, card, area, copier)
        local used_tarot = copier or card
        update_hand_text({sound = 'button', volume = 0.7, pitch = 0.8, delay = 0.3}, {handname=localize(self.config.hand_type, 'poker_hands'),chips = G.GAME.hands[self.config.hand_type].chips, mult = G.GAME.hands[self.config.hand_type].mult, level=G.GAME.hands[self.config.hand_type].level})
        level_up_hand(used_tarot, self.config.hand_type, false, 2)
        update_hand_text({sound = 'button', volume = 0.7, pitch = 1.1, delay = 0}, {mult = 0, chips = 0, handname = '', level = ''})
    end,
}

-- Neptune DX
SMODS.ConsumableDX{
	set = 'Planet', atlas = 'Van_dx', key = 'c_neptune_dx',
	loc_txt = {
        name = "Neptune DX",
        text = {
            "{s:0.8}({s:0.8,V:1}lvl.#1#{s:0.8}){} Level up {C:dark_edition}x2{}",
            "{C:attention}#2#",
            "{C:mult}+#3#{} Mult and",
            "{C:chips}+#4#{} chips"
        }
    },
    pos = {x=7,y=3},
    config = {hand_type = 'Straight Flush'},

    loc_vars = function(self, info_queue, center)
        SMODS.ConsumableDX.loc_vars(self, info_queue, center)
        local loc_vars = {
            G.GAME.hands[self.config.hand_type].level, localize(self.config.hand_type, 'poker_hands'), G.GAME.hands[self.config.hand_type].l_mult * 2, G.GAME.hands[self.config.hand_type].l_chips * 2,
            colours = {(G.GAME.hands[self.config.hand_type].level==1 and G.C.UI.TEXT_DARK or G.C.HAND_LEVELS[math.min(7, G.GAME.hands[self.config.hand_type].level)])}
        }
        return {vars = loc_vars}
    end,

    set_card_type_badge = function(self, card, badges)
        badges[1] = create_badge(localize('k_planet'), get_type_colour(self or card.config, card), nil, 1.2)
        SMODS.ConsumableDX.set_card_type_badge(self, card, badges)
    end,

    use = function(self, card, area, copier)
        local used_tarot = copier or card
        update_hand_text({sound = 'button', volume = 0.7, pitch = 0.8, delay = 0.3}, {handname=localize(self.config.hand_type, 'poker_hands'),chips = G.GAME.hands[self.config.hand_type].chips, mult = G.GAME.hands[self.config.hand_type].mult, level=G.GAME.hands[self.config.hand_type].level})
        level_up_hand(used_tarot, self.config.hand_type, false, 2)
        update_hand_text({sound = 'button', volume = 0.7, pitch = 1.1, delay = 0}, {mult = 0, chips = 0, handname = '', level = ''})
    end,
}

-- Pluto DX
SMODS.ConsumableDX{
	set = 'Planet', atlas = 'Van_dx', key = 'c_pluto_dx',
	loc_txt = {
        name = "Pluto DX",
        text = {
            "{s:0.8}({s:0.8,V:1}lvl.#1#{s:0.8}){} Level up {C:dark_edition}x2{}",
            "{C:attention}#2#",
            "{C:mult}+#3#{} Mult and",
            "{C:chips}+#4#{} chips"
        }
    },
    pos = {x=8,y=3},
    config = {hand_type = 'High Card'},

    loc_vars = function(self, info_queue, center)
        SMODS.ConsumableDX.loc_vars(self, info_queue, center)
        local loc_vars = {
            G.GAME.hands[self.config.hand_type].level, localize(self.config.hand_type, 'poker_hands'), G.GAME.hands[self.config.hand_type].l_mult * 2, G.GAME.hands[self.config.hand_type].l_chips * 2,
            colours = {(G.GAME.hands[self.config.hand_type].level==1 and G.C.UI.TEXT_DARK or G.C.HAND_LEVELS[math.min(7, G.GAME.hands[self.config.hand_type].level)])}
        }
        return {vars = loc_vars}
    end,

    set_card_type_badge = function(self, card, badges)
        badges[1] = create_badge(localize('k_dwarf_planet'), get_type_colour(self or card.config, card), nil, 1.2)
        SMODS.ConsumableDX.set_card_type_badge(self, card, badges)
    end,

    use = function(self, card, area, copier)
        local used_tarot = copier or card
        update_hand_text({sound = 'button', volume = 0.7, pitch = 0.8, delay = 0.3}, {handname=localize(self.config.hand_type, 'poker_hands'),chips = G.GAME.hands[self.config.hand_type].chips, mult = G.GAME.hands[self.config.hand_type].mult, level=G.GAME.hands[self.config.hand_type].level})
        level_up_hand(used_tarot, self.config.hand_type, false, 2)
        update_hand_text({sound = 'button', volume = 0.7, pitch = 1.1, delay = 0}, {mult = 0, chips = 0, handname = '', level = ''})
    end,
}

-- Planet X DX
SMODS.ConsumableDX{
	set = 'Planet', atlas = 'Van_dx', key = 'c_planet_x_dx',
	loc_txt = {
        name = "Planet X DX",
        text = {
            "{s:0.8}({s:0.8,V:1}lvl.#1#{s:0.8}){} Level up {C:dark_edition}x2{}",
            "{C:attention}#2#",
            "{C:mult}+#3#{} Mult and",
            "{C:chips}+#4#{} chips"
        }
    },
    pos = {x=9,y=2},
    config = {hand_type = 'Five of a Kind', softlock = true},

    loc_vars = function(self, info_queue, center)
        SMODS.ConsumableDX.loc_vars(self, info_queue, center)
        local loc_vars = {
            G.GAME.hands[self.config.hand_type].level, localize(self.config.hand_type, 'poker_hands'), G.GAME.hands[self.config.hand_type].l_mult * 2, G.GAME.hands[self.config.hand_type].l_chips * 2,
            colours = {(G.GAME.hands[self.config.hand_type].level==1 and G.C.UI.TEXT_DARK or G.C.HAND_LEVELS[math.min(7, G.GAME.hands[self.config.hand_type].level)])}
        }
        return {vars = loc_vars}
    end,

    set_card_type_badge = function(self, card, badges)
        badges[1] = create_badge(localize('k_planet_q'), get_type_colour(self or card.config, card), nil, 1.2)
        SMODS.ConsumableDX.set_card_type_badge(self, card, badges)
    end,

    use = function(self, card, area, copier)
        local used_tarot = copier or card
        update_hand_text({sound = 'button', volume = 0.7, pitch = 0.8, delay = 0.3}, {handname=localize(self.config.hand_type, 'poker_hands'),chips = G.GAME.hands[self.config.hand_type].chips, mult = G.GAME.hands[self.config.hand_type].mult, level=G.GAME.hands[self.config.hand_type].level})
        level_up_hand(used_tarot, self.config.hand_type, false, 2)
        update_hand_text({sound = 'button', volume = 0.7, pitch = 1.1, delay = 0}, {mult = 0, chips = 0, handname = '', level = ''})
    end,
}

-- Ceres DX
SMODS.ConsumableDX{
	set = 'Planet', atlas = 'Van_dx', key = 'c_ceres_dx',
	loc_txt = {
        name = "Ceres DX",
        text = {
            "{s:0.8}({s:0.8,V:1}lvl.#1#{s:0.8}){} Level up {C:dark_edition}x2{}",
            "{C:attention}#2#",
            "{C:mult}+#3#{} Mult and",
            "{C:chips}+#4#{} chips"
        }
    },
    pos = {x=8,y=2},
    config = {hand_type = 'Flush House', softlock = true},

    loc_vars = function(self, info_queue, center)
        SMODS.ConsumableDX.loc_vars(self, info_queue, center)
        local loc_vars = {
            G.GAME.hands[self.config.hand_type].level, localize(self.config.hand_type, 'poker_hands'), G.GAME.hands[self.config.hand_type].l_mult * 2, G.GAME.hands[self.config.hand_type].l_chips * 2,
            colours = {(G.GAME.hands[self.config.hand_type].level==1 and G.C.UI.TEXT_DARK or G.C.HAND_LEVELS[math.min(7, G.GAME.hands[self.config.hand_type].level)])}
        }
        return {vars = loc_vars}
    end,

    set_card_type_badge = function(self, card, badges)
        badges[1] = create_badge(localize('k_dwarf_planet'), get_type_colour(self or card.config, card), nil, 1.2)
        SMODS.ConsumableDX.set_card_type_badge(self, card, badges)
    end,

    use = function(self, card, area, copier)
        local used_tarot = copier or card
        update_hand_text({sound = 'button', volume = 0.7, pitch = 0.8, delay = 0.3}, {handname=localize(self.config.hand_type, 'poker_hands'),chips = G.GAME.hands[self.config.hand_type].chips, mult = G.GAME.hands[self.config.hand_type].mult, level=G.GAME.hands[self.config.hand_type].level})
        level_up_hand(used_tarot, self.config.hand_type, false, 2)
        update_hand_text({sound = 'button', volume = 0.7, pitch = 1.1, delay = 0}, {mult = 0, chips = 0, handname = '', level = ''})
    end,
}

-- Eris DX
SMODS.ConsumableDX{
	set = 'Planet', atlas = 'Van_dx', key = 'c_eris_dx',
	loc_txt = {
        name = "Eris DX",
        text = {
            "{s:0.8}({s:0.8,V:1}lvl.#1#{s:0.8}){} Level up {C:dark_edition}x2{}",
            "{C:attention}#2#",
            "{C:mult}+#3#{} Mult and",
            "{C:chips}+#4#{} chips"
        }
    },
    pos = {x=3,y=2},
    config = {hand_type = 'Flush Five', softlock = true},

    loc_vars = function(self, info_queue, center)
        SMODS.ConsumableDX.loc_vars(self, info_queue, center)
        local loc_vars = {
            G.GAME.hands[self.config.hand_type].level, localize(self.config.hand_type, 'poker_hands'), G.GAME.hands[self.config.hand_type].l_mult * 2, G.GAME.hands[self.config.hand_type].l_chips * 2,
            colours = {(G.GAME.hands[self.config.hand_type].level==1 and G.C.UI.TEXT_DARK or G.C.HAND_LEVELS[math.min(7, G.GAME.hands[self.config.hand_type].level)])}
        }
        return {vars = loc_vars}
    end,

    set_card_type_badge = function(self, card, badges)
        badges[1] = create_badge(localize('k_dwarf_planet'), get_type_colour(self or card.config, card), nil, 1.2)
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


-- Familiar DX
SMODS.ConsumableDX{
	set = 'Spectral', atlas = 'Van_dx', key = 'c_familiar_dx',
	loc_txt = {
        name = "Familiar DX",
        text = {
            "Destroy {C:attention}2{} selected",
            "cards in your hand, add",
            "{C:attention}#1#{} random {C:attention}Enhanced face",
            "{C:attention}cards{} to your hand"
        }
    },
    pos = {x=0,y=4},
    config = {max_highlighted = 2, min_highlighted = 2, remove_card = true, extra = 5},
    cost = 6,

    set_card_type_badge = function(self, card, badges)
        badges[1] = create_badge(localize('k_spectral'), get_type_colour(self or card.config, card), nil, 1.2)
        SMODS.ConsumableDX.set_card_type_badge(self, card, badges)
    end,

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
	loc_txt = {
        name = "Grim DX",
        text = {
            "Destroy {C:attention}2{} selected",
            "cards in your hand,",
            "add {C:attention}#1#{} random {C:attention}Enhanced",
            "{C:attention}Aces{} to your hand"
        }
    },
    pos = {x=1,y=4},
    config = {max_highlighted = 2, min_highlighted = 2, remove_card = true, extra = 4},
    cost = 6,

    set_card_type_badge = function(self, card, badges)
        badges[1] = create_badge(localize('k_spectral'), get_type_colour(self or card.config, card), nil, 1.2)
        SMODS.ConsumableDX.set_card_type_badge(self, card, badges)
    end,

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
	loc_txt = {
        name = "Incantation DX",
        text = {
            "Destroy {C:attention}2{} selected",
            "cards in your hand, add {C:attention}#1#",
            "random {C:attention}Enhanced numbered",
            "{C:attention}cards{} to your hand"
        }
    },
    pos = {x=2,y=4},
    config = {max_highlighted = 2, min_highlighted = 2, remove_card = true, extra = 6},
    cost = 6,

    set_card_type_badge = function(self, card, badges)
        badges[1] = create_badge(localize('k_spectral'), get_type_colour(self or card.config, card), nil, 1.2)
        SMODS.ConsumableDX.set_card_type_badge(self, card, badges)
    end,

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
	loc_txt = {
        name = "Talisman DX",
        text = {
            "Add a {C:attention}Gold Seal{}",
            "to up to {C:attention}3{} selected",
            "cards in your hand"
        }
    },
    pos = {x=3,y=4},
    config = {max_highlighted = 3, extra = 'Gold'},
    cost = 6,

    set_card_type_badge = function(self, card, badges)
        badges[1] = create_badge(localize('k_spectral'), get_type_colour(self or card.config, card), nil, 1.2)
        SMODS.ConsumableDX.set_card_type_badge(self, card, badges)
    end,

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
	loc_txt = {
        name = "Aura DX",
        text = {
            "Add {C:dark_edition}Foil{}, {C:dark_edition}Holographic{},",
            "or {C:dark_edition}Polychrome{} effect to up",
            "to {C:attention}3{} selected cards in hand"
        }
    },
    pos = {x=4,y=4},
    config = {max_highlighted = 3},
    cost = 6,

    set_card_type_badge = function(self, card, badges)
        badges[1] = create_badge(localize('k_spectral'), get_type_colour(self or card.config, card), nil, 1.2)
        SMODS.ConsumableDX.set_card_type_badge(self, card, badges)
    end,

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
	loc_txt = {
        name = "Wraith DX",
        text = {
            "Creates a random",
            "{C:red}Rare{C:attention} Joker{},"
        }
    },
    pos = {x=5,y=4},
    config = {},
    cost = 6,

    set_card_type_badge = function(self, card, badges)
        badges[1] = create_badge(localize('k_spectral'), get_type_colour(self or card.config, card), nil, 1.2)
        SMODS.ConsumableDX.set_card_type_badge(self, card, badges)
    end,

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
	loc_txt = {
        name = "Sigil DX",
        text = {
            "Converts all cards",
            "in hand to a single",
            "selected {C:attention}suit"
        }
    },
    pos = {x=6,y=4},
    config = {max_highlighted = 1},
    cost = 6,

    set_card_type_badge = function(self, card, badges)
        badges[1] = create_badge(localize('k_spectral'), get_type_colour(self or card.config, card), nil, 1.2)
        SMODS.ConsumableDX.set_card_type_badge(self, card, badges)
    end,

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
	loc_txt = {
        name = "Ouija DX",
        text = {
            "Converts all cards",
            "in hand to a single",
            "selected {C:attention}rank"
        }
    },
    pos = {x=7,y=4},
    config = {max_highlighted = 1},
    cost = 6,

    set_card_type_badge = function(self, card, badges)
        badges[1] = create_badge(localize('k_spectral'), get_type_colour(self or card.config, card), nil, 1.2)
        SMODS.ConsumableDX.set_card_type_badge(self, card, badges)
    end,

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
	loc_txt = {
        name = "Ectoplasm DX",
        text = {
            "Add {C:dark_edition}Negative{} to",
            "a random {C:attention}Joker,",
            "destroys {C:attention}all{} consumables"
        }
    },
    pos = {x=8,y=4},
    config = {},
    cost = 6,

    set_card_type_badge = function(self, card, badges)
        badges[1] = create_badge(localize('k_spectral'), get_type_colour(self or card.config, card), nil, 1.2)
        SMODS.ConsumableDX.set_card_type_badge(self, card, badges)
    end,

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
	loc_txt = {
        name = "Immolate DX",
        text = {
            "Destroys {C:attention}#1#{} selected",
            "cards in hand,",
            "gain {C:money}$#2#"
        }
    },
    pos = {x=9,y=4},
    config = {max_highlighted = 5, min_highlighted = 5, remove_card = true, extra = {destroy = 5, dollars = 20}},
    cost = 6,

    set_card_type_badge = function(self, card, badges)
        badges[1] = create_badge(localize('k_spectral'), get_type_colour(self or card.config, card), nil, 1.2)
        SMODS.ConsumableDX.set_card_type_badge(self, card, badges)
    end,

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
        delay(0.5)
        ease_dollars(self.config.extra.dollars)
    end,
}

-- Ankh DX
SMODS.ConsumableDX{
	set = 'Spectral', atlas = 'Van_dx', key = 'c_ankh_dx',
	loc_txt = {
        name = "Ankh DX",
        text = {
            "Create a copy of a",
            "random {C:attention}Joker{}"
        }
    },
    pos = {x=0,y=5},
    config = {},
    cost = 6,

    set_card_type_badge = function(self, card, badges)
        badges[1] = create_badge(localize('k_spectral'), get_type_colour(self or card.config, card), nil, 1.2)
        SMODS.ConsumableDX.set_card_type_badge(self, card, badges)
    end,

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
	loc_txt = {
        name = "Deja Vu DX",
        text = {
            "Add a {C:red}Red Seal{}",
            "to up to {C:attention}3{} selected",
            "cards in your hand"
        }
    },
    pos = {x=1,y=5},
    config = {max_highlighted = 3, extra = 'Red'},
    cost = 6,

    set_card_type_badge = function(self, card, badges)
        badges[1] = create_badge(localize('k_spectral'), get_type_colour(self or card.config, card), nil, 1.2)
        SMODS.ConsumableDX.set_card_type_badge(self, card, badges)
    end,

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
	loc_txt = {
        name = "Hex DX",
        text = {
            "Add {C:dark_edition}Polychrome{} to a",
            "random {C:attention}Joker{}"
        }
    },
    pos = {x=2,y=5},
    config = {},
    cost = 6,

    set_card_type_badge = function(self, card, badges)
        badges[1] = create_badge(localize('k_spectral'), get_type_colour(self or card.config, card), nil, 1.2)
        SMODS.ConsumableDX.set_card_type_badge(self, card, badges)
    end,

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
	loc_txt = {
        name = "Trance DX",
        text = {
            "Add a {C:blue}Blue Seal{}",
            "to up to {C:attention}3{} selected",
            "cards in your hand"
        }
    },
    pos = {x=3,y=5},
    config = {max_highlighted = 3, extra = 'Blue'},
    cost = 6,

    set_card_type_badge = function(self, card, badges)
        badges[1] = create_badge(localize('k_spectral'), get_type_colour(self or card.config, card), nil, 1.2)
        SMODS.ConsumableDX.set_card_type_badge(self, card, badges)
    end,

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
	loc_txt = {
        name = "Medium DX",
        text = {
            "Add a {C:purple}Purple Seal{}",
            "to up to {C:attention}3{} selected",
            "cards in your hand"
        }
    },
    pos = {x=4,y=5},
    config = {max_highlighted = 3, extra = 'Purple'},
    cost = 6,

    set_card_type_badge = function(self, card, badges)
        badges[1] = create_badge(localize('k_spectral'), get_type_colour(self or card.config, card), nil, 1.2)
        SMODS.ConsumableDX.set_card_type_badge(self, card, badges)
    end,

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
	loc_txt = {
        name = "Cryptid DX",
        text = {
            "Create {C:attention}#1#{} copies of",
            "{C:attention}1{} selected card",
            "in your hand"
        }
    },
    pos = {x=5,y=5},
    config = {extra = 4, max_highlighted = 1},
    cost = 6,

    set_card_type_badge = function(self, card, badges)
        badges[1] = create_badge(localize('k_spectral'), get_type_colour(self or card.config, card), nil, 1.2)
        SMODS.ConsumableDX.set_card_type_badge(self, card, badges)
    end,

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
	loc_txt = {
        name = "The Soul DX",
        text = {
            "Creates a",
            "{C:legendary,E:1}Legendary{} Joker",
            "{C:inactive}(Don't need room...?)"
        }
    },
    pos = {x=2,y=2},
    soul_pos = {x=6,y=5},
    config = {},
    cost = 6,
    hidden = true,

    set_card_type_badge = function(self, card, badges)
        badges[1] = create_badge(localize('k_spectral'), get_type_colour(self or card.config, card), nil, 1.2)
        SMODS.ConsumableDX.set_card_type_badge(self, card, badges)
    end,

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
}

-- Black Hole DX
SMODS.ConsumableDX{
	set = 'Spectral', atlas = 'Van_dx', key = 'c_black_hole_dx',
	loc_txt = {
        name = "Black Hole DX",
        text = {
            "Upgrade every",
            "{C:legendary,E:1}poker hand",
            "by {C:attention}3{} levels"
        }
    },
    pos = {x=9,y=3},
    config = {},
    cost = 6,
    hidden = true,

    set_card_type_badge = function(self, card, badges)
        badges[1] = create_badge(localize('k_spectral'), get_type_colour(self or card.config, card), nil, 1.2)
        SMODS.ConsumableDX.set_card_type_badge(self, card, badges)
    end,

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
        if (js_config.planet_edition_enabled and not (SMODS.Mods['aurinko'] or {}).can_load) and used_tarot.edition then
            if used_tarot.edition.holo then
                G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.9, func = function()
                    play_sound('holo1')
                    used_tarot:juice_up(0.8, 0.5)
                    return true end }))
                    update_hand_text({delay = 0}, {mult = '+' .. tostring(G.P_CENTERS.e_holo.config.extra), StatusText = true})
            end
            if used_tarot.edition.foil then
                G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.9, func = function()
                    play_sound('foil1')
                    used_tarot:juice_up(0.8, 0.5)
                    return true end }))
                    update_hand_text({delay = 0}, {chips = '+' .. tostring(G.P_CENTERS.e_foil.config.extra), StatusText = true})
            end
            if used_tarot.edition.polychrome then
                G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.9, func = function()
                    play_sound('polychrome1')
                    used_tarot:juice_up(0.8, 0.5)
                    return true end }))
                    update_hand_text({delay = 0}, {mult = 'x' .. tostring(G.P_CENTERS.e_polychrome.config.extra), StatusText = true})
            end
            -- Bunco Glitter compat
            if SMODS.Mods and (SMODS.Mods['Bunco'] or {}).can_load and used_tarot.edition.bunc_glitter then
                G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, func = function()
                    play_sound('bunc_glitter')
                    used_tarot:juice_up(0.8, 0.5)
                    return true end }))
                update_hand_text({delay = 0}, {chips = 'x' .. tostring(G.P_CENTERS.e_bunc_glitter.config.Xchips), StatusText = true})
            end
            -- Cryptid Mosaic compat
            if SMODS.Mods and (SMODS.Mods['Cryptid'] or {}).can_load and used_tarot.edition.cry_mosaic then
                G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, func = function()
                    play_sound('cry_e_mosaic')
                    used_tarot:juice_up(0.8, 0.5)
                    return true end }))
                update_hand_text({delay = 0}, {chips = 'x' .. tostring(G.P_CENTERS.e_cry_mosaic.config.Xchips), StatusText = true})
            end
            -- Cryptid Oversaturated compat
            if SMODS.Mods and (SMODS.Mods['Cryptid'] or {}).can_load and used_tarot.edition.cry_oversat then
                G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, func = function()
                    play_sound('cry_e_oversaturated')
                    used_tarot:juice_up(0.8, 0.5)
                    return true end }))
                update_hand_text({delay = 0}, {chips = 'x2', StatusText = true})
                update_hand_text({delay = 0}, {mult = 'x2', StatusText = true})
            end
            -- Cryptid Astral Compat
            if SMODS.Mods and (SMODS.Mods['Cryptid'] or {}).can_load and used_tarot.edition.cry_astral then
                G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, func = function()
                    play_sound('cry_^Mult')
                    used_tarot:juice_up(0.8, 0.5)
                    return true end }))
                update_hand_text({delay = 0}, {mult = '^' .. tostring(G.P_CENTERS.e_cry_astral.config.pow_mult), StatusText = true})
            end
            -- Cryptid Glitched compat
            if SMODS.Mods and (SMODS.Mods['Cryptid'] or {}).can_load and used_tarot.edition.cry_glitched then
                G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, func = function()
                    play_sound('cry_e_glitched')
                    used_tarot:juice_up(0.8, 0.5)
                    return true end }))
                update_hand_text({ delay = 0 }, { chips = 'x' .. '...', StatusText = true })
                update_hand_text({ delay = 0 }, { mult = 'x' .. '...', StatusText = true })
                -- TODO either keep it as is or force hellno/bad/gud values to be pulled once and applied to every hand
            end
        end
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

-- Arcana Pack DX 1
SMODS.BoosterDX{
    kind = 'Arcana', atlas = 'Van_Booster_dx', key = 'p_arcana_normal_1_dx',
	loc_txt = {
        name = "Arcana Pack DX",
        text = {
            "Choose {C:attention}#1#{} of up to",
            "{C:attention}#2#{C:tarot} Tarot{} cards to",
            "be used immediately",
            "{C:inactive}(You feel lucky...)"
        }
    },
    group_key = "k_arcana_pack",
    draw_hand = true,
    pos = {x=0,y=0},
    cost = 6,
    config = {extra = 4, choose = 1},
    weight = 1 * js_config.booster_dx_rate,
    
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
}

-- Arcana Pack DX 2
SMODS.BoosterDX{
    kind = 'Arcana', atlas = 'Van_Booster_dx', key = 'p_arcana_normal_2_dx',
	loc_txt = {
        name = "Arcana Pack DX",
        text = {
            "Choose {C:attention}#1#{} of up to",
            "{C:attention}#2#{C:tarot} Tarot{} cards to",
            "be used immediately",
            "{C:inactive}(You feel lucky...)"
        }
    },
    group_key = "k_arcana_pack",
    draw_hand = true,
    pos = {x=1,y=0},
    cost = 6,
    config = {extra = 4, choose = 1},
    weight = 1 * js_config.booster_dx_rate,
    
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
}

-- Arcana Pack DX 3
SMODS.BoosterDX{
    kind = 'Arcana', atlas = 'Van_Booster_dx', key = 'p_arcana_normal_3_dx',
	loc_txt = {
        name = "Arcana Pack DX",
        text = {
            "Choose {C:attention}#1#{} of up to",
            "{C:attention}#2#{C:tarot} Tarot{} cards to",
            "be used immediately",
            "{C:inactive}(You feel lucky...)"
        }
    },
    group_key = "k_arcana_pack",
    draw_hand = true,
    pos = {x=2,y=0},
    cost = 6,
    config = {extra = 4, choose = 1},
    weight = 1 * js_config.booster_dx_rate,
    
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
}

-- Arcana Pack DX 4
SMODS.BoosterDX{
    kind = 'Arcana', atlas = 'Van_Booster_dx', key = 'p_arcana_normal_4_dx',
	loc_txt = {
        name = "Arcana Pack DX",
        text = {
            "Choose {C:attention}#1#{} of up to",
            "{C:attention}#2#{C:tarot} Tarot{} cards to",
            "be used immediately",
            "{C:inactive}(You feel lucky...)"
        }
    },
    group_key = "k_arcana_pack",
    draw_hand = true,
    pos = {x=3,y=0},
    cost = 6,
    config = {extra = 4, choose = 1},
    weight = 1 * js_config.booster_dx_rate,
    
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
}

-- Jumbo Arcana Pack DX 1
SMODS.BoosterDX{
    kind = 'Arcana', atlas = 'Van_Booster_dx', key = 'p_arcana_jumbo_1_dx',
	loc_txt = {
        name = "Jumbo Arcana Pack DX",
        text = {
            "Choose {C:attention}#1#{} of up to",
            "{C:attention}#2#{C:tarot} Tarot{} cards to",
            "be used immediately",
            "{C:inactive}(You feel lucky...)"
        }
    },
    group_key = "k_arcana_pack",
    draw_hand = true,
    pos = {x=0,y=2},
    cost = 8,
    config = {extra = 6, choose = 1},
    weight = 1 * js_config.booster_dx_rate,
    
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
}

-- Jumbo Arcana Pack DX 2
SMODS.BoosterDX{
    kind = 'Arcana', atlas = 'Van_Booster_dx', key = 'p_arcana_jumbo_2_dx',
	loc_txt = {
        name = "Jumbo Arcana Pack DX",
        text = {
            "Choose {C:attention}#1#{} of up to",
            "{C:attention}#2#{C:tarot} Tarot{} cards to",
            "be used immediately",
            "{C:inactive}(You feel lucky...)"
        }
    },
    group_key = "k_arcana_pack",
    draw_hand = true,
    pos = {x=1,y=2},
    cost = 8,
    config = {extra = 6, choose = 1},
    weight = 1 * js_config.booster_dx_rate,
    
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
}

-- Mega Arcana Pack DX 1
SMODS.BoosterDX{
    kind = 'Arcana', atlas = 'Van_Booster_dx', key = 'p_arcana_mega_1_dx',
	loc_txt = {
        name = "Mega Arcana Pack DX",
        text = {
            "Choose {C:attention}#1#{} of up to",
            "{C:attention}#2#{C:tarot} Tarot{} cards to",
            "be used immediately",
            "{C:inactive}(You feel lucky...)"
        }
    },
    group_key = "k_arcana_pack",
    draw_hand = true,
    pos = {x=2,y=2},
    cost = 10,
    config = {extra = 6, choose = 2},
    weight = 0.25 * js_config.booster_dx_rate,
    
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
}

-- Mega Arcana Pack DX 2
SMODS.BoosterDX{
    kind = 'Arcana', atlas = 'Van_Booster_dx', key = 'p_arcana_mega_2_dx',
	loc_txt = {
        name = "Mega Arcana Pack DX",
        text = {
            "Choose {C:attention}#1#{} of up to",
            "{C:attention}#2#{C:tarot} Tarot{} cards to",
            "be used immediately",
            "{C:inactive}(You feel lucky...)"
        }
    },
    group_key = "k_arcana_pack",
    draw_hand = true,
    pos = {x=3,y=2},
    cost = 10,
    config = {extra = 6, choose = 2},
    weight = 0.25 * js_config.booster_dx_rate,
    
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
}

-- Celestial Pack DX 1
SMODS.BoosterDX{
    kind = 'Celestial', atlas = 'Van_Booster_dx', key = 'p_celestial_normal_1_dx',
	loc_txt = {
        name = "Celestial Pack DX",
        text = {
            "Choose {C:attention}#1#{} of up to",
            "{C:attention}#2#{C:planet} Planet{} cards to",
            "be used immediately",
            "{C:inactive}(You feel lucky...)"
        }
    },
    group_key = "k_celestial_pack",
    pos = {x=0,y=1},
    cost = 6,
    config = {extra = 4, choose = 1},
    weight = 1 * js_config.booster_dx_rate,
    
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
}

-- Celestial Pack DX 2
SMODS.BoosterDX{
    kind = 'Celestial', atlas = 'Van_Booster_dx', key = 'p_celestial_normal_2_dx',
	loc_txt = {
        name = "Celestial Pack DX",
        text = {
            "Choose {C:attention}#1#{} of up to",
            "{C:attention}#2#{C:planet} Planet{} cards to",
            "be used immediately",
            "{C:inactive}(You feel lucky...)"
        }
    },
    group_key = "k_celestial_pack",
    pos = {x=1,y=1},
    cost = 6,
    config = {extra = 4, choose = 1},
    weight = 1 * js_config.booster_dx_rate,
    
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
}

-- Celestial Pack DX 3
SMODS.BoosterDX{
    kind = 'Celestial', atlas = 'Van_Booster_dx', key = 'p_celestial_normal_3_dx',
	loc_txt = {
        name = "Celestial Pack DX",
        text = {
            "Choose {C:attention}#1#{} of up to",
            "{C:attention}#2#{C:planet} Planet{} cards to",
            "be used immediately",
            "{C:inactive}(You feel lucky...)"
        }
    },
    group_key = "k_celestial_pack",
    pos = {x=2,y=1},
    cost = 6,
    config = {extra = 4, choose = 1},
    weight = 1 * js_config.booster_dx_rate,
    
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
}

-- Celestial Pack DX 4
SMODS.BoosterDX{
    kind = 'Celestial', atlas = 'Van_Booster_dx', key = 'p_celestial_normal_4_dx',
	loc_txt = {
        name = "Celestial Pack DX",
        text = {
            "Choose {C:attention}#1#{} of up to",
            "{C:attention}#2#{C:planet} Planet{} cards to",
            "be used immediately",
            "{C:inactive}(You feel lucky...)"
        }
    },
    group_key = "k_celestial_pack",
    pos = {x=3,y=1},
    cost = 6,
    config = {extra = 4, choose = 1},
    weight = 1 * js_config.booster_dx_rate,
    
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
}

-- Jumbo Celestial Pack DX 1
SMODS.BoosterDX{
    kind = 'Celestial', atlas = 'Van_Booster_dx', key = 'p_celestial_jumbo_1_dx',
	loc_txt = {
        name = "Jumbo Celestial Pack DX",
        text = {
            "Choose {C:attention}#1#{} of up to",
            "{C:attention}#2#{C:planet} Planet{} cards to",
            "be used immediately",
            "{C:inactive}(You feel lucky...)"
        }
    },
    group_key = "k_celestial_pack",
    pos = {x=0,y=3},
    cost = 8,
    config = {extra = 6, choose = 1},
    weight = 1 * js_config.booster_dx_rate,
    
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
}

-- Jumbo Celestial Pack DX 2
SMODS.BoosterDX{
    kind = 'Celestial', atlas = 'Van_Booster_dx', key = 'p_celestial_jumbo_2_dx',
	loc_txt = {
        name = "Jumbo Celestial Pack DX",
        text = {
            "Choose {C:attention}#1#{} of up to",
            "{C:attention}#2#{C:planet} Planet{} cards to",
            "be used immediately",
            "{C:inactive}(You feel lucky...)"
        }
    },
    group_key = "k_celestial_pack",
    pos = {x=1,y=3},
    cost = 8,
    config = {extra = 6, choose = 1},
    weight = 1 * js_config.booster_dx_rate,
    
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
}

-- Mega Celestial Pack DX 1
SMODS.BoosterDX{
    kind = 'Celestial', atlas = 'Van_Booster_dx', key = 'p_celestial_mega_1_dx',
	loc_txt = {
        name = "Mega Celestial Pack DX",
        text = {
            "Choose {C:attention}#1#{} of up to",
            "{C:attention}#2#{C:planet} Planet{} cards to",
            "be used immediately",
            "{C:inactive}(You feel lucky...)"
        }
    },
    group_key = "k_celestial_pack",
    pos = {x=2,y=3},
    cost = 10,
    config = {extra = 6, choose = 2},
    weight = 0.25 * js_config.booster_dx_rate,
    
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
}

-- Mega Celestial Pack DX 2
SMODS.BoosterDX{
    kind = 'Celestial', atlas = 'Van_Booster_dx', key = 'p_celestial_mega_2_dx',
	loc_txt = {
        name = "Mega Celestial Pack DX",
        text = {
            "Choose {C:attention}#1#{} of up to",
            "{C:attention}#2#{C:planet} Planet{} cards to",
            "be used immediately",
            "{C:inactive}(You feel lucky...)"
        }
    },
    group_key = "k_celestial_pack",
    pos = {x=3,y=3},
    cost = 10,
    config = {extra = 6, choose = 2},
    weight = 0.25 * js_config.booster_dx_rate,
    
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
}

-- Spectral Pack DX 1
SMODS.BoosterDX{
    kind = 'Spectral', atlas = 'Van_Booster_dx', key = 'p_spectral_normal_1_dx',
	loc_txt = {
        name = "Spectral Pack DX",
        text = {
            "Choose {C:attention}#1#{} of up to",
            "{C:attention}#2#{C:spectral} Spectral{} cards to",
            "be used immediately",
            "{C:inactive}(You feel lucky...)"
        }
    },
    group_key = "k_spectral_pack",
    draw_hand = true,
    pos = {x=0,y=4},
    cost = 6,
    config = {extra = 3, choose = 1},
    weight = 0.3 * js_config.booster_dx_rate,
    
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
}

-- Spectral Pack DX 2
SMODS.BoosterDX{
    kind = 'Spectral', atlas = 'Van_Booster_dx', key = 'p_spectral_normal_2_dx',
	loc_txt = {
        name = "Spectral Pack DX",
        text = {
            "Choose {C:attention}#1#{} of up to",
            "{C:attention}#2#{C:spectral} Spectral{} cards to",
            "be used immediately",
            "{C:inactive}(You feel lucky...)"
        }
    },
    group_key = "k_spectral_pack",
    draw_hand = true,
    pos = {x=1,y=4},
    cost = 6,
    config = {extra = 3, choose = 1},
    weight = 0.3 * js_config.booster_dx_rate,
    
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
}

-- Jumbo Spectral Pack DX 1
SMODS.BoosterDX{
    kind = 'Spectral', atlas = 'Van_Booster_dx', key = 'p_spectral_jumbo_1_dx',
	loc_txt = {
        name = "Jumbo Spectral Pack DX",
        text = {
            "Choose {C:attention}#1#{} of up to",
            "{C:attention}#2#{C:spectral} Spectral{} cards to",
            "be used immediately",
            "{C:inactive}(You feel lucky...)"
        }
    },
    group_key = "k_spectral_pack",
    draw_hand = true,
    pos = {x=2,y=4},
    cost = 8,
    config = {extra = 5, choose = 1},
    weight = 0.3 * js_config.booster_dx_rate,
    
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
}

-- Mega Spectral Pack DX 1
SMODS.BoosterDX{
    kind = 'Spectral', atlas = 'Van_Booster_dx', key = 'p_spectral_mega_1_dx',
	loc_txt = {
        name = "Mega Spectral Pack DX",
        text = {
            "Choose {C:attention}#1#{} of up to",
            "{C:attention}#2#{C:spectral} Spectral{} cards to",
            "be used immediately",
            "{C:inactive}(You feel lucky...)"
        }
    },
    group_key = "k_spectral_pack",
    draw_hand = true,
    pos = {x=2,y=4},
    cost = 8,
    config = {extra = 5, choose = 2},
    weight = 0.07 * js_config.booster_dx_rate,
    
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
}

-- Standard Pack DX 1
SMODS.BoosterDX{
    kind = 'Standard', atlas = 'Van_Booster_dx', key = 'p_standard_normal_1_dx',
	loc_txt = {
        name = "Standard Pack DX",
        text = {
            "Choose {C:attention}#1#{} of up to",
            "{C:attention}#2#{C:attention} Playing{} cards to",
            "add to your deck",
            "{C:inactive}(You feel lucky...)"
        }
    },
    group_key = "k_standard_pack",
    pos = {x=0,y=6},
    cost = 6,
    config = {extra = 4, choose = 1},
    weight = 1 * js_config.booster_dx_rate,
    
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
}

-- Standard Pack DX 2
SMODS.BoosterDX{
    kind = 'Standard', atlas = 'Van_Booster_dx', key = 'p_standard_normal_2_dx',
	loc_txt = {
        name = "Standard Pack DX",
        text = {
            "Choose {C:attention}#1#{} of up to",
            "{C:attention}#2#{C:attention} Playing{} cards to",
            "add to your deck",
            "{C:inactive}(You feel lucky...)"
        }
    },
    group_key = "k_standard_pack",
    pos = {x=1,y=6},
    cost = 6,
    config = {extra = 4, choose = 1},
    weight = 1 * js_config.booster_dx_rate,
    
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
}

-- Standard Pack DX 3
SMODS.BoosterDX{
    kind = 'Standard', atlas = 'Van_Booster_dx', key = 'p_standard_normal_3_dx',
	loc_txt = {
        name = "Standard Pack DX",
        text = {
            "Choose {C:attention}#1#{} of up to",
            "{C:attention}#2#{C:attention} Playing{} cards to",
            "add to your deck",
            "{C:inactive}(You feel lucky...)"
        }
    },
    group_key = "k_standard_pack",
    pos = {x=2,y=6},
    cost = 6,
    config = {extra = 4, choose = 1},
    weight = 1 * js_config.booster_dx_rate,
    
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
}

-- Standard Pack DX 4
SMODS.BoosterDX{
    kind = 'Standard', atlas = 'Van_Booster_dx', key = 'p_standard_normal_4_dx',
	loc_txt = {
        name = "Standard Pack DX",
        text = {
            "Choose {C:attention}#1#{} of up to",
            "{C:attention}#2#{C:attention} Playing{} cards to",
            "add to your deck",
            "{C:inactive}(You feel lucky...)"
        }
    },
    group_key = "k_standard_pack",
    pos = {x=3,y=6},
    cost = 6,
    config = {extra = 4, choose = 1},
    weight = 1 * js_config.booster_dx_rate,
    
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
}

-- Jumbo Standard Pack DX 1
SMODS.BoosterDX{
    kind = 'Standard', atlas = 'Van_Booster_dx', key = 'p_standard_jumbo_1_dx',
	loc_txt = {
        name = "Jumbo Standard Pack DX",
        text = {
            "Choose {C:attention}#1#{} of up to",
            "{C:attention}#2#{C:attention} Playing{} cards to",
            "add to your deck",
            "{C:inactive}(You feel lucky...)"
        }
    },
    group_key = "k_standard_pack",
    pos = {x=0,y=7},
    cost = 8,
    config = {extra = 6, choose = 1},
    weight = 1 * js_config.booster_dx_rate,
    
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
}

-- Jumbo Standard Pack DX 2
SMODS.BoosterDX{
    kind = 'Standard', atlas = 'Van_Booster_dx', key = 'p_standard_jumbo_2_dx',
	loc_txt = {
        name = "Jumbo Standard Pack DX",
        text = {
            "Choose {C:attention}#1#{} of up to",
            "{C:attention}#2#{C:attention} Playing{} cards to",
            "add to your deck",
            "{C:inactive}(You feel lucky...)"
        }
    },
    group_key = "k_standard_pack",
    pos = {x=1,y=7},
    cost = 8,
    config = {extra = 6, choose = 1},
    weight = 1 * js_config.booster_dx_rate,
    
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
}

-- Mega Standard Pack DX 1
SMODS.BoosterDX{
    kind = 'Standard', atlas = 'Van_Booster_dx', key = 'p_standard_mega_1_dx',
	loc_txt = {
        name = "Mega Standard Pack DX",
        text = {
            "Choose {C:attention}#1#{} of up to",
            "{C:attention}#2#{C:attention} Playing{} cards to",
            "add to your deck",
            "{C:inactive}(You feel lucky...)"
        }
    },
    group_key = "k_standard_pack",
    pos = {x=2,y=7},
    cost = 10,
    config = {extra = 6, choose = 2},
    weight = 0.25 * js_config.booster_dx_rate,
    
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
}

-- Mega Standard Pack DX 2
SMODS.BoosterDX{
    kind = 'Standard', atlas = 'Van_Booster_dx', key = 'p_standard_mega_2_dx',
	loc_txt = {
        name = "Mega Standard Pack DX",
        text = {
            "Choose {C:attention}#1#{} of up to",
            "{C:attention}#2#{C:attention} Playing{} cards to",
            "add to your deck",
            "{C:inactive}(You feel lucky...)"
        }
    },
    group_key = "k_standard_pack",
    pos = {x=3,y=7},
    cost = 10,
    config = {extra = 6, choose = 2},
    weight = 0.25 * js_config.booster_dx_rate,
    
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
}

-- Buffoon Pack DX 1
SMODS.BoosterDX{
    kind = 'Buffoon', atlas = 'Van_Booster_dx', key = 'p_buffoon_normal_1_dx',
	loc_txt = {
        name = "Buffoon Pack DX",
        text = {
            "Choose {C:attention}#1#{} of up to",
            "{C:attention}#2#{C:joker} Joker{} cards",
            "{C:inactive}(You feel lucky...)"
        }
    },
    group_key = "k_buffoon_pack",
    pos = {x=0,y=8},
    cost = 6,
    config = {extra = 3, choose = 1},
    weight = 0.6 * js_config.booster_dx_rate,
    
    ease_background_colour = function(self) ease_background_colour_blind(G.STATES.BUFFOON_PACK) end,

    create_card = function(self, card)
        local dx_modifier = pseudorandom(pseudoseed('force_dx'..G.GAME.round_resets.ante)) > 0.35
        local edition_rate = dx_modifier and 3 or 1.5
        local _edition = poll_edition('standard_edition'..G.GAME.round_resets.ante, edition_rate, true)
        local _rarity = pseudorandom('rarity'..G.GAME.round_resets.ante..(_append or '')) + (dx_modifier and 0.3 or 0)
        local _card = {set = "Joker", edition = _edition, rarity = _rarity, area = G.pack_cards, skip_materialize = true, soulable = true, key_append = "bufdx"}

        return _card
    end,
}

-- Buffoon Pack DX 2
SMODS.BoosterDX{
    kind = 'Buffoon', atlas = 'Van_Booster_dx', key = 'p_buffoon_normal_2_dx',
	loc_txt = {
        name = "Buffoon Pack DX",
        text = {
            "Choose {C:attention}#1#{} of up to",
            "{C:attention}#2#{C:joker} Joker{} cards",
            "{C:inactive}(You feel lucky...)"
        }
    },
    group_key = "k_buffoon_pack",
    pos = {x=1,y=8},
    cost = 6,
    config = {extra = 3, choose = 1},
    weight = 0.6 * js_config.booster_dx_rate,
    
    ease_background_colour = function(self) ease_background_colour_blind(G.STATES.BUFFOON_PACK) end,

    create_card = function(self, card)
        local dx_modifier = pseudorandom(pseudoseed('force_dx'..G.GAME.round_resets.ante)) > 0.35
        local edition_rate = dx_modifier and 3 or 1.5
        local _edition = poll_edition('standard_edition'..G.GAME.round_resets.ante, edition_rate, true)
        local _rarity = pseudorandom('rarity'..G.GAME.round_resets.ante..(_append or '')) + (dx_modifier and 0.3 or 0)
        local _card = {set = "Joker", edition = _edition, rarity = _rarity, area = G.pack_cards, skip_materialize = true, soulable = true, key_append = "bufdx"}

        return _card
    end,
}

-- Jumbo Buffoon Pack DX 1
SMODS.BoosterDX{
    kind = 'Buffoon', atlas = 'Van_Booster_dx', key = 'p_buffoon_jumbo_1_dx',
	loc_txt = {
        name = "Jumbo Buffoon Pack DX",
        text = {
            "Choose {C:attention}#1#{} of up to",
            "{C:attention}#2#{C:joker} Joker{} cards",
            "{C:inactive}(You feel lucky...)"
        }
    },
    group_key = "k_buffoon_pack",
    pos = {x=2,y=8},
    cost = 8,
    config = {extra = 5, choose = 1},
    weight = 0.6 * js_config.booster_dx_rate,
    
    ease_background_colour = function(self) ease_background_colour_blind(G.STATES.BUFFOON_PACK) end,

    create_card = function(self, card)
        local dx_modifier = pseudorandom(pseudoseed('force_dx'..G.GAME.round_resets.ante)) > 0.35
        local edition_rate = dx_modifier and 3 or 1.5
        local _edition = poll_edition('standard_edition'..G.GAME.round_resets.ante, edition_rate, true)
        local _rarity = pseudorandom('rarity'..G.GAME.round_resets.ante..(_append or '')) + (dx_modifier and 0.3 or 0)
        local _card = {set = "Joker", edition = _edition, rarity = _rarity, area = G.pack_cards, skip_materialize = true, soulable = true, key_append = "bufdx"}

        return _card
    end,
}

-- Mega Buffoon Pack DX 1
SMODS.BoosterDX{
    kind = 'Buffoon', atlas = 'Van_Booster_dx', key = 'p_buffoon_mega_1_dx',
	loc_txt = {
        name = "Mega Buffoon Pack DX",
        text = {
            "Choose {C:attention}#1#{} of up to",
            "{C:attention}#2#{C:joker} Joker{} cards",
            "{C:inactive}(You feel lucky...)"
        }
    },
    group_key = "k_buffoon_pack",
    pos = {x=3,y=8},
    cost = 10,
    config = {extra = 5, choose = 2},
    weight = 0.15 * js_config.booster_dx_rate,
    
    ease_background_colour = function(self) ease_background_colour_blind(G.STATES.BUFFOON_PACK) end,

    create_card = function(self, card)
        local dx_modifier = pseudorandom(pseudoseed('force_dx'..G.GAME.round_resets.ante)) > 0.35
        local edition_rate = dx_modifier and 3 or 1.5
        local _edition = poll_edition('standard_edition'..G.GAME.round_resets.ante, edition_rate, true)
        local _rarity = pseudorandom('rarity'..G.GAME.round_resets.ante..(_append or '')) + (dx_modifier and 0.3 or 0)
        local _card = {set = "Joker", edition = _edition, rarity = _rarity, area = G.pack_cards, skip_materialize = true, soulable = true, key_append = "bufdx"}

        return _card
    end,
}