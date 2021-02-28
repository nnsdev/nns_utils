labels = {}


RegisterLabel = function (name, text, coords, maxDist, interactDist, cb)
    local zone = GetZoneAtCoords(coords.x, coords.y, coords.z)

    if labels[zone] == nil then
        labels[zone] = {}
    end

    labels[zone][name] = {
        text = text,
        coords = vector3(coords.x, coords.y, coords.z),
        maxDist = maxDist,
        interactDist = interactDist,
        cb = cb
    }
end

UnregisterLabel = function (name)
    for zone, labelSplit in pairs(labels) do
        if labelSplit[name] ~= nil then
            labels[zone][name] = nil
        end
    end
end

AddEventHandler("nns_utils:client:registerLabel", RegisterLabel)
AddEventHandler("nns_utils:client:UnregisterLabel", UnregisterLabel)

exports("RegisterLabel", RegisterLabel)
exports("UnregisterLabel", UnregisterLabel)
