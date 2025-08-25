
local ESX, QBCore = nil, nil

CreateThread(function()
    while not bl_lib do Wait(10) end
    bl_lib.Notify('BL HUD Loaded', 'success')
end)
local hunger, thirst = 100.0, 100.0

function math.clamp(val, min, max)
    return math.max(min, math.min(max, val))
end

CreateThread(function()
    if GetResourceState('es_extended') == 'started' then
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        while ESX == nil do Wait(100) end
    elseif GetResourceState('qb-core') == 'started' then
        QBCore = exports['qb-core']:GetCoreObject()
        while QBCore == nil do Wait(100) end
    end
end)

CreateThread(function()
    while true do
        local cash, bank = 0, 0

        if ESX then
            local accounts = ESX.GetPlayerData().accounts or {}
            for _, acc in pairs(accounts) do
                if acc.name == "money" then
                    cash = acc.money
                elseif acc.name == "bank" then
                    bank = acc.money
                end
            end
        elseif QBCore then
            local pdata = QBCore.Functions.GetPlayerData()
            local money = pdata.money or {}
            cash = money.cash or 0
            bank = money.bank or 0
        end

        if bank == 0 and GetResourceState('okokBanking') == 'started' then
            local okok = lib.callback.await('okokBanking:GetAccountData', false)
            if okok and okok.bank ~= nil then
                bank = okok.bank
            end
        end

        if bank == 0 and GetResourceState('qs-banking') == 'started' then
            local result = lib.callback.await('qs-banking:GetCurrentAccountMoney', false)
            if result and result.bank ~= nil then
                bank = result.bank
            end
        end

        if GetResourceState('ox_inventory') == 'started' then
            local oxCash = exports.ox_inventory:Search('count', 'cash')
            if oxCash and oxCash > 0 then
                cash = oxCash
            end

            local oxBank = exports.ox_inventory:Search('count', 'bank')
            if oxBank and oxBank > 0 then
                bank = oxBank
            end
        end

        SendNUIMessage({ action = "setCash", value = cash })
        SendNUIMessage({ action = "setBank", value = bank })

        if ESX then
            TriggerEvent('esx_status:getStatus', 'hunger', function(status)
                hunger = status.val / 1000000 * 100
                SendNUIMessage({ action = "setHunger", value = hunger })
            end)
            TriggerEvent('esx_status:getStatus', 'thirst', function(status)
                thirst = status.val / 1000000 * 100
                SendNUIMessage({ action = "setThirst", value = thirst })
            end)
        elseif QBCore then
            local meta = QBCore.Functions.GetPlayerData().metadata
            hunger = meta.hunger or 0
            thirst = meta.thirst or 0
            SendNUIMessage({ action = "setHunger", value = hunger })
            SendNUIMessage({ action = "setThirst", value = thirst })
        else
            hunger = math.max(hunger - 0.1, 0.0)
            thirst = math.max(thirst - 0.2, 0.0)
            SendNUIMessage({ action = "setHunger", value = hunger })
            SendNUIMessage({ action = "setThirst", value = thirst })
        end

        Wait(3000)
    end
end)

CreateThread(function()
    while true do
        local ped = PlayerPedId()
        local rawHealth = GetEntityHealth(ped)
        local maxHealth = GetEntityMaxHealth(ped)

        local health = 0
        if not IsPedDeadOrDying(ped, true) and rawHealth > 101 then
            health = math.floor(((rawHealth - 100) / (maxHealth - 100)) * 100)
        end

        health = math.clamp(health, 0, 100)
        local armor = math.clamp(GetPedArmour(ped), 0, 100)

        if not IsEntityDead(ped) and rawHealth > 101 then
    SendNUIMessage({
        type = "updateHUD",
        data = {
            health = health,
            armor = armor,
            hunger = hunger,
            thirst = thirst
        }
    })
end

        Wait(500)
    end
end)

RegisterCommand("toggleblhud", function()
    SendNUIMessage({ type = "toggleHUD" })
end, false)

RegisterKeyMapping("toggleblhud", "Toggle BL HUD", "keyboard", "F10")

-- Auto-refresh HUD after player loads
RegisterNetEvent('esx:playerLoaded', function()
    Wait(1500)
    SendNUIMessage({ type = "forceUpdate" })
end)

RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
    Wait(1500)
    SendNUIMessage({ type = "forceUpdate" })
end)

RegisterNetEvent('playerSpawned', function()
    Wait(2000)
    SendNUIMessage({ type = "forceUpdate" })
end)

-- Admin heal command
RegisterCommand("adminheal", function()
    if ESX then
        TriggerEvent('esx_status:set', 'hunger', 1000000)
        TriggerEvent('esx_status:set', 'thirst', 1000000)
    elseif QBCore then
        TriggerServerEvent("hud:setNeeds", 100, 100)
    else
        hunger = 100.0
        thirst = 100.0
    end
end, true)
