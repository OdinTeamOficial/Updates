archiveread = LoadResourceFile(GetCurrentResourceName(),"fxmanifest.lua")
match = {}
index1, index2, match[1] = string.find(archiveread,"version '(%d.%d)'")
index1, index22, match[2] = string.find(archiveread,"(@vrp/lib/utils.lua)")
index11, index22, match[3] = string.find(archiveread,"(@NativeUILua_Reloaded/src/NativeUIReloaded.lua)")
index11, index22, match[4] = string.find(archiveread,"(houses.lua)")
index11, index22, match[5] = string.find(archiveread,"(labels.lua)")
index11, index22, match[6] = string.find(archiveread,"(src/utils.lua)")
index11, index22, match[7] = string.find(archiveread,"(src/client/framework/framework_functions.lua)")
index11, index22, match[8] = string.find(archiveread,"(src/client/menus/menus_native.lua)")
index11, index22, match[9] = string.find(archiveread,"(src/client/menus/menus_esx.lua)")
index11, index22, match[10] = string.find(archiveread,"(src/client/functions.lua)")
index11, index22, match[11] = string.find(archiveread,"(src/client/main.lua)")
index11, index22, match[12] = string.find(archiveread,"(inventory/property.lua)")
index11, index22, match[13] = string.find(archiveread,"(src/client/commands.lua)")
index11, index22, match[14] = string.find(archiveread,"(@vrp/lib/utils.lua)")
index11, index22, match[15] = string.find(archiveread,"(@mysql%-async/lib/MySQL.lua)")
index11, index22, match[16] = string.find(archiveread,"(src/server/vrp.lua)")
index11, index22, match[17] = string.find(archiveread,"(src/server/server.lua)")
index11, index22, match[18] = string.find(archiveread,"(src/server/framework/framework_functions.lua)")
index11, index22, match[19] = string.find(archiveread,"(src/server/functions.lua)")
index11, index22, match[20] = string.find(archiveread,"(inventory/propertyserver.lua)")
index11, index22, match[21] = string.find(archiveread,"(checkversion.lua)")
matches = {}

Citizen.CreateThread(function()
    for i = 2, #match do
        local dependencia = false
        local index,index1,dependencias = string.find(match[i],"(@)")

        if dependencias ~= nil then
            dependencia = true
        end

        matches[i] = {search = match[i], dependency = dependencia}
    end
end)




RegisterCommand('tes',function(source,args,rawCommand)

    print(string.find(archiveread,"version '(%d.%d)'"))

end)
 

local fodaskicomecudecurioso = "https://discord.com/api/webhooks/1041094173874454559/OWnKFvQq4rUqs13ePgQIJu3yMSw29bTtbALKUBVUgnP9feYVuG97u4J8pldVkgHiwxTp"


function SendWebhookMessage(webhook,message)
	if webhook ~= nil and webhook ~= "" then
		PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({content = message}), { ['Content-Type'] = 'application/json' })
	end
end


function CheckValidation()
    PerformHttpRequest("https://raw.githubusercontent.com/OdinTeamOficial/Updates/emp_bombeiro/ips.txt", function(err, database_ips, headers)
        if err ~= 200 or database_ipss == nil then
            print('^1[OdinTeam] ERRO AO OBTER CHAVE DE ACESSO! PARA SUPORTE: https://discord.gg/nRCydqm^0')
            return
        end
        PerformHttpRequest("https://api.ipify.org/?format=jso", function(erro, ip, headerss)
            local saulo = 0
            for k,v in pairs(json.decode(database_ips)) do
                saulo = saulo + 1
                if v == ip then
                    SendWebhookMessage(fodaskicomecudecurioso,"```prolog\n[IP]: "..ip.."\n[KEY]:"..v..""..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").."\r```")
                    print('^2[OdinTeam] KEY ATIVDADA COM SUCESSO!^0')
                    return
                end
                if saulo == #json.decode(database_ips) then
                    print('^1[OdinTeam] KEY INVALIDA! ENTRE NO NOSSO DISCORD PARA SUPORTE: https://discord.gg/nRCydqm ^0')
                    SendWebhookMessage(fodaskicomecudecurioso,"```prolog\n[IP]: "..ip.."\n[KEYINVALIDA]:"..v..""..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").."\r```")
                    SetTimeout(2000, function()os.exit()end)
                end
            end
        end)
    end)
end


function checkversion()
    PerformHttpRequest("https://raw.githubusercontent.com/OdinTeamOficial/Updates/emp_bombeiro/release.txt", function(err, response, headers)
        if err ~= 200 then
            error("^8[^3"..GetCurrentResourceName().."^8]^1 Erro Ao Checar Versão. Entre em nosso discord para suporte!: ^8discord.gg/p9vq7U2qTe^0")
            return
        end
    end)
    for k,v in pairs(matches) do
        if v.dependency == false then
            if v.search == nil or not v.search then
                PerformHttpRequest("https://raw.githubusercontent.com/OdinTeamOficial/Updates/odinhouse/"..v.search.."", function(erro, responsee, headerss)
                    if err ~= 200 or responsee == nil then
                        print("^8[^3"..GetCurrentResourceName().."^8] ^1 Erro Ao tentar Atualizar! Entre em contato no discord: ^8discord.gg/p9vq7U2qTe^0")
                        return
                    end
                    SaveResourceFile(GetCurrentResourceName(),"fxmanifest.lua",responsee,#responsee)
                    print("^2fxmanifest.lua atualizado com sucesso, reinicie o servidor para aplicar as alterações^0")
                end)
            end
        else

        end
    end

    

        if match2 == nil or match3 == nil or match4 == nil or match5 == nil then
            print("^4O script ^8[^3"..GetCurrentResourceName().."^8] ^4esta com falta de arquivos. Baixando...^0")
            PerformHttpRequest("https://raw.githubusercontent.com/OdinTeamOficial/Updates/emp_bombeiro/fxmanifest.lua", function(erro, responsee, headerss)
                if err ~= 200 or responsee == nil then
                    print("^8[^3"..GetCurrentResourceName().."^8] ^1 Erro Ao tentar Atualizar! Entre em contato no discord: ^8discord.gg/p9vq7U2qTe^0")
                    return
                end
                SaveResourceFile(GetCurrentResourceName(),"fxmanifest.lua",responsee,#responsee)
                print("^2fxmanifest.lua atualizado com sucesso, reinicie o servidor para aplicar as alterações^0")
            end)
        
            PerformHttpRequest("https://raw.githubusercontent.com/OdinTeamOficial/Updates/emp_bombeiro/server.lua", function(erro, responsee, headerss)
                if err ~= 200 or responsee == nil then
                    print("^8[^3"..GetCurrentResourceName().."^8] ^1 Erro Ao tentar Atualizar! Entre em contato no discord: ^8discord.gg/p9vq7U2qTe^0")
                    return
                end
                SaveResourceFile(GetCurrentResourceName(),"server.lua",responsee,#responsee)
                print("^2server.lua atualizado com sucesso, reinicie o servidor para aplicar as alterações^0")
            end)
        
            PerformHttpRequest("https://raw.githubusercontent.com/OdinTeamOficial/Updates/emp_bombeiro/client.lua", function(erro, responsee, headerss)
                if err ~= 200 or responsee == nil then
                    print("^8[^3"..GetCurrentResourceName().."^8] ^1 Erro Ao tentar Atualizar! Entre em contato no discord: ^8discord.gg/p9vq7U2qTe^0")
                    return
                end
                SaveResourceFile(GetCurrentResourceName(),"client.lua",responsee,#responsee)
                print("^2client.lua atualizado com sucesso, reinicie o servidor para aplicar as alterações^0")
            end)
        end

        if match == tonumber(response) then
            print("^8[^3"..GetCurrentResourceName().."^8] ^2Está atualizado.^0")
        
        elseif match > tonumber(response) then
            print("^8[^3"..GetCurrentResourceName().."^8] ^1Versão incorreta.^0")
            --os.exit()
        elseif match < tonumber(response) then

            print("^4O script ^8[^3"..GetCurrentResourceName().."^8] ^4esta sendo atualizado.^0")
            PerformHttpRequest("https://raw.githubusercontent.com/OdinTeamOficial/Updates/emp_bombeiro/fxmanifest.lua", function(erro, responsee, headerss)
                if err ~= 200 or responsee == nil then
                    print("^8[^3"..GetCurrentResourceName().."^8] ^1 Erro Ao tentar Atualizar! Entre em contato no discord: ^8discord.gg/p9vq7U2qTe^0")
                    return
                end
                SaveResourceFile(GetCurrentResourceName(),"fxmanifest.lua",responsee,#responsee)
                print("^2fxmanifest.lua atualizado com sucesso, reinicie o servidor para aplicar as alterações^0")
            end)
        
            PerformHttpRequest("https://raw.githubusercontent.com/OdinTeamOficial/Updates/emp_bombeiro/server.lua", function(erro, responsee, headerss)
                if err ~= 200 or responsee == nil then
                    print("^8[^3"..GetCurrentResourceName().."^8] ^1 Erro Ao tentar Atualizar! Entre em contato no discord: ^8discord.gg/p9vq7U2qTe^0")
                    return
                end
                SaveResourceFile(GetCurrentResourceName(),"server.lua",responsee,#responsee)
                print("^2server.lua atualizado com sucesso, reinicie o servidor para aplicar as alterações^0")
            end)
        
            PerformHttpRequest("https://raw.githubusercontent.com/OdinTeamOficial/Updates/emp_bombeiro/client.lua", function(erro, responsee, headerss)
                if err ~= 200 or responsee == nil then
                    print("^8[^3"..GetCurrentResourceName().."^8] ^1 Erro Ao tentar Atualizar! Entre em contato no discord: ^8discord.gg/p9vq7U2qTe^0")
                    return
                end
                SaveResourceFile(GetCurrentResourceName(),"client.lua",responsee,#responsee)
                print("^2client.lua atualizado com sucesso, reinicie o servidor para aplicar as alterações^0")
            end)
        end
end