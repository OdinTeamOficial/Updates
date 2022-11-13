local labels = {
  ['pt'] = {
    ['Entry']       = "Entrada",
    ['Exit']        = "Saida",
    ['Garage']      = "Garagem",
    ['Wardrobe']    = "Guarda-Roupa",
    ['Inventory']   = "Inventário",
    ['InventoryLocation']   = "Inventário",

    ['LeavingHouse']      = "Saindo da Cassa",

    ['AccessHouseMenu']   = "Acessar Menu",

    ['InteractDrawText']  = "["..Config.CorTextos[Config.TipoMarker].."E~s~] ",
    ['InteractHelpText']  = "~INPUT_PICKUP~ ",

    ['AcceptDrawText']    = "["..Config.CorTextos[Config.TipoMarker].."G~s~] ",
    ['AcceptHelpText']    = "~INPUT_DETONATE~ ",

    ['FurniDrawText']     = "["..Config.CorTextos[Config.TipoMarker].."F~s~] ",
    ['CancelDrawText']    = "["..Config.CorTextos[Config.TipoMarker].."F~s~] ",

    ['VehicleStored']     = "Veiculo Guardado",
    ['CantStoreVehicle']  = "Você nao pode guardar este veiculo",

    ['HouseNotOwned']     = "Voce nao é dono desta casa",
    ['InvitedInside']     = "Aceitar convite para casa",
    ['MovedTooFar']       = "Voce se moveu para muito longe da porta",
    ['KnockAtDoor']       = "Alguém esta batendo na porta",

    ['TrackMessage']      = "Rastrear mensagem",

    ['Unlocked']          = "Casa destrancada",
    ['Locked']            = "Casa trancada",

    ['WardrobeSet']       = "Setar guarda-roupa",
    ['InventorySet']      = "Setar inventário",

    ['ToggleFurni']       = "Abrir/fechar menu de móveis",

    ['GivingKeys']        = "Dar chaves para outro player",
    ['TakingKeys']        = "Pegar chaves de outro jogador",

    ['GarageSet']         = "Setar garagem",
    ['GarageTooFar']      = "Garagem está muito longe",

    ['PurchasedHouse']    = "~w~[~b~OdinHouse~w~] ~g~Voce comprou a casa $%d",
    ['CantAffordHouse']   = "~w~[~b~OdinHouse~w~] ~r~Sem dinheiro suficiente!",

    ['MortgagedHouse']    = "Voce hipotecou a casa por $%d",

    ['NoLockpick']        = "Voce nao tem lockpick",
    ['LockpickFailed']    = "Voce falhou em abrir a porta",
    ['LockpickSuccess']   = "Voce abriu a porta com sucesso",

    ['NotifyRobbery']     = "Alguem esta tentando roubar a casa %s",

    ['ProgressLockpicking'] = "Abrindo porta",

    ['InvalidShell']        = "Interior inválido: %s, por favor, reporte ao dono do server.",
    ['ShellNotLoaded']      = "Interior não carregado: %s, por favor, reporte ao dono do server.",
    ['BrokenOffset']        = "Offset confuso para o id %s, por favor, reporte ao dono do server.",

    ['UpgradeHouse']        = "~w~[~b~OdinHouse~w~] ~g~Voce comprou um novo interior: %s",
    ['CantAffordUpgrade']   = "~w~[~b~OdinHouse~w~] ~r~Dinheiro insuficiente!",

    ['SetSalePrice']        = "Mudar valor de venda",
    ['InvalidAmount']       = "~w~[~b~OdinHouse~w~] ~r~Valor inválido!",
    ['InvalidSale']         = "Voce nao pode vender uma casa em que deve dinheiro",
    ['InvalidMoney']        = "Dinheiro Insuficiente",

    ['EvictingTenants']     = "Despejar Inquilinos",

    ['NoOutfits']           = "Voce nao tem looks guardados",

    ['EnterHouse']          = "Entre na casa",
    ['KnockHouse']          = "Bater Na Porta",
    ['RaidHouse']           = "Roubar Casa",
    ['BreakIn']             = "Arrombar Porta",
    ['InviteInside']        = "Convidar para a casa",
    ['HouseKeys']           = "Chaves da casa",
    ['UpgradeHouse2']       = "Atualizar casa",
    ['UpgradeShell']        = "Atualizar Interior",
    ['SellHouse']           = "Vender casa",
    ['FurniUI']             = "Catálogo de móveis",
    W         = "Setar Guarda-roupa",
    ['SetInventory']        = "Setar Inventário",
    ['SetGarage']           = "Setar Garagem",
    ['LockDoor']            = "Trancar casa",
    ['UnlockDoor']          = "Destrancar casa",
    ['LeaveHouse']          = "Sair da casa",
    ['Mortgage']            = "Hipotecar",
    ['Buy']                 = "Comprar",
    ['View']                = "Visualizar",
    ['Upgrades']            = "Atualizar",
    ['MoveGarage']          = "Mover garagem",

    ['GiveKeys']            = "Dar chaves",
    ['TakeKeys']            = "Pegar chaves",

    ['MyHouse']             = "Minha casa",
    ['PlayerHouse']         = "Casa do player",
    ['EmptyHouse']          = "Casa vazia",

    ['NoUpgrades']          = "Sem atualizações disponiveis",
    ['NoVehicles']          = "Sem veiculos Disponiveis",
    ['NothingToDisplay']    = "Nada para mostrar",

    ['ConfirmSale']         = "Sim, vender casa",
    ['CancelSale']          = "Não vender casa",
    ['SellingHouse']        = "Vender casa por R$",

    ['MoneyOwed']           = "Dívida: $%s",
    ['LastRepayment']       = "Último pagamento: %s",
    ['PayMortgage']         = "Pagar Hipoteca",
    ['MortgageInfo']        = "Informações da hipoteca",

    ['SetEntry']            = "Setar entrada",
    ['CancelGarage']        = "Cancelar garagem",
    ['UseInterior']         = "Usar interior",
    ['UseShell']            = "Usar interior",
    ['InteriorType']        = "Setar tipo de interior",
    ['SetInterior']         = "Selecione interior atual",
    ['SelectDefaultShell']  = "Selecione o interior padrão",
    ['ToggleShells']        = "Mudar interiores disponiveis da casa",
    ['AvailableShells']     = "Interiores Disponiveis",
    ['Enabled']             = "~g~ATIVADO~s~",
    ['Disabled']            = "~r~DESATIVADO~s~",
    ['NewDoor']             = "Adicionar nova porta",
    ['Done']                = "Finalizado",
    ['Doors']               = "Portas",
    ['Interior']            = "Interior",

    ['CreationComplete']    = "Casa criada com sucesso.",

    ['HousePurchased'] = "Sua casa foi comprada por $%d",
    ['HouseEarning']   = ", Voce recebeu $%d da venda.",
    ['Availableupgrades']   = "Upgrades Disponiveis",
    ['Upgradesdispo']   = "Upgrades",
    ['HouseExit']   = "Saida da Casa",
    ['HouseSelling']   = "Casa à Venda",
    ['NoplayersNerHouse']   = "Sem jogadores na entrada",
    ['Confirmationhouse']   = "Confirmar",
    ['ConfirmationSalehouse']   = "Confirmar Vend",
    ['CancelSellHouse']   = "Cancelar",
    ['Verify']   = "Verificar",
    ['NoPlayersKey']   = "Sem Jogadores Com A Chave",
    ['SpawnVehicle']   = "Spawnar Veiculo",
    ['NotExitVehicle']   = "Você ja tem um veiculo desse fora da garagem",
    ['LongPlayer']   = "Voce esta muito longe da entrada",



  },

  ['en'] = {
    ['Entry']       = "Entry",
    ['Exit']        = "Exit",
    ['Garage']      = "Garage",
    ['Wardrobe']    = "Wardrobe",
    ['Inventory']   = "Inventory",
    ['InventoryLocation']   = "Inventory",

    ['LeavingHouse']      = "Leaving house",

    ['AccessHouseMenu']   = "Access the house menu",

    ['InteractDrawText']  = "["..Config.CorTextos[Config.TipoMarker].."E~s~] ",
    ['InteractHelpText']  = "~INPUT_PICKUP~ ",

    ['AcceptDrawText']    = "["..Config.CorTextos[Config.TipoMarker].."G~s~] ",
    ['AcceptHelpText']    = "~INPUT_DETONATE~ ",

    ['FurniDrawText']     = "["..Config.CorTextos[Config.TipoMarker].."F~s~] ",
    ['CancelDrawText']    = "["..Config.CorTextos[Config.TipoMarker].."F~s~] ",

    ['VehicleStored']     = "Vehicle stored",
    ['CantStoreVehicle']  = "You can't store this vehicle",

    ['HouseNotOwned']     = "You don't own this house",
    ['InvitedInside']     = "Accept house invitation",
    ['MovedTooFar']       = "You moved too far from the door",
    ['KnockAtDoor']       = "Someone is knocking at your door",

    ['TrackMessage']      = "Track message",

    ['Unlocked']          = "House unlocked",
    ['Locked']            = "House locked",

    ['WardrobeSet']       = "Wardrobe set",
    ['InventorySet']      = "Inventory set",

    ['ToggleFurni']       = "Toggle furniture UI",

    ['GivingKeys']        = "Giving keys to player",
    ['TakingKeys']        = "Taking keys from player",

    ['GarageSet']         = "Garage location set",
    ['GarageTooFar']      = "Garage is too far away",

    ['PurchasedHouse']    = "~w~[~b~OdinHouse~w~] ~g~Ai cumparat casa si ai platit $%d",
    ['CantAffordHouse']   = "~w~[~b~OdinHouse~w~] ~r~Nu ai bani suficienti!",

    ['MortgagedHouse']    = "You mortgaged the house for $%d",

    ['NoLockpick']        = "You don't have a lockpick",
    ['LockpickFailed']    = "You failed to crack the lock",
    ['LockpickSuccess']   = "You successfully cracked the lock",

    ['NotifyRobbery']     = "Someone is attempting to rob a house at %s",

    ['ProgressLockpicking'] = "Lockpicking Door",

    ['InvalidShell']        = "Invalid house shell: %s, please report to your server owner.",
    ['ShellNotLoaded']      = "Shell would not load: %s, please report to your server owner.",
    ['BrokenOffset']        = "Offset is messed up for house with ID %s, please report to your server owner.",

    ['UpgradeHouse']        = "~w~[~b~OdinHouse~w~] ~g~Ai cumparat un interior: %s",
    ['CantAffordUpgrade']   = "~w~[~b~OdinHouse~w~] ~r~Nu ai bani suficienti!",

    ['SetSalePrice']        = "Set sale price",
    ['InvalidAmount']       = "~w~[~b~OdinHouse~w~] ~r~Suma invalida!",
    ['InvalidSale']         = "You can't sell a house that you still owe money on",
    ['InvalidMoney']        = "You don't have enough money",

    ['EvictingTenants']     = "Evicting tenants",

    ['NoOutfits']           = "You don't have any outfits stored",

    ['EnterHouse']          = "Intra in Casa",
    ['KnockHouse']          = "Bate la usa",
    ['RaidHouse']           = "Raid House",
    ['BreakIn']             = "Break In",
    ['InviteInside']        = "Invita in Casa",
    ['HouseKeys']           = "Cheile Casei",
    ['UpgradeHouse2']       = "Actualizeaza Casa",
    ['UpgradeShell']        = "Actualizeaza Interior",
    ['SellHouse']           = "Vinde Casa",
    ['FurniUI']             = "Meniu Mobila",
    ['SetWardrobe']         = "Seteaza Garderoba",
    ['SetInventory']        = "Seteaza Inventar",
    ['SetGarage']           = "Set Garage",
    ['LockDoor']            = "Incuie Casa",
    ['UnlockDoor']          = "Descuie Casa",
    ['LeaveHouse']          = "Iesi din Casa",
    ['Mortgage']            = "Mortgage",
    ['Buy']                 = "Cumpara",
    ['View']                = "Viziteaza",
    ['Upgrades']            = "Actualizari",
    ['MoveGarage']          = "Move Garage",

    ['GiveKeys']            = "Ofera chei",
    ['TakeKeys']            = "Ia chei",

    ['MyHouse']             = "My House",
    ['PlayerHouse']         = "Player House",
    ['EmptyHouse']          = "Empty House",

    ['NoUpgrades']          = "No upgrades available",
    ['NoVehicles']          = "No vehicles",
    ['NothingToDisplay']    = "Nothing to display",

    ['ConfirmSale']         = "Yes, sell my house",
    ['CancelSale']          = "No, don't sell my house",
    ['SellingHouse']        = "Sell House ($%d)",

    ['MoneyOwed']           = "Money Owed: $%s",
    ['LastRepayment']       = "Last Repayment: %s",
    ['PayMortgage']         = "Pay Mortgage",
    ['MortgageInfo']        = "Mortgage Info",

    ['SetEntry']            = "Set Entry",
    ['CancelGarage']        = "Cancel Garage",
    ['UseInterior']         = "Use Interior",
    ['UseShell']            = "Use Shell",
    ['InteriorType']        = "Set Interior Type",
    ['SetInterior']         = "Select Current Interior",
    ['SelectDefaultShell']  = "Select default house shell",
    ['ToggleShells']        = "Toggle shells available for this property",
    ['AvailableShells']     = "Available Shells",
    ['Enabled']             = "~g~ENABLED~s~",
    ['Disabled']            = "~r~DISABLED~s~",
    ['NewDoor']             = "Add New Door",
    ['Done']                = "Done",
    ['Doors']               = "Doors",
    ['Interior']            = "Interior",

    ['CreationComplete']    = "House creation complete.",

    ['HousePurchased'] = "Your house was purchased for $%d",
    ['HouseEarning']   = ", you earnt $%d from the sale.",
    ['HouseExit']   = "Saida da Casa",

  }
}

Labels = setmetatable({},{
  __index = function(self,k)
    if Config and Config.Linguagem and labels[Config.Linguagem] then
      if labels[Config.Linguagem][k] then
        return labels[Config.Linguagem][k]
      else
        return string.format("UNKNOWN LABEL: %s",tostring(k))
      end
    elseif labels['en'] then
      if labels[Config.Linguagem][k] then
        return labels[Config.Linguagem][k]
      else
        return string.format("UNKNOWN LABEL: %s",tostring(k))
      end
    else
      return string.format("UNKNOWN LABEL: %s",tostring(k))
    end
  end
})

