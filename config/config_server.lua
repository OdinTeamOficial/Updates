ConfigS = {}

ConfigS.giveitem = function(user_id,item,quantidade,notify)
  vRP.giveInventoryItem(user_id,item,quantidade,notify)
end

ConfigS.GetItem = function(user_id,item,quantidade,notify)
  return vRP.tryGetInventoryItem(user_id,item,quantidade,notify)
end

ConfigS.getid = function(nsource)
  return vRP.getUserId(nource)
end

ConfigS.notify = function(nsource,tipo,mensagem)
  TriggerClientEvent("Notify",nsource,tipo,mensagem)
end