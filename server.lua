local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
local Tools = module("vrp","lib/Tools")
vRP = Proxy.getInterface("vRP")
fodaSKI = {}
Tunnel.bindInterface(GetCurrentResourceName(),fodaSKI)
vRPclient = Tunnel.getInterface("vRP")

math.randomseed(os.time())

local car = Config.Cars[math.random(#Config.Cars)]
local wheels = {}


vRP.prepare("odinluckywheel/creae_colum","ALTER TABLE "..Config.table_users.." ADD COLUMN IF NOT EXISTS roleta BIGINT NOT NULL DEFAULT 0")
vRP.prepare("odinluckywheel/select_user","SELECT roleta FROM "..Config.table_users.." WHERE "..Config.table_users_fields[1].."= @user_id")
vRP.prepare("odinluckywheel/update_user","UPDATE "..Config.table_users.." SET roleta= @roleta WHERE "..Config.table_users_fields[1].."= @user_id")
vRP.prepare("vRP/odindarveiculo","INSERT IGNORE INTO "..Config.table_vehicles.."("..Config.table_vehicle_fields[1]..","..Config.table_vehicle_fields[2]..","..Config.table_vehicle_fields[3]..","..Config.table_vehicle_fields[4]..") VALUES(@"..Config.table_vehicle_fields[1]..",@"..Config.table_vehicle_fields[2]..",@"..Config.table_vehicle_fields[3]..",@"..Config.table_vehicle_fields[3]..")")



function desligar_servidor()
	for i = 5,1,-1 do
	  print("Desligando em "..i)
	  Wait(1000)
	end
	os.exit()
end
  
Citizen.CreateThread(function()
	local return_validation = pcall(CheckValidation)
	local return_version = pcall(checkversion)
  
	if not return_validation or not return_version then
	  print("^8[^3"..GetCurrentResourceName().."^8] ^1 Erro Ao tentar executar as funcoes! ^1Entre em contato no discord: ^8discord.gg/p9vq7U2qTe^0")
	  desligar_servidor()
	end
  
end)

Citizen.CreateThread(function()
	vRP.execute("odinluckywheel/creae_colum")


end)

RegisterServerEvent('luckywheel:getwheel')
AddEventHandler('luckywheel:getwheel', function(id)
    local _source = source
    local user_id = vRP.getUserId(source)
	local roleta = vRP.query("odinluckywheel/select_user",{user_id = parseInt(user_id)})

	if #roleta > 0 then
		local roletou = roleta[1].roleta

		local time = (os.time{year=os.date("%Y",roletou), month=os.date("%m",roletou), day=os.date("%d",roletou), hour=(os.date("%H",roletou) + Config.Tempo_reset.h), min = (os.date("%M",roletou) + Config.Tempo_reset.m),sec=(os.date("%S",roletou) + Config.Tempo_reset.s)})
		local mostrar = (os.time{year=os.date("%Y",roletou), month=os.date("%m",roletou), day=os.date("%d",roletou), hour=(os.date("%H",time) - os.date("%H")), min = (os.date("%M",time) - os.date("%M")),sec=(os.date("%S",time) - os.date("%S"))})

		
		if  time < os.time() or tonumber(roletou) == 0 or Config.debug == true then
			roletar(user_id,_source,id)
		else
			TriggerClientEvent('odin:notify_lucky_wheel', _source, string.format(Language['already_spin'],os.date("%H",mostrar),os.date("%M",mostrar),os.date("%S",mostrar)))
		end
	end
end)	
	

DarItem = function(x,y,z)
	if Config.framework == "CREATIVE" then
		vRP.generateItem(x,y,z,true)
	elseif Config.framework == "VRPEX" then
		vRP.giveInventoryItem(x, y, z)
	end
end

DarDinheiro = function(x,y)
	if Config.framework == "CREATIVE" then
		vRP.addBank(x,y)
	elseif Config.framework == "VRPEX" then
		vRP.giveBankMoney(x,y)
	end
end


function fodaSKI.getcarofday()
	return car
end

function fodaSKI.returid()
	local source = source
	return vRP.getUserId(source)
end

function fodaSKI.returnvip()
	local source = source
	local user_id = vRP.getUserId(source)
	if Config.VipPerm == "PREMIUM_SCRIPT" then
		return vRP.userPremium(user_id)
	end
	return vRP.hasPermission(user_id, Config.VipPerm)
end

	
function roletar(xPlayer,source,id)

	local _source = source
    if not wheels[id] then
		wheels[id] = true
        if xPlayer ~= nil then
			vRP.execute("odinluckywheel/update_user",{roleta = os.time(),user_id = parseInt(xPlayer)})
			local rnd = math.random(1, 1000)
			local price = 0
			local priceIndex = 0
			for k,v in pairs(Config.premios) do
				if (rnd > v.chance.a) and (rnd <= v.chance.b) then
					price = v
					priceIndex = k
					break
				end
			end
			TriggerClientEvent("luckywheel:syncanim", _source, xPlayer,priceIndex,price,id)
			
		end
	end
end


RegisterServerEvent('luckywheel:give')
AddEventHandler('luckywheel:give', function(user_id, price,id)

    local _s = vRP.getUserSource(user_id)

	wheels[id] = false
	local item_p = price.items
	local quantity = price.quantidade
	if type(quantity) == "table" then
		local sort = math.random(quantity[1],quantity[2])
		quantity = sort
	end
	if price.type == "carro" then
		if item_p == false then
			item_p = car
		else
			if type(item_p) == "table" then
				local sort = math.random(#item_p)
				item_p = item_p[sort]
			end
		end



		TriggerClientEvent('odin:notify_lucky_wheel', _s, string.format(Language['you_won_car'],quantity,item_p))
		for i = 1, quantity do
			local placa = pcall(vRP.generatePlate)
			if placa then
				vRP.execute("vRP/odindarveiculo",{ user_id = parseInt(user_id), vehicle = tostring(item_p), ipva = parseInt(os.time()), tax = parseInt(os.time()), plate = vRP.generatePlate() })
			else
				vRP.execute("vRP/odindarveiculo",{ user_id = parseInt(user_id), vehicle = tostring(item_p), ipva = parseInt(os.time()), tax = parseInt(os.time()) })
			end
		end

	elseif price.type == "nada" then
		TriggerClientEvent('odin:notify_lucky_wheel', _s, Language['you_won_nothing'])
	elseif price.type == 'item' then
		

		if type(price.items) == "table" then
			local sorteio = math.random(#price.items)
			item_p = price.items[sorteio]
			

		end

		TriggerClientEvent('odin:notify_lucky_wheel', _s, string.format(Language['you_won_item'],quantity,item_p))
		DarItem(user_id, item_p, quantity)
	elseif price.type == "dinheiro" then
		
		if item_p == false then
			DarDinheiro(user_id,quantity)
		else
			DarItem(user_id, item_p, quantity)
		end
		TriggerClientEvent('odin:notify_lucky_wheel', _s, string.format(Language['you_won_money'],quantity))

	elseif price.type == "vida" then
		TriggerClientEvent('odin:recompensavida', _s,quantity)
		TriggerClientEvent('odin:notify_lucky_wheel', _s, string.format(Language['you_won_life'],quantity))

	elseif price.type == "colete" then
		TriggerClientEvent('odin:notify_lucky_wheel', _s, string.format(Language['you_won_armor'],quantity))
		TriggerClientEvent('odin:recompensacolete', _s,quantity)

	elseif price.type == "mistery" then
		
		local sorteio = math.random(#price.items)
		local quantidade = price.items[sorteio].quantidade
		if type(price.items[sorteio].quantidade) == "table" then
			local quantidade_sort = math.random(price.items[sorteio].quantidade[1],price.items[sorteio].quantidade[2])
			quantidade = quantidade_sort
		end

		if price.items[sorteio].carro then

			for i = 1, quantidade do
				local placa = pcall(vRP.generatePlate)
				if placa then
					vRP.execute("vRP/odindarveiculo",{ user_id = parseInt(user_id), vehicle = tostring(item_p), ipva = parseInt(os.time()), tax = parseInt(os.time()), plate = vRP.generatePlate() })
				else
					vRP.execute("vRP/odindarveiculo",{ user_id = parseInt(user_id), vehicle = tostring(item_p), ipva = parseInt(os.time()), tax = parseInt(os.time()) })
				end
			end

			TriggerClientEvent('odin:notify_lucky_wheel', _s, string.format(Language['you_won_car'],quantidade,price.items[sorteio].nome))

		elseif price.items[sorteio].nome == "vida" then
			TriggerClientEvent('odin:notify_lucky_wheel', _s, string.format(Language['you_won_life'],quantidade))
			TriggerClientEvent('odin:recompensavida', _s,quantidade)

		elseif price.items[sorteio].nome == "colete" then
			TriggerClientEvent('odin:notify_lucky_wheel', _s, string.format(Language['you_won_armor'],quantidade))
			TriggerClientEvent('odin:recompensacolete', _s,quantidade)

		elseif price.items[sorteio].item == true then
			TriggerClientEvent('odin:notify_lucky_wheel', _s, string.format(Language['you_won_item'],quantidade,price.items[sorteio].nome))
			DarItem(user_id, price.items[sorteio].nome, quantidade)

		elseif price.items[sorteio].nome == "dinheiro" then
			TriggerClientEvent('odin:notify_lucky_wheel', _s, string.format(Language['you_won_money'],quantidade))
			if price.items[sorteio].dinheiroitem == false then
				DarDinheiro(user_id,quantidade)
			else
				DarItem(user_id, price.items[sorteio].dinheiroitem, quantidade)
			end
		end
	end

	TriggerClientEvent("luckywheel:rollFinished", -1,id)
end)


RegisterServerEvent('luckywheel:stoproll')
AddEventHandler('luckywheel:stoproll', function(id)
	wheels[id] = false

end)

RegisterServerEvent('luckywheel:finishedanim')
AddEventHandler('luckywheel:finishedanim', function(xPlayer, priceIndex, price,id)
	TriggerClientEvent("luckywheel:startroll", -1, xPlayer, priceIndex, price,id)
end)


