-- Variables

local VORPcore = {}

TriggerEvent("getCore", function(core)
    VORPcore = core 
end)
local deployeddecks = nil
progressbar = exports.vorp_progressbar:initiate()
-- Functions

local function loadAnimDict(dict)
  while (not HasAnimDictLoaded(dict)) do
      RequestAnimDict(dict)
      Wait(5)
  end
end

-- Events

-- place dj equipment
RegisterNetEvent('s_barrier:client:barikatkur', function()
    progressbar.start("Barikat kuruluyor", "5000")
    local coords = GetEntityCoords(PlayerPedId())
    local heading = GetEntityHeading(PlayerPedId())
    local forward = GetEntityForwardVector(PlayerPedId())
    local x, y, z = table.unpack(coords + forward * 2.5)
	TaskStartScenarioInPlace(PlayerPedId(), GetHashKey("WORLD_HUMAN_CROUCH_INSPECT"), -1, true, "StartScenario", 0, false)
	Wait(500)
	ClearPedTasks(PlayerPedId())
    local object = CreateObject(GetHashKey('p_barricade05x'), x, y, z, true, false, false)
    PlaceObjectOnGroundProperly(object)
    SetEntityHeading(object, heading)
    FreezeEntityPosition(object, true)
    deployeddecks = NetworkGetNetworkIdFromEntity(object)
end)


RegisterNetEvent('s_barrier:client:barikattopla', function()
    local obj = NetworkGetEntityFromNetworkId(deployeddecks)
    local objCoords = GetEntityCoords()
    NetworkRequestControlOfEntity(obj)
    SetEntityAsMissionEntity(obj,false,true)
    DeleteEntity(obj)
    DeleteObject(obj)
    if not DoesEntityExist(obj) then
        TriggerServerEvent('s_barrier:server:barikattopla')
        deployeddecks = nil
    end
    Wait(500)
    ClearPedTasks(PlayerPedId())
end)

RegisterCommand('barikattopla', function(source, args, rawCommand)
    progressbar.start("Barikat toplaniyor", "5000")
    TaskStartScenarioInPlace(PlayerPedId(), GetHashKey("WORLD_HUMAN_CROUCH_INSPECT"), -1, true, "StartScenario", 0, false)
	Wait(5000)
	ClearPedTasks(PlayerPedId())
    local obj = NetworkGetEntityFromNetworkId(deployeddecks)
    local objCoords = GetEntityCoords()
    NetworkRequestControlOfEntity(obj)
    SetEntityAsMissionEntity(obj,false,true)
    DeleteEntity(obj)
    DeleteObject(obj)
    TriggerServerEvent('s_barrier:server:barikattopla')
    ClearPedTasks(PlayerPedId())
end)