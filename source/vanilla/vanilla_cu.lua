-- The Cursed Fool
SMODS.ConsumableCU{
	set = 'Tarot', atlas = 'Van_cu', key = 'c_fool_cu',
    pos = {x=0,y=0},
    nb_curse = 1,

    loc_vars = function(self, info_queue, center)
        SMODS.ConsumableCU.loc_vars(self, info_queue, center)
        local fool_c = G.P_CENTERS["c_fool_dx"] or nil
        local created_card = fool_c and localize{type = 'name_text', key = fool_c.key, set = fool_c.set} or localize('k_none')
        if fool_c then
            info_queue[#info_queue+1] = fool_c
        end
        return {vars = {created_card}}
    end,

    use = function(self, card, area, copier)
        local used_tarot = copier or card
        G.E_MANAGER:add_event(Event({func = function()
            G.consumeables.config.card_limit = G.consumeables.config.card_limit + 1
            return true end }))
        G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
            if G.consumeables.config.card_limit > #G.consumeables.cards then
                play_sound('timpani')
                local card = create_card('Tarot_dx', G.consumeables, nil, nil, nil, nil, 'c_fool_dx', 'fool')
                card:add_to_deck()
                G.consumeables:emplace(card)
                if G.consumeables.config.card_limit > #G.consumeables.cards then 
                    local card = create_card('Tarot_dx', G.consumeables, nil, nil, nil, nil, 'c_fool_dx', 'fool')
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
}

-- The Cursed Magician
SMODS.ConsumableCU{
	set = 'Tarot', atlas = 'Van_cu', key = 'c_magician_cu',
    pos = {x=1,y=0},
    nb_curse = 2,

    loc_vars = function(self, info_queue, center)
        SMODS.ConsumableCU.loc_vars(self, info_queue, center)
        local fool_c = G.P_CENTERS["c_magician_dx"] or nil
        local created_card = fool_c and localize{type = 'name_text', key = fool_c.key, set = fool_c.set} or localize('k_none')
        if fool_c then
            info_queue[#info_queue+1] = fool_c
        end
        return {vars = {created_card}}
    end,

    use = function(self, card, area, copier)
        local used_tarot = copier or card
        G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
            if G.consumeables.config.card_limit > #G.consumeables.cards then
                play_sound('timpani')
                if G.consumeables.config.card_limit > #G.consumeables.cards then 
                    local card = create_card('Tarot_dx', G.consumeables, nil, nil, nil, nil, 'c_magician_dx', 'magician')
                    card:add_to_deck()
                    G.consumeables:emplace(card)
                end
            end
            for k, v in pairs(G.GAME.probabilities) do 
                G.GAME.probabilities[k] = v*2
            end
            used_tarot:juice_up(0.3, 0.5)
            return true end }))
    end,

    can_use = function(self)
        return true
    end,
}

-- The Cursed High Priestess
SMODS.ConsumableCU{
	set = 'Tarot', atlas = 'Van_cu', key = 'c_high_priestess_cu',
    pos = {x=2,y=0},
    nb_curse = 1,
    config = {planets = 2, prob_mult = 2},

    loc_vars = function(self, info_queue, center)
        SMODS.ConsumableCU.loc_vars(self, info_queue, center)
        info_queue[#info_queue+1] = G.P_CENTERS.e_foil
        info_queue[#info_queue+1] = G.P_CENTERS.e_holo
        info_queue[#info_queue+1] = G.P_CENTERS.e_polychrome
        return {vars = {self.config.prob_mult * ((G.GAME.used_cu_augments.c_high_priestess_cu or 0) + 1)}}
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

-- The Cursed Empress
SMODS.ConsumableCU{
	set = 'Tarot', atlas = 'Van_cu', key = 'c_empress_cu',
    pos = {x=3,y=0},
    nb_curse = 1,
    config = {mod_conv = 'm_mult', extra = 8},

    loc_vars = function(self, info_queue, center)
        SMODS.ConsumableCU.loc_vars(self, info_queue, center)
        local fool_c = G.P_CENTERS["c_empress_dx"] or nil
        local created_card = fool_c and localize{type = 'name_text', key = fool_c.key, set = fool_c.set} or localize('k_none')
        if fool_c then
            info_queue[#info_queue+1] = fool_c
        end
        return {vars = {G.P_CENTERS.m_mult.config.mult + self.config.extra, localize{type = 'name_text', set = 'Enhanced', key = self.config.mod_conv}, created_card}}
    end,

    use = function(self, card, area, copier)
        local used_tarot = copier or card
        G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
            if G.consumeables.config.card_limit > #G.consumeables.cards then
                play_sound('timpani')
                local card = create_card('Tarot_dx', G.consumeables, nil, nil, nil, nil, 'c_empress_dx', 'empress')
                card:add_to_deck()
                G.consumeables:emplace(card)
            end
            DXT.update_cu_buffs()
            DXT.buff_enhanced_cards(self.key)
            used_tarot:juice_up(0.3, 0.5)
        return true end }))
    end,

    can_use = function(self)
        return true
    end,
}

-- The Cursed Emperor
SMODS.ConsumableCU{
	set = 'Tarot', atlas = 'Van_cu', key = 'c_emperor_cu',
    pos = {x=4,y=0},
    nb_curse = 1,
    config = {tarots = 6},

    loc_vars = function(self, info_queue, center)
        SMODS.ConsumableCU.loc_vars(self, info_queue, center)
        info_queue[#info_queue+1] = {key = 'e_negative_consumable', set = 'Edition', config = {extra = 1}}
        return {vars = {self.config.tarots}}
    end,

    use = function(self, card, area, copier)
        local used_tarot = copier or card
        for i = 1, self.config.tarots do
            G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
                play_sound('timpani')
                local card = create_card('Tarot_dx', G.consumeables, nil, nil, nil, nil, nil, 'emp')
                card:set_edition({negative = true}, true)
                card:add_to_deck()
                G.consumeables:emplace(card)
                used_tarot:juice_up(0.3, 0.5)
            return true end }))
        end
        delay(0.6)
    end,

    can_use = function(self)
        return true
    end,
}

-- The Cursed Hierophant
SMODS.ConsumableCU{
	set = 'Tarot', atlas = 'Van_cu', key = 'c_heirophant_cu',
    pos = {x=5,y=0},
    nb_curse = 1,
    config = {mod_conv = 'm_bonus', extra = 60},

    loc_vars = function(self, info_queue, center)
        SMODS.ConsumableCU.loc_vars(self, info_queue, center)
        local fool_c = G.P_CENTERS["c_heirophant_dx"] or nil
        local created_card = fool_c and localize{type = 'name_text', key = fool_c.key, set = fool_c.set} or localize('k_none')
        if fool_c then
            info_queue[#info_queue+1] = fool_c
        end
        return {vars = {G.P_CENTERS.m_bonus.config.bonus + self.config.extra, localize{type = 'name_text', set = 'Enhanced', key = self.config.mod_conv}, created_card}}
    end,

    use = function(self, card, area, copier)
        local used_tarot = copier or card
        G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
            if G.consumeables.config.card_limit > #G.consumeables.cards then
                play_sound('timpani')
                local card = create_card('Tarot_dx', G.consumeables, nil, nil, nil, nil, 'c_heirophant_dx', 'heirophant')
                card:add_to_deck()
                G.consumeables:emplace(card)
            end
            DXT.update_cu_buffs()
            DXT.buff_enhanced_cards(self.key)
            used_tarot:juice_up(0.3, 0.5)
        return true end }))
    end,

    can_use = function(self)
        return true
    end,
}

-- The Cursed Lovers
SMODS.ConsumableCU{
	set = 'Tarot', atlas = 'Van_cu', key = 'c_lovers_cu',
    pos = {x=6,y=0},
    nb_curse = 1,
    config = {mod_conv = 'm_wild'},
    unique = true,

    loc_vars = function(self, info_queue, center)
        SMODS.ConsumableCU.loc_vars(self, info_queue, center)
        local fool_c = G.P_CENTERS["c_lovers_dx"] or nil
        local created_card = fool_c and localize{type = 'name_text', key = fool_c.key, set = fool_c.set} or localize('k_none')
        if fool_c then
            info_queue[#info_queue+1] = fool_c
        end
        return {vars = {localize{type = 'name_text', set = 'Enhanced', key = self.config.mod_conv}, created_card}}
    end,

    use = function(self, card, area, copier)
        local used_tarot = copier or card
        G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
            if G.consumeables.config.card_limit > #G.consumeables.cards then
                play_sound('timpani')
                local card = create_card('Tarot_dx', G.consumeables, nil, nil, nil, nil, 'c_lovers_dx', 'lovers')
                card:add_to_deck()
                G.consumeables:emplace(card)
            end
            used_tarot:juice_up(0.3, 0.5)
        return true end }))
    end,

    can_use = function(self)
        return true
    end,
}

-- The Cursed Chariot
SMODS.ConsumableCU{
	set = 'Tarot', atlas = 'Van_cu', key = 'c_chariot_cu',
    pos = {x=7,y=0},
    nb_curse = 2,
    config = {mod_conv = 'm_steel', extra = 1},

    loc_vars = function(self, info_queue, center)
        SMODS.ConsumableCU.loc_vars(self, info_queue, center)
        local fool_c = G.P_CENTERS["c_chariot_dx"] or nil
        local created_card = fool_c and localize{type = 'name_text', key = fool_c.key, set = fool_c.set} or localize('k_none')
        if fool_c then
            info_queue[#info_queue+1] = fool_c
        end
        return {vars = {G.P_CENTERS.m_steel.config.h_x_mult + self.config.extra, localize{type = 'name_text', set = 'Enhanced', key = self.config.mod_conv}, created_card}}
    end,

    use = function(self, card, area, copier)
        local used_tarot = copier or card
        G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
            if G.consumeables.config.card_limit > #G.consumeables.cards then
                play_sound('timpani')
                local card = create_card('Tarot_dx', G.consumeables, nil, nil, nil, nil, 'c_chariot_dx', 'chariot')
                card:add_to_deck()
                G.consumeables:emplace(card)
            end
            DXT.update_cu_buffs()
            DXT.buff_enhanced_cards(self.key)
            used_tarot:juice_up(0.3, 0.5)
        return true end }))
    end,

    can_use = function(self)
        return true
    end,
}

-- Cursed Justice
SMODS.ConsumableCU{
	set = 'Tarot', atlas = 'Van_cu', key = 'c_justice_cu',
    pos = {x=8,y=0},
    nb_curse = 2,
    config = {mod_conv = 'm_glass', extra = 1.5},

    loc_vars = function(self, info_queue, center)
        SMODS.ConsumableCU.loc_vars(self, info_queue, center)
        local fool_c = G.P_CENTERS["c_justice_dx"] or nil
        local created_card = fool_c and localize{type = 'name_text', key = fool_c.key, set = fool_c.set} or localize('k_none')
        if fool_c then
            info_queue[#info_queue+1] = fool_c
        end
        return {vars = {G.P_CENTERS.m_glass.config.Xmult + self.config.extra, localize{type = 'name_text', set = 'Enhanced', key = self.config.mod_conv}, created_card}}
    end,

    use = function(self, card, area, copier)
        local used_tarot = copier or card
        G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
            if G.consumeables.config.card_limit > #G.consumeables.cards then
                play_sound('timpani')
                local card = create_card('Tarot_dx', G.consumeables, nil, nil, nil, nil, 'c_justice_dx', 'justice')
                card:add_to_deck()
                G.consumeables:emplace(card)
            end
            DXT.update_cu_buffs()
            DXT.buff_enhanced_cards(self.key)
            used_tarot:juice_up(0.3, 0.5)
        return true end }))
    end,

    can_use = function(self)
        return true
    end,
}

-- The Cursed Hermit
SMODS.ConsumableCU{
	set = 'Tarot', atlas = 'Van_cu', key = 'c_hermit_cu',
    pos = {x=9,y=0},
    nb_curse = 2,
    config = {extra = 50},

    loc_vars = function(self, info_queue, center)
        SMODS.ConsumableCU.loc_vars(self, info_queue, center)
        return {vars = {self.config.extra}}
    end,

    use = function(self, card, area, copier)
        local used_tarot = copier or card
        G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
            play_sound('timpani')
            used_tarot:juice_up(0.3, 0.5)
            ease_dollars(self.config.extra, true)
            return true end }))
        delay(0.6)
    end,

    can_use = function(self)
        return true
    end,
}

-- The Cursed Wheel of Fortune
SMODS.ConsumableCU{
	set = 'Tarot', atlas = 'Van_cu', key = 'c_wheel_of_fortune_cu',
    pos = {x=0,y=1},
    nb_curse = 1,
    config = {extra = 2},

    loc_vars = function(self, info_queue, center)
        SMODS.ConsumableCU.loc_vars(self, info_queue, center)
        info_queue[#info_queue+1] = G.P_CENTERS.e_foil
        info_queue[#info_queue+1] = G.P_CENTERS.e_holo
        info_queue[#info_queue+1] = G.P_CENTERS.e_polychrome
        return {vars = {SMODS.get_probability_vars(center, 1, self.config.extra, 'wheel_of_fortune')}}
    end,

    use = function(self, card, area, copier)
        local used_tarot = copier or card
        local temp_pool = self.eligible_strength_jokers or {}
        local temp_pool_count = #temp_pool
        G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
            local eligible_card, key = pseudorandom_element(temp_pool, pseudoseed('wheel_of_fortune'))
            local edition = poll_edition('wheel_of_fortune', nil, true, true)
            eligible_card:set_edition(edition, true)
            check_for_unlock({type = 'have_edition'})
            used_tarot:juice_up(0.3, 0.5)
            temp_pool[key] = nil
        return true end }))
        if SMODS.pseudorandom_probability(used_tarot, 'wheel_of_fortune', 1, self.config.extra, 'wheel_of_fortune') and temp_pool_count > 1 then 
            G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
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

-- Cursed Strength
SMODS.ConsumableCU{
	set = 'Tarot', atlas = 'Van_cu', key = 'c_strength_cu',
    pos = {x=1,y=1},
    nb_curse = 2,
    config = {mod_conv = 'up_rank', max_highlighted = 5, min_highlighted = 1},

    loc_vars = function(self, info_queue, center)
        SMODS.ConsumableCU.loc_vars(self, info_queue, center)
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
        local selected_ranks = {}
        local updated_cards_in_hand = {}
        local l_card = nil
        for i = 1, #G.hand.highlighted do
            l_card = G.hand.highlighted[i]
            selected_ranks[SMODS.Ranks[l_card.base.value]] = true
        end 
        for i = 1, #G.hand.cards do
            l_card = G.hand.cards[i]
            if selected_ranks[SMODS.Ranks[l_card.base.value]] then
                updated_cards_in_hand[#updated_cards_in_hand + 1] = G.hand.cards[i]
            end
        end
        for i = 1, #updated_cards_in_hand do
            local percent = 1.15 - (i - 0.999) / (#updated_cards_in_hand - 0.998) * 0.3
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.15,
                func = function()
                    updated_cards_in_hand[i]:flip()
                    play_sound('card1', percent)
                    updated_cards_in_hand[i]:juice_up(0.3, 0.3)
                    return true
                end
            }))
        end
        delay(0.2)
        for i = 1, #G.playing_cards do
            l_card = G.playing_cards[i]
            if selected_ranks[SMODS.Ranks[l_card.base.value]] then
                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    delay = 0.1,
                    func = function()
                        local _card = G.playing_cards[i]
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
        end
        for i = 1, #updated_cards_in_hand do
            local percent = 0.85 + (i - 0.999) / (#updated_cards_in_hand - 0.998) * 0.3
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.15,
                func = function()
                    updated_cards_in_hand[i]:flip()
                    play_sound('tarot2', percent, 0.6)
                    updated_cards_in_hand[i]:juice_up(0.3, 0.3); return true
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
    end
}

-- The Cursed Hanged Man
SMODS.ConsumableCU{
	set = 'Tarot', atlas = 'Van_cu', key = 'c_hanged_man_cu',
    pos = {x=2,y=1},
    nb_curse = 2,
    config = {remove_card = true, max_highlighted = 4, min_highlighted = 1},

    loc_vars = function(self, info_queue, center)
        SMODS.ConsumableCU.loc_vars(self, info_queue, center)
        return {vars = {self.config.max_highlighted}}
    end,

    use = function(self, card, area, copier)
        local used_tarot = copier or card
        local selected_ranks = {}
        local destroyed_cards = {}
        for i=1, #G.hand.highlighted do
            selected_ranks[G.hand.highlighted[i].base.id] = true
        end 
        G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
            play_sound('tarot1')
            used_tarot:juice_up(0.3, 0.5)
        return true end }))
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.2,
            func = function() 
                for k, v in pairs(G.playing_cards) do
                    if selected_ranks[v.base.id] then
                        destroyed_cards[#destroyed_cards+1] = v
                    end
                end
                SMODS.destroy_cards(destroyed_cards)
        return true end }))
        delay(0.3)
    end
}

-- Cursed Death
SMODS.ConsumableCU{
	set = 'Tarot', atlas = 'Van_cu', key = 'c_death_cu',
    pos = {x=3,y=1},
    nb_curse = 2,
    config = {mod_conv = 'card', max_highlighted = 5, min_highlighted = 2},

    loc_vars = function(self, info_queue, center)
        SMODS.ConsumableCU.loc_vars(self, info_queue, center)
        local fool_c = G.P_CENTERS["c_death_dx"] or nil
        local created_card = fool_c and localize{type = 'name_text', key = fool_c.key, set = fool_c.set} or localize('k_none')
        if fool_c then
            info_queue[#info_queue+1] = fool_c
        end
        return {vars = {self.config.max_highlighted}, created_card}
    end,

    use = function(self, card, area, copier)
        local used_tarot = copier or card
        G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
            play_sound('tarot1')
            used_tarot:juice_up(0.3, 0.5)
        return true end }))
        for i=1, #G.hand.highlighted do
            local percent = 1.15 - (i-0.999)/(#G.hand.highlighted-0.998)*0.3
            G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() G.hand.highlighted[i]:flip();play_sound('card1', percent);G.hand.highlighted[i]:juice_up(0.3, 0.3);return true end }))
        end
        delay(0.2)
        local rightmost = G.hand.highlighted[1]
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
        for i=1, 2, 1 do
            G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
                if G.consumeables.config.card_limit > #G.consumeables.cards then
                    play_sound('timpani')
                    if G.consumeables.config.card_limit > #G.consumeables.cards then 
                        local card = create_card('Tarot_dx', G.consumeables, nil, nil, nil, nil, 'c_death_dx', 'death')
                        card:add_to_deck()
                        G.consumeables:emplace(card)
                    end
                    used_tarot:juice_up(0.3, 0.5)
                end
            return true end }))
        end
        G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.2,func = function() G.hand:unhighlight_all(); return true end }))
        delay(0.5)
    end
}

-- The Cursed Temperance
SMODS.ConsumableCU{
	set = 'Tarot', atlas = 'Van_cu', key = 'c_temperance_cu',
    pos = {x=4,y=1},
    nb_curse = 1,
    config = {extra = 60},

    loc_vars = function(self, info_queue, center)
        SMODS.ConsumableCU.loc_vars(self, info_queue, center)
        local _money = 0
        if G.jokers then
            for i = 1, #G.jokers.cards do
                if G.jokers.cards[i].ability.set == 'Joker' then
                    _money = _money + 10
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
                    self.money = self.money + 10
                end
            end
            self.money = math.min(self.money, self.config.extra)
        else
            self.money = 0
        end
    end,
}

-- The Cursed Devil
SMODS.ConsumableCU{
	set = 'Tarot', atlas = 'Van_cu', key = 'c_devil_cu',
    pos = {x=5,y=1},
    nb_curse = 2,
    config = {mod_conv = 'm_gold', extra = 5},

    loc_vars = function(self, info_queue, center)
        SMODS.ConsumableCU.loc_vars(self, info_queue, center)
        local fool_c = G.P_CENTERS["c_devil_dx"] or nil
        local created_card = fool_c and localize{type = 'name_text', key = fool_c.key, set = fool_c.set} or localize('k_none')
        if fool_c then
            info_queue[#info_queue+1] = fool_c
        end
        return {vars = {G.P_CENTERS.m_gold.config.h_dollars + self.config.extra, localize{type = 'name_text', set = 'Enhanced', key = self.config.mod_conv}, created_card}}
    end,

    use = function(self, card, area, copier)
        local used_tarot = copier or card
        G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
            if G.consumeables.config.card_limit > #G.consumeables.cards then
                play_sound('timpani')
                local card = create_card('Tarot_dx', G.consumeables, nil, nil, nil, nil, 'c_devil_dx', 'devil')
                card:add_to_deck()
                G.consumeables:emplace(card)
            end
            DXT.update_cu_buffs()
            DXT.buff_enhanced_cards(self.key)
            used_tarot:juice_up(0.3, 0.5)
        return true end }))
    end,

    can_use = function(self)
        return true
    end,
}

-- The Cursed Tower
SMODS.ConsumableCU{
	set = 'Tarot', atlas = 'Van_cu', key = 'c_tower_cu',
    pos = {x=6,y=1},
    nb_curse = 1,
    config = {mod_conv = 'm_stone', extra = 200},

    loc_vars = function(self, info_queue, center)
        SMODS.ConsumableCU.loc_vars(self, info_queue, center)
        local fool_c = G.P_CENTERS["c_tower_dx"] or nil
        local created_card = fool_c and localize{type = 'name_text', key = fool_c.key, set = fool_c.set} or localize('k_none')
        if fool_c then
            info_queue[#info_queue+1] = fool_c
        end
        return {vars = {G.P_CENTERS.m_stone.config.bonus + self.config.extra, localize{type = 'name_text', set = 'Enhanced', key = self.config.mod_conv}, created_card}}
    end,

    use = function(self, card, area, copier)
        local used_tarot = copier or card
        G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
            if G.consumeables.config.card_limit > #G.consumeables.cards then
                play_sound('timpani')
                local card = create_card('Tarot_dx', G.consumeables, nil, nil, nil, nil, 'c_tower_dx', 'tower')
                card:add_to_deck()
                G.consumeables:emplace(card)
            end
            DXT.update_cu_buffs()
            DXT.buff_enhanced_cards(self.key)
            used_tarot:juice_up(0.3, 0.5)
        return true end }))
    end,

    can_use = function(self)
        return true
    end,
}

-- The Cursed Star
SMODS.ConsumableCU{
	set = 'Tarot', atlas = 'Van_cu', key = 'c_star_cu',
    pos = {x=7,y=1},
    nb_curse = 2,
    config = {suit_conv = 'Diamonds'},
    unique = true,

    loc_vars = function(self, info_queue, center)
        SMODS.ConsumableCU.loc_vars(self, info_queue, center)
        local fool_c = G.P_CENTERS["c_star_dx"] or nil
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
                    local card = create_card('Tarot_dx', G.consumeables, nil, nil, nil, nil, 'c_star_dx', 'star')
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
}

-- The Cursed Moon
SMODS.ConsumableCU{
	set = 'Tarot', atlas = 'Van_cu', key = 'c_moon_cu',
    pos = {x=8,y=1},
    nb_curse = 2,
    config = {suit_conv = 'Clubs'},
    unique = true,

    loc_vars = function(self, info_queue, center)
        SMODS.ConsumableCU.loc_vars(self, info_queue, center)
        local fool_c = G.P_CENTERS["c_moon_dx"] or nil
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
                    local card = create_card('Tarot_dx', G.consumeables, nil, nil, nil, nil, 'c_moon_dx', 'moon')
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
}

-- The Cursed Sun
SMODS.ConsumableCU{
	set = 'Tarot', atlas = 'Van_cu', key = 'c_sun_cu',
    pos = {x=9,y=1},
    nb_curse = 2,
    config = {suit_conv = 'Hearts'},
    unique = true,

    loc_vars = function(self, info_queue, center)
        SMODS.ConsumableCU.loc_vars(self, info_queue, center)
        local fool_c = G.P_CENTERS["c_sun_dx"] or nil
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
                    local card = create_card('Tarot_dx', G.consumeables, nil, nil, nil, nil, 'c_sun_dx', 'sun')
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
}

-- Cursed Judgement
SMODS.ConsumableCU{
	set = 'Tarot', atlas = 'Van_cu', key = 'c_judgement_cu',
    pos = {x=0,y=2},
    nb_curse = 1,

    loc_vars = function(self, info_queue, center)
        SMODS.ConsumableCU.loc_vars(self, info_queue, center)
        info_queue[#info_queue+1] = G.P_CENTERS.e_foil
        info_queue[#info_queue+1] = G.P_CENTERS.e_holo
        info_queue[#info_queue+1] = G.P_CENTERS.e_polychrome
        return {}
    end,

    use = function(self, card, area, copier)
        local used_tarot = copier or card
            G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
                play_sound('timpani')
                local rarity = 0.98
                local card = create_card('Joker', G.jokers, false, rarity, nil, nil, nil, 'jud')
                local edition = poll_edition('cu_judg', nil, true, true)
                if not card.edition then card:set_edition(edition) end
                card:add_to_deck()
                G.jokers:emplace(card)
                used_tarot:juice_up(0.3, 0.5)
                return true end }))
            delay(0.6)
    end,

    can_use = function(self)
        return #G.jokers.cards < G.jokers.config.card_limit or self.area == G.jokers
    end,
}

-- The Cursed World
SMODS.ConsumableCU{
	set = 'Tarot', atlas = 'Van_cu', key = 'c_world_cu',
    pos = {x=1,y=2},
    nb_curse = 2,
    config = {suit_conv = 'Spades'},
    unique = true,

    loc_vars = function(self, info_queue, center)
        SMODS.ConsumableCU.loc_vars(self, info_queue, center)
        local fool_c = G.P_CENTERS["c_world_dx"] or nil
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
                    local card = create_card('Tarot_dx', G.consumeables, nil, nil, nil, nil, 'c_world_dx', 'world')
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
}