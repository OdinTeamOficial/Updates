Tunnel = module("vrp","lib/Tunnel")
Proxy = module("vrp","lib/Proxy")
vRPclient = Tunnel.getInterface("vRP")
vRP = Proxy.getInterface("vRP")
fodaSKI = {}
Tunnel.bindInterface(GetCurrentResourceName(),fodaSKI)


function fodaSKI.getuserid(nsource)
  local nnsource = nsource
  if not nnsource then
    nnsource = source
  end
  return vRP.getUserId(nnsource)
end

function fodaSKI.getmultas(user_id)
  local multas = vRP.query('SkS/selectMultas',{ user_id = user_id })
  --local value = vRP.getUData(parseInt(user_id),"vRP:multas")
  --local multas = json.decode(value)
  --local multas = vRP.getFines(parseInt(user_id))[1] or 0
  return multas[1].multas or 0
end

function fodaSKI.getplaca()
  return vRP.getRegistrationNumber()
end

function fodaSKI.getpermission(perm)
  local user_id = fodaSKI.getuserid()
  return vRP.hasPermission(user_id,perm)
end

function fodaSKI.getidentity(user_id)
  return vRP.getUserIdentity(user_id)
end

function fodaSKI.tryfullpayment(user_id,price)
  return vRP.tryFullPayment(user_id,price)
end

function fodaSKI.givebankmoney(user_id,val)
  return vRP.giveBankMoney(user_id,val)
end

function fodaSKI.getusersource(user_id)
  return vRP.getUserSource(user_id)
end

function fodaSKI.getusermoney(user_id)
  local source = source
  local nuser_id = user_id
  print("chegou pegar money 1")
  if not nuser_id then
    nuser_id = fodaSKI.getuserid(source)
  end
  print("chegou pegar money 2",nuser_id)

  return vRP.getMoney(nuser_id)
end

function fodaSKI.getuserbankmoney(user_id)
  local source = source
  local nuser_id = user_id

  if not nuser_id then
    nuser_id = fodaSKI.getuserid(source)
  end

  return vRP.getBankMoney(nuser_id)
end

function fodaSKI.CanPlayerAfford(val)
  local source = source
  local user_id = fodaSKI.getuserid()

  if fodaSKI.getusermoney(user_id) >= val then
    return true
  elseif fodaSKI.getuserbankmoney(user_id) >= val then
    return true
  else
    NotifyPlayer(source,Labels['CantAffordHouse'])
    return false
  end
end

function fodaSKI.getlockpick()
  local source = source
  local user_id = fodaSKI.getuserid(source)
  if vRP.getInventoryItemAmount(user_id, "lockpick") > 0 then
    return true
  else
    return false
  end
end


function check_vehicle(veiculoss)

  local name = veiculoss.spawn
  if name then
		local source = source
		local user_id = fodaSKI.getuserid(source)
		if user_id then
			local identity = fodaSKI.getidentity(user_id)
      local multas = fodaSKI.getmultas(user_id)
			
			if multas >= 10000 then
				TriggerClientEvent("Notify",source,"negado","Você tem multas pendentes.",10000)
				return true
			end


			local tuning = vRP.getSData("custom:u"..user_id.."veh_"..name) or {}
			local custom = json.decode(tuning) or {}

			if parseInt(os.time()) <= parseInt(veiculoss.time+24*60*60) then
				local ok = vRP.request(source,"Veículo na retenção, deseja acionar o seguro pagando <b>$"..vRP.format(parseInt(vRP.vehiclePrice(name)*0.2)).."</b> dólares ?",60)
				if ok then
          local valor = vRP.vehiclePrice(name)*0.2
					if fodaSKI.tryfullpayment(user_id,parseInt(valor)) then
            
            vRP.execute("creative/set_detido",{ user_id = parseInt(user_id), vehicle = name, detido = 0, time = 0 })
						
						TriggerClientEvent("Notify",source,"sucesso","Veículo liberado.",10000)
					else
						TriggerClientEvent("Notify",source,"negado","Dinheiro insuficiente.",10000)
					end
				end
			elseif parseInt(veiculoss.detido) >= 1 then
				local ok = vRP.request(source,"Veículo na detenção, deseja acionar o seguro pagando <b>$"..vRP.format(parseInt(vRP.vehiclePrice(name)*0.1)).."</b> dólares ?",60)
				if ok then
          local valor = vRP.vehiclePrice(name)*0.1
					if fodaSKI.tryfullpayment(user_id,parseInt(vRP.vehiclePrice(name)*0.1)) then

            vRP.execute("creative/set_detido",{ user_id = parseInt(user_id), vehicle = name, detido = 0, time = 0 })

            
						TriggerClientEvent("Notify",source,"sucesso","Veículo liberado.",10000)
					else
						TriggerClientEvent("Notify",source,"negado","Dinheiro insuficiente.",10000)
					end
				end
			else

        local placa = identity.registration or veiculoss.plate
        if veiculoss.plate and veiculoss.plate ~= nil then
          placa = veiculoss.plate
        end
        
        TriggerClientEvent("Allhousing:spawnvehicleodin",source,name,veiculoss.engine,veiculoss.body,veiculoss.fuel,custom,placa)

				TriggerClientEvent("setPlateEveryone",placa)
        --TriggerEvent("setPlatePlayers",placa,user_id)
        TriggerClientEvent("vrp_odinhouse:Addcar",source,name,true)
  
        for k,v in pairs(vehicle_players[user_id]) do
          if v.spawn == veiculoss.spawn then
            
            v.retirado = true
          end
        end
			end
		end
	end
end


NotifyJobs = function(job,msg,pos)
  TriggerClientEvent("Allhousing:NotifyJob",-1,job,msg,pos)
end

NotifyPlayer = function(source,msg)
  TriggerClientEvent("Allhousing:NotifyPlayer",source,msg)
end

RegisterNetEvent("Allhousing:NotifyJobs")
AddEventHandler("Allhousing:NotifyJobs",NotifyJobs)