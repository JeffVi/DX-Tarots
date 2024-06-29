--- STEAMODDED HEADER
--- MOD_NAME: Deluxe Consumables Cards
--- MOD_ID: JeffDeluxeConsumablesPack
--- MOD_AUTHOR: [JeffVi]
--- MOD_DESCRIPTION: Add Deluxe versions of consumables
--- PRIORITY: 1000

----------------------------------------------
------------MOD CODE -------------------------

-- SET CUSTOM CONFIG HERE

local tarot_dx_rate = 0.1               -- (from 0 (0%) to 1 (100%))
local tarot_cu_rate = 0.07              -- (from 0 (0%) to 1 (100%))
local planet_dx_rate = 0.12             -- (from 0 (0%) to 1 (100%))
local spectral_dx_rate = 0.15           -- (from 0 (0%) to 1 (100%))
local alchemical_dx_rate = 0.1          -- (from 0 (0%) to 1 (100%))
local booster_dx_rate = 0.1             -- (from 0 (0%) to 1 (100%))
local planet_edition_enabled = true     -- Enable/Disable the possibility of planet cards edition (may not be compatible with other mods that overwrite the level_up_hand function)
local spectral_on_blank = true          -- Enable/Disable spectral rate on blank voucher
local unique_enabled = true             -- Enable/Disable the unique badge management.

-- END CUSTOM CONFIGS

---------- local functions & variables ----------

local enhanced_prototype_centers = {}
local enhanced_prototype_descriptions = {}

local function setup_consumables()
    
    -- Vanilla DX Tarots
    G.P_CENTERS.c_fool_dx=             {order = 1,     discovered = true, cost = 5, consumeable = true, name = "The Fool DX", pos = {x=0,y=0}, set = "Tarot", effect = "Disable Blind Effect", cost_mult = 1.0, config = {type = '_dx'}, atlas = 'Van_dx'}
    G.P_CENTERS.c_magician_dx=         {order = 2,     discovered = true, cost = 5, consumeable = true, name = "The Magician DX", pos = {x=1,y=0}, set = "Tarot", effect = "Enhance", cost_mult = 1.0, config = {type = '_dx', mod_conv = 'm_lucky', max_highlighted = 4}, atlas = 'Van_dx'}
    G.P_CENTERS.c_high_priestess_dx=   {order = 3,     discovered = true, cost = 5, consumeable = true, name = "The High Priestess DX", pos = {x=2,y=0}, set = "Tarot", effect = "Round Bonus", cost_mult = 1.0, config = {type = '_dx', planets = 2}, atlas = 'Van_dx'}
    G.P_CENTERS.c_empress_dx=          {order = 4,     discovered = true, cost = 5, consumeable = true, name = "The Empress DX", pos = {x=3,y=0}, set = "Tarot", effect = "Enhance", cost_mult = 1.0, config = {type = '_dx', mod_conv = 'm_mult', max_highlighted = 4}, atlas = 'Van_dx'}
    G.P_CENTERS.c_emperor_dx=          {order = 5,     discovered = true, cost = 5, consumeable = true, name = "The Emperor DX", pos = {x=4,y=0}, set = "Tarot", effect = "Round Bonus", cost_mult = 1.0, config = {type = '_dx', tarots = 2}, atlas = 'Van_dx'}
    G.P_CENTERS.c_heirophant_dx=       {order = 6,     discovered = true, cost = 5, consumeable = true, name = "The Hierophant DX", pos = {x=5,y=0}, set = "Tarot", effect = "Enhance", cost_mult = 1.0, config = {type = '_dx', mod_conv = 'm_bonus', max_highlighted = 4}, atlas = 'Van_dx'}
    G.P_CENTERS.c_lovers_dx=           {order = 7,     discovered = true, cost = 5, consumeable = true, name = "The Lovers DX", pos = {x=6,y=0}, set = "Tarot", effect = "Enhance", cost_mult = 1.0, config = {type = '_dx', mod_conv = 'm_wild', max_highlighted = 2}, atlas = 'Van_dx'}
    G.P_CENTERS.c_chariot_dx=          {order = 8,     discovered = true, cost = 5, consumeable = true, name = "The Chariot DX", pos = {x=7,y=0}, set = "Tarot", effect = "Enhance", cost_mult = 1.0, config = {type = '_dx', mod_conv = 'm_steel', max_highlighted = 2}, atlas = 'Van_dx'}
    G.P_CENTERS.c_justice_dx=          {order = 9,     discovered = true, cost = 5, consumeable = true, name = "Justice DX", pos = {x=8,y=0}, set = "Tarot", effect = "Enhance", cost_mult = 1.0, config = {type = '_dx', mod_conv = 'm_glass', max_highlighted = 2}, atlas = 'Van_dx'}
    G.P_CENTERS.c_hermit_dx=           {order = 10,    discovered = true, cost = 5, consumeable = true, name = "The Hermit DX", pos = {x=9,y=0}, set = "Tarot", effect = "Dollar Doubler", cost_mult = 1.0, config = {type = '_dx', extra = 30}, atlas = 'Van_dx'}
    G.P_CENTERS.c_wheel_of_fortune_dx= {order = 11,    discovered = true, cost = 5, consumeable = true, name = "The Wheel of Fortune DX", pos = {x=0,y=1}, set = "Tarot", effect = "Round Bonus", cost_mult = 1.0, config = {type = '_dx', extra = 2}, atlas = 'Van_dx'}
    G.P_CENTERS.c_strength_dx=         {order = 12,    discovered = true, cost = 5, consumeable = true, name = "Strength DX", pos = {x=1,y=1}, set = "Tarot", effect = "Round Bonus", cost_mult = 1.0, config = {type = '_dx', mod_conv = 'up_rank', max_highlighted = 4}, atlas = 'Van_dx'}
    G.P_CENTERS.c_hanged_man_dx=       {order = 13,    discovered = true, cost = 5, consumeable = true, name = "The Hanged Man DX", pos = {x=2,y=1}, set = "Tarot", effect = "Card Removal", cost_mult = 1.0, config = {type = '_dx', remove_card = true, max_highlighted = 4}, atlas = 'Van_dx'}
    G.P_CENTERS.c_death_dx=            {order = 14,    discovered = true, cost = 5, consumeable = true, name = "Death DX", pos = {x=3,y=1}, set = "Tarot", effect = "Card Conversion", cost_mult = 1.0, config = {type = '_dx', mod_conv = 'card', max_highlighted = 3, min_highlighted = 2}, atlas = 'Van_dx'}
    G.P_CENTERS.c_temperance_dx=       {order = 15,    discovered = true, cost = 5, consumeable = true, name = "Temperance DX", pos = {x=4,y=1}, set = "Tarot", effect = "Joker Payout", cost_mult = 1.0, config = {type = '_dx', extra = 60}, atlas = 'Van_dx'}
    G.P_CENTERS.c_devil_dx=            {order = 16,    discovered = true, cost = 5, consumeable = true, name = "The Devil DX", pos = {x=5,y=1}, set = "Tarot", effect = "Enhance", cost_mult = 1.0, config = {type = '_dx', mod_conv = 'm_gold', max_highlighted = 2}, atlas = 'Van_dx'}
    G.P_CENTERS.c_tower_dx=            {order = 17,    discovered = true, cost = 5, consumeable = true, name = "The Tower DX", pos = {x=6,y=1}, set = "Tarot", effect = "Enhance", cost_mult = 1.0, config = {type = '_dx', mod_conv = 'm_stone', max_highlighted = 2}, atlas = 'Van_dx'}
    G.P_CENTERS.c_star_dx=             {order = 18,    discovered = true, cost = 5, consumeable = true, name = "The Star DX", pos = {x=7,y=1}, set = "Tarot", effect = "Suit Conversion", cost_mult = 1.0, config = {type = '_dx', suit_conv = 'Diamonds', max_highlighted = 5}, atlas = 'Van_dx'}
    G.P_CENTERS.c_moon_dx=             {order = 19,    discovered = true, cost = 5, consumeable = true, name = "The Moon DX", pos = {x=8,y=1}, set = "Tarot", effect = "Suit Conversion", cost_mult = 1.0, config = {type = '_dx', suit_conv = 'Clubs', max_highlighted = 5}, atlas = 'Van_dx'}
    G.P_CENTERS.c_sun_dx=              {order = 20,    discovered = true, cost = 5, consumeable = true, name = "The Sun DX", pos = {x=9,y=1}, set = "Tarot", effect = "Suit Conversion", cost_mult = 1.0, config = {type = '_dx', suit_conv = 'Hearts', max_highlighted = 5}, atlas = 'Van_dx'}
    G.P_CENTERS.c_judgement_dx=        {order = 21,    discovered = true, cost = 5, consumeable = true, name = "Judgement DX", pos = {x=0,y=2}, set = "Tarot", effect = "Random Joker", cost_mult = 1.0, config = {type = '_dx', }, atlas = 'Van_dx'}
    G.P_CENTERS.c_world_dx=            {order = 22,    discovered = true, cost = 5, consumeable = true, name = "The World DX", pos = {x=1,y=2}, set = "Tarot", effect = "Suit Conversion", cost_mult = 1.0, config = {type = '_dx', suit_conv = 'Spades', max_highlighted = 5}, atlas = 'Van_dx'}

    -- Vanilla Cursed Tarots
    G.P_CENTERS.c_fool_cu=             {order = 1,     discovered = true, cost = 5, consumeable = true, name = "The Cursed Fool", pos = {x=0,y=0}, set = "Tarot", effect = "Disable Blind Effect", cost_mult = 1.0, config = {type = '_cu', unique = true, nb_curse = 1}, atlas = 'Van_cu'}
    G.P_CENTERS.c_magician_cu=         {order = 2,     discovered = true, cost = 5, consumeable = true, name = "The Cursed Magician", pos = {x=1,y=0}, set = "Tarot", effect = "Round Bonus", cost_mult = 1.0, config = {type = '_cu', unique = true, nb_curse = 2}, atlas = 'Van_cu'}
    G.P_CENTERS.c_high_priestess_cu=   {order = 3,     discovered = true, cost = 5, consumeable = true, name = "The Cursed High Priestess", pos = {x=2,y=0}, set = "Tarot", effect = "Round Bonus", cost_mult = 1.0, config = {type = '_cu', planets = 2, prob_mult = 2, unique = true, nb_curse = 1}, atlas = 'Van_cu'}
    G.P_CENTERS.c_empress_cu=          {order = 4,     discovered = true, cost = 5, consumeable = true, name = "The Cursed Empress", pos = {x=3,y=0}, set = "Tarot", effect = "Round Bonus", cost_mult = 1.0, config = {type = '_cu', mod_conv = 'm_mult', extra = 8, unique = true, nb_curse = 1}, atlas = 'Van_cu'}
    G.P_CENTERS.c_emperor_cu=          {order = 5,     discovered = true, cost = 5, consumeable = true, name = "The Cursed Emperor", pos = {x=4,y=0}, set = "Tarot", effect = "Round Bonus", cost_mult = 1.0, config = {type = '_cu', tarots = 6, unique = true, nb_curse = 1}, atlas = 'Van_cu'}
    G.P_CENTERS.c_heirophant_cu=       {order = 6,     discovered = true, cost = 5, consumeable = true, name = "The Cursed Hierophant", pos = {x=5,y=0}, set = "Tarot", effect = "Round Bonus", cost_mult = 1.0, config = {type = '_cu', mod_conv = 'm_bonus', extra = 60, max_highlighted = 4, unique = true, nb_curse = 1}, atlas = 'Van_cu'}
    G.P_CENTERS.c_lovers_cu=           {order = 7,     discovered = true, cost = 5, consumeable = true, name = "The Cursed Lovers", pos = {x=6,y=0}, set = "Tarot", effect = "Round Bonus", cost_mult = 1.0, config = {type = '_cu', mod_conv = 'm_wild', unique = true, nb_curse = 1}, atlas = 'Van_cu'}
    G.P_CENTERS.c_chariot_cu=          {order = 8,     discovered = true, cost = 5, consumeable = true, name = "The Cursed Chariot", pos = {x=7,y=0}, set = "Tarot", effect = "Round Bonus", cost_mult = 1.0, config = {type = '_cu', mod_conv = 'm_steel', extra = 1, unique = true, nb_curse = 2}, atlas = 'Van_cu'}
    G.P_CENTERS.c_justice_cu=          {order = 9,     discovered = true, cost = 5, consumeable = true, name = "Cursed Justice", pos = {x=8,y=0}, set = "Tarot", effect = "Round Bonus", cost_mult = 1.0, config = {type = '_cu', mod_conv = 'm_glass', extra = 1.5, unique = true, nb_curse = 2}, atlas = 'Van_cu'}
    G.P_CENTERS.c_hermit_cu=           {order = 10,    discovered = true, cost = 5, consumeable = true, name = "The Cursed Hermit", pos = {x=9,y=0}, set = "Tarot", effect = "Dollar Doubler", cost_mult = 1.0, config = {type = '_cu', extra = 50, unique = true, nb_curse = 2}, atlas = 'Van_cu'}
    G.P_CENTERS.c_wheel_of_fortune_cu= {order = 11,    discovered = true, cost = 5, consumeable = true, name = "The Cursed Wheel of Fortune", pos = {x=0,y=1}, set = "Tarot", effect = "Round Bonus", cost_mult = 1.0, config = {type = '_cu', unique = true, nb_curse = 2, extra = 3}, atlas = 'Van_cu'}
    G.P_CENTERS.c_strength_cu=         {order = 12,    discovered = true, cost = 5, consumeable = true, name = "Cursed Strength", pos = {x=1,y=1}, set = "Tarot", effect = "Round Bonus", cost_mult = 1.0, config = {type = '_cu', mod_conv = 'up_rank', max_highlighted = 5, min_highlighted = 1, unique = true, nb_curse = 2}, atlas = 'Van_cu'}
    G.P_CENTERS.c_hanged_man_cu=       {order = 13,    discovered = true, cost = 5, consumeable = true, name = "The Cursed Hanged Man", pos = {x=2,y=1}, set = "Tarot", effect = "Card Removal", cost_mult = 1.0, config = {type = '_cu', remove_card = true, max_highlighted = 4, min_highlighted = 1, unique = true, nb_curse = 2}, atlas = 'Van_cu'}
    G.P_CENTERS.c_death_cu=            {order = 14,    discovered = true, cost = 5, consumeable = true, name = "Cursed Death", pos = {x=3,y=1}, set = "Tarot", effect = "Card Conversion", cost_mult = 1.0, config = {type = '_cu', mod_conv = 'card', max_highlighted = 5, min_highlighted = 2, unique = true, nb_curse = 2}, atlas = 'Van_cu'}
    G.P_CENTERS.c_temperance_cu=       {order = 15,    discovered = true, cost = 5, consumeable = true, name = "Cursed Temperance", pos = {x=4,y=1}, set = "Tarot", effect = "Joker Payout", cost_mult = 1.0, config = {type = '_cu', extra = 60, unique = true, nb_curse = 1}, atlas = 'Van_cu'}
    G.P_CENTERS.c_devil_cu=            {order = 16,    discovered = true, cost = 5, consumeable = true, name = "The Cursed Devil", pos = {x=5,y=1}, set = "Tarot", effect = "Enhance", cost_mult = 1.0, config = {type = '_cu', mod_conv = 'm_gold', extra = 5, unique = true, nb_curse = 2}, atlas = 'Van_cu'}
    G.P_CENTERS.c_tower_cu=            {order = 17,    discovered = true, cost = 5, consumeable = true, name = "The Cursed Tower", pos = {x=6,y=1}, set = "Tarot", effect = "Enhance", cost_mult = 1.0, config = {type = '_cu', mod_conv = 'm_stone', extra = 200, unique = true, nb_curse = 1}, atlas = 'Van_cu'}
    G.P_CENTERS.c_star_cu=             {order = 18,    discovered = true, cost = 5, consumeable = true, name = "The Cursed Star", pos = {x=7,y=1}, set = "Tarot", effect = "Suit Conversion", cost_mult = 1.0, config = {type = '_cu', suit_conv = 'Diamonds', unique = true, nb_curse = 2}, atlas = 'Van_cu'}
    G.P_CENTERS.c_moon_cu=             {order = 19,    discovered = true, cost = 5, consumeable = true, name = "The Cursed Moon", pos = {x=8,y=1}, set = "Tarot", effect = "Suit Conversion", cost_mult = 1.0, config = {type = '_cu', suit_conv = 'Clubs', unique = true, nb_curse = 2}, atlas = 'Van_cu'}
    G.P_CENTERS.c_sun_cu=              {order = 20,    discovered = true, cost = 5, consumeable = true, name = "The Cursed Sun", pos = {x=9,y=1}, set = "Tarot", effect = "Suit Conversion", cost_mult = 1.0, config = {type = '_cu', suit_conv = 'Hearts', unique = true, nb_curse = 2}, atlas = 'Van_cu'}
    G.P_CENTERS.c_judgement_cu=        {order = 21,    discovered = true, cost = 5, consumeable = true, name = "Cursed Judgement", pos = {x=0,y=2}, set = "Tarot", effect = "Random Joker", cost_mult = 1.0, config = {type = '_cu', unique = true, nb_curse = 1}, atlas = 'Van_cu'}
    G.P_CENTERS.c_world_cu=            {order = 22,    discovered = true, cost = 5, consumeable = true, name = "The Cursed World", pos = {x=1,y=2}, set = "Tarot", effect = "Suit Conversion", cost_mult = 1.0, config = {type = '_cu', suit_conv = 'Spades', unique = true, nb_curse = 2}, atlas = 'Van_cu'}

    -- Vanilla DX Planets
    G.P_CENTERS.c_mercury_dx=          {order = 1,    discovered = true, cost = 5, consumeable = true, freq = 1, name = "Mercury DX", pos = {x=0,y=3}, set = "Planet", effect = "Hand Upgrade", cost_mult = 1.0, config = {type = '_dx', hand_type = 'Pair'}, atlas = 'Van_dx'}
    G.P_CENTERS.c_venus_dx=            {order = 2,    discovered = true, cost = 5, consumeable = true, freq = 1, name = "Venus DX", pos = {x=1,y=3}, set = "Planet", effect = "Hand Upgrade", cost_mult = 1.0, config = {type = '_dx', hand_type = 'Three of a Kind'}, atlas = 'Van_dx'}
    G.P_CENTERS.c_earth_dx=            {order = 3,    discovered = true, cost = 5, consumeable = true, freq = 1, name = "Earth DX", pos = {x=2,y=3}, set = "Planet", effect = "Hand Upgrade", cost_mult = 1.0, config = {type = '_dx', hand_type = 'Full House'}, atlas = 'Van_dx'}
    G.P_CENTERS.c_mars_dx=             {order = 4,    discovered = true, cost = 5, consumeable = true, freq = 1, name = "Mars DX", pos = {x=3,y=3}, set = "Planet", effect = "Hand Upgrade", cost_mult = 1.0, config = {type = '_dx', hand_type = 'Four of a Kind'}, atlas = 'Van_dx'}
    G.P_CENTERS.c_jupiter_dx=          {order = 5,    discovered = true, cost = 5, consumeable = true, freq = 1, name = "Jupiter DX", pos = {x=4,y=3}, set = "Planet", effect = "Hand Upgrade", cost_mult = 1.0, config = {type = '_dx', hand_type = 'Flush'}, atlas = 'Van_dx'}
    G.P_CENTERS.c_saturn_dx=           {order = 6,    discovered = true, cost = 5, consumeable = true, freq = 1, name = "Saturn DX", pos = {x=5,y=3}, set = "Planet", effect = "Hand Upgrade", cost_mult = 1.0, config = {type = '_dx', hand_type = 'Straight'}, atlas = 'Van_dx'}
    G.P_CENTERS.c_uranus_dx=           {order = 7,    discovered = true, cost = 5, consumeable = true, freq = 1, name = "Uranus DX", pos = {x=6,y=3}, set = "Planet", effect = "Hand Upgrade", cost_mult = 1.0, config = {type = '_dx', hand_type = 'Two Pair'}, atlas = 'Van_dx'}
    G.P_CENTERS.c_neptune_dx=          {order = 8,    discovered = true, cost = 5, consumeable = true, freq = 1, name = "Neptune DX", pos = {x=7,y=3}, set = "Planet", effect = "Hand Upgrade", cost_mult = 1.0, config = {type = '_dx', hand_type = 'Straight Flush'}, atlas = 'Van_dx'}
    G.P_CENTERS.c_pluto_dx=            {order = 9,    discovered = true, cost = 5, consumeable = true, freq = 1, name = "Pluto DX", pos = {x=8,y=3}, set = "Planet", effect = "Hand Upgrade", cost_mult = 1.0, config = {type = '_dx', hand_type = 'High Card'}, atlas = 'Van_dx'}
    G.P_CENTERS.c_planet_x_dx=         {order = 10,   discovered = true, cost = 5, consumeable = true, freq = 1, name = "Planet X DX", pos = {x=9,y=2}, set = "Planet", effect = "Hand Upgrade", cost_mult = 1.0, config = {type = '_dx', hand_type = 'Five of a Kind', softlock = true}, atlas = 'Van_dx'}
    G.P_CENTERS.c_ceres_dx=            {order = 11,   discovered = true, cost = 5, consumeable = true, freq = 1, name = "Ceres DX", pos = {x=8,y=2}, set = "Planet", effect = "Hand Upgrade", cost_mult = 1.0, config = {type = '_dx', hand_type = 'Flush House', softlock = true}, atlas = 'Van_dx'}
    G.P_CENTERS.c_eris_dx=             {order = 12,   discovered = true, cost = 5, consumeable = true, freq = 1, name = "Eris DX", pos = {x=3,y=2}, set = "Planet", effect = "Hand Upgrade", cost_mult = 1.0, config = {type = '_dx', hand_type = 'Flush Five', softlock = true}, atlas = 'Van_dx'}

    -- Vanilla DX Spectrals
    G.P_CENTERS.c_familiar_dx=         {order = 1,    discovered = true, cost = 6, consumeable = true, name = "Familiar DX", pos = {x=0,y=4}, set = "Spectral", config = {type = '_dx', max_highlighted = 2, min_highlighted = 2, remove_card = true, extra = 5, unique = true}, atlas = 'Van_dx'}
    G.P_CENTERS.c_grim_dx=             {order = 2,    discovered = true, cost = 6, consumeable = true, name = "Grim DX",     pos = {x=1,y=4}, set = "Spectral", config = {type = '_dx', max_highlighted = 2, min_highlighted = 2, remove_card = true, extra = 4, unique = true}, atlas = 'Van_dx'}
    G.P_CENTERS.c_incantation_dx=      {order = 3,    discovered = true, cost = 6, consumeable = true, name = "Incantation DX", pos = {x=2,y=4}, set = "Spectral", config = {type = '_dx', max_highlighted = 2, min_highlighted = 2, remove_card = true, extra = 6, unique = true}, atlas = 'Van_dx'}
    G.P_CENTERS.c_talisman_dx=         {order = 4,    discovered = true, cost = 6, consumeable = true, name = "Talisman DX", pos = {x=3,y=4}, set = "Spectral", config = {type = '_dx', extra = 'Gold', max_highlighted = 3, unique = true}, atlas = 'Van_dx'}
    G.P_CENTERS.c_aura_dx=             {order = 5,    discovered = true, cost = 6, consumeable = true, name = "Aura DX", pos = {x=4,y=4}, set = "Spectral", config = {type = '_dx', max_highlighted = 3, unique = true}, atlas = 'Van_dx'}
    G.P_CENTERS.c_wraith_dx=           {order = 6,    discovered = true, cost = 6, consumeable = true, name = "Wraith DX", pos = {x=5,y=4}, set = "Spectral", config = {type = '_dx', unique = true}, atlas = 'Van_dx'}
    G.P_CENTERS.c_sigil_dx=            {order = 7,    discovered = true, cost = 6, consumeable = true, name = "Sigil DX", pos = {x=6,y=4}, set = "Spectral", config = {type = '_dx', max_highlighted = 1, unique = true}, atlas = 'Van_dx'}
    G.P_CENTERS.c_ouija_dx=            {order = 8,    discovered = true, cost = 6, consumeable = true, name = "Ouija DX", pos = {x=7,y=4}, set = "Spectral", config = {type = '_dx', max_highlighted = 1, unique = true}, atlas = 'Van_dx'}
    G.P_CENTERS.c_ectoplasm_dx=        {order = 9,    discovered = true, cost = 6, consumeable = true, name = "Ectoplasm DX", pos = {x=8,y=4}, set = "Spectral", config = {type = '_dx', unique = true}, atlas = 'Van_dx'}
    G.P_CENTERS.c_immolate_dx=         {order = 10,   discovered = true, cost = 6, consumeable = true, name = "Immolate DX", pos = {x=9,y=4}, set = "Spectral", config = {type = '_dx', max_highlighted = 5, min_highlighted = 5, remove_card = true, extra = {destroy = 5, dollars = 20}, unique = true}, atlas = 'Van_dx'}
    G.P_CENTERS.c_ankh_dx=             {order = 11,   discovered = true, cost = 6, consumeable = true, name = "Ankh DX", pos = {x=0,y=5}, set = "Spectral", config = {type = '_dx', extra = 2, unique = true}, atlas = 'Van_dx'}
    G.P_CENTERS.c_deja_vu_dx=          {order = 12,   discovered = true, cost = 6, consumeable = true, name = "Deja Vu DX", pos = {x=1,y=5}, set = "Spectral", config = {type = '_dx', extra = 'Red', max_highlighted = 3, unique = true}, atlas = 'Van_dx'}
    G.P_CENTERS.c_hex_dx=              {order = 13,   discovered = true, cost = 6, consumeable = true, name = "Hex DX", pos = {x=2,y=5}, set = "Spectral", config = {type = '_dx', extra = 2, unique = true}, atlas = 'Van_dx'}
    G.P_CENTERS.c_trance_dx=           {order = 14,   discovered = true, cost = 6, consumeable = true, name = "Trance DX", pos = {x=3,y=5}, set = "Spectral", config = {type = '_dx', extra = 'Blue', max_highlighted = 3, unique = true}, atlas = 'Van_dx'}
    G.P_CENTERS.c_medium_dx=           {order = 15,   discovered = true, cost = 6, consumeable = true, name = "Medium DX", pos = {x=4,y=5}, set = "Spectral", config = {type = '_dx', extra = 'Purple', max_highlighted = 3, unique = true}, atlas = 'Van_dx'}
    G.P_CENTERS.c_cryptid_dx=          {order = 16,   discovered = true, cost = 6, consumeable = true, name = "Cryptid DX", pos = {x=5,y=5}, set = "Spectral", config = {type = '_dx', extra = 4, max_highlighted = 1, unique = true}, atlas = 'Van_dx'}
    G.P_CENTERS.c_soul_dx=             {order = 17,   discovered = true, cost = 6, consumeable = true, name = "The Soul DX", pos = {x=2,y=2}, set = "Spectral", effect = "Unlocker", config = {type = '_dx', unique = true}, hidden = true, atlas = 'Van_dx'}
    G.P_CENTERS.c_black_hole_dx=       {order = 18,   discovered = true, cost = 6, consumeable = true, name = "Black Hole DX", pos = {x=9,y=3}, set = "Spectral", config = {type = '_dx', unique = true}, hidden = true, atlas = 'Van_dx'}

    -- DX Booster Packs
    G.P_CENTERS.p_arcana_normal_1_dx =         {order = 1,  discovered = true, name = "Arcana Pack DX", weight = 1, kind = 'Arcana', cost = 6, pos = {x=0,y=0}, atlas = 'Van_Booster_dx', set = 'Booster', config = {type = '_dx', extra = 4, choose = 1, unique = true}}
    G.P_CENTERS.p_arcana_normal_2_dx =         {order = 2,  discovered = true, name = "Arcana Pack DX", weight = 1, kind = 'Arcana', cost = 6, pos = {x=1,y=0}, atlas = 'Van_Booster_dx', set = 'Booster', config = {type = '_dx', extra = 4, choose = 1, unique = true}}
    G.P_CENTERS.p_arcana_normal_3_dx =         {order = 3,  discovered = true, name = "Arcana Pack DX", weight = 1, kind = 'Arcana', cost = 6, pos = {x=2,y=0}, atlas = 'Van_Booster_dx', set = 'Booster', config = {type = '_dx', extra = 4, choose = 1, unique = true}}
    G.P_CENTERS.p_arcana_normal_4_dx =         {order = 4,  discovered = true, name = "Arcana Pack DX", weight = 1, kind = 'Arcana', cost = 6, pos = {x=3,y=0}, atlas = 'Van_Booster_dx', set = 'Booster', config = {type = '_dx', extra = 4, choose = 1, unique = true}}
    G.P_CENTERS.p_arcana_jumbo_1_dx =          {order = 5,  discovered = true, name = "Jumbo Arcana Pack DX", weight = 1, kind = 'Arcana', cost = 8, pos = {x=0,y=2}, atlas = 'Van_Booster_dx', set = 'Booster', config = {type = '_dx', extra = 6, choose = 1, unique = true}}
    G.P_CENTERS.p_arcana_jumbo_2_dx =          {order = 6,  discovered = true, name = "Jumbo Arcana Pack DX", weight = 1, kind = 'Arcana', cost = 8, pos = {x=1,y=2}, atlas = 'Van_Booster_dx', set = 'Booster', config = {type = '_dx', extra = 6, choose = 1, unique = true}}
    G.P_CENTERS.p_arcana_mega_1_dx =           {order = 7,  discovered = true, name = "Mega Arcana Pack DX", weight = 0.25, kind = 'Arcana', cost = 10, pos = {x=2,y=2}, atlas = 'Van_Booster_dx', set = 'Booster', config = {type = '_dx', extra = 6, choose = 2, unique = true}}
    G.P_CENTERS.p_arcana_mega_2_dx =           {order = 8,  discovered = true, name = "Mega Arcana Pack DX", weight = 0.25, kind = 'Arcana', cost = 10, pos = {x=3,y=2}, atlas = 'Van_Booster_dx', set = 'Booster', config = {type = '_dx', extra = 6, choose = 2, unique = true}}
    G.P_CENTERS.p_celestial_normal_1_dx =      {order = 9,  discovered = true, name = "Celestial Pack DX", weight = 1, kind = 'Celestial', cost = 6, pos = {x=0,y=1}, atlas = 'Van_Booster_dx', set = 'Booster', config = {type = '_dx', extra = 4, choose = 1, unique = true}}
    G.P_CENTERS.p_celestial_normal_2_dx =      {order = 10, discovered = true, name = "Celestial Pack DX", weight = 1, kind = 'Celestial', cost = 6, pos = {x=1,y=1}, atlas = 'Van_Booster_dx', set = 'Booster', config = {type = '_dx', extra = 4, choose = 1, unique = true}}
    G.P_CENTERS.p_celestial_normal_3_dx =      {order = 11, discovered = true, name = "Celestial Pack DX", weight = 1, kind = 'Celestial', cost = 6, pos = {x=2,y=1}, atlas = 'Van_Booster_dx', set = 'Booster', config = {type = '_dx', extra = 4, choose = 1, unique = true}}
    G.P_CENTERS.p_celestial_normal_4_dx =      {order = 12, discovered = true, name = "Celestial Pack DX", weight = 1, kind = 'Celestial', cost = 6, pos = {x=3,y=1}, atlas = 'Van_Booster_dx', set = 'Booster', config = {type = '_dx', extra = 4, choose = 1, unique = true}}
    G.P_CENTERS.p_celestial_jumbo_1_dx =       {order = 13, discovered = true, name = "Jumbo Celestial Pack DX", weight = 1, kind = 'Celestial', cost = 8, pos = {x=0,y=3}, atlas = 'Van_Booster_dx', set = 'Booster', config = {type = '_dx', extra = 6, choose = 1, unique = true}}
    G.P_CENTERS.p_celestial_jumbo_2_dx =       {order = 14, discovered = true, name = "Jumbo Celestial Pack DX", weight = 1, kind = 'Celestial', cost = 8, pos = {x=1,y=3}, atlas = 'Van_Booster_dx', set = 'Booster', config = {type = '_dx', extra = 6, choose = 1, unique = true}}
    G.P_CENTERS.p_celestial_mega_1_dx =        {order = 15, discovered = true, name = "Mega Celestial Pack DX", weight = 0.25, kind = 'Celestial', cost = 10, pos = {x=2,y=3}, atlas = 'Van_Booster_dx', set = 'Booster', config = {type = '_dx', extra = 6, choose = 2, unique = true}}
    G.P_CENTERS.p_celestial_mega_2_dx =        {order = 16, discovered = true, name = "Mega Celestial Pack DX", weight = 0.25, kind = 'Celestial', cost = 10, pos = {x=3,y=3}, atlas = 'Van_Booster_dx', set = 'Booster', config = {type = '_dx', extra = 6, choose = 2, unique = true}}
    G.P_CENTERS.p_spectral_normal_1_dx =       {order = 29, discovered = true, name = "Spectral Pack DX", weight = 0.3, kind = 'Spectral', cost = 6, pos = {x=0,y=4}, atlas = 'Van_Booster_dx', set = 'Booster', config = {type = '_dx', extra = 3, choose = 1, unique = true}}
    G.P_CENTERS.p_spectral_normal_2_dx =       {order = 30, discovered = true, name = "Spectral Pack DX", weight = 0.3, kind = 'Spectral', cost = 6, pos = {x=1,y=4}, atlas = 'Van_Booster_dx', set = 'Booster', config = {type = '_dx', extra = 3, choose = 1, unique = true}}
    G.P_CENTERS.p_spectral_jumbo_1_dx =        {order = 31, discovered = true, name = "Jumbo Spectral Pack DX", weight = 0.3, kind = 'Spectral', cost = 8, pos = {x=2,y=4}, atlas = 'Van_Booster_dx', set = 'Booster', config = {type = '_dx', extra = 5, choose = 1, unique = true}}
    G.P_CENTERS.p_spectral_mega_1_dx =         {order = 32, discovered = true, name = "Mega Spectral Pack DX", weight = 0.07, kind = 'Spectral', cost = 10, pos = {x=3,y=4}, atlas = 'Van_Booster_dx', set = 'Booster', config = {type = '_dx', extra = 5, choose = 2, unique = true}}
    G.P_CENTERS.p_standard_normal_1_dx =       {order = 17, discovered = true, name = "Standard Pack DX", weight = 1, kind = 'Standard', cost = 6, pos = {x=0,y=6}, atlas = 'Van_Booster_dx', set = 'Booster', config = {type = '_dx', extra = 4, choose = 1, unique = true}}
    G.P_CENTERS.p_standard_normal_2_dx =       {order = 18, discovered = true, name = "Standard Pack DX", weight = 1, kind = 'Standard', cost = 6, pos = {x=1,y=6}, atlas = 'Van_Booster_dx', set = 'Booster', config = {type = '_dx', extra = 4, choose = 1, unique = true}}
    G.P_CENTERS.p_standard_normal_3_dx =       {order = 19, discovered = true, name = "Standard Pack DX", weight = 1, kind = 'Standard', cost = 6, pos = {x=2,y=6}, atlas = 'Van_Booster_dx', set = 'Booster', config = {type = '_dx', extra = 4, choose = 1, unique = true}}
    G.P_CENTERS.p_standard_normal_4_dx =       {order = 20, discovered = true, name = "Standard Pack DX", weight = 1, kind = 'Standard', cost = 6, pos = {x=3,y=6}, atlas = 'Van_Booster_dx', set = 'Booster', config = {type = '_dx', extra = 4, choose = 1, unique = true}}
    G.P_CENTERS.p_standard_jumbo_1_dx =        {order = 21, discovered = true, name = "Jumbo Standard Pack DX", weight = 1, kind = 'Standard', cost = 8, pos = {x=0,y=7}, atlas = 'Van_Booster_dx', set = 'Booster', config = {type = '_dx', extra = 6, choose = 1, unique = true}}
    G.P_CENTERS.p_standard_jumbo_2_dx =        {order = 22, discovered = true, name = "Jumbo Standard Pack DX", weight = 1, kind = 'Standard', cost = 8, pos = {x=1,y=7}, atlas = 'Van_Booster_dx', set = 'Booster', config = {type = '_dx', extra = 6, choose = 1, unique = true}}
    G.P_CENTERS.p_standard_mega_1_dx =         {order = 23, discovered = true, name = "Mega Standard Pack DX", weight = 0.25, kind = 'Standard', cost = 10, pos = {x=2,y=7}, atlas = 'Van_Booster_dx', set = 'Booster', config = {type = '_dx', extra = 6, choose = 2, unique = true}}
    G.P_CENTERS.p_standard_mega_2_dx =         {order = 24, discovered = true, name = "Mega Standard Pack DX", weight = 0.25, kind = 'Standard', cost = 10, pos = {x=3,y=7}, atlas = 'Van_Booster_dx', set = 'Booster', config = {type = '_dx', extra = 6, choose = 2, unique = true}}
    G.P_CENTERS.p_buffoon_normal_1_dx =        {order = 25, discovered = true, name = "Buffoon Pack DX", weight = 0.6, kind = 'Buffoon', cost = 6, pos = {x=0,y=8}, atlas = 'Van_Booster_dx', set = 'Booster', config = {type = '_dx', extra = 3, choose = 1, unique = true}}
    G.P_CENTERS.p_buffoon_normal_2_dx =        {order = 26, discovered = true, name = "Buffoon Pack DX", weight = 0.6, kind = 'Buffoon', cost = 6, pos = {x=1,y=8}, atlas = 'Van_Booster_dx', set = 'Booster', config = {type = '_dx', extra = 3, choose = 1, unique = true}}
    G.P_CENTERS.p_buffoon_jumbo_1_dx =         {order = 27, discovered = true, name = "Jumbo Buffoon Pack DX", weight = 0.6, kind = 'Buffoon', cost = 8, pos = {x=2,y=8}, atlas = 'Van_Booster_dx', set = 'Booster', config = {type = '_dx', extra = 5, choose = 1, unique = true}}
    G.P_CENTERS.p_buffoon_mega_1_dx =          {order = 28, discovered = true, name = "Mega Buffoon Pack DX", weight = 0.15, kind = 'Buffoon', cost = 10, pos = {x=3,y=8}, atlas = 'Van_Booster_dx', set = 'Booster', config = {type = '_dx', extra = 5, choose = 2, unique = true}}


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

    -- Save vanilla enhanced centers
    enhanced_prototype_centers.m_bonus = G.P_CENTERS.m_bonus.config.bonus
    enhanced_prototype_centers.m_mult = G.P_CENTERS.m_mult.config.mult
    enhanced_prototype_centers.m_glass = G.P_CENTERS.m_glass.config.Xmult
    enhanced_prototype_centers.m_steel = G.P_CENTERS.m_steel.config.h_x_mult
    enhanced_prototype_centers.m_stone = G.P_CENTERS.m_stone.config.bonus
    enhanced_prototype_centers.m_gold = G.P_CENTERS.m_gold.config.h_dollars
    
    -- Save vanilla enhanced descriptions
    G.localization.descriptions.Enhanced.m_wild_bak = G.localization.descriptions.Enhanced.m_wild

end

local function setUpLocalizationTarotDX()
    
    G.localization.descriptions.Tarot_dx = {}

    G.localization.descriptions.Tarot_dx.c_fool_dx = {
        name = "The Fool DX",
        text = {
            "Creates up to {C:attention}2{} copies of",
            "the last {C:tarot}Tarot{} or {C:planet}Planet{}",
            "card used during this run",
            "{s:0.8,C:tarot}The Fool{s:0.8} excluded"
        }
    }
    G.localization.descriptions.Tarot_dx.c_magician_dx = {
        name = "The Magician DX",
        text = {
            "Enhances {C:attention}#1#{}",
            "selected cards to",
            "{C:attention}#2#s"
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
            "Enhances {C:attention}#1#",
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
            "Enhances {C:attention}#1#{} selected",
            "card into",
            "{C:attention}#2#s"
        }
    }
    G.localization.descriptions.Tarot_dx.c_chariot_dx = {
        name = "The Chariot DX",
        text = {
            "Enhances {C:attention}#1#{} selected",
            "card into",
            "{C:attention}#2#s"
        }
    }
    G.localization.descriptions.Tarot_dx.c_justice_dx = {
        name = "Justice DX",
        text = {
            "Enhances {C:attention}#1#{} selected",
            "card into",
            "{C:attention}#2#s"
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
            "Enhances {C:attention}#1#{} selected",
            "card into",
            "{C:attention}#2#s"
        }
    }
    G.localization.descriptions.Tarot_dx.c_tower_dx = {
        name = "The Tower DX",
        text = {
            "Enhances {C:attention}#1#{} selected",
            "card into",
            "{C:attention}#2#s"
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

local function setUpLocalizationTarotCU()
    
    G.localization.descriptions.Tarot_cu = {}

    G.localization.descriptions.Tarot_cu.c_fool_cu = {
        name = "The Cursed Fool",
        text = {
            "{C:dark_edition}+1{} consumable slot.",
            "Creates 2 copies of",
            "{C:tarot}The Fool{} {C:dark_edition}DX{}",
            "{C:inactive}(Must have room)"
        }
    }
    G.localization.descriptions.Tarot_cu.c_magician_cu = {
        name = "The Cursed Magician",
        text = {
            "Permanently doubles all listed",
            "{C:green}probabilities{}. Creates a",
            "copy of {C:tarot}The Magician{} {C:dark_edition}DX{}",
            "{C:inactive}(Must have room)"
        }
    }
    G.localization.descriptions.Tarot_cu.c_high_priestess_cu = {
        name = "The Cursed High Priestess",
        text = {
            "{C:planet}Planet{} cards are {C:attention}#1# times{}",
            "more likely to be {C:dark_edition}Foil{},",
            "{C:dark_edition}Holographic{}, or {C:dark_edition}Polychrome{}.",
            "Creates up to two {C:planet}Planet{} {C:dark_edition}DX{}",
            "{C:inactive}(Must have room)"
        }
    }
    G.localization.descriptions.Tarot_cu.c_empress_cu = {
        name = "The Empress DX",
        text = {
            "Permanently increases",
            "{C:attention}#2#{} bonus to",
            "{C:red}+#1#{} Mult. Creates a",
            "copy of {C:tarot}The Empress{} {C:dark_edition}DX{}",
            "{C:inactive}(Must have room)"
        }
    }
    G.localization.descriptions.Tarot_cu.c_emperor_cu = {
        name = "The Cursed Emperor",
        text = {
            "Creates {C:attention}#1#{} random",
            "{C:dark_edition}negative DX{} {C:tarot}Tarot{} cards"
        }
    }
    G.localization.descriptions.Tarot_cu.c_heirophant_cu = {
        name = "The Cursed Hierophant",
        text = {
            "Permanently increases",
            "{C:attention}#2#{} bonus to",
            "{C:blue}+#1#{} extra chips. Creates a",
            "copy of {C:tarot}The Hierophant{} {C:dark_edition}DX{}",
            "{C:inactive}(Must have room)"
        }
    }
    G.localization.descriptions.Tarot_cu.c_lovers_cu = {
        name = "The Cursed Lovers",
        text = {
            "{C:attention}#1#s{} now copy the",
            "rank of the card to their {C:attention}left{}",
            "{C:inactive}(Drag to rearrange)",
            "Creates a copy of",
            "{C:tarot}The Lovers{} {C:dark_edition}DX{}",
            "{C:inactive}(Must have room)"
        }
    }
    G.localization.descriptions.Tarot_cu.c_chariot_cu = {
        name = "The Cursed Chariot",
        text = {
            "Permanently increases",
            "{C:attention}#2#{} bonus to",
            "{X:red,C:white} X#1# {} Mult. Creates a",
            "copy of {C:tarot}The Chariot{} {C:dark_edition}DX{}",
            "{C:inactive}(Must have room)"
        }
    }
    G.localization.descriptions.Tarot_cu.c_justice_cu = {
        name = "Cursed Justice",
        text = {
            "Permanently increases",
            "{C:attention}#2#{} bonus to",
            "{X:red,C:white} X#1# {} Mult. Creates a",
            "copy of {C:tarot}Justice {C:dark_edition}DX{}",
            "{C:inactive}(Must have room)"
        }
    }
    G.localization.descriptions.Tarot_cu.c_hermit_cu = {
        name = "The Cursed Hermit",
        text = {
            "Gives {C:money}$#1#{}"
        }
    }
    G.localization.descriptions.Tarot_cu.c_wheel_of_fortune_cu = {
        name = "The Cursed Wheel of Fortune",
        text = {
            "Add {C:dark_edition}Foil{}, {C:dark_edition}Holographic{}, or",
            "{C:dark_edition}Polychrome{} edition",
            "to a random {C:attention}Jokers{}",
            "{C:green}#1# in #2#{} chance to repeat once"
        }
    }
    G.localization.descriptions.Tarot_cu.c_strength_cu = {
        name = "Cursed Strength",
        text = {
            "Select up to {C:attention}#1#{} cards,",
            "rank up {C:attention}all cards{} matching",
            "{C:attention}selected ranks{}"
        }
    }
    G.localization.descriptions.Tarot_cu.c_hanged_man_cu = {
        name = "The Cursed Hanged Man",
        text = {
            "Select up to {C:attention}#1#{} cards,",
            "destroys {C:attention}all cards{} matching",
            "{C:attention}selected ranks{}"
        }
    }
    G.localization.descriptions.Tarot_cu.c_death_cu = {
        name = "Cursed Death",
        text = {
            "Select {C:attention}#1#{} cards,",
            "convert the {C:attention}left{} cards",
            "into the {C:attention}right{} card",
            "{C:inactive}(Drag to rearrange)",
            "Creates two copies",
            "of {C:tarot}Death{} {C:dark_edition}DX{}",
            "{C:inactive}(Must have room)"
        }
    }
    G.localization.descriptions.Tarot_cu.c_temperance_cu = {
        name = "Cursed Temperance",
        text = {
            "Gives {C:money}$10{} per",
            "current Joker",
            "{C:inactive}(Max of {C:money}$#1#{C:inactive})",
            "{C:inactive}(Currently {C:money}$#2#{C:inactive})"
        }
    }
    G.localization.descriptions.Tarot_cu.c_devil_cu = {
        name = "The Cursed Devil",
        text = {
            "Permanently increases",
            "{C:attention}#2#{} gold gain to",
            "{C:money}$#1#{}. Creates a",
            "copy of {C:tarot}The Devil{} {C:dark_edition}DX{}",
            "{C:inactive}(Must have room)"
        }
    }
    G.localization.descriptions.Tarot_cu.c_tower_cu = {
        name = "The Cursed Tower",
        text = {
            "Permanently increases",
            "{C:attention}#2#{} bonus to",
            "{C:blue}+#1#{} Chips. Creates a",
            "copy of {C:tarot}The Tower{} {C:dark_edition}DX{}",
            "{C:inactive}(Must have room)"
        }
    }
    G.localization.descriptions.Tarot_cu.c_star_cu = {
        name = "The Cursed Star",
        text = {
            "{V:1}#1#{} cannot",
            "get {C:attention}debuffed{}. Creates a",
            "copy of {C:tarot}The Star{} {C:dark_edition}DX{}",
            "{C:inactive}(Must have room)"
        }
    }
    G.localization.descriptions.Tarot_cu.c_moon_cu = {
        name = "The Cursed Moon",
        text = {
            "{V:1}#1#{} cannot",
            "get {C:attention}debuffed{}. Creates a",
            "copy of {C:tarot}The Moon{} {C:dark_edition}DX{}",
            "{C:inactive}(Must have room)"
        }
    }
    G.localization.descriptions.Tarot_cu.c_sun_cu = {
        name = "The Cursed Sun",
        text = {
            "{V:1}#1#{} cannot",
            "get {C:attention}debuffed{}. Creates a",
            "copy of {C:tarot}The Sun{} {C:dark_edition}DX{}",
            "{C:inactive}(Must have room)"
        }
    }
    G.localization.descriptions.Tarot_cu.c_judgement_cu = {
        name = "Cursed Judgement",
        text = {
            "Creates a random",
            "{C:red}rare{} {C:attention}Joker{} card",
            "{C:inactive}(Must have room)"
        }
    }
    G.localization.descriptions.Tarot_cu.c_world_cu = {
        name = "The Cursed World",
        text = {
            "{V:1}#1#{} cannot",
            "get {C:attention}debuffed{}. Creates a",
            "copy of {C:tarot}The World{} {C:dark_edition}DX{}",
            "{C:inactive}(Must have room)"
        }
    }
end

local function setUpLocalizationPlanetDX()

    G.localization.descriptions.Planet_dx = {}

    G.localization.descriptions.Planet_dx.c_mercury_dx = {
        name = "Mercury DX",
        text = {
            "{s:0.8}({s:0.8,V:1}lvl.#1#{s:0.8}){} Level up {C:dark_edition}x2{}",
            "{C:attention}#2#",
            "{C:mult}+#3#{} Mult and",
            "{C:chips}+#4#{} chips"
        }
    }
    G.localization.descriptions.Planet_dx.c_venus_dx = {
        name = "Venus DX",
        text = {
            "{s:0.8}({s:0.8,V:1}lvl.#1#{s:0.8}){} Level up {C:dark_edition}x2{}",
            "{C:attention}#2#",
            "{C:mult}+#3#{} Mult and",
            "{C:chips}+#4#{} chips"
        }
    }
    G.localization.descriptions.Planet_dx.c_earth_dx = {
        name = "Earth DX",
        text = {
            "{s:0.8}({s:0.8,V:1}lvl.#1#{s:0.8}){} Level up {C:dark_edition}x2{}",
            "{C:attention}#2#",
            "{C:mult}+#3#{} Mult and",
            "{C:chips}+#4#{} chips"
        }
    }
    G.localization.descriptions.Planet_dx.c_mars_dx = {
        name = "Mars DX",
        text = {
            "{s:0.8}({s:0.8,V:1}lvl.#1#{s:0.8}){} Level up {C:dark_edition}x2{}",
            "{C:attention}#2#",
            "{C:mult}+#3#{} Mult and",
            "{C:chips}+#4#{} chips"
        }
    }
    G.localization.descriptions.Planet_dx.c_jupiter_dx = {
        name = "Jupiter DX",
        text = {
            "{s:0.8}({s:0.8,V:1}lvl.#1#{s:0.8}){} Level up {C:dark_edition}x2{}",
            "{C:attention}#2#",
            "{C:mult}+#3#{} Mult and",
            "{C:chips}+#4#{} chips"
        }
    }
    G.localization.descriptions.Planet_dx.c_saturn_dx = {
        name = "Saturn DX",
        text = {
            "{s:0.8}({s:0.8,V:1}lvl.#1#{s:0.8}){} Level up {C:attention}x2{}",
            "{C:attention}#2#",
            "{C:mult}+#3#{} Mult and",
            "{C:chips}+#4#{} chips"
        }
    }
    G.localization.descriptions.Planet_dx.c_uranus_dx = {
        name = "Uranus DX",
        text = {
            "{s:0.8}({s:0.8,V:1}lvl.#1#{s:0.8}){} Level up {C:dark_edition}x2{}",
            "{C:attention}#2#",
            "{C:mult}+#3#{} Mult and",
            "{C:chips}+#4#{} chips"
        }
    }
    G.localization.descriptions.Planet_dx.c_neptune_dx = {
        name = "Neptune DX",
        text = {
            "{s:0.8}({s:0.8,V:1}lvl.#1#{s:0.8}){} Level up {C:dark_edition}x2{}",
            "{C:attention}#2#",
            "{C:mult}+#3#{} Mult and",
            "{C:chips}+#4#{} chips"
        }
    }
    G.localization.descriptions.Planet_dx.c_pluto_dx = {
        name = "Pluto DX",
        text = {
            "{s:0.8}({s:0.8,V:1}lvl.#1#{s:0.8}){} Level up {C:dark_edition}x2{}",
            "{C:attention}#2#",
            "{C:mult}+#3#{} Mult and",
            "{C:chips}+#4#{} chips"
        }
    }
    G.localization.descriptions.Planet_dx.c_ceres_dx = {
        name = "Ceres DX",
        text = {
            "{s:0.8}({s:0.8,V:1}lvl.#1#{s:0.8}){} Level up {C:dark_edition}x2{}",
            "{C:attention}#2#",
            "{C:mult}+#3#{} Mult and",
            "{C:chips}+#4#{} chips"
        }
    }
    G.localization.descriptions.Planet_dx.c_planet_x_dx = {
        name = "Planet X DX",
        text = {
            "{s:0.8}({s:0.8,V:1}lvl.#1#{s:0.8}){} Level up {C:dark_edition}x2{}",
            "{C:attention}#2#",
            "{C:mult}+#3#{} Mult and",
            "{C:chips}+#4#{} chips"
        }
    }
    G.localization.descriptions.Planet_dx.c_eris_dx = {
        name = "Eris DX",
        text = {
            "{s:0.8}({s:0.8,V:1}lvl.#1#{s:0.8}){} Level up {C:dark_edition}x2{}",
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
            "a random {C:attention}Joker,",
            "destroys {C:attention}all{} consumables"
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
            "to up to {C:attention}3{} selected",
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

local function setUpLocalizationBoosterDX()

    G.localization.descriptions.Other.p_arcana_normal_dx = {
        name = "Arcana Pack DX",
        text = {
            "Choose {C:attention}#1#{} of up to",
            "{C:attention}#2#{C:tarot} Tarot{} cards to",
            "be used immediately",
            "{C:inactive}(You feel lucky...)"
        }
    }
    G.localization.descriptions.Other.p_arcana_jumbo_dx = {
        name = "Jumbo Arcana Pack DX",
        text = {
            "Choose {C:attention}#1#{} of up to",
            "{C:attention}#2#{C:tarot} Tarot{} cards to",
            "be used immediately",
            "{C:inactive}(You feel lucky...)"
        }
    }
    G.localization.descriptions.Other.p_arcana_mega_dx = {
        name = "Mega Arcana Pack DX",
        text = {
            "Choose {C:attention}#1#{} of up to",
            "{C:attention}#2#{C:tarot} Tarot{} cards to",
            "be used immediately",
            "{C:inactive}(You feel lucky...)"
        }
    }
    G.localization.descriptions.Other.p_celestial_normal_dx = {
        name = "Celestial Pack DX",
        text = {
            "Choose {C:attention}#1#{} of up to",
            "{C:attention}#2#{C:planet} Planet{} cards to",
            "be used immediately",
            "{C:inactive}(You feel lucky...)"
        }
    }
    G.localization.descriptions.Other.p_celestial_jumbo_dx = {
        name = "Jumbo Celestial Pack DX",
        text = {
            "Choose {C:attention}#1#{} of up to",
            "{C:attention}#2#{C:planet} Planet{} cards to",
            "be used immediately",
            "{C:inactive}(You feel lucky...)"
        }
    }
    G.localization.descriptions.Other.p_celestial_mega_dx = {
        name = "Mega Celestial Pack DX",
        text = {
            "Choose {C:attention}#1#{} of up to",
            "{C:attention}#2#{C:planet} Planet{} cards to",
            "be used immediately",
            "{C:inactive}(You feel lucky...)"
        }
    }
    G.localization.descriptions.Other.p_spectral_normal_dx = {
        name = "Spectral Pack DX",
        text = {
            "Choose {C:attention}#1#{} of up to",
            "{C:attention}#2#{C:spectral} Spectral{} cards to",
            "be used immediately",
            "{C:inactive}(You feel lucky...)"
        }
    }
    G.localization.descriptions.Other.p_spectral_jumbo_dx = {
        name = "Jumbo Spectral Pack DX",
        text = {
            "Choose {C:attention}#1#{} of up to",
            "{C:attention}#2#{C:spectral} Spectral{} cards to",
            "be used immediately",
            "{C:inactive}(You feel lucky...)"
        }
    }
    G.localization.descriptions.Other.p_spectral_mega_dx = {
        name = "Mega Spectral Pack DX",
        text = {
            "Choose {C:attention}#1#{} of up to",
            "{C:attention}#2#{C:spectral} Spectral{} cards to",
            "be used immediately",
            "{C:inactive}(You feel lucky...)"
        }
    }
    G.localization.descriptions.Other.p_standard_normal_dx = {
        name = "Standard Pack DX",
        text = {
            "Choose {C:attention}#1#{} of up to",
            "{C:attention}#2#{C:attention} Playing{} cards to",
            "add to your deck",
            "{C:inactive}(You feel lucky...)"
        }
    }
    G.localization.descriptions.Other.p_standard_jumbo_dx = {
        name = "Jumbo Standard Pack DX",
        text = {
            "Choose {C:attention}#1#{} of up to",
            "{C:attention}#2#{C:attention} Playing{} cards to",
            "add to your deck",
            "{C:inactive}(You feel lucky...)"
        }
    }
    G.localization.descriptions.Other.p_standard_mega_dx = {
        name = "Mega Standard Pack DX",
        text = {
            "Choose {C:attention}#1#{} of up to",
            "{C:attention}#2#{C:attention} Playing{} cards to",
            "add to your deck",
            "{C:inactive}(You feel lucky...)"
        }
    }
    G.localization.descriptions.Other.p_buffoon_normal_dx = {
        name = "Buffoon Pack DX",
        text = {
            "Choose {C:attention}#1#{} of up to",
            "{C:attention}#2#{C:joker} Joker{} cards",
            "{C:inactive}(You feel lucky...)"
        }
    }
    G.localization.descriptions.Other.p_buffoon_jumbo_dx = {
        name = "Jumbo Buffoon Pack DX",
        text = {
            "Choose {C:attention}#1#{} of up to",
            "{C:attention}#2#{C:joker} Joker{} cards",
            "{C:inactive}(You feel lucky...)"
        }
    }
    G.localization.descriptions.Other.p_buffoon_mega_dx = {
        name = "Mega Buffoon Pack DX",
        text = {
            "Choose {C:attention}#1#{} of up to",
            "{C:attention}#2#{C:joker} Joker{} cards",
            "{C:inactive}(You feel lucky...)"
        }
    }
end

local function setUpLocalizationEnhanced()
    
    G.localization.descriptions.Enhanced.m_wild_cu = {
        name = "Wild Card",
        text = {
            "Can be used",
            "as any suit",
            "Copy rank of",
            "its left card"
        }
    }
end

-- Should be called after everithing was overrided...
local function loadCursesModule()

    local js_mod = SMODS.findModByID("JeffDeluxeConsumablesPack")

    -- Load modules
    assert(load(NFS.read(js_mod.path .. "source/curse.lua")))()
    
    -- Add curses
    setup_curses()
end

local function loadCodexArcanumModule()

    if SMODS.findModByID("CodexArcanum") then
        local js_mod = SMODS.findModByID("JeffDeluxeConsumablesPack")

        -- Load modules
        assert(load(NFS.read(js_mod.path .. "source/alchemical_dx.lua")))()
        
        -- Add new dx stuff
        CodexArcanum.LoadDX()
    end
end

---------- mod init ----------

local function overrides()

    ---------- game ----------

    -- Track cursed tarots usage
    local Game_init_game_object_ref = Game.init_game_object
    function Game.init_game_object(self)

        local ret = Game_init_game_object_ref(self)
        ret.used_cu_augments = {}
        return ret
    end

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
            for k, v in pairs(G.playing_cards) do
                if v.config.center_key == G.P_CENTERS.c_empress_cu.config.mod_conv then v:set_ability(G.P_CENTERS[G.P_CENTERS.c_empress_cu.config.mod_conv]) end
            end
        end
        
        if G.GAME.used_cu_augments and G.GAME.used_cu_augments.c_heirophant_cu then
            G.P_CENTERS.m_bonus.config.bonus = G.P_CENTERS.m_bonus.config.bonus + (G.P_CENTERS.c_heirophant_cu.config.extra * G.GAME.used_cu_augments.c_heirophant_cu)
            for k, v in pairs(G.playing_cards) do
                if v.config.center_key == G.P_CENTERS.c_heirophant_cu.config.mod_conv then v:set_ability(G.P_CENTERS[G.P_CENTERS.c_heirophant_cu.config.mod_conv]) end
            end
        end
        
        if G.GAME.used_cu_augments and G.GAME.used_cu_augments.c_lovers_cu then
            G.localization.descriptions.Enhanced.m_wild = G.localization.descriptions.Enhanced.m_wild_cu
        end
        
        if G.GAME.used_cu_augments and G.GAME.used_cu_augments.c_chariot_cu then
            G.P_CENTERS.m_steel.config.h_x_mult = G.P_CENTERS.m_steel.config.h_x_mult + (G.P_CENTERS.c_chariot_cu.config.extra * G.GAME.used_cu_augments.c_chariot_cu)
            for k, v in pairs(G.playing_cards) do
                if v.config.center_key == G.P_CENTERS.c_chariot_cu.config.mod_conv then v:set_ability(G.P_CENTERS[G.P_CENTERS.c_chariot_cu.config.mod_conv]) end
            end
        end
        
        if G.GAME.used_cu_augments and G.GAME.used_cu_augments.c_justice_cu then
            G.P_CENTERS.m_glass.config.Xmult = G.P_CENTERS.m_glass.config.Xmult + (G.P_CENTERS.c_justice_cu.config.extra * G.GAME.used_cu_augments.c_justice_cu)
            for k, v in pairs(G.playing_cards) do
                if v.config.center_key == G.P_CENTERS.c_justice_cu.config.mod_conv then v:set_ability(G.P_CENTERS[G.P_CENTERS.c_justice_cu.config.mod_conv]) end
            end
        end
        
        if G.GAME.used_cu_augments and G.GAME.used_cu_augments.c_devil_cu then
            G.P_CENTERS.m_gold.config.h_dollars = G.P_CENTERS.m_gold.config.h_dollars + (G.P_CENTERS.c_devil_cu.config.extra * G.GAME.used_cu_augments.c_devil_cu)
            for k, v in pairs(G.playing_cards) do
                if v.config.center_key == G.P_CENTERS.c_devil_cu.config.mod_conv then v:set_ability(G.P_CENTERS[G.P_CENTERS.c_devil_cu.config.mod_conv]) end
            end
        end
        
        if G.GAME.used_cu_augments and G.GAME.used_cu_augments.c_tower_cu then
            G.P_CENTERS.m_stone.config.bonus = G.P_CENTERS.m_stone.config.bonus + (G.P_CENTERS.c_tower_cu.config.extra * G.GAME.used_cu_augments.c_tower_cu)
            for k, v in pairs(G.playing_cards) do
                if v.config.center_key == G.P_CENTERS.c_tower_cu.config.mod_conv then v:set_ability(G.P_CENTERS[G.P_CENTERS.c_tower_cu.config.mod_conv]) end
            end
        end
    end
        
    ---------- misc_functions ----------

    -- Manage consumable usage
    local set_consumeable_usage_ref = set_consumeable_usage
    function set_consumeable_usage(card)

        set_consumeable_usage_ref(card)

        -- Last consumable used, set it to vanilla version
        if card.config.center_key and card.ability.consumeable and (card.config.center.set == 'Tarot' or card.config.center.set == 'Planet') and (card.ability.type == '_dx' or card.ability.type == '_cu') then 
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

    ---------- button_callbacks ----------

    -- Manage Ankh DX
    local G_FUNCS_buy_from_shop_ref = G.FUNCS.buy_from_shop
    function G.FUNCS.buy_from_shop(e)

        local c1 = e.config.ref_table
        if c1 and c1:is(Card) and c1.ability.name == 'Ankh DX' and e.config.id == 'buy_and_use' then
            if #G.jokers.cards >= G.jokers.config.card_limit then  
                alert_no_space(c1, G.jokers)
                e.disable_button = nil
                return false
            end
        end

        return G_FUNCS_buy_from_shop_ref(e)
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
                        if v.name == 'Black Hole DX' or v.name == 'The Soul DX' or v.name == "Philosopher's Stone DX" then
                            add = false
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
        if forced_key and _type == 'Planet' and G.GAME.used_vouchers.v_telescope and G.STATE == G.STATES.PLANET_PACK and (pseudorandom('upgrade_card'..G.GAME.round_resets.ante) > math.min(1, math.max(0, 1 - planet_dx_rate))) then
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
            if new_type == 'Tarot' and (pseudorandom('upgrade_card'..G.GAME.round_resets.ante) > math.min(1, math.max(0, 1 - tarot_dx_rate))) then new_type = "Tarot_dx" end
            if ((new_type == 'Tarot') or (new_type == 'Tarot_dx')) and (pseudorandom('upgrade_card'..G.GAME.round_resets.ante) > math.min(1, math.max(0, 1 - tarot_cu_rate))) then new_type = "Tarot_cu" end
            if new_type == 'Planet' and (pseudorandom('upgrade_card'..G.GAME.round_resets.ante) > math.min(1, math.max(0, 1 - planet_dx_rate))) then new_type = "Planet_dx" end
            if new_type == 'Spectral' and (pseudorandom('upgrade_card'..G.GAME.round_resets.ante) > math.min(1, math.max(0, 1 - spectral_dx_rate))) then new_type = "Spectral_dx" end
            if new_type == 'Alchemical' and (pseudorandom('upgrade_card'..G.GAME.round_resets.ante) > math.min(1, math.max(0, 1 - alchemical_dx_rate))) then new_type = "Alchemical_dx" end

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
                if (new_type == 'Alchemical_dx' or new_type == 'Spectral_dx') and
                not (G.GAME.used_jokers['c_philosopher_stone_dx'] and not next(find_joker("Showman")))  then
                    if pseudorandom('soul_'.._type..G.GAME.round_resets.ante) > 0.997 then
                        new_forced_key = 'c_philosopher_stone_dx'
                    end
                end
            end
        end

        local created_card = create_card_ref(new_type, area, legendary, _rarity, skip_materialize, soulable, new_forced_key, key_append)

        -- manage unique cards
        if unique_enabled and created_card.config and created_card.config.center and created_card.config.center.config and created_card.config.center.config.unique and created_card.config.center_key then
            G.GAME.banned_keys[created_card.config.center_key] = true
        end

        -- poll planet edition if it is enabled
        if planet_edition_enabled then
            if (_type == 'Planet' or _type == 'Planet_dx') and created_card.ability.consumeable and created_card.ability.consumeable.hand_type then
                local mod = math.max(1, 1 + (0.07 * math.min(7, G.GAME.hands[created_card.ability.consumeable.hand_type].level))) or 1
                if G.GAME.used_cu_augments and G.GAME.used_cu_augments.c_high_priestess_cu then mod = mod * G.P_CENTERS.c_high_priestess_cu.config.prob_mult end
                local edition = poll_edition('edi'..(key_append or '')..G.GAME.round_resets.ante, mod, true)
                created_card:set_edition(edition)
                check_for_unlock({type = 'have_edition'})
            end
            if created_card.ability.name == 'Black Hole' or created_card.ability.name == 'Black Hole DX' then
                local mod = 1
                if G.GAME.used_cu_augments and G.GAME.used_cu_augments.c_high_priestess_cu then mod = mod * G.P_CENTERS.c_high_priestess_cu.config.prob_mult end
                local edition = poll_edition('edi'..(key_append or '')..G.GAME.round_resets.ante, mod, true)
                created_card:set_edition(edition)
                check_for_unlock({type = 'have_edition'})
            end
        end

        return created_card
    end

    -- Set a chance to change pool from normal to DX
    local get_pack_ref = get_pack
    function get_pack(_key, _type)

        if (pseudorandom('dx_booster'..G.GAME.round_resets.ante) > math.min(1, math.max(0, 1 - booster_dx_rate))) then
            local cume, it, center = 0, 0, nil
            for k, v in ipairs(G.P_CENTER_POOLS['Booster_dx']) do
                if (not _type or _type == v.kind) and not G.GAME.banned_keys[v.key] then cume = cume + (v.weight or 1 ) end
            end
            local poll = pseudorandom(pseudoseed((_key or 'pack_generic')..G.GAME.round_resets.ante))*cume
            for k, v in ipairs(G.P_CENTER_POOLS['Booster_dx']) do
                if not G.GAME.banned_keys[v.key] then 
                    if not _type or _type == v.kind then it = it + (v.weight or 1) end
                    if it >= poll and it - (v.weight or 1) <= poll then
                        center = v
                        G.GAME.banned_keys[v.key] = true
                        break
                    end
                end
            end
            if center ~= nil then
                return center
            end
        end
        return get_pack_ref(_key, _type)
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
                
                if card and card.ability and card.ability.set and card.ability.type == '_dx' then
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
        
        local first_pass = nil
        first_pass = not full_UI_table
        local info_queue = {}

        -- Add custom badges
        if first_pass and badges then
            if _c.config.type == '_dx' then
                -- Add the DX badge
                badges[#badges + 1] = 'dx'
            end

            if _c.config.unique and unique_enabled then
                -- Add the Unique badge
                badges[#badges + 1] = 'unique'
            end

            if card_type == 'Enhanced' or card_type == 'Default' then
                if specific_vars.suit == 'Diamonds' and G.GAME.used_cu_augments and G.GAME.used_cu_augments.c_star_cu then
                    badges[#badges + 1] = 'star_bu'
                elseif specific_vars.suit == 'Clubs' and G.GAME.used_cu_augments and G.GAME.used_cu_augments.c_moon_cu then
                    badges[#badges + 1] = 'moon_bu'
                elseif specific_vars.suit == 'Hearts' and G.GAME.used_cu_augments and G.GAME.used_cu_augments.c_sun_cu then
                    badges[#badges + 1] = 'sun_bu'
                elseif specific_vars.suit == 'Spades' and G.GAME.used_cu_augments and G.GAME.used_cu_augments.c_world_cu then
                    badges[#badges + 1] = 'world_bu'
                end
            end
        end

        if _c.config and (_c.config.type == '_dx' or _c.config.type == '_cu') and (_c.atlas == 'Van_dx' or _c.atlas == 'Van_cu' or _c.atlas == 'Van_Booster_dx') then    -- Overwrite

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
            
            if _c.set == 'Booster' then 
                local desc_override = 'p_arcana_normal_dx'
                if _c.name == 'Arcana Pack DX' then desc_override = 'p_arcana_normal_dx'; loc_vars = {_c.config.choose, _c.config.extra}
                elseif _c.name == 'Jumbo Arcana Pack DX' then desc_override = 'p_arcana_jumbo_dx'; loc_vars = {_c.config.choose, _c.config.extra}
                elseif _c.name == 'Mega Arcana Pack DX' then desc_override = 'p_arcana_mega_dx'; loc_vars = {_c.config.choose, _c.config.extra}
                elseif _c.name == 'Celestial Pack DX' then desc_override = 'p_celestial_normal_dx'; loc_vars = {_c.config.choose, _c.config.extra}
                elseif _c.name == 'Jumbo Celestial Pack DX' then desc_override = 'p_celestial_jumbo_dx'; loc_vars = {_c.config.choose, _c.config.extra}
                elseif _c.name == 'Mega Celestial Pack DX' then desc_override = 'p_celestial_mega_dx'; loc_vars = {_c.config.choose, _c.config.extra}
                elseif _c.name == 'Spectral Pack DX' then desc_override = 'p_spectral_normal_dx'; loc_vars = {_c.config.choose, _c.config.extra}
                elseif _c.name == 'Jumbo Spectral Pack DX' then desc_override = 'p_spectral_jumbo_dx'; loc_vars = {_c.config.choose, _c.config.extra}
                elseif _c.name == 'Mega Spectral Pack DX' then desc_override = 'p_spectral_mega_dx'; loc_vars = {_c.config.choose, _c.config.extra}
                elseif _c.name == 'Standard Pack DX' then desc_override = 'p_standard_normal_dx'; loc_vars = {_c.config.choose, _c.config.extra}
                elseif _c.name == 'Jumbo Standard Pack DX' then desc_override = 'p_standard_jumbo_dx'; loc_vars = {_c.config.choose, _c.config.extra}
                elseif _c.name == 'Mega Standard Pack DX' then desc_override = 'p_standard_mega_dx'; loc_vars = {_c.config.choose, _c.config.extra}
                elseif _c.name == 'Buffoon Pack DX' then desc_override = 'p_buffoon_normal_dx'; loc_vars = {_c.config.choose, _c.config.extra}
                elseif _c.name == 'Jumbo Buffoon Pack DX' then desc_override = 'p_buffoon_jumbo_dx'; loc_vars = {_c.config.choose, _c.config.extra}
                elseif _c.name == 'Mega Buffoon Pack DX' then desc_override = 'p_buffoon_mega_dx'; loc_vars = {_c.config.choose, _c.config.extra}
                end
                name_override = desc_override
                if not full_UI_table.name then full_UI_table.name = localize{type = 'name', set = 'Other', key = name_override, nodes = full_UI_table.name} end
                localize{type = 'other', key = desc_override, nodes = desc_nodes, vars = loc_vars}
            elseif _c.set == 'Spectral' then 
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
                localize{type = 'descriptions', key = _c.key, set = _c.set.._c.config.type, nodes = desc_nodes, vars = loc_vars}
            elseif _c.set == 'Planet' then
                loc_vars = {
                    G.GAME.hands[_c.config.hand_type].level,localize(_c.config.hand_type, 'poker_hands'), G.GAME.hands[_c.config.hand_type].l_mult * 2, G.GAME.hands[_c.config.hand_type].l_chips * 2,
                    colours = {(G.GAME.hands[_c.config.hand_type].level==1 and G.C.UI.TEXT_DARK or G.C.HAND_LEVELS[math.min(7, G.GAME.hands[_c.config.hand_type].level)])}
                }
                localize{type = 'descriptions', key = _c.key, set = _c.set.._c.config.type, nodes = desc_nodes, vars = loc_vars}
            elseif _c.set == 'Tarot' then
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

                elseif _c.name == "The Cursed Fool" then
                    local fool_c = G.P_CENTERS["c_fool_dx"] or nil
                    local created_card = fool_c and localize{type = 'name_text', key = fool_c.key, set = fool_c.set..fool_c.config.type} or localize('k_none')
                    loc_vars = {created_card}
                    if fool_c then
                        info_queue[#info_queue+1] = fool_c
                    end
                elseif _c.name == "The Cursed Magician" then
                    local fool_c = G.P_CENTERS["c_magician_dx"] or nil
                    local created_card = fool_c and localize{type = 'name_text', key = fool_c.key, set = fool_c.set..fool_c.config.type} or localize('k_none')
                loc_vars = {created_card}
                if fool_c then
                        info_queue[#info_queue+1] = fool_c
                end
                elseif _c.name == "The Cursed High Priestess" then loc_vars = {_c.config.prob_mult}; info_queue[#info_queue+1] = G.P_CENTERS.e_foil; info_queue[#info_queue+1] = G.P_CENTERS.e_holo; info_queue[#info_queue+1] = G.P_CENTERS.e_polychrome; 
                elseif _c.name == "The Cursed Empress" then
                    local fool_c = G.P_CENTERS["c_empress_dx"] or nil
                    local created_card = fool_c and localize{type = 'name_text', key = fool_c.key, set = fool_c.set..fool_c.config.type} or localize('k_none')
                if fool_c then
                        info_queue[#info_queue+1] = fool_c
                end
                    loc_vars = {G.P_CENTERS.m_mult.config.mult + _c.config.extra, localize{type = 'name_text', set = 'Enhanced', key = _c.config.mod_conv, created_card}};
                elseif _c.name == "The Cursed Emperor" then
                    info_queue[#info_queue+1] = {key = 'e_negative_consumable', set = 'Edition', config = {extra = 1}}
                    loc_vars = {_c.config.tarots}
                elseif _c.name == "The Cursed Hierophant" then
                    local fool_c = G.P_CENTERS["c_heirophant_dx"] or nil
                    local created_card = fool_c and localize{type = 'name_text', key = fool_c.key, set = fool_c.set..fool_c.config.type} or localize('k_none')
                if fool_c then
                        info_queue[#info_queue+1] = fool_c
                end
                    loc_vars = {G.P_CENTERS.m_bonus.config.bonus + _c.config.extra, localize{type = 'name_text', set = 'Enhanced', key = _c.config.mod_conv}}
                elseif _c.name == "The Cursed Lovers" then
                    local fool_c = G.P_CENTERS["c_lovers_dx"] or nil
                    local created_card = fool_c and localize{type = 'name_text', key = fool_c.key, set = fool_c.set..fool_c.config.type} or localize('k_none')
                if fool_c then
                        info_queue[#info_queue+1] = fool_c
                end
                loc_vars = {localize{type = 'name_text', set = 'Enhanced', key = _c.config.mod_conv}}
                elseif _c.name == "The Cursed Chariot" then
                    local fool_c = G.P_CENTERS["c_chariot_dx"] or nil
                    local created_card = fool_c and localize{type = 'name_text', key = fool_c.key, set = fool_c.set..fool_c.config.type} or localize('k_none')
                if fool_c then
                        info_queue[#info_queue+1] = fool_c
                end
                loc_vars = {G.P_CENTERS.m_steel.config.h_x_mult + _c.config.extra, localize{type = 'name_text', set = 'Enhanced', key = _c.config.mod_conv}}
                elseif _c.name == "Cursed Justice" then
                    local fool_c = G.P_CENTERS["c_justice_dx"] or nil
                    local created_card = fool_c and localize{type = 'name_text', key = fool_c.key, set = fool_c.set..fool_c.config.type} or localize('k_none')
                if fool_c then
                        info_queue[#info_queue+1] = fool_c
                end
                loc_vars = {G.P_CENTERS.m_glass.config.Xmult + _c.config.extra, localize{type = 'name_text', set = 'Enhanced', key = _c.config.mod_conv}}
                elseif _c.name == "The Cursed Hermit" then loc_vars = {_c.config.extra}
                elseif _c.name == "The Cursed Wheel of Fortune" then loc_vars = {G.GAME.probabilities.normal, _c.config.extra}; info_queue[#info_queue+1] = G.P_CENTERS.e_foil; info_queue[#info_queue+1] = G.P_CENTERS.e_holo; info_queue[#info_queue+1] = G.P_CENTERS.e_polychrome; 
                elseif _c.name == "Cursed Strength" then loc_vars = {_c.config.max_highlighted}
                elseif _c.name == "The Cursed Hanged Man" then loc_vars = {_c.config.max_highlighted}
                elseif _c.name == "Cursed Death" then
                    local fool_c = G.P_CENTERS["c_death_dx"] or nil
                    local created_card = fool_c and localize{type = 'name_text', key = fool_c.key, set = fool_c.set..fool_c.config.type} or localize('k_none')
                if fool_c then
                        info_queue[#info_queue+1] = fool_c
                end
                loc_vars = {_c.config.max_highlighted}
                elseif _c.name == "Cursed Temperance" then
                local _money = 0
                if G.jokers then
                    for i = 1, #G.jokers.cards do
                        if G.jokers.cards[i].ability.set == 'Joker' then
                            _money = _money + 10
                        end
                    end
                end
                loc_vars = {_c.config.extra, math.min(_c.config.extra, _money)}
                elseif _c.name == "The Cursed Devil" then
                    local fool_c = G.P_CENTERS["c_devil_dx"] or nil
                    local created_card = fool_c and localize{type = 'name_text', key = fool_c.key, set = fool_c.set..fool_c.config.type} or localize('k_none')
                if fool_c then
                        info_queue[#info_queue+1] = fool_c
                end
                loc_vars = {G.P_CENTERS.m_gold.config.h_dollars + _c.config.extra, localize{type = 'name_text', set = 'Enhanced', key = _c.config.mod_conv}}
                elseif _c.name == "The Cursed Tower" then
                    local fool_c = G.P_CENTERS["c_tower_dx"] or nil
                    local created_card = fool_c and localize{type = 'name_text', key = fool_c.key, set = fool_c.set..fool_c.config.type} or localize('k_none')
                if fool_c then
                        info_queue[#info_queue+1] = fool_c
                end
                loc_vars = {G.P_CENTERS.m_stone.config.bonus + _c.config.extra, localize{type = 'name_text', set = 'Enhanced', key = _c.config.mod_conv}}
                elseif _c.name == "The Cursed Star" then
                    local fool_c = G.P_CENTERS["c_star_dx"] or nil
                    local created_card = fool_c and localize{type = 'name_text', key = fool_c.key, set = fool_c.set..fool_c.config.type} or localize('k_none')
                if fool_c then
                        info_queue[#info_queue+1] = fool_c
                end
                loc_vars = {localize(_c.config.suit_conv, 'suits_plural'), colours = {G.C.SUITS[_c.config.suit_conv]}}
                elseif _c.name == "The Cursed Moon" then
                    local fool_c = G.P_CENTERS["c_moon_dx"] or nil
                    local created_card = fool_c and localize{type = 'name_text', key = fool_c.key, set = fool_c.set..fool_c.config.type} or localize('k_none')
                if fool_c then
                        info_queue[#info_queue+1] = fool_c
                end
                loc_vars = {localize(_c.config.suit_conv, 'suits_plural'), colours = {G.C.SUITS[_c.config.suit_conv]}}
                elseif _c.name == "The Cursed Sun" then
                    local fool_c = G.P_CENTERS["c_sun_dx"] or nil
                    local created_card = fool_c and localize{type = 'name_text', key = fool_c.key, set = fool_c.set..fool_c.config.type} or localize('k_none')
                if fool_c then
                        info_queue[#info_queue+1] = fool_c
                end
                loc_vars = {localize(_c.config.suit_conv, 'suits_plural'), colours = {G.C.SUITS[_c.config.suit_conv]}}
                elseif _c.name == "Cursed Judgement" then
                elseif _c.name == "The Cursed World" then
                    local fool_c = G.P_CENTERS["c_world_dx"] or nil
                    local created_card = fool_c and localize{type = 'name_text', key = fool_c.key, set = fool_c.set..fool_c.config.type} or localize('k_none')
                if fool_c then
                        info_queue[#info_queue+1] = fool_c
                end
                loc_vars = {localize(_c.config.suit_conv, 'suits_plural'), colours = {G.C.SUITS[_c.config.suit_conv]}}
                end
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
                    if v == 'dx' then info_queue[#info_queue+1] = {key = 'dx', set = 'Other'} end
                    if v == 'unique' then info_queue[#info_queue+1] = {key = 'unique', set = 'Other'} end
                end
            end

            for _, v in ipairs(info_queue) do
                generate_card_ui(v, full_UI_table)
            end
        
            return full_UI_table

        else    -- Do not overwrite
            local ret = generate_card_ui_ref(_c, full_UI_table, specific_vars, card_type, badges, hide_desc, main_start, main_end)

            -- Add extra badges info
            if first_pass and badges then
                for k, v in ipairs(badges) do
                    if v == 'dx' then info_queue[#info_queue+1] = {key = 'dx', set = 'Other'} end
                    if v == 'unique' then info_queue[#info_queue+1] = {key = 'unique', set = 'Other'} end
                end
                for _, v in ipairs(info_queue) do
                    generate_card_ui(v, ret)
                end
            end

            return ret
        end
    end

    -- Manage Standard Pack UI if DX
    local create_UIBox_standard_pack_ref = create_UIBox_standard_pack
    function create_UIBox_standard_pack()
        
        local ret = create_UIBox_standard_pack_ref()
    
        local _size = G.GAME.pack_size
        if _size >= 6 then
            G.pack_cards:hard_set_T(G.pack_cards.X, G.pack_cards.Y, _size*G.CARD_W, G.pack_cards.H)
        end

        return ret
    end

    -- Manage Celestial Pack UI if DX
    local create_UIBox_celestial_pack_ref = create_UIBox_celestial_pack
    function create_UIBox_celestial_pack()
        
        local ret = create_UIBox_celestial_pack_ref()
    
        local _size = G.GAME.pack_size
        if _size >= 6 then
            G.pack_cards:hard_set_T(G.pack_cards.X, G.pack_cards.Y, _size*G.CARD_W, G.pack_cards.H)
        end

        return ret
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

    -- Manage usage of DX consumables
    local card_use_consumeable_ref = Card.use_consumeable
    function Card.use_consumeable(self, area, copier)
        if self.ability.type == '_dx' and self.config.center and self.config.center.atlas == 'Van_dx' then  -- Manage DX
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
                            update_hand_text({delay = 0}, {chips = '+' .. tostring(G.P_CENTERS.e_foil.config.extra), StatusText = true})
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
                            local _first_dissolve = nil
                            for k, v in ipairs(G.consumeables.cards) do
                                if v.start_dissolve and not v.ability.eternal then v:start_dissolve(nil, _first_dissolve);_first_dissolve = true end
                            end
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
            update_hand_text({sound = 'button', volume = 0.7, pitch = 0.9, delay = 0}, {level='+1'})
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

        elseif self.ability.type == '_cu' and self.config.center and self.config.center.atlas == 'Van_cu' then      -- Manage curses
            stop_use()
            if not copier then set_consumeable_usage(self) end
            if self.debuff then return nil end
            local used_tarot = copier or self

            G.GAME.used_cu_augments[self.config.center_key] = (G.GAME.used_cu_augments[self.config.center_key] or 0) + 1
        
            if self.ability.consumeable.max_highlighted then
                update_hand_text({immediate = true, nopulse = true, delay = 0}, {mult = 0, chips = 0, level = '', handname = ''})
            end

            if self.ability.name == 'The Cursed Fool' then
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
            end

            if self.ability.name == 'The Cursed Magician' then
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
            end

            if self.ability.name == 'The Cursed High Priestess' then
                for i = 1, math.min(self.ability.consumeable.planets, G.consumeables.config.card_limit - #G.consumeables.cards) do
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
            end

            if self.ability.name == 'The Cursed Empress' then
                G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
                    if G.consumeables.config.card_limit > #G.consumeables.cards then
                        play_sound('timpani')
                        if G.consumeables.config.card_limit > #G.consumeables.cards then 
                            local card = create_card('Tarot_dx', G.consumeables, nil, nil, nil, nil, 'c_empress_dx', 'empress')
                            card:add_to_deck()
                            G.consumeables:emplace(card)
                        end
                        G.P_CENTERS.m_mult.config.mult = G.P_CENTERS.m_mult.config.mult + self.ability.extra
                        for k, v in pairs(G.playing_cards) do
                            if v.config.center_key == self.ability.consumeable.mod_conv then v:set_ability(G.P_CENTERS[self.ability.consumeable.mod_conv]) end
                        end
                        used_tarot:juice_up(0.3, 0.5)
                    end
                return true end }))
            end

            if self.ability.name == 'The Cursed Emperor' then
                for i = 1, self.ability.consumeable.tarots do
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
            end

            if self.ability.name == 'The Cursed Hierophant' then
                G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
                    if G.consumeables.config.card_limit > #G.consumeables.cards then
                        play_sound('timpani')
                        if G.consumeables.config.card_limit > #G.consumeables.cards then 
                            local card = create_card('Tarot_dx', G.consumeables, nil, nil, nil, nil, 'c_heirophant_dx', 'heirophant')
                            card:add_to_deck()
                            G.consumeables:emplace(card)
                        end
                        G.P_CENTERS.m_bonus.config.bonus = G.P_CENTERS.m_bonus.config.bonus + self.ability.extra
                        for k, v in pairs(G.playing_cards) do
                            if v.config.center_key == self.ability.consumeable.mod_conv then v:set_ability(G.P_CENTERS[self.ability.consumeable.mod_conv]) end
                        end
                        used_tarot:juice_up(0.3, 0.5)
                    end
                return true end }))
            end

            if self.ability.name == 'The Cursed Lovers' then
                G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
                    if G.consumeables.config.card_limit > #G.consumeables.cards then
                        play_sound('timpani')
                        if G.consumeables.config.card_limit > #G.consumeables.cards then 
                            local card = create_card('Tarot_dx', G.consumeables, nil, nil, nil, nil, 'c_lovers_dx', 'lovers')
                            card:add_to_deck()
                            G.consumeables:emplace(card)
                        end
                        G.localization.descriptions.Enhanced.m_wild = G.localization.descriptions.Enhanced.m_wild_cu
                        used_tarot:juice_up(0.3, 0.5)
                    end
                return true end }))
            end

            if self.ability.name == 'The Cursed Chariot' then
                G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
                    if G.consumeables.config.card_limit > #G.consumeables.cards then
                        play_sound('timpani')
                        if G.consumeables.config.card_limit > #G.consumeables.cards then 
                            local card = create_card('Tarot_dx', G.consumeables, nil, nil, nil, nil, 'c_chariot_dx', 'chariot')
                            card:add_to_deck()
                            G.consumeables:emplace(card)
                        end
                        G.P_CENTERS.m_steel.config.h_x_mult = G.P_CENTERS.m_steel.config.h_x_mult + self.ability.extra
                        for k, v in pairs(G.playing_cards) do
                            if v.config.center_key == self.ability.consumeable.mod_conv then v:set_ability(G.P_CENTERS[self.ability.consumeable.mod_conv]) end
                        end
                        used_tarot:juice_up(0.3, 0.5)
                    end
                return true end }))
            end

            if self.ability.name == 'Cursed Justice' then
                G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
                    if G.consumeables.config.card_limit > #G.consumeables.cards then
                        play_sound('timpani')
                        if G.consumeables.config.card_limit > #G.consumeables.cards then 
                            local card = create_card('Tarot_dx', G.consumeables, nil, nil, nil, nil, 'c_justice_dx', 'justice')
                            card:add_to_deck()
                            G.consumeables:emplace(card)
                        end
                        G.P_CENTERS.m_glass.config.Xmult = G.P_CENTERS.m_glass.config.Xmult + self.ability.extra
                        for k, v in pairs(G.playing_cards) do
                            if v.config.center_key == self.ability.consumeable.mod_conv then v:set_ability(G.P_CENTERS[self.ability.consumeable.mod_conv]) end
                        end
                        used_tarot:juice_up(0.3, 0.5)
                    end
                return true end }))
            end

            if self.ability.name == 'The Cursed Hermit' then
                G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
                    play_sound('timpani')
                    used_tarot:juice_up(0.3, 0.5)
                    ease_dollars(self.ability.extra, true)
                    return true end }))
                delay(0.6)
            end
            
            if self.ability.name == 'The Cursed Wheel of Fortune' then
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
                if pseudorandom('wheel_of_fortune') < G.GAME.probabilities.normal/self.ability.extra and temp_pool_count > 1 then 
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
            end

            if self.ability.name == 'Cursed Strength' then
                G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
                    play_sound('tarot1')
                    used_tarot:juice_up(0.3, 0.5)
                    return true end }))
                delay(0.2)
                local selected_ranks = {}
                local updated_cards_in_hand = {}
                for i=1, #G.hand.highlighted do
                    selected_ranks[G.hand.highlighted[i].base.id] = true
                end 
                for i=1, #G.hand.cards do
                    if selected_ranks[G.hand.cards[i].base.id] then
                        updated_cards_in_hand[#updated_cards_in_hand + 1] = G.hand.cards[i]
                    end
                end
                for i=1, #updated_cards_in_hand do
                    local percent = 1.15 - (i-0.999)/(#updated_cards_in_hand-0.998)*0.3
                    G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() updated_cards_in_hand[i]:flip();play_sound('card1', percent);updated_cards_in_hand[i]:juice_up(0.3, 0.3);return true end }))
                end
                for k, v in pairs(G.playing_cards) do
                    if selected_ranks[v.base.id] then
                        G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.1,func = function()
                            local suit_prefix = string.sub(v.base.suit, 1, 1)..'_'
                            local rank_suffix = v.base.id == 14 and 2 or math.min(v.base.id+1, 14)
                            if rank_suffix < 10 then rank_suffix = tostring(rank_suffix)
                            elseif rank_suffix == 10 then rank_suffix = 'T'
                            elseif rank_suffix == 11 then rank_suffix = 'J'
                            elseif rank_suffix == 12 then rank_suffix = 'Q'
                            elseif rank_suffix == 13 then rank_suffix = 'K'
                            elseif rank_suffix == 14 then rank_suffix = 'A'
                            end
                            v:set_base(G.P_CARDS[suit_prefix..rank_suffix])
                        return true end }))
                    end
                end
                for i=1, #updated_cards_in_hand do
                    local percent = 0.85 + (i-0.999)/(#updated_cards_in_hand-0.998)*0.3
                    G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() updated_cards_in_hand[i]:flip();play_sound('tarot2', percent, 0.6);updated_cards_in_hand[i]:juice_up(0.3, 0.3);return true end }))
                end
                G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.2,func = function() G.hand:unhighlight_all(); return true end }))
                delay(0.5)
            end
            
            if self.ability.name == 'The Cursed Hanged Man' then
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
                                if v.ability.name == 'Glass Card' and v.area == G.hand then 
                                    v:shatter()
                                else
                                    v:start_dissolve()
                                end
                            end
                        end
                        for i = 1, #G.jokers.cards do
                            G.jokers.cards[i]:calculate_joker({remove_playing_cards = true, removed = destroyed_cards})
                        end
                return true end }))
                delay(0.3)
            end

            if self.ability.name == 'Cursed Death' then
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
            
            if self.ability.name == 'Cursed Temperance' then
                G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
                    play_sound('timpani')
                    used_tarot:juice_up(0.3, 0.5)
                    ease_dollars(self.ability.money, true)
                    return true end }))
                delay(0.6)
            end

            if self.ability.name == 'The Cursed Devil' then
                G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
                    if G.consumeables.config.card_limit > #G.consumeables.cards then
                        play_sound('timpani')
                        if G.consumeables.config.card_limit > #G.consumeables.cards then 
                            local card = create_card('Tarot_dx', G.consumeables, nil, nil, nil, nil, 'c_devil_dx', 'devil')
                            card:add_to_deck()
                            G.consumeables:emplace(card)
                        end
                        G.P_CENTERS.m_gold.config.h_dollars = G.P_CENTERS.m_gold.config.h_dollars + self.ability.extra
                        for k, v in pairs(G.playing_cards) do
                            if v.config.center_key == self.ability.consumeable.mod_conv then v:set_ability(G.P_CENTERS[self.ability.consumeable.mod_conv]) end
                        end
                        used_tarot:juice_up(0.3, 0.5)
                    end
                return true end }))
            end

            if self.ability.name == 'The Cursed Tower' then
                G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
                    if G.consumeables.config.card_limit > #G.consumeables.cards then
                        play_sound('timpani')
                        if G.consumeables.config.card_limit > #G.consumeables.cards then 
                            local card = create_card('Tarot_dx', G.consumeables, nil, nil, nil, nil, 'c_tower_dx', 'tower')
                            card:add_to_deck()
                            G.consumeables:emplace(card)
                        end
                        G.P_CENTERS.m_stone.config.bonus = G.P_CENTERS.m_stone.config.bonus + self.ability.extra
                        for k, v in pairs(G.playing_cards) do
                            if v.config.center_key == self.ability.consumeable.mod_conv then v:set_ability(G.P_CENTERS[self.ability.consumeable.mod_conv]) end
                        end
                        used_tarot:juice_up(0.3, 0.5)
                    end
                return true end }))
            end

            if self.ability.name == 'The Cursed Star' then
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
            end

            if self.ability.name == 'The Cursed Moon' then
                G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
                    if G.consumeables.config.card_limit > #G.consumeables.cards then
                        play_sound('timpani')
                        if G.consumeables.config.card_limit > #G.consumeables.cards then 
                            local card = create_card('Tarot_dx', G.consumeables, nil, nil, nil, nil, 'c_moon_dx', 'star')
                            card:add_to_deck()
                            G.consumeables:emplace(card)
                        end
                        used_tarot:juice_up(0.3, 0.5)
                    end
                return true end }))
            end

            if self.ability.name == 'The Cursed Sun' then
                G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
                    if G.consumeables.config.card_limit > #G.consumeables.cards then
                        play_sound('timpani')
                        if G.consumeables.config.card_limit > #G.consumeables.cards then 
                            local card = create_card('Tarot_dx', G.consumeables, nil, nil, nil, nil, 'c_sun_dx', 'star')
                            card:add_to_deck()
                            G.consumeables:emplace(card)
                        end
                        used_tarot:juice_up(0.3, 0.5)
                    end
                return true end }))
            end
            
            if self.ability.name == 'Cursed Judgement' then
                G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
                    play_sound('timpani')
                    local rarity = 0.98
                    local card = create_card('Joker', G.jokers, false, rarity, nil, nil, nil, 'jud')
                    card:add_to_deck()
                    G.jokers:emplace(card)
                    used_tarot:juice_up(0.3, 0.5)
                    return true end }))
                delay(0.6)
            end

            if self.ability.name == 'The Cursed World' then
                G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
                    if G.consumeables.config.card_limit > #G.consumeables.cards then
                        play_sound('timpani')
                        if G.consumeables.config.card_limit > #G.consumeables.cards then 
                            local card = create_card('Tarot_dx', G.consumeables, nil, nil, nil, nil, 'c_world_dx', 'star')
                            card:add_to_deck()
                            G.consumeables:emplace(card)
                        end
                        used_tarot:juice_up(0.3, 0.5)
                    end
                return true end }))
            end
            
        else    -- Call vanilla
            card_use_consumeable_ref(self, area, copier)
        end
    end

    -- Check if DX card can be used
    local card_can_use_consumeable_ref = Card.can_use_consumeable
    function Card.can_use_consumeable(self, any_state, skip_check)

        if (self.ability.type == '_dx' or self.ability.type == '_cu') and (self.config.center and (self.config.center.atlas == 'Van_dx' or self.config.center.atlas == 'Van_cu')) then

            if not skip_check and ((G.play and #G.play.cards > 0) or
                (G.CONTROLLER.locked) or
                (G.GAME.STOP_USE and G.GAME.STOP_USE > 0))
                then  return false end

            if G.STATE ~= G.STATES.HAND_PLAYED and G.STATE ~= G.STATES.DRAW_TO_HAND and G.STATE ~= G.STATES.PLAY_TAROT or any_state then

                if self.ability.name == 'The Hermit DX' or self.ability.consumeable.hand_type or self.ability.name == 'Temperance DX' or self.ability.name == 'Black Hole DX' or self.ability.name == 'The Soul DX' then
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

                if self.ability.name == 'The Cursed Hermit' or self.ability.name == 'Cursed Temperance' then
                    return true
                end
                if self.ability.name == 'The Cursed Wheel of Fortune' then 
                    if next(self.eligible_strength_jokers) then return true end
                end
                if self.ability.name == 'The Cursed Emperor' or self.ability.name == 'The Cursed High Priestess' then 
                    return true
                end
                if self.ability.name == 'Cursed Judgement' then
                    if #G.jokers.cards < G.jokers.config.card_limit or self.area == G.jokers then
                        return true
                    else
                        return false
                    end
                end
                if self.ability.name == 'The Cursed Magician' or self.ability.name == 'The Cursed Empress' or self.ability.name == 'The Cursed Hierophant' or self.ability.name == 'The Cursed Lovers' or self.ability.name == 'The Cursed Chariot' or self.ability.name == 'Cursed Justice' or self.ability.name == 'The Cursed Devil' or self.ability.name == 'The Cursed Tower' or self.ability.name == 'The Cursed Moon' or self.ability.name == 'The Cursed Star' or self.ability.name == 'The Cursed Sun' or self.ability.name == 'The Cursed World' or self.ability.name == 'The Cursed Fool' then 
                    return true
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

    -- Manage DX boosters
    local card_open_ref = Card.open
    function Card.open(self)

        if self.ability.set == "Booster" and self.ability.type == '_dx' then
            stop_use()
            G.STATE_COMPLETE = false 
            self.opening = true

            if not self.config.center.discovered then
                discover_card(self.config.center)
            end
            self.states.hover.can = false

            if self.ability.name:find('Arcana') then 
                G.STATE = G.STATES.TAROT_PACK
                G.GAME.pack_size = self.ability.extra
            elseif self.ability.name:find('Celestial') then
                G.STATE = G.STATES.PLANET_PACK
                G.GAME.pack_size = self.ability.extra
            elseif self.ability.name:find('Spectral') then
                G.STATE = G.STATES.SPECTRAL_PACK
                G.GAME.pack_size = self.ability.extra
            elseif self.ability.name:find('Standard') then
                G.STATE = G.STATES.STANDARD_PACK
                G.GAME.pack_size = self.ability.extra
            elseif self.ability.name:find('Buffoon') then
                G.STATE = G.STATES.BUFFOON_PACK
                G.GAME.pack_size = self.ability.extra
            elseif self.ability.name:find('Alchemy') then
                G.STATE = G.STATES.BUFFOON_PACK
                G.GAME.pack_size = self.ability.extra
            end

            G.GAME.pack_choices = self.config.center.config.choose or 1

            if self.cost > 0 then 
                G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.2, func = function()
                    inc_career_stat('c_shop_dollars_spent', self.cost)
                    self:juice_up()
                return true end }))
                ease_dollars(-self.cost) 
            else
                delay(0.2)
            end

        G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
            self:explode()
            local pack_cards = {}

            G.E_MANAGER:add_event(Event({trigger = 'after', delay = 1.3*math.sqrt(G.SETTINGS.GAMESPEED), blockable = false, blocking = false, func = function()
                local _size = self.ability.extra
                
                for i = 1, _size do
                    local card = nil

                    -- Add an increased chance for dx card
                    local dx_modifier = pseudorandom(pseudoseed('force_dx'..G.GAME.round_resets.ante)) > 0.35

                    if self.ability.name:find('Arcana') then 
                        if G.GAME.used_vouchers.v_omen_globe and pseudorandom('omen_globe') > 0.8 then
                            card = create_card(dx_modifier and "Spectral_dx" or "Spectral", G.pack_cards, nil, nil, true, true, nil, 'ar2')
                        else
                            card = create_card(dx_modifier and "Tarot_dx" or "Tarot", G.pack_cards, nil, nil, true, true, nil, 'ar1')
                        end
                    elseif self.ability.name:find('Celestial') then
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
                            card = create_card("Planet", G.pack_cards, nil, nil, true, true, _planet, 'pl1')
                        else
                            card = create_card(dx_modifier and "Planet_dx" or "Planet", G.pack_cards, nil, nil, true, true, nil, 'pl1')
                        end
                    elseif self.ability.name:find('Spectral') then
                        card = create_card(dx_modifier and "Spectral_dx" or "Spectral", G.pack_cards, nil, nil, true, true, nil, 'spe')
                    elseif self.ability.name:find('Standard') then
                        card = create_card("Enhanced", G.pack_cards, nil, nil, nil, true, nil, 'sta')
                        local edition_rate = dx_modifier and 6 or 3
                        local edition = poll_edition('standard_edition'..G.GAME.round_resets.ante, edition_rate, true)
                        if not card.edition then card:set_edition(edition) end
                        local seal_rate = dx_modifier and 30 or 15
                        local seal_poll = pseudorandom(pseudoseed('stdseal'..G.GAME.round_resets.ante))
                        if seal_poll > 1 - 0.02*seal_rate then
                            local seal_type = pseudorandom(pseudoseed('stdsealtype'..G.GAME.round_resets.ante))
                            if seal_type > 0.75 then card:set_seal('Red')
                            elseif seal_type > 0.5 then card:set_seal('Blue')
                            elseif seal_type > 0.25 then card:set_seal('Gold')
                            else card:set_seal('Purple')
                            end
                        end
                    elseif self.ability.name:find('Buffoon') then
                        local rarity = pseudorandom('rarity'..G.GAME.round_resets.ante..(_append or '')) + (dx_modifier and 0.3 or 0)
                        card = create_card("Joker", G.pack_cards, nil, rarity, true, true, nil, 'buf')
                        local edition_rate = dx_modifier and 3 or 1.5
                        local edition = poll_edition('standard_edition'..G.GAME.round_resets.ante, edition_rate, true)
                        if not card.edition then card:set_edition(edition) end
                    elseif self.ability.name:find('Alchemy') then
                        G.ARGS.is_alchemical_booster = true
                        card = create_card(dx_modifier and "Alchemical_dx" or "Alchemical", G.pack_cards, nil, nil, true, true, nil, 'alc')
                    end
                    card.T.x = self.T.x
                    card.T.y = self.T.y
                    card:start_materialize({G.C.WHITE, G.C.WHITE}, nil, 1.5*G.SETTINGS.GAMESPEED)
                    pack_cards[i] = card
                end
                return true
            end}))

            G.E_MANAGER:add_event(Event({trigger = 'after', delay = 1.3*math.sqrt(G.SETTINGS.GAMESPEED), blockable = false, blocking = false, func = function()
                if G.pack_cards then 
                    if G.pack_cards and G.pack_cards.VT.y < G.ROOM.T.h then 
                    for k, v in ipairs(pack_cards) do
                        G.pack_cards:emplace(v)
                    end
                    return true
                    end
                end
            end}))

            for i = 1, #G.jokers.cards do
                G.jokers.cards[i]:calculate_joker({open_booster = true, card = self})
            end

            if G.GAME.modifiers.inflation then 
                G.GAME.inflation = G.GAME.inflation + 1
                G.E_MANAGER:add_event(Event({func = function()
                for k, v in pairs(G.I.CARD) do
                    if v.set_cost then v:set_cost() end
                end
                return true end }))
            end

        return true end }))
        else
            card_open_ref(self)
        end
    end

    -- Update calculate_joker for Hanged Man DX/CU
    local card_calculate_joker_ref = Card.calculate_joker
    function Card.calculate_joker(self, context)

        if self.ability.set == "Joker" and not self.debuff then
            if context.using_consumeable then
                if self.ability.name == 'Glass Joker' and not context.blueprint and (context.consumeable.ability.name == 'The Hanged Man DX' or context.consumeable.ability.name == 'The Cursed Hanged Man')  then
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

        if G.STAGE and G.STAGE == G.STAGES.RUN then
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
            if self.ability.name == 'Cursed Temperance' then
                if G.STAGE == G.STAGES.RUN then
                    self.ability.money = 0
                    for i = 1, #G.jokers.cards do
                        if G.jokers.cards[i].ability.set == 'Joker' then
                            self.ability.money = self.ability.money + 10
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
            if self.ability.name == 'The Cursed Wheel of Fortune' then
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
    end

    -- Prevents duplicates between normal and DX version
    local card_set_ability_ref = Card.set_ability
    function Card.set_ability(self, center, initial, delay_sprites)

        card_set_ability_ref(self, center, initial, delay_sprites)

        if self.ability and self.ability.consumeable and self.ability.name and self.ability.set then 
            if self.ability.type == '_dx' then
                if not G.OVERLAY_MENU then 
                    for k, v in pairs(G.P_CENTERS) do
                        if v.name == self.ability.name then
                            -- Add normal and cursed version
                            G.GAME.used_jokers[string.sub(k, 1, -4)] = true
                            G.GAME.used_jokers[string.sub(k, 1, -4)..'_cu'] = true
                        end
                    end
                end
            end
            if self.ability.type == '_cu' then
                if not G.OVERLAY_MENU then 
                    for k, v in pairs(G.P_CENTERS) do
                        if v.name == self.ability.name then
                            -- Add normal and DX version
                            G.GAME.used_jokers[string.sub(k, 1, -4)] = true
                            G.GAME.used_jokers[string.sub(k, 1, -4)..'_dx'] = true
                        end
                    end
                end
            end
            if self.ability.set == 'Tarot' or self.ability.set == 'Planet' or self.ability.set == 'Spectral' or self.ability.set == 'Booster' then
                if not G.OVERLAY_MENU then 
                    for k, v in pairs(G.P_CENTERS) do
                        if v.name == self.ability.name then
                            -- Add DX/CU version
                            G.GAME.used_jokers[k..'_dx'] = true
                            G.GAME.used_jokers[k..'_cu'] = true
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
            if self.ability.type == '_dx' then
                if not G.OVERLAY_MENU then 
                    for k, v in pairs(G.P_CENTERS) do
                        if v.name == self.ability.name then
                            if not next(find_joker(self.ability.name, true)) then 
                                -- Remove normal and cursed version
                                G.GAME.used_jokers[string.sub(k, 1, -4)] = nil
                                G.GAME.used_jokers[string.sub(k, 1, -4)..'_cu'] = nil
                            end
                        end
                    end
                end
            end
            if self.ability.type == '_cu' then
                if not G.OVERLAY_MENU then 
                    for k, v in pairs(G.P_CENTERS) do
                        if v.name == self.ability.name then
                            if not next(find_joker(self.ability.name, true)) then 
                                -- Remove normal and DX version
                                G.GAME.used_jokers[string.sub(k, 1, -4)] = nil
                                G.GAME.used_jokers[string.sub(k, 1, -4)..'_dx'] = nil
                            end
                        end
                    end
                end
            end
            if self.ability.set == 'Tarot' or self.ability.set == 'Planet' or self.ability.set == 'Spectral' or self.ability.set == 'Booster' then
                if not G.OVERLAY_MENU then 
                    for k, v in pairs(G.P_CENTERS) do
                        if v.name == self.ability.name then
                            if not next(find_joker(self.ability.name, true)) then 
                                -- Remove DX/CU version
                                G.GAME.used_jokers[k..'_dx'] = nil
                                G.GAME.used_jokers[k..'_cu'] = nil
                            end
                        end
                    end
                end
            end
        end

        card_remove_ref(self)
    end

    -- Manage Ankh DX
    local card_check_use_ref = Card.check_use
    function Card.check_use(self)

        if self.ability.name == 'Ankh DX' then 
            if #G.jokers.cards >= G.jokers.config.card_limit then  
                alert_no_space(self, G.jokers)
                return true
            end
        end
        card_check_use_ref(self)
    end

    -- Apply the correct shader to Soul DX
    local card_draw_ref = Card.draw
    function Card.draw(self, layer)
        
        -- Use the vanilla function for now, TODO
        if self.ability.type == '_dx' or self.ability.type == '_cu' then
            if self.ability.name == 'The Soul DX' then
                self.ability.name = 'The Soul'
            end
            card_draw_ref(self, layer)
            if self.ability.name == 'The Soul' then
                self.ability.name = 'The Soul DX'
            end
        else
            card_draw_ref(self, layer)
        end
    end

    -- Cycle Vanilla/DX/Cursed in collection
    local card_click_ref = Card.click
    function Card.click(self)

        card_click_ref(self)
        -- Check if we are in the collection
        if self.area and self.area.config and self.area.config.collection then
            local version = 'van'
            -- Check if this is a DX card
            if self.ability.type == '_dx' then version = 'dx' end
            -- Check if this is a Cursed card
            if self.ability.type == '_cu' then version = 'cu' end

            -- Check if a DX version exists
            if version == 'van' and G.P_CENTER_POOLS[self.ability.set..'_dx'] then
                local dx_ver = self.config.center_key..'_dx'
                for k, v in pairs(G.P_CENTER_POOLS[self.ability.set..'_dx']) do
                    if v.key == dx_ver then
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
                    if v.key == cu_ver then
                        self:set_ability(G.P_CENTER_POOLS[self.ability.set..'_cu'][k], true)
                        version = nil
                        break
                    end
                end
            elseif version == 'dx' and G.P_CENTER_POOLS[self.ability.set..'_cu'] then 
                local cu_ver = string.sub(self.config.center_key, 1, -4)..'_cu'
                for k, v in pairs(G.P_CENTER_POOLS[self.ability.set..'_cu']) do
                    if v.key == cu_ver then
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
                    if v.key == van_ver then
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
            card_set_debuff_ref(self, false)
            self.params.debuff_by_curse = nil
        -- Check if the debuff is from a curse
        elseif not should_debuff and self.params.debuff_by_curse then
            card_set_debuff_ref(self, self.params.debuff_by_curse)
        -- Vanilla
        else
            card_set_debuff_ref(self, should_debuff)
        end
    end

    -- Manage custom sprites
    local card_set_sprites_ref = Card.set_sprites
    function Card.set_sprites(self, _center, _front)
        
        -- Override if DX/CU
        if _center and _center.set and _center.consumeable and _center.config and (_center.config.type == '_dx' or _center.config.type == '_cu') then 
            
            if self.children.center then
                self.children.center.atlas = G.ASSET_ATLAS[_center.atlas or 'centers']
                self.children.center:set_sprite_pos(_center.pos)
            else
                if self.config.center.consumeable and self.config.center.demo then 
                    self.children.center = Sprite(self.T.x, self.T.y, self.T.w, self.T.h, G.ASSET_ATLAS[_center.atlas], G.c_locked.pos)
                elseif not self.params.bypass_discovery_center and (_center.consumeable or _center.set == 'Booster') and not _center.discovered then 
                    self.children.center = Sprite(self.T.x, self.T.y, self.T.w, self.T.h, G.ASSET_ATLAS[_center.atlas or _center.set], 
                    (_center.set == 'Tarot' and G.t_undiscovered.pos) or 
                    (_center.set == 'Planet' and G.p_undiscovered.pos) or 
                    (_center.set == 'Spectral' and G.s_undiscovered.pos) or 
                    (_center.set == 'Booster' and G.booster_undiscovered.pos))
                else
                    self.children.center = Sprite(self.T.x, self.T.y, self.T.w, self.T.h, G.ASSET_ATLAS[_center.atlas or 'centers'], _center.pos)
                end
                self.children.center.states.hover = self.states.hover
                self.children.center.states.click = self.states.click
                self.children.center.states.drag = self.states.drag
                self.children.center.states.collide.can = false
                self.children.center:set_role({major = self, role_type = 'Glued', draw_major = self})
            end
            
            if not self.children.back then
                self.children.back = Sprite(self.T.x, self.T.y, self.T.w, self.T.h, G.ASSET_ATLAS["centers"], self.params.bypass_back or (self.playing_card and G.GAME[self.back].pos or G.P_CENTERS['b_red'].pos))
                self.children.back.states.hover = self.states.hover
                self.children.back.states.click = self.states.click
                self.children.back.states.drag = self.states.drag
                self.children.back.states.collide.can = false
                self.children.back:set_role({major = self, role_type = 'Glued', draw_major = self})
            end

        else
            card_set_sprites_ref(self, _center, _front)
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
end

function SMODS.INIT.JeffDeluxeConsumablesPack()
    sendDebugMessage("Deluxe Consumables Cards Loaded")

    -- DX/Curses Sprites

    local js_mod = SMODS.findModByID("JeffDeluxeConsumablesPack")
    local sprite_dx = SMODS.Sprite:new("Van_dx", js_mod.path, "Tarots_dx.png", 71, 95, "asset_atli")
    sprite_dx:register()
    sprite_dx = SMODS.Sprite:new("Van_cu", js_mod.path, "Tarots_cu.png", 71, 95, "asset_atli")
    sprite_dx:register()
    sprite_dx = SMODS.Sprite:new("Van_Booster_dx", js_mod.path, "booster_dx.png", 71, 95, "asset_atli")
    sprite_dx:register()

    -- Add consumables
    setup_consumables()

    -- Localizations
    setUpLocalizationTarotDX()
    setUpLocalizationTarotCU()
    setUpLocalizationPlanetDX()
    setUpLocalizationSpectralDX()
    setUpLocalizationBoosterDX()
    setUpLocalizationEnhanced()
    G.localization.descriptions.Other.dx = {
        name = "Deluxe Version",
        text = {
            "Enhanced effect",
        }
    }
    G.localization.descriptions.Other.unique = {
        name = "Unique",
        text = {
            "Cannot be pulled",
            "again this run"
        }
    }
    G.localization.misc.labels['tarot_dx'] = "Tarot DX"
    G.localization.misc.labels['planet_dx'] = "Planet DX"
    G.localization.misc.labels['spectral_dx'] = "Spectral DX"
    G.localization.misc.labels['booster_dx'] = "Booster DX"
    G.localization.misc.labels['dx'] = "DX Version"
    G.localization.misc.labels['unique'] = "Unique"
    G.localization.misc.labels['star_bu'] = "Diamonds Buff"
    G.localization.misc.labels['moon_bu'] = "Clubs Buff"
    G.localization.misc.labels['sun_bu'] = "Hearts Buff"
    G.localization.misc.labels['world_bu'] = "Spades Buff"
    G.localization.misc.dictionary['k_tarot_dx'] = "Tarot DX"
    G.localization.misc.dictionary['k_tarot_cu'] = "Cursed Tarot"
    G.localization.misc.dictionary['k_planet_dx'] = "Planet DX"
    G.localization.misc.dictionary['k_spectral_dx'] = "Spectral DX"
    G.localization.misc.dictionary['k_booster_dx'] = "Booster DX"

    -- Manage loc_colour
    loc_colour('red', nil)
    G.ARGS.LOC_COLOURS['tarot_dx'] = G.C.SECONDARY_SET.Tarot
    G.ARGS.LOC_COLOURS['tarot_cu'] = G.C.SECONDARY_SET.Tarot
    G.ARGS.LOC_COLOURS['planet_dx'] = G.C.SECONDARY_SET.Planet
    G.ARGS.LOC_COLOURS['spectral_dx'] = G.C.SECONDARY_SET.Spectral
    G.ARGS.LOC_COLOURS['booster_dx'] = G.C.BOOSTER

    -- Manage get_badge_colour
    get_badge_colour(foil)
    G.BADGE_COL['dx'] = G.C.DARK_EDITION
    G.BADGE_COL['unique'] = G.C.ETERNAL
    G.BADGE_COL['star_bu'] = G.C.SUITS.Diamonds
    G.BADGE_COL['moon_bu'] = G.C.SUITS.Clubs
    G.BADGE_COL['sun_bu'] = G.C.SUITS.Hearts
    G.BADGE_COL['world_bu'] = G.C.SUITS.Spades

    -- Manage C colors
    G.C.SET['Tarot_dx'] = HEX('424e54')
    G.C.SET['Tarot_cu'] = HEX('424e54')
    G.C.SET['Planet_dx'] = HEX('424e54')
    G.C.SET['Spectral_dx'] = HEX('424e54')
    G.C.SET['Booster_dx'] = HEX('424e54')
    G.C.SECONDARY_SET['Tarot_dx'] = HEX('a782d1')
    G.C.SECONDARY_SET['Tarot_cu'] = HEX('a782d1')
    G.C.SECONDARY_SET['Planet_dx'] = HEX('13afce')
    G.C.SECONDARY_SET['Spectral_dx'] = HEX('4584fa')
    G.C.SECONDARY_SET['Booster_dx'] = HEX('4584fa')

    -------------------------------
    ---------- OVERRIDES ----------
    -------------------------------

    -- ORDER IS IMPORTANT !!!
    loadCodexArcanumModule()

    overrides()

    loadCursesModule()
end

----------------------------------------------
------------MOD CODE END----------------------
