CreateThread(function()
    while not IsHudComponentActive(14) do
        Wait(100)
    end

    local minimap = RequestScaleformMovie("minimap")
    while not HasScaleformMovieLoaded(minimap) do
        Wait(0)
    end

    -- Refresh radar
    SetRadarBigmapEnabled(true, false)
    Wait(100)
    SetRadarBigmapEnabled(false, false)

    local defaultAspectRatio = 1920 / 1080
    local resX, resY = GetActiveScreenResolution()
    local aspectRatio = resX / resY
    local minimapOffset = 0
    if aspectRatio > defaultAspectRatio then
        minimapOffset = ((defaultAspectRatio - aspectRatio) / 3.6) - 0.008
    end

    -- Minimap position
    SetMinimapComponentPosition("minimap", "L", "B", -0.010 + minimapOffset, -0.085, 0.1638, 0.183)
    SetMinimapComponentPosition("minimap_mask", "L", "B", -0.010 + minimapOffset, -0.038, 0.128, 0.20)
    SetMinimapComponentPosition("minimap_blur", "L", "B", -0.020 + minimapOffset, -0.013, 0.262, 0.300)
    SetBlipAlpha(GetNorthRadarBlip(), 0)

    SetScriptGfxAlign(string.byte("L"), string.byte("B"))

    -- Align parameters
    local xPos = -0.010 + minimapOffset
    local yPos = 0.745 
    SetScriptGfxAlignParams(xPos, yPos, 0.0, 0.0)
end)
