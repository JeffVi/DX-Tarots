CodexArcanum.DXAlchemicals = {}

-- For convenience
function CodexArcanum.Alchemical:newDX(name, slug, config, pos, loc_txt, cost, discovered, unlocked, unlock_condition, atlas)

  name = name .. " DX"
  slug = slug .. "_dx"
  config = config or {}
  config.type = "_dx"
  atlas = atlas or "alchemical_dx_atlas"

  return CodexArcanum.Alchemical:new(name, slug, config, pos, loc_txt, cost, discovered, unlocked, unlock_condition, atlas)
end

-- Need a custom register to add DX alchemicals to the correct CENTER_POOL
function CodexArcanum.Alchemical:registerDX()

	CodexArcanum.DXAlchemicals[self.slug] = self
	local minId = table_length(G.P_CENTER_POOLS['Alchemical_dx']) + 1
	local id = 0
	local i = 0
	i = i + 1

  	id = i + minId

	local alchemical_obj = {
		discovered = self.discovered,
		unlocked = self.unlocked,
		consumeable = true,
		name = self.name,
		set = "Alchemical",
		order = id,
		key = self.slug,
		pos = self.pos,
    	cost = self.cost,
		config = self.config,
		unlock_condition = self.unlock_condition,
		atlas = self.atlas
	}

	for _i, sprite in ipairs(SMODS.Sprites) do
		if sprite.name == alchemical_obj.key then
			alchemical_obj.atlas = sprite.name
		end
	end

 	G.P_CENTERS[self.slug] = alchemical_obj
	table.insert(G.P_CENTER_POOLS['Alchemical_dx'], alchemical_obj)

  	G.localization.descriptions["Alchemical_dx"][self.slug] = self.loc_txt

  	for g_k, group in pairs(G.localization) do
		if g_k == 'descriptions' then
			for _, set in pairs(group) do
				for _, center in pairs(set) do
					center.text_parsed = {}
					for _, line in ipairs(center.text) do
						center.text_parsed[#center.text_parsed + 1] = loc_parse_string(line)
					end
					center.name_parsed = {}
					for _, line in ipairs(type(center.name) == 'table' and center.name or {center.name}) do
						center.name_parsed[#center.name_parsed + 1] = loc_parse_string(line)
					end
					if center.unlock then
						center.unlock_parsed = {}
						for _, line in ipairs(center.unlock) do
							center.unlock_parsed[#center.unlock_parsed + 1] = loc_parse_string(line)
						end
					end
				end
			end
		end
	end

	sendDebugMessage("The DX Alchemical named " .. self.name .. " with the slug " .. self.slug ..
						 " have been registered at the id " .. id .. ".")
end

-- For convenience
function SMODS.Booster:newDX(name, slug, config, pos, cost, discovered, weight, kind, atlas)

    name = name .." DX"
    slug = slug .. "_dx"
    config = config or {}
    config.type = "_dx"
    atlas = atlas or "ca_booster_dx_atlas"

    return SMODS.Booster:new(name, slug, config, pos, cost, discovered, weight, kind, atlas)
end

-- Need a custom register to add DX boosters to the correct CENTER_POOL
function SMODS.Booster:registerDX()

	CodexArcanum.DXAlchemicals[self.slug] = self
    local id = table_length(G.P_CENTER_POOLS["Booster_dx"]) + 1

	local booster_obj = {
		discovered = self.discovered,
		name = self.name,
		set = "Booster",
		order = id,
		key = self.slug,
		pos = self.pos,
        cost = self.cost,
		config = self.config,
		weight = self.weight,
		kind = self.kind,
		atlas = self.atlas
	}

	for _i, sprite in ipairs(SMODS.Sprites) do
		sendDebugMessage(sprite.name)
		sendDebugMessage(booster_obj.key)
		if sprite.name == booster_obj.key then
			booster_obj.atlas = sprite.name
		end
	end

	-- Now we replace the others
	G.P_CENTERS[self.slug] = booster_obj
	table.insert(G.P_CENTER_POOLS['Booster_dx'], booster_obj)

	sendDebugMessage("The DX Booster named " .. self.name .. " with the slug " .. self.slug ..
						 " have been registered at the id " .. id .. ".")
end

-- For Phosphorus DX
function draw_cards_from_discard(count)
    G.E_MANAGER:add_event(Event({
        trigger = 'immediate',
        func = function()
            for i=1, count do --draw cards from discard
                draw_card(G.discard, G.hand, i*100/count, 'up', true, nil, 0.005, i%2==0, nil, math.max((21-i)/20,0.7))
            end
            return true
        end
    }))
end

-- override

local card_use_consumeable_ref = Card.use_consumeable
function Card.use_consumeable(self, area, copier)

    local used_alchemical = copier or self
    -- Check if alchemical DX
    if self.config.in_booster and (self.ability.set == "Alchemical" or self.ability.name == "Philosopher's Stone DX") and self.ability.type == "_dx" then
        if #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
            G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
            G.E_MANAGER:add_event(Event({
                func = (function()
                    G.E_MANAGER:add_event(Event({
                        func = function() 
                        local card = copy_card(used_alchemical, nil, nil, nil)
                        card:add_to_deck()
                        G.consumeables:emplace(card)
                        G.GAME.consumeable_buffer = 0
                    return true end }))   
            return true end)}))
        end
    elseif not self.config.in_booster and self.ability.name == "Philosopher's Stone DX" then
        G.deck.config.philosopher = true
        G.deck.config.philosopher_dx = 3
    elseif not self.config.in_booster and self.ability.set == "Alchemical" and self.ability.type == "_dx" then
        local key = self.config.center.key
        local center_obj = CodexArcanum.DXAlchemicals[key]
        if center_obj and center_obj.use and type(center_obj.use) == 'function' then
            stop_use()
            if not copier then set_consumeable_usage(self) end
            if self.debuff then return nil end
            if self.ability.consumeable.max_highlighted then
                update_hand_text({ immediate = true, nopulse = true, delay = 0 },
                { mult = 0, chips = 0, level = '', handname = '' })
            end
            center_obj.use(self, area, copier)
            check_for_unlock({type = 'used_alchemical'})
        end
    elseif self.ability.set == "Tarot" and self.ability.type == '_dx' and self.config.center and self.config.center.atlas == 'ca_others_dx_atlas' then
        stop_use()
        if not copier then set_consumeable_usage(self) end
        if self.debuff then return nil end
        local used_tarot = copier or self

        if self.ability.name == 'The Seeker DX' then
            for i = 1, math.min(self.ability.consumeable.alchemicals, G.consumeables.config.card_limit - #G.consumeables.cards) do
                G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
                if G.consumeables.config.card_limit > #G.consumeables.cards then
                    play_sound('timpani')
                    local card = create_card('Alchemical_dx', G.consumeables, nil, nil, nil, nil, nil, 'see')
                    card:add_to_deck()
                    G.consumeables:emplace(card)
                    used_tarot:juice_up(0.3, 0.5)
                end
                return true end }))
            end
            delay(0.6)
        end
    elseif self.ability.set == "Tarot" and self.ability.type == '_cu' and self.config.center and self.config.center.atlas == 'ca_others_cu_atlas' then
        stop_use()
        if not copier then set_consumeable_usage(self) end
        if self.debuff then return nil end
        local used_tarot = copier or self

        G.GAME.used_cu_augments[self.config.center_key] = (G.GAME.used_cu_augments[self.config.center_key] or 0) + 1

        if self.ability.name == 'The Cursed Seeker' then
            G.E_MANAGER:add_event(Event({func = function()
                for k, v in pairs(G.I.CARD) do
                    if v.set_cost then v:set_cost() end
                end
                return true end }))
        end

    else -- Call vanilla
        card_use_consumeable_ref(self, area, copier)
    end
end

local card_can_use_consumeable_ref = Card.can_use_consumeable
function Card.can_use_consumeable(self, any_state, skip_check)

    if self.ability.set == "Alchemical" and self.ability.type == "_dx" then
        if not skip_check and ((G.play and #G.play.cards > 0) or
          (G.CONTROLLER.locked) or
          (G.GAME.STOP_USE and G.GAME.STOP_USE > 0))
          then  return false end

        if G.STATE == G.STATES.SELECTING_HAND then
            local t = nil
            local key = self.config.center.key
            local center_obj = CodexArcanum.DXAlchemicals[key]

            self.config.in_booster = false
            if center_obj and center_obj.can_use and type(center_obj.can_use) == 'function' then
                t = center_obj.can_use(self)
            end
            if not (t == nil) then
            return t
            end
        end

        if G.STATE == G.STATES.STANDARD_PACK or G.STATE == G.STATES.TAROT_PACK 
        or G.STATE == G.STATES.PLANET_PACK or G.STATE == G.STATES.SPECTRAL_PACK or G.STATE == G.STATES.BUFFOON_PACK then
            self.config.in_booster = true
            return true
        end
    elseif (self.ability.type == '_dx' or self.ability.type == '_cu') and self.config.center and (self.config.center.atlas == 'ca_others_dx_atlas' or self.config.center.atlas == 'ca_others_cu_atlas') then
        if not skip_check and ((G.play and #G.play.cards > 0) or
        (G.CONTROLLER.locked) or
        (G.GAME.STOP_USE and G.GAME.STOP_USE > 0))
        then  return false end

        if G.STATE ~= G.STATES.HAND_PLAYED and G.STATE ~= G.STATES.DRAW_TO_HAND and G.STATE ~= G.STATES.PLAY_TAROT or any_state then
            if self.ability.name == 'The Seeker DX' then
                return #G.consumeables.cards < G.consumeables.config.card_limit or self.area == G.consumeables
            end
            if self.ability.name == "Philosopher's Stone DX" then
                if G.STATE == G.STATES.SELECTING_HAND then
                    self.config.in_booster = false
                    return true
                end
        
                if G.STATE == G.STATES.STANDARD_PACK or G.STATE == G.STATES.TAROT_PACK 
                or G.STATE == G.STATES.PLANET_PACK or G.STATE == G.STATES.SPECTRAL_PACK or G.STATE == G.STATES.BUFFOON_PACK then
                    self.config.in_booster = true
                    return true
                end
            end
            
            if self.ability.name == 'The Cursed Seeker' then
                return true
            end
        end
        return false
    else -- Call vanilla
        return card_can_use_consumeable_ref(self, any_state, skip_check)
    end
end

-- Manage Philosopher DX
local blind_set_blind_ref = Blind.set_blind
function Blind.set_blind(self, blind, reset, silent)

    blind_set_blind_ref(self, blind, reset, silent)

    if G.deck.config.philosopher_dx and G.deck.config.philosopher_dx > 0 and (not reset) and (not silent) then
        G.deck.config.philosopher = true
        G.deck.config.philosopher_dx = G.deck.config.philosopher_dx - 1
    end
end

-- Manage Cursed Seeker joker
local card_set_cost_ref = Card.set_cost
function Card.set_cost(self)

    card_set_cost_ref(self)

    if G.GAME.used_cu_augments and G.GAME.used_cu_augments.c_seeker_cu then 
        if self.ability.set == 'Alchemical' or (self.ability.set == 'Booster' and self.ability.name:find('Alchemy')) then self.cost = math.floor(self.cost / 2) end
    end
end

-- Manage card UI if DX
local generate_card_ui_ref = generate_card_ui
function generate_card_ui(_c, full_UI_table, specific_vars, card_type, badges, hide_desc, main_start, main_end)
    
    local first_pass = nil
    first_pass = not full_UI_table
    local info_queue = {}

    if _c.config and (_c.config.type == '_dx' or _c.config.type == '_cu') and (_c.atlas == 'alchemical_dx_atlas' or _c.atlas == 'ca_booster_dx_atlas' or _c.atlas == 'ca_others_dx_atlas' or _c.atlas == 'ca_others_cu_atlas') then    -- Overwrite

        -- Just copy-paste for now... TODO
        if first_pass then 
            full_UI_table = {
                main = {},
                info = {},
                type = {},
                name = nil,
                badges = badges or {}
            }
        end
        
        local desc_nodes = (not full_UI_table.name and full_UI_table.main) or full_UI_table.info
        local name_override = nil
        local info_queue = {}

        if full_UI_table.name then
            full_UI_table.info[#full_UI_table.info+1] = {}
            desc_nodes = full_UI_table.info[#full_UI_table.info]
        end

        if not full_UI_table.name then
            if specific_vars and specific_vars.no_name then
                full_UI_table.name = true
            elseif card_type == 'Locked' then
                full_UI_table.name = localize{type = 'name', set = 'Other', key = 'locked', nodes = {}}
            elseif card_type == 'Undiscovered' then 
                full_UI_table.name = localize{type = 'name', set = 'Other', key = 'undiscovered_'..(string.lower(_c.set)), name_nodes = {}}
            elseif specific_vars and (card_type == 'Default' or card_type == 'Enhanced') then
                if (_c.name == 'Stone Card') then full_UI_table.name = true end
                if (specific_vars.playing_card and (_c.name ~= 'Stone Card')) then
                    full_UI_table.name = {}
                    localize{type = 'other', key = 'playing_card', set = 'Other', nodes = full_UI_table.name, vars = {localize(specific_vars.value, 'ranks'), localize(specific_vars.suit, 'suits_plural'), colours = {specific_vars.colour}}}
                    full_UI_table.name = full_UI_table.name[1]
                end
            elseif card_type == 'Booster' then
                
            else
                full_UI_table.name = localize{type = 'name', set = _c.set.._c.config.type, key = _c.key, nodes = full_UI_table.name}
            end
            full_UI_table.card_type = card_type or _c.set
        end 

        local loc_vars = {}
        if main_start then 
            desc_nodes[#desc_nodes+1] = main_start 
        end
        
        if _c.set == "Alchemical" then
            info_queue[#info_queue+1] = {key = "alchemical_card", set = "Other"}
            if _c.name == 'Bismuth DX' then info_queue[#info_queue+1] = G.P_CENTERS.e_polychrome
            elseif _c.name == 'Manganese DX' then info_queue[#info_queue+1] = G.P_CENTERS.m_steel
            elseif _c.name == 'Glass DX' then info_queue[#info_queue+1] = G.P_CENTERS.m_glass
            elseif _c.name == 'Gold DX' then info_queue[#info_queue+1] = G.P_CENTERS.m_gold
            elseif _c.name == 'Silver DX' then info_queue[#info_queue+1] = G.P_CENTERS.m_lucky
            elseif _c.name == 'Stone DX' then info_queue[#info_queue+1] = G.P_CENTERS.m_stone
            elseif _c.name == 'Cobalt DX' then 
                local loc_text = "Not chosen"
                if G.hand then
                local text,disp_text = G.FUNCS.get_poker_hand_info(G.hand.highlighted)
                loc_text = localize(text, 'poker_hands')
                if loc_text == "ERROR" then
                    loc_text = "Not chosen"
                end
                end
                loc_vars = {loc_text}
            elseif _c.name == 'Antimony DX' then 
                info_queue[#info_queue+1] = G.P_CENTERS.e_negative 
                info_queue[#info_queue+1] = {key = 'eternal', set = 'Other'} 
            end
            localize{type = 'descriptions', key = _c.key, set = _c.set..'_dx', nodes = desc_nodes, vars = loc_vars}
        elseif _c.set == 'Booster' and _c.name:find("Alchemy") then 
            local desc_override = 'p_arcana_normal'
            if _c.name == 'Alchemy Pack DX' then desc_override = 'p_alchemy_normal_dx'; loc_vars = {_c.config.choose, _c.config.extra} end
            if _c.name == 'Jumbo Alchemy Pack DX' then desc_override = 'p_alchemy_jumbo_dx'; loc_vars = {_c.config.choose, _c.config.extra} end
            if _c.name == 'Mega Alchemy Pack DX' then desc_override = 'p_alchemy_mega_dx'; loc_vars = {_c.config.choose, _c.config.extra} end
            name_override = desc_override
            if not full_UI_table.name then full_UI_table.name = localize{type = 'name', set = 'Other', key = name_override, nodes = full_UI_table.name} end
            localize{type = 'other', key = desc_override, nodes = desc_nodes, vars = loc_vars}
        elseif _c.set == 'Spectral' then
            localize{type = 'descriptions', key = _c.key, set = _c.set.._c.config.type, nodes = desc_nodes, vars = loc_vars}
        elseif _c.set == 'Tarot' then
            if _c.name == 'The Seeker DX' then loc_vars = {_c.config.alchemicals} end
            if _c.name == 'The Cursed Seeker' then loc_vars = {_c.config.prob_mult * ((G.GAME.used_cu_augments.c_seeker_cu or 0) + 1)} end
            localize{type = 'descriptions', key = _c.key, set = _c.set.._c.config.type, nodes = desc_nodes, vars = loc_vars}
        end

        if main_end then 
            desc_nodes[#desc_nodes+1] = main_end 
        end

        --Fill all remaining info if this is the main desc
        if not ((specific_vars and not specific_vars.sticker) and (card_type == 'Default' or card_type == 'Enhanced')) then
            if desc_nodes == full_UI_table.main and not full_UI_table.name then
                localize{type = 'name', key = _c.key, set = _c.set.._c.config.type, nodes = full_UI_table.name} 
                if not full_UI_table.name then full_UI_table.name = {} end
            elseif desc_nodes ~= full_UI_table.main then 
                desc_nodes.name = localize{type = 'name_text', key = name_override or _c.key, set = name_override and 'Other' or _c.set.._c.config.type} 
            end
        end

        if first_pass and not (_c.set == 'Edition') and badges then
            for k, v in ipairs(badges) do
                if v == 'foil' then info_queue[#info_queue+1] = G.P_CENTERS['e_foil'] end
                if v == 'holographic' then info_queue[#info_queue+1] = G.P_CENTERS['e_holo'] end
                if v == 'polychrome' then info_queue[#info_queue+1] = G.P_CENTERS['e_polychrome'] end
                if v == 'negative' then info_queue[#info_queue+1] = G.P_CENTERS['e_negative'] end
                if v == 'negative_consumable' then info_queue[#info_queue+1] = {key = 'e_negative_consumable', set = 'Edition', config = {extra = 1}} end
                if v == 'gold_seal' then info_queue[#info_queue+1] = {key = 'gold_seal', set = 'Other'} end
                if v == 'blue_seal' then info_queue[#info_queue+1] = {key = 'blue_seal', set = 'Other'} end
                if v == 'red_seal' then info_queue[#info_queue+1] = {key = 'red_seal', set = 'Other'} end
                if v == 'purple_seal' then info_queue[#info_queue+1] = {key = 'purple_seal', set = 'Other'} end
                if v == 'eternal' then info_queue[#info_queue+1] = {key = 'eternal', set = 'Other'} end
                if v == 'pinned_left' then info_queue[#info_queue+1] = {key = 'pinned_left', set = 'Other'} end
            end
        end

        for _, v in ipairs(info_queue) do
            generate_card_ui(v, full_UI_table)
        end
    
        return full_UI_table

    else    -- Do not overwrite
        return generate_card_ui_ref(_c, full_UI_table, specific_vars, card_type, badges, hide_desc, main_start, main_end)
    end
end

-- Manage pool if DX pool
local get_current_pool_ref  = get_current_pool
function get_current_pool(_type, _rarity, _legendary, _append)

    if _type == 'Alchemical_dx' then
        --create the pool
        G.ARGS.TEMP_POOL = EMPTY(G.ARGS.TEMP_POOL)
        local _pool, _starting_pool, _pool_key, _pool_size = G.ARGS.TEMP_POOL, nil, '', 0
    
        _starting_pool, _pool_key = G.P_CENTER_POOLS[_type], _type..(_append or '')
    
        --cull the pool
        for k, v in ipairs(_starting_pool) do
            local add = nil
            if _type == 'Alchemical_dx' then
                if not (G.GAME.used_jokers[v.key] and not next(find_joker("Showman"))) and
                    (v.unlocked ~= false or v.rarity == 4) then
                        add = true
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
            if _type == 'Alchemical_dx' then return get_current_pool("Alchemical", _rarity, _legendary, _append)
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

local G_UIDEF_use_and_sell_buttons_ref = G.UIDEF.use_and_sell_buttons;
function G.UIDEF.use_and_sell_buttons(card)

	local ret = G_UIDEF_use_and_sell_buttons_ref(card)

    if (card.ability.name == "Philosopher's Stone DX") and G.ARGS.is_alchemical_booster and (card.area == G.pack_cards and G.pack_cards) then
	    return {
		    n=G.UIT.ROOT, config = {padding = 0, colour = G.C.CLEAR}, nodes={
			    {n=G.UIT.R, config={mid = true}, nodes={
			    }},
			    {n=G.UIT.R, config={ref_table = card, r = 0.08, padding = 0.1, align = "bm", minw = 0.5*card.T.w - 0.15, minh = 0.8*card.T.h, maxw = 0.7*card.T.w - 0.15, hover = true, shadow = true, colour = G.C.UI.BACKGROUND_INACTIVE, one_press = true, button = 'select_alchemical', func = 'can_select_alchemical'}, nodes={
			    {n=G.UIT.T, config={text = localize("b_select"),colour = G.C.UI.TEXT_LIGHT, scale = 0.55, shadow = true}}
		    }},
	    }}
    end
	
	return ret
end

local G_FUNCS_select_alchemical_ref = G.FUNCS.select_alchemical
function G.FUNCS.select_alchemical(e, mute, nosave)
    
    local card = e.config.ref_table
    if card.ability.name == "Philosopher's Stone DX" then -- Use vanilla for now TODO
        card.ability.name = "Philosopher's Stone"
        G_FUNCS_select_alchemical_ref(e, mute, nosave)
        card = e.config.ref_table
        card.ability.name = "Philosopher's Stone DX"
    else
        G_FUNCS_select_alchemical_ref(e, mute, nosave)
    end
end

-- Load the DX alchemical cards
function load_dx_alchemical_cards()
    
    local alchemy_ignis_def = {
        name = "Ignis DX",
        text = {
            "Gain {C:attention}+2{} discards"
        }
    }

    local alchemy_ignis = CodexArcanum.Alchemical:newDX("Ignis", "ignis", {extra = 2}, { x = 0, y = 0 }, alchemy_ignis_def, 5)
    alchemy_ignis:registerDX()
        
    function CodexArcanum.DXAlchemicals.c_alchemy_ignis_dx.can_use(card)
        return true
    end

    function CodexArcanum.DXAlchemicals.c_alchemy_ignis_dx.use(card, area, copier)
        G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.1,func = function()
            ease_discard(card.ability.extra)
        return true end }))
    end


    local alchemy_aqua_def = {
        name = "Aqua DX",
        text = {
            "Gain {C:attention}+2{} hands"
        }
    }

    local alchemy_aqua = CodexArcanum.Alchemical:newDX("Aqua", "aqua", {extra = 2}, { x = 1, y = 0 }, alchemy_aqua_def, 5)
    alchemy_aqua:registerDX()
                
    function CodexArcanum.DXAlchemicals.c_alchemy_aqua_dx.can_use(card)
        return true
    end

    function CodexArcanum.DXAlchemicals.c_alchemy_aqua_dx.use(card, area, copier)
        G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.1,func = function()
            ease_hands_played(card.ability.extra)
        return true end }))
    end


    local alchemy_terra_def = {
        name = "Terra DX",
        text = {
            "Reduce blind by {C:attention}30%{}"
        }
    }

    local alchemy_terra = CodexArcanum.Alchemical:newDX("Terra", "terra", {extra = 0.7}, { x = 2, y = 0 }, alchemy_terra_def, 5)
    alchemy_terra:registerDX()
                          
    function CodexArcanum.DXAlchemicals.c_alchemy_terra_dx.can_use(card)
        return true
    end

    function CodexArcanum.DXAlchemicals.c_alchemy_terra_dx.use(card, area, copier)
        G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.1,func = function()
            G.GAME.blind.chips = math.floor(G.GAME.blind.chips * card.ability.extra)
            G.GAME.blind.chip_text = number_format(G.GAME.blind.chips)
            
            local chips_UI = G.hand_text_area.blind_chips
            G.FUNCS.blind_chip_UI_scale(G.hand_text_area.blind_chips)
            G.HUD_blind:recalculate() 
            chips_UI:juice_up()
    
            if not silent then play_sound('chips2') end
        return true end }))
    end


    local alchemy_aero_def = {
        name = "Aero DX",
        text = {
            "Draw {C:attention}8{} cards"
        }
    }

    local alchemy_aero = CodexArcanum.Alchemical:newDX("Aero", "aero", {extra = 8}, { x = 3, y = 0 }, alchemy_aero_def, 5)
    alchemy_aero:registerDX()
            
    function CodexArcanum.DXAlchemicals.c_alchemy_aero_dx.can_use(card)
        return true
    end

    function CodexArcanum.DXAlchemicals.c_alchemy_aero_dx.use(card, area, copier)
        G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.1,func = function()
            G.FUNCS.draw_from_deck_to_hand(card.ability.extra)
        return true end }))
    end

    
    local alchemy_quicksilver_def = {
        name = "Quicksilver DX",
        text = {
            "{C:attention}+4{} hand size",
            "for this blind"
        }
    }

    local alchemy_quicksilver = CodexArcanum.Alchemical:newDX("Quicksilver", "quicksilver", {extra = 4}, { x = 4, y = 0 }, alchemy_quicksilver_def, 5)
    alchemy_quicksilver:registerDX()
            
    function CodexArcanum.DXAlchemicals.c_alchemy_quicksilver_dx.can_use(card)
        return true
    end

    function CodexArcanum.DXAlchemicals.c_alchemy_quicksilver_dx.use(card, area, copier)
        G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.1,func = function()
            G.hand:change_size(card.ability.extra)
            if not G.deck.config.quicksilver then G.deck.config.quicksilver = 0 end
            G.deck.config.quicksilver = G.deck.config.quicksilver + card.ability.extra
        return true end }))
    end


    local alchemy_salt_def = {
        name = "Salt DX",
        text = {
            "Gain {C:attention}2{} tags"
        }
    }

    local alchemy_salt = CodexArcanum.Alchemical:newDX("Salt", "salt", {extra = 2}, { x = 5, y = 0 }, alchemy_salt_def, 5)
    alchemy_salt:registerDX()
            
    function CodexArcanum.DXAlchemicals.c_alchemy_salt_dx.can_use(card)
        return true
    end

    function CodexArcanum.DXAlchemicals.c_alchemy_salt_dx.use(card, area, copier)
        for i = 1, card.ability.extra do
            G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.1,func = function()
                if G.FORCE_TAG then return G.FORCE_TAG end
                local _pool, _pool_key = get_current_pool('Tag', nil, nil, nil)
                local _tag_name = pseudorandom_element(_pool, pseudoseed(_pool_key))
                local it = 1
                while _tag_name == 'UNAVAILABLE' or _tag_name == "tag_double" or _tag_name == "tag_orbital" do
                    it = it + 1
                    _tag_name = pseudorandom_element(_pool, pseudoseed(_pool_key..'_resample'..it))
                end
    
                G.GAME.round_resets.blind_tags = G.GAME.round_resets.blind_tags or {}
                local _tag = Tag(_tag_name, nil, G.GAME.blind)
                add_tag(_tag)
            return true end }))
        end
    end
    

    local alchemy_sulfur_def = {
        name = "Sulfur DX",
        text = {
            "Reduce hands to {C:attention}1",
            "Gain {C:attention}$6{} for each",
            "hand removed"
        }
    }

    local alchemy_sulfur = CodexArcanum.Alchemical:newDX("Sulfur", "sulfur", {extra = 6}, { x = 0, y = 1 }, alchemy_sulfur_def, 5)
    alchemy_sulfur:registerDX()
            
    function CodexArcanum.DXAlchemicals.c_alchemy_sulfur_dx.can_use(card)
        return true
    end

    function CodexArcanum.DXAlchemicals.c_alchemy_sulfur_dx.use(card, area, copier)
        G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.1,func = function()
            local prev_hands = G.GAME.current_round.hands_left
            ease_hands_played(-(prev_hands - 1))
            ease_dollars(card.ability.extra * (prev_hands - 1), true)
        return true end }))
    end

    
    local alchemy_phosphorus_def = {
        name = "Phosphorus DX",
        text = {
            "Draw {C:attention}8{}",
            "discarded cards"
        }
    }

    local alchemy_phosphorus = CodexArcanum.Alchemical:newDX("Phosphorus", "phosphorus", {extra = 8}, { x = 1, y = 1 }, alchemy_phosphorus_def, 5)
    alchemy_phosphorus:registerDX()
            
    function CodexArcanum.DXAlchemicals.c_alchemy_phosphorus_dx.can_use(card)
        return true
    end

    function CodexArcanum.DXAlchemicals.c_alchemy_phosphorus_dx.use(card, area, copier)
        G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.1,func = function()
            draw_cards_from_discard(card.ability.extra)
        return true end }))
    end

    
    local alchemy_bismuth_def = {
        name = "Bismuth DX",
        text = {
        "Converts up to",
        "{C:attention}4{} selected cards",
        "to {C:dark_edition}Polychrome{}",
        "for one blind"
        }
    }

    local alchemy_bismuth = CodexArcanum.Alchemical:newDX("Bismuth", "bismuth", {extra = 4}, { x = 2, y = 1 }, alchemy_bismuth_def, 5)
    alchemy_bismuth:registerDX()
            
    function CodexArcanum.DXAlchemicals.c_alchemy_bismuth_dx.can_use(card)
        if #G.hand.highlighted <= card.ability.extra and #G.hand.highlighted >= 1 then return true else return false end
    end

    function CodexArcanum.DXAlchemicals.c_alchemy_bismuth_dx.use(card, area, copier)
        G.deck.config.bismuth = G.deck.config.bismuth or {}
        G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.1,func = function()
            for k, card in ipairs(G.hand.highlighted) do
                card:set_edition({polychrome = true}, true)
                table.insert(G.deck.config.bismuth, card.unique_val)
            end
        return true end }))
    end

    
    local alchemy_cobalt_def = {
        name = "Cobalt DX",
        text = {
        "Upgrade currently",
        "selected {C:legendary,E:1}poker hand",
        "by {C:attention}3{} levels", 
        "{C:inactive}(hand: #1#)"
        }
    }

    local alchemy_cobalt = CodexArcanum.Alchemical:newDX("Cobalt", "cobalt", {extra = 3}, { x = 3, y = 1 }, alchemy_cobalt_def, 5)
    alchemy_cobalt:registerDX()
            
    function CodexArcanum.DXAlchemicals.c_alchemy_cobalt_dx.can_use(card)
        if #G.hand.highlighted >= 1 then return true else return false end
    end

    function CodexArcanum.DXAlchemicals.c_alchemy_cobalt_dx.use(card, area, copier)
        G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.1,func = function()
            local text,disp_text = G.FUNCS.get_poker_hand_info(G.hand.highlighted)
            update_hand_text({sound = 'button', volume = 0.7, pitch = 0.8, delay = 0.3}, {handname=localize(text, 'poker_hands'),chips = G.GAME.hands[text].chips, mult = G.GAME.hands[text].mult, level=G.GAME.hands[text].level})
            level_up_hand(self, text, nil, card.ability.extra)
            update_hand_text({sound = 'button', volume = 0.7, pitch = 1.1, delay = 0}, {mult = 0, chips = 0, handname = '', level = ''})
        return true end }))
    end

    
    local alchemy_arsenic_def = {
        name = "Arsenic DX",
        text = {
        "{C:attention}Set{} your hands",
        "and your discards to the",
        "highest value of the two"
        }
    }

    local alchemy_arsenic = CodexArcanum.Alchemical:newDX("Arsenic", "arsenic", {}, { x = 4, y = 1 }, alchemy_arsenic_def, 5)
    alchemy_arsenic:registerDX()
            
    function CodexArcanum.DXAlchemicals.c_alchemy_arsenic_dx.can_use(card)
        return true
    end

    function CodexArcanum.DXAlchemicals.c_alchemy_arsenic_dx.use(card, area, copier)
        G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.1,func = function()
            local temp_hands = G.GAME.current_round.hands_left
            local temp_discards = G.GAME.current_round.discards_left
            local set_num = math.max(temp_hands, temp_discards)
            G.GAME.current_round.hands_left = 0
            G.GAME.current_round.discards_left = 0
            ease_hands_played(set_num)
            ease_discard(set_num)
        return true end }))
    end

    
    local alchemy_antimony_def = {
        name = "Antimony DX",
        text = {
        "Create a {C:dark_edition}Negative{} {C:eternal}eternal{}",
        "{C:attention}copy{} of a selected",
        "joker for one blind"
        }
    }

    local alchemy_antimony = CodexArcanum.Alchemical:newDX("Antimony", "antimony", {}, { x = 5, y = 1 }, alchemy_antimony_def, 5)
    alchemy_antimony:registerDX()
                
    function CodexArcanum.DXAlchemicals.c_alchemy_antimony_dx.can_use(card)
        return #G.jokers.highlighted == 1
    end

    function CodexArcanum.DXAlchemicals.c_alchemy_antimony_dx.use(card, area, copier)
        G.jokers.config.antimony = G.jokers.config.antimony or {}
        G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.1,func = function()
            if #G.jokers.highlighted > 0 then 
                local chosen_joker = G.jokers.highlighted[1]
                local card = copy_card(chosen_joker, nil, nil, nil, chosen_joker.edition and chosen_joker.edition.negative)
                card:set_edition({negative = true}, true)
                card:set_eternal(true)
                if card.ability.invis_rounds then card.ability.invis_rounds = 0 end
                card:add_to_deck()
                G.jokers:emplace(card)
                table.insert(G.jokers.config.antimony, card.unique_val)
            end
        return true end }))
    end

    
    local alchemy_soap_def = {
        name = "Soap DX",
        text = {
            "Select up to {C:attention}3{}",
            "cards. Replace any non",
            "selected card with",
            "cards from your deck"
        }
    }

    local alchemy_soap = CodexArcanum.Alchemical:newDX("Soap", "soap", {extra = 3}, { x = 0, y = 2 }, alchemy_soap_def, 5)
    alchemy_soap:registerDX()
                    
    function CodexArcanum.DXAlchemicals.c_alchemy_soap_dx.can_use(card)
        return #G.hand.highlighted <= card.ability.extra
    end

    function CodexArcanum.DXAlchemicals.c_alchemy_soap_dx.use(card, area, copier)
        G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.1,func = function()
            local nb = 0
            for k, _card in ipairs(G.hand.cards) do
                if not _card.highlighted then return_to_deck(card.ability.extra, _card); nb = nb + 1 end
            end
            G.FUNCS.draw_from_deck_to_hand(nb)
        return true end }))
    end

    
    local alchemy_manganese_def = {
        name = "Manganese DX",
        text = {
            "Enhances up to",
            "{C:attention}4{} selected cards",
            "into {C:attention}Steel Cards",
            "for one blind",
            "Creates a copy of",
            "{C:alchemical}Manganese{}"
        }
    }

    local alchemy_manganese = CodexArcanum.Alchemical:newDX("Manganese", "manganese", {extra = 4}, { x = 1, y = 2 }, alchemy_manganese_def, 5)
    alchemy_manganese:registerDX()
                        
    function CodexArcanum.DXAlchemicals.c_alchemy_manganese_dx.can_use(card)
        if #G.hand.highlighted <= card.ability.extra and #G.hand.highlighted >= 1 then return true else return false end
    end

    function CodexArcanum.DXAlchemicals.c_alchemy_manganese_dx.use(card, area, copier)
        G.deck.config.manganese = G.deck.config.manganese or {}
        G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.1,func = function()
            for k, card in ipairs(G.hand.highlighted) do
                delay(0.05)
                card:juice_up(1, 0.5)
                card:set_ability(G.P_CENTERS.m_steel)
                table.insert(G.deck.config.manganese, card.unique_val)
            end
        return true end }))
        G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.1,func = function()
            if #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
                G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
                local card = create_card('Alchemical', G.pack_cards, nil, nil, nil, nil, 'c_alchemy_manganese', 'dx')
                card:add_to_deck()
                G.consumeables:emplace(card)
            end
        return true end }))
    end

    
    local alchemy_wax_def = {
        name = "Wax DX",
        text = {
            "Create {C:attention}4{} temporary",
            "copies of selected card",
            "for one blind"
        }
    }

    local alchemy_wax = CodexArcanum.Alchemical:newDX("Wax", "wax", {extra = 4}, { x = 2, y = 2 }, alchemy_wax_def, 5)
    alchemy_wax:registerDX()
            
    function CodexArcanum.DXAlchemicals.c_alchemy_wax_dx.can_use(card)
        return #G.hand.highlighted == 1
    end

    function CodexArcanum.DXAlchemicals.c_alchemy_wax_dx.use(card, area, copier)
        G.deck.config.wax = G.deck.config.wax or {}
        G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.1,func = function()
            for i = 1, card.ability.extra do
                G.playing_card = (G.playing_card and G.playing_card + 1) or 1
                local _card = copy_card(G.hand.highlighted[1], nil, nil, G.playing_card)
                _card:add_to_deck()
                G.deck.config.card_limit = G.deck.config.card_limit + 1
                table.insert(G.playing_cards, _card)
                G.hand:emplace(_card)
                _card:start_materialize(nil, _first_dissolve)
                table.insert(G.deck.config.wax, _card.unique_val)
            end
            playing_card_joker_effects(new_cards)
        return true end }))
    end

    
    local alchemy_borax_def = {
        name = "Borax DX",
        text = {
            "Converts your hand",
            "into most common {C:attention}suit",
            "for one blind"
        }
    }

    local alchemy_borax = CodexArcanum.Alchemical:newDX("Borax", "borax", {}, { x = 3, y = 2 }, alchemy_borax_def, 5)
    alchemy_borax:registerDX()
            
    function CodexArcanum.DXAlchemicals.c_alchemy_borax_dx.can_use(card)
        return true
    end

    function CodexArcanum.DXAlchemicals.c_alchemy_borax_dx.use(card, area, copier)
        G.deck.config.borax = G.deck.config.borax or {}
        G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.1,func = function()
            local suit_to_card_couner = {}
            for _, v in pairs(SMODS.Card.SUITS) do
                if not v.disabled then
                    suit_to_card_couner[v.name] = 0
                end
            end

            for _, v in pairs(G.playing_cards) do
                suit_to_card_couner[v.base.suit] = suit_to_card_couner[v.base.suit] + 1
            end

            local top_suit = "";
            local top_count = 0;
            for suit, count in pairs(suit_to_card_couner) do
                if top_count < count then
                    top_suit = suit
                    top_count = count
                end
            end

            for k, card in ipairs(G.hand.cards) do
                delay(0.05)
                card:juice_up(1, 0.5)
                local prev_suit = card.base.suit
                card:change_suit(top_suit)
                table.insert(G.deck.config.borax, {id = card.unique_val, suit = prev_suit})
            end
        return true end }))
    end

            
    local alchemy_glass_def = {
        name = "Glass DX",
        text = {
            "Enhances up to",
            "{C:attention}4{} selected cards",
            "into {C:attention}Glass Cards",
            "for one blind",
            "Creates a copy of",
            "{C:alchemical}Glass{}"
        }
    }

    local alchemy_glass = CodexArcanum.Alchemical:newDX("Glass", "glass", {extra = 4}, { x = 4, y = 2 }, alchemy_glass_def, 5)
    alchemy_glass:registerDX()
                
    function CodexArcanum.DXAlchemicals.c_alchemy_glass_dx.can_use(card)
        if #G.hand.highlighted <= card.ability.extra and #G.hand.highlighted >= 1 then return true else return false end
    end

    function CodexArcanum.DXAlchemicals.c_alchemy_glass_dx.use(card, area, copier)
        G.deck.config.glass = G.deck.config.glass or {}
        G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.1,func = function()
            for k, card in ipairs(G.hand.highlighted) do
                delay(0.05)
                card:juice_up(1, 0.5)
                card:set_ability(G.P_CENTERS.m_glass)
                table.insert(G.deck.config.glass, card.unique_val)
            end
        return true end }))
        G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.1,func = function()
            if #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
                G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
                local card = create_card('Alchemical', G.pack_cards, nil, nil, nil, nil, 'c_alchemy_glass', 'dx')
                card:add_to_deck()
                G.consumeables:emplace(card)
            end
        return true end }))
    end


    local alchemy_magnet_def = {
        name = "Magnet DX",
        text = {
            "Draw {C:attention}4{} cards",
            "of the same rank",
            "as the selected card"
        }
    }

    local alchemy_magnet = CodexArcanum.Alchemical:newDX("Magnet", "magnet", {extra = 4}, { x = 5, y = 2 }, alchemy_magnet_def, 5)
    alchemy_magnet:registerDX()
                
    function CodexArcanum.DXAlchemicals.c_alchemy_magnet_dx.can_use(card)
        return #G.hand.highlighted == 1
    end

    function CodexArcanum.DXAlchemicals.c_alchemy_magnet_dx.use(card, area, copier)
        G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.1,func = function()
            local cur_rank = G.hand.highlighted[1].base.id
            local count = card.ability.extra
            for _, v in pairs(G.deck.cards) do
                if v.base.id == cur_rank and count > 0 then
                    delay(0.05)
                    draw_card(G.deck, G.hand, 100, 'up', true, v)
                    count = count - 1
                end
            end
        return true end }))
    end


    local alchemy_gold_def = {
        name = "Gold DX",
        text = {
            "Enhances up to",
            "{C:attention}4{} selected cards",
            "into {C:attention}Gold Cards",
            "for one blind",
            "Creates a copy of",
            "{C:alchemical}Gold{}"
        }
    }

    local alchemy_gold = CodexArcanum.Alchemical:newDX("Gold", "gold", {extra = 4}, { x = 0, y = 3 }, alchemy_gold_def, 5)
    alchemy_gold:registerDX()
                
    function CodexArcanum.DXAlchemicals.c_alchemy_gold_dx.can_use(card)
        if #G.hand.highlighted <= card.ability.extra and #G.hand.highlighted >= 1 then return true else return false end
    end
    
    function CodexArcanum.DXAlchemicals.c_alchemy_gold_dx.use(card, area, copier)
        G.deck.config.gold = G.deck.config.gold or {}
        G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.1,func = function()
            for k, card in ipairs(G.hand.highlighted) do
                delay(0.05)
                card:juice_up(1, 0.5)
                card:set_ability(G.P_CENTERS.m_gold)
                table.insert(G.deck.config.gold, card.unique_val)
            end
        return true end }))
        G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.1,func = function()
            if #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
                G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
                local card = create_card('Alchemical', G.pack_cards, nil, nil, nil, nil, 'c_alchemy_gold', 'dx')
                card:add_to_deck()
                G.consumeables:emplace(card)
            end
        return true end }))
    end


    local alchemy_silver_def = {
        name = "Silver DX",
        text = {
            "Enhances up to",
            "{C:attention}4{} selected cards",
            "into {C:attention}Lucky Cards",
            "for one blind",
            "Creates a copy of",
            "{C:alchemical}Silver{}"
        }
    }

    local alchemy_silver = CodexArcanum.Alchemical:newDX("Silver", "silver", {extra = 4}, { x = 1, y = 3 }, alchemy_silver_def, 5)
    alchemy_silver:registerDX()
                
    function CodexArcanum.DXAlchemicals.c_alchemy_silver_dx.can_use(card)
        if #G.hand.highlighted <= card.ability.extra and #G.hand.highlighted >= 1 then return true else return false end
    end
        
    function CodexArcanum.DXAlchemicals.c_alchemy_silver_dx.use(card, area, copier)
        G.deck.config.silver = G.deck.config.silver or {}
        G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.1,func = function()
            for k, card in ipairs(G.hand.highlighted) do
                delay(0.05)
                card:juice_up(1, 0.5)
                card:set_ability(G.P_CENTERS.m_lucky)
                table.insert(G.deck.config.silver, card.unique_val)
            end
        return true end }))
        G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.1,func = function()
            if #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
                G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
                local card = create_card('Alchemical', G.pack_cards, nil, nil, nil, nil, 'c_alchemy_silver', 'dx')
                card:add_to_deck()
                G.consumeables:emplace(card)
            end
        return true end }))
    end


    local alchemy_oil_def = {
        name = "Oil DX",
        text = {
            "Removes {C:attention}debuffs{}",
            "of all cards",
            "in hand",
            "Creates a copy of",
            "{C:alchemical}Oil{}"
        }
    }

    local alchemy_oil = CodexArcanum.Alchemical:newDX("Oil", "oil", {}, { x = 2, y = 3 }, alchemy_oil_def, 5)
    alchemy_oil:registerDX()
                
    function CodexArcanum.DXAlchemicals.c_alchemy_oil_dx.can_use(card)
        return true 
    end
        
    function CodexArcanum.DXAlchemicals.c_alchemy_oil_dx.use(card, area, copier)
        G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.1,func = function()
            for k, v in ipairs(G.hand.cards) do
                delay(0.05)
                v:juice_up(1, 0.5)
                v.params.debuff_by_curse = nil
                v:set_debuff(false)
                v.config = v.config or {}
                v.config.oil = true
                if v.facing == 'back' then
                    v:flip()
                end
            end
        return true end }))
        G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.1,func = function()
            if #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
                G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
                local card = create_card('Alchemical', G.pack_cards, nil, nil, nil, nil, 'c_alchemy_oil', 'dx')
                card:add_to_deck()
                G.consumeables:emplace(card)
            end
        return true end }))
    end
    
    -- Need to override the base mod function to remove curses debuffs
    function CodexArcanum.Alchemicals.c_alchemy_oil.use(card, area, copier)
        G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.1,func = function()
            for k, v in ipairs(G.hand.cards) do
                delay(0.05)
                v:juice_up(1, 0.5)
                v.params.debuff_by_curse = nil
                v:set_debuff(false)
                v.ability.extra = v.ability.extra or {}
                v.ability.extra.oil = true
                if v.facing == 'back' then
                    v:flip()
                end
            end
        return true end }))
    end


    local alchemy_acid_def = {
        name = "Acid DX",
        text = {
            "Select up to {C:attention}3{} cards,",
            "{C:attention}destroy{} all cards of",
            "the selected ranks.",
            "All cards are {C:attention}returned{}",
            "after one blind"
        }
    }

    local alchemy_acid = CodexArcanum.Alchemical:newDX("Acid", "acid", {extra = 3}, { x = 3, y = 3 }, alchemy_acid_def, 5)
    alchemy_acid:registerDX()
                
    function CodexArcanum.DXAlchemicals.c_alchemy_acid_dx.can_use(card)
        return (#G.hand.highlighted <= card.ability.extra and #G.hand.highlighted >= 1)
    end

    function CodexArcanum.DXAlchemicals.c_alchemy_acid_dx.use(card, area, copier)
        G.deck.config.acid = G.deck.config.acid or {}
        G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.1,func = function()
            for i = 1, card.ability.extra do
                for k, v in ipairs(G.playing_cards) do
                    if v:get_id() == G.hand.highlighted[i]:get_id() then
                        table.insert(G.deck.config.acid, v)
                        v:start_dissolve({HEX("E3FF37")}, nil, 1.6)
                    end 
                end
            end
            for j=1, #G.jokers.cards do
                eval_card(G.jokers.cards[j], {cardarea = G.jokers, remove_playing_cards = true, removed = G.deck.config.acid})
            end
        return true end }))
    end


    local alchemy_brimstone_def = {
        name = "Brimstone DX",
        text = {
            "{C:attention}+2{} hands, {C:attention}+2{} discards"
        }
    }

    local alchemy_brimstone = CodexArcanum.Alchemical:newDX("Brimstone", "brimstone", {extra = 2}, { x = 4, y = 3 }, alchemy_brimstone_def, 5)
    alchemy_brimstone:registerDX()
                
    function CodexArcanum.DXAlchemicals.c_alchemy_brimstone_dx.can_use(card)
        return true
    end

    function CodexArcanum.DXAlchemicals.c_alchemy_brimstone_dx.use(card, area, copier)
        G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.1,func = function()
            ease_discard(card.ability.extra)
            ease_hands_played(card.ability.extra)
        return true end }))
    end


    local alchemy_uranium_def = {
        name = "Uranium DX",
        text = {
            "Copy the selected card's",
            "{C:attention}enhancement{}, {C:attention}seal{}, and {C:attention}edition",
            "to unenhanced cards in",
            "hand for one blind"
        },
        unlock = {
            "Use {C:attention}5",
            "{E:1,C:alchemical}Alchemical{} cards in",
            "the same run"
        }
    }


    local alchemy_uranium = CodexArcanum.Alchemical:newDX("Uranium", "uranium", {extra = 1}, { x = 5, y = 3 }, alchemy_uranium_def, 5, false, false, {type = 'used_alchemical', extra = 5})
    alchemy_uranium:registerDX()
            
    function CodexArcanum.DXAlchemicals.c_alchemy_uranium_dx.can_use(card)
        return #G.hand.highlighted == card.ability.extra
    end

    function CodexArcanum.DXAlchemicals.c_alchemy_uranium_dx.use(card, area, copier)
        G.deck.config.uranium = G.deck.config.uranium or {}
        G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.1,func = function()
            local eligible_cards = {}
            for k, v in ipairs(G.hand.cards) do
                if v.config.center == G.P_CENTERS.c_base and not (v.edition) and not (v.seal) and not v.highlighted then
                    table.insert(eligible_cards, v)
                end
            end

            if #eligible_cards > 0 then
                for k, v in ipairs(eligible_cards) do
                    delay(0.05)
                    if not (G.hand.highlighted[1].edition) then v:juice_up(1, 0.5) end
                    v:set_ability(G.hand.highlighted[1].config.center)
                    v:set_seal(G.hand.highlighted[1]:get_seal(true))
                    v:set_edition(G.hand.highlighted[1].edition)
                    table.insert(G.deck.config.uranium, v.unique_val)
                end
            end
        return true end }))
    end
end

-- Load the DX alchemical boosters
function load_dx_alchemical_packs()
    G.localization.misc.dictionary["k_alchemy_pack_dx"] = "Alchemy Pack DX"

    G.localization.descriptions["Other"]["p_alchemy_normal_dx"] = {
      name = "Alchemy Pack DX",
      text = {
          "Choose {C:attention}#1#{} of up to",
          "{C:attention}#2#{C:alchemical} Alchemical{} cards to",
          "add to your consumeables",
            "{C:inactive}(You feel lucky...)"
      }
    }
  
    G.localization.descriptions["Other"]["p_alchemy_jumbo_dx"] = {
      name = "Jumbo Alchemy Pack DX",
      text = {
          "Choose {C:attention}#1#{} of up to",
          "{C:attention}#2#{C:alchemical} Alchemical{} cards to",
          "add to your consumeables",
            "{C:inactive}(You feel lucky...)"
      }
    }
  
    G.localization.descriptions["Other"]["p_alchemy_mega_dx"] = {
      name = "Mega Alchemy Pack DX",
      text = {
          "Choose {C:attention}#1#{} of up to",
          "{C:attention}#2#{C:alchemical} Alchemical{} cards to",
          "add to your consumeables",
            "{C:inactive}(You feel lucky...)"
      }
    }
  
    SMODS.Booster:newDX("Alchemy Pack", "alchemy_normal_1", {extra = 3, choose = 1, unique = true}, { x = 0, y = 0 }, 6, false, 1, "Celestial", "ca_booster_dx_atlas"):registerDX()
    SMODS.Booster:newDX("Alchemy Pack", "alchemy_normal_2", {extra = 3, choose = 1, unique = true}, { x = 1, y = 0 }, 6, false, 1, "Celestial", "ca_booster_dx_atlas"):registerDX()
    SMODS.Booster:newDX("Alchemy Pack", "alchemy_normal_3", {extra = 3, choose = 1, unique = true}, { x = 2, y = 0 }, 6, false, 1, "Celestial", "ca_booster_dx_atlas"):registerDX()
    SMODS.Booster:newDX("Alchemy Pack", "alchemy_normal_4", {extra = 3, choose = 1, unique = true}, { x = 3, y = 0 }, 6, false, 1, "Celestial", "ca_booster_dx_atlas"):registerDX()
    SMODS.Booster:newDX("Jumbo Alchemy Pack", "alchemy_jumbo_1", {extra = 5, choose = 1, unique = true}, { x = 0, y = 1 }, 8, false, 1, "Celestial", "ca_booster_dx_atlas"):registerDX()
    SMODS.Booster:newDX("Jumbo Alchemy Pack", "alchemy_jumbo_2", {extra = 5, choose = 1, unique = true}, { x = 1, y = 1 }, 8, false, 1, "Celestial", "ca_booster_dx_atlas"):registerDX()
    SMODS.Booster:newDX("Mega Alchemy Pack", "alchemy_mega_1", {extra = 5, choose = 2, unique = true}, { x = 2, y = 1 }, 10, false, 0.25, "Celestial", "ca_booster_dx_atlas"):registerDX()
end

-- Load DX tarots
function load_dx_cu_alchemical_tarots()

    G.localization.descriptions.Tarot_dx.c_seeker_dx = {
        name = "The Seeker DX",
        text = {
            "Creates up to {C:attention}#1#",
            "random {C:alchemical}Alchemical{} {C:dark_edition}DX{} cards",
            "{C:inactive}(Must have room)"
        }
    }
    G.localization.descriptions.Spectral_dx.c_philosopher_stone_dx = {
        name = "Philosopher's Stone DX",
        text = {
            "{C:attention}Retrigger{} all played cards",
            "for three blinds"
        }
    }
    
    G.localization.descriptions.Tarot_cu.c_seeker_cu = {
        name = "The Cursed Seeker",
        text = {
            "{C:alchemical}Alchemical{} packs and cards",
            "are {C:attention}50% off{}. {C:alchemical}Alchemical{} cards",
            "are {C:attention}#1# times{} more likely",
            "to be {C:dark_edition}DX{}"
        }
    }

    -- DX
    G.P_CENTERS.c_seeker_dx =               {order = 22,    discovered = true, cost = 5, consumeable = true, name = "The Seeker DX", pos = {x=0,y=0}, set = "Tarot", effect = "Round Bonus", cost_mult = 1.0, config = {type = '_dx', alchemicals = 2}, atlas = 'ca_others_dx_atlas'}
    G.P_CENTERS.c_philosopher_stone_dx =    {order = 19,    discovered = true, cost = 6, consumeable = true, name = "Philosopher's Stone DX", pos = {x=0,y=1}, set = "Spectral", config = {type = '_dx', extra = 3, unique = true}, atlas = 'ca_others_dx_atlas'}
    
    -- Cursed
    G.P_CENTERS.c_seeker_cu=                {order = 23,    discovered = true, cost = 5, consumeable = true, name = "The Cursed Seeker", pos = {x=0,y=0}, set = "Tarot", effect = "Round Bonus", cost_mult = 1.0, config = {type = '_cu', prob_mult = 2, unique = true, nb_curse = 2}, atlas = 'ca_others_cu_atlas'}

    -- Update tables
    G.P_CENTER_POOLS.Tarot_dx = {}
    G.P_CENTER_POOLS.Tarot_cu = {}
    G.P_CENTER_POOLS.Planet_dx = {}
    G.P_CENTER_POOLS.Spectral_dx = {}
    G.P_CENTER_POOLS.Booster_dx = {}

    for k, v in pairs(G.P_CENTERS) do
        v.key = k
        if not v.wip then 
            if v.set == 'Tarot' or v.set == 'Planet' or v.set == 'Spectral' or v.set == 'Booster' then
                if v.config and (v.config.type ==  '_dx' or v.config.type ==  '_cu') then
                    table.insert(G.P_CENTER_POOLS[v.set..v.config.type], v)
                end
            end
        end
    end

    table.sort(G.P_CENTER_POOLS["Tarot_dx"], function (a, b) return a.order < b.order end)
    table.sort(G.P_CENTER_POOLS["Tarot_cu"], function (a, b) return a.order < b.order end)
    table.sort(G.P_CENTER_POOLS["Planet_dx"], function (a, b) return a.order < b.order end)
    table.sort(G.P_CENTER_POOLS["Spectral_dx"], function (a, b) return a.order < b.order end)
    table.sort(G.P_CENTER_POOLS["Booster_dx"], function (a, b) return a.order < b.order end)

end

-- Load DX expansion
function CodexArcanum.LoadDX()
    sendDebugMessage("Codex Arcanum DX Loaded")

    -- DX Sprites

    local js_mod = SMODS.findModByID("JeffDeluxeConsumablesPack")
    SMODS.Sprite:new("alchemical_dx_atlas", js_mod.path, "alchemical_dx_atlas.png", 71, 95, "asset_atli"):register();
	SMODS.Sprite:new("ca_booster_dx_atlas", js_mod.path, "ca_booster_dx_atlas.png", 71, 95, "asset_atli"):register();
	SMODS.Sprite:new("ca_others_dx_atlas", js_mod.path, "ca_others_dx_atlas.png", 71, 95, "asset_atli"):register();
	SMODS.Sprite:new("ca_others_cu_atlas", js_mod.path, "ca_others_cu_atlas.png", 71, 95, "asset_atli"):register();
    
	G.P_CENTER_POOLS.Alchemical_dx = {}
	G.localization.descriptions.Alchemical_dx = {}

    load_dx_alchemical_cards()
    load_dx_alchemical_packs()
    load_dx_cu_alchemical_tarots()

end
