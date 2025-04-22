Config = {}

Config.PlatePrefix = "CHIVAS" -- Plaka
Config.MoneyType = "bank" -- "cash" ya da "bank"
Config.Cooldown = 60 -- Saniye Cinsinden

Config.Blip = {
    label = "Araç Kiralama", -- Blip Adı
    sprite = 326, -- https://docs.fivem.net/docs/game-references/blips/#blips
    scale = 0.7, -- Blip Boyutu
    colour = 3, -- https://docs.fivem.net/docs/game-references/blips/#blips
}

Config.Locations = {
    [1] = {
        npcModel = "a_m_m_business_01", -- https://docs.fivem.net/docs/game-references/ped-models/
        npcCoords = vector4(-1034.6, -2731.7, 12.76, 328.5), -- NPC Konumu
        vehicleSpawn = vector4(-1027.2, -2734.9, 13.76, 90.0), -- Aracın Spawn Olacağı Konum
        vehicles = { -- https://docs.fivem.net/docs/game-references/vehicle-references/vehicle-models/
            { label = "Faggio", model = "faggio", price = 150 },
            { label = "Blista", model = "blista", price = 300 },
            { label = "Sanchez", model = "sanchez", price = 450 },
        }
    },
    [2] = {
        npcModel = "a_f_m_bevhills_01",
        npcCoords = vector4(215.76, -809.59, 29.73, 160.0),
        vehicleSpawn = vector4(225.12, -804.66, 30.73, 160.0),
        vehicles = {
            { label = "Panto", model = "panto", price = 200 },
            { label = "Faggio", model = "faggio", price = 100 },
        }
    },
}
