----------------------------------------------------------------------------------
-- IMPORTS
----------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
src = Tunnel.getInterface("Wall")
----------------------------------------------------------------------------------
-- VARIAVEIS
----------------------------------------------------------------------------------
local testes = false
local players = {}
local name = {}
local name2 = {}

function tD(n)
    n = math.ceil(n * 100) / 100
    return n
end
----------------------------------------------------------------------------------
-- ARMAS ARRAY
----------------------------------------------------------------------------------
local armas = {			["-1569615261"] = "Unarmed",
						["2725352035"] = "Unarmed",
						["2578778090"] = "Faca",
						["1737195953"] = "Cassetete",
						["1317494643"] = "Martelo",
						["2508868239"] = "Taco de Beiseball",
						["1141786504"] = "Taco de golf",
						["2227010557"] = "Pé de cabra",
						["453432689"] = "Colt-1911",
						["-1075685676"] = "Five-seven",
						["961495388"] = "AK-49",
						["1593441988"] = "Glock-18",
						["584646201"] = "Pistola AP",
						["324215364"] = "UZI",
						["736523883"] = "MPX",
						["4024951519"] = "MTAR-21",
						["3220176749"] = "AK-47",
						["2210333304"] = "M4A1",
						["487013001"] = "Remington",
						["911657153"] = "Tazer",
						["100416529"] = "Sniper",
						["205991906"] = "Sniper Pesada",
						["2726580491"] = "Lançador de granada",
						["1305664598"] = "Lançador de smoke",
						["2982836145"] = "RPG",
						["1119849093"] = "Minigun",
						["2481070269"] = "Granada",
						["741814745"] = "Bomba Adesiva",
						["4256991824"] = "Granada de fumaça",
						["2694266206"] = "Bzgas",
						["615608432"] = "Molotov",
						["101631238"] = "Extintor",
						["1233104067"] = "Flare",
						["3218215474"] = "Pistola fajuta",
						["4192643659"] = "Garrafa quebrada",
						["1627465347"] = "Thompsom",
						["3523564046"] = "Pistola pesada",
						["2460120199"] = "Adaga",
						["137902532"] = "Pistola Vintage",
						["2138347493"] = "Foguete",
						["2828843422"] = "Mosquetão",
						["984333226"] = "Escopeta pesada",
						["3342088282"] = "Sniper",
						["126349499"] = "Bola de neve",
						["2874559379"] = "Mina de proximidade",
						["1198879012"] = "Sinalizador",
						["1672152130"] = "Lançador de teleguiado",
						["3494679629"] = "Algemas",
						["171789620"] = "Sig-Sauer",
						["3638508604"] = "Soco-Inglês",
						["4191993645"] = "Machadinho",
						["1834241177"] = "Arma de raio",
						["3713923289"] = "Facão",
						["3675956304"] = "Tec-Nine",
						["3756226112"] = "Canivete",
						["3249783761"] = "TREIX OITAO",
						["1649403952"] = "Rifle compacto",
						["883325847"] = "Galão de gasolina"
			}
----------------------------------------------------------------------------------
-- THREADS
----------------------------------------------------------------------------------
Citizen.CreateThread(
	function()
		while true do
			Citizen.Wait(1000)
		    for _, id in ipairs(GetActivePlayers()) do
				local pid = src.getId(GetPlayerServerId(id))
				players[id] = pid
			end
		end
	end
)
----------------------------------------------------------------------------------
-- WALL
----------------------------------------------------------------------------------
RegisterCommand("wall",function(source,args)
	if src.getPermissao() then
		if testes then
			testes = false
			src.wallLog(testes)
		else
			testes = true
			src.wallLog(testes)
		end
	end
end)
----------------------------------------------------------------------------------
-- THREADS
----------------------------------------------------------------------------------
Citizen.CreateThread(
	function()
	    while true do
	    	Citizen.Wait(0)
			if testes then
				for _, id in ipairs(GetActivePlayers()) do

					local pos = GetEntityCoords(GetPlayerPed(id))
					local pos2 = GetEntityCoords(GetPlayerPed(), true)

					local x,y,z = table.unpack(GetEntityCoords(GetPlayerPed(-1),true))
                	local x2,y2,z2 = table.unpack(GetEntityCoords(GetPlayerPed(id),true))

					local distance = GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), pos)

					local id2 = id
					local healthped = GetPlayerPed(id)
					local health = GetEntityHealth(healthped)
					local colete =  GetPedArmour(healthped)
					local arma = GetSelectedPedWeapon(healthped)
					local arma_name = armas[tostring(arma)]
					if not arma_name then
						arma_name = "Unknown"
					end

					DrawLine(x, y, z, x2, y2, z2, 10, 22, 255, 255)

					DrawText3D(pos.x, pos.y, pos.z + 1.2, "~w~["..tD(distance).."m]\n ~w~ID: ~g~"..players[id].." ~w~Steam: ~g~"..GetPlayerName(id).."\n~w~Vida: ~g~"..health.."~w~ (~b~"..colete.."%~w~)\n~w~Arma: ~g~"..arma_name)
					
				end
			end
	    end
	end
)
----------------------------------------------------------------------------------
-- DRAWTEXT3D
----------------------------------------------------------------------------------
function DrawText3D(x, y, z, text)
    local onScreen, _x, _y = GetScreenCoordFromWorldCoord(x, y, z)
    local px, py, pz = table.unpack(GetGameplayCamCoords())
    local dist = GetDistanceBetweenCoords(px, py, pz, x, y, z, 1)
    
    if onScreen then
        SetTextScale(0.0, 0.30)
        SetTextFont(0)
        SetTextColour(255, 255, 255, 255)
        SetTextDropshadow(0, 0, 0, 0, 255)
        SetTextEntry("STRING")
        SetTextCentre(1)
        AddTextComponentString(text)
        DrawText(_x, _y)
    end
end
