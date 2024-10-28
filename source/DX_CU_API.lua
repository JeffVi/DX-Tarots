local js_mod = SMODS.current_mod
local js_config = assert(NFS.load(js_mod.path..'config.lua')())--js_mod.config

local dx_locs = {
    dx =  {
        label = "DX Version",
        description = {
            name = "Deluxe",
            text = {
                "Enhanced effect"
            }
        }
    },
    cursed =  {
        label = "Cursed Version",
        description = {
            name = "Cursed",
            text = {
                "Get a random",
                "{X:black,C:white} curse {} if used",
                "{C:attention}(x#1#){}"
            }
        }
    }
}

SMODS.process_loc_text(G.localization.descriptions.Other, 'dx', dx_locs.dx.description)
SMODS.process_loc_text(G.localization.descriptions.Other, 'cursed', dx_locs.cursed.description)

-- DX Consumables
SMODS.ConsumableDX = SMODS.Center:extend {
    unlocked = true,
    discovered = false,
    consumeable = true,
    pos = { x = 0, y = 0 },
    atlas = 'Tarot',
    extra_type = '_dx',
    legendaries = {},
    cost = 5,
    config = {},
    class_prefix = 'c',
    required_params = {
        'set',
        'key',
    },
    inject = function(self)
        G.P_CENTERS[self.key] = self
        G.P_CENTER_POOLS[self.set..self.extra_type] = G.P_CENTER_POOLS[self.set..self.extra_type] or {}
        SMODS.insert_pool(G.P_CENTER_POOLS[self.set..self.extra_type], self)
        SMODS.insert_pool(G.P_CENTER_POOLS['Consumeables'], self)
        self.type = SMODS.ConsumableTypes[self.set]
        if self.hidden then
            self.soul_set = self.soul_set or 'Spectral'
            self.soul_rate = self.soul_rate or 0.003
            table.insert(self.legendaries, self)
        end
        if self.type and self.type.inject_card and type(self.type.inject_card) == 'function' then
            self.type:inject_card(self)
        end
    end,
    delete = function(self)
        if self.type and self.type.delete_card and type(self.type.delete_card) == 'function' then
            G.P_CENTERS[self.key] = nil
            SMODS.remove_pool(G.P_CENTER_POOLS[self.set..self.extra_type], self.key)
            local j
            for i, v in ipairs(self.obj_buffer) do
                if v == self.key then j = i end
            end
            if j then table.remove(self.obj_buffer, j) end
            self = nil
        end
        SMODS.remove_pool(G.P_CENTER_POOLS['Consumeables'], self.key)
        SMODS.Consumable.super.delete(self)
    end,
    loc_vars = function(self, info_queue, center)
        --info_queue[#info_queue+1] = {key = 'dx', set = 'Other'}
        return {}
    end,
    set_card_type_badge = function(self, card, badges)
        badges[#badges+1] = create_badge(dx_locs.dx.label, G.C.DARK_EDITION, nil, 1.0)
    end
}

-- CU Consumables
SMODS.ConsumableCU = SMODS.Center:extend {
    unlocked = true,
    discovered = false,
    consumeable = true,
    pos = { x = 0, y = 0 },
    atlas = 'Tarot',
    extra_type = '_cu',
    nb_curse = 1,
    legendaries = {},
    cost = 5,
    config = {},
    class_prefix = 'c',
    required_params = {
        'set',
        'key',
    },
    inject = function(self)
        G.P_CENTERS[self.key] = self
        G.P_CENTER_POOLS[self.set..self.extra_type] = G.P_CENTER_POOLS[self.set..self.extra_type] or {}
        SMODS.insert_pool(G.P_CENTER_POOLS[self.set..self.extra_type], self)
        SMODS.insert_pool(G.P_CENTER_POOLS['Consumeables'], self)
        self.type = SMODS.ConsumableTypes[self.set]
        if self.hidden then
            self.soul_set = self.soul_set or 'Spectral'
            self.soul_rate = self.soul_rate or 0.003
            table.insert(self.legendaries, self)
        end
        if self.type and self.type.inject_card and type(self.type.inject_card) == 'function' then
            self.type:inject_card(self)
        end
    end,
    delete = function(self)
        if self.type and self.type.delete_card and type(self.type.delete_card) == 'function' then
            G.P_CENTERS[self.key] = nil
            SMODS.remove_pool(G.P_CENTER_POOLS[self.set..self.extra_type], self.key)
            local j
            for i, v in ipairs(self.obj_buffer) do
                if v == self.key then j = i end
            end
            if j then table.remove(self.obj_buffer, j) end
            self = nil
        end
        SMODS.remove_pool(G.P_CENTER_POOLS['Consumeables'], self.key)
        SMODS.Consumable.super.delete(self)
    end,
    loc_vars = function(self, info_queue, center)
        info_queue[#info_queue+1] = {key = 'cursed', set = 'Other', vars = {self.nb_curse or 1}}
        return {}
    end,
    set_card_type_badge = function(self, card, badges)
        badges[#badges+1] = create_badge(dx_locs.cursed.label, G.C.BLACK, nil, 1.0)
    end
}

-- DX Boosters
SMODS.BoosterDX = SMODS.Booster:extend {
    update_pack = SMODS.Booster.update_pack,
    --extra_type = '_dx',

    --[[
    inject = function(self)
        G.P_CENTER_POOLS['Booster'..self.extra_type] = G.P_CENTER_POOLS['Booster'..self.extra_type] or {}
        SMODS.insert_pool(G.P_CENTER_POOLS['Booster'..self.extra_type], self)
        SMODS.Booster.inject(self)
    end,

    delete = function(self)
        if self.type and self.type.delete_card and type(self.type.delete_card) == 'function' then
            SMODS.remove_pool(G.P_CENTER_POOLS['Booster'..self.extra_type], self.key)
        end
        SMODS.Booster.delete(self)
    end,
    ]]

    set_card_type_badge = function(self, card, badges)
        badges[1] = create_badge(localize('k_booster'), get_type_colour(self or card.config, card), nil, 1.2)
        badges[#badges+1] = create_badge("DX Version", G.C.DARK_EDITION, nil, 1.0)
    end,

    loc_vars = function(self, info_queue, card)
        return { vars = {self.config.choose, self.config.extra} }
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


-- Prevents duplicates between normal and DX/CU version
local card_set_ability_ref = Card.set_ability
function Card.set_ability(self, center, initial, delay_sprites)

    card_set_ability_ref(self, center, initial, delay_sprites)

    if self.ability and self.ability.consumeable and self.ability.name and self.ability.set then 
        if self.ability.set == 'Tarot' or self.ability.set == 'Planet' or self.ability.set == 'Spectral' or self.ability.set == 'Booster' or self.ability.set == 'Alchemical' then
            if not G.OVERLAY_MENU then 
                for k, v in pairs(G.P_CENTERS) do
                    if v.name == self.ability.name then
                        local normal_k = k
                        if self.config.center.extra_type == '_dx' then
                            normal_k = string.sub(normal_k, 1, -4)
                        end
                        if self.config.center.extra_type == '_cu' then
                            normal_k = string.sub(normal_k, 1, -4)
                        end
                        -- Add normal/DX/CU version
                        G.GAME.used_jokers[normal_k] = true
                        G.GAME.used_jokers[normal_k..'_dx'] = true
                        G.GAME.used_jokers[normal_k..'_cu'] = true
                    end
                end
            end
        end
    end
end

-- Prevents duplicates between normal and DX/CU version
local card_remove_ref = Card.remove
function Card.remove(self)

    if self.ability and self.ability.consumeable and self.ability.name and self.ability.set and G.consumeables then 
        if self.ability.set == 'Tarot' or self.ability.set == 'Planet' or self.ability.set == 'Spectral' or self.ability.set == 'Booster' or self.ability.set == 'Alchemical' then
            if not G.OVERLAY_MENU then 
                for k, v in pairs(G.P_CENTERS) do
                    if v.name == self.ability.name then
                        local normal_k = k
                        if self.config.center.extra_type == '_dx' then
                            normal_k = string.sub(normal_k, 1, -4)
                        end
                        if self.config.center.extra_type == '_cu' then
                            normal_k = string.sub(normal_k, 1, -4)
                        end
                        local consumeable_exists
                        for k, v in pairs(G.consumeables.cards) do
                            if v and type(v) == 'table' and (
                                v.config.center.key == normal_k 
                                or v.config.center.key == normal_k..'_dx'
                                or v.config.center.key == normal_k..'_cu'
                            ) then
                                consumeable_exists = true
                            end
                        end
                        if not consumeable_exists then 
                            -- Remove normal/DX/CU version
                            G.GAME.used_jokers[normal_k] = nil
                            G.GAME.used_jokers[normal_k..'_dx'] = nil
                            G.GAME.used_jokers[normal_k..'_cu'] = nil
                        end
                    end
                end
            end
        end
    end

    card_remove_ref(self)
end