local function resolveHudScale(scale)
    local baseScale = tonumber(scale) or 1.0
    local offset = tonumber(Config.HudScaleOffset) or 0.0
    local resolvedScale = baseScale + offset

    if resolvedScale < 0.1 then
        resolvedScale = 0.1
    end

    return resolvedScale
end

function SetScale(scale)
    SendNUIMessage({
        action = "setScale",
        scale = resolveHudScale(scale)
    })
end

exports("SetScale", function(scale)
    SetScale(scale)
end)
