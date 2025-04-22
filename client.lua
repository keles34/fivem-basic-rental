local QBCore = exports['qb-core']:GetCoreObject()
local cooldown = {}

CreateThread(function()
    for k, loc in pairs(Config.Locations) do
        RequestModel(loc.npcModel)
        while not HasModelLoaded(loc.npcModel) do Wait(10) end

        local ped = CreatePed(0, loc.npcModel, loc.npcCoords.xyz, loc.npcCoords.w, false, true)
        FreezeEntityPosition(ped, true)
        SetEntityInvincible(ped, true)
        SetBlockingOfNonTemporaryEvents(ped, true)

        if Config.Blip then
            local blip = AddBlipForCoord(loc.npcCoords.xyz)
            SetBlipSprite(blip, Config.Blip.sprite)
            SetBlipScale(blip, Config.Blip.scale)
            SetBlipColour(blip, Config.Blip.colour)
            SetBlipDisplay(blip, 4)
            SetBlipAsShortRange(blip, true)
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentString(Config.Blip.label)
            EndTextCommandSetBlipName(blip)
        end

        exports['qb-target']:AddTargetEntity(ped, {
            options = {
                {
                    icon = "fas fa-car",
                    label = "Araç Kirala",
                    action = function()
                        openRentalMenu(k)
                    end
                },
            },
            distance = 2.0,
        })
    end
end)

function openRentalMenu(id)
    if cooldown[id] and GetGameTimer() < cooldown[id] then
        QBCore.Functions.Notify("Yeniden kiralama için biraz bekle!", "error")
        return
    end

    local options = {
        {
            header = "Araç Kiralama Menüsü",
            isMenuHeader = true
        }
    }

    for _, veh in ipairs(Config.Locations[id].vehicles) do
        options[#options + 1] = {
            header = veh.label,
            txt = "$" .. veh.price,
            params = {
                event = "vehicle_rental:client:rent",
                args = {
                    id = id,
                    model = veh.model,
                    label = veh.label,
                    price = veh.price
                }
            }
        }
    end

    options[#options + 1] = {
        header = "⬅️ Menüyü Kapat",
        txt = "",
        params = {
            event = "qb-menu:client:closeMenu"
        }
    }

    exports['qb-menu']:openMenu(options)
end

RegisterNetEvent("vehicle_rental:client:rent", function(data)
    local id = data.id
    local spawn = Config.Locations[id].vehicleSpawn
    cooldown[id] = GetGameTimer() + (Config.Cooldown * 1000)
    TriggerServerEvent("vehicle_rental:rentVehicle", data.model, data.label, data.price, spawn)
end)

RegisterNetEvent("vehicle_rental:client:spawnVehicle", function(model, plate, coords)
    QBCore.Functions.SpawnVehicle(model, function(veh)
        SetVehicleNumberPlateText(veh, plate)
        SetEntityHeading(veh, coords.w)
        TaskWarpPedIntoVehicle(PlayerPedId(), veh, -1)
    end, coords, true)
end)
