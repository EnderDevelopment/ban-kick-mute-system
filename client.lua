ESX = nil

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(0)
    end
end)

RegisterNetEvent('BanKickMuteSystem:notify')
AddEventHandler('BanKickMuteSystem:notify', function(message)
    ESX.ShowNotification(message)
end)