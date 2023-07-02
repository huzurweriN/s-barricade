local VorpCore = {}

TriggerEvent("getCore",function(core)
    VorpCore = core
end)

VorpInv = exports.vorp_inventory:vorp_inventoryApi()


VorpInv.RegisterUsableItem("barrier", function(data)
    VorpInv.subItem(data.source, "barrier", 1)
    TriggerClientEvent("s_barrier:client:barikatkur", data.source)
end)


RegisterServerEvent('s_barrier:server:barikattopla')
AddEventHandler('s_barrier:server:barikattopla', function()
    local _source = source
    VorpInv.addItem(_source, "barrier", 1)
end)