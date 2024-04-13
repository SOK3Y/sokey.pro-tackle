local isJumping = false
local tackling = false

Citizen.CreateThread(function()
	while true do
		Wait(200)
		if IsPedJumping(ESX.PlayerData.ped) and not isJumping and not tackling then
            isJumping = true
			Wait(150)
			if IsControlPressed(0, 22) then
				if not IsPedInAnyVehicle(ESX.PlayerData.ped) and IsPedOnFoot(ESX.PlayerData.ped) then
					local ForwardVector = GetEntityForwardVector(ESX.PlayerData.ped)
					local Tackled = {}
					tackling = true
					SetPedToRagdollWithFall(ESX.PlayerData.ped, 1000, 1500, 0, ForwardVector, 1.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0)
					while IsPedRagdoll(ESX.PlayerData.ped) do
						Citizen.Wait(0)
						for k, v in ipairs(GetTouchedPlayers()) do
							if not Tackled[v] then
								Tackled[v] = true
								TriggerServerEvent(name..'TacklePlayer', GetPlayerServerId(v), ForwardVector)
							end
							tackling = false
						end
					end
				end
			end
        elseif not IsPedJumping(ESX.PlayerData.ped) and isJumping then
            isJumping = false
        end
	end
end)

RegisterNetEvent(name..'TacklePlayer')
AddEventHandler(name..'TacklePlayer',function(ForwardVector)
    SetPedToRagdollWithFall(ESX.PlayerData.ped, 1000, 1500, 0, ForwardVector, 10.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0) 
end)

function GetPlayers()
	local players = {}
	tackling = false
	for i = 0, 512 do
		if NetworkIsPlayerActive(i) then
			table.insert(players, i)
		end
	end
	return players
end

function GetTouchedPlayers()
	local touchedPlayer = {}
    tackling = false
    for k, v in ipairs(GetPlayers()) do
        if IsEntityTouchingEntity(ESX.PlayerData.ped, GetPlayerPed(v)) then
            table.insert(touchedPlayer, v)
        end
    end
    return touchedPlayer
end
