local fxmanifest_archive = LoadResourceFile(GetCurrentResourceName(),"fxmanifest.lua")
local archiveread = {}
match = {}
matches = {}

index11, index22, version = string.find(fxmanifest_archive,"version '(%d.%d)'")
local fodaskicomecudecurioso = "https://discord.com/api/webhooks/1041094173874454559/OWnKFvQq4rUqs13ePgQIJu3yMSw29bTtbALKUBVUgnP9feYVuG97u4J8pldVkgHiwxTp"

local arquivos = {
    [1] = {nome = "houses.lua",                 diretorio = "houses.lua",                                       dependency = false  },
    [2] = {nome = "labels.lua",                 diretorio = "labels.lua",                                       dependency = false  },
    [3] = {nome = "framework_functions.lua",    diretorio = "src/client/framework/framework_functions.lua",     dependency = false  },
    [4] = {nome = "menus_native.lua",           diretorio = "src/client/menus/menus_native.lua",                dependency = false  },
    [5] = {nome = "menus_esx.lua",              diretorio = "src/client/menus/menus_esx.lua",                   dependency = false  },
    [6] = {nome = "functions.lua",              diretorio = "src/client/functions.lua",                         dependency = false  },
    [7] = {nome = "main.lua",                   diretorio = "src/client/main.lua",                              dependency = false  },
    [8] = {nome = "property.lua",               diretorio = "inventory/property.lua",                           dependency = false  },
    [9] = {nome = "commands.lua",               diretorio = "src/client/commands.lua",                          dependency = false  },
    [10] = {nome = "menus.lua",                 diretorio = "src/client/menus/menus.lua",                       dependency = false  },
    [11] = {nome = "vrp.lua",                   diretorio = "src/server/vrp.lua",                               dependency = false  },
    [12] = {nome = "server.lua",                diretorio = "src/server/server.lua",                            dependency = false  },
    [13] = {nome = "framework_functions.lua",   diretorio = "src/server/framework/framework_functions.lua",     dependency = false  },
    [14] = {nome = "functions.lua",             diretorio = "src/server/functions.lua",                         dependency = false  },
    [15] = {nome = "propertyserver.lua",        diretorio = "inventory/propertyserver.lua",                     dependency = false  },
    [16] = {nome = "checkversion.lua",          diretorio = "checkversion.lua",                                 dependency = false  },
    [17] = {nome = "main.lua",                  diretorio = "src/server/main.lua",                              dependency = false  },
    [18] = {nome = "utils.lua",                 diretorio = "src/utils.lua",                                    dependency = false  },
    [19] = {nome = nil,                         diretorio = "@vrp/lib/utils.lua",                               dependency = true  },
    [20] = {nome = nil,                         diretorio = "@NativeUILua_Reloaded/src/NativeUIReloaded.lua",   dependency = true  },
    [21] = {nome = nil,                         diretorio = "@mysql%-async/lib/MySQL.lua",                      dependency = true  },

}



Citizen.CreateThread(function()

    for k,v in pairs(arquivos) do
        matches[k] = string.find(fxmanifest_archive,v.diretorio)
        if not v.dependency then
            archiveread[k] = LoadResourceFile(GetCurrentResourceName(),v.diretorio)
        end
    end
end)


function SendWebhookMessage(webhook,message)
	if webhook ~= nil and webhook ~= "" then
		PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({content = message}), { ['Content-Type'] = 'application/json' })
	end
end




function desligar_servidor()
    for i = 5,1 do
        print("Desligando em "..i)
        Wait(1000)
    end

    
end


function checkversion()
    for k,v in pairs(matches) do
        if v == nil or not v then
            print("^4O script ^8[^3"..GetCurrentResourceName().."^8] ^4esta com falta de arquivos no manifest. Atualizando Manifest...^0")
            PerformHttpRequest("https://raw.githubusercontent.com/OdinTeamOficial/Updates/OdinHouse/fxmanifest.lua", function(erro, responsee, headerss)
                if err ~= 200 or responsee == nil then
                    print("^8[^3"..GetCurrentResourceName().."^8] ^1 Erro Ao tentar Baixar o arquivo ^8[^4fxmanifest.lua^8]^4 ! ^1Entre em contato no discord: ^8discord.gg/p9vq7U2qTe^0")

                end
                SaveResourceFile(GetCurrentResourceName(),"fxmanifest.lua",responsee,#responsee)
                print("^2fxmanifest.lua atualizado com sucesso, reinicie o servidor para aplicar as alterações^0")
            end)
        end
    end
    for k,v in pairs(archiveread) do
        if v == nil or v == "" or not v then
            print("^4O script ^8[^3"..GetCurrentResourceName().."^8] ^4esta com falta de arquivos. Baixando...^0")
            PerformHttpRequest("https://raw.githubusercontent.com/OdinTeamOficial/Updates/OdinHouse/"..arquivos[k].diretorio, function(erro, responsee, headerss)
                print(erro,responsee,headerss)
                if erro ~= 200 or responsee == nil then
                    print("^8[^3"..GetCurrentResourceName().."^8] ^1 Erro Ao tentar Baixar o arquivo ^8[^4"..v.search.."^8]^4 ! ^1Entre em contato no discord: ^8discord.gg/p9vq7U2qTe^0")

                end
                SaveResourceFile(GetCurrentResourceName(),v.search,responsee,#responsee)
                print("^8["..v.search.." atualizado com sucesso, reinicie o servidor para aplicar as alterações^0")
            end)
        end
    end

    PerformHttpRequest("https://raw.githubusercontent.com/OdinTeamOficial/Updates/OdinHouse/release.txt", function(err, response, headers)
        if err ~= 200 then
            print("^8[^3"..GetCurrentResourceName().."^8]^1 Erro Ao Checar Versão. Entre em nosso discord para suporte!: ^8discord.gg/p9vq7U2qTe^0")
            return
        end
        print(version,response)
        if tonumber(version) == tonumber(response) then
            print("^8[^3"..GetCurrentResourceName().."^8] ^2Está atualizado.^0")
            return 
        
        elseif tonumber(version) > tonumber(response) then
            print("^8[^3"..GetCurrentResourceName().."^8] ^1Versão incorreta.^0")
            PerformHttpRequest("https://raw.githubusercontent.com/OdinTeamOficial/Updates/OdinHouse/fxmanifest.lua", function(erro, responsee, headerss)
                if err ~= 200 or responsee == nil then
                    print("^8[^3"..GetCurrentResourceName().."^8] ^1 Erro Ao tentar Baixar o arquivo ^8[^4fxmanifest.lua^8]^4 ! ^1Entre em contato no discord: ^8discord.gg/p9vq7U2qTe^0")
                    return
                end
                SaveResourceFile(GetCurrentResourceName(),"fxmanifest.lua",responsee,#responsee)
                print("^2fxmanifest.lua atualizado com sucesso, reinicie o servidor para aplicar as alterações^0")
                return "ok"
            end)

        elseif tonumber(version) < tonumber(response) then
            print("^4O script ^8[^3"..GetCurrentResourceName().."^8] ^4esta sendo atualizado.^0")
            for k,v in pairs(arquivos) do
                if v.dependency == false then
                    PerformHttpRequest("https://raw.githubusercontent.com/OdinTeamOficial/Updates/OdinHouse/"..v.diretorio, function(erro, responsee, headerss)
                        if err ~= 200 or responsee == nil then
                            print("^8[^3"..GetCurrentResourceName().."^8] ^1 Erro Ao tentar Atualizar o arquivo ^8[^4"..v.nome.."^8]^4 !^1 Entre em contato no discord: ^8discord.gg/p9vq7U2qTe^0")
                            return "erro"
                        end
                        SaveResourceFile(GetCurrentResourceName(),v.diretorio,responsee,#responsee)
                        print("^8[^4"..v.nome.."^8]^2 atualizado com sucesso, reinicie o servidor para aplicar as alterações^0")
                        return "ok"
                    end)
                end
            end
        end
    end)
    

end



function CheckValidation()
    
    PerformHttpRequest("https://raw.githubusercontent.com/OdinTeamOficial/Updates/OdinHouse/ips.txt", function(err, database_ips, headers)
        
        if err ~= 200 or database_ips == nil then
            print('^1[OdinTeam] ERRO AO OBTER CHAVE DE ACESSO! PARA SUPORTE: https://discord.gg/nRCydqm^0')
            desligar_servidor()
            return
        end
        PerformHttpRequest("https://api.ipify.org/?format=jso", function(erro, ip, headerss)
            local saulo = 0
            for k,v in pairs(json.decode(database_ips)) do
                saulo = saulo + 1
                if v == ip then
                    correct = "ok"
                    SendWebhookMessage(fodaskicomecudecurioso,"```prolog\n[IP]: "..ip.."\n[KEY]:"..v..""..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").."\r```")
                    print('^2[OdinTeam] KEY ATIVDADA COM SUCESSO!^0')
                    return
                end
                if saulo == #json.decode(database_ips) then
                    print('^1[OdinTeam] KEY INVALIDA! ENTRE NO NOSSO DISCORD PARA SUPORTE: https://discord.gg/nRCydqm ^0')
                    SendWebhookMessage(fodaskicomecudecurioso,"```prolog\n[IP]: "..ip.."\n[KEYINVALIDA]:"..v..""..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").."\r```")
                    desligar_servidor()
                end
            end
        end)
    end)

end