vRPUtils = {}
vRPUtilsC = {}
Tunnel = module("vrp", "lib/Tunnel")
Proxy = module("vrp", "lib/Proxy")
vRP = Proxy.getInterface("vRP")
Proxy.addInterface("furni", vRPUtils)

--[[local Furni = class("Furni", vRP.Extension)

Furni.proxy = {}
function Furni.proxy:getId(source)
    local user = vRP.users_by_source[source]
    if user then
        return tonumber(user.id)
    end
end

function Furni.proxy:getSourceId(id)
    local user = vRP.users[id]
    if user then
        return user.source
    end
end

function Furni.proxy:tryPaymentCash(source,val)
    local user = vRP.users_by_source[source]
    if user then
        return user:tryPayment(val)
    end
end

function Furni.proxy:tryPaymentBank(source,val)
    local user = vRP.users_by_source[source]
    if user then
        return user:tryPaymentBank(val)
    end
end

function Furni.proxy:giveBank(source,val)
    local user = vRP.users_by_source[source]
    if user then
        user:giveplmBank(val)
    end
end

function Furni.proxy:getBank(source)
    local user = vRP.users_by_source[source]
    if user then
        return user:getBank()
    end
end

function Furni.proxy:getWallet(source)
    local user = vRP.users_by_source[source]
    if user then
        return user:getWallet()
    end
end

function Furni.proxy:onlinePl(id)
    return vRP.users[id]
end

function Furni.proxy:getPlayerJob(source)
    local user = vRP.users_by_source[source]
    if user then
        --local job = user:getGroupByType("job")
        return user:hasPermission("create.casa")
    end
end]]--

function vRPUtilsC.getPlayerJob()
    local user = vRP.getUserId(source)
    if user then
        --local job = user:getGroupByType("job")
        return vRP.hasPermission(user,Config.PermiAdmin)
    end
end

function vRPUtilsC.getId()
    local user = vRP.getUserId(source)
    if user then
        return user
    end
end

function vRPUtilsC.tryPaymentCash(val)
    local user = vRP.getUserId(source)
    if user then
        return vRP.tryPayment(user_id,val)
    end
end

function vRPUtilsC.tryPaymentBank(val)
    local user = vRP.getUserId(source)
    if user then
        return vRP.tryFullPayment(user,val)
    end
end

function vRPUtilsC.giveBank(usuarioval)
    local user = vRP.getUserId(source)
    if user then
        vRP.giveBankMoney(user,val)
    end
end

function vRPUtilsC.getBank()
    local user = vRP.getUserId(source)
    if user then
        return vRP.getBankMoney(user)
    end
end

function vRPUtilsC.getWallet()
    local user = vRP.getUserId(source)
    if user then
        return vRP.getMoney(user)
    end
end

Tunnel.bindInterface("furni", vRPUtilsC)

vRP:registerExtension(Furni)