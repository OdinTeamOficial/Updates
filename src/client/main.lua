--local Tunnel = module("vrp", "lib/Tunnel")
--vRPUtils = Tunnel.getInterface("utils", "utils")

Init = function()
  Citizen.Wait(math.random(1,5)*1000)
  local start = GetGameTimer()
  --GetFramework()
  while (GetGameTimer() - start < 2000) do Wait(0); end

  StartData       = Callback("Allhousing:GetHouseData")
  Houses          = StartData.Houses
  KashIdentifier  = StartData.Identifier

  RefreshBlips  ()
  Update        ()
end

Update = function()
  while true do
    local wait_time = 0
    local do_render = false

    if not InsideHouse then
      do_render = RenderExterior()
    else
      do_render = RenderInterior()
    end

    if not do_render and Config.WaitToRender then
      wait_time = Config.WaitToRenderTime
    end

    Wait(wait_time)
  end
end

RenderInterior = function()
  local ped = GetPlayerPed(-1)
  local pos = GetEntityCoords(ped)
  local now = GetGameTimer()

  if (not lastIntCheck or not lastIntPos) or (now - lastIntCheck >= 500) or #(lastIntPos - pos) >= 2.0 then
    local _closest,_closestDist

    lastIntCheck  = now
    lastIntPos    = pos

    if InsideHouse.Interior then
      if GetInteriorAtCoords(pos.x,pos.y,pos.z) == InsideHouse.Interior then
        if InsideHouse.Owned then
          local wardrobeDist  = (                             InsideHouse.Wardrobe           and #(InsideHouse.Entry.xyz-InsideHouse.Wardrobe+Config.SpawnOffset - pos)            or false)
          local garageDist    = (                             InsideHouse.Garage             and #(InsideHouse.Garage.xyz - pos)                                                   or false)
          local inventoryDist = (not InsideHouse.Visiting and InsideHouse.InventoryLocation  and #(InsideHouse.Entry.xyz-InsideHouse.InventoryLocation+Config.SpawnOffset - pos)   or false)

          if wardrobeDist then
            if not _closestDist or wardrobeDist < _closestDist then
              _closest      = "Wardrobe"
              _closestDist  = wardrobeDist
            end
          end

          if inventoryDist then
            if not _closestDist or inventoryDist < _closestDist then
              _closest      = "InventoryLocation"
              _closestDist  = inventoryDist
            end
          end

          if garageDist then
            if not _closestDist or garageDist < _closestDist then
              _closest      = "Garage"
              _closestDist  = garageDist
            end
          end
        else
          local entryDist = #(InsideHouse.Entry.xyz - pos)
          if entryDist then
            if not _closestDist or entryDist < _closestDist then
              _closest      = "Entry"
              _closestDist  = entryDist
            end
          end
        end
      else
        UnloadInterior()
        return true
      end
    else
      local wardrobeDist  = (InsideHouse.Wardrobe     and #(InsideHouse.Entry.xyz-InsideHouse.Wardrobe+Config.SpawnOffset - pos)            or false)
      local inventoryDist = (not InsideHouse.Visiting and InsideHouse.InventoryLocation  and #(InsideHouse.Entry.xyz-InsideHouse.InventoryLocation+Config.SpawnOffset - pos)   or false)
      local exitDist      = (#(InsideHouse.Entry.xyz - ShellOffsets[InsideHouse.Shell].exit.xyz+Config.SpawnOffset-pos))
      --print(ShellOffsets[InsideHouse.Shell].exit.xyz+Config.SpawnOffset-pos)

      if wardrobeDist then
        if not _closestDist or wardrobeDist < _closestDist then
          _closest      = "Wardrobe"
          _closestDist  = wardrobeDist
        end
      end

      if inventoryDist then
        if not _closestDist or inventoryDist < _closestDist then
          _closest      = "InventoryLocation"
          _closestDist  = inventoryDist
        end
      end

      if exitDist then
        if not _closestDist or exitDist < _closestDist then
          _closest      = "Exit"
          _closestDist  = exitDist
        end
      end
    end

    if _closest then
      closestInt      = _closest
      closestIntDist  = _closestDist
    end
  end

  if closestInt then
    local _pos = ((closestInt == "Garage" and InsideHouse[closestInt]) or (closestInt == "Exit" and InsideHouse.Entry.xyz-ShellOffsets[InsideHouse.Shell].exit.xyz+Config.SpawnOffset) or (InsideHouse.Entry.xyz-InsideHouse[closestInt].xyz+Config.SpawnOffset))
    if Config.UsarMarkers then
      if closestIntDist < Config.MarkerDistance then
        DrawMarker(1,_pos.x,_pos.y,_pos.z-1.6, 0.0,0.0,0.0, 0.0,0.0,0.0, 1.0,1.0,1.0, Config.CorMarkers[Config.TipoMarker].r,Config.CorMarkers[Config.TipoMarker].g,Config.CorMarkers[Config.TipoMarker].b,Config.CorMarkers[Config.TipoMarker].a, false,true,2)
      end
    end

    if Config.Usar3DText then
      if closestIntDist < Config.TextDistance3D then
        if closestIntDist < Config.InteractDistance then
          DrawText3D(_pos.x,_pos.y,_pos.z, Labels["InteractDrawText"]..Labels[closestInt])
        else
          DrawText3D(_pos.x,_pos.y,_pos.z, Labels[closestInt])
        end
      end
    end

    if Config.UsarHelpText then
      if closestIntDist < Config.HelpTextDistance then
        ShowHelpNotification(Labels["InteractHelpText"]..Labels[closestInt])
      end
    end

    if closestIntDist < Config.InteractDistance then
      if IsControlJustReleased(0,Config.Controles.Interagir) then
        --print(GetPlayerIdentifier(),"1")

        if InsideHouse.Owned and (tonumber(InsideHouse.Owner) == GetPlayerIdentifier()) then
          OpenMenu(InsideHouse,closestInt,"Owner")
        elseif InsideHouse.Owned then
          OpenMenu(InsideHouse,closestInt,"Owned")
        else
          
          OpenMenu(InsideHouse,closestInt,"Empty")
        end
      end
    elseif InsideHouse.Interior then
      if IsControlJustReleased(0,Config.Controles.Interagir) then
        if InsideHouse.Owned and (tonumber(InsideHouse.Owner) == GetPlayerIdentifier()) then
          OpenMenu(InsideHouse,"Exit","Owner")
        elseif InsideHouse.Owned then
          OpenMenu(InsideHouse,"Exit","Owned")
        else
          
          OpenMenu(InsideHouse,"Exit","Empty")
        end
      end
    end
    return true
  else
    return false
  end
end

RenderExterior = function()
  local ped = GetPlayerPed(-1)
  local pos = GetEntityCoords(ped)

  local now = GetGameTimer()
  if (not lastExtCheck or not lastExtPos) or (now - lastExtCheck > 5000) or (#(lastExtPos - pos) >= 2.0) then
    lastExtCheck = now
    lastExtPos   = pos

    closestExt,closestExtDist,closestExtHouse = false,false,false

    local _closest,_closestDist
    for index,house in pairs(Houses) do
      local entryDist   = #(pos - house.Entry.xyz)
      local garageDist  = (type(house.Garage) == "vector4" and type(pos) == "vector3" and #(house.Garage.xyz - pos) or false)

      if not garageDist or entryDist < garageDist then
        _closest      = "Entry"
        _closestDist  = entryDist
      else
        _closest      = "Garage"
        _closestDist  = garageDist
      end

      if not closestExtDist or _closestDist < closestExtDist then
        closestExt       = _closest
        closestExtDist   = _closestDist
        closestExtHouse  = index
      end
    end
  end


  
  if closestExt and closestExtDist and closestExtDist < 100.0 then
    local house = Houses[closestExtHouse]
    if not house or house == nil then return end
    if house.Interior and house.Owned and GetInteriorAtCoords(pos.x,pos.y,pos.z) == house.Interior then
      LoadInterior(house)
      return true
    else
      local render = false

      if Config.UsarMarkers then
        if closestExtDist < Config.MarkerDistance then
          render = true
          DrawMarker(1,house[closestExt].x,house[closestExt].y,house[closestExt].z-1.6, 0.0,0.0,0.0, 0.0,0.0,0.0, 1.0,1.0,1.0, Config.CorMarkers[Config.TipoMarker].r,Config.CorMarkers[Config.TipoMarker].g,Config.CorMarkers[Config.TipoMarker].b,Config.CorMarkers[Config.TipoMarker].a, false,true,2)
        end
      end

      if Config.Usar3DText then
        if closestExtDist < Config.TextDistance3D then
          render = true
          if closestExtDist < Config.InteractDistance then
            DrawText3D(house[closestExt].x,house[closestExt].y,house[closestExt].z, Labels["InteractDrawText"]..Labels[closestExt])
          else
            DrawText3D(house[closestExt].x,house[closestExt].y,house[closestExt].z, Labels[closestExt])
          end
        end
      end

      if Config.UsarHelpText then
        if closestExtDist < Config.HelpTextDistance then
          render = true
          ShowHelpNotification(Labels["InteractHelpText"]..Labels[closestExt])
        end
      end

      if closestExtDist < Config.InteractDistance then
        render = true
        if IsControlJustReleased(0,Config.Controles.Interagir) then
          --print(GetPlayerIdentifier(),"3")
          --print(house.Owner)

          if house.Owned and (tonumber(house.Owner) == GetPlayerIdentifier()) then
            OpenMenu(house,closestExt,"Owner")

          elseif house.Owned then

            OpenMenu(house,closestExt,"Owned")
          else
            
            OpenMenu(house,closestExt,"Empty")
          end
        end
      end

      return render
    end
  else
    return false
  end
end

LoadModel = function(hash_or_model)
  local hash = (type(hash_or_model) == "number" and hash_or_model or GetHashKey(has_or_model))
  RequestModel(hash)
  while not HasModelLoaded(hash) do Wait(0); end
end

UnloadInterior = function()  
  if InsideHouse and InsideHouse.Extras then
    for k,v in pairs(InsideHouse.Extras) do
      SetEntityAsMissionEntity(v,true,true)
      DeleteObject(v)
    end
  end

  InsideHouse = false  
  TriggerEvent("Allhousing:Leave")
end

LoadInterior = function(d)
  ShowNotification(Labels["InteractDrawText"]..Labels["AccessHouseMenu"])

  InsideHouse         = d
  InsideHouse.Exit    = InsideHouse.Entry
  InsideHouse.Extras  = {}

  local furni = Callback("Allhousing:GetFurniture",d.Id)
  for k,v in pairs(furni) do
    local objHash = GetHashKey(v.model)
    LoadModel(objHash)

    local obj = CreateObject(objHash, InsideHouse.Entry.x + v.pos.x, InsideHouse.Entry.y + v.pos.y, InsideHouse.Entry.z + v.pos.z, false,false,false)
    SetEntityCoordsNoOffset(obj, InsideHouse.Entry.x + v.pos.x, InsideHouse.Entry.y + v.pos.y, InsideHouse.Entry.z + v.pos.z)
    SetEntityRotation(obj, v.rot.x, v.rot.y, v.rot.z, 2)
    FreezeEntityPosition(obj, true)

    SetModelAsNoLongerNeeded(objHash)

    table.insert(InsideHouse.Extras,obj)
  end

  local isOwner,hasKeys,isPolice = false,false,false

  --print(GetPlayerIdentifier(),"4")
  local identifier = GetPlayerIdentifier()
  if identifier == d.Owner then
    isOwner = true
  else
    for k,v in pairs(d.HouseKeys) do
      if v.identifier == identifier then
        hasKeys = true
        break
      end
    end
  end

  local job = vRPUtils.getPlayerJob(Config.PermiPolicia)

  if job then
    isPolice = true
 
  end

  if hasKeys or isOwner or (isPolice and Config.PoliciaisPodemEntrar and Config.PoliciaAcessarInv) then
    InsideHouse.Visiting = false
  else
    InsideHouse.Visiting = true
  end

  TriggerEvent("Allhousing:Enter",InsideHouse)
end

RefreshInterior = function()
  if InsideHouse then
    for k,v in pairs(Houses) do
      if v.Entry == InsideHouse.Entry then
        InsideHouse.HouseKeys = v.HouseKeys
      end
    end
  end
end

Sync = function(data)
  local _key
  for k,house in pairs(Houses) do
    if house.Blip then
      RemoveBlip(house.Blip)
      house.Blip = false
      if InsideHouse and InsideHouse.Id == house.Id then
        _key = k
      end
    end
  end
  
  Houses = data
  RefreshBlips()
  if _key then
    InsideHouse = Houses[_key]
  end
end

SyncHouse = function(sync_house)
  local house = Houses[sync_house.Id]

  if not house then
    Houses[sync_house.Id] = sync_house
    house = Houses[sync_house.Id]
  end

  if house.Blip then
    RemoveBlip(house.Blip)
    house.Blip = false
  end

  if house.Id == sync_house.Id then
    if house.Blip then
      RemoveBlip(house.Blip)
    end

    Houses[sync_house.Id] = sync_house

    if InsideHouse and InsideHouse.Id == sync_house.Id then
      sync_house.Extras = InsideHouse.Extras
      sync_house.Object = InsideHouse.Object
      sync_house.Visiting = InsideHouse.Visiting  
      InsideHouse = Houses[sync_house.Id]
    end

    if Config.UsarBlips then
      --print(GetPlayerIdentifier(),"5")
      local identifier = GetPlayerIdentifier()
      local color,sprite,text
      if Houses[sync_house.Id].Owned and (tonumber(Houses[sync_house.Id].Owner) == identifier) then
        text = Labels['MyHouse']
        color,sprite = GetBlipData("owner",Houses[sync_house.Id].Entry)
      elseif Houses[sync_house.Id].Owned then
        text = Labels['PlayerHouse']
        color,sprite = GetBlipData("owned",Houses[sync_house.Id].Entry)
      else
        text = Labels['EmptyHouse']
        color,sprite = GetBlipData("empty",Houses[sync_house.Id].Entry)
      end
      if color and sprite then
        Houses[sync_house.Id].Blip = CreateBlip(Houses[sync_house.Id].Entry,sprite,color,text)
      end
    end
  end
  LastExtCheck = 0
end

RegisterCommand('delhouse', function(...)  
  local plyJob  = vRPUtils.getPlayerJob(Config.PermiAdmin)
  if not plyJob then return end

  local closestDist,closest
  local plyPos = GetEntityCoords(GetPlayerPed(-1))
  for _,thisHouse in pairs(Houses) do
    local dist = Vdist(plyPos,thisHouse.Entry.xyz)
    if not closestDist or dist < closestDist then
      closest = thisHouse
      closestDist = dist
    end
    if closest and closestDist and closestDist < 50.0 then
      TriggerServerEvent("Allhousing:FullDeleteHouse",closest)
    end
  end
end)

RegisterNetEvent("Allhousing:DelHouse")
AddEventHandler("Allhousing:DelHouse", function(house_id)

  local house = Houses[house_id]

  if house.blip then
    RemoveBlip(house.blip)
  end
  Houses[house_id] = nil
end)

Invited = function(house)
  local plyPed = GetPlayerPed(-1)
  local plyPos = GetEntityCoords(plyPed)
  if Vdist(plyPos,house.Entry.xyz) < 5.0 then
    ShowNotification(Labels["AcceptDrawText"]..Labels["InvitedInside"])
    BeingInvited = true
    while Vdist(GetEntityCoords(plyPed),house.Entry.xyz) < 10.0 do
      if IsControlJustPressed(0,Config.Controles.Aceitar) then
        ViewHouse(house)
        BeingInvited = false
        return
      end
      Wait(0)
    end
    BeingInvited = false
    ShowNotification(Labels["MovedTooFar"])
  else    
    ShowNotification(Labels["MovedTooFar"])
  end
end

--[[syncBlips = function(nveh,vehname)
	Citizen.CreateThread(function()
		while true do
			if GetBlipFromEntity(nveh) == 0 and gps[vehname] ~= nil then
				vehblips[vehname] = AddBlipForEntity(nveh)
				SetBlipSprite(vehblips[vehname],1)
				SetBlipAsShortRange(vehblips[vehname],false)
				SetBlipColour(vehblips[vehname],80)
				SetBlipScale(vehblips[vehname],0.4)
				BeginTextCommandSetBlipName("STRING")
				AddTextComponentString("~b~Rastreador: ~g~"..GetDisplayNameFromVehicleModel(GetEntityModel(nveh)))
				EndTextCommandSetBlipName(vehblips[vehname])
			end
			Citizen.Wait(100)
		end
	end)
end]]

KnockAtDoor = function(entry)
  --print(GetPlayerIdentifier(),"6")
  if InsideHouse and InsideHouse.Entry == entry and InsideHouse.Owner and InsideHouse.Owner == GetPlayerIdentifier() then
    ShowNotification(Labels["KnockAtDoor"])
  end
end

Boot = function(id,enter)
  if InsideHouse and InsideHouse.Id == id and not LeavingHouse then
    local _id = InsideHouse.Id
    LeaveHouse()
    if enter then
      for k,v in pairs(Houses) do
        if v.Id == _id then
          EnterHouse(v)
          return
        end
      end
    end
  end
end

RegisterNetEvent("Allhousing:Sync")
AddEventHandler("Allhousing:Sync", Sync)

RegisterNetEvent("Allhousing:SyncHouse")
AddEventHandler("Allhousing:SyncHouse", SyncHouse)

RegisterNetEvent("Allhousing:Boot")
AddEventHandler("Allhousing:Boot", Boot)

RegisterNetEvent("Allhousing:spawnvehicleodin")
AddEventHandler("Allhousing:spawnvehicleodin", SpawnVehicle)

RegisterNetEvent("Allhousing:Invited")
AddEventHandler("Allhousing:Invited", Invited)

RegisterNetEvent("Allhousing:KnockAtDoor")
AddEventHandler("Allhousing:KnockAtDoor", KnockAtDoor)

AddEventHandler("Allhousing:Relog", function(...)
  StartData       = Callback("Allhousing:GetHouseData")
  Houses          = StartData.Houses
  KashIdentifier  = StartData.Identifier
  RefreshBlips    ()
end)

AddEventHandler("Allhousing:GetHouseById",function(id,callback)
  callback(Houses[id],KashIdentifier)
end)

Citizen.CreateThread(Init)