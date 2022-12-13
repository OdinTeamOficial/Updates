local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")
local Tools = module("vrp", "lib/Tools")
vRP = Proxy.getInterface("vRP") 
vRPclient = Tunnel.getInterface("vRP")
fodaSKI = Tunnel.getInterface(GetCurrentResourceName())




local wheels = {}
local podium_models = {}
local vehicles = {}
local car_of_day = nil
local user_id


local m1a = GetHashKey('vw_prop_vw_luckylight_off')
local m1b = GetHashKey('vw_prop_vw_luckylight_on')
local m2a = GetHashKey('vw_prop_vw_jackpot_off')
local m2b = GetHashKey('vw_prop_vw_jackpot_on')
	
	
	
Citizen.CreateThread(function()
	user_id = fodaSKI.returid()
	car_of_day = fodaSKI.getcarofday()
	local model1 = GetHashKey('vw_prop_vw_luckywheel_02a')
	local model2 = GetHashKey('vw_prop_vw_luckywheel_01a')
	local podiumModel = GetHashKey('vw_prop_vw_casino_podium_01a')
	RequestModel(model1) while not HasModelLoaded(model1) do Citizen.Wait(0) end
	RequestModel(model2) while not HasModelLoaded(model2) do Citizen.Wait(0) end
	local _wheel, _base, _lights1, _lights2, _arrow1, _arrow2 = nil, nil, nil, nil, nil, nil
	RequestModel(m1a) while not HasModelLoaded(m1a) do Citizen.Wait(0) end
	RequestModel(m1b) while not HasModelLoaded(m1b) do Citizen.Wait(0) end
	RequestModel(m2a) while not HasModelLoaded(m2a) do Citizen.Wait(0) end
	RequestModel(m2b) while not HasModelLoaded(m2b) do Citizen.Wait(0) end
	
	for k,v in pairs(Config.Wheels) do
		ClearArea(v.spawn[1],v.spawn[2],v.spawn[3], 5.0, true, false, false, false)
		local rot = v.spawn[4] - 180
		_base = CreateObject(model2, v.spawn[1],v.spawn[2],v.spawn[3]-0.97, false, false, true)
		SetEntityHeading(_base, rot)
		SetModelAsNoLongerNeeded(_base)


		_wheel = CreateObject(model1, GetOffsetFromEntityInWorldCoords(_base, 0.0, 0.0, 0.23), false, false, true)
		SetEntityHeading(_wheel, rot)
		SetModelAsNoLongerNeeded(model1)


		_lights1 = CreateObject(m1a, GetOffsetFromEntityInWorldCoords(_base, 0.0, 0.0, 0.6), false, false, true)
		SetEntityHeading(_lights1, rot)

		SetModelAsNoLongerNeeded(_lights1)

		_lights2 = CreateObject(m1b, GetOffsetFromEntityInWorldCoords(_base, 0.0, 0.0, 0.6), false, false, true)
		SetEntityVisible(_lights2, false, 0)
		SetEntityHeading(_lights2, rot)

		SetModelAsNoLongerNeeded(_lights2)

		_arrow1 = CreateObject(m2a, GetOffsetFromEntityInWorldCoords(_base, 0.0, 0.0, 2.7), false, false, true)
		SetEntityHeading(_arrow1, rot)

		SetModelAsNoLongerNeeded(_arrow1)

		_arrow2 = CreateObject(m2b, GetOffsetFromEntityInWorldCoords(_base, 0.0, 0.0, 2.7), false, false, true)
		SetEntityVisible(_arrow2, false, 0)
		SetEntityHeading(_arrow2, rot)
		SetModelAsNoLongerNeeded(_arrow2)
		
		PlaceObjectOnGroundProperly(_base)
		wheels[k] = {rolling = false, _base = _base,_wheel = _wheel, _lights1 = _lights1, _lights2 = _lights2, _arrow1 = _arrow1, _arrow2 = _arrow2, h = GetEntityRotation(_wheel)}


		if v.expo then
			RequestModel(podiumModel)
			while not HasModelLoaded(podiumModel) do
				Citizen.Wait(0)
			end
			_podiumModel = CreateObject(podiumModel, v.spawn_expo[1], v.spawn_expo[2], v.spawn_expo[3] -1.0, false, false, true)
			podium_models[k] = { _podiumModel = _podiumModel, rot = v.rot}
			SetEntityHeading(_podiumModel, v.spawn_expo[4])
			SetModelAsNoLongerNeeded(podiumModel)
		end
		if Config.substituirIMG then
			while not DoesEntityExist(PlayerPedId()) or not DoesEntityExist(_wheel) do Wait(0) end
			CreateRuntimeTextureReplace("vw_prop_vw_luckywheel", "prop_luckywheel_decal_dprop_luckywheel_decal_a", "images/prop_luckywheel_decal_dprop_luckywheel_decal_a.png","ola")
			CreateRuntimeTextureReplace("vw_prop_vw_luckywheel", "prop_luckywheel_01a_d2", "images/prop_luckywheel_01a_d2.png","ola2")
		end
	end

end)



Citizen.CreateThread(function()


	while true do
		local saulo2 = 1000
		
		
		for k,v in pairs(Config.Wheels) do
			if v.expo then

				if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), v.spawn_vehicle[1], v.spawn_vehicle[2], v.spawn_vehicle[3], true) < 100 then
					saulo2 = 5

					if #vehicles == 0 or not DoesEntityExist(vehicles[k].vehicle) then

						if car_of_day then

							local hash = GetHashKey(car_of_day)
							RequestModel(hash)
							while not HasModelLoaded(hash) do
								Wait(1)
							end

							vehicle = CreateVehicle(hash, v.spawn_vehicle[1], v.spawn_vehicle[2], v.spawn_vehicle[3], v.spawn_vehicle[4], false, false)
							FreezeEntityPosition(vehicle, true)
							SetEntityInvincible(vehicle, true)
							SetVehicleColours(vehicle, 62, 159)
							SetEntityCoords(vehicle, v.spawn_vehicle[1], v.spawn_vehicle[2], v.spawn_vehicle[3], false, false, false, true)
							SetVehicleNumberPlateText(vehicle, Config.Placa)
							SetVehicleDirtLevel(vehicle, 0.0)
							
							if Config.Lightson then
								SetVehicleLightsMode(vehicle,2)
								SetVehicleLights(vehicle,2)
							end

							if Config.NeonOn then
								for i = 0,3 do
									SetVehicleNeonLightEnabled(vehicle, i, true)
								end
								SetVehicleNeonLightsColour(vehicle,Config.NeonColor[1],Config.NeonColor[2],Config.NeonColor[3])
							end
							vehicles[k] = { vehicle = vehicle,rot = v.rot}
						end
					else
						SetVehicleDoorsLocked(vehicles[k].vehicle, 2)
					end
				end
			end
		end
		Citizen.Wait(saulo2)
	end
end)

Citizen.CreateThread(function() 
    while true do
		local saulo3 = 1000
		for k,v in pairs(podium_models) do
			if v.rot then
				if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), GetEntityCoords(v._podiumModel), true) <= 100 then
					saulo3 = 5
					local _heading = GetEntityHeading(v._podiumModel)
					local _z = _heading - 0.05
					SetEntityHeading(v._podiumModel, _z)
				end
			end
		end
        Citizen.Wait(saulo3)
    end
end)

Citizen.CreateThread(function() 
    while true do
		local saulo4 = 1000
		for k,v in pairs(vehicles) do
			if DoesEntityExist(v.vehicle) and v.rot then
				if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), GetEntityCoords(v.vehicle), true) <= 100 then
					saulo4 = 5
					local _heading = GetEntityHeading(v.vehicle)
					local _z = _heading - 0.05
					SetEntityHeading(v.vehicle, _z)
				end
			end
		end
        Citizen.Wait(saulo4)
    end
end)


RegisterNetEvent("luckywheel:syncanim")
AddEventHandler("luckywheel:syncanim", function(xPlayer,priceIndex,price,id)
	doRoll(xPlayer,priceIndex,price,id)
end)

RegisterNetEvent("luckywheel:startroll")
AddEventHandler("luckywheel:startroll", function(s, index, p,id)
	RequestScriptAudioBank("DLC_VINEWOOD\\CASINO_GENERAL", false)
	local bla = tonumber(s)
	local _lights1 = wheels[id]._lights1
	local _lights2 = wheels[id]._lights1
	local _wheel = wheels[id]._wheel
	local _arrow1 = wheels[id]._arrow1
	local _arrow2 = wheels[id]._arrow2
	local h = wheels[id].h
	
	SetEntityVisible(_lights1, false, 0)
	SetEntityVisible(_lights2, true, 0)

	win = (index - 1) * 18 + 0.0

	local j = 360
	

	if bla == user_id then

		PlaySoundFromEntity(-1, "Spin_Start", _wheel, 'dlc_vw_casino_lucky_wheel_sounds', 1, 1)
	end

	for i=1,1100,1 do
		
		SetEntityRotation(_wheel, h.x, j+0.0, h.z, 0, false)
		if i < 50 then
			j = j - 1.5
		elseif i < 100 then
			j = j - 2.0
		elseif i < 150 then
			j = j - 2.5
			
			
		elseif i > 1060 then
			j = j - 0.3
		elseif i > 1030 then
			j = j - 0.6
		elseif i > 1000 then
			j = j - 0.9
		elseif i > 970 then
			j = j - 1.2
		elseif i > 940 then
			j = j - 1.5
		elseif i > 910 then
			j = j - 1.8
		elseif i > 880 then
			j = j - 2.1
		elseif i > 850 then
			j = j - 2.4
		elseif i > 820 then
			j = j - 2.7
		else
			j = j - 3.0
		end
		if i == 850 then j = math.random(win-4, win+10) + 0.0 end
		if j > 360 then j = j + 0 end
		if j < 0 then j = j + 360 end
		if i == 900 then
		end
		Citizen.Wait(0)
	end

	Citizen.Wait(300)
	SetEntityVisible(_arrow1, false, 0)
	SetEntityVisible(_arrow2, true, 0)

	local t = true
	

	if bla == user_id then

		if p.sound == 'car' then
			PlaySoundFromEntity(-1, "Win_Car", _wheel, 'dlc_vw_casino_lucky_wheel_sounds', 1, 1)
		elseif p.sound == 'cash' then
			PlaySoundFromEntity(-1, "Win_Cash", _wheel, 'dlc_vw_casino_lucky_wheel_sounds', 1, 1)
		elseif p.sound == 'chips' then
			PlaySoundFromEntity(-1, "Win_Chips", _wheel, 'dlc_vw_casino_lucky_wheel_sounds', 1, 1)
		elseif p.sound == 'clothes' then
			PlaySoundFromEntity(-1, "Win_Clothes", _wheel, 'dlc_vw_casino_lucky_wheel_sounds', 1, 1)
		elseif p.sound == 'mystery' then
			PlaySoundFromEntity(-1, "Win_Mystery", _wheel, 'dlc_vw_casino_lucky_wheel_sounds', 1, 1)
		else
			PlaySoundFromEntity(-1, "Win", _wheel, 'dlc_vw_casino_lucky_wheel_sounds', 1, 1)
		end

		if Config.firework then

			if not HasNamedPtfxAssetLoaded(Config.FireworkAsset[1]) then
				RequestNamedPtfxAsset(Config.FireworkAsset[1])
				while not HasNamedPtfxAssetLoaded(Config.FireworkAsset[1]) do
					Wait(10)
				end
			end
	
	
	
			UseParticleFxAssetNextCall(Config.FireworkAsset[1])
			SetParticleFxNonLoopedColour(1.0, 0.0, 0.0)
			StartNetworkedParticleFxNonLoopedAtCoord(Config.FireworkAsset[2], GetOffsetFromEntityInWorldCoords(_wheel, Config.offsetFirework), 0.0, 0.0, 0.0, 1.0, false, false, false, false) -- Start the animation itself
	
			RemoveNamedPtfxAsset(Config.FireworkAsset[1])
		end
	end



		
	for i=1,15,1 do
		Citizen.Wait(200)
		SetEntityVisible(_lights1, t, 0)
		SetEntityVisible(_arrow2, t, 0)
		t = not t
		SetEntityVisible(_lights2, t, 0)
		SetEntityVisible(_arrow1, t, 0)
		if i == 5 then

			if s == user_id then

				TriggerServerEvent('luckywheel:give', bla, p,id)
			end
		end
	end

	Citizen.Wait(1000)
	SetEntityVisible(_lights1, true, 0)
	SetEntityVisible(_lights2, false, 0)
	SetEntityVisible(_arrow1, true, 0)
	SetEntityVisible(_arrow2, false, 0)
	TriggerServerEvent('luckywheel:stoproll',id)
end)

RegisterNetEvent("luckywheel:rollFinished")
AddEventHandler("luckywheel:rollFinished", function(id) 
	wheels[id].rolling = false
end)

function CreateRuntimeTextureReplace(OldTXD, OldTXN, media,name)
	local nometxd = name.."Txd"
	local nometex = name.."Tex"
	
	local txd = CreateRuntimeTxd(nometxd)
	local tx = CreateRuntimeTextureFromImage(txd,nometex,media)
	
	AddReplaceTexture(OldTXD, OldTXN, nometxd, nometex)
end

function doRoll(xPlayer, priceIndex, price,id)

    if not wheels[id].rolling then
        wheels[id].rolling = true
		local _base = wheels[id]._base
        local playerPed = PlayerPedId()
        local _lib = 'anim_casino_a@amb@casino@games@lucky7wheel@female'
        if IsPedMale(playerPed) then
            _lib = 'anim_casino_a@amb@casino@games@lucky7wheel@male'
        end
        local lib, anim = _lib, 'enter_right_to_baseidle'
		RequestAnimDict(lib)
        while not HasAnimDictLoaded(lib) do Wait(0) end

		local _movePos = GetObjectOffsetFromCoords(GetEntityCoords(_base), GetEntityHeading(_base),-0.9, -0.8, -1.0)
        TaskGoStraightToCoord(playerPed,  _movePos.x,  _movePos.y,  _movePos.z,  1.0,  3000,  GetEntityHeading(_base),  0.0)
        local _isMoved = false
        while not _isMoved do
            local coords = GetEntityCoords(PlayerPedId())
            if coords.x >= (_movePos.x - 0.01) and coords.x <= (_movePos.x + 0.01) and coords.y >= (_movePos.y - 0.01) and coords.y <= (_movePos.y + 0.01) then
                _isMoved = true
            end
            Citizen.Wait(0)
        end
		SetEntityHeading(playerPed, GetEntityHeading(_base))
		
        TaskPlayAnim(playerPed, lib, anim, 8.0, -8.0, -1, 0, 0, false, false, false)
		
		
        while IsEntityPlayingAnim(playerPed, lib, anim, 3) do
			Citizen.Wait(0)
			DisableAllControlActions(0)
        end
		
		
        TaskPlayAnim(playerPed, lib, 'enter_to_armraisedidle', 8.0, -8.0, -1, 0, 0, false, false, false)
		
        while IsEntityPlayingAnim(playerPed, lib, 'enter_to_armraisedidle', 3) do
            Citizen.Wait(0)
            DisableAllControlActions(0)
        end

		TriggerServerEvent('luckywheel:finishedanim',xPlayer, priceIndex, price,id)
        TaskPlayAnim(playerPed, lib, 'armraisedidle_to_spinningidle_high', 8.0, -8.0, -1, 0, 0, false, false, false)
		
    end
end

Citizen.CreateThread(function()
	while #wheels <= 0 do Wait(0) end
	
	while true do
		local saulo = 1000
        
        local coords = GetEntityCoords(PlayerPedId())
		
		for k,v in pairs(Config.Wheels) do
			if(GetDistanceBetweenCoords(coords, v.spawn, true) < 1.5) and not wheels[k].rolling then
				saulo = 1
				if Config.helptext == 2 then
					helptext_2(Language['spin_wheel'])
				else
					helpText(Language['spin_wheel'])
				end
				
				if IsControlJustReleased(0, 38) then
					local permi = true
					if Config.OnlyVip then
						if not fodaSKI.returnvip() then
							permi = false
							helptext_2(Language['only_vips'])
						end
					end
					if permi then
						TriggerServerEvent("luckywheel:getwheel",k)
					end
				end
			end	
		end	
		Citizen.Wait(saulo)
	end
end)

function helptext_2(string)
	BeginTextCommandThefeedPost("STRING")
	AddTextComponentSubstringPlayerName(string)
	EndTextCommandThefeedPostTicker(true, true)
end

function helpText(string)
	print("chegou",string)
    SetTextComponentFormat("STRING")
    AddTextComponentString(string)                                 
    DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end

RegisterNetEvent('odin:notify_lucky_wheel')
AddEventHandler('odin:notify_lucky_wheel',helptext_2)

RegisterNetEvent('odin:recompensavida')
AddEventHandler('odin:recompensavida',function(vida)
	local ped = PlayerPedId()
	SetEntityHealth(ped,vida)
end)

RegisterNetEvent('odin:recompensacolete')
AddEventHandler('odin:recompensacolete',function(colete)
	local ped = PlayerPedId()
	SetPedArmour(ped,colete)
end)