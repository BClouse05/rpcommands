-- client.lua

RegisterCommand('twotter', function(source, args, rawCommand)
    local message = table.concat(args, " ")
    local playerName = GetPlayerName(PlayerId())

    if message == "" then
        TriggerEvent('chat:addMessage', {
            color = {255, 0, 0},
            multiline = true,
            args = {"Twotter", "Please enter a message."}
        })
        return
    end

    -- Send the message to the server
    TriggerServerEvent('twotter:sendMessage', playerName, message)
end)
