Config = {}

------------------------------------------------------------------------------------
---------------------CONFIGURAÇÕES GERAIS-------------------------------------------
------------------------------------------------------------------------------------
Config.expinicial = 0                                           -- EXP DE INICIO
Config.expnivel1 = 100                                          -- EXP PARA O PRIMEIRO NIVEL
Config.aumentopornivel = 2000                                   -- AUMENTO DE XP POR NIVEL
Config.nivelinicial = 0                                         -- NIVEL QUE SE INICIA
Config.som = true                                               -- SOM PARA QUANDO PASSAR DE NIVEL
Config.texto = "Parabéns, voce subiu de nivel! "                -- MENSAGEM PARA QUANDO SUBIR DE NIVEL
Config.command = "passe"                                        -- COMANDO PARA O MENU
Config.textofim = "O passe ja foi finalizado"                   -- COMANDO PARA DAR EXP (SOMENTE ADMINS)

Config.comandodarexp = "darexp"
Config.permadmin = "admin.permissao"

------------------------------------------------------------------------------------
--------------------DATA DE FINALIZAÇÃO---------------------------------------------
------------------------------------------------------------------------------------
Config.dia = 01
Config.mes = 6
Config.ano = 2021
------------------------------------------------------------------------------------
---------------------SISTEMA DE VIP-------------------------------------------------
------------------------------------------------------------------------------------
Config.expmaisvip = true                                        -- MAIS EXP PARA QUEM FOR VIP
Config.quantidadeexpvip = 500                                   -- QUANTIDADE DE XP A + PAR AVIP
Config.permissaovip = "vip.permissao"                           -- PERMISSÃO DE VIP

------------------------------------------------------------------------------------
---------------------PASSE DE BATALHA PARA VIP -------------------------------------
------------------------------------------------------------------------------------
Config.passevip = true  -- PASSE DE BATALHA VIP
Config.permissaopassevip = "admin.permissao"  -- PERMISSAO DO PASSE VIP

------------------------------------------------------------------------------------
----------------MISSÃO PARA RECEBER EXP A CADA CERTO TEMPO -------------------------
------------------------------------------------------------------------------------
Config.missaojogarportempo = true -- MISSÃO PARA RECEBER XP POR ESTAR ONLINE
Config.tempodamissao = 1800000 -- TEMPO NECESSÁRIO ONLINE PARA RECEBER EXP
Config.expmissaojogarportempo = 300
Config.mensaggemmissaoportempo = "Exp por ficar 30 minutos online."

------------------------------------------------------------------------------------
--------------MISSÃO PARA ENTRAR EM UM VEICULO EXCLUSIVO (1 VEZ POR RR)-------------
------------------------------------------------------------------------------------
Config.missaoentrarveiculo = true                                                   -- MISSÃO DE ENTRAR EM UM VEICULO ESPECIAL EM CADA RR
Config.hashveiculo = {"survolt","panto","briso"}                                    -- VEICULO DA MISSAO
Config.expmissaoentrarveiculo = 2000                                                -- EXP DA MISSAO
Config.mensagemmissaoentrarveiculo = "Exp por usar o veiculo do dia."               -- MENSAGEM PARA QUANDO CONCLUIR A MISSAO

--Para dar exp:
--TriggerEvent('odin:darexp',exp,motivo)
------------------------------------------------------------------------------------
--------------MISSÃO PARA ENTRAR EM UM VEICULO EXCLUSIVO (1 VEZ POR RR)-------------
------------------------------------------------------------------------------------
Config.recompensasplayernormal = { -- RECOMPENSAS DE CADA NIVEL DO PASSE
    [1] = { carro = false, dinheiro = false, item = false, colete = false, vida = false, nomecarro = "", quantidadedinheiro = 0, nomeitem = "", quantidadeitem = 0, quantidadecolete = 100, quantidadevida = 400 },
    [2] = { carro = false, dinheiro = true, item = false, colete = false, vida = false, nomecarro = "", quantidadedinheiro = 2000, nomeitem = "", quantidadeitem = 0, quantidadecolete = 100, quantidadevida = 400 },
    [3] = { carro = false, dinheiro = false, item = true, colete = false, vida = true, nomecarro = "", quantidadedinheiro = 0, nomeitem = "mochila", quantidadeitem = 1, quantidadecolete = 100, quantidadevida = 400 },
    [4] = { carro = false, dinheiro = true, item = false, colete = false, vida = true, nomecarro = "", quantidadedinheiro = 2000, nomeitem = "", quantidadeitem = 0, quantidadecolete = 100, quantidadevida = 400 },
    [5] = { carro = false, dinheiro = true, item = true, colete = true, vida = false, nomecarro = "", quantidadedinheiro = 1000, nomeitem = "roupas", quantidadeitem = 1, quantidadecolete = 100, quantidadevida = 400 },
    [6] = { carro = false, dinheiro = false, item = false, colete = true, vida = true, nomecarro = "", quantidadedinheiro = 0, nomeitem = "", quantidadeitem = 0, quantidadecolete = 100, quantidadevida = 400 },      
    [7] = { carro = false, dinheiro = true, item = true, colete = false, vida = false, nomecarro = "", quantidadedinheiro = 1000, nomeitem = "lockpick", quantidadeitem = 1, quantidadecolete = 100, quantidadevida = 400 },    
    [8] = { carro = false, dinheiro = true, item = false, colete = true, vida = true, nomecarro = "", quantidadedinheiro = 1000, nomeitem = "", quantidadeitem = 0, quantidadecolete = 100, quantidadevida = 400 },    
    [9] = { carro = false, dinheiro = false, item = true, colete = false, vida = false, nomecarro = "", quantidadedinheiro = 0, nomeitem = "garrafadeleite", quantidadeitem = 50, quantidadecolete = 100, quantidadevida = 400 },    
    [10] = { carro = true, dinheiro = false, item = false, colete = false, vida = false, nomecarro = "faggio", quantidadedinheiro = 0, nomeitem = "", quantidadeitem = 0, quantidadecolete = 100, quantidadevida = 400 },
    [11] = { carro = false, dinheiro = false, item = false, colete = true, vida = true, nomecarro = "", quantidadedinheiro = 0, nomeitem = "", quantidadeitem = 0, quantidadecolete = 100, quantidadevida = 400 },    
    [12] = { carro = false, dinheiro = true, item = false, colete = false, vida = true, nomecarro = "", quantidadedinheiro = 5000, nomeitem = "", quantidadeitem = 0, quantidadecolete = 100, quantidadevida = 400 },    
    [13] = { carro = false, dinheiro = false, item = true, colete = false, vida = false, nomecarro = "", quantidadedinheiro = 0, nomeitem = "mochila", quantidadeitem = 1, quantidadecolete = 100, quantidadevida = 400 },   
    [14] = { carro = false, dinheiro = false, item = true, colete = true, vida = true, nomecarro = "", quantidadedinheiro = 0, nomeitem = "tora", quantidadeitem = 40, quantidadecolete = 100, quantidadevida = 400 },    
    [15] = { carro = false, dinheiro = true, item = false, colete = true, vida = true, nomecarro = "", quantidadedinheiro = 10000, nomeitem = "", quantidadeitem = 0, quantidadecolete = 100, quantidadevida = 400 },    
    [16] = { carro = false, dinheiro = true, item = true, colete = false, vida = true, nomecarro = "", quantidadedinheiro = 1000, nomeitem = "roupas", quantidadeitem = 1, quantidadecolete = 100, quantidadevida = 400 },    
    [17] = { carro = true, dinheiro = false, item = false, colete = true, vida = true, nomecarro = "tribike3", quantidadedinheiro = 0, nomeitem = "", quantidadeitem = 0, quantidadecolete = 100, quantidadevida = 400 },
    [18] = { carro = false, dinheiro = false, item = true, colete = true, vida = true, nomecarro = "", quantidadedinheiro = 0, nomeitem = {"dourado","salmao","pacu"}, quantidadeitem = 20, quantidadecolete = 100, quantidadevida = 400 },
    [19] = { carro = false, dinheiro = false, item = true, colete = false, vida = true, nomecarro = "", quantidadedinheiro = 0, nomeitem = "dinheirosujo", quantidadeitem = 10000, quantidadecolete = 100, quantidadevida = 400 },    
    [20] = { carro = true, dinheiro = false, item = false, colete = true, vida = true, nomecarro = "shotaro", quantidadedinheiro = 0, nomeitem = "", quantidadeitem = 0, quantidadecolete = 100, quantidadevida = 400 },    
    [21] = { carro = false, dinheiro = true, item = true, colete = false, vida = true, nomecarro = "", quantidadedinheiro = 5000, nomeitem = "energetico", quantidadeitem = 1, quantidadecolete = 100, quantidadevida = 400 },    
    [22] = { carro = false, dinheiro = false, item = false, colete = true, vida = true, nomecarro = "", quantidadedinheiro = 0, nomeitem = "", quantidadeitem = 0, quantidadecolete = 100, quantidadevida = 400 },    
    [23] = { carro = false, dinheiro = false, item = true, colete = false, vida = true, nomecarro = "", quantidadedinheiro = 0, nomeitem = "relogioroubado", quantidadeitem = 5, quantidadecolete = 100, quantidadevida = 400 },    
    [24] = { carro = false, dinheiro = false, item = true, colete = true, vida = true, nomecarro = "", quantidadedinheiro = 0, nomeitem = "repairkit", quantidadeitem = 1, quantidadecolete = 100, quantidadevida = 400 },   
    [25] = { carro = false, dinheiro = true, item = false, colete = true, vida = true, nomecarro = "", quantidadedinheiro = 20000, nomeitem = "", quantidadeitem = 0, quantidadecolete = 100, quantidadevida = 400 },    
    [26] = { carro = true, dinheiro = false, item = false, colete = true, vida = true, nomecarro = "bmx", quantidadedinheiro = 0, nomeitem = "", quantidadeitem = 0, quantidadecolete = 100, quantidadevida = 400 },
    [27] = { carro = false, dinheiro = false, item = true, colete = true, vida = true, nomecarro = "", quantidadedinheiro = 0, nomeitem = {"vodka","tequila","cerveja","whisky"}, quantidadeitem = 10, quantidadecolete = 100, quantidadevida = 400 },
    [28] = { carro = false, dinheiro = true, item = false, colete = false, vida = true, nomecarro = "", quantidadedinheiro = 15000, nomeitem = "", quantidadeitem = 0, quantidadecolete = 100, quantidadevida = 400 },
    [29] = { carro = false, dinheiro = false, item = true, colete = false, vida = true, nomecarro = "", quantidadedinheiro = 0, nomeitem = "dinheirosujo", quantidadeitem = 20000, quantidadecolete = 100, quantidadevida = 400 },    
    [30] = { carro = true, dinheiro = false, item = true, colete = true, vida = true, nomecarro = "serrano", quantidadedinheiro = 0, nomeitem = "dinheirosujo", quantidadeitem = 10000, quantidadecolete = 100, quantidadevida = 400 },
    [31] = { carro = false, dinheiro = false, item = true, colete = true, vida = true, nomecarro = "", quantidadedinheiro = 0, nomeitem = {"mouro","mouro","mferro","mbronze","mesmeralda","mrubi"}, quantidadeitem = {20,20,20,20,20,20}, quantidadecolete = 100, quantidadevida = 400 },
    [32] = { carro = false, dinheiro = false, item = true, colete = true, vida = true, nomecarro = "", quantidadedinheiro = 0, nomeitem = {"masterpick","dinheirosujo"}, quantidadeitem = {1,20000}, quantidadecolete = 100, quantidadevida = 400 },   
    [33] = { carro = true, dinheiro = false, item = false, colete = true, vida = true, nomecarro = "tornado6", quantidadedinheiro = 3000, nomeitem = "", quantidadeitem = 0, quantidadecolete = 100, quantidadevida = 400 },    
    [34] = { carro = false, dinheiro = false, item = false, colete = true, vida = true, nomecarro = "", quantidadedinheiro = 0, nomeitem = "0", quantidadeitem = 0, quantidadecolete = 100, quantidadevida = 400 },
    [35] = { carro = false, dinheiro = false, item = true, colete = true, vida = true, nomecarro = "", quantidadedinheiro = 0, nomeitem = {"wbody|WEAPON_SNSPISTOL","wammo|WEAPON_SNSPISTOL"}, quantidadeitem = {1,250}, quantidadecolete = 100, quantidadevida = 400 },   
    [36] = { carro = false, dinheiro = false, item = true, colete = true, vida = true, nomecarro = "", quantidadedinheiro = 0, nomeitem = {"tora","wbody|WEAPON_HATCHET"}, quantidadeitem = {150,1}, quantidadecolete = 100, quantidadevida = 400 },
    [37] = { carro = false, dinheiro = false, item = true, colete = true, vida = true, nomecarro = "", quantidadedinheiro = 0, nomeitem = {"colarroubado","relogioroubado","pulseiraroubada","anelroubado", "brincoroubado","carteiraroubada","carregadorroubado","tabletroubado"}, quantidadeitem = {20,20,20,20,20,20,20,20}, quantidadecolete = 100, quantidadevida = 400 },
    [38] = { carro = true, dinheiro = false, item = false, colete = true, vida = true, nomecarro = "faggio2", quantidadedinheiro = 0, nomeitem = "", quantidadeitem = 0, quantidadecolete = 100, quantidadevida = 400 },
    [39] = { carro = false, dinheiro = false, item = false, colete = true, vida = true, nomecarro = "", quantidadedinheiro = 0, nomeitem = "", quantidadeitem = 0, quantidadecolete = 100, quantidadevida = 400 },    
    [40] = { carro = true, dinheiro = false, item = false, colete = true, vida = true, nomecarro = "hexer", quantidadedinheiro = 0, nomeitem = "", quantidadeitem = 0, quantidadecolete = 100, quantidadevida = 400 },   
    [41] = { carro = false, dinheiro = false, item = false, colete = true, vida = true, nomecarro = "", quantidadedinheiro = 0, nomeitem = "", quantidadeitem = 0, quantidadecolete = 100, quantidadevida = 400 },    
    [42] = { carro = false, dinheiro = false, item = true, colete = true, vida = true, nomecarro = "", quantidadedinheiro = 0, nomeitem = "garrafadeleite", quantidadeitem = 120, quantidadecolete = 100, quantidadevida = 400 },   
    [43] = { carro = false, dinheiro = false, item = false, colete = true, vida = true, nomecarro = "", quantidadedinheiro = 0, nomeitem = "", quantidadeitem = 0, quantidadecolete = 100, quantidadevida = 400 },    
    [44] = { carro = false, dinheiro = true, item = false, colete = true, vida = true, nomecarro = "", quantidadedinheiro = 0, nomeitem = "wbody|WEAPON_SNSPISTOL", quantidadeitem = 1, quantidadecolete = 100, quantidadevida = 400 },    
    [45] = { carro = false, dinheiro = false, item = true, colete = true, vida = true, nomecarro = "", quantidadedinheiro = 0, nomeitem = "dinheirosujo", quantidadeitem = 35000, quantidadecolete = 100, quantidadevida = 400 },
    [46] = { carro = false, dinheiro = false, item = false, colete = true, vida = true, nomecarro = "", quantidadedinheiro = 0, nomeitem = "", quantidadeitem = 0, quantidadecolete = 100, quantidadevida = 400 },    
    [47] = { carro = false, dinheiro = false, item = true, colete = true, vida = true, nomecarro = "", quantidadedinheiro = 0, nomeitem = "wbody|WEAPON_DAGGER", quantidadeitem = 0, quantidadecolete = 100, quantidadevida = 400 },    
    [48] = { carro = false, dinheiro = false, item = false, colete = true, vida = true, nomecarro = "", quantidadedinheiro = 0, nomeitem = "", quantidadeitem = 0, quantidadecolete = 100, quantidadevida = 400 },   
    [49] = { carro = false, dinheiro = false, item = true, colete = true, vida = true, nomecarro = "", quantidadedinheiro = 0, nomeitem = "dinheirosujo", quantidadeitem = 17000, quantidadecolete = 100, quantidadevida = 400 },    
    [50] = { carro = true, dinheiro = false, item = true, colete = true, vida = true, nomecarro = "dubsta2", quantidadedinheiro = 0, nomeitem = "dinheirosujo", quantidadeitem = 30000, quantidadecolete = 100, quantidadevida = 400 },
    [51] = { carro = false, dinheiro = false, item = false, colete = true, vida = true, nomecarro = "", quantidadedinheiro = 0, nomeitem = "", quantidadeitem = 0, quantidadecolete = 100, quantidadevida = 400 },    
    [52] = { carro = false, dinheiro = false, item = true, colete = true, vida = true, nomecarro = "", quantidadedinheiro = 0, nomeitem = {"colete","conhaque","dipiroca","energetico"}, quantidadeitem = {2,10,10,5}, quantidadecolete = 100, quantidadevida = 400 },
    [53] = { carro = false, dinheiro = false, item = false, colete = true, vida = true, nomecarro = "", quantidadedinheiro = 0, nomeitem = "", quantidadeitem = 0, quantidadecolete = 100, quantidadevida = 400 },   
    [54] = { carro = false, dinheiro = false, item = true, colete = true, vida = true, nomecarro = "", quantidadedinheiro = 0, nomeitem = "sacodelixo", quantidadeitem = 150, quantidadecolete = 100, quantidadevida = 400 },    
    [55] = { carro = false, dinheiro = false, item = true, colete = true, vida = true, nomecarro = "", quantidadedinheiro = 0, nomeitem = {"diamante","mrubi"}, quantidadeitem = {1,50}, quantidadecolete = 100, quantidadevida = 400 },
    [56] = { carro = false, dinheiro = false, item = false, colete = true, vida = true, nomecarro = "", quantidadedinheiro = 0, nomeitem = "", quantidadeitem = 0, quantidadecolete = 100, quantidadevida = 400 },   
    [57] = { carro = false, dinheiro = false, item = true, colete = true, vida = true, nomecarro = "", quantidadedinheiro = 0, nomeitem = {"wbody|WEAPON_MICROSMG","wammo|WEAPON_MICROSMG"}, quantidadeitem = {1,50}, quantidadecolete = 100, quantidadevida = 400 },
    [58] = { carro = false, dinheiro = false, item = false, colete = true, vida = true, nomecarro = "", quantidadedinheiro = 0, nomeitem = "", quantidadeitem = 0, quantidadecolete = 100, quantidadevida = 400 },    
    [59] = { carro = false, dinheiro = true, item = false, colete = true, vida = true, nomecarro = "", quantidadedinheiro = 20000, nomeitem = "", quantidadeitem = 0, quantidadecolete = 100, quantidadevida = 400 },    
    [60] = { carro = true, dinheiro = false, item = false, colete = true, vida = true, nomecarro = "elegy2", quantidadedinheiro = 0, nomeitem = "", quantidadeitem = 0, quantidadecolete = 100, quantidadevida = 400 },
    [61] = { carro = false, dinheiro = false, item = false, colete = true, vida = true, nomecarro = "", quantidadedinheiro = 0, nomeitem = "", quantidadeitem = 0, quantidadecolete = 100, quantidadevida = 400 },    
    [62] = { carro = false, dinheiro = false, item = true, colete = true, vida = true, nomecarro = "", quantidadedinheiro = 0, nomeitem = "repairkit", quantidadeitem = 1, quantidadecolete = 100, quantidadevida = 400 },
    [63] = { carro = false, dinheiro = false, item = false, colete = true, vida = true, nomecarro = "", quantidadedinheiro = 0, nomeitem = "", quantidadeitem = 0, quantidadecolete = 100, quantidadevida = 400 },   
    [64] = { carro = false, dinheiro = false, item = true, colete = true, vida = true, nomecarro = "", quantidadedinheiro = 0, nomeitem = "dinheirosujo", quantidadeitem = 30000, quantidadecolete = 100, quantidadevida = 400 },    
    [65] = { carro = false, dinheiro = true, item = false, colete = true, vida = true, nomecarro = "", quantidadedinheiro = 80000, nomeitem = "", quantidadeitem = 0, quantidadecolete = 100, quantidadevida = 400 },
    [66] = { carro = false, dinheiro = false, item = false, colete = true, vida = true, nomecarro = "", quantidadedinheiro = 0, nomeitem = "", quantidadeitem = 0, quantidadecolete = 100, quantidadevida = 400 },    
    [67] = { carro = false, dinheiro = false, item = true, colete = true, vida = true, nomecarro = "", quantidadedinheiro = 0, nomeitem = {"dourado","salmao","pacu"}, quantidadeitem = {30,40,20}, quantidadecolete = 100, quantidadevida = 400 },    
    [68] = { carro = false, dinheiro = false, item = false, colete = true, vida = true, nomecarro = "", quantidadedinheiro = 0, nomeitem = "", quantidadeitem = 0, quantidadecolete = 100, quantidadevida = 400 },    
    [69] = { carro = false, dinheiro = false, item = true, colete = true, vida = true, nomecarro = "", quantidadedinheiro = 0, nomeitem = {"wbody|WEAPON_REVOLVER","ammo|WEAPON_REVOLVER"}, quantidadeitem = {1,20}, quantidadecolete = 100, quantidadevida = 400 },
    [70] = { carro = true, dinheiro = true, item = false, colete = true, vida = true, nomecarro = "vader", quantidadedinheiro = 50000, nomeitem = "", quantidadeitem = 0, quantidadecolete = 100, quantidadevida = 400 },
    [71] = { carro = false, dinheiro = false, item = false, colete = true, vida = true, nomecarro = "", quantidadedinheiro = 0, nomeitem = "", quantidadeitem = 0, quantidadecolete = 100, quantidadevida = 400 },    
    [72] = { carro = false, dinheiro = false, item = true, colete = true, vida = true, nomecarro = "", quantidadedinheiro = 0, nomeitem = "garrafadeleite", quantidadeitem = 200, quantidadecolete = 100, quantidadevida = 400 },
    [73] = { carro = true, dinheiro = false, item = false, colete = true, vida = true, nomecarro = "fixter", quantidadedinheiro = 0, nomeitem = "wbody|WEAPON_PUMPSHOTGUN_MK2", quantidadeitem = 1, quantidadecolete = 100, quantidadevida = 400 },   
    [74] = { carro = true, dinheiro = false, item = true, colete = true, vida = true, nomecarro = "fixter", quantidadedinheiro = 0, nomeitem = {"wbody|WEAPON_PUMPSHOTGUN_MK2","wammo|WEAPON_PUMPSHOTGUN_MK2"}, quantidadeitem = {1,30}, quantidadecolete = 100, quantidadevida = 400 },
    [75] = { carro = false, dinheiro = false, item = true, colete = true, vida = true, nomecarro = "", quantidadedinheiro = 0, nomeitem = "wbody|WEAPON_ASSAULTSMG", quantidadeitem = 1, quantidadecolete = 100, quantidadevida = 400 },
    [76] = { carro = false, dinheiro = false, item = true, colete = false, vida = false, nomecarro = "", quantidadedinheiro = 0, nomeitem = "wbody|WEAPON_ASSAULTRIFLE", quantidadeitem = 1, quantidadecolete = 100, quantidadevida = 400 },
    [77] = { carro = true, dinheiro = false, item = false, colete = true, vida = true, nomecarro = "zombieb", quantidadedinheiro = 0, nomeitem = "", quantidadeitem = 0, quantidadecolete = 100, quantidadevida = 400 },
    [78] = { carro = false, dinheiro = false, item = false, colete = true, vida = true, nomecarro = "", quantidadedinheiro = 0, nomeitem = "", quantidadeitem = 0, quantidadecolete = 100, quantidadevida = 400 },    
    [79] = { carro = false, dinheiro = true, item = true, colete = true, vida = true, nomecarro = "", quantidadedinheiro = 15000, nomeitem = "energetico", quantidadeitem = 3, quantidadecolete = 100, quantidadevida = 400 },   
    [80] = { carro = false, dinheiro = true, item = false, colete = true, vida = true, nomecarro = "", quantidadedinheiro = 450000, nomeitem = "", quantidadeitem = 0, quantidadecolete = 100, quantidadevida = 400 },
    [81] = { carro = false, dinheiro = false, item = false, colete = true, vida = true, nomecarro = "", quantidadedinheiro = 0, nomeitem = "", quantidadeitem = 0, quantidadecolete = 100, quantidadevida = 400 },    
    [82] = { carro = false, dinheiro = false, item = true, colete = true, vida = true, nomecarro = "", quantidadedinheiro = 0, nomeitem = {"algemas","capuz"}, quantidadeitem = {3,2}, quantidadecolete = 100, quantidadevida = 400 },
    [83] = { carro = false, dinheiro = false, item = false, colete = true, vida = true, nomecarro = "", quantidadedinheiro = 0, nomeitem = "", quantidadeitem = 0, quantidadecolete = 100, quantidadevida = 400 },   
    [84] = { carro = false, dinheiro = false, item = true, colete = true, vida = true, nomecarro = "", quantidadedinheiro = 0, nomeitem = "wbody|WEAPON_STUNGUN", quantidadeitem = 1, quantidadecolete = 100, quantidadevida = 400 },    
    [85] = { carro = false, dinheiro = false, item = true, colete = true, vida = true, nomecarro = "", quantidadedinheiro = 0, nomeitem = "dinheirosujo", quantidadeitem = 70000, quantidadecolete = 100, quantidadevida = 400 },
    [86] = { carro = false, dinheiro = false, item = false, colete = true, vida = true, nomecarro = "", quantidadedinheiro = 0, nomeitem = "", quantidadeitem = 0, quantidadecolete = 100, quantidadevida = 400 },    
    [87] = { carro = false, dinheiro = false, item = true, colete = true, vida = true, nomecarro = "", quantidadedinheiro = 0, nomeitem = {"sacodelixo","tora","garrafadeleite"}, quantidadeitem = {100,100,100}, quantidadecolete = 100, quantidadevida = 400 },    
    [88] = { carro = false, dinheiro = false, item = false, colete = true, vida = true, nomecarro = "", quantidadedinheiro = 0, nomeitem = "", quantidadeitem = 0, quantidadecolete = 100, quantidadevida = 400 },   
    [89] = { carro = true, dinheiro = false, item = false, colete = true, vida = true, nomecarro = "blista2", quantidadedinheiro = 0, nomeitem = "", quantidadeitem = 0, quantidadecolete = 100, quantidadevida = 400 },    
    [90] = { carro = true, dinheiro = false, item = false, colete = true, vida = true, nomecarro = "feltzer3", quantidadedinheiro = 0, nomeitem = "", quantidadeitem = 0, quantidadecolete = 100, quantidadevida = 400 },   
    [91] = { carro = false, dinheiro = false, item = true, colete = true, vida = true, nomecarro = "", quantidadedinheiro = 0, nomeitem = {"repairkit","capuz","wbody|WEAPON_REVOLVER","wammo|WEAPON_REVOLVER"}, quantidadeitem = {1,1,1,50}, quantidadecolete = 100, quantidadevida = 400 },
    [92] = { carro = true, dinheiro = false, item = true, colete = true, vida = true, nomecarro = "manana", quantidadedinheiro = 0, nomeitem = "dinheirosujo", quantidadeitem = 30000, quantidadecolete = 100, quantidadevida = 400 },   
    [93] = { carro = true, dinheiro = false, item = false, colete = true, vida = true, nomecarro = "bati2", quantidadedinheiro = 0, nomeitem = "", quantidadeitem = 0, quantidadecolete = 100, quantidadevida = 400 },    
    [94] = { carro = true, dinheiro = false, item = true, colete = true, vida = true, nomecarro = "sanchez", quantidadedinheiro = 0, nomeitem = {"wbody|WEAPON_ASSAULTRIFLE","wammo|WEAPON_ASSAULTRIFLE"}, quantidadeitem = {1,100}, quantidadecolete = 100, quantidadevida = 400 },
    [95] = { carro = false, dinheiro = true, item = true, colete = true, vida = true, nomecarro = "", quantidadedinheiro = 400000, nomeitem = "dinheirosujo", quantidadeitem = 200000, quantidadecolete = 100, quantidadevida = 400 },  
    [96] = { carro = false, dinheiro = false, item = true, colete = true, vida = true, nomecarro = "", quantidadedinheiro = 0, nomeitem = {"colarroubado","relogioroubado","pulseiraroubada","anelroubado","brincoroubado","carteiraroubada","carregadorroubado","tabletroubado"}, quantidadeitem = {50,50,50,50,50,50,50,50}, quantidadecolete = 100, quantidadevida = 400 },
    [97] = { carro = true, dinheiro = false, item = false, colete = true, vida = true, nomecarro = "flashgt", quantidadedinheiro = 0, nomeitem = "", quantidadeitem = 0, quantidadecolete = 100, quantidadevida = 400 },   
    [98] = { carro = false, dinheiro = false, item = true, colete = true, vida = true, nomecarro = "", quantidadedinheiro = 0, nomeitem = {"repairkit","lockpick","masterpick","wbody|WEAPON_STUNGUN","colete"}, quantidadeitem = {1,1,1,1,2}, quantidadecolete = 100, quantidadevida = 400 },
    [99] = { carro = false, dinheiro = false, item = true, colete = true, vida = true, nomecarro = "", quantidadedinheiro = 0, nomeitem = "diamante", quantidadeitem = 4, quantidadecolete = 100, quantidadevida = 400 },    
    [100] = { carro = true, dinheiro = false, item = false, colete = true, vida = true, nomecarro = {"swift2","i8"}, quantidadedinheiro = 0, nomeitem = "", quantidadeitem = 0, quantidadecolete = 100, quantidadevida = 400 },
}

Config.recompensasvip = { -- RECOMPENSA DE CADA NIVEL DO PASSE PARA VIP
    [1] = { carro = false, dinheiro = false, item = false, colete = false, vida = false, nomecarro = "", quantidadedinheiro = 0, nomeitem = "", quantidadeitem = 0, quantidadecolete = 100, quantidadevida = 400 },
    [2] = { carro = false, dinheiro = true, item = false, colete = false, vida = false, nomecarro = "", quantidadedinheiro = 2000, nomeitem = "", quantidadeitem = 0, quantidadecolete = 100, quantidadevida = 400 },
    [3] = { carro = false, dinheiro = false, item = true, colete = false, vida = true, nomecarro = "", quantidadedinheiro = 0, nomeitem = "mochila", quantidadeitem = 1, quantidadecolete = 100, quantidadevida = 400 },
    [4] = { carro = false, dinheiro = true, item = false, colete = false, vida = true, nomecarro = "", quantidadedinheiro = 2000, nomeitem = "", quantidadeitem = 0, quantidadecolete = 100, quantidadevida = 400 },
    [5] = { carro = false, dinheiro = true, item = true, colete = true, vida = false, nomecarro = "", quantidadedinheiro = 1000, nomeitem = "roupas", quantidadeitem = 1, quantidadecolete = 100, quantidadevida = 400 },
    [6] = { carro = false, dinheiro = false, item = false, colete = true, vida = true, nomecarro = "", quantidadedinheiro = 0, nomeitem = "", quantidadeitem = 0, quantidadecolete = 100, quantidadevida = 400 },      
    [7] = { carro = false, dinheiro = true, item = true, colete = false, vida = false, nomecarro = "", quantidadedinheiro = 1000, nomeitem = "lockpick", quantidadeitem = 1, quantidadecolete = 100, quantidadevida = 400 },    
    [8] = { carro = false, dinheiro = true, item = false, colete = true, vida = true, nomecarro = "", quantidadedinheiro = 1000, nomeitem = "", quantidadeitem = 0, quantidadecolete = 100, quantidadevida = 400 },    
    [9] = { carro = false, dinheiro = false, item = true, colete = false, vida = false, nomecarro = "", quantidadedinheiro = 0, nomeitem = "garrafadeleite", quantidadeitem = 50, quantidadecolete = 100, quantidadevida = 400 },    
    [10] = { carro = true, dinheiro = false, item = false, colete = false, vida = false, nomecarro = "faggio", quantidadedinheiro = 0, nomeitem = "", quantidadeitem = 0, quantidadecolete = 100, quantidadevida = 400 },
}