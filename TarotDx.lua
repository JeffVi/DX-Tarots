--- STEAMODDED HEADER
--- MOD_NAME: Deluxe Consumables Cards
--- MOD_ID: JeffDeluxeConsumablesPack
--- MOD_AUTHOR: [JeffVi]
--- MOD_DESCRIPTION: Add Deluxe versions of consumables

----------------------------------------------
------------MOD CODE -------------------------

-- SET CUSTOM CONFIG HERE

local tarot_dx_rate = 0.1               -- (from 0 (0%) to 1 (100%))
local planet_dx_rate = 0.1              -- (from 0 (0%) to 1 (100%))
local spectral_dx_rate = 0.2            -- (from 0 (0%) to 1 (100%))
local planet_edition_enabled = true     -- Enable/Disable the possibility of planet cards edition (may not be compatible with other mods that overwrite the level_up_hand function)
local spectral_on_blank = true          -- Enable/Disable spectral rate on blank voucher

-- END CUSTOM CONFIGS

---------- local functions ----------

local function setUpConsumables()
    
    -- Tarots
    G.P_CENTERS.c_fool_dx=             {order = 1,     discovered = true, cost = 5, consumeable = true, name = "The Fool DX", pos = {x=0,y=0}, set = "Tarot_dx", effect = "Disable Blind Effect", cost_mult = 1.0, config = {}}
    G.P_CENTERS.c_magician_dx=         {order = 2,     discovered = true, cost = 5, consumeable = true, name = "The Magician DX", pos = {x=1,y=0}, set = "Tarot_dx", effect = "Enhance", cost_mult = 1.0, config = {mod_conv = 'm_lucky', max_highlighted = 2}}
    G.P_CENTERS.c_high_priestess_dx=   {order = 3,     discovered = true, cost = 5, consumeable = true, name = "The High Priestess DX", pos = {x=2,y=0}, set = "Tarot_dx", effect = "Round Bonus", cost_mult = 1.0, config = {planets = 2}}
    G.P_CENTERS.c_empress_dx=          {order = 4,     discovered = true, cost = 5, consumeable = true, name = "The Empress DX", pos = {x=3,y=0}, set = "Tarot_dx", effect = "Enhance", cost_mult = 1.0, config = {mod_conv = 'm_mult', max_highlighted = 4}}
    G.P_CENTERS.c_emperor_dx=          {order = 5,     discovered = true, cost = 5, consumeable = true, name = "The Emperor DX", pos = {x=4,y=0}, set = "Tarot_dx", effect = "Round Bonus", cost_mult = 1.0, config = {tarots = 2}}
    G.P_CENTERS.c_heirophant_dx=       {order = 6,     discovered = true, cost = 5, consumeable = true, name = "The Hierophant DX", pos = {x=5,y=0}, set = "Tarot_dx", effect = "Enhance", cost_mult = 1.0, config = {mod_conv = 'm_bonus', max_highlighted = 4}}
    G.P_CENTERS.c_lovers_dx=           {order = 7,     discovered = true, cost = 5, consumeable = true, name = "The Lovers DX", pos = {x=6,y=0}, set = "Tarot_dx", effect = "Enhance", cost_mult = 1.0, config = {mod_conv = 'm_wild', max_highlighted = 2}}
    G.P_CENTERS.c_chariot_dx=          {order = 8,     discovered = true, cost = 5, consumeable = true, name = "The Chariot DX", pos = {x=7,y=0}, set = "Tarot_dx", effect = "Enhance", cost_mult = 1.0, config = {mod_conv = 'm_steel', max_highlighted = 2}}
    G.P_CENTERS.c_justice_dx=          {order = 9,     discovered = true, cost = 5, consumeable = true, name = "Justice DX", pos = {x=8,y=0}, set = "Tarot_dx", effect = "Enhance", cost_mult = 1.0, config = {mod_conv = 'm_glass', max_highlighted = 2}}
    G.P_CENTERS.c_hermit_dx=           {order = 10,    discovered = true, cost = 5, consumeable = true, name = "The Hermit DX", pos = {x=9,y=0}, set = "Tarot_dx", effect = "Dollar Doubler", cost_mult = 1.0, config = {extra = 30}}
    G.P_CENTERS.c_wheel_of_fortune_dx= {order = 11,    discovered = true, cost = 5, consumeable = true, name = "The Wheel of Fortune DX", pos = {x=0,y=1}, set = "Tarot_dx", effect = "Round Bonus", cost_mult = 1.0, config = {extra = 3}}
    G.P_CENTERS.c_strength_dx=         {order = 12,    discovered = true, cost = 5, consumeable = true, name = "Strength DX", pos = {x=1,y=1}, set = "Tarot_dx", effect = "Round Bonus", cost_mult = 1.0, config = {mod_conv = 'up_rank', max_highlighted = 4}}
    G.P_CENTERS.c_hanged_man_dx=       {order = 13,    discovered = true, cost = 5, consumeable = true, name = "The Hanged Man DX", pos = {x=2,y=1}, set = "Tarot_dx", effect = "Card Removal", cost_mult = 1.0, config = {remove_card = true, max_highlighted = 4}}
    G.P_CENTERS.c_death_dx=            {order = 14,    discovered = true, cost = 5, consumeable = true, name = "Death DX", pos = {x=3,y=1}, set = "Tarot_dx", effect = "Card Conversion", cost_mult = 1.0, config = {mod_conv = 'card', max_highlighted = 3, min_highlighted = 2}}
    G.P_CENTERS.c_temperance_dx=       {order = 15,    discovered = true, cost = 5, consumeable = true, name = "Temperance DX", pos = {x=4,y=1}, set = "Tarot_dx", effect = "Joker Payout", cost_mult = 1.0, config = {extra = 60}}
    G.P_CENTERS.c_devil_dx=            {order = 16,    discovered = true, cost = 5, consumeable = true, name = "The Devil DX", pos = {x=5,y=1}, set = "Tarot_dx", effect = "Enhance", cost_mult = 1.0, config = {mod_conv = 'm_gold', max_highlighted = 2}}
    G.P_CENTERS.c_tower_dx=            {order = 17,    discovered = true, cost = 5, consumeable = true, name = "The Tower DX", pos = {x=6,y=1}, set = "Tarot_dx", effect = "Enhance", cost_mult = 1.0, config = {mod_conv = 'm_stone', max_highlighted = 2}}
    G.P_CENTERS.c_star_dx=             {order = 18,    discovered = true, cost = 5, consumeable = true, name = "The Star DX", pos = {x=7,y=1}, set = "Tarot_dx", effect = "Suit Conversion", cost_mult = 1.0, config = {suit_conv = 'Diamonds', max_highlighted = 5}}
    G.P_CENTERS.c_moon_dx=             {order = 19,    discovered = true, cost = 5, consumeable = true, name = "The Moon DX", pos = {x=8,y=1}, set = "Tarot_dx", effect = "Suit Conversion", cost_mult = 1.0, config = {suit_conv = 'Clubs', max_highlighted = 5}}
    G.P_CENTERS.c_sun_dx=              {order = 20,    discovered = true, cost = 5, consumeable = true, name = "The Sun DX", pos = {x=9,y=1}, set = "Tarot_dx", effect = "Suit Conversion", cost_mult = 1.0, config = {suit_conv = 'Hearts', max_highlighted = 5}}
    G.P_CENTERS.c_judgement_dx=        {order = 21,    discovered = true, cost = 5, consumeable = true, name = "Judgement DX", pos = {x=0,y=2}, set = "Tarot_dx", effect = "Random Joker", cost_mult = 1.0, config = {}}
    G.P_CENTERS.c_world_dx=            {order = 22,    discovered = true, cost = 5, consumeable = true, name = "The World DX", pos = {x=1,y=2}, set = "Tarot_dx", effect = "Suit Conversion", cost_mult = 1.0, config = {suit_conv = 'Spades', max_highlighted = 5}}

    -- Planets
    G.P_CENTERS.c_mercury_dx=          {order = 1,    discovered = true, cost = 5, consumeable = true, freq = 1, name = "Mercury DX", pos = {x=0,y=3}, set = "Planet_dx", effect = "Hand Upgrade", cost_mult = 1.0, config = {hand_type = 'Pair'}}
    G.P_CENTERS.c_venus_dx=            {order = 2,    discovered = true, cost = 5, consumeable = true, freq = 1, name = "Venus DX", pos = {x=1,y=3}, set = "Planet_dx", effect = "Hand Upgrade", cost_mult = 1.0, config = {hand_type = 'Three of a Kind'}}
    G.P_CENTERS.c_earth_dx=            {order = 3,    discovered = true, cost = 5, consumeable = true, freq = 1, name = "Earth DX", pos = {x=2,y=3}, set = "Planet_dx", effect = "Hand Upgrade", cost_mult = 1.0, config = {hand_type = 'Full House'}}
    G.P_CENTERS.c_mars_dx=             {order = 4,    discovered = true, cost = 5, consumeable = true, freq = 1, name = "Mars DX", pos = {x=3,y=3}, set = "Planet_dx", effect = "Hand Upgrade", cost_mult = 1.0, config = {hand_type = 'Four of a Kind'}}
    G.P_CENTERS.c_jupiter_dx=          {order = 5,    discovered = true, cost = 5, consumeable = true, freq = 1, name = "Jupiter DX", pos = {x=4,y=3}, set = "Planet_dx", effect = "Hand Upgrade", cost_mult = 1.0, config = {hand_type = 'Flush'}}
    G.P_CENTERS.c_saturn_dx=           {order = 6,    discovered = true, cost = 5, consumeable = true, freq = 1, name = "Saturn DX", pos = {x=5,y=3}, set = "Planet_dx", effect = "Hand Upgrade", cost_mult = 1.0, config = {hand_type = 'Straight'}}
    G.P_CENTERS.c_uranus_dx=           {order = 7,    discovered = true, cost = 5, consumeable = true, freq = 1, name = "Uranus DX", pos = {x=6,y=3}, set = "Planet_dx", effect = "Hand Upgrade", cost_mult = 1.0, config = {hand_type = 'Two Pair'}}
    G.P_CENTERS.c_neptune_dx=          {order = 8,    discovered = true, cost = 5, consumeable = true, freq = 1, name = "Neptune DX", pos = {x=7,y=3}, set = "Planet_dx", effect = "Hand Upgrade", cost_mult = 1.0, config = {hand_type = 'Straight Flush'}}
    G.P_CENTERS.c_pluto_dx=            {order = 9,    discovered = true, cost = 5, consumeable = true, freq = 1, name = "Pluto DX", pos = {x=8,y=3}, set = "Planet_dx", effect = "Hand Upgrade", cost_mult = 1.0, config = {hand_type = 'High Card'}}
    G.P_CENTERS.c_planet_x_dx=         {order = 10,   discovered = true, cost = 5, consumeable = true, freq = 1, name = "Planet X DX", pos = {x=9,y=2}, set = "Planet_dx", effect = "Hand Upgrade", cost_mult = 1.0, config = {hand_type = 'Five of a Kind', softlock = true}}
    G.P_CENTERS.c_ceres_dx=            {order = 11,   discovered = true, cost = 5, consumeable = true, freq = 1, name = "Ceres DX", pos = {x=8,y=2}, set = "Planet_dx", effect = "Hand Upgrade", cost_mult = 1.0, config = {hand_type = 'Flush House', softlock = true}}
    G.P_CENTERS.c_eris_dx=             {order = 12,   discovered = true, cost = 5, consumeable = true, freq = 1, name = "Eris DX", pos = {x=3,y=2}, set = "Planet_dx", effect = "Hand Upgrade", cost_mult = 1.0, config = {hand_type = 'Flush Five', softlock = true}}

    -- Spectrals
    G.P_CENTERS.c_familiar_dx=         {order = 1,    discovered = true, cost = 6, consumeable = true, name = "Familiar DX", pos = {x=0,y=4}, set = "Spectral_dx", config = {max_highlighted = 2, min_highlighted = 2, remove_card = true, extra = 5}}
    G.P_CENTERS.c_grim_dx=             {order = 2,    discovered = true, cost = 6, consumeable = true, name = "Grim DX",     pos = {x=1,y=4}, set = "Spectral_dx", config = {max_highlighted = 2, min_highlighted = 2, remove_card = true, extra = 4}}
    G.P_CENTERS.c_incantation_dx=      {order = 3,    discovered = true, cost = 6, consumeable = true, name = "Incantation DX", pos = {x=2,y=4}, set = "Spectral_dx", config = {max_highlighted = 2, min_highlighted = 2, remove_card = true, extra = 6}}
    G.P_CENTERS.c_talisman_dx=         {order = 4,    discovered = true, cost = 6, consumeable = true, name = "Talisman DX", pos = {x=3,y=4}, set = "Spectral_dx", config = {extra = 'Gold', max_highlighted = 3}}
    G.P_CENTERS.c_aura_dx=             {order = 5,    discovered = true, cost = 6, consumeable = true, name = "Aura DX", pos = {x=4,y=4}, set = "Spectral_dx", config = {max_highlighted = 3}}
    G.P_CENTERS.c_wraith_dx=           {order = 6,    discovered = true, cost = 6, consumeable = true, name = "Wraith DX", pos = {x=5,y=4}, set = "Spectral_dx", config = {}}
    G.P_CENTERS.c_sigil_dx=            {order = 7,    discovered = true, cost = 6, consumeable = true, name = "Sigil DX", pos = {x=6,y=4}, set = "Spectral_dx", config = {max_highlighted = 1}}
    G.P_CENTERS.c_ouija_dx=            {order = 8,    discovered = true, cost = 6, consumeable = true, name = "Ouija DX", pos = {x=7,y=4}, set = "Spectral_dx", config = {max_highlighted = 1}}
    G.P_CENTERS.c_ectoplasm_dx=        {order = 9,    discovered = true, cost = 6, consumeable = true, name = "Ectoplasm DX", pos = {x=8,y=4}, set = "Spectral_dx", config = {}}
    G.P_CENTERS.c_immolate_dx=         {order = 10,   discovered = true, cost = 6, consumeable = true, name = "Immolate DX", pos = {x=9,y=4}, set = "Spectral_dx", config = {max_highlighted = 5, min_highlighted = 5, remove_card = true, extra = {destroy = 5, dollars = 20}}}
    G.P_CENTERS.c_ankh_dx=             {order = 11,   discovered = true, cost = 6, consumeable = true, name = "Ankh DX", pos = {x=0,y=5}, set = "Spectral_dx", config = {extra = 2}}
    G.P_CENTERS.c_deja_vu_dx=          {order = 12,   discovered = true, cost = 6, consumeable = true, name = "Deja Vu DX", pos = {x=1,y=5}, set = "Spectral_dx", config = {extra = 'Red', max_highlighted = 3}}
    G.P_CENTERS.c_hex_dx=              {order = 13,   discovered = true, cost = 6, consumeable = true, name = "Hex DX", pos = {x=2,y=5}, set = "Spectral_dx", config = {extra = 2}}
    G.P_CENTERS.c_trance_dx=           {order = 14,   discovered = true, cost = 6, consumeable = true, name = "Trance DX", pos = {x=3,y=5}, set = "Spectral_dx", config = {extra = 'Blue', max_highlighted = 3}}
    G.P_CENTERS.c_medium_dx=           {order = 15,   discovered = true, cost = 6, consumeable = true, name = "Medium DX", pos = {x=4,y=5}, set = "Spectral_dx", config = {extra = 'Purple', max_highlighted = 3}}
    G.P_CENTERS.c_cryptid_dx=          {order = 16,   discovered = true, cost = 6, consumeable = true, name = "Cryptid DX", pos = {x=5,y=5}, set = "Spectral_dx", config = {extra = 4, max_highlighted = 1}}
    G.P_CENTERS.c_soul_dx=             {order = 17,   discovered = true, cost = 6, consumeable = true, name = "The Soul DX", pos = {x=2,y=2}, set = "Spectral_dx", effect = "Unlocker", config = {}, hidden = true}
    G.P_CENTERS.c_black_hole_dx=       {order = 18,   discovered = true, cost = 6, consumeable = true, name = "Black Hole DX", pos = {x=9,y=3}, set = "Spectral_dx", config = {}, hidden = true}

    -- Update tables
    G.P_CENTER_POOLS.Tarot_dx = {}
    G.P_CENTER_POOLS.Planet_dx = {}
    G.P_CENTER_POOLS.Spectral_dx = {}

    for k, v in pairs(G.P_CENTERS) do
        v.key = k
        if not v.wip then 
            if v.set == 'Tarot_dx' or v.set == 'Planet_dx' or v.set == 'Spectral_dx' then
                table.insert(G.P_CENTER_POOLS[v.set], v)
            end
        end
    end

    table.sort(G.P_CENTER_POOLS["Tarot_dx"], function (a, b) return a.order < b.order end)
    table.sort(G.P_CENTER_POOLS["Planet_dx"], function (a, b) return a.order < b.order end)
    table.sort(G.P_CENTER_POOLS["Spectral_dx"], function (a, b) return a.order < b.order end)
end

local function setUpLocalizationTarotDX()
    
    G.localization.descriptions.Tarot_dx = {}

    G.localization.descriptions.Tarot_dx.c_fool_dx = {
        name = "The Fool DX",
        text = {
            "Creates up to {C:attention}2{} copies",
            "of the last {C:tarot}Tarot{} or {C:planet}Planet{} card",
            "used during this run",
            "{s:0.8,C:tarot}The Fool{s:0.8} excluded"
        }
    }
    G.localization.descriptions.Tarot_dx.c_magician_dx = {
        name = "The Magician DX",
        text = {
            "Enhances up to {C:attention}#1#{} selected",
            "cards into a",
            "{C:attention}#2#"
        }
    }
    G.localization.descriptions.Tarot_dx.c_high_priestess_dx = {
        name = "The High Priestess DX",
        text = {
            "Creates up to {C:attention}#1#",
            "random {C:planet}Planet{} {C:dark_edition}DX{} cards",
            "{C:inactive}(Must have room)"
        }
    }
    G.localization.descriptions.Tarot_dx.c_empress_dx = {
        name = "The Empress DX",
        text = {
            "Enhances up to {C:attention}#1#",
            "selected cards to",
            "{C:attention}#2#s"
        }
    }
    G.localization.descriptions.Tarot_dx.c_emperor_dx = {
        name = "The Emperor DX",
        text = {
            "Creates up to {C:attention}#1#",
            "random {C:tarot}Tarot{} {C:dark_edition}DX{} cards",
            "{C:inactive}(Must have room)"
        }
    }
    G.localization.descriptions.Tarot_dx.c_heirophant_dx = {
        name = "The Hierophant DX",
        text = {
            "Enhances up to {C:attention}#1#",
            "selected cards to",
            "{C:attention}#2#s"
        }
    }
    G.localization.descriptions.Tarot_dx.c_lovers_dx = {
        name = "The Lovers DX",
        text = {
            "Enhances up to {C:attention}#1#{} selected",
            "cards into a",
            "{C:attention}#2#"
        }
    }
    G.localization.descriptions.Tarot_dx.c_chariot_dx = {
        name = "The Chariot DX",
        text = {
            "Enhances up to {C:attention}#1#{} selected",
            "cards into a",
            "{C:attention}#2#"
        }
    }
    G.localization.descriptions.Tarot_dx.c_justice_dx = {
        name = "Justice DX",
        text = {
            "Enhances up to {C:attention}#1#{} selected",
            "cards into a",
            "{C:attention}#2#"
        }
    }
    G.localization.descriptions.Tarot_dx.c_hermit_dx = {
        name = "The Hermit DX",
        text = {
            "Triples money",
            "{C:inactive}(Max of {C:money}$#1#{C:inactive})"
        }
    }
    G.localization.descriptions.Tarot_dx.c_wheel_of_fortune_dx = {
        name = "The Wheel of Fortune DX",
        text = {
            "{C:green}#1# in #2#{} chance to add",
            "{C:dark_edition}Foil{}, {C:dark_edition}Holographic{}, or",
            "{C:dark_edition}Polychrome{} edition",
            "to a random {C:attention}Joker"
        }
    }
    G.localization.descriptions.Tarot_dx.c_strength_dx = {
        name = "Strength DX",
        text = {
            "Increases rank of",
            "up to {C:attention}#1#{} selected",
            "cards by {C:attention}1"
        }
    }
    G.localization.descriptions.Tarot_dx.c_hanged_man_dx = {
        name = "The Hanged Man DX",
        text = {
            "Destroys up to",
            "{C:attention}#1#{} selected cards"
        }
    }
    G.localization.descriptions.Tarot_dx.c_death_dx = {
        name = "Death DX",
        text = {
            "Select {C:attention}#1#{} cards,",
            "convert the {C:attention}left{} cards",
            "into the {C:attention}right{} card",
            "{C:inactive}(Drag to rearrange)"
        }
    }
    G.localization.descriptions.Tarot_dx.c_temperance_dx = {
        name = "Temperance DX",
        text = {
            "Gives double the total sell",
            "value of all current",
            "Jokers {C:inactive}(Max of {C:money}$#1#{C:inactive})",
            "{C:inactive}(Currently {C:money}$#2#{C:inactive})"
        }
    }
    G.localization.descriptions.Tarot_dx.c_devil_dx = {
        name = "The Devil DX",
        text = {
            "Enhances up to {C:attention}#1#{} selected",
            "cards into a",
            "{C:attention}#2#"
        }
    }
    G.localization.descriptions.Tarot_dx.c_tower_dx = {
        name = "The Tower DX",
        text = {
            "Enhances up to {C:attention}#1#{} selected",
            "cards into a",
            "{C:attention}#2#"
        }
    }
    G.localization.descriptions.Tarot_dx.c_star_dx = {
        name = "The Star DX",
        text = {
            "Converts up to",
            "{C:attention}#1#{} selected cards",
            "to {V:1}#2#{}"
        }
    }
    G.localization.descriptions.Tarot_dx.c_moon_dx = {
        name = "The Moon DX",
        text = {
            "Converts up to",
            "{C:attention}#1#{} selected cards",
            "to {V:1}#2#{}"
        }
    }
    G.localization.descriptions.Tarot_dx.c_sun_dx = {
        name = "The Sun DX",
        text = {
            "Converts up to",
            "{C:attention}#1#{} selected cards",
            "to {V:1}#2#{}"
        }
    }
    G.localization.descriptions.Tarot_dx.c_judgement_dx = {
        name = "Judgement DX",
        text = {
            "Creates a random",
            "{C:green}uncommon{} {C:attention}Joker{} card",
            "{C:inactive}(Must have room)"
        }
    }
    G.localization.descriptions.Tarot_dx.c_world_dx = {
        name = "The World DX",
        text = {
            "Converts up to",
            "{C:attention}#1#{} selected cards",
            "to {V:1}#2#{}"
        }
    }
end

local function setUpLocalizationPlanetDX()

    G.localization.descriptions.Planet_dx = {}

    G.localization.descriptions.Planet_dx.c_mercury_dx = {
        name = "Mercury DX",
        text = {
            "{S:0.8}({S:0.8,V:1}lvl.#1#{S:0.8}){} Level up {C:dark_edition}x2{}",
            "{C:attention}#2#",
            "{C:mult}+#3#{} Mult and",
            "{C:chips}+#4#{} chips"
        }
    }
    G.localization.descriptions.Planet_dx.c_venus_dx = {
        name = "Venus DX",
        text = {
            "{S:0.8}({S:0.8,V:1}lvl.#1#{S:0.8}){} Level up {C:dark_edition}x2{}",
            "{C:attention}#2#",
            "{C:mult}+#3#{} Mult and",
            "{C:chips}+#4#{} chips"
        }
    }
    G.localization.descriptions.Planet_dx.c_earth_dx = {
        name = "Earth DX",
        text = {
            "{S:0.8}({S:0.8,V:1}lvl.#1#{S:0.8}){} Level up {C:dark_edition}x2{}",
            "{C:attention}#2#",
            "{C:mult}+#3#{} Mult and",
            "{C:chips}+#4#{} chips"
        }
    }
    G.localization.descriptions.Planet_dx.c_mars_dx = {
        name = "Mars DX",
        text = {
            "{S:0.8}({S:0.8,V:1}lvl.#1#{S:0.8}){} Level up {C:dark_edition}x2{}",
            "{C:attention}#2#",
            "{C:mult}+#3#{} Mult and",
            "{C:chips}+#4#{} chips"
        }
    }
    G.localization.descriptions.Planet_dx.c_jupiter_dx = {
        name = "Jupiter DX",
        text = {
            "{S:0.8}({S:0.8,V:1}lvl.#1#{S:0.8}){} Level up {C:dark_edition}x2{}",
            "{C:attention}#2#",
            "{C:mult}+#3#{} Mult and",
            "{C:chips}+#4#{} chips"
        }
    }
    G.localization.descriptions.Planet_dx.c_saturn_dx = {
        name = "Saturn DX",
        text = {
            "{S:0.8}({S:0.8,V:1}lvl.#1#{S:0.8}){} Level up {C:attention}x2{}",
            "{C:attention}#2#",
            "{C:mult}+#3#{} Mult and",
            "{C:chips}+#4#{} chips"
        }
    }
    G.localization.descriptions.Planet_dx.c_uranus_dx = {
        name = "Uranus DX",
        text = {
            "{S:0.8}({S:0.8,V:1}lvl.#1#{S:0.8}){} Level up {C:dark_edition}x2{}",
            "{C:attention}#2#",
            "{C:mult}+#3#{} Mult and",
            "{C:chips}+#4#{} chips"
        }
    }
    G.localization.descriptions.Planet_dx.c_neptune_dx = {
        name = "Neptune DX",
        text = {
            "{S:0.8}({S:0.8,V:1}lvl.#1#{S:0.8}){} Level up {C:dark_edition}x2{}",
            "{C:attention}#2#",
            "{C:mult}+#3#{} Mult and",
            "{C:chips}+#4#{} chips"
        }
    }
    G.localization.descriptions.Planet_dx.c_pluto_dx = {
        name = "Pluto DX",
        text = {
            "{S:0.8}({S:0.8,V:1}lvl.#1#{S:0.8}){} Level up {C:dark_edition}x2{}",
            "{C:attention}#2#",
            "{C:mult}+#3#{} Mult and",
            "{C:chips}+#4#{} chips"
        }
    }
    G.localization.descriptions.Planet_dx.c_ceres_dx = {
        name = "Ceres DX",
        text = {
            "{S:0.8}({S:0.8,V:1}lvl.#1#{S:0.8}){} Level up {C:dark_edition}x2{}",
            "{C:attention}#2#",
            "{C:mult}+#3#{} Mult and",
            "{C:chips}+#4#{} chips"
        }
    }
    G.localization.descriptions.Planet_dx.c_planet_x_dx = {
        name = "Planet X DX",
        text = {
            "{S:0.8}({S:0.8,V:1}lvl.#1#{S:0.8}){} Level up {C:dark_edition}x2{}",
            "{C:attention}#2#",
            "{C:mult}+#3#{} Mult and",
            "{C:chips}+#4#{} chips"
        }
    }
    G.localization.descriptions.Planet_dx.c_eris_dx = {
        name = "Eris DX",
        text = {
            "{S:0.8}({S:0.8,V:1}lvl.#1#{S:0.8}){} Level up {C:dark_edition}x2{}",
            "{C:attention}#2#",
            "{C:mult}+#3#{} Mult and",
            "{C:chips}+#4#{} chips"
        }
    }
end

local function setUpLocalizationSpectralDX()

    G.localization.descriptions.Spectral_dx = {}
    
    G.localization.descriptions.Spectral_dx.c_familiar_dx = {
        name = "Familiar DX",
        text = {
            "Destroy {C:attention}2{} selected",
            "cards in your hand, add",
            "{C:attention}#1#{} random {C:attention}Enhanced face",
            "{C:attention}cards{} to your hand"
        }
    }
    G.localization.descriptions.Spectral_dx.c_grim_dx = {
        name = "Grim DX",
        text = {
            "Destroy {C:attention}2{} selected",
            "cards in your hand,",
            "add {C:attention}#1#{} random {C:attention}Enhanced",
            "{C:attention}Aces{} to your hand"
        }
    }
    G.localization.descriptions.Spectral_dx.c_incantation_dx = {
        name = "Incantation DX",
        text = {
            "Destroy {C:attention}2{} selected",
            "cards in your hand, add {C:attention}#1#",
            "random {C:attention}Enhanced numbered",
            "{C:attention}cards{} to your hand"
        }
    }
    G.localization.descriptions.Spectral_dx.c_talisman_dx = {
        name = "Talisman DX",
        text = {
            "Add a {C:attention}Gold Seal{}",
            "to up to {C:attention}3{} selected",
            "cards in your hand"
        }
    }
    G.localization.descriptions.Spectral_dx.c_aura_dx = {
        name = "Aura DX",
        text = {
            "Add {C:dark_edition}Foil{}, {C:dark_edition}Holographic{},",
            "or {C:dark_edition}Polychrome{} effect to up",
            "to {C:attention}3{} selected cards in hand"
        }
    }
    G.localization.descriptions.Spectral_dx.c_wraith_dx = {
        name = "Wraith DX",
        text = {
            "Creates a random",
            "{C:red}Rare{C:attention} Joker{},"
        }
    }
    G.localization.descriptions.Spectral_dx.c_sigil_dx = {
        name = "Sigil DX",
        text = {
            "Converts all cards",
            "in hand to a single",
            "selected {C:attention}suit"
        }
    }
    G.localization.descriptions.Spectral_dx.c_ouija_dx = {
        name = "Ouija DX",
        text = {
            "Converts all cards",
            "in hand to a single",
            "selected {C:attention}rank"
        }
    }
    G.localization.descriptions.Spectral_dx.c_ectoplasm_dx = {
        name = "Ectoplasm DX",
        text = {
            "Add {C:dark_edition}Negative{} to",
            "a random {C:attention}Joker,"
        }
    }
    G.localization.descriptions.Spectral_dx.c_immolate_dx = {
        name = "Immolate DX",
        text = {
            "Destroys {C:attention}#1#{} selected",
            "cards in hand,",
            "gain {C:money}$#2#"
        }
    }
    G.localization.descriptions.Spectral_dx.c_ankh_dx = {
        name = "Ankh DX",
        text = {
            "Create a copy of a",
            "random {C:attention}Joker{}"
        }
    }
    G.localization.descriptions.Spectral_dx.c_deja_vu_dx = {
        name = "Deja Vu DX",
        text = {
            "Add a {C:red}Red Seal{}",
            "to up to {C:attention}3{} selected",
            "cards in your hand"
        }
    }
    G.localization.descriptions.Spectral_dx.c_hex_dx = {
        name = "Hex DX",
        text = {
            "Add {C:dark_edition}Polychrome{} to a",
            "random {C:attention}Joker{}"
        }
    }
    G.localization.descriptions.Spectral_dx.c_trance_dx = {
        name = "Trance DX",
        text = {
            "Add a {C:blue}Blue Seal{}",
            "to up to {C:attention}3{} selected",
            "cards in your hand"
        }
    }
    G.localization.descriptions.Spectral_dx.c_medium_dx = {
        name = "Medium DX",
        text = {
            "Add a {C:purple}Purple Seal{}",
            "to up to {C:attention}2{} selected",
            "cards in your hand"
        }
    }
    G.localization.descriptions.Spectral_dx.c_cryptid_dx = {
        name = "Cryptid DX",
        text = {
            "Create {C:attention}#1#{} copies of",
            "{C:attention}1{} selected card",
            "in your hand"
        }
    }
    G.localization.descriptions.Spectral_dx.c_soul_dx = {
        name = "The Soul DX",
        text = {
            "Creates a",
            "{C:legendary,E:1}Legendary{} Joker",
            "{C:inactive}(Don't need room...?)"
        }
    }
    G.localization.descriptions.Spectral_dx.c_black_hole_dx = {
        name = "Black Hole DX",
        text = {
            "Upgrade every",
            "{C:legendary,E:1}poker hand",
            "by {C:attention}3{} levels"
        }
    }
end

function SMODS.INIT.JeffDeluxeConsumablesPack()
    sendDebugMessage("Deluxe Consumables Cards Loaded")

    -- DX Sprites

    local js_mod = SMODS.findModByID("JeffDeluxeConsumablesPack")
    local sprite_dx = SMODS.Sprite:new("Tarot_dx", js_mod.path, "Tarots_dx.png", 71, 95, "asset_atli")
    sprite_dx:register()
    sprite_dx = SMODS.Sprite:new("Planet_dx", js_mod.path, "Tarots_dx.png", 71, 95, "asset_atli")
    sprite_dx:register()
    sprite_dx = SMODS.Sprite:new("Spectral_dx", js_mod.path, "Tarots_dx.png", 71, 95, "asset_atli")
    sprite_dx:register()

    -- Add consumables
    setUpConsumables()

    -- Localizations
    setUpLocalizationTarotDX()
    setUpLocalizationPlanetDX()
    setUpLocalizationSpectralDX()
    G.localization.descriptions.Other.dx = {
        name = "Deluxe Version",
        text = {
            "Enhanced effect",
        }
    }
    G.localization.misc.labels['tarot_dx'] = "Tarot DX"
    G.localization.misc.labels['planet_dx'] = "Planet DX"
    G.localization.misc.labels['spectral_dx'] = "Spectral DX"
    G.localization.misc.labels['dx'] = "DX Version"
    G.localization.misc.dictionary['k_tarot_dx'] = "Tarot DX"
    G.localization.misc.dictionary['k_planet_dx'] = "Planet DX"
    G.localization.misc.dictionary['k_spectral_dx'] = "Spectral DX"

    -- Manage loc_colour
    loc_colour('red', nil)
    G.ARGS.LOC_COLOURS['tarot_dx'] = G.C.SECONDARY_SET.Tarot
    G.ARGS.LOC_COLOURS['planet_dx'] = G.C.SECONDARY_SET.Planet
    G.ARGS.LOC_COLOURS['spectral_dx'] = G.C.SECONDARY_SET.Spectral

    -- Manage get_badge_colour
    get_badge_colour(foil)
    G.BADGE_COL['dx'] = G.C.DARK_EDITION

    -- Manage C colors
    G.C.SET['Tarot_dx'] = HEX('424e54')
    G.C.SET['Planet_dx'] = HEX('424e54')
    G.C.SET['Spectral_dx'] = HEX('424e54')
    G.C.SECONDARY_SET['Tarot_dx'] = HEX('a782d1')
    G.C.SECONDARY_SET['Planet_dx'] = HEX('13afce')
    G.C.SECONDARY_SET['Spectral_dx'] = HEX('4584fa')

end

---------- common_events ----------

-- Manage pool if DX pool
local get_current_pool_ref  = get_current_pool
function get_current_pool(_type, _rarity, _legendary, _append)

    if _type == 'Tarot_dx' or _type == 'Planet_dx' or _type == 'Spectral_dx' then
        --create the pool for DX
        G.ARGS.TEMP_POOL = EMPTY(G.ARGS.TEMP_POOL)
        local _pool, _starting_pool, _pool_key, _pool_size = G.ARGS.TEMP_POOL, nil, '', 0
    
        _starting_pool, _pool_key = G.P_CENTER_POOLS[_type], _type..(_append or '')
    
        --cull the pool
        for k, v in ipairs(_starting_pool) do
            local add = nil
            if not (G.GAME.used_jokers[v.key] and not next(find_joker("Showman"))) and
                (v.unlocked ~= false or v.rarity == 4) then
                if v.set == 'Planet_dx' then
                    -- Check if hand is unlocked
                    if (not v.config.softlock or G.GAME.hands[v.config.hand_type].played > 0) then
                        add = true
                    end
                else
                    add = true
                end
                if v.name == 'Black Hole DX' or v.name == 'The Soul DX' then
                    add = false
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
    
        --if pool is empty
        if _pool_size == 0 then
            _pool = EMPTY(G.ARGS.TEMP_POOL)
            if _type == 'Tarot_dx' then _pool[#_pool + 1] = "c_fool_dx"
            elseif _type == 'Planet_dx' then _pool[#_pool + 1] = "c_mercury_dx"
            elseif _type == 'Spectral_dx' then _pool[#_pool + 1] = "c_incantation_dx"
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

-- Set a chance to change pool from normal to DX
local create_card_ref = create_card
function create_card(_type, area, legendary, _rarity, skip_materialize, soulable, forced_key, key_append)

    local new_type = _type
    local new_forced_key = forced_key

    if not forced_key then
        -- Change type pseudorandom
        if _type == 'Tarot' and (pseudorandom('upgrade_card'..G.GAME.round_resets.ante) > math.min(1, math.max(0, 1 - tarot_dx_rate))) then new_type = "Tarot_dx" end
        if _type == 'Planet' and (pseudorandom('upgrade_card'..G.GAME.round_resets.ante) > math.min(1, math.max(0, 1 - planet_dx_rate))) then new_type = "Planet_dx" end
        if _type == 'Spectral' and (pseudorandom('upgrade_card'..G.GAME.round_resets.ante) > math.min(1, math.max(0, 1 - spectral_dx_rate))) then new_type = "Spectral_dx" end
        
        -- If type is set to DX, need to manage soulable option
        if soulable and (not G.GAME.banned_keys['c_soul']) then
            if (_type == 'Tarot_dx' or _type == 'Spectral_dx') and
            not (G.GAME.used_jokers['c_soul_dx'] and not next(find_joker("Showman")))  then
                if pseudorandom('soul_'.._type..G.GAME.round_resets.ante) > 0.997 then
                    new_forced_key = 'c_soul_dx'
                end
            end
            if (_type == 'Planet_dx' or _type == 'Spectral_dx') and
            not (G.GAME.used_jokers['c_black_hole_dx'] and not next(find_joker("Showman")))  then 
                if pseudorandom('soul_'.._type..G.GAME.round_resets.ante) > 0.997 then
                    new_forced_key = 'c_black_hole_dx'
                end
            end
        end
    end

    local created_card = create_card_ref(new_type, area, legendary, _rarity, skip_materialize, soulable, new_forced_key, key_append)

    -- poll planet edition if it is enabled
    if planet_edition_enabled then
        if (_type == 'Planet' or _type == 'Planet_up') and created_card.ability.consumeable.hand_type then
            local mod = math.max(1, 1 + (0.15 * math.min(7, G.GAME.hands[created_card.ability.consumeable.hand_type].level))) or 1
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

    if planet_edition_enabled then  -- Overwrite
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
            
            if card and card.ability and card.ability.set and card.ability.set == "Planet_dx" then
                G.GAME.hands[hand].level = math.max(0, G.GAME.hands[hand].level + amount)
                G.GAME.hands[hand].mult = math.max(G.GAME.hands[hand].mult + G.GAME.hands[hand].l_mult*(amount), 1)
                G.GAME.hands[hand].chips = math.max(G.GAME.hands[hand].chips + G.GAME.hands[hand].l_chips*(amount), 0)
                G.E_MANAGER:add_event(Event({trigger = 'after', delay = 1.3, func = function()
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
            end
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

-- Manage card UI if DX
local generate_card_ui_ref = generate_card_ui
function generate_card_ui(_c, full_UI_table, specific_vars, card_type, badges, hide_desc, main_start, main_end)

    if _c.set == 'Tarot_dx' or _c.set == 'Planet_dx' or _c.set == 'Spectral_dx' then    -- Overwrite

        -- Add the DX badge
        badges[#badges + 1] = 'dx'

        -- Just copy-paste for now... TODO
        local first_pass = nil
        if not full_UI_table then 
            first_pass = true
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
                full_UI_table.name = localize{type = 'name', set = _c.set, key = _c.key, nodes = full_UI_table.name}
            end
            full_UI_table.card_type = card_type or _c.set
        end 

        local loc_vars = {}
        if main_start then 
            desc_nodes[#desc_nodes+1] = main_start 
        end

        if _c.set == 'Spectral_dx' then 
            if _c.name == 'Familiar DX' or _c.name == 'Grim DX' or _c.name == 'Incantation DX' then loc_vars = {_c.config.extra}
            elseif _c.name == 'Immolate DX' then loc_vars = {_c.config.extra.destroy, _c.config.extra.dollars}
            elseif _c.name == 'Hex DX' then info_queue[#info_queue+1] = G.P_CENTERS.e_polychrome
            elseif _c.name == 'Talisman DX' then info_queue[#info_queue+1] = {key = 'gold_seal', set = 'Other'}
            elseif _c.name == 'Deja Vu DX' then info_queue[#info_queue+1] = {key = 'red_seal', set = 'Other'}
            elseif _c.name == 'Trance DX' then info_queue[#info_queue+1] = {key = 'blue_seal', set = 'Other'}
            elseif _c.name == 'Medium DX' then info_queue[#info_queue+1] = {key = 'purple_seal', set = 'Other'}
            elseif _c.name == 'Ankh DX' then
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
            elseif _c.name == 'Cryptid DX' then loc_vars = {_c.config.extra}
            end
            if _c.name == 'Ectoplasm DX' then info_queue[#info_queue+1] = G.P_CENTERS.e_negative end
            if _c.name == 'Aura DX' then
                info_queue[#info_queue+1] = G.P_CENTERS.e_foil
                info_queue[#info_queue+1] = G.P_CENTERS.e_holo
                info_queue[#info_queue+1] = G.P_CENTERS.e_polychrome
            end
            localize{type = 'descriptions', key = _c.key, set = _c.set, nodes = desc_nodes, vars = loc_vars}
        elseif _c.set == 'Planet_dx' then
            loc_vars = {
                G.GAME.hands[_c.config.hand_type].level,localize(_c.config.hand_type, 'poker_hands'), G.GAME.hands[_c.config.hand_type].l_mult * 2, G.GAME.hands[_c.config.hand_type].l_chips * 2,
                colours = {(G.GAME.hands[_c.config.hand_type].level==1 and G.C.UI.TEXT_DARK or G.C.HAND_LEVELS[math.min(7, G.GAME.hands[_c.config.hand_type].level)])}
            }
            localize{type = 'descriptions', key = _c.key, set = _c.set, nodes = desc_nodes, vars = loc_vars}
        elseif _c.set == 'Tarot_dx' then
            if _c.name == "The Fool DX" then
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
                loc_vars = {last_tarot_planet}
                if not (not fool_c or fool_c.name == 'The Fool') then
                     info_queue[#info_queue+1] = fool_c
                end
            elseif _c.name == "The Magician DX" then loc_vars = {_c.config.max_highlighted, localize{type = 'name_text', set = 'Enhanced', key = _c.config.mod_conv}}; info_queue[#info_queue+1] = G.P_CENTERS[_c.config.mod_conv]
            elseif _c.name == "The High Priestess DX" then loc_vars = {_c.config.planets}
            elseif _c.name == "The Empress DX" then loc_vars = {_c.config.max_highlighted, localize{type = 'name_text', set = 'Enhanced', key = _c.config.mod_conv}}; info_queue[#info_queue+1] = G.P_CENTERS[_c.config.mod_conv]
            elseif _c.name == "The Emperor DX" then loc_vars = {_c.config.tarots}
            elseif _c.name == "The Hierophant DX" then loc_vars = {_c.config.max_highlighted, localize{type = 'name_text', set = 'Enhanced', key = _c.config.mod_conv}}; info_queue[#info_queue+1] = G.P_CENTERS[_c.config.mod_conv]
            elseif _c.name == "The Lovers DX" then loc_vars = {_c.config.max_highlighted, localize{type = 'name_text', set = 'Enhanced', key = _c.config.mod_conv}}; info_queue[#info_queue+1] = G.P_CENTERS[_c.config.mod_conv]
            elseif _c.name == "The Chariot DX" then loc_vars = {_c.config.max_highlighted, localize{type = 'name_text', set = 'Enhanced', key = _c.config.mod_conv}}; info_queue[#info_queue+1] = G.P_CENTERS[_c.config.mod_conv]
            elseif _c.name == "Justice DX" then loc_vars = {_c.config.max_highlighted, localize{type = 'name_text', set = 'Enhanced', key = _c.config.mod_conv}}; info_queue[#info_queue+1] = G.P_CENTERS[_c.config.mod_conv]
            elseif _c.name == "The Hermit DX" then loc_vars = {_c.config.extra}
            elseif _c.name == "The Wheel of Fortune DX" then loc_vars = {G.GAME.probabilities.normal, _c.config.extra};  info_queue[#info_queue+1] = G.P_CENTERS.e_foil; info_queue[#info_queue+1] = G.P_CENTERS.e_holo; info_queue[#info_queue+1] = G.P_CENTERS.e_polychrome; 
            elseif _c.name == "Strength DX" then loc_vars = {_c.config.max_highlighted}
            elseif _c.name == "The Hanged Man DX" then loc_vars = {_c.config.max_highlighted}
            elseif _c.name == "Death DX" then loc_vars = {_c.config.max_highlighted}
            elseif _c.name == "Temperance DX" then
             local _money = 0
             if G.jokers then
                 for i = 1, #G.jokers.cards do
                     if G.jokers.cards[i].ability.set == 'Joker' then
                         _money = _money + G.jokers.cards[i].sell_cost * 2
                     end
                 end
             end
             loc_vars = {_c.config.extra, math.min(_c.config.extra, _money)}
            elseif _c.name == "The Devil DX" then loc_vars = {_c.config.max_highlighted, localize{type = 'name_text', set = 'Enhanced', key = _c.config.mod_conv}}; info_queue[#info_queue+1] = G.P_CENTERS[_c.config.mod_conv]
            elseif _c.name == "The Tower DX" then loc_vars = {_c.config.max_highlighted, localize{type = 'name_text', set = 'Enhanced', key = _c.config.mod_conv}}; info_queue[#info_queue+1] = G.P_CENTERS[_c.config.mod_conv]
            elseif _c.name == "The Star DX" then loc_vars = {_c.config.max_highlighted,  localize(_c.config.suit_conv, 'suits_plural'), colours = {G.C.SUITS[_c.config.suit_conv]}}
            elseif _c.name == "The Moon DX" then loc_vars = {_c.config.max_highlighted, localize(_c.config.suit_conv, 'suits_plural'), colours = {G.C.SUITS[_c.config.suit_conv]}}
            elseif _c.name == "The Sun DX" then loc_vars = {_c.config.max_highlighted, localize(_c.config.suit_conv, 'suits_plural'), colours = {G.C.SUITS[_c.config.suit_conv]}}
            elseif _c.name == "Judgement DX" then
            elseif _c.name == "The World DX" then loc_vars = {_c.config.max_highlighted, localize(_c.config.suit_conv, 'suits_plural'), colours = {G.C.SUITS[_c.config.suit_conv]}}
            end
            localize{type = 'descriptions', key = _c.key, set = _c.set, nodes = desc_nodes, vars = loc_vars}
        end

        if main_end then 
            desc_nodes[#desc_nodes+1] = main_end 
        end

        --Fill all remaining info if this is the main desc
        if not ((specific_vars and not specific_vars.sticker) and (card_type == 'Default' or card_type == 'Enhanced')) then
            if desc_nodes == full_UI_table.main and not full_UI_table.name then
                localize{type = 'name', key = _c.key, set = _c.set, nodes = full_UI_table.name} 
                if not full_UI_table.name then full_UI_table.name = {} end
            elseif desc_nodes ~= full_UI_table.main then 
                desc_nodes.name = localize{type = 'name_text', key = name_override or _c.key, set = name_override and 'Other' or _c.set} 
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
                if v == 'dx' then info_queue[#info_queue+1] = {key = 'dx', set = 'Other'} end
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

---------- misc_functions ----------

-- Manage consumable usage
local set_consumeable_usage_ref = set_consumeable_usage
function set_consumeable_usage(card)

    set_consumeable_usage_ref(card)

    if card.config.center_key and card.ability.consumeable and (card.config.center.set == 'Tarot_dx' or card.config.center.set == 'Planet_dx' or card.config.center.set == 'Spectral_dx') then
        if card.config.center.set == 'Tarot_dx' then
            G.GAME.consumeable_usage_total.tarot = G.GAME.consumeable_usage_total.tarot + 1  
            G.GAME.consumeable_usage_total.tarot_planet = G.GAME.consumeable_usage_total.tarot_planet + 1
        elseif card.config.center.set == 'Planet_dx' then
            G.GAME.consumeable_usage_total.planet = G.GAME.consumeable_usage_total.planet + 1
            G.GAME.consumeable_usage_total.tarot_planet = G.GAME.consumeable_usage_total.tarot_planet + 1
        elseif card.config.center.set == 'Spectral_dx' then
            G.GAME.consumeable_usage_total.spectral = G.GAME.consumeable_usage_total.spectral + 1
        end
    end


end

---------- UI_definitions ----------

-- Manage DX planets badge
local G_UIDEF_card_h_popup_ref = G.UIDEF.card_h_popup
function G.UIDEF.card_h_popup(card)

    if card.ability_UIBox_table and card.ability and (card.ability.name == 'Pluto DX' or card.ability.name == 'Ceres DX' or card.ability.name == 'Eris DX' or card.ability.name == 'Planet X DX') then
        local AUT = card.ability_UIBox_table
        local debuffed = card.debuff
        local card_type_colour = get_type_colour(card.config.center or card.config, card)
        local card_type_background = 
            (AUT.card_type == 'Locked' and G.C.BLACK) or 
            ((AUT.card_type == 'Undiscovered') and darken(G.C.JOKER_GREY, 0.3)) or 
            (AUT.card_type == 'Enhanced' or AUT.card_type == 'Default') and darken(G.C.BLACK, 0.1) or
            (debuffed and darken(G.C.BLACK, 0.1)) or 
            (card_type_colour and darken(G.C.BLACK, 0.1)) or
            G.C.SET[AUT.card_type] or
            {0, 1, 1, 1}

        local outer_padding = 0.05
        local card_type = localize('k_'..string.lower(AUT.card_type))
        local disp_type, is_playing_card = 
        (AUT.card_type ~= 'Locked' and AUT.card_type ~= 'Undiscovered' and AUT.card_type ~= 'Default') or debuffed,
        AUT.card_type == 'Enhanced' or AUT.card_type == 'Default'
        local info_boxes = {}
        local badges = {}

        if AUT.badges.card_type or AUT.badges.force_rarity then
            badges[#badges + 1] = create_badge(((card.ability.name == 'Pluto DX' or card.ability.name == 'Ceres DX' or card.ability.name == 'Eris DX') and localize('k_dwarf_planet')) or (card.ability.name == 'Planet X DX' and localize('k_planet_q') or card_type),card_type_colour, nil, 1.2)
        end
        if AUT.badges then
            for k, v in ipairs(AUT.badges) do
            if v == 'negative_consumable' then v = 'negative' end
            badges[#badges + 1] = create_badge(localize(v, "labels"), get_badge_colour(v))
            end
        end
        if AUT.info then
            for k, v in ipairs(AUT.info) do
              info_boxes[#info_boxes+1] =
              {n=G.UIT.R, config={align = "cm"}, nodes={
              {n=G.UIT.R, config={align = "cm", colour = lighten(G.C.JOKER_GREY, 0.5), r = 0.1, padding = 0.05, emboss = 0.05}, nodes={
                info_tip_from_rows(v, v.name),
              }}
            }}
            end
          end
        return {n=G.UIT.ROOT, config = {align = 'cm', colour = G.C.CLEAR}, nodes={
            {n=G.UIT.C, config={align = "cm", func = 'show_infotip',object = Moveable(),ref_table = next(info_boxes) and info_boxes or nil}, nodes={
                {n=G.UIT.R, config={padding = outer_padding, r = 0.12, colour = lighten(G.C.JOKER_GREY, 0.5), emboss = 0.07}, nodes={
                {n=G.UIT.R, config={align = "cm", padding = 0.07, r = 0.1, colour = adjust_alpha(card_type_background, 0.8)}, nodes={
                    name_from_rows(AUT.name, is_playing_card and G.C.WHITE or nil),
                    desc_from_rows(AUT.main),
                    badges[1] and {n=G.UIT.R, config={align = "cm", padding = 0.03}, nodes=badges} or nil,
                }}
                }}
            }},
            }}
    else
        return G_UIDEF_card_h_popup_ref(card)
    end
end

---------- Card ----------

-- Manage Astronomer joker
local card_set_cost_ref = Card.set_cost
function Card.set_cost(self)

    card_set_cost_ref(self)
    if (self.ability.set == 'Planet_dx') and #find_joker('Astronomer') > 0 then self.cost = 0 end
end

-- Manage usage of DX consumables
local card_use_consumeable_ref = Card.use_consumeable
function Card.use_consumeable(self, area, copier)

    if self.ability.set == 'Tarot_dx' or self.ability.set == 'Planet_dx' or self.ability.set == 'Spectral_dx' then  -- Manage DX
        stop_use()
        if not copier then set_consumeable_usage(self) end
        if self.debuff then return nil end
        local used_tarot = copier or self
    
        if self.ability.consumeable.max_highlighted then
            update_hand_text({immediate = true, nopulse = true, delay = 0}, {mult = 0, chips = 0, level = '', handname = ''})
        end
    
        if self.ability.consumeable.mod_conv or self.ability.consumeable.suit_conv then
            G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
                play_sound('tarot1')
                used_tarot:juice_up(0.3, 0.5)
                return true end }))
            for i=1, #G.hand.highlighted do
                local percent = 1.15 - (i-0.999)/(#G.hand.highlighted-0.998)*0.3
                G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() G.hand.highlighted[i]:flip();play_sound('card1', percent);G.hand.highlighted[i]:juice_up(0.3, 0.3);return true end }))
            end
            delay(0.2)
            if self.ability.name == 'Death DX' then
                local rightmost = G.hand.highlighted[1]
                for i=1, #G.hand.highlighted do if G.hand.highlighted[i].T.x > rightmost.T.x then rightmost = G.hand.highlighted[i] end end
                for i=1, #G.hand.highlighted do
                    G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.1,func = function()
                        if G.hand.highlighted[i] ~= rightmost then
                            copy_card(rightmost, G.hand.highlighted[i])
                        end
                        return true end }))
                end  
            elseif self.ability.name == 'Strength DX' then
                for i=1, #G.hand.highlighted do
                    G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.1,func = function()
                        local card = G.hand.highlighted[i]
                        local suit_prefix = string.sub(card.base.suit, 1, 1)..'_'
                        local rank_suffix = card.base.id == 14 and 2 or math.min(card.base.id+1, 14)
                        if rank_suffix < 10 then rank_suffix = tostring(rank_suffix)
                        elseif rank_suffix == 10 then rank_suffix = 'T'
                        elseif rank_suffix == 11 then rank_suffix = 'J'
                        elseif rank_suffix == 12 then rank_suffix = 'Q'
                        elseif rank_suffix == 13 then rank_suffix = 'K'
                        elseif rank_suffix == 14 then rank_suffix = 'A'
                        end
                        card:set_base(G.P_CARDS[suit_prefix..rank_suffix])
                    return true end }))
                end  
            elseif self.ability.consumeable.suit_conv then
                for i=1, #G.hand.highlighted do
                    G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.1,func = function() G.hand.highlighted[i]:change_suit(self.ability.consumeable.suit_conv);return true end }))
                end    
            else
                for i=1, #G.hand.highlighted do
                    G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.1,func = function() G.hand.highlighted[i]:set_ability(G.P_CENTERS[self.ability.consumeable.mod_conv]);return true end }))
                end 
            end
            for i=1, #G.hand.highlighted do
                local percent = 0.85 + (i-0.999)/(#G.hand.highlighted-0.998)*0.3
                G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() G.hand.highlighted[i]:flip();play_sound('tarot2', percent, 0.6);G.hand.highlighted[i]:juice_up(0.3, 0.3);return true end }))
            end
            G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.2,func = function() G.hand:unhighlight_all(); return true end }))
            delay(0.5)
        end
        if self.ability.name == 'Black Hole DX' then
            update_hand_text({sound = 'button', volume = 0.7, pitch = 0.8, delay = 0.3}, {handname=localize('k_all_hands'),chips = '...', mult = '...', level=''})
            G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.2, func = function()
                play_sound('tarot1')
                self:juice_up(0.8, 0.5)
                G.TAROT_INTERRUPT_PULSE = true
                return true end }))
            update_hand_text({delay = 0}, {mult = '+', StatusText = true})
            G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.9, func = function()
                play_sound('tarot1')
                self:juice_up(0.8, 0.5)
                return true end }))
            update_hand_text({delay = 0}, {chips = '+', StatusText = true})
            G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.9, func = function()
                play_sound('tarot1')
                self:juice_up(0.8, 0.5)
                G.TAROT_INTERRUPT_PULSE = nil
                return true end }))
            update_hand_text({sound = 'button', volume = 0.7, pitch = 0.9, delay = 0}, {level='+3'})
            if planet_edition_enabled and self.edition then
                if self.edition.holo then
                    G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.9, func = function()
                        play_sound('holo1')
                        self:juice_up(0.8, 0.5)
                        return true end }))
                        update_hand_text({delay = 0}, {mult = '+' .. tostring(G.P_CENTERS.e_holo.config.extra), StatusText = true})
                end
                if self.edition.foil then
                    G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.9, func = function()
                        play_sound('foil1')
                        self:juice_up(0.8, 0.5)
                        return true end }))
                        update_hand_text({delay = 0}, {mult = '+' .. tostring(G.P_CENTERS.e_foil.config.extra), StatusText = true})
                end
                if self.edition.polychrome then
                    G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.9, func = function()
                        play_sound('polychrome1')
                        self:juice_up(0.8, 0.5)
                        return true end }))
                        update_hand_text({delay = 0}, {mult = 'x' .. tostring(G.P_CENTERS.e_polychrome.config.extra), StatusText = true})
                end
            end
            delay(1.3)
            for k, v in pairs(G.GAME.hands) do
                level_up_hand(self, k, true, 3)
            end
            update_hand_text({sound = 'button', volume = 0.7, pitch = 1.1, delay = 0}, {mult = 0, chips = 0, handname = '', level = ''})
        end
        if self.ability.name == 'Talisman DX' or self.ability.name == 'Deja Vu DX' or self.ability.name == 'Trance DX' or self.ability.name == 'Medium DX' then
            for i=#G.hand.highlighted, 1, -1 do
                local conv_card = G.hand.highlighted[i]
                G.E_MANAGER:add_event(Event({func = function()
                    play_sound('tarot1')
                    used_tarot:juice_up(0.3, 0.5)
                    return true end }))
                
                G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.1,func = function()
                    conv_card:set_seal(self.ability.extra, nil, true)
                    return true end }))
            end
            delay(0.5)
            G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.2,func = function() G.hand:unhighlight_all(); return true end }))
        end
        if self.ability.name == 'Aura DX' then 
            used_tarot:juice_up(0.3, 0.5)
            for i=1, #G.hand.highlighted do
                G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
                    local over = false
                    local edition = poll_edition('aura', nil, true, true)
                    local aura_card = G.hand.highlighted[i]
                    aura_card:set_edition(edition, true)
                return true end }))
            end
        end
        if self.ability.name == 'Cryptid DX' then
            G.E_MANAGER:add_event(Event({
                func = function()
                    local _first_dissolve = nil
                    local new_cards = {}
                    for i = 1, self.ability.extra do
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
        end
        if self.ability.name == 'Sigil DX' or self.ability.name == 'Ouija DX' then
            G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
                play_sound('tarot1')
                used_tarot:juice_up(0.3, 0.5)
                return true end }))
            for i=1, #G.hand.cards do
                local percent = 1.15 - (i-0.999)/(#G.hand.cards-0.998)*0.3
                G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() G.hand.cards[i]:flip();play_sound('card1', percent);G.hand.cards[i]:juice_up(0.3, 0.3);return true end }))
            end
            delay(0.2)
            if self.ability.name == 'Sigil DX' then
                local _suit = string.sub(G.hand.highlighted[1].base.suit, 1, 1)
                for i=1, #G.hand.cards do
                    G.E_MANAGER:add_event(Event({func = function()
                        local card = G.hand.cards[i]
                        local suit_prefix = _suit..'_'
                        local rank_suffix = card.base.id < 10 and tostring(card.base.id) or
                                            card.base.id == 10 and 'T' or card.base.id == 11 and 'J' or
                                            card.base.id == 12 and 'Q' or card.base.id == 13 and 'K' or
                                            card.base.id == 14 and 'A'
                        card:set_base(G.P_CARDS[suit_prefix..rank_suffix])
                    return true end }))
                end  
            end
            if self.ability.name == 'Ouija DX' then
                local _rank = G.hand.highlighted[1].base.id < 10 and tostring(G.hand.highlighted[1].base.id) or
                              G.hand.highlighted[1].base.id == 10 and 'T' or G.hand.highlighted[1].base.id == 11 and 'J' or
                              G.hand.highlighted[1].base.id == 12 and 'Q' or G.hand.highlighted[1].base.id == 13 and 'K' or
                              G.hand.highlighted[1].base.id == 14 and 'A'
                for i=1, #G.hand.cards do
                    G.E_MANAGER:add_event(Event({func = function()
                        local card = G.hand.cards[i]
                        local suit_prefix = string.sub(card.base.suit, 1, 1)..'_'
                        local rank_suffix =_rank
                        card:set_base(G.P_CARDS[suit_prefix..rank_suffix])
                    return true end }))
                end
            end
            for i=1, #G.hand.cards do
                local percent = 0.85 + (i-0.999)/(#G.hand.cards-0.998)*0.3
                G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() G.hand.cards[i]:flip();play_sound('tarot2', percent, 0.6);G.hand.cards[i]:juice_up(0.3, 0.3);return true end }))
            end
            delay(0.5)
        end
        if self.ability.consumeable.hand_type then
            update_hand_text({sound = 'button', volume = 0.7, pitch = 0.8, delay = 0.3}, {handname=localize(self.ability.consumeable.hand_type, 'poker_hands'),chips = G.GAME.hands[self.ability.consumeable.hand_type].chips, mult = G.GAME.hands[self.ability.consumeable.hand_type].mult, level=G.GAME.hands[self.ability.consumeable.hand_type].level})
            level_up_hand(used_tarot, self.ability.consumeable.hand_type)
            update_hand_text({sound = 'button', volume = 0.7, pitch = 1.1, delay = 0}, {mult = 0, chips = 0, handname = '', level = ''})
        end
        if self.ability.consumeable.remove_card then
            local destroyed_cards = {}
            if self.ability.name == 'The Hanged Man DX' then
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
                        return true end }))
            elseif self.ability.name == 'Familiar DX' or self.ability.name == 'Grim DX' or self.ability.name == 'Incantation DX' then
                for i=#G.hand.highlighted, 1, -1 do
                    destroyed_cards[#destroyed_cards+1] = G.hand.highlighted[i]
                end
                G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
                    play_sound('tarot1')
                    used_tarot:juice_up(0.3, 0.5)
                    return true end }))
                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    delay = 0.1,
                    func = function() 
                        for i=#destroyed_cards, 1, -1 do
                            local card = destroyed_cards[i]
                            if card.ability.name == 'Glass Card' then 
                                card:shatter()
                            else
                                card:start_dissolve(nil, i ~= #destroyed_cards)
                            end
                        end
                        return true end }))
                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    delay = 0.7,
                    func = function() 
                        local cards = {}
                        for i=1, self.ability.extra do
                            cards[i] = true
                            local _suit, _rank = nil, nil
                            if self.ability.name == 'Familiar DX' then
                                _rank = pseudorandom_element({'J', 'Q', 'K'}, pseudoseed('familiar_create'))
                                _suit = pseudorandom_element({'S','H','D','C'}, pseudoseed('familiar_create'))
                            elseif self.ability.name == 'Grim DX' then
                                _rank = 'A'
                                _suit = pseudorandom_element({'S','H','D','C'}, pseudoseed('grim_create'))
                            elseif self.ability.name == 'Incantation DX' then
                                _rank = pseudorandom_element({'2', '3', '4', '5', '6', '7', '8', '9', 'T'}, pseudoseed('incantation_create'))
                                _suit = pseudorandom_element({'S','H','D','C'}, pseudoseed('incantation_create'))
                            end
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
            elseif self.ability.name == 'Immolate DX' then
                for i=#G.hand.highlighted, 1, -1 do
                    destroyed_cards[#destroyed_cards+1] = G.hand.highlighted[i]
                end
    
                G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
                    play_sound('tarot1')
                    used_tarot:juice_up(0.3, 0.5)
                    return true end }))
                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    delay = 0.1,
                    func = function() 
                        for i=#destroyed_cards, 1, -1 do
                            local card = destroyed_cards[i]
                            if card.ability.name == 'Glass Card' then 
                                card:shatter()
                            else
                                card:start_dissolve(nil, i == #destroyed_cards)
                            end
                        end
                        return true end }))
                delay(0.5)
                ease_dollars(self.ability.extra.dollars)
            end
            delay(0.3)
            for i = 1, #G.jokers.cards do
                G.jokers.cards[i]:calculate_joker({remove_playing_cards = true, removed = destroyed_cards})
            end
        end
        if self.ability.name == 'The Fool DX' then
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
        end
        if self.ability.name == 'The Hermit DX' then
            G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
                play_sound('timpani')
                used_tarot:juice_up(0.3, 0.5)
                ease_dollars(math.max(0,math.min(G.GAME.dollars * 2, self.ability.extra)), true)
                return true end }))
            delay(0.6)
        end
        if self.ability.name == 'Temperance DX' then
            G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
                play_sound('timpani')
                used_tarot:juice_up(0.3, 0.5)
                ease_dollars(self.ability.money, true)
                return true end }))
            delay(0.6)
        end
        if self.ability.name == 'The Emperor DX' or self.ability.name == 'The High Priestess DX' then
            for i = 1, math.min((self.ability.consumeable.tarots or self.ability.consumeable.planets), G.consumeables.config.card_limit - #G.consumeables.cards) do
                G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
                    if G.consumeables.config.card_limit > #G.consumeables.cards then
                        play_sound('timpani')
                        local card = create_card((self.ability.name == 'The Emperor DX' and 'Tarot_dx') or (self.ability.name == 'The High Priestess DX' and 'Planet_dx'), G.consumeables, nil, nil, nil, nil, nil, (self.ability.name == 'The Emperor DX' and 'emp') or (self.ability.name == 'The High Priestess DX' and 'pri'))
                        card:add_to_deck()
                        G.consumeables:emplace(card)
                        used_tarot:juice_up(0.3, 0.5)
                    end
                    return true end }))
            end
            delay(0.6)
        end
        if self.ability.name == 'Judgement DX' then
            G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
                play_sound('timpani')
                local rarity = 0.8
                local card = create_card('Joker', G.jokers, false, rarity, nil, nil, nil, 'jud')
                card:add_to_deck()
                G.jokers:emplace(card)
                used_tarot:juice_up(0.3, 0.5)
                return true end }))
            delay(0.6)
        end
        if self.ability.name == 'The Soul DX' then
            G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
                play_sound('timpani')
                local card = create_card('Joker', G.jokers, true, nil, nil, nil, nil, 'sou')
                local edition = {negative = true}
                card:set_edition(edition, true)
                card:add_to_deck()
                G.jokers:emplace(card)
                if self.ability.name == 'The Soul' then check_for_unlock{type = 'spawn_legendary'} end
                used_tarot:juice_up(0.3, 0.5)
                return true end }))
            delay(0.6)
        end
        if self.ability.name == 'Ankh DX' then 
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
        end
        if self.ability.name == 'Wraith DX' then
            G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
                play_sound('timpani')
                local card = create_card('Joker', G.jokers, nil, 0.99, nil, nil, nil, 'wra')
                card:add_to_deck()
                G.jokers:emplace(card)
                used_tarot:juice_up(0.3, 0.5)
                return true end }))
            delay(0.6)
        end
        if self.ability.name == 'The Wheel of Fortune DX' or self.ability.name == 'Ectoplasm DX' or self.ability.name == 'Hex DX' then
            local temp_pool = (self.ability.name == 'The Wheel of Fortune DX' and self.eligible_strength_jokers) or 
                                ((self.ability.name == 'Ectoplasm DX' or self.ability.name == 'Hex DX') and self.eligible_editionless_jokers) or {}
            if self.ability.name == 'Ectoplasm DX' or self.ability.name == 'Hex DX' or pseudorandom('wheel_of_fortune') < G.GAME.probabilities.normal/self.ability.extra then 
                G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
                    local over = false
                    local eligible_card = pseudorandom_element(temp_pool, pseudoseed(
                        (self.ability.name == 'The Wheel of Fortune DX' and 'wheel_of_fortune') or 
                        (self.ability.name == 'Ectoplasm DX' and 'ectoplasm') or
                        (self.ability.name == 'Hex DX' and 'hex')
                    ))
                    local edition = nil
                    if self.ability.name == 'Ectoplasm DX' then
                        edition = {negative = true}
                    elseif self.ability.name == 'Hex DX' then
                        edition = {polychrome = true}
                    elseif self.ability.name == 'The Wheel of Fortune DX' then
                        edition = poll_edition('wheel_of_fortune', nil, true, true)
                    end
                    eligible_card:set_edition(edition, true)
                    if self.ability.name == 'The Wheel of Fortune DX' or self.ability.name == 'Ectoplasm DX' or self.ability.name == 'Hex DX' then check_for_unlock({type = 'have_edition'}) end
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
        end
    elseif self.ability.name == 'Black Hole' and planet_edition_enabled then    -- Manage Black Hole if planet editions is enabled
        stop_use()
        if not copier then set_consumeable_usage(self) end
        if self.debuff then return nil end
        local used_tarot = copier or self
    
        if self.ability.consumeable.max_highlighted then
            update_hand_text({immediate = true, nopulse = true, delay = 0}, {mult = 0, chips = 0, level = '', handname = ''})
        end

        update_hand_text({sound = 'button', volume = 0.7, pitch = 0.8, delay = 0.3}, {handname=localize('k_all_hands'),chips = '...', mult = '...', level=''})
        G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.2, func = function()
            play_sound('tarot1')
            self:juice_up(0.8, 0.5)
            G.TAROT_INTERRUPT_PULSE = true
            return true end }))
        update_hand_text({delay = 0}, {mult = '+', StatusText = true})
        G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.9, func = function()
            play_sound('tarot1')
            self:juice_up(0.8, 0.5)
            return true end }))
        update_hand_text({delay = 0}, {chips = '+', StatusText = true})
        G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.9, func = function()
            play_sound('tarot1')
            self:juice_up(0.8, 0.5)
            G.TAROT_INTERRUPT_PULSE = nil
            return true end }))
        update_hand_text({sound = 'button', volume = 0.7, pitch = 0.9, delay = 0}, {level='+3'})
        if self.edition then
            if self.edition.holo then
                G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.9, func = function()
                    play_sound('holo1')
                    self:juice_up(0.8, 0.5)
                    return true end }))
                    update_hand_text({delay = 0}, {mult = '+' .. tostring(G.P_CENTERS.e_holo.config.extra), StatusText = true})
            end
            if self.edition.foil then
                G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.9, func = function()
                    play_sound('foil1')
                    self:juice_up(0.8, 0.5)
                    return true end }))
                    update_hand_text({delay = 0}, {mult = '+' .. tostring(G.P_CENTERS.e_foil.config.extra), StatusText = true})
            end
            if self.edition.polychrome then
                G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.9, func = function()
                    play_sound('polychrome1')
                    self:juice_up(0.8, 0.5)
                    return true end }))
                    update_hand_text({delay = 0}, {mult = 'x' .. tostring(G.P_CENTERS.e_polychrome.config.extra), StatusText = true})
            end
        end
        delay(1.3)
        for k, v in pairs(G.GAME.hands) do
            level_up_hand(self, k, true)
        end
        update_hand_text({sound = 'button', volume = 0.7, pitch = 1.1, delay = 0}, {mult = 0, chips = 0, handname = '', level = ''})
    else    -- Call vanilla
        card_use_consumeable_ref(self, area, copier)
    end
end

-- Check if DX card can be used
local card_can_use_consumeable_ref = Card.can_use_consumeable
function Card.can_use_consumeable(self, any_state, skip_check)

    if self.ability.set == 'Tarot_dx' or self.ability.set == 'Spectral_dx' then

        if not skip_check and ((G.play and #G.play.cards > 0) or
            (G.CONTROLLER.locked) or
            (G.GAME.STOP_USE and G.GAME.STOP_USE > 0))
            then  return false end

        if G.STATE ~= G.STATES.HAND_PLAYED and G.STATE ~= G.STATES.DRAW_TO_HAND and G.STATE ~= G.STATES.PLAY_TAROT or any_state then

            if self.ability.name == 'The Hermit DX' or self.ability.name == 'Temperance DX' or self.ability.name == 'Black Hole DX' or self.ability.name == 'The Soul DX' then
                return true
            end
            if self.ability.name == 'The Wheel of Fortune DX' then 
                if next(self.eligible_strength_jokers) then return true end
            end
            if self.ability.name == 'Ankh DX' then
                --if there is at least one joker
                for k, v in pairs(G.jokers.cards) do
                    if v.ability.set == 'Joker' and G.jokers.config.card_limit > 1 then 
                        return true
                    end
                end
            end
            if self.ability.name == 'Ectoplasm DX' or self.ability.name == 'Hex DX' then 
                if next(self.eligible_editionless_jokers) then return true end
            end
            if self.ability.name == 'The Emperor DX' or self.ability.name == 'The High Priestess DX'  then 
                return true
            end
            if self.ability.name == 'The Fool DX' then
                if (#G.consumeables.cards < G.consumeables.config.card_limit or self.area == G.consumeables) 
                    and G.GAME.last_tarot_planet and G.GAME.last_tarot_planet ~= 'c_fool' then return true end
            end
            if self.ability.name == 'Judgement DX' or self.ability.name == 'Wraith DX' then
                if #G.jokers.cards < G.jokers.config.card_limit or self.area == G.jokers then
                    return true
                else
                    return false
                end
            end
            if G.STATE == G.STATES.SELECTING_HAND or G.STATE == G.STATES.TAROT_PACK or G.STATE == G.STATES.SPECTRAL_PACK or G.STATE == G.STATES.PLANET_PACK then
                if self.ability.consumeable.max_highlighted then
                    if self.ability.consumeable.mod_num >= #G.hand.highlighted and #G.hand.highlighted >= (self.ability.consumeable.min_highlighted or 1) then
                        return true
                    end
                end
            end

        end
        return false

    else

        return card_can_use_consumeable_ref(self, any_state, skip_check)
    end
end

-- Manage DX materialize color
local card_start_materialize_ref = Card.start_materialize
function Card.start_materialize(self, dissolve_colours, silent, timefac)

    local new_dissolve_colours = nil

    if self.ability.set == 'Tarot_dx' or self.ability.set == 'Planet_dx' or self.ability.set == 'Spectral_dx' then
        new_dissolve_colours = dissolve_colours or
        (self.ability.set == 'Tarot_dx' and {G.C.SECONDARY_SET.Tarot}) or
        (self.ability.set == 'Planet_dx'  and {G.C.SECONDARY_SET.Planet}) or
        (self.ability.set == 'Spectral_dx' and {G.C.SECONDARY_SET.Spectral}) or
        {G.C.GREEN}
    else
        new_dissolve_colours = dissolve_colours
    end

    card_start_materialize_ref(self, new_dissolve_colours, silent, timefac)
end

-- Manage Satellite joker
local card_calculate_dollar_bonus_ref = Card.calculate_dollar_bonus
function Card.calculate_dollar_bonus(self)

    ret = card_calculate_dollar_bonus_ref(self)

    if not self.debuff and self.ability.set == "Joker" and self.ability.name == 'Satellite' then
        local planets_used = 0
        for k, v in pairs(G.GAME.consumeable_usage) do
            if v.set == 'Planet' or v.set == 'Planet_dx' then planets_used = planets_used + 1 end
        end
        if planets_used == 0 then return end
        ret = self.ability.extra*planets_used
    end

    return ret
end

-- Update calculate_joker for DX
local card_calculate_joker_ref = Card.calculate_joker
function Card.calculate_joker(self, context)

    if self.ability.set == "Planet_dx" and not self.debuff then
        if context.joker_main then
            if G.GAME.used_vouchers.v_observatory and self.ability.consumeable.hand_type == context.scoring_name then
                return {
                    message = localize{type = 'variable', key = 'a_xmult', vars = {G.P_CENTERS.v_observatory.config.extra}},
                    Xmult_mod = G.P_CENTERS.v_observatory.config.extra
                }
            end
        end
    end

    if self.ability.set == "Joker" and not self.debuff then
        if context.using_consumeable then
            if self.ability.name == 'Glass Joker' and not context.blueprint and (context.consumeable.ability.name == 'The Hanged Man DX')  then
                local shattered_glass = 0
                for k, val in ipairs(G.hand.highlighted) do
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
            if self.ability.name == 'Fortune Teller' and not context.blueprint and (context.consumeable.ability.set == "Tarot_dx") then
                G.E_MANAGER:add_event(Event({
                    func = function() card_eval_status_text(self, 'extra', nil, nil, nil, {message = localize{type='variable',key='a_mult',vars={G.GAME.consumeable_usage_total.tarot}}}); return true
                    end}))
                return
            end
            if self.ability.name == 'Constellation' and not context.blueprint and (context.consumeable.ability.set == 'Planet_dx') then
                self.ability.x_mult = self.ability.x_mult + self.ability.extra
                G.E_MANAGER:add_event(Event({
                    func = function() card_eval_status_text(self, 'extra', nil, nil, nil, {message = localize{type='variable',key='a_xmult',vars={self.ability.x_mult}}}); return true
                    end}))
                return
            end
        end
    end

    return card_calculate_joker_ref(self, context)
end

-- Blank voucher
local card_apply_to_run_ref = Card.apply_to_run
function Card.apply_to_run(self, center)

    if spectral_on_blank then
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

-- Update update for DX
local card_update_ref = Card.update
function Card.update(self, dt)

    card_update_ref(self, dt)

    if self.ability.name == 'Temperance DX' then
        if G.STAGE == G.STAGES.RUN then
            self.ability.money = 0
            for i = 1, #G.jokers.cards do
                if G.jokers.cards[i].ability.set == 'Joker' then
                    self.ability.money = self.ability.money + (G.jokers.cards[i].sell_cost * 2)
                end
            end
            self.ability.money = math.min(self.ability.money, self.ability.extra)
        else
            self.ability.money = 0
        end
    end
    if self.ability.name == 'The Wheel of Fortune DX' then
        self.eligible_strength_jokers = EMPTY(self.eligible_strength_jokers)
        for k, v in pairs(G.jokers.cards) do
            if v.ability.set == 'Joker' and (not v.edition) then
                table.insert(self.eligible_strength_jokers, v)
            end
        end
    end
    if self.ability.name == 'Ectoplasm DX' or self.ability.name == 'Hex DX' then
        self.eligible_editionless_jokers = EMPTY(self.eligible_editionless_jokers)
        for k, v in pairs(G.jokers.cards) do
            if v.ability.set == 'Joker' and (not v.edition) then
                table.insert(self.eligible_editionless_jokers, v)
            end
        end
    end
end

-- Prevents duplicates between normal and DX version
local card_set_ability_ref = Card.set_ability
function Card.set_ability(self, center, initial, delay_sprites)

    card_set_ability_ref(self, center, initial, delay_sprites)

    if self.ability and self.ability.consumeable and self.ability.name and self.ability.set then 
        if self.ability.set == 'Tarot_dx' or self.ability.set == 'Planet_dx' or self.ability.set == 'Spectral_dx' then
            if not G.OVERLAY_MENU then 
                for k, v in pairs(G.P_CENTERS) do
                    if v.name == self.ability.name then
                        -- Add normal version
                        G.GAME.used_jokers[string.sub(k, 1, -4)] = true
                    end
                end
            end
        end
        if self.ability.set == 'Tarot' or self.ability.set == 'Planet' or self.ability.set == 'Spectral' then
            if not G.OVERLAY_MENU then 
                for k, v in pairs(G.P_CENTERS) do
                    if v.name == self.ability.name then
                        -- Add DX version
                        G.GAME.used_jokers[k..'_dx'] = true
                    end
                end
            end
        end
    end
end

-- Prevents duplicates between normal and DX version
local card_remove_ref = Card.remove
function Card.remove(self)

    if self.ability and self.ability.consumeable and self.ability.name and self.ability.set then 
        if self.ability.set == 'Tarot_dx' or self.ability.set == 'Planet_dx' or self.ability.set == 'Spectral_dx' then
            if not G.OVERLAY_MENU then 
                for k, v in pairs(G.P_CENTERS) do
                    if v.name == self.ability.name then
                        if not next(find_joker(self.ability.name, true)) then 
                            -- Remove normal version
                            G.GAME.used_jokers[string.sub(k, 1, -4)] = nil
                        end
                    end
                end
            end
        end
        if self.ability.set == 'Tarot' or self.ability.set == 'Planet' or self.ability.set == 'Spectral' then
            if not G.OVERLAY_MENU then 
                for k, v in pairs(G.P_CENTERS) do
                    if v.name == self.ability.name then
                        if not next(find_joker(self.ability.name, true)) then 
                            -- Remove DX version
                            G.GAME.used_jokers[k..'_dx'] = nil
                        end
                    end
                end
            end
        end
    end

    card_remove_ref(self)
end

----------------------------------------------
------------MOD CODE END----------------------
