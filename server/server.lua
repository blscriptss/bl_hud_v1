
RegisterCommand("savehud", function(source, args, raw)
    print("HUD settings saved")
end, true)

RegisterNetEvent("hud:setNeeds", function(hunger, thirst)
    local src = source
    local Player = QBCore and QBCore.Functions.GetPlayer(src)
    if Player then
        Player.Functions.SetMetaData("hunger", hunger)
        Player.Functions.SetMetaData("thirst", thirst)
    end
end)
