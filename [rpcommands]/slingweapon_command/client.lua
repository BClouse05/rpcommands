-- client.lua

local isWeaponSlung = false
local weaponHash = nil
local slingBone = 24816 -- Bone ID for back
local slingOffset = vector3(-0.2, -0.15, -0.05) -- Adjust these values to position the weapon on the back
local slingRotation = vector3(0.0, 135.0, 0.0) -- Adjust these for weapon rotation

RegisterCommand("slingweapon", function()
    local playerPed = PlayerPedId()
    if IsPedArmed(playerPed, 4) then
        if isWeaponSlung then
            -- Unsling weapon: give it back to the player's hands
            SetCurrentPedWeapon(playerPed, weaponHash, true)
            DetachEntity(NetToObj(weaponEntity), true, true)
            DeleteObject(NetToObj(weaponEntity))
            weaponEntity = nil
            isWeaponSlung = false
        else
            -- Sling weapon: remove from hands and attach to back
            weaponHash = GetSelectedPedWeapon(playerPed)
            RemoveWeaponFromPed(playerPed, weaponHash)

            -- Create weapon object and attach it to player's back
            RequestModel(GetHashKey("w_ar_carbinerifle"))
            while not HasModelLoaded(GetHashKey("w_ar_carbinerifle")) do
                Wait(10)
            end

            weaponEntity = CreateObject(GetHashKey("w_ar_carbinerifle"), 0, 0, 0, true, true, true)
            AttachEntityToEntity(weaponEntity, playerPed, GetPedBoneIndex(playerPed, slingBone), slingOffset, slingRotation, true, true, false, true, 1, true)
            
            isWeaponSlung = true
        end
    else
        -- Notify player if they don't have a suitable weapon equipped
        TriggerEvent('chat:addMessage', {
            color = {255, 0, 0},
            multiline = true,
            args = {"System", "You need a weapon in hand to use /slingweapon."}
        })
    end
end)

-- Ensure weapon is deleted when player dies
AddEventHandler('playerSpawned', function()
    if isWeaponSlung and weaponEntity then
        DeleteObject(NetToObj(weaponEntity))
        isWeaponSlung = false
    end
end)
