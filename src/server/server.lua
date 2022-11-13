vRPUtils = {}
vRPUtilsC = {}

Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")
vRP = Proxy.getInterface("vRP")
--Tunnel.bindInterface("CaseMob", vRPUtilsC)
Proxy.addInterface("CaseMob", vRPUtils)

--local CaseMob = class("CaseMob", vRP.Extension)
vRP = Proxy.getInterface("vRP")

--[[CaseMob.proxy = {}
function CaseMob.proxy:getId(source)
    local user = vRP.users_by_source[source]
    if user then
        return tonumber(user.id)
    end
end

function CaseMob.proxy:getSourceId(id)
    local user = vRP.users[id]
    if user then
        return user.source
    end
end

function CaseMob.proxy:tryPaymentCash(source,val)
    local user = vRP.users_by_source[source]
    if user then
        return user:tryPayment(val)
    end
end

function CaseMob.proxy:tryPaymentBank(source,val)
    local user = vRP.users_by_source[source]
    if user then
        return user:tryPaymentBank(val)
    end
end

function CaseMob.proxy:giveBank(source,val)
    local user = vRP.users_by_source[source]
    if user then
        user:giveplmBank(val)
    end
end

function CaseMob.proxy:getBank(source)
    local user = vRP.users_by_source[source]
    if user then
        return user:getBank()
    end
end

function CaseMob.proxy:getWallet(source)
    local user = vRP.users_by_source[source]
    if user then
        return user:getWallet()
    end
end

function CaseMob.proxy:onlinePl(id)
    return vRP.users[id]
end

function CaseMob.proxy:getPlayerJob(source)
    local user = vRP.getUserId(source)
    if user then
        print(9)
        --local job = user:getGroupByType("job")
        return vRP.hasPermission(user,Config.PermiAdmin)
    end
end

function CaseMob.proxy:notify(source, x)
    print(10)
    vRP.EXT.Base.remote.notify(source,x)
end]]--

function vRPUtilsC.getPlayerJob(job)

    local user = vRP.getUserId(source)
    if user then
        --local job = user:getGroupByType("job")
        return vRP.hasPermission(user,job)
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

function vRPUtilsC.giveBank(user_id,val)

    if user_id then
        vRP.giveBankMoney(user_id,val)
    end
end

function vRPUtilsC.getBank()
    local user = vRP.getUserId(source)
    if user then
        return vRP.getBankMoney(user)
    end
end

function vRPUtilsC.getitem(item,amount)
    local source = source
    local user = vRP.getUserId(source)
    if user then

        if vRP.tryGetInventoryItem(user, item, amount) then
            return true
        else
            return false
        end
    end
end

function vRPUtilsC.getWallet()
    local user = vRP.getUserId(source)
    if user then
        return vRP.getMoney(user)
    end
end



Tunnel.bindInterface("CaseMob", vRPUtilsC)



vRP:registerExtension(CaseMob)