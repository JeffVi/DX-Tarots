-- Curses from the vanilla boss blinds, and the final curse
-- Loaded after curse_api.lua

local cu = DXT.curse_utils
local active, triggered = DXT.is_curse_active, DXT.is_curse_triggered
local lift, juice, juice_later, views = cu.lift, cu.juice, cu.juice_later, cu.views
local hand_played, any_scoring, face_down_count, to_hand = cu.hand_played, cu.any_scoring, cu.face_down_count, cu.to_hand
local increase_blind_size, mult_malus, debuff_curse = cu.increase_blind_size, cu.mult_malus, cu.debuff_curse

DXT.Curse{
    key = 'cu_ox', name = 'The Ox', pos = {x = 0, y = 2},
    config = {extra = 5, lift = 3},
    loc_vars = function(self, curse)
        return {self.config.extra, localize(G.GAME.current_round.most_played_poker_hand, 'poker_hands')}
    end,
    calculate = function(self, curse, context)
        if hand_played(context) and active(curse) and context.scoring_name == G.GAME.current_round.most_played_poker_hand then
            curse.triggered = true
            G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.7, func = function()
                ease_dollars(-self.config.extra, true)
                juice(curse)
                return true end }))
        end
        if context.blind_defeated and not curse.triggered then lift(curse) end
    end,
}

DXT.Curse{
    key = 'cu_hook', name = 'The Hook', pos = {x = 0, y = 7},
    config = {extra = 1, lift = 60},
    loc_vars = function(self, curse) return {self.config.extra} end,
    calculate = function(self, curse, context)
        if context.press_play and active(curse) then
            G.E_MANAGER:add_event(Event({func = function()
                local any_selected = nil
                local _cards = {}
                for _, v in ipairs(G.hand.cards) do
                    _cards[#_cards+1] = v
                end
                for i = 1, self.config.extra do
                    if G.hand.cards[i] then
                        local selected_card, card_key = pseudorandom_element(_cards, pseudoseed('hook'))
                        G.hand:add_to_highlighted(selected_card, true)
                        table.remove(_cards, card_key)
                        any_selected = true
                        play_sound('card1', 1)
                    end
                end
                if any_selected then G.FUNCS.discard_cards_from_highlighted(nil, true) end
                juice(curse)
                return true end }))
            delay(0.7)
        end
        if context.pre_discard then
            lift(curse, math.min(#context.full_hand, G.discard.config.card_limit - #G.play.cards))
        end
    end,
}

DXT.Curse{
    key = 'cu_mouth', name = 'The Mouth', pos = {x = 0, y = 18},
    config = {extra = 0.6, lift = 3},
    loc_vars = function(self, curse)
        return {self.config.extra, (curse.ability.hand and '('..localize(curse.ability.hand, 'poker_hands')..')') or ""}
    end,
    calculate = function(self, curse, context)
        if hand_played(context) and active(curse) then
            if curse.ability.hand and curse.ability.hand ~= context.scoring_name then curse.triggered = true end
            curse.ability.hand = curse.ability.hand or context.scoring_name
        end
        if context.blind_defeated then
            curse.ability.hand = nil
            if G.GAME.current_round.hands_played <= 1 then lift(curse) end
        end
        return mult_malus(curse, context)
    end,
}

DXT.Curse{
    key = 'cu_fish', name = 'The Fish', pos = {x = 0, y = 5},
    config = {chanceN = 2, chanceD = 5, lift = 25},
    loc_vars = function(self, curse) return {self.config.chanceN, self.config.chanceD} end,
    calculate = function(self, curse, context)
        if context.press_play and active(curse) then curse.triggered = true end
        if context.hand_drawn then curse.triggered = false end
        if to_hand(context) and active(curse) and curse.triggered and triggered(curse) then
            juice(curse)
            return {stay_flipped = true}
        end
        if context.pre_discard then lift(curse, face_down_count(context.full_hand)) end
    end,
}

debuff_curse({key = 'cu_club', name = 'The Club', pos = {x = 0, y = 4}}, function(card) return card:is_suit('Clubs', true) end)

DXT.Curse{
    key = 'cu_manacle', name = 'The Manacle', pos = {x = 0, y = 8},
    config = {extra = 1, lift = 7},
    loc_vars = function(self, curse) return {self.config.extra} end,
    calculate = function(self, curse, context)
        if context.setting_blind and active(curse) and not curse.triggered and G.GAME.current_round.hands_left > self.config.extra then
            curse.triggered = true
            G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.7, func = function()
                G.hand:change_size(-1)
                juice(curse)
                return true end }))
        end
        -- Hand size is given back for the last hands, or when the blind is defeated
        if context.final_scoring_step and curse.triggered and G.GAME.current_round.hands_left <= self.config.extra then
            curse.triggered = false
            G.hand:change_size(1)
        end
        if context.blind_defeated and curse.triggered then G.hand:change_size(1) end
        if hand_played(context) and #context.scoring_hand == 5 then lift(curse) end
    end,
}

DXT.Curse{
    key = 'cu_tooth', name = 'The Tooth', pos = {x = 0, y = 22},
    config = {chanceN = 2, chanceD = 5, lift = 40},
    loc_vars = function(self, curse) return {self.config.chanceN, self.config.chanceD} end,
    calculate = function(self, curse, context)
        if context.press_play and active(curse) then
            G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.2, func = function()
                for i = 1, #G.play.cards do
                    if triggered(curse) then
                        G.E_MANAGER:add_event(Event({func = function()
                            G.play.cards[i]:juice_up()
                            if views[curse] then views[curse]:juice_up(0.3, 0.2) end
                            return true end }))
                        ease_dollars(-1)
                        delay(0.23)
                    end
                end
                return true end }))
        end
        if hand_played(context) then lift(curse, #context.full_hand) end
    end,
}

DXT.Curse{
    key = 'cu_wall', name = 'The Wall', pos = {x = 0, y = 9},
    config = {extra = 1.5, lift = 2},
    loc_vars = function(self, curse) return {math.floor(self.config.extra * 100 - 100)} end,
    calculate = function(self, curse, context)
        if context.setting_blind and active(curse) then
            curse.triggered = true
            increase_blind_size(curse, self.config.extra)
        end
        if context.blind_defeated and DXT.to_number(G.GAME.chips - G.GAME.blind.chips) > DXT.to_number(G.GAME.blind.chips / 2) then lift(curse) end
    end,
}

DXT.Curse{
    key = 'cu_house', name = 'The House', pos = {x = 0, y = 3},
    config = {chanceN = 2, chanceD = 3, lift = 15},
    loc_vars = function(self, curse) return {self.config.chanceN, self.config.chanceD} end,
    calculate = function(self, curse, context)
        if to_hand(context) and active(curse) and G.GAME.current_round.hands_played == 0 and G.GAME.current_round.discards_used == 0 and triggered(curse) then
            juice(curse)
            return {stay_flipped = true}
        end
        if context.press_play then lift(curse, face_down_count(G.hand.highlighted)) end
    end,
}

DXT.Curse{
    key = 'cu_mark', name = 'The Mark', pos = {x = 0, y = 23},
    config = {chanceN = 1, chanceD = 2, lift = 7},
    loc_vars = function(self, curse) return {self.config.chanceN, self.config.chanceD} end,
    calculate = function(self, curse, context)
        if to_hand(context) and active(curse) and context.other_card:is_face(true) and triggered(curse) then
            juice(curse)
            return {stay_flipped = true}
        end
        if context.pre_discard and face_down_count(context.full_hand) > 2 then lift(curse) end
    end,
}

DXT.Curse{
    key = 'cu_wheel', name = 'The Wheel', pos = {x = 0, y = 10},
    config = {chanceN = 1, chanceD = 8, lift = 5},
    loc_vars = function(self, curse) return {self.config.chanceN, self.config.chanceD} end,
    calculate = function(self, curse, context)
        if to_hand(context) and active(curse) and triggered(curse) then
            juice(curse)
            return {stay_flipped = true}
        end
        if context.press_play and face_down_count(G.hand.highlighted) > 2 then lift(curse) end
    end,
}

DXT.Curse{
    key = 'cu_arm', name = 'The Arm', pos = {x = 0, y = 11},
    config = {chanceN = 1, chanceD = 6, lift = 40},
    loc_vars = function(self, curse) return {self.config.chanceN, self.config.chanceD} end,
    calculate = function(self, curse, context)
        if hand_played(context) then
            local level = DXT.to_number(G.GAME.hands[context.scoring_name].level)
            if active(curse) and level > 1 and triggered(curse) then
                level_up_hand(views[curse], context.scoring_name, nil, -1)
                juice(curse)
            end
            lift(curse, DXT.to_number(G.GAME.hands[context.scoring_name].level))
        end
    end,
}

DXT.Curse{
    key = 'cu_psychic', name = 'The Psychic', pos = {x = 0, y = 12},
    config = {extra = 0.6, lift = 12},
    loc_vars = function(self, curse) return {self.config.extra} end,
    calculate = function(self, curse, context)
        if hand_played(context) then
            if active(curse) and #context.full_hand < 5 then curse.triggered = true end
            if #context.full_hand == 5 then lift(curse) end
        end
        return mult_malus(curse, context)
    end,
}

debuff_curse({key = 'cu_goad', name = 'The Goad', pos = {x = 0, y = 13}}, function(card) return card:is_suit('Spades', true) end)

DXT.Curse{
    key = 'cu_water', name = 'The Water', pos = {x = 0, y = 14},
    config = {extra = 1, lift = 3},
    loc_vars = function(self, curse) return {self.config.extra} end,
    calculate = function(self, curse, context)
        if context.setting_blind and active(curse) then
            curse.triggered = true
            G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.7, func = function()
                ease_discard(-self.config.extra)
                juice(curse)
                return true end }))
        end
        if context.blind_defeated and G.GAME.current_round.discards_used == 0 then lift(curse) end
    end,
}

DXT.Curse{
    key = 'cu_eye', name = 'The Eye', pos = {x = 0, y = 17},
    config = {extra = 0.6, lift = 3},
    loc_vars = function(self, curse)
        return {self.config.extra, localize(curse.ability.indicate_trig and 'k_dxt_active' or 'k_dxt_inactive')}
    end,
    calculate = function(self, curse, context)
        curse.ability.hand = curse.ability.hand or {}
        if context.debuff_hand and active(curse) then
            -- When only selected, shows if this hand would trigger the curse
            if not context.check then
                if curse.ability.hand[context.scoring_name] then curse.triggered = true end
                curse.ability.hand[context.scoring_name] = true
            end
            curse.ability.indicate_trig = curse.ability.hand[context.scoring_name] or false
        end
        if context.blind_defeated then
            local played_hands = 0
            for _, v in pairs(curse.ability.hand) do
                if v then played_hands = played_hands + 1 end
            end
            if G.GAME.current_round.hands_played <= played_hands then lift(curse) end
            curse.ability.hand = {}
            curse.ability.indicate_trig = false
        end
        return mult_malus(curse, context)
    end,
}

debuff_curse({key = 'cu_plant', name = 'The Plant', pos = {x = 0, y = 19}}, function(card) return card:is_face(true) end)

DXT.Curse{
    key = 'cu_needle', name = 'The Needle', pos = {x = 0, y = 20},
    config = {extra = 1, lift = 3},
    loc_vars = function(self, curse) return {self.config.extra} end,
    calculate = function(self, curse, context)
        if context.setting_blind and active(curse) and G.GAME.current_round.hands_left > 0 then
            curse.triggered = true
            G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.7, func = function()
                ease_hands_played(-self.config.extra)
                juice(curse)
                return true end }))
        end
        if context.blind_defeated and G.GAME.current_round.hands_left == 0 then lift(curse) end
    end,
}

debuff_curse({key = 'cu_head', name = 'The Head', pos = {x = 0, y = 21}}, function(card) return card:is_suit('Hearts', true) end)
debuff_curse({key = 'cu_window', name = 'The Window', pos = {x = 0, y = 6}}, function(card) return card:is_suit('Diamonds', true) end)

DXT.Curse{
    -- Only the first draw after a Play or Discard, once per blind (triggered is reset when the blind is defeated)
    key = 'cu_serpent', name = 'The Serpent', pos = {x = 0, y = 15},
    config = {extra = 2, lift = 80},
    loc_vars = function(self, curse) return {self.config.extra} end,
    -- Steamodded must not refill the hand around the limited draw: its refill is queued as soon as
    -- the hand has room, before the draw itself, so this starts at the Play or Discard
    modifies_draw = function(self, curse) return curse.ability.limiting_draw end,
    calculate = function(self, curse, context)
        if context.press_play or context.pre_discard then
            curse.ability.limiting_draw = (active(curse) and not curse.triggered) or nil
        end
        if context.blind_defeated then curse.ability.limiting_draw = nil end
        if context.drawing_cards and active(curse) and not curse.triggered
        and not (G.STATE == G.STATES.TAROT_PACK or G.STATE == G.STATES.SPECTRAL_PACK)
        and (G.GAME.current_round.hands_played > 0 or G.GAME.current_round.discards_used > 0) then
            curse.triggered = true
            juice(curse)
            return {cards_to_draw = math.min(#G.deck.cards, self.config.extra)}
        end
        if context.hand_drawn then lift(curse, #context.hand_drawn) end
    end,
}

DXT.Curse{
    key = 'cu_pillar', name = 'The Pillar', pos = {x = 0, y = 16},
    config = {chanceN = 2, chanceD = 5, lift = 9},
    debuffs = function(card) return card.ability.played_this_ante end,
    loc_vars = function(self, curse) return {self.config.chanceN, self.config.chanceD} end,
    calculate = function(self, curse, context)
        if hand_played(context) and any_scoring(context, function(card) return card.debuff end) then lift(curse) end
    end,
}

DXT.Curse{
    key = 'cu_flint', name = 'The Flint', pos = {x = 0, y = 24},
    config = {extra = 0.75, lift = 20},
    loc_vars = function(self, curse) return {math.floor(100 - self.config.extra * 100)} end,
    calculate = function(self, curse, context)
        if context.initial_scoring_step and active(curse) then
            juice_later(curse)
            return {xchips = self.config.extra, xmult = self.config.extra}
        end
        if hand_played(context) then lift(curse) end
    end,
}

-- Final curse: pulled when every curse was pulled, then each new curse makes it stronger
DXT.Curse{
    key = 'cu_final_vessel', name = 'Violet Vessel', pos = {x = 0, y = 29},
    config = {type = 'final_curse', extra = 1.5},
    loc_vars = function(self, curse)
        local exp = curse.ability.exp or 1
        return {math.floor((self.config.extra ^ exp) * 100 - 100), exp}
    end,
    calculate = function(self, curse, context)
        if context.setting_blind then
            curse.triggered = true
            increase_blind_size(curse, self.config.extra ^ (curse.ability.exp or 1))
        end
    end,
}
