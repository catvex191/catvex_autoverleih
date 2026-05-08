ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

local function GeneratePlate()
    local num = math.random(100, 999)
    local letters = string.char(math.random(65,90)) .. string.char(math.random(65,90))
    return Config.PlatePrefix .. tostring(num) .. letters
end

RegisterNetEvent('cat_autoverleih:attemptPay')
AddEventHandler('cat_autoverleih:attemptPay', function(price)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    if not xPlayer then return end

    if xPlayer.getMoney() >= price then
        xPlayer.removeMoney(price)
        TriggerClientEvent('esx:showNotification', src, "Du hast $" .. price .. " bezahlt.")
    else
        TriggerClientEvent('esx:showNotification', src, "Du hast nicht genug Bargeld.")
    end
end)
