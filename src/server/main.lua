local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")
vRPUtils = Proxy.getInterface("vRP.EXT.CaseMob")
vRP = Proxy.getInterface("vRP")

vRP._prepare("vRP/createhouse","INSERT INTO odinhouse SET id=@id,owner=@owner,ownername=@ownername,owned=@owned,price=@price,resalepercent=@resalepercent,resalejob=@resalejob,entry=@entry,garage=@garage,furniture=@furniture,shell=@shell,interior=@interior,shells=@shells,doors=@doors,housekeys=@housekeys,wardrobe=@wardrobe,inventory=@inventory,inventorylocation=@inventorylocation")
vRP._prepare("vRP/selectvehicles","SELECT * FROM vrp_user_vehicles WHERE user_id=@user_id ORDER BY vehicle")
vRP._prepare("vRP/owner","SELECT * FROM odinhouse WHERE owner=@owner AND owned = 1")
vRP._prepare("vRP/sethome","UPDATE odinhouse SET owner=@owner,ownername=@ownername,resalejob=@resalejob,owned=1,housekeys=@housekeys WHERE id=@id")
vRP._prepare("vRP/mortgage","UPDATE odinhouse SET owner=@owner,ownername=@ownername,resalejob=@resalejob,owned=1,housekeys=@housekeys,mortgage_owed=@mortgage_owed,last_repayment=@last_repayment WHERE id=@id")
vRP._prepare("vRP/updatehome","UPDATE "..((Config and Config.AllhousingTable) or "odinhouse").." SET owned=0,price=@price,resalepercent=100,resalejob=@resalejob,furniture=@furniture WHERE id=@id")
vRP._prepare("vRP/setgarage","UPDATE odinhouse SET garage=@garage WHERE id=@id")
--vRP._prepare("vRP/GetVehicleOwner","SELECT * FROM owned_vehicles WHERE plate=@plate")
vRP._prepare("vRP/RepayMortgage","UPDATE odinhouse SET mortgage_owed=@mortgage_owed,last_repayment=@last_repayment WHERE id=@id")
vRP._prepare("vRP/RevokeTenancy","UPDATE odinhouse SET owner=@owner,ownername=@ownername,resalejob=@resalejob,owned=0,housekeys=@housekeys,mortgage_owed=0,last_repayment=0 WHERE id=@id")
vRP._prepare("vRP/addToDb","SELECT * FROM "..((Config and Config.AllhousingTable) or "odinhouse"))
vRP._prepare("vRP/UpgradeHouse","UPDATE "..((Config and Config.AllhousingTable) or "odinhouse").." SET shell=@shell WHERE id=@id")
vRP._prepare("vRP/GiveKeys","UPDATE "..((Config and Config.AllhousingTable) or "odinhouse").." SET housekeys=@housekeys WHERE id=@id")
vRP._prepare("vRP/SetWardrobe","UPDATE "..((Config and Config.AllhousingTable) or "odinhouse").." SET wardrobe=@wardrobe WHERE id=@id")
vRP._prepare("vRP/SetInventory","UPDATE "..((Config and Config.AllhousingTable) or "odinhouse").." SET inventorylocation=@inventorylocation WHERE id=@id")
vRP._prepare("vRP/GetItem","UPDATE "..((Config and Config.AllhousingTable) or "odinhouse").." SET inventory=@inventory WHERE id=@id")
vRP._prepare("vRP/SqlCheck","SELECT * FROM information_schema.COLUMNS")
vRP._prepare("vRP/insertdb","INSERT INTO "..(Config.AllhousingTable or "odinhouse").." SET id=@id,owner=@owner,ownername=@ownername,owned=@owned,entry=@entry,garage=@garage,furniture=@furniture,price=@price,resalepercent=@resalepercent,resalejob=@resalejob,shell=@shell,shells=@shells,housekeys=@housekeys,wardrobe=@wardrobe,inventory=@inventory,inventorylocation=@inventorylocation,mortgage_owed=@mortgage_owed,last_repayment=@last_repayment")

vRP.prepare("homes/get_homeuser","SELECT * FROM vrp_homes_permissions WHERE user_id = @user_id AND home = @home")
vRP.prepare("homes/get_homeuserid","SELECT * FROM vrp_homes_permissions WHERE user_id = @user_id")
vRP.prepare("homes/get_homeuserowner","SELECT * FROM vrp_homes_permissions WHERE user_id = @user_id AND home = @home AND owner = 1")
vRP.prepare("homes/get_homeuseridowner","SELECT * FROM vrp_homes_permissions WHERE home = @home AND owner = 1")
vRP._prepare("vRP/deletehouse","DELETE FROM odinhouse WHERE id=@id")
vRP._prepare("creative/set_detido","UPDATE vrp_user_vehicles SET detido = @detido, time = @time WHERE user_id = @user_id AND vehicle = @vehicle")
vRP._prepare("creative/set_ipva","UPDATE vrp_user_vehicles SET ipva = @ipva WHERE user_id = @user_id AND vehicle = @vehicle")

local vehicle_players = {}


Citizen.CreateThread(function()
  local return_validation = pcall(CheckValidation)
  local return_version = pcall(checkversion)

  if not return_validation or not returnversion then
    print("^8[^3"..GetCurrentResourceName().."^8] ^1 Erro Ao tentar executar as funcoes! ^1Entre em contato no discord: ^8discord.gg/p9vq7U2qTe^0")
    desligar_servidor()
  end

end)

  --local curInDb = SqlFetch('SELECT * FROM '..((Config and Config.AllhousingTable) or "allhousing"),{})

GetOutfits = function(source)
  local xPlayer  = ESX.GetPlayerFromId(source)
  local ret,labels = false
  TriggerEvent('esx_datastore:getDataStore', 'property', xPlayer.identifier, function(store)
    local count  = store.count('dressing')
    local _labels = {}
    for i=1, count, 1 do
      local entry = store.get('dressing', i)
      table.insert(_labels, entry.label)
    end
    labels = _labels
    ret = true
  end)
  while not ret do Wait(0); end
  return labels
end

GetOutfit = function(source,num)
  local xPlayer  = ESX.GetPlayerFromId(source)
  local ret,skin = false
  TriggerEvent('esx_datastore:getDataStore', 'property', xPlayer.identifier, function(store)
    local outfit = store.get('dressing', num)
    skin = outfit.skin
    ret = true
  end)
  while not ret do Wait(0); end
  return skin
end

RemoveOutfit = function(label)
  local xPlayer = ESX.GetPlayerFromId(source)
  TriggerEvent('esx_datastore:getDataStore', 'property', xPlayer.identifier, function(store)
    local dressing = store.get('dressing') or {}
    table.remove(dressing, label)
    store.set('dressing', dressing)
  end)
end

GetVehicles = function(source,house)
  local vehs = {}
  local vehs = {}
	local source = source
	local user_id = vRP.getUserId(source)
  local retData = vRP.query("vRP/selectvehicles",{user_id = user_id})

  --local retData = SqlFetch("SELECT * FROM vrp_user_vehicles WHERE storedhouse=@storedhouse",{['@storedhouse'] = house.Id})]
  if not vehicle_players[user_id] then

    vehicle_players[user_id] = {}
  end
  if retData and type(retData) == "table" then

    for k,v in pairs(retData) do
      if vehicle_players[user_id][k] and vehicle_players[user_id][k].spawn == v.vehicle then
        vehicle_players[user_id][k].detido = v.detido
        vehicle_players[user_id][k].engine = v.engine
        vehicle_players[user_id][k].body = v.body
        vehicle_players[user_id][k].fuel = v.fuel
        vehicle_players[user_id][k].ipva = v.ipva
        vehicle_players[user_id][k].time = v.time
      else
        vehicle_players[user_id][k] = {spawn = v.vehicle,detido = v.detido, engine = v.engine, body = v.body, fuel = v.fuel, ipva = v.ipva, time = v.time, retirado = false}
      end
      
    end
    if #retData < #vehicle_players[user_id] then

      for i = #vehicle_players + 1, #retData do

        table.remove(vehicle_players[user_id],i)
      end
    end
    ret = true
  end
  while not ret do Wait(0); end
  return vehicle_players[user_id]
end

SqlFetch = function(ssm,sjd)
  local res,ret
  exports["GHMattiMySQL"]:QueryResultAsync(ssm,sjd,function(sqldata)
    ret = sqldata
    res = true
  end)
  while not res do Wait(0); end
  return ret
end

SqlExecute = function(ssm,sjd)
  local res,ret
  exports["GHMattiMySQL"]:QueryResultAsync(ssm,sjd,function(sqldata)
    ret = sqldata
    res = true
  end)
  while not res do Wait(0); end
  return ret
end

--[[VehicleSpawned = function(plate)
  exports["GHMattiMySQL"]:QueryAsync("UPDATE vrp_user_vehicles SET `storedhouse`=@storedhouse WHERE `plate`=@plate",{['@storedhouse'] = 0,['@plate'] = plate})
end]]--

VehicleStored = function(props,vehicle)
  local source = source
  local user_id = vRP.getUserId(source)
  local vehbody,vehfuel,vehengine = 1000,100,1000
  

  if Config.SaveVehicleBody then
    vehbody = props.bodyHealth
  end

  if Config.SaveVehicleFuel then
    vehfuel = props.fuelLevel
  end

  if Config.SaveVehicleEngine then

    vehengine = props.engineHealth
  end


  for k,v in pairs(vehicle_players[user_id]) do
    if vehicle == v.spawn then
      vRP.execute("creative/set_update_vehicles",{ user_id = parseInt(user_id), vehicle = tostring(vehicle), engine = parseInt(vehengine), body = parseInt(vehbody), fuel = parseInt(vehfuel) })
      TriggerClientEvent("vrp_odinhouse:Addcar", source, vehicle,nil)
      v.retirado = false
    end
  end


    

end

GetInventory = function(source,cb,house)
  local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		local hsinventory = {}
		local myinventory = {}
		local data = vRP.getSData("chest:"..tostring(house))
		local result = json.decode(data) or {}
		if result then
			for k,v in pairs(result) do
				table.insert(hsinventory,{ amount = parseInt(v.amount), name = vRP.itemNameList(k), index = vRP.itemIndexList(k), key = k, peso = vRP.getItemWeight(k) })
			end

			local inv = vRP.getInventory(parseInt(user_id))
			for k,v in pairs(inv) do
				table.insert(myinventory,{ amount = parseInt(v.amount), name = vRP.itemNameList(k), index = vRP.itemIndexList(k), key = k, peso = vRP.getItemWeight(k) })
			end
		end
		return hsinventory,myinventory,vRP.getInventoryWeight(user_id),vRP.getInventoryMaxWeight(user_id),vRP.computeItemsWeight(result),parseInt(homes[tostring(house)][3])
	end
	return false
end

purchase = true


PurchaseHouse = function(house)
  local _source = source

  if purchase then

    purchase = false
    local v = Houses[house.Id]
    local entry = house.Entry

    local rows = vRP.query("vRP/owner",{owner = vRP.getUserId(_source)})
    --local rows = SqlFetch("SELECT * FROM allhousing WHERE owner=@owner AND owned = 1",{['@owner'] = vRP.getUserId(_source)})
    if #rows <= 1 then

      if not v.Owned then

        local afford
        if vRP.tryFullPayment(vRP.getUserId(_source),v.Price) then
          afford = true
        end


        if afford then

          --print("aaaaaaaa")
          local lastOwner = ""
          if v.Owner then

            lastOwner = v.Owner
            local targetPlayer = v.Owner
            local salePrice = math.floor(v.Price * (v.ResalePercent / 100))
            if salePrice > 0 then


              if v.Owner ~= -1  and v.Owner ~= "-1" then
                
                
                local targetSource = vRP.getUserSource(parseInt(targetPlayer))

                if targetSource ~= nil then

                  vRPUtilsC.giveBank(v.Owner,salePrice)

                  NotifyPlayer(targetSource,string.format(Labels["HousePurchased"],v.Price,(v.Price ~= salePrice and Labels["HouseEarning"] or ".")))
                else
                  
                  vRPUtilsC.giveBank(v.Owner,salePrice)
                end
              end

              --[[if v.ResaleJob and v.ResaleJob:len() > 1 then
                local societyAmount = (Config.CreationJobs[v.ResaleJob].society and math.floor(v.Price * ((100 - v.ResalePercent) / 100)))
                local societyAccount = Config.CreationJobs[v.ResaleJob].account
                if societyAmount and societyAccount then
                  AddSocietyMoney(societyAccount,societyAmount)
                end
              end]]
              --vRPUtils.notify(_source,Labels["CantAffordHouse"])
            end
          end
          
          v.Owner = vRP.getUserId(_source)
         
          v.OwnerName = GetPlayerName(_source)
          
          v.ResaleJob = ""
          v.Owned = true
          
          TriggerClientEvent("Allhousing:SyncHouse",-1,v)
          

          
          vRP.execute("vRP/sethome", { owner = v.Owner,ownername = v.OwnerName, housekeys = json.encode({}),resalejob = "",id = v.Id })

          --SqlExecute("UPDATE allhousing SET owner=@owner,ownername=@ownername,resalejob=@resalejob,owned=1,housekeys=@housekeys WHERE id=@id",{['@owner'] = vRP.getUserId(_source),['@ownername'] = v.OwnerName, ['@housekeys'] = json.encode({}),['@resalejob'] = "",['@id'] = v.Id})
        end
      end
    else
      v.Owned = false
      TriggerClientEvent("Allhousing:SyncHouse",-1,v)
      TriggerClientEvent("Allhousing:NotifyPlayer", _source, "~b~[OdinHouse] ~r~Você só pode ter 2 casas!")
    end
    SetTimeout(3*1000,function()
      purchase = true
    end)
  else
    TriggerClientEvent("Allhousing:NotifyPlayer", _source, "~b~[OdinHouse] ~r~Espere alguns segundos, você está comprando muitas casas!")
  end
end

SellHouse = function(house,price)
  local _source = source
  local v = Houses[house.Id]
  local entry = house.Entry
  local user_id = vRP.getUserId(source)
  if v.Entry.x == entry.x and v.Entry.y == entry.y and v.Entry.z == entry.z then
    if v.Owned and v.Owner == vRP.getUserId(_source) then
      if Config.RemoverMoveis then
        if Config.DevolverDinMoveis and Config.PorcentagemDevolucao then
          TriggerEvent("Allhousing.Furni:GetPrices", function(prices)
            local addVal,count = 0,0
            if v and v.Furniture and type(v.Furniture) == "table" then
              for k,v in pairs(v.Furniture) do
                local price = prices[v.model]
                addVal = addVal + price
                count = count + 1
              end
              if count and count > 0 then
                _print("[Sale]","Added $"..addVal.." to ".._source.." ("..vRP.getUserId(_source).."/"..GetPlayerName(_source)..") to refund "..(count and count > 1 and count.." pieces" or tostring(count).." piece").." of furniture.")
                vRPUtils.giveBank(user_id,math.ceil(addVal*(Config.PorcentagemDevolucao / 100)))
              end
            end
          end)
        end
        v.Furniture = {}
      end          
      local furniTab = {}
      if v and v.Furniture and type(v.Furniture) == "table" then
        for k,v in pairs(v.Furniture) do
          table.insert(furniTab,{
            pos = {x = v.pos.x, y = v.pos.y, z = v.pos.z},
            rot = {x = v.rot.x, y = v.rot.y, z = v.rot.z},
            model = v.model
          })
        end
      end
      v.Owned = false
      v.Price = price
      v.ResalePercent = 100
      v.ResaleJob = ""
      SyncHouse(v)
      TriggerClientEvent("Allhousing:Boot",-1,house.Id)
      vRP.setSData("chest:"..tostring(house.Id),json.encode({}))
      vRP.execute("vRP/updatehome", { furniture = json.encode(furniTab),resalejob = "",price = price,id = v.Id })
      --SqlExecute("UPDATE "..((Config and Config.AllhousingTable) or "allhousing").." SET owned=0,price=@price,resalepercent=100,resalejob=@resalejob,furniture=@furniture WHERE id=@id",{['@furniture'] = json.encode(furniTab),['@resalejob'] = "",['@price'] = price,['@id'] = v.Id})
      return
    end
  end
end

MortgageHouse = function(house)
  local _source = source
  local v = Houses[house.Id]
  local entry = house.Entry
  if not v.Owned then
    local price = math.floor((v.Price / 100) * Config.MortgagePercent)
    local afford
    if vRPUtils.tryPaymentCash(_source,price) then
      afford = true
    elseif vRPUtils.tryPaymentBank(_source,price) then
      afford = true
    end
    if afford then
      local lastOwner = ""
      if v.Owner then
        lastOwner = v.Owner
        local targetPlayer = vRPUtils.getSourceId(v.Owner)
        local salePrice = math.floor(price * (v.ResalePercent / 100))
        if salePrice > 0 then
          if targetPlayer then
            local targetSource = targetPlayer
            vRPUtils.giveBank(targetSource,salePrice)
            --AddPlayerBank(targetSource,salePrice)
            NotifyPlayer(targetSource,"Sua casa foi hipotecada por R$"..price..(price ~= salePrice and ", voce recebeu R$"..salePrice.." da venda." or "."))
          else
            AddOfflineBank(v.Owner,salePrice)
          end

          --[[if v.ResaleJob and v.ResaleJob:len() > 1 then
            local societyAmount = (Config.CreationJobs[v.ResaleJob].society and math.floor(price * ((100 - v.ResalePercent) / 100)))
            local societyAccount = Config.CreationJobs[v.ResaleJob].account
            if societyAmount and societyAccount then
              AddSocietyMoney(societyAccount,societyAmount)
            end
          end]]
        end
      end

      v.Owner = vRP.getUserId(_source)
      v.OwnerName = GetPlayerName(_source)
      v.ResaleJob = ""
      v.Owned = true
      v.MortgageOwed = (v.Price - price)
      v.LastRepayment = os.time()
      TriggerClientEvent("Allhousing:SyncHouse",-1,v)
      
      vRP.execute("vRP/mortgage", { owner = vRP.getUserId(_source),ownername = v.OwnerName, housekeys = json.encode({}),resalejob = "",mortgage_owed = v.MortgageOwed,last_repayment = v.LastRepayment,id = v.Id })
      --SqlExecute("UPDATE allhousing SET owner=@owner,ownername=@ownername,resalejob=@resalejob,owned=1,housekeys=@housekeys,mortgage_owed=@mortgage_owed,last_repayment=@last_repayment WHERE id=@id",{['@owner'] = vRP.getUserId(_source),['@ownername'] = v.OwnerName, ['@housekeys'] = json.encode({}),['@resalejob'] = "",['@mortgage_owed'] = v.MortgageOwed,['@last_repayment'] = v.LastRepayment,['@id'] = v.Id})
    end
  end
end

GetVehicleOwner = function(source,plate)
  local res,ret

  local retData = vRP.query("vRP/GetVehicleOwner",{plate = plate})
  --exports["GHMattiMySQL"]:QueryResultAsync("SELECT * FROM owned_vehicles WHERE plate=@plate",{['@plate'] = plate},function(retData)
    ret = {}
    if retData and type(retData) == "table" and retData[1] then
      local xPlayer  = ESX.GetPlayerFromId(source)
      if retData[1].owner == xPlayer.getIdentifier() then
        ret.owner = true
        ret.owned = true
      else
        ret.owner = false
        ret.owned = true
      end
    else
      ret.owner = false
      ret.owned = false
    end
    res = true
  --end)
  while not res do Wait(0); end
  return ret
end

if Config.UsingDiscInventory then
  Citizen.CreateThread(function()
    TriggerEvent('disc-inventoryhud:RegisterInventory', {
      name = 'allhousing',
      label = 'Storage',
      slots = (Config.DiscInventorySlots or 20)
    })
  end)
end

GetHouseData = function(source,entry)
  while not ModReady do Wait(0); end
  local identifier = vRPUtils.getId(source)
  if not entry then return {Houses = Houses, Identifier = identifier}; end
  for k,v in pairs(Houses) do
    --print(entry.x)
    if v.Entry.x == entry.x and v.Entry.y == entry.y and v.Entry.z == entry.z then
      return v
    end
  end
  return false
end

RegisterCallback("Allhousing:GetHouseData", GetHouseData)



SetGarageLocation = function(id,pos)
  local house = Houses[id]
  local _source = source
  if house.Owned and house.Garage then
    house.Garage = pos
    TriggerClientEvent("Allhousing:SyncHouse",-1,house)
    
    vRP.execute("vRP/setgarage", { garage = json.encode({x = pos.x, y = pos.y, z = pos.z, w = pos.w}),id = id })
    --SqlExecute("UPDATE allhousing SET garage=@garage WHERE id=@id",{['@garage'] = json.encode({x = pos.x, y = pos.y, z = pos.z, w = pos.w}),['@id'] = id})
  end
end

RepayMortgage = function(id,repay)
  local _source = source
  local house = Houses[id]
  if house.Owned and house.MortgageOwed >= 0 then
    repay = math.min(repay,house.MortgageOwed)
    local afford
    if GetPlayerCash(_source) >= repay then
      afford = true
      TakePlayerCash(_source,repay)
    elseif GetPlayerBank(_source) >= repay then
      afford = true
      TakePlayerBank(_source,repay)
    end
    if afford then
      house.MortgageOwed = house.MortgageOwed - repay
      house.LastRepayment = os.time()
      TriggerClientEvent("Allhousing:SyncHouse",-1,house)

      vRP.execute("vRP/RepayMortgage", { id = house.Id,mortgage_owed = house.MortgageOwed,last_repayment = house.LastRepayment })
      --SqlExecute("UPDATE allhousing SET mortgage_owed=@mortgage_owed,last_repayment=@last_repayment WHERE id=@id",{['@id'] = house.Id,['@mortgage_owed'] = house.MortgageOwed,['@last_repayment'] = house.LastRepayment})
    end
  end
end

RevokeTenancy = function(house)
  local house = Houses[house.Id]
  local _source = source
  local identifier = vRP.getUserId(_source)

  local jobName = vRP.hasPermission(identifier, Config.PermiPolicia) 

  if not jobName then return; end

  local charName = GetPlayerName(_source)
  if house.Owned and house.MortgageOwed >= 0 then

    house.Owned = false
    house.Owner = identifier
    house.OwnerName = charName
    house.ResaleJob = jobName
    house.HouseKeys = {}
    house.MortgageOwed = 0
    house.LastRepayment = 0

    TriggerClientEvent("Allhousing:SyncHouse",-1,house)

    vRP.execute("vRP/RevokeTenancy", { owner = house.Owner,ownername = house.OwnerName, housekeys = json.encode({}),resalejob = house.ResaleJob,id = house.Id })
    --SqlExecute("UPDATE allhousing SET owner=@owner,ownername=@ownername,resalejob=@resalejob,owned=0,housekeys=@housekeys,mortgage_owed=0,last_repayment=0 WHERE id=@id",{['@owner'] = house.Owner,['@ownername'] = house.OwnerName, ['@housekeys'] = json.encode({}),['@resalejob'] = house.ResaleJob,['@id'] = house.Id})
  end
end
RegisterCallback("Allhousing:GetVehicleOwner",GetVehicleOwner)
RegisterCallback("Allhousing:GetHouseData", GetHouseData)
RegisterCallback("Allhousing:GetOutfits", GetOutfits)
RegisterCallback("Allhousing:GetOutfit", GetOutfit)
RegisterCallback("Allhousing:GetVehicles", GetVehicles)

RegisterNetEvent("Allhousing:PurchaseHouse")
AddEventHandler("Allhousing:PurchaseHouse", PurchaseHouse)

RegisterNetEvent("Allhousing:SetGarageLocation")
AddEventHandler("Allhousing:SetGarageLocation", SetGarageLocation)

RegisterNetEvent("Allhousing:MortgageHouse")
AddEventHandler("Allhousing:MortgageHouse", MortgageHouse)

RegisterNetEvent("Allhousing:VehicleSpawned")
AddEventHandler("Allhousing:VehicleSpawned", VehicleSpawned)

RegisterNetEvent("Allhousing:VehicleStored")
AddEventHandler("Allhousing:VehicleStored", VehicleStored)

RegisterNetEvent("Allhousing:RemoveOutfit")
AddEventHandler("Allhousing:RemoveOutfit", RemoveOutfit)

RegisterNetEvent("Allhousing:RepayMortgage")
AddEventHandler("Allhousing:RepayMortgage", RepayMortgage)

RegisterNetEvent("Allhousing:RevokeTenancy")
AddEventHandler("Allhousing:RevokeTenancy", RevokeTenancy)

KashCache = {}
KashCharacters = {}
HouseKey = 1

SqlCheck = function()
  Houses = (Houses or {})

  local found_allhousing = false

  local has_column = vRP.query("vRP/SqlCheck",{})
  --local has_column = SqlFetch("SELECT * FROM information_schema.COLUMNS",{})
  if has_column and type(has_column) == "table" then
    for k,v in pairs(has_column) do
      if v.TABLE_NAME == ((Config and Config.AllhousingTable) or "odinhouse") then
        found_allhousing = true
      end
    end
  end

  if not found_allhousing then
    print("Falha ao iniciar SQL")
    return
  end

  local addToDb = {}

  local curInDb = vRP.query("vRP/addToDb",{})
  --local curInDb = SqlFetch('SELECT * FROM '..((Config and Config.AllhousingTable) or "allhousing"),{})

  if curInDb and type(curInDb) == "table" then
    for k,v in pairs(curInDb) do
      if not v.ownername then
        print("Erro Critico. Comunique a OdinTeam")
        error_out = true
        return
      end

      if v.id and v.id >= HouseKey then
        HouseKey = v.id+1
      end
    end
  end

  local newHouses = {}
  if Houses and type(Houses) == "table" then
    for k1,v1 in pairs(Houses) do
      local foundMatch = false
      for k2,v2 in pairs(curInDb) do
        local entry = json.decode(v2.entry)
        if (math.floor(tonumber(v1.Entry.x)) == math.floor(tonumber(entry.x)) and math.floor(tonumber(v1.Entry.y)) == math.floor(tonumber(entry.y)) and math.floor(tonumber(v1.Entry.z)) == math.floor(tonumber(entry.z))) then
          foundMatch = k2
          break
        end
      end
      if not foundMatch then

        newHouses[HouseKey] =  (Houses[HouseKey] or {})
        newHouses[HouseKey].Id = HouseKey
        newHouses[HouseKey].Owner = ""
        newHouses[HouseKey].OwnerName = ""
        newHouses[HouseKey].Owned = false
        newHouses[HouseKey].Price = v1.Price
        newHouses[HouseKey].ResalePercent = 0
        newHouses[HouseKey].ResaleJob = ''
        newHouses[HouseKey].Entry = v1.Entry
        newHouses[HouseKey].Garage = (v1.Garage or false)
        newHouses[HouseKey].Furniture = {}
        newHouses[HouseKey].Shell = (v1.Shell ~= "0" and v1.Shell or false)
        newHouses[HouseKey].Interior = (v1.Interior ~= "0" and tonumber(v1.Interior) or false)
        newHouses[HouseKey].Shells = v1.Shells
        newHouses[HouseKey].HouseKeys = {}
        newHouses[HouseKey].Wardrobe = false
        newHouses[HouseKey].Inventory = {Cash = 0,DirtyMoney = 0, Items = {}, Weapons = {}}
        newHouses[HouseKey].InventoryLocation = false
        newHouses[HouseKey].MortgageOwed = 0
        newHouses[HouseKey].LastRepayment = 0

        table.insert(addToDb,Houses[HouseKey])
        HouseKey = HouseKey + 1
      else

        newHouses[curInDb[foundMatch].id] =  (Houses[curInDb[foundMatch].id] or {})
        newHouses[curInDb[foundMatch].id].Id = (curInDb[foundMatch].id)
        newHouses[curInDb[foundMatch].id].Owner = curInDb[foundMatch].owner
        newHouses[curInDb[foundMatch].id].OwnerName = (curInDb[foundMatch].ownername)
        newHouses[curInDb[foundMatch].id].Owned = (curInDb[foundMatch].owned >= 1 and true or false)
        newHouses[curInDb[foundMatch].id].Price = curInDb[foundMatch].price
        newHouses[curInDb[foundMatch].id].ResalePercent = curInDb[foundMatch].resalepercent
        newHouses[curInDb[foundMatch].id].ResaleJob = curInDb[foundMatch].resalejob
        newHouses[curInDb[foundMatch].id].Entry = table.tovec(json.decode(curInDb[foundMatch].entry))
        newHouses[curInDb[foundMatch].id].Garage = (curInDb[foundMatch].garage:len() > 5 and table.tovec(json.decode(curInDb[foundMatch].garage)) or false)
        newHouses[curInDb[foundMatch].id].Furniture = json.decode(curInDb[foundMatch].furniture)
        newHouses[curInDb[foundMatch].id].Shell = (curInDb[foundMatch].shell ~= "0" and curInDb[foundMatch].shell or false)
        newHouses[curInDb[foundMatch].id].Interior = (curInDb[foundMatch].Interior ~= "0" and tonumber(curInDb[foundMatch].Interior) or false)
        newHouses[curInDb[foundMatch].id].Shells = json.decode(curInDb[foundMatch].shells)
        newHouses[curInDb[foundMatch].id].HouseKeys = json.decode(curInDb[foundMatch].housekeys)
        newHouses[curInDb[foundMatch].id].Wardrobe = (curInDb[foundMatch].wardrobe:len() > 5 and table.tovec(json.decode(curInDb[foundMatch].wardrobe)) or false)     
        newHouses[curInDb[foundMatch].id].Inventory = (curInDb[foundMatch].inventory:len() > 5 and json.decode(curInDb[foundMatch].inventory) or false)
        newHouses[curInDb[foundMatch].id].InventoryLocation = (curInDb[foundMatch].inventorylocation:len() > 5 and table.tovec(json.decode(curInDb[foundMatch].inventorylocation)) or false)
        newHouses[curInDb[foundMatch].id].MortgageOwed = (curInDb[foundMatch].mortgage_owed or 0)
        newHouses[curInDb[foundMatch].id].LastRepayment = (curInDb[foundMatch].last_repayment or 0)
      end
    end
  end
  if curInDb and type(curInDb) == "table" then
    for k1,v1 in pairs(curInDb) do
      local foundMatch = false
      local entry = json.decode(v1.entry)
      for k2,v2 in pairs(newHouses) do
        if (math.floor(tonumber(v2.Entry.x)) == math.floor(tonumber(entry.x)) and math.floor(tonumber(v2.Entry.y)) == math.floor(tonumber(entry.y)) and math.floor(tonumber(v2.Entry.z)) == math.floor(tonumber(entry.z))) then
          foundMatch = k2
          break
        end
      end
      if not foundMatch then
        
        newHouses[v1.id] = {
          Id = v1.id,
          Owner = v1.owner,
          OwnerName = v1.ownername,
          Owned = (v1.owned >= 1 and true or false),
          Price = v1.price,
          ResalePercent = v1.resalepercent,
          ResaleJob = v1.resalejob,
          Entry = table.tovec(json.decode(v1.entry)),
          Garage = (v1.garage:len() > 5 and table.tovec(json.decode(v1.garage)) or false),
          Furniture = json.decode(v1.furniture),
          Shell = (v1.shell ~= "0" and v1.shell or false),
          Shells = json.decode(v1.shells),
          Interior = (v1.interior ~= "0" and tonumber(v1.interior) or false),
          HouseKeys = json.decode(v1.housekeys),
          Wardrobe = (v1.wardrobe:len() > 5 and table.tovec(json.decode(v1.wardrobe)) or false),
          Inventory = (v1.inventory:len() > 5 and json.decode(v1.inventory) or false),
          InventoryLocation = (v1.inventorylocation:len() > 5 and table.tovec(json.decode(v1.inventorylocation)) or false),
          MortgageOwed = (v1.mortgage_owed),
          LastRepayment = (v1.last_repayment)
        }
      end
    end
  end

  if addToDb and type(addToDb) == "table" then
    for k,v in pairs(addToDb) do

      vRP.execute("vRP/insertdb", { 
        id = v.Id,
        owner = "",
        ownername = "",
        owned = 0,
        entry = json.encode(table.fromvec(v.Entry)),
        garage = json.encode((v.Garage and table.fromvec(v.Garage) or {})),
        furniture = json.encode({}),
        price = v.Price,
        resalepercent = 0,
        resalejob = "",
        shell = (v.Shell or 0),
        interior = (v.Interior or 0),
        shells = json.encode(v.Shells),
        housekeys = json.encode({}),
        wardrobe = json.encode((v.Wardrobe and table.fromvec(v.Garage) or {})),
        inventory = json.encode({Cash = 0,DirtyMoney = 0, Items = {}, Weapons = {}}),
        inventorylocation = json.encode({}),
        mortgage_owed = 0,
        last_repayment = 0,
      })
    end

    if (#addToDb > 0) then
      if (not error_out) then
        _print("[Init]","Adicionado "..#addToDb.." À Database")
      end
    end
  end
  Houses = newHouses
  SqlReady = true
end

Init = function()
  if LoadCallback then
    LoadCallback()
  end

  if not error_out then
    _print("[Init]","Iniciado.")
  else
    return
  end

  GetFramework()

  if not error_out then
    _print("[Init]","Got Framework.")
  else
    return
  end

  while not SqlReady do Wait(0); end
  _print("[Init]","Banco de Dados Carregado.")
  ModReady = true

  _print("[Init]","Iniciado Com Sucesso.")
end

InviteInside = function(house,id)
  TriggerClientEvent("Allhousing:Invited",id,house)
end

KnockOnDoor = function(entry)
  TriggerClientEvent("Allhousing:KnockAtDoor",-1,entry)
end

BreakLockpick = function()
  TakePlayerItem(source,Config.LockpickItem)
end

if not Config.ControlCharacters then
  KashChosen = function(charId)
    KashCharacters[source] = charId
  end

  GetHouseData = function(source,entry)
    while not ModReady do Wait(0); end
    local identifier = GetPlayerIdentifier(source,true)
    --[[if Config.UsingKashacters then
      while not KashCharacters[source] do Wait(0); end
      local st,fn = identifier:find(":")
      KashCache[source] = KashCharacters[source]..":"..identifier:sub((fn or 0)+1,identifier:len())
      identifier = KashCache[source]
    end]]
    if not entry then return {Houses = Houses, Identifier = identifier}; end
    if Houses and type(Houses) == "table" then
      for k,v in pairs(Houses) do
        if v.Entry.x == entry.x and v.Entry.y == entry.y and v.Entry.z == entry.z then
          return v
        end
      end
    end
    return false
  end

  RegisterCallback("Allhousing:GetHouseData", GetHouseData)
  RegisterNetEvent("kashactersS:CharacterChosen")
  AddEventHandler("kashactersS:CharacterChosen", KashChosen)
end


CleanseDoors = function(d)
  local ret = {}
  if d and type(d) == "table" then
    for k,v in pairs(d) do
      local t = type(v)
      if t == "table" then
        ret[k] = CleanseDoors(v)
      elseif t == "vector3" then
        ret[k] = {x = v.x, y = v.y, z = v.z}
      else
        ret[k] = v
      end
    end
  end
  return ret
end

CreateHouse = function(house)
  local _source = source
  local identifier = vRP.getUserId(_source)

  local jobName = vRP.hasPermission(identifier, Config.PermiAdmin) 

  if jobName then 

    local _key = HouseKey
    HouseKey = HouseKey + 1
    local charName = GetPlayerName(_source)
    Houses[_key] = {
      Id = _key,
      Owner = "",
      OwnerName = charName,
      Owned = false,
      Price = house.Price,
      ResalePercent = 1,
      ResaleJob = "Fondator",
      Entry = house.Entry,
      Garage = house.Garage,
      Furniture = {},
      Shell = house.Shell,
      Interior = house.Interior,
      Shells = house.Shells,
      Doors = house.Doors,
      HouseKeys = {},
      Wardrobe = false,
      Inventory = {
        Cash = 0,
        DirtyMoney = 0,
        Items = {},
        Weapons = {},
      },
      InventoryLocation = false,
    }
    SyncHouse(Houses[_key])

    vRP.execute("vRP/createhouse",{ 
      id = _key,
      owner = -1,
      ownername = "",
      owned = 0,
      price = house.Price,
      resalepercent = 1,
      resalejob = "Fondator",
      entry = json.encode(table.fromvec(house.Entry)),
      garage = json.encode((house.Garage and table.fromvec(house.Garage) or {})),
      furniture = json.encode({}),
      shell = house.Shell,
      interior = house.Interior,
      shells = json.encode(house.Shells),
      doors = json.encode(CleanseDoors(house.Doors)),
      housekeys = json.encode({}),
      wardrobe = json.encode({}),
      inventory = json.encode({Cash = 0,DirtyMoney = 0,Items = {},Weapons = {},}),
      inventorylocation = json.encode({}),
    })

  if #house.Doors >= 1 then
    for _,creation in ipairs(house.Doors) do
      creation.house = _key
      TriggerEvent("Doors:Save",creation)
    end
  end
  end
end



UpgradeHouse = function(house,shell)
  local _source = source
  local v = Houses[house.Id]
  local entry = house.Entry
  
  if v.Owned == true and v.Owner == vRP.getUserId(_source) then
    
    local afford
    local truePrice = ShellPrices[shell]

    if vRP.tryFullPayment(vRP.getUserId(_source),truePrice) then
      
      afford = true
    end

    if afford then
      
      v.Shell = shell
      SyncHouse(v)
      
      vRP.execute("vRP/UpgradeHouse", {shell = shell,id = v.Id })
      --SqlExecute("UPDATE "..((Config and Config.AllhousingTable) or "allhousing").." SET shell=@shell WHERE id=@id",{['@shell'] = shell,['@id'] = v.Id})
      TriggerClientEvent("Allhousing:Boot",-1,house.Id,true)
    end
  end
end

GiveKeys = function(house,target)
  local _source = source
  local v = Houses[house.Id]
  local entry = house.Entry
  if v.Owned == true and v.Owner == vRP.getUserId(_source) then
    table.insert(v.HouseKeys,{identifier = vRP.getUserId(target), name = GetPlayerName(target)})
    SyncHouse(v)
    TriggerClientEvent("Allhousing:NotifyPlayer",target,"Você recebeu a chave da casa.")

  vRP.execute("vRP/GiveKeys", { housekeys = json.encode(v.HouseKeys),id = v.Id })
    --SqlExecute("UPDATE "..((Config and Config.AllhousingTable) or "allhousing").." SET housekeys=@housekeys WHERE id=@id",{['@housekeys'] = json.encode(v.HouseKeys),['@id'] = v.Id})
  end
end

TakeKeys = function(house,target)
  local _source = source
  local v = Houses[house.Id]
  local entry = house.Entry
  if v.Owned == true and v.Owner == vRP.getUserId(_source) then
    local foundTarget = false
    if v and v.HouseKeys and type(v.HouseKeys) == "table" then
      for _k,_v in pairs(v.HouseKeys) do
        if _v.identifier == target.identifier and _v.name == target.name then
          foundTarget = _v.identifier
          table.remove(v.HouseKeys,_k)
          v.HouseKeys[_k] = nil
        end
      end
    end
    if foundTarget then
      SyncHouse(v)

      vRP.execute("vRP/GiveKeys", { housekeys = json.encode(v.HouseKeys),id = v.Id })
      --SqlExecute("UPDATE "..((Config and Config.AllhousingTable) or "allhousing").." SET housekeys=@housekeys WHERE id=@id",{['@housekeys'] = json.encode(v.HouseKeys),['@id'] = v.Id})
      _print("[Keys]","Took keys.")

      local targetPlayer = foundTarget
      if targetPlayer then
        local targetSource = vRPUtils.getSourceId(targetPlayer)
        if targetSource then
          TriggerClientEvent("Allhousing:NotifyPlayer",targetSource,"Você perdeu a chave da casa")
        end
      end
    end
  end
end

SetFurni = function(house,furni)
  local v = Houses[house.Id]
  local entry = house.Entry
  v.Furniture = furni
  --SyncHouse(v)
  _print("[Furni]","Mobilia Atualizada.")
  return
end

SetWardrobe = function(house,wardrobe)
  local _source = source
  local v = Houses[house.Id]
  if v.Owned == true and v.Owner == vRP.getUserId(_source) then
    v.Wardrobe = wardrobe
    SyncHouse(v)
    
    vRP.execute("vRP/SetWardrobe", { wardrobe = json.encode({x = wardrobe.x, y = wardrobe.y, z = wardrobe.z}),id = v.Id })
    --SqlExecute("UPDATE "..((Config and Config.AllhousingTable) or "allhousing").." SET wardrobe=@wardrobe WHERE id=@id",{['@wardrobe'] = json.encode({x = wardrobe.x, y = wardrobe.y, z = wardrobe.z}),['@id'] = v.Id})
    _print("[Wardrobe]","Set location.")
  end
end

SetInventory = function(house,inventoryLocation)
  local _source = source
  local v = Houses[house.Id]
  if v.Owned == true and v.Owner == vRP.getUserId(_source) then
    v.InventoryLocation = inventoryLocation
    SyncHouse(v)

    vRP.execute("vRP/SetInventory", { inventorylocation = json.encode({x = inventoryLocation.x, y = inventoryLocation.y, z = inventoryLocation.z}),id = v.Id })
    --SqlExecute("UPDATE "..((Config and Config.AllhousingTable) or "allhousing").." SET inventorylocation=@inventorylocation WHERE id=@id",{['@inventorylocation'] = json.encode({x = inventoryLocation.x, y = inventoryLocation.y, z = inventoryLocation.z}),['@id'] = v.Id})
    _print("[InventoryLocation]","Set location.")
  end
end


if Config.UsingESX then
  Citizen.CreateThread(function()
    if not error_out then
      _print("[ESX]","Waiting for ESX.")
      while not ESX do Wait(0); end
      if not error_out then
        _print("[ESX]","Register ESX Callback.")
        ESX.RegisterServerCallback('Allhousing:GetInventory', GetInventory)
      end
    end
  end)
end

SyncHouse = function(data)
  local h = {}
  for k,v in pairs(data) do
    if k ~= "Inventory" and k ~= "Furniture" then
      h[k] = v
    end
  end
  TriggerClientEvent("Allhousing:SyncHouse",-1,h)
end

LockDoor = function(house)
  Houses[house.Id].Unlocked = false
  SyncHouse(Houses[house.Id])
end

UnlockDoor = function(house)
  Houses[house.Id].Unlocked = true
  SyncHouse(Houses[house.Id])
end

SpawnVehicleSe = function(veiculoss)

  local name = veiculoss.spawn
  if name then
		local source = source
		local user_id = vRP.getUserId(source)
		if user_id then
			local identity = vRP.getUserIdentity(user_id)
			local value = vRP.getUData(parseInt(user_id),"vRP:multas")
			local multas = json.decode(value) or 0
			if multas >= 10000 then
				TriggerClientEvent("Notify",source,"negado","Você tem multas pendentes.",10000)
				return true
			end


			local tuning = vRP.getSData("custom:u"..user_id.."veh_"..name) or {}
			local custom = json.decode(tuning) or {}

			if parseInt(os.time()) <= parseInt(veiculoss.time+24*60*60) then
				local ok = vRP.request(source,"Veículo na retenção, deseja acionar o seguro pagando <b>$"..vRP.format(parseInt(vRP.vehiclePrice(name)*0.2)).."</b> dólares ?",60)
				if ok then
					if vRP.tryFullPayment(user_id,parseInt(vRP.vehiclePrice(name)*0.2)) then
						vRP.execute("creative/set_detido",{ user_id = parseInt(user_id), vehicle = name, detido = 0, time = 0 })
						TriggerClientEvent("Notify",source,"sucesso","Veículo liberado.",10000)
					else
						TriggerClientEvent("Notify",source,"negado","Dinheiro insuficiente.",10000)
					end
				end
			elseif parseInt(veiculoss.detido) >= 1 then
				local ok = vRP.request(source,"Veículo na detenção, deseja acionar o seguro pagando <b>$"..vRP.format(parseInt(vRP.vehiclePrice(name)*0.1)).."</b> dólares ?",60)
				if ok then
					if vRP.tryFullPayment(user_id,parseInt(vRP.vehiclePrice(name)*0.1)) then
						vRP.execute("creative/set_detido",{ user_id = parseInt(user_id), vehicle = name, detido = 0, time = 0 })
						TriggerClientEvent("Notify",source,"sucesso","Veículo liberado.",10000)
					else
						TriggerClientEvent("Notify",source,"negado","Dinheiro insuficiente.",10000)
					end
				end
			else
				if parseInt(os.time()) <= parseInt(veiculoss.ipva+24*15*60*60) then
          TriggerClientEvent("Allhousing:spawnvehicleodin",source,name,veiculoss.engine,veiculoss.body,veiculoss.fuel,custom)
					TriggerClientEvent("setPlateEveryone",identity.registration)
          TriggerClientEvent("vrp_odinhouse:Addcar", source, vehicle,true)
          for k,v in pairs(vehicle_players[user_id]) do
            if v.spawn == veiculoss.spawn then
              
              v.retirado = true
            end
          end
				else
					local price_tax = parseInt(vRP.vehiclePrice(name)*0.10)
					if price_tax > 100000 then
						price_tax = 100000
					end
					local ok = vRP.request(source,"Deseja pagar o <b>Vehicle Tax</b> do veículo <b>"..vRP.vehicleName(name).."</b> por <b>$"..vRP.format(price_tax).."</b> dólares?",60)
					if ok then
						if vRP.tryFullPayment(user_id,price_tax) then
							vRP.execute("creative/set_ipva",{ user_id = parseInt(user_id), vehicle = name, ipva = parseInt(os.time()) })
							TriggerClientEvent("Notify",source,"sucesso","Pagamento do <b>Vehicle Tax</b> conclúido com sucesso.",10000)
						else
							TriggerClientEvent("Notify",source,"negado","Dinheiro insuficiente.",10000)
						end
					end
				end
			end
		end
	end
end

GetLastRepayment = function(now,prev)
  local t =  math.floor(now - prev)
  if t / 60 >= 1 then
    if t / 60 / 60 >= 1 then
      if t / 60 / 60 / 24 >= 1 then
        local d = math.floor(t / 60 / 60 / 24)
        t = t % (60 / 60 / 24)
        local h = math.floor(t / 60 / 60)
        t = t % (60 / 60)
        local m = math.floor(t / 60)
        t = t % (60)
        local s = math.floor(t)
        return d.."d, "..h.."h, "..m.."m, "..s.."s."
      else
        local h = math.floor(t / 60 / 60)
        t = t % (60 / 60)
        local m = math.floor(t / 60)
        t = t % (60)
        local s = math.floor(t)
        return h.."h, "..m.."m, "..s.."s."
      end
    else
      local m = math.floor(t / 60)
      t = t % (60)
      local s = math.floor(t)
      return m.."m, "..s.."s."
    end
  else
    local s = math.floor(t)
    return s.."s."
  end
end

GetMortgageInfo = function(source,house)
  return {MortgageOwed = Houses[house.Id].MortgageOwed, LastRepayment = GetLastRepayment(os.time(),Houses[house.Id].LastRepayment)}
end

GetFurniture = function(source,house_id)
  if not house_id or not Houses or not Houses[house_id] then return; end
  return Houses[house_id].Furniture
end

GetCreatePerm = function(source)
  return vRPUtils.getPlayerJob(source)
end

GetCreatePerm = function(source)
  return vRPUtils.getId(source)
end

RegisterCallback("Allhousing:GetOutfits", GetOutfits)
RegisterCallback("Allhousing:GetOutfit", GetOutfit)
RegisterCallback("Allhousing:GetVehicles", GetVehicles)
RegisterCallback("Allhousing:GetMortgageInfo", GetMortgageInfo)
RegisterCallback("Allhousing:GetFurniture", GetFurniture)
RegisterCallback("Allhousing:GetCrPerm", GetCreatePerm)
RegisterCallback("Allhousing:GetPlId", GetPlId)

RegisterNetEvent('Allhousing:GetItem')
AddEventHandler('Allhousing:GetItem', GetItem)

RegisterNetEvent('Allhousing:PutItem')
AddEventHandler('Allhousing:PutItem', PutItem)

RegisterNetEvent("Allhousing:CreateHouse")
AddEventHandler("Allhousing:CreateHouse", CreateHouse)

RegisterNetEvent("Allhousing:GiveKeys")
AddEventHandler("Allhousing:GiveKeys", GiveKeys)

RegisterNetEvent("Allhousing:BreakLockpick")
AddEventHandler("Allhousing:BreakLockpick", BreakLockpick)

RegisterNetEvent("Allhousing:TakeKeys")
AddEventHandler("Allhousing:TakeKeys", TakeKeys)

RegisterNetEvent("Allhousing:SellHouse")
AddEventHandler("Allhousing:SellHouse", SellHouse)

RegisterNetEvent("Allhousing:LockDoor")
AddEventHandler("Allhousing:LockDoor", LockDoor)

RegisterNetEvent("Allhousing:UnlockDoor")
AddEventHandler("Allhousing:UnlockDoor", UnlockDoor)

RegisterNetEvent("Allhousing:SetWardrobe")
AddEventHandler("Allhousing:SetWardrobe", SetWardrobe)

RegisterNetEvent("Allhousing:SetInventory")
AddEventHandler("Allhousing:SetInventory", SetInventory)

RegisterNetEvent("Allhousing:KnockOnDoor")
AddEventHandler("Allhousing:KnockOnDoor", KnockOnDoor)

RegisterNetEvent("Allhousing:Spawnvehicleseodin")
AddEventHandler("Allhousing:Spawnvehicleseodin", SpawnVehicleSe)


RegisterNetEvent("Allhousing:InviteInside")
AddEventHandler("Allhousing:InviteInside", InviteInside)

RegisterNetEvent("Allhousing:UpgradeHouse")
AddEventHandler("Allhousing:UpgradeHouse", UpgradeHouse)

AddEventHandler("Allhousing:SetFurni", SetFurni)
AddEventHandler("Allhousing:GetGlobalOffset", function(cb) cb(Config.SpawnOffset); end)

AddEventHandler("Allhousing:GetHouseById",function(id,callback,source)
  callback(Houses[id],KashCache[source])
end)

RegisterNetEvent("Allhousing:FullDeleteHouse")
AddEventHandler("Allhousing:FullDeleteHouse",function(house)
  vRP.execute("vRP/deletehouse", { id = house.Id })
  vRP.setSData("chesthouse:"..tostring(house.Id),json.encode({}))
  TriggerClientEvent("Allhousing:DelHouse",-1,house.Id)
end)

if not Config.OtherStartEvent then
  --MySQL.ready(function(...)  end)
  Citizen.CreateThread(SqlCheck);
else
  AddEventHandler(Config.OtherStartEvent,SqlCheck)
end

Citizen.CreateThread(Init)
