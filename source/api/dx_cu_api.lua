-- Same as SMODS.Consumable, but the card goes in the DX/CU pool (e.g. Tarot_dx) instead of the vanilla one
local function inject_extra_type(self)
    G.P_CENTER_POOLS[self.set..self.extra_type] = G.P_CENTER_POOLS[self.set..self.extra_type] or {}
    self.undiscovered = self.undiscovered or SMODS.UndiscoveredSprites[self.set..self.extra_type]
    local omit = self.omit
    self.omit = true
    SMODS.Consumable.inject(self)
    self.omit = omit
    if not omit then SMODS.insert_pool(G.P_CENTER_POOLS[self.set..self.extra_type], self) end
end

local function delete_extra_type(self)
    if not self.omit then SMODS.remove_pool(G.P_CENTER_POOLS[self.set..self.extra_type], self.key) end
    self.omit = true
    return SMODS.Consumable.delete(self)
end

-- Type badge (e.g. Tarot), its text can be changed with type_badge (a localization key, or a function returning the text)
local function type_badge(self, card, badges)
    local text = type(self.type_badge) == 'function' and self:type_badge() or localize(self.type_badge or 'k_'..string.lower(self.set))
    badges[1] = create_badge(text, get_type_colour(self or card.config, card), nil, 1.2)
end

-- DX Consumables
SMODS.ConsumableDX = SMODS.Consumable:extend {
    extra_type = '_dx',
    cost = 5,
    inject = inject_extra_type,
    delete = delete_extra_type,
    loc_vars = function(self, info_queue, center)
        return {}
    end,
    set_card_type_badge = function(self, card, badges)
        type_badge(self, card, badges)
        badges[#badges+1] = create_badge(localize('k_dx_version'), G.C.DARK_EDITION, nil, 1.0)
    end
}

-- DX Planets: upgrade their poker hand by 2 levels
SMODS.PlanetDX = SMODS.ConsumableDX:extend {
    set = 'Planet',
    atlas = 'Van_dx',
    loc_vars = function(self, info_queue, center)
        SMODS.ConsumableDX.loc_vars(self, info_queue, center)
        local hand = G.GAME.hands[self.config.hand_type]
        return {vars = {
            hand.level, localize(self.config.hand_type, 'poker_hands'), hand.l_mult * 2, hand.l_chips * 2,
            colours = {(DXT.to_number(hand.level) == 1 and G.C.UI.TEXT_DARK or G.C.HAND_LEVELS[math.min(7, DXT.to_number(hand.level))])}
        }}
    end,
    use = function(self, card, area, copier)
        local used_tarot = copier or card
        local hand = G.GAME.hands[self.config.hand_type]
        update_hand_text({sound = 'button', volume = 0.7, pitch = 0.8, delay = 0.3}, {handname = localize(self.config.hand_type, 'poker_hands'), chips = hand.chips, mult = hand.mult, level = hand.level})
        level_up_hand(used_tarot, self.config.hand_type, false, 2)
        update_hand_text({sound = 'button', volume = 0.7, pitch = 1.1, delay = 0}, {mult = 0, chips = 0, handname = '', level = ''})
    end,
}

-- CU Consumables
SMODS.ConsumableCU = SMODS.Consumable:extend {
    extra_type = '_cu',
    nb_curse = 1,
    cost = 5,
    inject = inject_extra_type,
    delete = delete_extra_type,
    loc_vars = function(self, info_queue, center)
        info_queue[#info_queue+1] = {key = 'cursed', set = 'Other', vars = {self.nb_curse or 1}}
        return {}
    end,
    set_card_type_badge = function(self, card, badges)
        type_badge(self, card, badges)
        badges[#badges+1] = create_badge(localize('k_cursed_version'), G.C.BLACK, nil, 1.0)
    end
}

-- DX Boosters
SMODS.BoosterDX = SMODS.Booster:extend {
    update_pack = SMODS.Booster.update_pack,
    unique = true,

    -- Shop weight scaled by the DX Boosters rate setting
    get_weight = function(self)
        return (self.weight or 1) * DXT.rate('booster_dx')
    end,

    set_card_type_badge = function(self, card, badges)
        badges[1] = create_badge(localize('k_booster'), get_type_colour(self or card.config, card), nil, 1.2)
        badges[#badges+1] = create_badge(localize('k_dx_version'), G.C.DARK_EDITION, nil, 1.0)
    end,

    -- Boosters of the same size share their text (loc_key)
    loc_vars = function(self, info_queue, card)
        local ret = SMODS.Booster.loc_vars(self, info_queue, card)
        ret.key = self.loc_key
        return ret
    end,
}


-- Track cursed tarots usage
local Game_init_game_object_ref = Game.init_game_object
function Game.init_game_object(self)

    local ret = Game_init_game_object_ref(self)
    ret.used_cu_augments = {}
    return ret
end

-- Manage usage of DX/CU consumables
local card_use_consumeable_ref = Card.use_consumeable
function Card.use_consumeable(self, area, copier)

    -- Keep track of used curses
    if self.config.center and self.config.center.extra_type == '_cu' then 
        G.GAME.used_cu_augments[self.config.center_key] = (G.GAME.used_cu_augments[self.config.center_key] or 0) + 1
    end
    card_use_consumeable_ref(self, area, copier)
end

-- Manage consumable usage
local set_consumeable_usage_ref = set_consumeable_usage
function set_consumeable_usage(card)

    set_consumeable_usage_ref(card)

    -- Last consumable used, set it to vanilla version
    if card.config.center_key and card.ability.consumeable and (card.config.center.set == 'Tarot' or card.config.center.set == 'Planet') and (card.config.center.extra_type == '_dx' or card.config.center.extra_type == '_cu') then 
        G.E_MANAGER:add_event(Event({
            trigger = 'immediate',
            func = function()
            G.E_MANAGER:add_event(Event({
                trigger = 'immediate',
                func = function()
                G.GAME.last_tarot_planet = string.sub(card.config.center_key, 1, -4)
                    return true
                end
            }))
                return true
            end
        }))
    end
end


-- Sets whose normal/DX/CU versions count as the same card
local linked_sets = {Tarot = true, Planet = true, Spectral = true, Booster = true}

-- Key of the normal version of a center
local function normal_key(center)
    if center.extra_type == '_dx' or center.extra_type == '_cu' then
        return string.sub(center.key, 1, -4)
    end
    return center.key
end

local function set_linked_used(normal_k, value)
    G.GAME.used_jokers[normal_k] = value
    G.GAME.used_jokers[normal_k..'_dx'] = value
    G.GAME.used_jokers[normal_k..'_cu'] = value
end

-- Prevents duplicates between normal and DX/CU version
local card_set_ability_ref = Card.set_ability
function Card.set_ability(self, center, initial, delay_sprites)

    card_set_ability_ref(self, center, initial, delay_sprites)

    if self.ability and self.ability.consumeable and self.ability.set and linked_sets[self.ability.set] and self.config.center.key and not G.OVERLAY_MENU then
        -- Add normal/DX/CU version
        set_linked_used(normal_key(self.config.center), true)
    end
end

-- Prevents duplicates between normal and DX/CU version
local card_remove_ref = Card.remove
function Card.remove(self)

    if self.ability and self.ability.consumeable and self.ability.set and linked_sets[self.ability.set] and self.config.center.key and G.consumeables and not G.OVERLAY_MENU then
        local normal_k = normal_key(self.config.center)
        local consumeable_exists
        for _, v in pairs(G.consumeables.cards) do
            if v ~= self and type(v) == 'table' and v.config and v.config.center and normal_key(v.config.center) == normal_k then
                consumeable_exists = true
            end
        end
        if not consumeable_exists then
            -- Remove normal/DX/CU version
            set_linked_used(normal_k, nil)
        end
    end

    card_remove_ref(self)
end
