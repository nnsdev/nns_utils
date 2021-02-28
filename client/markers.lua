markers = {}

RegisterMarker = function (name, text, coords, maxDist, interactDist, cb, options)
    local zone = GetZoneAtCoords(vector3(coords.x, coords.y, coords.z))

    if markers[zone] == nil then
        markers[zone] = {}
    end

    local color = { r = 255, g = 255, b = 255, a = 100 }

    if options.color ~= nil then
        color = options.color
    end

    local scale = vector3(1.0, 1.0, 1.0)

    if options.scale ~= nil then
        scale = options.scale
    end

    local type = 27
    if options.type ~= nil then
        type = options.type
    end

    markers[zone][name] = {
        name = name,
        type = type,
        text = text,
        coords = vector3(coords.x, coords.y, coords.z),
        maxDist = maxDist,
        interactDist = interactDist,
        color = color,
        scale = scale,
        cb = cb
    }
end

UnregisterMarker = function (name)
    for zone, markerSplit in pairs(markers) do
        if markerSplit[name] ~= nil then
            markers[zone][name] = nil
        end
    end
end

AddEventHandler("nns_utils:client:registerMarker", RegisterMarker)
AddEventHandler("nns_utils:client:unregisterMarker", UnregisterMarker)


exports("RegisterMarker", RegisterMarker)
exports("UnregisterMarker", UnregisterMarker)
