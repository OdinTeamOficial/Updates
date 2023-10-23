Tunnel = module("vrp","lib/Tunnel")
Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
fodaSKI = Tunnel.getInterface(GetCurrentResourceName())

vRPGarage = Tunnel.getInterface("vrp_garages","src")




GetNearbyPlayers = function(pos,radius)
  if Config.UsingESX then
    return ESX.Game.GetPlayersInArea((pos or GetEntityCoords(GetPlayerPed(-1))),(radius or 20.0))
  else
    -- NON-ESX USERS ADD HERE
    local players = {}

    for _,player in ipairs(GetActivePlayers()) do
      local ped = GetPlayerPed(player)

      if DoesEntityExist(ped) then
        table.insert(players, player)
      end
    end
    local playersInArea = {}

    for i=1, #players, 1 do
      local target       = GetPlayerPed(players[i])
      local targetCoords = GetEntityCoords(target)
      local distance     = GetDistanceBetweenCoords(targetCoords, (pos or GetEntityCoords(GetPlayerPed(-1))), true)

      if distance <= (radius or 20.0) then
        table.insert(playersInArea, players[i])
      end
    end

    return playersInArea
  end

end

NotifyJob = function(job,msg,pos)
  local jobName = fodaSKI.getpermission(Config.PermiPolicia)
  if jobName then
    if pos then
      Citizen.CreateThread(function()
        local start = GetGameTimer()
        ShowNotification(Labels["InteractDrawText"]..Labels["TrackMessage"].."\n"..msg)
        while GetGameTimer() - start < 10000 do
          if IsControlJustPressed(0,47) then
            SetNewWaypoint(pos.x,pos.y)
            return
          end
          Wait(0)
        end
      end)
    else
      ShowNotification(msg)
    end
  end
end

RegisterNetEvent("Allhousing:NotifyJob")
AddEventHandler("Allhousing:NotifyJob",NotifyJob)