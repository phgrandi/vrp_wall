local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
local Tools = module("vrp","lib/Tools")
vRP = Proxy.getInterface("vRP")
src = {}
Tunnel.bindInterface("Wall",src)
----------------------------------------------------------------------------------
-- LOG
----------------------------------------------------------------------------------
function SendWebhookMessage(webhook,message)
    if webhook ~= nil and webhook ~= "" then
        PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({content = message}), { ['Content-Type'] = 'application/json' })
    end
end

local webhookwall = "LINK DO WEBHOOK"
----------------------------------------------------------------------------------
function src.getId(sourceplayer)
	local user_id = vRP.getUserId(sourceplayer)
	return user_id
end

function src.getname(sourceplayer)
    --local user_id = vRP.getUserId(sourceplayer)
    local identity = vRP.getUserIdentity(sourceplayer)
	return identity.name
end

function src.getname2(sourceplayer)
    --local user_id = vRP.getUserId(sourceplayer)
    local identity = vRP.getUserIdentity(sourceplayer)
	return identity.firstname
end

function src.getPermissao()
    local source = source
    local user_id = vRP.getUserId(source)
    if vRP.hasPermission(user_id,permissao) then
        return true
    else
        return false
    end
end

function src.wallLog(testes)
    local source = source
    local user_id = vRP.getUserId(source)

    if testes then
        SendWebhookMessage(webhookwall,"```prolog\n[ID]: "..user_id.." \n[LIGOU O WALLHACK]"..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
    elseif not testes then
        SendWebhookMessage(webhookwall,"```prolog\n[ID]: "..user_id.." \n[DESLIGOU O WALLHACK]"..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
    end
end