function SetScale(scale)
    SendNUIMessage({
        action = "setScale",
        scale = scale
    })
end

exports("SetScale", function(scale)
    SetScale(scale)
end)
