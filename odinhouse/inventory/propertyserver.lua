-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")


vRPclient = Tunnel.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONEXÃO
-----------------------------------------------------------------------------------------------------------------------------------------
src = {}
Tunnel.bindInterface("AllHousing",src)
vCLIENT = Tunnel.getInterface("AllHousing")
-----------------------------------------------------------------------------------------------------------------------------------------
-- OPENCHEST
-----------------------------------------------------------------------------------------------------------------------------------------
function src.openChest(homeName,vWeight)
	local source = source
	local user_id = fodaSKI.getuserid(source)
	if user_id then
		local hmInventory = {}
		local myInventory = {}

		local data = vRP.getSData("homesVault:"..tostring(homeName))
		local result = json.decode(data) or {}
		if data then
			for k,v in pairs(result) do
				table.insert(hmInventory,{economy = vRP.itemEconomyList(k), unity = vRP.itemUnityList(k), tipo = vRP.itemTipoList(k), desc = vRP.itemDescList(k), amount = parseInt(v.amount), name = vRP.itemNameList(k), index = vRP.itemIndexList(k), key = k, peso = vRP.itemWeightList(k) })
			end
		end

		local inv = vRP.getInventory(user_id)
		if inv then
			for k,v in pairs(inv) do
				if string.sub(v.item,1,9) == "toolboxes" then
					local advFile = LoadResourceFile("logsystem","toolboxes.json")
					local advDecode = json.decode(advFile)

					v.durability = advDecode[v.item]
				end
				if v.item and v.timestamp then
						local actualTime = os.time()
						local finalTime = v.timestamp
						local durabilityInSeconds = vRP.itemDurabilityList(v.item)
						local startTime = (v.timestamp - durabilityInSeconds)
						
						local actualTimeInSeconds = (actualTime - startTime)
						local porcentage = (actualTimeInSeconds/durabilityInSeconds)-1
						if porcentage < 0 then porcentage = porcentage*-1 end
						if porcentage <= 0.0 then
							porcentage = 0.0
						elseif porcentage >= 100.0 then
							porcentage = 100.0
						end
						if porcentage then
							v.durability = porcentage
						end
					end

				v.amount = parseInt(v.amount)
				v.name = vRP.itemNameList(v.item)
				v.desc = vRP.itemDescList(v.item)
				v.tipo = vRP.itemTipoList(v.item)
				v.unity = vRP.itemUnityList(v.item)
				v.economy = vRP.itemEconomyList(v.item)
				v.peso = vRP.itemWeightList(v.item)
				v.index = vRP.itemIndexList(v.item)
				v.key = v.item
				v.slot = k

				myInventory[k] = v
			end
		end

		local identity = fodaSKI.getidentity(user_id)
		if identity then
			if vWeight then
				return myInventory,hmInventory,vRP.computeInvWeight(user_id),vRP.getBackpack(user_id),vRP.computeChestWeight(result),parseInt(vWeight),{ identity.name.." "..identity.name2,parseInt(user_id),identity.phone,identity.registration }
			end
		end
	end
	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- NOSTORE
-----------------------------------------------------------------------------------------------------------------------------------------
local noStore = {
	["cola"] = true,
	["soda"] = true,
	["coffee"] = true,
	["water"] = true,
	["dirtywater"] = true,
	["emptybottle"] = true,
	["hamburger"] = true,
	["tacos"] = true,
	["chocolate"] = true,
	["donut"] = true
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- POPULATESLOT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("homes:populateSlot")
AddEventHandler("homes:populateSlot",function(item,slot,target,amount)
	local source = source
	local user_id = fodaSKI.getuserid(source)
	if user_id then
		if amount == nil then amount = 1 end
		if amount <= 0 then amount = 1 end

		if vRP.tryGetInventoryItem(user_id,item,amount,false,slot) then
			vRP.giveInventoryItem(user_id,item,amount,false,target)
			TriggerClientEvent("homes:Update",source,"updateVault")
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- UPDATESLOT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("homes:updateSlot")
AddEventHandler("homes:updateSlot",function(item,slot,target,amount)
	local source = source
	local user_id = fodaSKI.getuserid(source)
	if user_id then
		if amount == nil then amount = 1 end
		if amount <= 0 then amount = 1 end

		local inv = vRP.getInventory(user_id)
		if inv then
			if inv[tostring(slot)] and inv[tostring(target)] and inv[tostring(slot)].item == inv[tostring(target)].item then
				if vRP.tryGetInventoryItem(user_id,item,amount,false,slot) then
					vRP.giveInventoryItem(user_id,item,amount,false,target)
				end
			else
				vRP.swapSlot(user_id,slot,target)
			end
		end

		TriggerClientEvent("homes:Update",source,"updateVault")
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SUMSLOT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("homes:sumSlot")
AddEventHandler("homes:sumSlot",function(itemName,slot,amount)
	local source = source
	local user_id = fodaSKI.getuserid(source)
	if user_id then
		local inv = vRP.getInventory(user_id)
		if inv then
			if inv[tostring(slot)] and inv[tostring(slot)].item == itemName then
				if vRP.tryChestItem(user_id,"homesVault:"..tostring(chestOpen[user_id]),itemName,amount,slot) then
					TriggerClientEvent("homes:Update",source,"updateVault")
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- STOREITEM
-----------------------------------------------------------------------------------------------------------------------------------------
function src.storeItem(homeName,itemName,slot,amount,vWeight)
	if itemName then
		local source = source
		local user_id = fodaSKI.getuserid(source)
		if user_id then
			if noStore[itemName] or vRP.itemSubTypeList(itemName) then
				TriggerClientEvent("Notify",source,"vermelho","Você não pode armazenar este item em baús.",5000)
				return
			end


			if vRP.storeChestItem(user_id,"homesVault:"..tostring(homeName),itemName,amount,parseInt(vWeight),slot) then
				TriggerClientEvent("homes:Update",source,"updateVault")
			end
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- TAKEITEM
-----------------------------------------------------------------------------------------------------------------------------------------
function src.takeItem(homeName,itemName,slot,amount)
	if itemName then
		local source = source
		local user_id = fodaSKI.getuserid(source)
		if user_id then
			if vRP.tryChestItem(user_id,"homesVault:"..tostring(homeName),itemName,amount,slot) then
				TriggerClientEvent("homes:Update",source,"updateVault")
			end
		end
	end
end