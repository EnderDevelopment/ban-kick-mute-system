ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

-- Function to check if a player is an admin
function isAdmin(playerId)
    local xPlayer = ESX.GetPlayerFromId(playerId)
    if xPlayer then
        for _, group in ipairs(Config.AdminGroups) do
            if xPlayer.getGroup() == group then
                return true
            end
        end
    end
    return false
end

-- Function to log actions to the database
function logAction(identifier, type, reason, duration, admin)
    MySQL.Async.execute(
        'INSERT INTO ban_kick_mute_system (identifier, type, reason, duration, admin) VALUES (@identifier, @type, @reason, @duration, @admin)',
        {
            ['@identifier'] = identifier,
            ['@type'] = type,
            ['@reason'] = reason,
            ['@duration'] = duration,
            ['@admin'] = admin
        }
    )
end

-- Command to ban a player
RegisterCommand(Config.Commands.Ban, function(source, args, rawCommand)
    if not isAdmin(source) then
        TriggerClientEvent('BanKickMuteSystem:notify', source, 'You do not have permission to use this command.')
        return
    end

    local targetId = tonumber(args[1])
    local duration = tonumber(args[2]) or Config.DefaultBanDuration
    local reason = table.concat(args, ' ', 3) or 'No reason provided'

    if not targetId then
        TriggerClientEvent('BanKickMuteSystem:notify', source, 'Usage: /ban [playerId] [duration] [reason]')
        return
    end

    local xPlayer = ESX.GetPlayerFromId(targetId)
    if not xPlayer then
        TriggerClientEvent('BanKickMuteSystem:notify', source, 'Player not found.')
        return
    end

    local identifier = xPlayer.identifier
    local admin = GetPlayerName(source)

    logAction(identifier, 'ban', reason, duration, admin)

    DropPlayer(targetId, 'You have been banned for ' .. duration .. ' minutes. Reason: ' .. reason)
    TriggerClientEvent('BanKickMuteSystem:notify', -1, xPlayer.getName() .. ' has been banned for ' .. duration .. ' minutes. Reason: ' .. reason)
end, false)

-- Command to kick a player
RegisterCommand(Config.Commands.Kick, function(source, args, rawCommand)
    if not isAdmin(source) then
        TriggerClientEvent('BanKickMuteSystem:notify', source, 'You do not have permission to use this command.')
        return
    end

    local targetId = tonumber(args[1])
    local reason = table.concat(args, ' ', 2) or 'No reason provided'

    if not targetId then
        TriggerClientEvent('BanKickMuteSystem:notify', source, 'Usage: /kick [playerId] [reason]')
        return
    end

    local xPlayer = ESX.GetPlayerFromId(targetId)
    if not xPlayer then
        TriggerClientEvent('BanKickMuteSystem:notify', source, 'Player not found.')
        return
    end

    local identifier = xPlayer.identifier
    local admin = GetPlayerName(source)

    logAction(identifier, 'kick', reason, 0, admin)

    DropPlayer(targetId, 'You have been kicked. Reason: ' .. reason)
    TriggerClientEvent('BanKickMuteSystem:notify', -1, xPlayer.getName() .. ' has been kicked. Reason: ' .. reason)
end, false)

-- Command to mute a player
RegisterCommand(Config.Commands.Mute, function(source, args, rawCommand)
    if not isAdmin(source) then
        TriggerClientEvent('BanKickMuteSystem:notify', source, 'You do not have permission to use this command.')
        return
    end

    local targetId = tonumber(args[1])
    local duration = tonumber(args[2]) or Config.DefaultMuteDuration
    local reason = table.concat(args, ' ', 3) or 'No reason provided'

    if not targetId then
        TriggerClientEvent('BanKickMuteSystem:notify', source, 'Usage: /mute [playerId] [duration] [reason]')
        return
    end

    local xPlayer = ESX.GetPlayerFromId(targetId)
    if not xPlayer then
        TriggerClientEvent('BanKickMuteSystem:notify', source, 'Player not found.')
        return
    end

    local identifier = xPlayer.identifier
    local admin = GetPlayerName(source)

    logAction(identifier, 'mute', reason, duration, admin)

    TriggerClientEvent('BanKickMuteSystem:notify', targetId, 'You have been muted for ' .. duration .. ' minutes. Reason: ' .. reason)
    TriggerClientEvent('BanKickMuteSystem:notify', -1, xPlayer.getName() .. ' has been muted for ' .. duration .. ' minutes. Reason: ' .. reason)
end, false)