Tunnel = module("vrp", "lib/Tunnel")
vRPUtils = Tunnel.getInterface("CaseMob", "CaseMob")
vRPGarage = Tunnel.getInterface("vrp_garages","src")

GetESX = function()
  while not ESX do
    TriggerEvent("esx:getSharedObject", function(obj)
      ESX = obj
    end)
    Wait(0)
  end
  while not ESX.IsPlayerLoaded() do Wait(0); end
end

GetFramework = function()
  if Config.UsingESX then
    GetESX()
  else
    -- NON-ESX USERS ADD HERE
  end
end

GetPlayerData = function()
  if Config.UsingESX then
    return ESX.GetPlayerData()
  else
    -- NON-ESX USERS ADD HERE
  end
end

SetPlayerData = function(data)
  PlayerData = data
end

SetPlayerJob = function(job)
  PlayerData = (PlayerData or GetPlayerData())
  if type(PlayerData) ~= "table" then
    _print("SetPlayerJob() Failed")
  else
    PlayerData.job = job
  end
end

GetPlayerCash = function()
  if Config.UsingESX then
    PlayerData = GetPlayerData()
    if Config["UsingESX_V1.2.0"] then
      for k,v in pairs(PlayerData.accounts) do
        if v.name == Config.CashAccountName then
          return v.money
        end
      end
    else
      return PlayerData.money
    end
  else
    --print(vRPUtils.getWallet())
    return vRPUtils.getWallet()
    -- NON-ESX USERS ADD HERE
  end
end

GetPlayerBank = function()
  if Config.UsingESX then
    PlayerData = GetPlayerData()
    for k,v in pairs(PlayerData.accounts) do
      if v.name == Config.BankAccountName then
        return v.money
      end
    end
    return 0
  else
    return vRPUtils.getBank()
    -- NON-ESX USERS ADD HERE
  end
end

CheckForLockpick = function()
  if Config.UsingESX then
    PlayerData = GetPlayerData()
    for k,v in pairs(PlayerData.inventory) do
      if v.name == Config.LockpickItem then
        return (v.count and v.count > 0 and true or false)
      end
    end
    return false
  else
    return vRPUtils.getitem("lockpick",1)
  end
end

GetPlayerJobName = function()
  if Config.UsingESX then
    PlayerData = GetPlayerData()
    return PlayerData.job.name
  else
    -- NON-ESX USERS ADD HERE
    return vRPUtils.getPlayerJob()
  end
end

GetPlayerJobRank = function()
  if Config.UsingESX then
    PlayerData = GetPlayerData()
    return PlayerData.job.grade
  else
    -- NON-ESX USERS ADD HERE
  end
end

GetPlayerIdentifier = function()
  if Config.UsingESX then
    PlayerData = GetPlayerData()
    return PlayerData.identifier
  else
    return vRPUtils.getId()
    -- NON-ESX USERS ADD HERE
  end
end

CanPlayerAfford = function(value)
  --print("Can player afford?",vRPUtils.getWallet(),value)
  if vRPUtils.getWallet() >= value then
    return true
  elseif vRPUtils.getBank() >= value then
    return true
  else
    return false
  end
end



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
  local jobName = vRPUtils.getPlayerJob(Config.PermiPolicia)
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

RegisterNetEvent("esx:updatePlayerData")
AddEventHandler("esx:updatePlayerData",SetPlayerData)

RegisterNetEvent("esx:setJob")
AddEventHandler("esx:setJob",SetPlayerJob)