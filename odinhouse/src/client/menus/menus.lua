OpenMenu = function(...)
  if Config.UsingESX then
    if Config.UsingESXMenu then
      menuType = "ESX"
    elseif Config.UsingNativeUI then
      menuType = "NativeUI"
    end
  elseif Config.UsingNativeUI then
    menuType = "NativeUI"
  end

  if menuType == "NativeUI" then
    NativeUIHandler(...)
  elseif menuType == "ESX" then
    ESXMenuHandler(...)
  end
end

UnlockHouse = function(house)
  if InsideHouse then
    InsideHouse.Unlocked = true 
  else
    house.Unlocked = true
  end
  TriggerServerEvent("Allhousing:UnlockDoor",house)
  ShowNotification(Labels["Unlocked"])
  if Config.UsingNativeUI and _Pool then
    _Pool:CloseAllMenus()
  elseif Config.UsingESX and Config.UsingESXMenu then
    ESX.UI.Menu.CloseAll()
  end
end

LockHouse = function(house)
  if InsideHouse then
    InsideHouse.Unlocked = false 
  else
    house.Unlocked = false
  end
  TriggerServerEvent("Allhousing:LockDoor",house)
  ShowNotification(Labels["Locked"])
  if Config.UsingNativeUI and _Pool then
    _Pool:CloseAllMenus()
  elseif Config.UsingESX and Config.UsingESXMenu then
    ESX.UI.Menu.CloseAll()
  end
end

GetVehiclesAtHouse = function(house)
  local data = Callback("Allhousing:GetVehicles",house)
  return data
end

GetVehicleLabel = function(model)
  return (GetLabelText(GetDisplayNameFromVehicleModel(model)))
end

RegisterNetEvent('vrp_garages:mods')
AddEventHandler('vrp_garages:mods',function(vnet,custom)
  vehicleMods(NetToVeh(vnet),custom)
end)

SpawnVehicle = function(vehname,vehengine,vehbody,vehfuel,custom)  
  if Config.UsingESX and Config.UsingESXMenu then
    ESX.UI.Menu.CloseAll()
  end
	local mhash = GetHashKey(vehname)
	while not HasModelLoaded(mhash) do
		RequestModel(mhash)
		Citizen.Wait(1)
	end
	if HasModelLoaded(mhash) then

		local nveh = CreateVehicle(mhash,GetEntityCoords(PlayerPedId()),GetEntityHeading(PlayerPedId()),true,false)
    
		SetVehicleIsStolen(nveh,false)
		SetVehicleNeedsToBeHotwired(nveh,false)
		SetVehicleOnGroundProperly(nveh)
		SetVehicleNumberPlateText(nveh,vRP.getRegistrationNumber())
		SetEntityAsMissionEntity(nveh,true,true)
		SetVehRadioStation(nveh,"OFF")
		SetVehicleEngineHealth(nveh,vehengine+0.0)
		SetVehicleBodyHealth(nveh,vehbody+0.0)
		SetVehicleFuelLevel(nveh,vehfuel+0.0)
		vehicleMods(nveh,custom)
    TriggerEvent("nation:applymods",nveh,vehname)
    TriggerEvent("Odinhouse:addvehicle",VehToNet(nveh),mhash,GetVehicleNumberPlateText(nveh))
    
		SetModelAsNoLongerNeeded(mhash)
    SetPedIntoVehicle(PlayerPedId(), nveh, -1)

	end

end


ChestOpen = false
OpenInventory = function()
  if Config.UsingESX then
    if not Config.UsingDiscInventory then
      ESX.TriggerServerCallback('Allhousing:GetInventory', function(inventory)
        TriggerEvent("esx_inventoryhud:openPropertyInventory", inventory, false, false, InsideHouse)
      end,InsideHouse)  
    else
      TriggerEvent('disc-inventoryhud:openInventory', {
        type = 'allhousing',
        owner = "allhousing-"..InsideHouse.Id
      })
    end
  else
    -- NON ESX USERS FILL IN HERE
    local player = GetPlayerPed(-1)
    local x,y,z = table.unpack(GetEntityCoords(player))
    if ChestOpen == false then
      TriggerServerEvent("openchest", x,y,z)
      ChestOpen = true
    end
  end
end

RegisterNetEvent("closechest")
AddEventHandler("closechest",function()
  ChestOpen = false
end)

SetWardrobe = function(d)  
  if Config.UsingNativeUI and _Pool then
    _Pool:CloseAllMenus()
  elseif Config.UsingESX and Config.UsingESXMenu then
    ESX.UI.Menu.CloseAll()
  end

  ShowNotification(Labels["AcceptDrawText"]..Labels["SetWardrobe"])
  while true do
    if IsControlJustPressed(0,Config.Controles.Aceitar) then
      local pos = d.Entry.xyz - GetEntityCoords(GetPlayerPed(-1))
      InsideHouse.Wardrobe = pos + Config.SpawnOffset
      TriggerServerEvent("Allhousing:SetWardrobe",d,InsideHouse.Wardrobe)
      ShowNotification(Labels['WardrobeSet'])
      return
    end
    Wait(0)
  end
end

SetInventory = function(d)  
  if Config.UsingNativeUI and _Pool then
    _Pool:CloseAllMenus()
  elseif Config.UsingESX and Config.UsingESXMenu then
    ESX.UI.Menu.CloseAll()
  end

  ShowNotification(Labels["AcceptDrawText"]..Labels["SetInventory"])
  while true do
    if IsControlJustPressed(0,Config.Controles.Aceitar) then
      local pos = d.Entry.xyz - GetEntityCoords(GetPlayerPed(-1))
      InsideHouse.InventoryLocation = pos + Config.SpawnOffset
      TriggerServerEvent("Allhousing:SetInventory",d,InsideHouse.InventoryLocation)
      ShowNotification(Labels['InventorySet'])
      return
    end
    Wait(0)
  end
end

SetOutfit = function(index,label)  
  if Config.UsingNativeUI and _Pool then
    _Pool:CloseAllMenus()
  elseif Config.UsingESX and Config.UsingESXMenu then
    ESX.UI.Menu.CloseAll()
  end

  if Config.UsingESX then
    local clothes = Callback("Allhousing:GetOutfit",index)
    TriggerEvent('skinchanger:getSkin', function(skin)
      TriggerEvent('skinchanger:loadClothes', skin, clothes)
      TriggerEvent('esx_skin:setLastSkin', skin)

      TriggerEvent('skinchanger:getSkin', function(skin)
        TriggerServerEvent('esx_skin:save', skin)
      end)
    end)
  else
    -- NON-ESX USERS FILL IN HERE.
  end
end

OpenFurniture = function(d)
  ShowNotification(Labels["FurniDrawText"]..Labels["ToggleFurni"])
  TriggerEvent("Allhousing:OpenFurni")    

  if Config.UsingNativeUI and _Pool then
    _Pool:CloseAllMenus()
  elseif Config.UsingESX and Config.UsingESXMenu then
    ESX.UI.Menu.CloseAll()
  end
end

GiveKeys = function(d,serverId)
  TriggerServerEvent("Allhousing:GiveKeys",d,serverId)
  ShowNotification(Labels["GivingKeys"])
  if Config.UsingNativeUI and _Pool then
    _Pool:CloseAllMenus()
  elseif Config.UsingESX and Config.UsingESXMenu then
    ESX.UI.Menu.CloseAll()
  end
end

TakeKeys = function(d,data)
  TriggerServerEvent("Allhousing:TakeKeys",d,data)
  ShowNotification(Labels["TakingKeys"])

  if Config.UsingNativeUI and _Pool then
    _Pool:CloseAllMenus()
  elseif Config.UsingESX and Config.UsingESXMenu then
    ESX.UI.Menu.CloseAll()
  end
end

MoveGarage = function(d)
  local last_dist = Vdist(d.Garage.xyz,d.Entry.xyz)
  local ped = GetPlayerPed(-1)
  FreezeEntityPosition(ped,false)

  if Config.UsingNativeUI and _Pool then
    _Pool:CloseAllMenus()
  elseif Config.UsingESX and Config.UsingESXMenu then
    ESX.UI.Menu.CloseAll()
  end

  ShowNotification(Labels["AcceptDrawText"]..Labels["SetGarage"])
  while true do
    if IsControlJustPressed(0,Config.Controles.Aceitar) then
      ped = GetPlayerPed(-1)
      local pos = GetEntityCoords(ped)
      if Vdist(pos,d.Entry.xyz) <= last_dist+5.0 then
        local head = GetEntityHeading(ped)
        d.Garage = vector4(pos.x,pos.y,pos.z,head)
        TriggerServerEvent("Allhousing:SetGarageLocation",d.Id,d.Garage)
        ShowNotification(Labels["GarageSet"])
        return
      else
        ShowNotification(Labels["GarageTooFar"])
      end
    end
    Wait(0)
  end
end

InviteInside = function(d,serverId)
  TriggerServerEvent("Allhousing:InviteInside",d,serverId)
end

BuyHouse = function(d)
  local price = d.Price
  if CanPlayerAfford(price) then
    --print(vRPUtils.getHouses())
    --if vRPUtils.getHouses() == 1 then
      ShowNotification(string.format(Labels["PurchasedHouse"],price))
      d.Owner = GetPlayerIdentifier()
      d.Owned = true

      if Config.UsingNativeUI and _Pool then
        _Pool:CloseAllMenus()
      elseif Config.UsingESX and Config.UsingESXMenu then      
        ESX.UI.Menu.CloseAll()
      end

      TriggerServerEvent("Allhousing:PurchaseHouse",d)
    --else
     -- ShowNotification("~w~[~b~Ze~y~nTr~r~ix~w~] ~r~Nu poti avea 2 sau mai multe case.")
    --end
  --else
    --ShowNotification(Labels["CantAffordHouse"])
  end
  if Config.UsingNativeUI and _Pool then
    _Pool:CloseAllMenus()
  elseif Config.UsingESX and Config.UsingESXMenu then      
    ESX.UI.Menu.CloseAll()
  end
  FreezeEntityPosition(GetPlayerPed(-1),false)
end

MortgageHouse = function(d)
  local price = math.floor((d.Price / 100) * Config.MortgagePercent)
  if CanPlayerAfford(price) then
    ShowNotification(string.format(Labels["MortgagedHouse"],price))
    d.Owner = GetPlayerIdentifier()
    d.Owned = true

    if Config.UsingNativeUI and _Pool then
      _Pool:CloseAllMenus()
    elseif Config.UsingESX and Config.UsingESXMenu then      
      ESX.UI.Menu.CloseAll()
    end

    TriggerServerEvent("Allhousing:MortgageHouse",d)
  else
    ShowNotification(Labels["CantAffordHouse"])
  end
  FreezeEntityPosition(GetPlayerPed(-1),false)
end

RaidHouse = function(d)
  EnterHouse(d,not Config.PoliciaAcessarInv)
end

KnockOnDoor = function(d)  
  if Config.UsingNativeUI and _Pool then
    _Pool:CloseAllMenus()
  elseif Config.UsingESX and Config.UsingESXMenu then
    ESX.UI.Menu.CloseAll()
  end

  GoToDoor(d.Entry)
  FaceCoordinate(d.Entry)
  TriggerServerEvent("Allhousing:KnockOnDoor",d.Entry)
  local plyPed = GetPlayerPed(-1)
  while not HasAnimDictLoaded("timetable@jimmy@doorknock@") do RequestAnimDict("timetable@jimmy@doorknock@"); Wait(0); end
  TaskPlayAnim(plyPed, "timetable@jimmy@doorknock@", "knockdoor_idle", 8.0, 8.0, -1, 4, 0, 0, 0, 0 )     
  Wait(0)

  while IsEntityPlayingAnim(plyPed, "timetable@jimmy@doorknock@", "knockdoor_idle", 3) do Citizen.Wait(0); end 

  RemoveAnimDict("timetable@jimmy@door@knock@")
end

BreakInHouse = function(d)  
  if Config.UsingNativeUI and _Pool then
    _Pool:CloseAllMenus()
  elseif Config.UsingESX and Config.UsingESXMenu then
    ESX.UI.Menu.CloseAll()
  end

  GoToDoor(d.Entry)
  FaceCoordinate(d.Entry)

  if Config.PrecisaDeLockpick then
    local hasItem = CheckForLockpick()
    if not hasItem then
      ShowNotification(Labels["NoLockpick"])
      return
    end
  end

  local plyPed = GetPlayerPed(-1)
  local plyPos = GetEntityCoords(GetPlayerPed(-1))
  local zoneName = GetNameOfZone(plyPos.x,plyPos.y,plyPos.z)
  while not HasAnimDictLoaded("mini@safe_cracking") do RequestAnimDict("mini@safe_cracking"); Citizen.Wait(0); end
  TaskPlayAnim(plyPed, "mini@safe_cracking", "idle_base", 1.0, 1.0, -1, 1, 0, 0, 0, 0 ) 
  Wait(2000)
  if Config.UsingLockpickV1 then
    TriggerEvent("lockpicking:StartMinigame",4,function(didWin)
      if didWin then
        EnterHouse(d,true)
      else
        ClearPedTasksImmediately(plyPed)
        if Config.QuebrarLockpickFalha then
          TriggerServerEvent("Allhousing:BreakLockpick")
        end
        ShowNotification(Labels["LockpickFailed"])
        FreezeEntityPosition(plyPed,false)
        TriggerServerEvent("Allhousing:NotifyJobs",k,string.format(Labels["NotifyRobbery"],zoneName),d.Entry)
      end
    end)
  elseif Config.UsingLockpickV2 then
    exports["lockpick"]:Lockpick(function(didWin)
      if didWin then
        EnterHouse(d,true)
        ShowNotification(Labels["LockpickSuccess"])
      else
        ClearPedTasksImmediately(plyPed)
        if Config.QuebrarLockpickFalha then
          TriggerServerEvent("Allhousing:BreakLockpick")
        end
        ShowNotification(Labels["LockpickFailed"])
        FreezeEntityPosition(plyPed,false)
        TriggerServerEvent("Allhousing:NotifyJobs",k,string.format(Labels["NotifyRobbery"],zoneName),d.Entry)
      end
    end)
  else
    if Config.UsingProgressBars then
      TriggerEvent("progress",Config.TempoLockpick * 1000,Labels["ProgressLockpicking"])
    end
    Wait(Config.TempoLockpick * 1000)
    if math.random(100) < Config.ChanceDeFalhar then
      if Config.QuebrarLockpickFalha then
        TriggerServerEvent("Allhousing:BreakLockpick")
      end
      TriggerServerEvent("Allhousing:NotifyJobs",k,string.format(Labels["NotifyRobbery"],zoneName),d.Entry)
      ClearPedTasksImmediately(plyPed)
      ShowNotification(Labels["LockpickFailed"])
      FreezeEntityPosition(plyPed,false)
    else
      EnterHouse(d,true)
    end
  end
  RemoveAnimDict("mini@safe_cracking")
end

LeaveHouse = function(d)
  LeavingHouse = true
  if Config.UsingNativeUI and _Pool then
    _Pool:CloseAllMenus()
  elseif Config.UsingESX and Config.UsingESXMenu then
    ESX.UI.Menu.CloseAll()
  end

  DoScreenFadeOut(500)
  TriggerEvent("Allhousing:Leave")
  Wait(1000)

  local plyPed = GetPlayerPed(-1)

  SetEntityCoordsNoOffset(plyPed, InsideHouse.Entry.x,InsideHouse.Entry.y,InsideHouse.Entry.z)
  SetEntityHeading(plyPed, InsideHouse.Entry.w - 180.0)

  Wait(500)
  DoScreenFadeIn(500)

  SetEntityAsMissionEntity(InsideHouse.Object,true,true)
  DeleteObject(InsideHouse.Object)
  DeleteEntity(InsideHouse.Object)

  if InsideHouse and InsideHouse.Extras then
    for k,v in pairs(InsideHouse.Extras) do
      SetEntityAsMissionEntity(v,true,true)
      DeleteObject(v)
    end
  end

  InsideHouse = false
  SetWeatherAndTime(true)
  LeavingHouse = false
  TriggerEvent("closewardrobe")
  TriggerEvent("closechest")
end

RegisterNetEvent("LeaveCasa")
AddEventHandler("LeaveCasa", function()
  if InsideHouse then

    TriggerEvent("Allhousing:Leave")
    SetEntityAsMissionEntity(InsideHouse.Object,true,true)
    DeleteObject(InsideHouse.Object)
    DeleteEntity(InsideHouse.Object)
  
    if InsideHouse and InsideHouse.Extras then
      for k,v in pairs(InsideHouse.Extras) do
        SetEntityAsMissionEntity(v,true,true)
        DeleteObject(v)
      end
    end
  
    InsideHouse = false
    SetWeatherAndTime(true)
    LeavingHouse = false

  end

end)

SpawnHouse = function(d)
  local model = ShellModels[d.Shell]
  local hash  = GetHashKey(model)

  local start = GetGameTimer()
  RequestModel(hash)
  while not HasModelLoaded(hash) and GetGameTimer() - start < 30000 do Wait(0); end
  if not HasModelLoaded(hash) then
    ShowNotification(string.format(Labels["InvalidShell"],model))
    return false,false
  end

  local shell = CreateObject(hash, d.Entry.x + Config.SpawnOffset.x,d.Entry.y + Config.SpawnOffset.y,d.Entry.z - 30.0 + Config.SpawnOffset.z,false,false)
  FreezeEntityPosition(shell,true)
  --print(d.Entry.x + Config.SpawnOffset.x,d.Entry.y + Config.SpawnOffset.y,d.Entry.z - 30.0 + Config.SpawnOffset.z)
  start = GetGameTimer()
  while not DoesEntityExist(shell) and GetGameTimer() - start < 30000 do Wait(0); end
  if not DoesEntityExist(shell) then
    ShowNotification(string.format(Labels["ShellNotLoaded"],model))
    return false,false
  end

  SetEntityAsMissionEntity(shell,true,true)
  SetModelAsNoLongerNeeded(hash)

  local extras = {}
  if ShellExtras[d.Shell] then
    for objHash,data in pairs(ShellExtras[d.Shell]) do
      RequestModel(objHash)
      start = GetGameTimer()
      while not HasModelLoaded(objHash) and GetGameTimer() - start < 10000 do Wait(0); end
      if HasModelLoaded(objHash) then
        local pos = d.Entry.xyz + data.offset + Config.SpawnOffset
        local rot = data.rotation
        local obj = CreateObject(objHash, pos.x,pos.y,pos.z - 30.0, false,false)
        FreezeEntityPosition(obj,true)
        if rot then SetEntityRotation(obj,rot.x,rot.y,rot.z,2) end
        SetEntityAsMissionEntity(obj,true,true)
        SetModelAsNoLongerNeeded(objHash)
        table.insert(extras,obj)
      end
    end
  end

  local furni = Callback("Allhousing:GetFurniture",d.Id)
  local pos   = vector3(d.Entry.x,d.Entry.y,d.Entry.z)

  if furni then
  for k,v in pairs(furni) do
    local objHash = GetHashKey(v.model)
    RequestModel(objHash)
    start = GetGameTimer()
    while not HasModelLoaded(objHash) and GetGameTimer() - start < 10000 do Wait(0); end
    if HasModelLoaded(objHash) then
      local obj = CreateObject(objHash, pos.x + v.pos.x, pos.y + v.pos.y, pos.z + v.pos.z, false,false,false)
      FreezeEntityPosition(obj, true)
      SetEntityCoordsNoOffset(obj, pos.x + v.pos.x, pos.y + v.pos.y, pos.z + v.pos.z)
      SetEntityRotation(obj, v.rot.x, v.rot.y, v.rot.z, 2)

      SetModelAsNoLongerNeeded(objHash)

      table.insert(extras,obj)
    end
  end
end

  return shell,extras
end

TeleportInside = function(d,v)  
  local exitOffset = vector4(ShellOffsets[d.Shell]["exit"].x - Config.SpawnOffset.x,ShellOffsets[d.Shell]["exit"].y - Config.SpawnOffset.y,ShellOffsets[d.Shell]["exit"].z - Config.SpawnOffset.z,ShellOffsets[d.Shell]["exit"].w)
  if type(exitOffset) ~= "vector4" or exitOffset.w == nil then
    ShowNotification(string.format(Labels["BrokenOffset"],d.Id))
    return
  end

  local plyPed = GetPlayerPed(-1)
  FreezeEntityPosition(plyPed,true)

  DoScreenFadeOut(1000)
  Wait(1500)

  ClearPedTasksImmediately(plyPed)

  local shell,extras = SpawnHouse(d)
  if shell and extras then
    SetEntityCoordsNoOffset(plyPed, d.Entry.x - exitOffset.x,d.Entry.y - exitOffset.y,d.Entry.z - exitOffset.z)
    SetEntityHeading(plyPed, exitOffset.w)

    local start_time = GetGameTimer()
    while (not HasCollisionLoadedAroundEntity(plyPed) and GetGameTimer() - start_time < 5000) do Wait(0); end
    FreezeEntityPosition(plyPed,false)

    DoScreenFadeIn(500)

    InsideHouse = d
    InsideHouse.Extras    = extras
    InsideHouse.Object    = shell
    InsideHouse.Visiting  = v  
  else
    FreezeEntityPosition(plyPed,false)
    DoScreenFadeIn(500)
  end
end

ViewHouse = function(d)
  EnterHouse(d,true)
  
  if Config.UsingNativeUI and _Pool then
    _Pool:CloseAllMenus()
  elseif Config.UsingESX and Config.UsingESXMenu then
    ESX.UI.Menu.CloseAll()
  end
end

EnterHouse = function(d,visiting)
  if Config.UsingNativeUI and _Pool then
    _Pool:CloseAllMenus()
  elseif Config.UsingESX and Config.UsingESXMenu then    
    ESX.UI.Menu.CloseAll()
  end

  TriggerEvent("Allhousing:Enter",d)
  TeleportInside(d,visiting)
  SetWeatherAndTime(false)
end

UpgradeHouse = function(d,data)
  if CanPlayerAfford(ShellPrices[data.shell]) then
    TriggerServerEvent("Allhousing:UpgradeHouse",d,data.shell)
    ShowNotification(string.format(Labels["UpgradeHouse"],tostring(data.shell)))
    d.Shell = data.shell
    if InsideHouse then
      local _visiting = InsideHouse.Visiting
      LeaveHouse(d)
      EnterHouse(d,_visiting)
    end
  else
    ShowNotification(Labels["CantAffordUpgrade"])
  end

  if Config.UsingNativeUI and _Pool then
    _Pool:CloseAllMenus()
  elseif Config.UsingESX and Config.UsingESXMenu then
    ESX.UI.Menu.CloseAll()
  end
end

SellHouse = function(d)
  if Config.UsingNativeUI and _Pool then
    _Pool:CloseAllMenus()
  elseif Config.UsingESX and Config.UsingESXMenu then
    ESX.UI.Menu.CloseAll()
  end

  if not d.MortgageOwed or d.MortgageOwed <= 0 then
    exports["input"]:Open(Labels["SetSalePrice"],(Config.UsingESX and Config.UsingESXMenu and "ESX" or "Native"), function(data)
      local price = (tonumber(data) and tonumber(data) > 0 and tonumber(data) or 0)
      local floored = math.max(1,math.floor(tonumber(price)))

      Wait(100)

      if Config.UsingESX and Config.UsingESXMenu then
        ESXConfirmSaleMenu(d,floored)
      elseif Config.UsingNativeUI then
        NativeConfirmSaleMenu(d,floored)
      end
    end)
  else
    ShowNotification(Labels["InvalidSale"])
  end
end

RepayMortgage = function(d)
  if Config.UsingNativeUI and _Pool then
    _Pool:CloseAllMenus()
  elseif Config.UsingESX and Config.UsingESXMenu then
    ESX.UI.Menu.CloseAll()
  end

  local min_repayment = math.floor((d.MortgageOwed / 100) * Config.MortgageMinRepayment)
  if GetPlayerCash() > min_repayment or GetPlayerBank() > min_repayment then
    exports["input"]:Open(string.format("Min: $%i",min_repayment),(Config.UsingESX and Config.UsingESXMenu and "ESX" or "Native"),function(res)
      local repay = tonumber(res)
      if repay == nil or not repay then
        ShowNotification(Labels["InvalidAmount"])
      else
        repay = math.floor(repay)
        if repay < min_repayment then
          ShowNotification(Labels["InvalidAmount"])
        else
          if GetPlayerCash() > repay or GetPlayerBank() > repay then
            TriggerServerEvent("Allhousing:RepayMortgage",d.Id,repay)
          else
            ShowNotification(Labels["InvalidMoney"])
          end
        end
      end
    end)
  else
  end
end

RevokeTenancy = function(d)
  if Config.UsingNativeUI and _Pool then
    _Pool:CloseAllMenus()
  elseif Config.UsingESX and Config.UsingESXMenu then
    ESX.UI.Menu.CloseAll()
  end

  ESX.UI.Menu.CloseAll()
  ShowNotification(Labels["EvictingTenants"])
  TriggerServerEvent("Allhousing:RevokeTenancy",d)
end

MenuThread = function()
  while true do      
    if _Pool and _Pool:IsAnyMenuOpen() then
      _Pool:ControlDisablingEnabled(false)
      _Pool:MouseControlsEnabled(false)
      _Pool:ProcessMenus()
    end
    Wait(0)
  end
end

vehicleMods = function(veh,custom)
	if custom and veh then
		SetVehicleModKit(veh,0)
		if custom.color then
			SetVehicleColours(veh,tonumber(custom.color[1]),tonumber(custom.color[2]))
			SetVehicleExtraColours(veh,tonumber(custom.extracolor[1]),tonumber(custom.extracolor[2]))
		end

		if custom.smokecolor then
			SetVehicleTyreSmokeColor(veh,tonumber(custom.smokecolor[1]),tonumber(custom.smokecolor[2]),tonumber(custom.smokecolor[3]))
		end

		if custom.neon then
			SetVehicleNeonLightEnabled(veh,0,1)
			SetVehicleNeonLightEnabled(veh,1,1)
			SetVehicleNeonLightEnabled(veh,2,1)
			SetVehicleNeonLightEnabled(veh,3,1)
			SetVehicleNeonLightsColour(veh,tonumber(custom.neoncolor[1]),tonumber(custom.neoncolor[2]),tonumber(custom.neoncolor[3]))
		else
			SetVehicleNeonLightEnabled(veh,0,0)
			SetVehicleNeonLightEnabled(veh,1,0)
			SetVehicleNeonLightEnabled(veh,2,0)
			SetVehicleNeonLightEnabled(veh,3,0)
		end

		if custom.plateindex then
			SetVehicleNumberPlateTextIndex(veh,tonumber(custom.plateindex))
		end

		if custom.windowtint then
			SetVehicleWindowTint(veh,tonumber(custom.windowtint))
		end

		if custom.bulletProofTyres then
			SetVehicleTyresCanBurst(veh,custom.bulletProofTyres)
		end

		if custom.wheeltype then
			SetVehicleWheelType(veh,tonumber(custom.wheeltype))
		end

		if custom.spoiler then
			SetVehicleMod(veh,0,tonumber(custom.spoiler))
			SetVehicleMod(veh,1,tonumber(custom.fbumper))
			SetVehicleMod(veh,2,tonumber(custom.rbumper))
			SetVehicleMod(veh,3,tonumber(custom.skirts))
			SetVehicleMod(veh,4,tonumber(custom.exhaust))
			SetVehicleMod(veh,5,tonumber(custom.rollcage))
			SetVehicleMod(veh,6,tonumber(custom.grille))
			SetVehicleMod(veh,7,tonumber(custom.hood))
			SetVehicleMod(veh,8,tonumber(custom.fenders))
			SetVehicleMod(veh,10,tonumber(custom.roof))
			SetVehicleMod(veh,11,tonumber(custom.engine))
			SetVehicleMod(veh,12,tonumber(custom.brakes))
			SetVehicleMod(veh,13,tonumber(custom.transmission))
			SetVehicleMod(veh,14,tonumber(custom.horn))
			SetVehicleMod(veh,15,tonumber(custom.suspension))
			SetVehicleMod(veh,16,tonumber(custom.armor))
			SetVehicleMod(veh,23,tonumber(custom.tires),custom.tiresvariation)
		
			if IsThisModelABike(GetEntityModel(veh)) then
				SetVehicleMod(veh,24,tonumber(custom.btires),custom.btiresvariation)
			end
		
			SetVehicleMod(veh,25,tonumber(custom.plateholder))
			SetVehicleMod(veh,26,tonumber(custom.vanityplates))
			SetVehicleMod(veh,27,tonumber(custom.trimdesign)) 
			SetVehicleMod(veh,28,tonumber(custom.ornaments))
			SetVehicleMod(veh,29,tonumber(custom.dashboard))
			SetVehicleMod(veh,30,tonumber(custom.dialdesign))
			SetVehicleMod(veh,31,tonumber(custom.doors))
			SetVehicleMod(veh,32,tonumber(custom.seats))
			SetVehicleMod(veh,33,tonumber(custom.steeringwheels))
			SetVehicleMod(veh,34,tonumber(custom.shiftleavers))
			SetVehicleMod(veh,35,tonumber(custom.plaques))
			SetVehicleMod(veh,36,tonumber(custom.speakers))
			SetVehicleMod(veh,37,tonumber(custom.trunk)) 
			SetVehicleMod(veh,38,tonumber(custom.hydraulics))
			SetVehicleMod(veh,39,tonumber(custom.engineblock))
			SetVehicleMod(veh,40,tonumber(custom.camcover))
			SetVehicleMod(veh,41,tonumber(custom.strutbrace))
			SetVehicleMod(veh,42,tonumber(custom.archcover))
			SetVehicleMod(veh,43,tonumber(custom.aerials))
			SetVehicleMod(veh,44,tonumber(custom.roofscoops))
			SetVehicleMod(veh,45,tonumber(custom.tank))
			SetVehicleMod(veh,46,tonumber(custom.doors))
			SetVehicleMod(veh,48,tonumber(custom.liveries))
			SetVehicleLivery(veh,tonumber(custom.liveries))

			ToggleVehicleMod(veh,20,tonumber(custom.tyresmoke))
			ToggleVehicleMod(veh,22,tonumber(custom.headlights))
			ToggleVehicleMod(veh,18,tonumber(custom.turbo))
		end
	end
end

Citizen.CreateThread(MenuThread)