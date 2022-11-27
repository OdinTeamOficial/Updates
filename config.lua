Config	= {}

Config.Locale = 'pt'  																		-- LINGUAGEM DO SCRIPT

Config.framework = "VRPEX" 																	-- FRAMEWORK A SER UTILIZADA (VRPEX OU CREATIVE)

Config.substituirIMG = true 																-- SUBSTITUIR IMAGEM DA ROLETA

Config.firework = true																		-- SOLTAR PARTICULAS DE FOGOS
Config.offsetFirework = vec3(0.0,0.0,1.0)													-- OFFSET DOS FOGOS DE ARTIFICIO A PARTIR DA ROLETA
Config.FireworkAsset = {"proj_indep_firework_v2","scr_firework_indep_spiral_burst_rwb"}		-- ASSETS DA PARTICULA https://vespura.com/fivem/particle-list/

Config.OnlyVip = false																		-- ROLETAR SOMENTE QUEM TIVER A PERMISSÃO
Config.VipPerm = "vip.permissao"															-- PERMISSÃO CASO A OPÇÃO DE CIMA ESTEJA ATIVADA


Config.Lightson = true																		-- LIGAR AS LUZES DO CARRO EM EXPOSIÇÃO
Config.NeonOn = true																		-- LIGAR O NEON DO CARRO EM EXPOSIÇÃO
Config.NeonColor = {0,0,255}																-- COR DO NEON DO CARRO EM EXPOSIÇÃO CASO A OPÇÃO ACIMA ESTEJA ATIVADA (RGB)
Config.Placa = "ODINTEAM"

Config.Wheels = {																			-- ROLETAS A SEREM SPAWNADAS
	[1] = { 
		spawn = vec4(187.84562683105,-943.34405517578,30.091932296753,324.74), 				-- LOCALIZAÇÃO + ROTAÇÃO (X,Y,Z,H)
		expo = true,																		-- SE SERÁ CRIADO UMA EXPOSIÇÃO DO CARRO DO DIA
		rot = true, 																		-- SE O CARRO E A EXPOSIÇÃO IRÃO GIRAR
		spawn_expo = vec4(197.63636779785,-934.82434082031,30.686792373657,324.74),			-- LOCAL DE SPAWN DA EXPOSIÇÃO
		spawn_vehicle = vec4(197.63636779785,-934.82434082031,30.686792373657,324.74)		-- LOCAL DE SPAWN DO CARRO (PODE SER A MESMA DE CIMA OU DIFERENTE PARA AJUSTES)
	},

	[2] = { 
		spawn = vec4(185.51324462891,-928.06256103516,30.686811447144,229.96), 
		expo = true,
		rot = false, 
		spawn_expo = vec4(171.77891540527,-918.71759033203,30.691997528076,150.29),
		spawn_vehicle = vec4(171.77891540527,-918.71759033203,30.691997528076,150.29)
	}
}





Config.debug = true																			-- DEIXAR DESATIVADO (PERMITE ROLETAR SEM NECESSIDADE DO TEMPO)
Config.Tempo_reset = {h = 0, m = 10, s = 0}													-- TEMPO EM QUE IRÁ DEMORAR PARA CONSEGUIR ROLETAR NOVAMENTE (MAXIMO DE 24 HORAS!)
			

Config.Cars = {																				-- POSSIVEIS CARROS A FICAR EM EXPOSIÇÃO (SERÁ ALEATÓRIO)
	[1]  = 'panto',
	[2]  = 'neon',
	[3]  = 'zentorno',
}

--TIPOS DE PREMIOS: (carro,item,colete,nada,dinheiro,vida,mistery)
--TIPOS DE ITEMS: Caso o type for "carro", deixar items = false; Caso o type for "item", deixar items com o nome do item a ser dado; Caso o type for "nada" ou "colete" ou "vida" deixar items = ""; caso type = dinheiro e utilizar o dinheiro como um item em sua base, deixar items com n ome do item de dinheiro, caso contrario, deixar false;
--TIPOS DE QUANTIDADE: A quantidade pode ser um valor fixo, ou um valor á ser sorteado, basta colocar {} e colocar o valor minimo e maximo á ser sorteado, EXP: {1,5}, irá sortear um valor entre 1 e 5, pode ser utilizado para qualquer tipo de prêmio
--TIPOS DE SOUND: (car,cash,chips,clotches,mistery); é o som a ser feito ao ganhar um prêmio
--TIPOS DE CHANCE: O script irá sortear um numero de 1 á 1000; caso a chance esteja entre o valor minimo (a) e o valor maximo (b), então o item é escolhido; 
--https://www.4devs.com.br/calculadora_porcentagem

Config.premios = {
	[1]  = {type = 'carro', 	items = false, 						quantidade = {1}, 			sound = 'car', 		chance = {a = 0, b = 1}			},	-- 0.1% de chance
	[2]  = {type = 'item', 		items = "dinheirosujo", 			quantidade = {1000,5000},	sound = 'cash', 	chance = {a = 1, b = 20}		},	-- 2% de chance
	[3]  = {type = 'colete', 	items = "", 						quantidade = 100, 			sound = 'clothes', 	chance = {a = 20, b = 80}		}, 	-- 6% de chance
	[4]  = {type = 'nada', 		items = "",							quantidade = 1, 			sound = 'chips', 	chance = {a = 80, b = 110}		},
	[5]  = {type = 'dinheiro', 	items = false, 						quantidade = 40000, 		sound = 'cash', 	chance = {a = 110, b = 150}		},
	[6]  = {type = 'item', 		items = "mochila", 					quantidade = 1, 			sound = 'cash', 		chance = {a = 150, b = 200}	},	
	[7]  = {type = 'colete', 	items = "",							quantidade = 100, 			sound = 'clothes', 	chance = {a = 200, b = 300}		},	
	[8]  = {
		type = 'mistery', 	
		sound = 'mystery', 	
		chance = {a = 300, b = 350},
		items = { -- CASO CAIA MISTERY, O SCRIPT IRÁ SORTEAR UM ITEM ALEATORIO DA LISTA ABAIXO, A QUANTIDADE PODE VARIAS PARA QUALQUER TIPO, BASTA SEGUIR O EXPEMPLO ABAIXO PARA CADA TIPO DE ITEM
			[1] = {
				nome = "panto",
				carro = true,
				quantidade = 1
			}, 
			[2] = {
				nome = "vida",
				quantidade = {200,400}
			}, 
			[3] = {
				nome = "colete",
				quantidade = {1,100}
			}, 
			[4] = { 
				nome = "mochila",
				item = true, 
				quantidade = {1,100}
			},
			[5] = { 
				nome = "dinheiro",
				dinheiroitem = false, 
				quantidade = {1,100}
			} 
		}
	},
	
	[9]  = {type = 'nada', 		items = "",										quantidade = 1, 		sound = 'chips', 	chance = {a = 350, b = 400}},
	[10] = {type = 'item', 		items = "lockpick", 							quantidade = 1, 		sound = 'cash', 	chance = {a = 400, b = 500}},
	[11] = {type = 'colete',	items = "",										quantidade = 1, 		sound = 'clothes', 	chance = {a = 500, b = 600}},	
	[12] = {type = 'nada', 		items = "",										quantidade = 1, 		sound = 'chips', 	chance = {a = 600, b = 650}},	
	[13] = {type = 'dinheiro', 	items = false, 									quantidade = 30000, 	sound = 'cash', 	chance = {a = 650, b = 700}},	
	[14] = {type = 'item', 		items = "masterpick", 							quantidade = 1, 		sound = 'cash', 	chance = {a = 700, b = 750}},	
	[15] = {type = 'vida', 		items = "",  									quantidade = 400, 		sound = 'mystery', 	chance = {a = 750, b = 800}},
	[16] = {type = 'nada',		items = {"lockpick","mochila","masterpick"},	quantidade = 1, 		sound = 'chips', 	chance = {a = 800, b = 820}},	
	[17] = {type = 'dinheiro',	items = false, 									quantidade = 20000, 	sound = 'cash', 	chance = {a = 820, b = 850}},	
	[18] = {type = 'item', 		items = "mochila", 								quantidade = 1, 		sound = 'cash', 	chance = {a = 850, b = 900}},	
	[19] = {type = 'colete', 	items = "",										quantidade = 100, 		sound = 'clothes', 	chance = {a = 900, b = 950}},	
	[20] = {type = 'dinheiro', 	items = false, 									quantidade = 50000, 	sound = 'cash', 	chance = {a = 950, b = 1000}},	
}