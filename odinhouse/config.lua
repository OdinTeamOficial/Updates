Config = {
  Linguagem      = 'pt',                                  -- Linguagem a ser utilizada 
  Debug       = false,                                    -- Não mexer
  Max_Homes = 2,                                          -- Limite de casas por players
  Command_create = "vali1234",                            -- Comando para criar casas
  Command_delete = "delhouse",                            -- Comando para deletar casas
  PermitirVendaDeCasas = true,                            -- Permitir players vender casa
  SpawnOffset     = vector3(0.0,0.0,0.0),                 -- Offset de spawn 
  WaitToRender      = true,                               -- Esperar renderizar interior 
  WaitToRenderTime  = 2000,                               -- Tempo de espera para renderizar
  SaveVehicleBody = true,                                 -- Salvar dano da carcaça do veiculo
  SaveVehicleFuel = true,                                 -- Salvar combustivel do veiculo
  SaveVehicleEngine = true,                               -- Savar dano do motor do veiculo 
  UsarVSync        = true,                                -- Usando vsync
  UsingNativeUI     = true,                               -- Não mexer
  UsarInventarioNasCasas = true,                          -- Permitir inventario nas casas
  UsarHelpText       = true,                              -- Usar heelp text
  Usar3DText         = true,                              -- Usar 3d text
  UsarMarkers        = true,                              -- Usar markers
  UsarBlips          = true,                              -- Usar blips
  MarkerDistance    = 10.0,                               -- Distancia do marker
  TextDistance3D    = 10.0,                               -- Distancia 3d text 
  HelpTextDistance  = 2.0,                                -- Distancia heelp text
  InteractDistance  = 2.0,                                -- Distancia da interação
  MovimentoDaGaragem = true,                              -- Permitir player mover garagem
  UsarSpritePorZona    = true,                            -- Mudar blip por zona
  UsarCorPorZona   = true,                                -- Mudar cor por zona
  CorBlipCasaVazia      = 1,                              -- Cor do blip de casas vazias
  CorBlipDonoCasa      = 2,                               -- Cor do blip do dono da casa
  CorBlipCasaComprada      = 3,                           -- Cor do blip de outras casas
  CorBlipZona      = {                                    -- Cor blip por zona
    [9] = {                                               -- Entre [] fica o id da casa a ter configuração diferente
      CorCasaVaziaZona  = 1,                              --Cor do blip da casa
      CorDonoZoa  = 2,                                    -- Cor do blip dono da casa
      CorCasaCompradaZona  = 3,                           -- Cor do blip de outras casas
    }, 
  },
  BlipCasaVazia   = 350,                                  -- Tipo de blip casa vazia
  BlipDonoCasa   = 40,                                    -- Tipo de blip dono da casa
  BlipCasaComprada   = 357,                               -- Tipo de blip de outras casas
  BlipPorZona   = {                                       -- Blip por zona
    [9] = {                                               -- Entre [] fica o id da casa a ter configuração diferente
      BlipCasaVaziaZona  = 350,                           -- Tipo de blip casa vazia
      BlipDonoZona  = 40,                                 -- Tipo de blip dono da casa 
      BlipCasaCompradaZona  = 357,                        -- Tipo de blip outras casas 
    }, 
  },
  TipoMarker = 1,                                        -- Tipo de marker geral
  CorMarkers = {                                         -- Cor marker diferentes
    [1] = {r = 0, g = 255, b = 0, a = 155},              -- Entre [] fica o id da casa a ter configuração diferente e então, muda-se a cor a partir do código RGBA
    [2] = {r = 255, g = 0, b = 0, a = 155},
    [3] = {r = 0, g = 0, b = 0, a = 155},
    [4] = {r = 0, g = 0, b = 255, a = 155},
    [5] = {r = 255, g = 255, b = 0, a = 155},
    [6] = {r = 0, g = 255, b = 255, a = 155},
    [7] = {r = 255, g = 255, b = 255, a = 155},
  },
  CorTextos = {                                          -- Não Mexer
    [1] = "~g~",
    [2] = "~r~",
    [3] = "~b~",
    [4] = "~o~",
    [5] = "~p~",
    [6] = "~y~",
    [7] = "~w~",
  },
  Controles = {                                          -- Id controles para cada interação 
    Interagir  = 38,  
    Aceitar    = 58, 
    Cancelar    = 49,
    Furni     = 49,
  },
  EsconderBlipsCasaComprada    = false,                  -- Esconder blip de casas compradas 
  EsconderBlipsCasaOutros   = false,                     -- Esconder blip de casa de outros players 
  EsconderBlipsCasaVazia  = false,                       -- Esconder blip de casas vazias
  RemoverMoveis  = true,                                 -- Remover moveis na venda
  DevolverDinMoveis  = true,                             -- Devonver dinheiro do movel ao vender 
  PorcentagemDevolucao    = 50,                          -- Porcentagem de devolução do dinheiro dos moveis 
  RouboDeCasas                = true,                    -- Permitir roubo de casas 
  RoubodeGaragem               = true,                   -- Permitir roubo de garagens 
  GuardarVeiculosOutrosPlayers = true,                   -- Permitir guardar veiculo de outros players
  PrecisaDeLockpick          = true,                     -- Usar lockpick
  LockpickItem              = "lockpick",                -- Item lockpick
  QuebrarLockpickFalha       = true,                     -- Quebrar lockpick ao falhar
  ChanceDeFalhar        = 50,                            -- Chance de falhar
  TempoLockpick              = 3,                        -- Tempo para roubar 
  PermiAdmin = "admin.permissao",                        -- Permissão de admin
  PermiPolicia = "policia.permissao",                    -- Permissão de policias
  PoliciaisPodemEntrar     = true,                       -- Permitir policiais entrar em casas 
  PoliciaAcessarInv  = true,                             -- Permitir policiais acessar inventario
}

mLibs = exports["meta_libs"]                             -- Não mexer 