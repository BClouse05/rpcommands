-- server.lua

RegisterServerEvent('3dme:shareDisplay')
AddEventHandler('3dme:shareDisplay', function(text, coords)
    TriggerClientEvent('3dme:display', -1, text, coords)
end)
