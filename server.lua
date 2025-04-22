local QBCore = exports['qb-core']:GetCoreObject()

RegisterServerEvent("vehicle_rental:rentVehicle", function(model, label, price, coords)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local plate = string.upper(Config.PlatePrefix) .. tostring(math.random(1000, 9999))

    if Config.MoneyType == "bank" then
        if Player.Functions.RemoveMoney("bank", price, "vehicle-rental") then
            TriggerClientEvent("vehicle_rental:client:spawnVehicle", src, model, plate, coords)
            TriggerClientEvent("QBCore:Notify", src, label.." kiralandı.", "success")
        else
            TriggerClientEvent("QBCore:Notify", src, "Yeterli banka bakiyesi yok.", "error")
        end
    else
        if Player.Functions.RemoveMoney("cash", price, "vehicle-rental") then
            TriggerClientEvent("vehicle_rental:client:spawnVehicle", src, model, plate, coords)
            TriggerClientEvent("QBCore:Notify", src, label.." kiralandı.", "success")
        else
            TriggerClientEvent("QBCore:Notify", src, "Yeterli nakit yok.", "error")
        end
    end
end)
