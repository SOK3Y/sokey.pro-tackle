RegisterNetEvent(name..'TacklePlayer', function(target, ForwardVector)
    local sourcePlayer = ESX.GetPlayerFromId(source)
    local targetPlayer = ESX.GetPlayerFromId(target)
    TriggerClientEvent(name..'TacklePlayer', target, ForwardVector)
end)