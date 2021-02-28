drawnMarkers = {}
drawnLabels = {}

CreateThread(function ()
    while true do
        Wait(1000)
        local playerPos = GetEntityCoords(PlayerPedId())
        local zone = GetZoneAtCoords(playerPos)

        drawnMarkers = {}
        if markers[zone] ~= nil then
            for index, marker in pairs(markers[zone]) do
                local dist = #(marker.coords - playerPos)
                if dist < marker.maxDist then
                    table.insert(drawnMarkers, marker)
                end
            end
        end

        drawnLabels = {}
        if labels[zone] ~= nil then
            for index, label in pairs(labels[zone]) do
                local dist = #(label.coords - playerPos)
                if dist < label.maxDist then
                    table.insert(drawnLabels, label)
                end
            end
        end
    end
end)

local currentMarker = nil

CreateThread(function ()
    while true do
        Wait(0)
        local playerPos = GetEntityCoords(PlayerPedId())
        for index, marker in pairs(drawnMarkers) do
            DrawMarker(marker.type, marker.coords, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, marker.scale, marker.color.r, marker.color.g, marker.color.b, marker.color.a, false, true, 2, false, false, false, false)
            if #(playerPos - marker.coords) < marker.interactDist then
                if currentMarker ~= marker then
                    currentMarker = marker
                    AddTextEntry('utilMarkerText', '~INPUT_CONTEXT~ ' .. marker.text)
                end
                if marker.hasText then
                    DisplayHelpTextThisFrame('utilMarkerText', false)
                end
                if IsControlJustReleased(0, 38) then
                    marker.cb()
                end
            end
        end
        for index, label in pairs(drawnLabels) do
            DrawText3Ds(label.coords, label.text)
            if #(playerPos - label.coords) < label.interactDist then
                if IsControlJustReleased(0, 38) then
                    label.cb()
                end
            end
        end
    end
end)

DrawText3Ds = function (coords, text)
    local onScreen,_x,_y=World3dToScreen2d(coords.x, coords.y, coords.z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())

    if onScreen then
        SetTextScale(0.32, 0.32)
        SetTextFont(4)
        SetTextProportional(1)
        SetTextColour(255, 255, 255, 255)
        SetTextEntry("STRING")
        SetTextCentre(1)
        AddTextComponentString(text)
        DrawText(_x,_y)
        local factor = (string.len(text)) / 500
        DrawRect(_x,_y+0.0125, 0.015+ factor, 0.03, 0, 0, 0, 80)
    end
end
