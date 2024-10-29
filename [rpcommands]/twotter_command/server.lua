-- server.lua

RegisterServerEvent('twotter:sendMessage')
AddEventHandler('twotter:sendMessage', function(playerName, message)
    local formattedMessage = string.format("^5@%s^7: %s", playerName, message)  -- Format with player name and message
    
    -- Send the formatted message to all players
    TriggerClientEvent('chat:addMessage', -1, {
        color = {30, 144, 255},
        multiline = true,
        args = {"Twotter", formattedMessage}
    })
end)
