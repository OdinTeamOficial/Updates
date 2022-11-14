Config = {
  Linguagem      = 'pt',
  Debug       = false,

  Max_Homes = 2,
  Command_create = "vali1234",
  Command_delete = "delhouse",

  PermitirVendaDeCasas = true,              -- os jogadores podem vender sua casa após a compra?
  SpawnOffset     = vector3(0.0,0.0,0.0),   -- deslocamento global de desova da casa (local + SpawnOffset) (use valor z negativo para diminuir a posição dos projéteis)
                                            -- note: if you already have houses spawned, I wouldn't go changing this. Will result in furniture dissappearing.

  WaitToRender      = true, -- might help reduce MS when you have lots of houses
  WaitToRenderTime  = 2000, -- time to sleep between distance checks (if WaitToRender is true)
  SaveVehicleBody = true,
  SaveVehicleFuel = true,
  SaveVehicleEngine = true,

  -- FRAMEWORK
  
  UsarVSync        = true,   -- Really only applies if you're using the modified vSync provided, else set false.


 
  UsingNativeUI     = true,
  UsarInventarioNasCasas = true, -- if using the inventory inside of houses.




  -- BLIPS/MARKERS/3DTEXT
  UsarHelpText       = true,  -- se estiver usando HelpText (em vez de 3DText).
  Usar3DText         = true,   -- se estiver usando 3DText (em vez de HelpText).
  UsarMarkers        = true,  -- se você quiser marcadores.
  UsarBlips          = true,   -- se você quiser blips.

  -- TORNAR DISTÂNCIA
  MarkerDistance    = 10.0,
  TextDistance3D    = 10.0,
  HelpTextDistance  = 2.0,
  InteractDistance  = 2.0,  

  -- Permitir que os donos da casa movam sua garagem?
  MovimentoDaGaragem = true,


  


  -- BLIP COLORS/SPRITES
  UsarSpritePorZona    = true,  -- if you want to set the blip sprite by zone.
  UsarCorPorZona   = true,  -- if you want to set the blip color by zone.

  CorBlipCasaVazia      = 1,     -- must be set regardless of option above.
  CorBlipDonoCasa      = 2,     -- must be set regardless of option above.
  CorBlipCasaComprada      = 3,     -- must be set regardless of option above.
  CorBlipZona      = {      -- set house blip colors based on zone. Optional.
    [9] = {
      CorCasaVaziaZona  = 1,
      CorDonoZoa  = 2,
      CorCasaCompradaZona  = 3,
    }, 
    [205] = {      
      CorCasaVaziaZona  = 1,
      CorDonoZoa  = 2,
      CorCasaCompradaZona  = 3,
    }
  },

  BlipCasaVazia   = 350,    -- must be set regardless of option above.
  BlipDonoCasa   = 40,     -- must be set regardless of option above.
  BlipCasaComprada   = 357,    -- must be set regardless of option above.
  BlipPorZona   = {       -- set house blip colors sprites on zone. Optional.
    [9] = {
      BlipCasaVaziaZona  = 350,
      BlipDonoZona  = 40,
      BlipCasaCompradaZona  = 357,
    }, 
    [205] = {      
      BlipCasaVaziaZona  = 350,
      BlipDonoZona  = 40,
      BlipCasaCompradaZona  = 357,
    }
  },

  -- Marker colors and text color.
  TipoMarker = 1,
  CorMarkers = {
    [1] = {r = 0, g = 255, b = 0, a = 155},
    [2] = {r = 255, g = 0, b = 0, a = 155},
    [3] = {r = 0, g = 0, b = 0, a = 155},
    [4] = {r = 0, g = 0, b = 255, a = 155},
    [5] = {r = 255, g = 255, b = 0, a = 155},
    [6] = {r = 0, g = 255, b = 255, a = 155},
    [7] = {r = 255, g = 255, b = 255, a = 155},
  },
  CorTextos = {
    [1] = "~g~",
    [2] = "~r~",
    [3] = "~b~",
    [4] = "~o~",
    [5] = "~p~",
    [6] = "~y~",
    [7] = "~w~",
  },

  Controles = {
    Interagir  = 38, -- Access most things.
    Aceitar    = 58, -- Accept/validate decision.
    Cancelar    = 49, -- Cancel/discard deicsion.
    Furni     = 49, -- Furni UI.
  },

  espacobau = 1000,
  EsconderBlipsCasaComprada    = false,    -- hide blips for players owned houses?
  EsconderBlipsCasaOutros   = false,    -- hide blips for other player houses?
  EsconderBlipsCasaVazia  = false,    -- hide blips for empty houses/for sale houses?

  -- OWNER STUFF  
  RemoverMoveis  = true,  -- Remove all furniture on sale.
  DevolverDinMoveis  = true,  -- Only if RemoverMoveis enabled.
  PorcentagemDevolucao    = 50,    -- percent of price to refund for furniture.

  -- THEFT STUFF
  RouboDeCasas                = true,         -- can the player break into the house?
  RoubodeGaragem               = true,         -- can the player break into garage?
  GuardarVeiculosOutrosPlayers = true,        -- can players store other player vehicles at their house?
  PrecisaDeLockpick          = true,         -- does the player require a lockpick item to attempt to break in (garage AND house)?
  LockpickItem              = "lockpick",   -- lockpick item name.
  QuebrarLockpickFalha       = true,         -- does the lockpick break if the minigame is failed?
  ChanceDeFalhar        = 50,            -- % failure chance, if not using minigames for lockpicking.
  TempoLockpick              = 3,            -- seconds to lockpick, if not using minigames for lockpicking.
  PermiAdmin = "admin.permissao",
  PermiPolicia = "policia.permissao",

  -- List a job like the example below to allow creation of houses.


  PoliciaisPodemEntrar     = true, -- Can houses be raided by jobs listed below?
  PoliciaAcessarInv  = true, -- Can police raid the inventory of all houses?
  -- These jobs also receive all notifications regarding police

}

mLibs = exports["meta_libs"]