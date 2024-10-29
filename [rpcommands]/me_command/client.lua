-- client.lua

RegisterCommand('me', function(source, args)
    local text = table.concat(args, " ")
    local playerPed = PlayerPedId()
    local playerCoords = GetEntityCoords(playerPed)

    -- Display the text above the player's head
    TriggerEvent('chat:addMessage', {
        color = { 255, 0, 0},
        multiline = true,
        args = {"Me", text}
    })

    -- Display the 3D text
    TriggerServerEvent('3dme:shareDisplay', text, playerCoords)
end)

-- Draw 3D text above the player
RegisterNetEvent('3dme:display')
AddEventHandler('3dme:display', function(text, coords)
    local display = true
    Citizen.CreateThread(function()
        while display do
            Wait(0)
            local dist = #(GetEntityCoords(PlayerPedId()) - coords)
            if dist < 20 then
                DrawText3D(coords.x, coords.y, coords.z + 1.0, text)
            end
        end
    end)
end)

function DrawText3D(x, y, z, text)
    local onScreen, _x, _y = World3dToScreen2d(x, y, z)
    local scale = 0.35
    if onScreen then
        SetTextScale(scale, scale)
        SetTextFont(4)
        SetTextProportional(1)
        SetTextColour(255, 255, 255, 215)
        SetTextOutline()
        SetTextEntry("STRING")
        SetTextCentre(1)
        AddTextComponentString(text)
        DrawText(_x, _y)
    end
end
