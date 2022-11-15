--local Tunnel = module("vrp", "lib/Tunnel")
--vRPUtils = Tunnel.getInterface("utils", "utils")

NativeUIHandler = function(d,t,st)

  if t == "Entry" then
    --print(st)
    if st == "Owner" then
      NativeEntryOwnerMenu(d)
    elseif st == "Owned" then
      NativeEntryOwnedMenu(d)
    elseif st == "Empty" then
      
      NativeEntryEmptyMenu(d)
    end
  elseif t == "Garage" then
    if st == "Owner" then
      NativeGarageOwnerMenu(d)
    elseif st == "Owned" then
      NativeGarageOwnedMenu(d)
    end
  elseif t == "Exit" then
    if st == "Owner" then
      NativeExitOwnerMenu(d)
    elseif st == "Owned" then
      NativeExitOwnedMenu(d)
    elseif st == "Empty" then
      NativeExitEmptyMenu(d)
    end
  elseif t == "Wardrobe" then
    if st == "Owner" or st == "Owned" then
      NativeWardrobeMenu(d)
    end
  elseif t == "InventoryLocation" then
    openinventoryhouse(d)
  end
end

CreateNativeUIMenu = function(title,subtitle)
  if _Pool then _Pool:Remove(); end
  _Pool = NativeUI.CreatePool()

  local ResX,ResY = GetActiveScreenResolution()
  local xPos = ResX - (ResX > 2560 and 1050 or 550)
  local menu = NativeUI.CreateMenu(title,subtitle,xPos,250)

  _Pool:Add(menu)

  return menu
end

NativeConfirmSaleMenu = function(d,floored)
  _Pool:CloseAllMenus()

  local sellMenu = CreateNativeUIMenu(Labels['ConfirmationSalehouse'],Labels['SellingHouse']..""..tostring(floored))

  local confirm = NativeUI.CreateItem(Labels['ConfirmSale'],Labels['Confirmationhouse'])
  confirm.Activated = function(...) 
    ShowNotification("Selling house for $"..tostring(floored))
    d.Owner = ""
    d.Owned = false

    if InsideHouse then LeaveHouse(d); end
    TriggerServerEvent("Allhousing:SellHouse",d,floored)

    _Pool:CloseAllMenus()
  end
  sellMenu:AddItem(confirm)

  local cancel = NativeUI.CreateItem(Labels['CancelSale'],Labels['CancelSellHouse'])
  cancel.Activated = function(...) 
    _Pool:CloseAllMenus()
  end
  sellMenu:AddItem(cancel)

  sellMenu:RefreshIndex()
  sellMenu:Visible(true)
end

NativeOpenInvite = function(d)  
  _Pool:CloseAllMenus()

  local inviteMenu = CreateNativeUIMenu(Labels['InviteInside'],"")

  local players = GetNearbyPlayers(d.Entry,20.0)
  local c = 0
  for _,player in pairs(players) do
    local _item = NativeUI.CreateItem(GetPlayerName(player),Labels['InviteInside'])
    _item.Activated = function(...) InviteInside(d,GetPlayerServerId(player)); end
    inviteMenu:AddItem(_item)
    c = c + 1
  end

  if c == 0 then
    local _item = NativeUI.CreateItem(Labels['NoplayersNerHouse'],"")
    inviteMenu:AddItem(_item)
  end

  inviteMenu:RefreshIndex()
  inviteMenu:Visible(true)
end

NativeCreateKeysMenu = function(d,menu) 
  local keys = _Pool:AddSubMenu(menu,Labels['HouseKeys'],d.Shell,true,true) 
  local giveKeys = _Pool:AddSubMenu(keys.SubMenu,Labels['GiveKeys'],d.Shell,true,true)
  local takeKeys = _Pool:AddSubMenu(keys.SubMenu,Labels['TakeKeys'],d.Shell,true,true)
  keys.SubMenu:RefreshIndex()

  local plyPed = GetPlayerPed(-1)
  local nearbyPlayers = GetNearbyPlayers()
  local c = 0
  for _,player in pairs(nearbyPlayers) do
    if player ~= plyPed then
      local _item = NativeUI.CreateItem(GetPlayerName(player),Labels['GiveKeys'])
      _item:RightLabel("ID: "..player)
      _item.Activated = function(...) GiveKeys(d,GetPlayerServerId(player)); end
      giveKeys.SubMenu:AddItem(_item)
      c = c + 1
    end
  end

  if c == 0 then
    local _item = NativeUI.CreateItem("No players nearby","")
    giveKeys.SubMenu:AddItem(_item)
  end

  c = 0
  for k,v in pairs(Houses) do
    if v.Entry == d.Entry then
      for _,data in pairs(v.HouseKeys) do
        local _item = NativeUI.CreateItem(data.name,Labels['TakeKeys'])
        _item.Activated = function(...) TakeKeys(v,data); end
        takeKeys.SubMenu:AddItem(_item)
        c = c + 1
      end
    end
  end

  if c == 0 then
    local _item = NativeUI.CreateItem(Labels['NoPlayersKey'],"")
    takeKeys.SubMenu:AddItem(_item)
  end

  giveKeys.SubMenu:RefreshIndex()
  takeKeys.SubMenu:RefreshIndex()
end

NativeCreateUpgradeMenu = function(d,menu,empty)  
  local upgrade = _Pool:AddSubMenu(menu,(not empty and Labels['Upgradesdispo'] or Labels['Availableupgrades']),d.Shell,true,true)
  local c = 0
  local dataTable = {}
  local sortedTable = {}
  for k,v in pairs(d.Shells) do
    local price = ShellPrices[k]
    if price then
      dataTable[price.."_"..k] = {
        available = v,
        price = price,
        shell = k,
      }
      table.insert(sortedTable,price.."_"..k)
    end
  end
  table.sort(sortedTable)

  for key,price in pairs(sortedTable) do
    local data = dataTable[price]
    if data.available and d.Shell ~= data.shell then
      local _item = NativeUI.CreateItem(data.shell,d.Shell)
      _item:RightLabel("$"..data.price)
      if not empty then 
        _item.Activated = function(...) UpgradeHouse(d,data); end 
      end
      upgrade.SubMenu:AddItem(_item)
      c = c + 1
    end    
  end

  if c == 0 then
    local _item = NativeUI.CreateItem("No upgrades available","")
    upgrade.SubMenu:AddItem(_item)
  end
  upgrade.SubMenu:RefreshIndex()
end

NativeCreateMortgageMenu = function(d,menu,paying)  
  if d.MortgageOwed and d.MortgageOwed > 0 then
    local mortgage_info = Callback("Allhousing:GetMortgageInfo",d)
    local mortgage = _Pool:AddSubMenu(menu,"Mortgage","",true,true)

    local owed = NativeUI.CreateItem(string.format("Mortgage Owed: $%i",mortgage_info.MortgageOwed),"")
    mortgage.SubMenu:AddItem(owed)

    local repayment = NativeUI.CreateItem(string.format("Last Repayment: %s",mortgage_info.LastRepayment),"")
    mortgage.SubMenu:AddItem(repayment)

    if paying then
      local repay = NativeUI.CreateItem("Repay Mortgage","")
      mortgage.SubMenu:AddItem(repay)
      repay.Activated = function(...)
        RepayMortgage(d)
      end
    else
      local evict = NativeUI.CreateItem("Evict Tenants","")
      evict.Activated = function(...)
        RevokeTenancy(d)
      end
      mortgage.SubMenu:AddItem(evict)
    end

    mortgage.SubMenu:RefreshIndex()
  end
end

NativeCreateSellMenu = function(d,menu)
  local sell = _Pool:AddSubMenu(menu,Labels['SellHouse'],d.Shell,true,true)  
  local verifyItem = NativeUI.CreateItem(Labels['Verify'],Labels['ConfirmSale'])
  local cancelItem = NativeUI.CreateItem(Labels['CancelSellHouse'],Labels['CancelSale'])

  verifyItem.Activated = function() _Pool:CloseAllMenus(); SellHouse(d); end
  cancelItem.Activated = function() _Pool:CloseAllMenus(); end

  sell.SubMenu:AddItem(verifyItem)
  sell.SubMenu:AddItem(cancelItem)
  sell.SubMenu:RefreshIndex()
end

--Tunnel = module("vrp", "lib/Tunnel")
--vRPUtils = Tunnel.getInterface("utils", "utils")

WardrobeOpen = false
NativeWardrobeMenu = function(d)
  local player = GetPlayerPed(-1)
  local wardrobeMenu = CreateNativeUIMenu("House Wardrobe","My House")

  local outfits = Callback("Allhousing:GetOutfits")
  if not outfits or #outfits <= 0 then
    ShowNotification("You don't have any outfits stored.")
    return
  end

  if (#outfits > 0) then
    for i,label in pairs(outfits) do
      local outfit = NativeUI.CreateItem(label,"Select Outfit")
      outfit.Activated = function(...) SetOutfit(i,label); end
      wardrobeMenu:AddItem(outfit)
    end
  else
    local invalid = NativeUI.CreateItem("No outfits available","")
    wardrobeMenu:AddItem(invalid)
  end

  wardrobeMenu:RefreshIndex()
  wardrobeMenu:Visible(true)
  if WardrobeOpen == false then
    local x, y, z = table.unpack(GetEntityCoords(player))
    WardrobeOpen = true
    TriggerServerEvent("openWardrobe",x,y,z)
  end
end

RegisterNetEvent("closewardrobe")
AddEventHandler("closewardrobe",function()
  WardrobeOpen = false
end)

DoOpenNativeGarage = function(d)
  local garageMenu = CreateNativeUIMenu(Labels['Garage'],Labels['MyHouse'])



  local vehicles = GetVehiclesAtHouse(d)
  
  if (#vehicles > 0) then
    for _,vehData in pairs(vehicles) do
      local vehicle = NativeUI.CreateItem(GetVehicleLabel(vehData.vehicle),Labels['SpawnVehicle'])
      vehicle.Activated = function(...) 
        if guardou == true then
          TriggerServerEvent('Allhousing:VehicleSpawned',vehData.vehicle.plate)
          SpawnVehicle(d.Garage,vehData.vehicle.model,vehData.vehicle)
        end
      end
      garageMenu:AddItem(vehicle)
    end
  else
    local invalid = NativeUI.CreateItem(Labels['NoVehicles'],"")
    garageMenu:AddItem(invalid)
  end

  garageMenu:RefreshIndex()
  garageMenu:Visible(true)
end



NativeGarageOwnerMenu = function(d)
  local ped = GetPlayerPed(-1)
  if IsPedInAnyVehicle(ped,false) then
    local veh = GetVehiclePedIsUsing(ped)
    local props = GetVehicleProperties(veh)
    local veiculoplayer = GetVehiclesAtHouse()
    --local ownerInfo = Callback("Allhousing:GetVehicleOwner",props.plate)

    local canStore = false
    local identifier = GetPlayerIdentifier()
    local guardou = nil

    if tonumber(d.Owner) == tonumber(identifier) then

      canStore = true
    else
      for k,v in pairs(d.HouseKeys) do
        if v.identifier == identifier then
          canStore = true
          break
        end
      end
    end


    for k,v in pairs(veiculoplayer) do
      if (GetDisplayNameFromVehicleModel(props.model):lower()) == v.spawn then

        if v.retirado == false then

          canStore = false
        end
      end
    end

    if vRP.getRegistrationNumber() ~= props.plate then

      canStore = false
    end

    if canStore then

      TaskEveryoneLeaveVehicle(veh)
      SetEntityAsMissionEntity(veh,true,true)
      DeleteVehicle(veh)

      TriggerServerEvent("Allhousing:VehicleStored",props,(GetDisplayNameFromVehicleModel(props.model):lower()))
      TriggerServerEvent("nation:removeVehicle",nil,props.model,props.plate)
      
      ShowNotification(Labels["VehicleStored"])

    else
      ShowNotification(Labels["CantStoreVehicle"])
    end
    FreezeEntityPosition(GetPlayerPed(-1),false)
  else
    local garageMenu = CreateNativeUIMenu(Labels['Garage'],Labels['MyHouse'])


    local vehicles = GetVehiclesAtHouse()
    if (#vehicles > 0) then
      for _,vehData in pairs(vehicles) do
        local vehicle = NativeUI.CreateItem(GetVehicleLabel(vehData.spawn),Labels['SpawnVehicle'])
        vehicle.Activated = function(...) 
          if vehData.retirado == false then
            if CheckLong(d.Garage,Labels['MovedTooFarGarage']) then
              TriggerServerEvent("Allhousing:Spawnvehicleseodin",vehicles[_])
              _Pool:CloseAllMenus()
            end
          else
            ShowNotification(Labels['NotExitVehicle'])
          end
        end
        garageMenu:AddItem(vehicle)
      end
    else
      local invalid = NativeUI.CreateItem(Labels['NoVehicles'],"")
      garageMenu:AddItem(invalid)
    end

    garageMenu:RefreshIndex()
    garageMenu:Visible(true)
  end
end

NativeGarageOwnedMenu = function(d)
  local ped = GetPlayerPed(-1)
  if IsPedInAnyVehicle(ped,false) then
    local veh = GetVehiclePedIsUsing(ped)
    local props = GetVehicleProperties(veh)
    local ownerInfo = Callback("Allhousing:GetVehicleOwner",props.plate)
    local canStore = false
    local identifier = GetPlayerIdentifier()
    local guardou = false

    if d.Owner == tostring(identifier) then
      
      canStore = true
    else
      for k,v in pairs(d.HouseKeys) do
        if v.identifier == identifier then
          canStore = true
          break
        end
      end
    end

    if canStore then
      
      local doStore = false
      if guardou == false then
        
        doStore = true
      end

      if doStore then
        TaskEveryoneLeaveVehicle(veh)
        SetEntityAsMissionEntity(veh,true,true)
        DeleteVehicle(veh)  
        TriggerServerEvent("Allhousing:VehicleStored",d.Id,props.plate,props)
        ShowNotification(Labels["VehicleStored"])
        guardou = true
        
      else
        ShowNotification(Labels["CantStoreVehicle"])
      end
    else
      ShowNotification(Labels["CantStoreVehicle"])
    end
    FreezeEntityPosition(GetPlayerPed(-1),false)
  else
    local plyPed = GetPlayerPed(-1)  

    local myId = GetPlayerIdentifier()
    for k,v in pairs(d.HouseKeys) do
      if v.identifier == myId then
        DoOpenNativeGarage(d)
        return
      end
    end
    
    if not Config.RoubodeGaragem then return; end

    if Config.PrecisaDeLockpick then
      local hasItem = CheckForLockpick()
      if not hasItem then
        ShowNotification("You don't have a lockpick.")
        return
      end
    end

    while not HasAnimDictLoaded("mini@safe_cracking") do RequestAnimDict("mini@safe_cracking"); Citizen.Wait(0); end
    TaskPlayAnim(plyPed, "mini@safe_cracking", "idle_base", 1.0, 1.0, -1, 1, 0, 0, 0, 0 ) 
    Wait(2000)

    if Config.UsingLockpickV1 then
      TriggerEvent("lockpicking:StartMinigame",4,function(didWin)
        if didWin then
          ClearPedTasksImmediately(plyPed)
          DoOpenNativeGarage(d)
        else
          ClearPedTasksImmediately(plyPed)
          TriggerServerEvent("Allhousing:BreakLockpick")
        end
      end)
    elseif Config.UsingLockpickV2 then
      exports["lockpick"]:Lockpick(function(didWin)
        if didWin then
          ClearPedTasksImmediately(plyPed)
          DoOpenNativeGarage(d)
          ShowNotification("You successfully cracked the lock.")
        else
          ClearPedTasksImmediately(plyPed)
          TriggerServerEvent("Allhousing:BreakLockpick")
          ShowNotification("You failed to crack the lock.")
        end
      end)
    else
      if Config.UsingProgressBars then
        TriggerEvent("progress",Config.TempoLockpick * 1000,Labels["ProgressLockpicking"])
      end
      Wait(Config.TempoLockpick * 1000)
      if math.random(100) < Config.ChanceDeFalhar then
        local plyPos = GetEntityCoords(GetPlayerPed(-1))
        local zoneName = GetNameOfZone(plyPos.x,plyPos.y,plyPos.z)
        if Config.QuebrarLockpickFalha then
          TriggerServerEvent("Allhousing:BreakLockpick")
        end
        ShowNotification("You failed to crack the lock.")
        TriggerServerEvent("Allhousing:NotifyJobs",k,"Someone is attempting to break into a garage at "..zoneName)
        ClearPedTasksImmediately(plyPed)
      else
        ShowNotification("You successfully cracked the lock.")
        ClearPedTasksImmediately(plyPed)
        DoOpenNativeGarage(d)
      end
    end
  end
end

NativeExitOwnerMenu = function(d)
  local exitMenu = CreateNativeUIMenu(Labels['HouseExit'],Labels['MyHouse'])

  local invite = NativeUI.CreateItem(Labels['InviteInside'],d.Shell)
  invite.Activated = function(...) NativeOpenInvite(d); end
  exitMenu:AddItem(invite)

  NativeCreateKeysMenu(d,exitMenu)

  NativeCreateUpgradeMenu(d,exitMenu)

  if Config.PermitirVendaDeCasas then
    NativeCreateSellMenu(d,exitMenu)
  end

  local furni = NativeUI.CreateItem(Labels['FurniUI'],d.Shell)
  furni.Activated = function(...) OpenFurniture(d); end
  exitMenu:AddItem(furni)

  --[[local wardrobe = NativeUI.CreateItem(Labels['SetWardrobe'],d.Shell)
  wardrobe.Activated = function(...) SetWardrobe(d); end
  exitMenu:AddItem(wardrobe)]]

  if Config.UsarInventarioNasCasas then
    local inventory = NativeUI.CreateItem(Labels['SetInventory'],d.Shell)
    inventory.Activated = function(...) SetInventory(d); end
    exitMenu:AddItem(inventory)
  end

  if d.Unlocked then
    local lock = NativeUI.CreateItem(Labels['LockDoor'],d.Shell)
    lock.Activated = function(...) LockHouse(d); end
    exitMenu:AddItem(lock)
  else
    local unlock = NativeUI.CreateItem(Labels['UnlockDoor'],d.Shell)
    unlock.Activated = function(...) UnlockHouse(d); end
    exitMenu:AddItem(unlock)
  end

  NativeCreateMortgageMenu(d,exitMenu,true)

  local leave = NativeUI.CreateItem(Labels['HouseExit'],d.Shell)
  leave.Activated = function(...) LeaveHouse(d); end
  exitMenu:AddItem(leave)

  exitMenu:RefreshIndex()
  exitMenu:Visible(true)
end

NativeExitOwnedMenu = function(d)
  local exitMenu = CreateNativeUIMenu(Labels['HouseExit'] ,Labels["PlayerHouse"] )

  local leave = NativeUI.CreateItem(Labels['HouseExit'],d.Shell)
  leave.Activated = function(...) LeaveHouse(d); end
  exitMenu:AddItem(leave)

  for k,v in pairs(d.HouseKeys) do
    if v.identifier == GetPlayerIdentifier() then
      local invite = NativeUI.CreateItem(Labels['InviteInside'],d.Shell)
      invite.Activated = function(...) NativeOpenInvite(d); end
      exitMenu:AddItem(invite)

      local furni = NativeUI.CreateItem(Labels['FurniUI'],d.Shell)
      furni.Activated = function(...) OpenFurniture(d); end
      exitMenu:AddItem(furni)
      break
    end
  end

  exitMenu:RefreshIndex()
  exitMenu:Visible(true)
end

NativeExitEmptyMenu = function(d)
  local exitMenu = CreateNativeUIMenu(Labels['HouseExit'],Labels['EmptyHouse'])

  local leave = NativeUI.CreateItem(Labels['HouseExit'],d.Shell)
  leave.Activated = function(...) LeaveHouse(d); end
  exitMenu:AddItem(leave)

  if (d.Owned) then
    local jobName =  vRPUtils.getPlayerJob(Config.PermiPolicia)
    if Config.PoliciaisPodemEntrar and jobName then 
      if d.Unlocked then
        local lock = NativeUI.CreateItem(Labels['LockDoor'],d.Shell)
        lock.Activated = function(...) LockHouse(d); end
        exitMenu:AddItem(lock)
      else
        local unlock = NativeUI.CreateItem(Labels['UnlockDoor'],d.Shell)
        unlock.Activated = function(...) UnlockHouse(d); end
        exitMenu:AddItem(unlock)
      end
    end
  end

  exitMenu:RefreshIndex()
  exitMenu:Visible(true)
end

CheckLong = function(d,n)
  if Vdist(d.x, d.y, d.z, GetEntityCoords(PlayerPedId())) > 2 then 
    ShowNotification(n)
    return false
  else
    return true
  end
end


NativeEntryOwnerMenu = function(d)
  local entryMenu = CreateNativeUIMenu(Labels['Entry'],"Minha Casa")

  if d.Shell then
    local enter = NativeUI.CreateItem(Labels['EnterHouse'],d.Shell)
    enter.Activated = function(...) if CheckLong(d.Entry,Labels['LongPlayer']) then EnterHouse(d) end end

    entryMenu:AddItem(enter)

    NativeCreateUpgradeMenu(d,entryMenu)

    if d.Unlocked then
      local lock = NativeUI.CreateItem(Labels['LockDoor'],d.Shell)
      lock.Activated = function(...) if CheckLong(d.Entry,Labels['LongPlayer']) then LockHouse(d) end end
      entryMenu:AddItem(lock)
    else
      local unlock = NativeUI.CreateItem(Labels['UnlockDoor'],d.Shell)
      unlock.Activated = function(...) if CheckLong(d.Entry,Labels['LongPlayer']) then EnterHouse(d); end end
      entryMenu:AddItem(unlock)
    end
  end

  if d.Garage and Config.MovimentoDaGaragem then
    local move = NativeUI.CreateItem(Labels['MoveGarage'],d.Shell)
    move.Activated = function(...) if CheckLong(d.Entry,Labels['LongPlayer']) then MoveGarage(d) ; end end
    entryMenu:AddItem(move)
  end
  
  if Config.PermitirVendaDeCasas then
    NativeCreateSellMenu(d,entryMenu)
  end

  entryMenu:RefreshIndex()
  entryMenu:Visible(true)
end

NativeEntryOwnedMenu = function(d)
  local entryMenu = CreateNativeUIMenu(Labels['Entry'],"Minha Casa")


  local hasKeys = false
  for k,v in pairs(d.HouseKeys) do
    --print("55", GetPlayerIdentifier(), v.identifier)
    if v.identifier == GetPlayerIdentifier() then
      if d.Shell then
        local enter = NativeUI.CreateItem(Labels['EnterHouse'],d.Shell)
        enter.Activated = function(...) if CheckLong(d.Entry,Labels['LongPlayer']) then EnterHouse(d); end end
        entryMenu:AddItem(enter)
      end
      hasKeys = true
      break
    end
  end

  if not hasKeys then
    if d.Shell then
      local knock = NativeUI.CreateItem(Labels['KnockHouse'],d.Shell)
      knock.Activated = function(...) if CheckLong(d.Entry,Labels['LongPlayer']) then KnockOnDoor(d); end end
      entryMenu:AddItem(knock)

      local isPolice = false
      local jobName = vRPUtils.getPlayerJob(Config.PermiPolicia)
      local jobName2 = vRPUtils.getPlayerJob(Config.PermiAdmin)

      if jobName then
        isPolice = true
        local raid = NativeUI.CreateItem(Labels['BreakIn'],d.Shell)
        raid.Activated = function(...) if CheckLong(d.Entry,Labels['LongPlayer']) then RaidHouse(d); end end
        entryMenu:AddItem(raid)
      end

    end

    local isRealestate = false
    if Config.CreationJobs and jobName2 then
      NativeCreateMortgageMenu(d,entryMenu)
    end

    if d.Shell then
      if Config.RouboDeCasas and not isPolice then
        local breakIn = NativeUI.CreateItem(Labels['RaidHouse'],d.Shell)
        breakIn.Activated = function(...) if CheckLong(d.Entry,Labels['LongPlayer']) then BreakInHouse(d); end end
        entryMenu:AddItem(breakIn)
      end

      if d.Unlocked then
        local enterHouse = NativeUI.CreateItem(Labels['EnterHouse'],d.Shell)
        enterHouse.Activated = function(...) if CheckLong(d.Entry,Labels['LongPlayer']) then EnterHouse(d,true); end end
        entryMenu:AddItem(enterHouse)
      end
    end
  end

  entryMenu:RefreshIndex()
  entryMenu:Visible(true)
end

NativeEntryEmptyMenu = function(d)
  local entryMenu = CreateNativeUIMenu(Labels['Entry'],Labels['HouseSelling'])

  local buy = NativeUI.CreateItem(Labels['Buy'],d.Shell)
  --local mortgage = NativeUI.CreateItem("Mortgage House",d.Shell)
  buy.Activated = function(...) if CheckLong(d.Entry,Labels['LongPlayer']) then BuyHouse(d); end end
  --mortgage.Activated = function(...) MortgageHouse(d); end

  buy:RightLabel("$"..d.Price)
  --mortgage:RightLabel("$"..math.floor(d.Price / 100) * Config.MortgagePercent)

  entryMenu:AddItem(buy)
  --entryMenu:AddItem(mortgage)
  
  if d.Shell then
    local visit = NativeUI.CreateItem(Labels['View'],d.Shell)
    visit.Activated = function(...) if CheckLong(d.Entry,Labels['LongPlayer']) then ViewHouse(d); end end
    entryMenu:AddItem(visit)
  end

  NativeCreateUpgradeMenu(d,entryMenu,true)

  entryMenu:RefreshIndex()
  entryMenu:Visible(true)
end
