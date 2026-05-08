ESX = nil

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(0)
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        local ped = PlayerPedId()
        local pos = GetEntityCoords(ped)
        local dist = #(pos - Config.RentalPosition)

        if dist < Config.Marker.drawDistance then
            DrawMarker(
                Config.Marker.type,
                Config.RentalPosition.x,
                Config.RentalPosition.y,
                Config.RentalPosition.z - 1.0,
                0.0, 0.0, 0.0,
                0.0, 0.0, 0.0,
                Config.Marker.size.x,
                Config.Marker.size.y,
                Config.Marker.size.z,
                Config.Marker.color.r,
                Config.Marker.color.g,
                Config.Marker.color.b,
                Config.Marker.color.a,
                false, true, 2
            )
        end

        if dist < 1.5 then
            exports['LamaInteractUI']:showHelpNotification('Fahrzeug Mieten')
            if IsControlJustReleased(0, 38) then
                OpenRentalMenu()
            end
        end
    end
end)

function OpenRentalMenu()
    ESX.UI.Menu.CloseAll()
    ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'rental_menu', {
        title    = 'Auto Verleih',
        align    = 'top-left',
        elements = {
            {label = "Fahrzeug mieten ($"..Config.RentalPrice..")", value = 'rent'}
        }
    }, function(data, menu)
        if data.current.value == 'rent' then
            RentVehicle()
            menu.close()
        end
    end, function(data, menu)
        menu.close()
    end)
end

function RentVehicle()
    local playerPed = PlayerPedId()
    local model = GetHashKey(Config.DefaultVehicle)
    RequestModel(model)
    while not HasModelLoaded(model) do Citizen.Wait(0) end

    local plate = GeneratePlate()
    local veh = CreateVehicle(model, Config.SpawnVehicle.coords.x, Config.SpawnVehicle.coords.y, Config.SpawnVehicle.coords.z, Config.SpawnVehicle.heading, true, false)
    SetVehicleNumberPlateText(veh, plate)
    TaskWarpPedIntoVehicle(playerPed, veh, -1)
    SetVehicleEngineOn(veh, true, true, false)
    SetEntityAsMissionEntity(veh, true, true)

    TriggerServerEvent('cat_autoverleih:attemptPay', Config.RentalPrice)
    ESX.ShowNotification("Du hast ein Fahrzeug gemietet. Kennzeichen: " .. plate)
end

function GeneratePlate()
    local num = math.random(100, 999)
    local letters = string.char(math.random(65,90)) .. string.char(math.random(65,90))
    return Config.PlatePrefix .. tostring(num) .. letters
end
