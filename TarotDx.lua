--- STEAMODDED HEADER
--- MOD_NAME: Deluxe Consumables
--- MOD_ID: JeffDeluxeConsumablesPack
--- MOD_AUTHOR: [JeffVi]
--- MOD_DESCRIPTION: Add Deluxe versions of consumables
--- PRIORITY: 1000
--- VERSION: 1.0.0
--- LOADER_VERSION_GEQ: 1.0.0

----------------------------------------------
------------MOD CODE -------------------------

---------- local functions & variables ----------

local enhanced_prototype_centers = {}
local enhanced_prototype_descriptions = {}
local js_mod = SMODS.current_mod
local js_config = assert(NFS.load(js_mod.path..'config.lua')())--js_mod.config
js_mod.prefix_config = {key = false, atlas = false, shader = false, card_key = false}

local function setUpDX()

    -- Add consumables
    G.P_CENTER_POOLS.Tarot_dx = {}
    G.P_CENTER_POOLS.Tarot_cu = {}
    G.P_CENTER_POOLS.Planet_dx = {}
    G.P_CENTER_POOLS.Spectral_dx = {}
    --G.P_CENTER_POOLS.Booster_dx = {}

    -- Save vanilla enhanced centers
    enhanced_prototype_centers.m_bonus = G.P_CENTERS.m_bonus.config.bonus
    enhanced_prototype_centers.m_mult = G.P_CENTERS.m_mult.config.mult
    enhanced_prototype_centers.m_glass = G.P_CENTERS.m_glass.config.Xmult
    enhanced_prototype_centers.m_steel = G.P_CENTERS.m_steel.config.h_x_mult
    enhanced_prototype_centers.m_stone = G.P_CENTERS.m_stone.config.bonus
    enhanced_prototype_centers.m_gold = G.P_CENTERS.m_gold.config.h_dollars
    
    -- Save vanilla enhanced descriptions
    G.localization.descriptions.Enhanced.m_wild_bak = G.localization.descriptions.Enhanced.m_wild

    -- Localizations
    G.localization.descriptions.Enhanced.m_wild_cu = {
        name = "Wild Card",
        text = {
            "Can be used",
            "as any suit",
            "Copy rank of",
            "its left card"
        }
    }
    
    unique_info =  {
        label = "Unique",
        description = {
            name = "Unique",
            text = {
                "Cannot be pulled",
                "again this run"
            }
        }
    }
    SMODS.process_loc_text(G.localization.descriptions.Other, 'unique', unique_info.description)

    G.localization.misc.labels['unique'] = "Unique"
    G.localization.misc.labels['star_bu'] = "Diamonds Buff"
    G.localization.misc.labels['moon_bu'] = "Clubs Buff"
    G.localization.misc.labels['sun_bu'] = "Hearts Buff"
    G.localization.misc.labels['world_bu'] = "Spades Buff"

    -- Manage get_badge_colour
    get_badge_colour(foil)
    G.BADGE_COL['unique'] = G.C.ETERNAL
    G.BADGE_COL['star_bu'] = G.C.SUITS.Diamonds
    G.BADGE_COL['moon_bu'] = G.C.SUITS.Clubs
    G.BADGE_COL['sun_bu'] = G.C.SUITS.Hearts
    G.BADGE_COL['world_bu'] = G.C.SUITS.Spades
end

-- Should be called after everithing was overrided...
local function loadDXCUModule()

    -- Load modules
    assert(load(NFS.load(js_mod.path .. "source/DX_CU_API.lua")))()
    assert(load(NFS.load(js_mod.path .. "source/vanilla_dx.lua")))()
    assert(load(NFS.load(js_mod.path .. "source/vanilla_cu.lua")))()

end

local function loadCursesModule()

    -- Load modules
    assert(load(NFS.load(js_mod.path .. "source/curse.lua")))()
    
    -- Add curses
    setup_curses()
end

local function loadCodexArcanumModule()

    if SMODS.Mods and (SMODS.Mods['CodexArcanum'] or {}).can_load  then
        
        -- Load modules
        assert(load(love.filesystem.read(js_mod.path .. "source/alchemical_dx.lua")))()
        
        -- Add new dx stuff
        CodexArcanum.LoadDX()
    end
end

local function loadBuncoModule()

    if SMODS.Mods and (SMODS.Mods['Bunco'] or {}).can_load  then
        
        -- Load modules
        assert(load(NFS.load(js_mod.path .. "source/bunco_dx.lua")))()
        
        -- Add new dx stuff
        LoadBuncoDX()
    end
end

---------- mod init ----------

local function overrides()

    ---------- game ----------

    -- Restore vanilla enhancements
    local Game_delete_run_ref = Game.delete_run
    function Game.delete_run(self)

        G.P_CENTERS.m_bonus.config.bonus = enhanced_prototype_centers.m_bonus
        G.P_CENTERS.m_mult.config.mult = enhanced_prototype_centers.m_mult
        G.P_CENTERS.m_glass.config.Xmult = enhanced_prototype_centers.m_glass
        G.P_CENTERS.m_steel.config.h_x_mult = enhanced_prototype_centers.m_steel
        G.P_CENTERS.m_stone.config.bonus = enhanced_prototype_centers.m_stone
        G.P_CENTERS.m_gold.config.h_dollars = enhanced_prototype_centers.m_gold

        G.localization.descriptions.Enhanced.m_wild = G.localization.descriptions.Enhanced.m_wild_bak

        Game_delete_run_ref(self)
    end

    -- Track cursed tarots usage
    local Game_start_run_ref = Game.start_run
    function Game.start_run(self, args)

        G.P_CENTERS.m_bonus.config.bonus = enhanced_prototype_centers.m_bonus
        G.P_CENTERS.m_mult.config.mult = enhanced_prototype_centers.m_mult
        G.P_CENTERS.m_glass.config.Xmult = enhanced_prototype_centers.m_glass
        G.P_CENTERS.m_steel.config.h_x_mult = enhanced_prototype_centers.m_steel
        G.P_CENTERS.m_stone.config.bonus = enhanced_prototype_centers.m_stone
        G.P_CENTERS.m_gold.config.h_dollars = enhanced_prototype_centers.m_gold

        G.localization.descriptions.Enhanced.m_wild = G.localization.descriptions.Enhanced.m_wild_bak

        Game_start_run_ref(self, args)

        local saveTable = args.savetext or nil
        
        if G.GAME.used_cu_augments and G.GAME.used_cu_augments.c_empress_cu then
            G.P_CENTERS.m_mult.config.mult = G.P_CENTERS.m_mult.config.mult + (G.P_CENTERS.c_empress_cu.config.extra * G.GAME.used_cu_augments.c_empress_cu)
        end
        
        if G.GAME.used_cu_augments and G.GAME.used_cu_augments.c_heirophant_cu then
            G.P_CENTERS.m_bonus.config.bonus = G.P_CENTERS.m_bonus.config.bonus + (G.P_CENTERS.c_heirophant_cu.config.extra * G.GAME.used_cu_augments.c_heirophant_cu)
        end
        
        if G.GAME.used_cu_augments and G.GAME.used_cu_augments.c_lovers_cu then
            G.localization.descriptions.Enhanced.m_wild = G.localization.descriptions.Enhanced.m_wild_cu
        end
        
        if G.GAME.used_cu_augments and G.GAME.used_cu_augments.c_chariot_cu then
            G.P_CENTERS.m_steel.config.h_x_mult = G.P_CENTERS.m_steel.config.h_x_mult + (G.P_CENTERS.c_chariot_cu.config.extra * G.GAME.used_cu_augments.c_chariot_cu)
        end
        
        if G.GAME.used_cu_augments and G.GAME.used_cu_augments.c_justice_cu then
            G.P_CENTERS.m_glass.config.Xmult = G.P_CENTERS.m_glass.config.Xmult + (G.P_CENTERS.c_justice_cu.config.extra * G.GAME.used_cu_augments.c_justice_cu)
        end
        
        if G.GAME.used_cu_augments and G.GAME.used_cu_augments.c_devil_cu then
            G.P_CENTERS.m_gold.config.h_dollars = G.P_CENTERS.m_gold.config.h_dollars + (G.P_CENTERS.c_devil_cu.config.extra * G.GAME.used_cu_augments.c_devil_cu)
        end
        
        if G.GAME.used_cu_augments and G.GAME.used_cu_augments.c_tower_cu then
            G.P_CENTERS.m_stone.config.bonus = G.P_CENTERS.m_stone.config.bonus + (G.P_CENTERS.c_tower_cu.config.extra * G.GAME.used_cu_augments.c_tower_cu)
        end
    end

    ---------- common_events ----------

    -- Manage pool if DX pool
    local get_current_pool_ref  = get_current_pool
    function get_current_pool(_type, _rarity, _legendary, _append)

        if _type == 'Tarot_dx' or _type == 'Tarot_cu' or _type == 'Planet_dx' or _type == 'Spectral_dx' then
            --create the pool
            G.ARGS.TEMP_POOL = EMPTY(G.ARGS.TEMP_POOL)
            local _pool, _starting_pool, _pool_key, _pool_size = G.ARGS.TEMP_POOL, nil, '', 0
        
            _starting_pool, _pool_key = G.P_CENTER_POOLS[_type], _type..(_append or '')
        
            --cull the pool
            for k, v in ipairs(_starting_pool) do
                local add = nil
                if _type == 'Tarot_dx' or _type == 'Tarot_cu' or _type == 'Planet_dx' or _type == 'Spectral_dx' then
                    if not (G.GAME.used_jokers[v.key] and not next(find_joker("Showman"))) and
                        (v.unlocked ~= false or v.rarity == 4) then
                        if v.set == 'Planet' then
                            -- Check if hand is unlocked
                            if (not v.config.softlock or G.GAME.hands[v.config.hand_type].played > 0) then
                                add = true
                            end
                        else
                            add = true
                        end
                        if v.name == 'c_black_hole_dx' or v.name == 'c_soul_dx' or v.name == "c_philosopher_stone_dx" then
                            add = false
                        end
                        if SMODS.Mods and (SMODS.Mods['Bunco'] or {}).can_load  and (v.name == 'c_bunc_sky_dx' or v.name == 'c_bunc_abyss_dx' or v.name == 'c_bunc_sky_cu' or v.name == 'c_bunc_abyss_cu') then
                            add = G.GAME and G.GAME.Exotic
                        end
                    end
                end
        
                if v.no_pool_flag and G.GAME.pool_flags[v.no_pool_flag] then add = nil end
                if v.yes_pool_flag and not G.GAME.pool_flags[v.yes_pool_flag] then add = nil end
                
                if add and not G.GAME.banned_keys[v.key] then 
                    _pool[#_pool + 1] = v.key
                    _pool_size = _pool_size + 1
                else
                    _pool[#_pool + 1] = 'UNAVAILABLE'
                end
            end
        
            --if pool is empty, return normal pool
            if _pool_size == 0 then
                _pool = EMPTY(G.ARGS.TEMP_POOL)
                if _type == 'Tarot_dx' then return get_current_pool("Tarot", _rarity, _legendary, _append)
                elseif _type == 'Tarot_cu' then return get_current_pool("Tarot_dx", _rarity, _legendary, _append)
                elseif _type == 'Planet_dx' then return get_current_pool("Planet", _rarity, _legendary, _append)
                elseif _type == 'Spectral_dx' then return get_current_pool("Spectral", _rarity, _legendary, _append)
                else _pool[#_pool + 1] = "c_fool_dx"    -- Should never happen...
                end
            end
        
            return _pool, _pool_key..G.GAME.round_resets.ante

        else
            -- Use normal pool
            local _pool, _pool_key = get_current_pool_ref(_type, _rarity, _legendary, _append)
            return _pool, _pool_key
        end
    end

    -- Set a chance to change pool from normal to DX/Cursed
    local create_card_ref = create_card
    function create_card(_type, area, legendary, _rarity, skip_materialize, soulable, forced_key, key_append)

        local new_type = _type
        local new_forced_key = forced_key

        -- Give a chance to the forced planet to be DX
        if forced_key and _type == 'Planet' and G.GAME.used_vouchers.v_telescope and G.STATE == G.STATES.PLANET_PACK and (pseudorandom('upgrade_card'..G.GAME.round_resets.ante) > math.min(1, math.max(0, 1 - js_config.planet_dx_rate))) then
            -- Check if the DX version exists (needed for mods compatibility)
            local dx_ver = forced_key..'_dx'
            for k, v in pairs(G.P_CENTER_POOLS.Planet_dx) do
                if v.key == dx_ver then
                    new_forced_key = v.key
                    new_type = 'Planet_dx'
                end
            end
        end

        if not forced_key then
            -- Change type pseudorandom
            if new_type == 'Tarot' and (pseudorandom('upgrade_card'..G.GAME.round_resets.ante) > math.min(1, math.max(0, 1 - js_config.tarot_dx_rate))) then new_type = "Tarot_dx" end
            if ((new_type == 'Tarot') or (new_type == 'Tarot_dx')) and (pseudorandom('upgrade_card'..G.GAME.round_resets.ante) > math.min(1, math.max(0, 1 - js_config.tarot_cu_rate))) then new_type = "Tarot_cu" end
            if new_type == 'Planet' and (pseudorandom('upgrade_card'..G.GAME.round_resets.ante) > math.min(1, math.max(0, 1 - js_config.planet_dx_rate))) then new_type = "Planet_dx" end
            if new_type == 'Spectral' and (pseudorandom('upgrade_card'..G.GAME.round_resets.ante) > math.min(1, math.max(0, 1 - js_config.spectral_dx_rate))) then new_type = "Spectral_dx" end
            
            local alc_mod = js_config.alchemical_dx_rate
            if G.GAME.used_cu_augments and G.GAME.used_cu_augments.c_seeker_cu then alc_mod = js_config.alchemical_dx_rate * G.P_CENTERS.c_seeker_cu.config.prob_mult * G.GAME.used_cu_augments.c_seeker_cu end
            if new_type == 'Alchemical' and (pseudorandom('upgrade_card'..G.GAME.round_resets.ante) > math.min(1, math.max(0, 1 - (alc_mod)))) then new_type = "Alchemical_dx" end

            -- If type is set to DX, need to manage soulable option
            if soulable and (not G.GAME.banned_keys['c_soul']) then
                if (new_type == 'Tarot_dx' or new_type == 'Spectral_dx') and
                not (G.GAME.used_jokers['c_soul_dx'] and not next(find_joker("Showman")))  then
                    if pseudorandom('soul_'.._type..G.GAME.round_resets.ante) > 0.997 then
                        new_forced_key = 'c_soul_dx'
                    end
                end
                if (new_type == 'Planet_dx' or new_type == 'Spectral_dx') and
                not (G.GAME.used_jokers['c_black_hole_dx'] and not next(find_joker("Showman")))  then 
                    if pseudorandom('soul_'.._type..G.GAME.round_resets.ante) > 0.997 then
                        new_forced_key = 'c_black_hole_dx'
                    end
                end
                if SMODS.Mods and (SMODS.Mods['CodexArcanum'] or {}).can_load  and (new_type == 'Alchemical_dx' or new_type == 'Spectral_dx') and
                not (G.GAME.used_jokers['c_philosopher_stone_dx'] and not next(find_joker("Showman")))  then
                    if pseudorandom('soul_'.._type..G.GAME.round_resets.ante) > 0.997 then
                        new_forced_key = 'c_philosopher_stone_dx'
                    end
                end
            end
        end

        local created_card = create_card_ref(new_type, area, legendary, _rarity, skip_materialize, soulable, new_forced_key, key_append)

        -- manage unique cards
        if js_config.unique_enabled and created_card.config and created_card.config.center and created_card.config.center.unique and created_card.config.center.key then
            G.GAME.banned_keys[created_card.config.center.key] = true
        end

        -- poll planet edition if it is enabled
        if (js_config.planet_edition_enabled and not (SMODS.Mods['aurinko'] or {}).can_load) then
            if (_type == 'Planet' or _type == 'Planet_dx') and created_card.ability.consumeable and created_card.ability.consumeable.hand_type then
                local mod = math.max(1, 1 + (0.07 * math.min(7, G.GAME.hands[created_card.ability.consumeable.hand_type].level))) or 1
                if G.GAME.used_cu_augments and G.GAME.used_cu_augments.c_high_priestess_cu then mod = mod * G.P_CENTERS.c_high_priestess_cu.config.prob_mult * G.GAME.used_cu_augments.c_high_priestess_cu end
                local edition = poll_edition('edi'..(key_append or '')..G.GAME.round_resets.ante, mod, true)
                created_card:set_edition(edition)
                check_for_unlock({type = 'have_edition'})
            end
            if created_card.ability.name == 'Black Hole' or created_card.ability.name == 'Black Hole DX' then
                local mod = 1
                if G.GAME.used_cu_augments and G.GAME.used_cu_augments.c_high_priestess_cu then mod = mod * G.P_CENTERS.c_high_priestess_cu.config.prob_mult * G.GAME.used_cu_augments.c_high_priestess_cu end
                local edition = poll_edition('edi'..(key_append or '')..G.GAME.round_resets.ante, mod, true)
                created_card:set_edition(edition)
                check_for_unlock({type = 'have_edition'})
            end
        end

        return created_card
    end

    -- Overwrite level_up_hand if planet edition is enabled 
    local level_up_hand_ref = level_up_hand
    function level_up_hand(card, hand, instant, amount)

        if (js_config.planet_edition_enabled and not (SMODS.Mods['aurinko'] or {}).can_load) then  -- Overwrite
            amount = amount or 1
            G.GAME.hands[hand].level = math.max(0, G.GAME.hands[hand].level + amount)
            G.GAME.hands[hand].mult = math.max(G.GAME.hands[hand].mult + G.GAME.hands[hand].l_mult*(amount), 1)
            G.GAME.hands[hand].chips = math.max(G.GAME.hands[hand].chips + G.GAME.hands[hand].l_chips*(amount), 0)
            if not instant then 
                G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.2, func = function()
                    play_sound('tarot1')
                    if card then card:juice_up(0.8, 0.5) end
                    G.TAROT_INTERRUPT_PULSE = true
                    return true end }))
                update_hand_text({delay = 0}, {mult = G.GAME.hands[hand].mult, StatusText = true})
                G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.9, func = function()
                    play_sound('tarot1')
                    if card then card:juice_up(0.8, 0.5) end
                    return true end }))
                update_hand_text({delay = 0}, {chips = G.GAME.hands[hand].chips, StatusText = true})
                G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.9, func = function()
                    play_sound('tarot1')
                    if card then card:juice_up(0.8, 0.5) end
                    G.TAROT_INTERRUPT_PULSE = nil
                    return true end }))
                update_hand_text({sound = 'button', volume = 0.7, pitch = 0.9, delay = 0}, {level=G.GAME.hands[hand].level})
                delay(1.3)
            end
                
            -- Manage Editions
            if card and card.ability and card.ability.consumeable then
                if card.edition then
                    if card.edition.holo then
                        G.GAME.hands[hand].mult = math.max(G.GAME.hands[hand].mult + G.P_CENTERS.e_holo.config.extra, 1)
                        if not instant then
                            G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, func = function()
                                play_sound('holo1')
                                card:juice_up(0.8, 0.5)
                                return true end }))
                            update_hand_text({delay = 0}, {mult = G.GAME.hands[hand].mult, StatusText = true})
                            delay(1.3)
                        end
                    end
                    if card.edition.foil then
                        G.GAME.hands[hand].chips = math.max(G.GAME.hands[hand].chips + G.P_CENTERS.e_foil.config.extra, 0)
                        if not instant then
                            G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, func = function()
                                play_sound('foil1')
                                card:juice_up(0.8, 0.5)
                                return true end }))
                            update_hand_text({delay = 0}, {chips = G.GAME.hands[hand].chips, StatusText = true})
                            delay(1.3)
                        end
                    end
                    if card.edition.polychrome then
                        G.GAME.hands[hand].mult = math.floor(math.max(G.GAME.hands[hand].mult * G.P_CENTERS.e_polychrome.config.extra, 1))
                        if not instant then
                            G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, func = function()
                                play_sound('polychrome1')
                                card:juice_up(0.8, 0.5)
                                return true end }))
                            update_hand_text({delay = 0}, {mult = 'x' .. tostring(G.P_CENTERS.e_polychrome.config.extra), StatusText = true})
                            delay(1.3)
                        end
                    end
                    -- Bunco Glitter compat
                    if SMODS.Mods and (SMODS.Mods['Bunco'] or {}).can_load and card.edition.bunc_glitter then
                        G.GAME.hands[hand].chips = math.floor(math.max(G.GAME.hands[hand].chips * G.P_CENTERS.e_bunc_glitter.config.Xchips, 0))
                        if not instant then
                            G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, func = function()
                                play_sound('bunc_glitter')
                                card:juice_up(0.8, 0.5)
                                return true end }))
                            update_hand_text({delay = 0}, {chips = 'x' .. tostring(G.P_CENTERS.e_bunc_glitter.config.Xchips), StatusText = true})
                            delay(1.3)
                        end
                    end
                    -- Cryptid Mosaic compat
                    if SMODS.Mods and (SMODS.Mods['Cryptid'] or {}).can_load and card.edition.cry_mosaic then
                        G.GAME.hands[hand].chips = math.floor(math.max(G.GAME.hands[hand].chips * G.P_CENTERS.e_cry_mosaic.config.Xchips, 0))
                        if not instant then
                            G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, func = function()
                                play_sound('cry_e_mosaic')
                                card:juice_up(0.8, 0.5)
                                return true end }))
                            update_hand_text({delay = 0}, {chips = 'x' .. tostring(G.P_CENTERS.e_cry_mosaic.config.Xchips), StatusText = true})
                            delay(1.3)
                        end
                    end
                    -- Cryptid Oversaturated compat
                    if SMODS.Mods and (SMODS.Mods['Cryptid'] or {}).can_load and card.edition.cry_oversat then
                        G.GAME.hands[hand].chips = math.floor(math.max(G.GAME.hands[hand].chips * 2, 0))
                        G.GAME.hands[hand].mult = math.floor(math.max(G.GAME.hands[hand].mult * 2, 1))
                        if not instant then
                            G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, func = function()
                                play_sound('cry_e_oversaturated')
                                card:juice_up(0.8, 0.5)
                                return true end }))
                            update_hand_text({delay = 0}, {chips = 'x2', StatusText = true})
                            update_hand_text({delay = 0}, {mult = 'x2', StatusText = true})
                            delay(1.3)
                        end
                    end
                    -- Cryptid Astral Compat
                    if SMODS.Mods and (SMODS.Mods['Cryptid'] or {}).can_load and card.edition.cry_astral then
                        G.GAME.hands[hand].mult = math.floor(math.max(G.GAME.hands[hand].mult ^ G.P_CENTERS.e_cry_astral.config.pow_mult, 1))
                        if not instant then
                            G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, func = function()
                                play_sound('cry_^Mult')
                                card:juice_up(0.8, 0.5)
                                return true end }))
                            update_hand_text({delay = 0}, {mult = '^' .. tostring(G.P_CENTERS.e_cry_astral.config.pow_mult), StatusText = true})
                            delay(1.3)
                        end
                    end
                    -- Cryptid Glitched compat
                    if SMODS.Mods and (SMODS.Mods['Cryptid'] or {}).can_load and card.edition.cry_glitched then

                        local bad = (love.math.random(1, 10) / 10)
                        local gud = (love.math.random(11, 100) / 10)
                        local hellno = love.math.random() < 1 / 3

                        G.GAME.hands[hand].chips = math.floor(math.max(G.GAME.hands[hand].chips * ((hellno and bad) or gud), 0))
                        G.GAME.hands[hand].mult = math.floor(math.max(G.GAME.hands[hand].mult * ((hellno and bad) or gud), 1))

                        if not instant then
                            G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, func = function()
                                play_sound('cry_e_glitched')
                                card:juice_up(0.8, 0.5)
                                return true end }))
                            update_hand_text({ delay = 0 }, { chips = 'x' .. ((hellno and tostring(bad)) or gud), StatusText = true })
                            update_hand_text({ delay = 0 }, { mult = 'x' .. ((hellno and tostring(bad)) or gud), StatusText = true })
                            delay(2.6)
                        end
                    end
                end
            end
            
            G.E_MANAGER:add_event(Event({
                trigger = 'immediate',
                func = (function() check_for_unlock{type = 'upgrade_hand', hand = hand, level = G.GAME.hands[hand].level} return true end)
            }))
        else    -- Do not overwrite
            level_up_hand_ref(card, hand, instant, amount)
        end
    end

    ---------- Card ----------

    -- Update calculate_joker for Hanged Man DX/CU
    local card_calculate_joker_ref = Card.calculate_joker
    function Card.calculate_joker(self, context)

        if self.ability.set == "Joker" and not self.debuff then
            if context.remove_playing_cards then
                if self.ability.name == 'Glass Joker' and not context.blueprint and (context.name == 'The Hanged Man DX' or context.name == 'The Cursed Hanged Man')  then
                    local shattered_glass = 0
                    local destroyed_cards = context.removed or {}
                    for k, val in ipairs(destroyed_cards) do
                        if val.ability.name == 'Glass Card' then shattered_glass = shattered_glass + 1 end
                    end
                    if shattered_glass > 0 then
                        self.ability.x_mult = self.ability.x_mult + self.ability.extra*shattered_glass
                        G.E_MANAGER:add_event(Event({
                            func = function() card_eval_status_text(self, 'extra', nil, nil, nil, {message = localize{type='variable',key='a_xmult',vars={self.ability.x_mult}}}); return true
                            end}))
                    end
                    return
                end
            end
        end

        return card_calculate_joker_ref(self, context)
    end

    -- Blank voucher
    local card_apply_to_run_ref = Card.apply_to_run
    function Card.apply_to_run(self, center)

        if js_config.spectral_on_blank then
            local center_table = {
                name = center and center.name or self and self.ability.name,
                extra = center and center.config.extra or self and self.ability.extra
            }
            if center_table.name == 'Blank' then
                G.E_MANAGER:add_event(Event({func = function()
                    G.GAME.spectral_rate = G.GAME.spectral_rate + 1
                    return true end }))
            end
        end

        card_apply_to_run_ref(self, center)
    end

    -- Saves old curse rolls
    local card_set_ability_ref = Card.set_ability
    function Card.set_ability(self, center, initial, delay_sprites)

        local old_curse_rolls = self.ability and self.ability.debuff_by_curse_rolls
        card_set_ability_ref(self, center, initial, delay_sprites)
        if old_curse_rolls then
            self.ability.debuff_by_curse_rolls = old_curse_rolls
            if not initial then G.GAME.blind:debuff_card(self) end
        end
    end

    -- Cycle Vanilla/DX/Cursed in collection
    local card_click_ref = Card.click
    function Card.click(self)

        card_click_ref(self)
        -- Check if we are in the collection
        if self.area and self.area.config and self.area.config.collection and self.config.center.discovered then
            local version = 'van'
            -- Check if this is a DX card
            if self.config.center.extra_type == '_dx' then version = 'dx' end
            -- Check if this is a Cursed card
            if self.config.center.extra_type == '_cu' then version = 'cu' end

            -- Check if a DX version exists
            if version == 'van' and G.P_CENTER_POOLS[self.ability.set..'_dx'] then
                local dx_ver = self.config.center_key..'_dx'
                for k, v in pairs(G.P_CENTER_POOLS[self.ability.set..'_dx']) do
                    if v.key == dx_ver and v.discovered then
                        self:set_ability(G.P_CENTER_POOLS[self.ability.set..'_dx'][k], true)
                        version = nil
                        break
                    end
                end
            end

            -- Check if a cursed version exists
            if version == 'van' and G.P_CENTER_POOLS[self.ability.set..'_cu'] then
                local cu_ver = self.config.center_key..'_cu'
                for k, v in pairs(G.P_CENTER_POOLS[self.ability.set..'_cu']) do
                    if v.key == cu_ver and v.discovered then
                        self:set_ability(G.P_CENTER_POOLS[self.ability.set..'_cu'][k], true)
                        version = nil
                        break
                    end
                end
            elseif version == 'dx' and G.P_CENTER_POOLS[self.ability.set..'_cu'] then 
                local cu_ver = string.sub(self.config.center_key, 1, -4)..'_cu'
                for k, v in pairs(G.P_CENTER_POOLS[self.ability.set..'_cu']) do
                    if v.key == cu_ver and v.discovered then
                        self:set_ability(G.P_CENTER_POOLS[self.ability.set..'_cu'][k], true)
                        version = nil
                        break
                    end
                end
            end

            -- Back to vanilla
            if version == 'dx' or version == 'cu' then
                local van_ver = string.sub(self.config.center_key, 1, -4)
                for k, v in pairs(G.P_CENTER_POOLS[self.ability.set]) do
                    if v.key == van_ver and v.discovered then
                        self:set_ability(G.P_CENTER_POOLS[self.ability.set][k], true)
                        break
                    end
                end
            end
        end
    end

    -- Manage enhanced wild cards
    local card_get_id_ref = Card.get_id
    function Card.get_id(self)
        if G.GAME.used_cu_augments and G.GAME.used_cu_augments.c_lovers_cu and self.ability.effect == 'Wild Card' and not self.vampired and not self.debuffed and (self.area == G.hand or self.area == G.play) then
            local cards = (self.area == G.hand and G.hand.highlighted) or (self.area == G.play and G.play.cards)
            table.sort(cards, function(a,b) return a.T.x < b.T.x end)
            for i=2, #cards, 1
            do
                if (cards[i].sort_id == self.sort_id) then return cards[i-1]:get_id() end
            end
        end
        return card_get_id_ref(self)
    end

    -- Manage debuff prevention
    local card_set_debuff_ref = Card.set_debuff
    function Card.set_debuff(self, should_debuff)

        -- Check for suit buff
        if self.base and self.base.suit and G.GAME.used_cu_augments and ((self.base.suit == 'Diamonds' and G.GAME.used_cu_augments.c_star_cu) or (self.base.suit == 'Clubs' and G.GAME.used_cu_augments.c_moon_cu) or (self.base.suit == 'Hearts' and G.GAME.used_cu_augments.c_sun_cu) or (self.base.suit == 'Spades' and G.GAME.used_cu_augments.c_world_cu)) then   -- Overwrite
            self.debuff = false
            self.ability.debuff_by_curse_rolls = {}
            return
        end
        -- Check for bunco suit buff
        if SMODS.Mods and (SMODS.Mods['Bunco'] or {}).can_load and self.base and self.base.suit and G.GAME.used_cu_augments and ((self.base.suit == 'bunc_Fleurons' and G.GAME.used_cu_augments.c_bunc_sky_cu) or (self.base.suit == 'bunc_Halberds' and G.GAME.used_cu_augments.c_bunc_abyss_cu)) then   -- Overwrite
            self.debuff = false
            self.ability.debuff_by_curse_rolls = {}
            return
        end
        -- Check for Oil, CodexArcanum stuff
        if self.ability and self.ability.oil then    -- Overwrite
            self.debuff = false
            self.ability.debuff_by_curse_rolls = {}
            return
        end
        -- OR with vanilla boolean
        local custom_debuff = custom_debuff_card(self)
        card_set_debuff_ref(self, should_debuff or custom_debuff)
        if (should_debuff or custom_debuff) and not self.debuff then
            -- Debuff prevented by another mod, remove curse rolls after the fact
            self.ability.debuff_by_curse_rolls = {}
        end
    end

    ---------- cardarea ----------

    -- Manage enhanced wild cards
    local cardarea_align_cards_ref = CardArea.align_cards
    function CardArea.align_cards(self)

        if G.GAME.used_cu_augments and G.GAME.used_cu_augments.c_lovers_cu and self == G.hand and G.STATE == G.STATES.SELECTING_HAND then
            self:parse_highlighted()
        end
        cardarea_align_cards_ref(self)
    end
    
    -- Manage Black Hole planet edition if enabled
    if (js_config.planet_edition_enabled and not (SMODS.Mods['aurinko'] or {}).can_load) then
        SMODS.Consumable:take_ownership('c_black_hole', {
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
                    level_up_hand(used_tarot, k, true, 1)
                end
                update_hand_text({sound = 'button', volume = 0.7, pitch = 1.1, delay = 0}, {mult = 0, chips = 0, handname = '', level = ''})
            end,
        })
    end
end

sendInfoMessage("Deluxe Consumables Cards Loaded", 'DX')

-- DX/Curses Sprites

SMODS.Atlas({key = 'Van_dx', path = 'Tarots_dx.png', px = 71, py = 95})
SMODS.Atlas({key = 'Van_cu', path = 'Tarots_cu.png', px = 71, py = 95})
SMODS.Atlas({key = 'Van_Booster_dx', path = 'booster_dx.png', px = 71, py = 95})

setUpDX()

-------------------------------
---------- OVERRIDES ----------
-------------------------------

--loadCodexArcanumModule()

overrides()

loadDXCUModule()

loadCursesModule()

loadBuncoModule()

----------------------------------------------
------------MOD CODE END----------------------
