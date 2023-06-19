ConfigC = {}

ConfigC.carregarobjeto = function(dict1,dict2,objdict,flag,flag2)

  vRP.CarregarObjeto(dict1,dict2,objdict,flag,flag2)      
end

ConfigC.delobjeto = function()
  vRP._DeletarObjeto()
end

ConfigC.notify = function(tipo,mensagem)
  TriggerEvent("Notify",tipo,mensagem)
end
