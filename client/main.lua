local flipThreshold = Config.UeberschlagWinkel
local minHeight = Config.MaxHoehe
local lastZ = 0
local isFalling = false
local debughoehe = 0

local antiueber = false
local antigh = false

local lastCheckedVehicle = nil
local blacklistedStatus = {}

local lastFlipTime = 0
local lastFallTime = 0
local debounceDelay = 3000

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(10)

        local playerPed = GetPlayerPed(-1)
        local vehicle = GetVehiclePedIsIn(playerPed, false)

        if vehicle ~= 0 then
            local rotation = GetEntityRotation(vehicle, 0)
            local xRotation = rotation.x
            local yRotation = rotation.y

            if Config.Ueberschlag and antiueber == false then
                local currentCar = string.lower(GetDisplayNameFromVehicleModel(GetEntityModel(vehicle)))
                
                if lastCheckedVehicle ~= vehicle then
                    lastCheckedVehicle = vehicle
                    blacklistedStatus[currentCar] = isVehicleBlacklisted(currentCar)
                end

                if not blacklistedStatus[currentCar] then
                    if (math.abs(xRotation) > flipThreshold or math.abs(yRotation) > flipThreshold) and not IsVehicleOnAllWheels(vehicle) then
                        SetVehicleEngineHealth(vehicle, -3999.0)
                        SetVehicleEngineOn(vehicle, false, true)
                        tg_shownotification(_('umessage'))

                        if (GetGameTimer() - lastFlipTime) > debounceDelay then
                            tg_shownotification(_('umessage'))
                            lastFlipTime = GetGameTimer()
                        end

                        if Config.Debug then
                            local text = string.format("~r~ÜBERSCHLAG AKTIV")
                            DrawText2D(0.5, 0.93, text, 0.4)
                        end
                    end
                end

                if Config.Debug then
                    local text = string.format("Aktuelle Rotation: X: "..math.round(xRotation,2)..", Y: "..math.round(yRotation,2))
                    DrawText2D(0.5, 0.9, text, 0.4)
                end
            end

            if Config.GrosseHoehe and antigh == false then
                local currentCar = string.lower(GetDisplayNameFromVehicleModel(GetEntityModel(vehicle)))

                if lastCheckedVehicle ~= vehicle then
                    lastCheckedVehicle = vehicle
                    blacklistedStatus[currentCar] = isVehicleBlacklisted(currentCar)
                end

                if not blacklistedStatus[currentCar] then
                    local currentZ = GetEntityCoords(vehicle, true).z

                    if Config.Debug then
                        DrawText2D(0.5, 0.85, "currentZ: " .. math.round(currentZ, 2), 0.4)
                        DrawText2D(0.5, 0.82, "lastZ: " .. math.round(lastZ, 2), 0.4)
                    end

                    if not IsVehicleOnAllWheels(vehicle) and (lastZ - currentZ) > minHeight then
                        isFalling = true
                    end

                    if isFalling and IsVehicleOnAllWheels(vehicle) then
                        disableVehicleEngine(vehicle)
                        tg_shownotification(_('ghmessage'))

                        isFalling = false

                        if Config.Debug then
                            debughoehe = (lastZ - currentZ)
                            DrawText2D(0.5, 0.875, "~r~FALL AUS GROßER HÖHE!", 0.4)
                        end
                    end

                    if Config.Debug then
                        DrawText2D(0.5, 0.79, "Letzter Fall: "..math.round(debughoehe,2), 0.4)
                    end

                    if IsVehicleOnAllWheels(vehicle) then
                        lastZ = currentZ
                    end
                end
            end

            if Config.Debug then
                local enginetext = string.format("Engine Health: "..GetVehicleEngineHealth(vehicle))
                DrawText2D(0.5, 0.96, enginetext, 0.4)
            end
        end
    end
end)

RegisterNetEvent('tg_accident:antiueberschlag')
AddEventHandler('tg_accident:antiueberschlag', function()
    if antiueber == false then
        tg_shownotification(_('antiueber_act'))
        antiueber = true
    else
        tg_shownotification(_('antiueber_deact'))
        antiueber = false
    end
end)

RegisterNetEvent('tg_accident:antigh')
AddEventHandler('tg_accident:antigh', function()
    if antigh == false then
        tg_shownotification(_('antigh_act'))
        antigh = true
    else
        tg_shownotification(_('antigh_deact'))
        antigh = false
    end
end)

function DrawText2D(x, y, text, scale)
    SetTextFont(0)
    SetTextProportional(1)
    SetTextScale(scale, scale)
    SetTextColour(255, 255, 255, 255)
    SetTextEntry("STRING")
    AddTextComponentString(text)
    DrawText(x, y)
end

function tg_shownotification(message)
    BeginTextCommandThefeedPost("STRING")
    AddTextComponentSubstringPlayerName(message)
    EndTextCommandThefeedPostMessagetext("CHAR_DEFAULT", "CHAR_DEFAULT", false, 0, "TG Accident Script", "")
end

function disableVehicleEngine(vehicle)
    SetVehicleEngineHealth(vehicle, -3999.0)
    SetVehicleEngineOn(vehicle, false, true)
end

function isVehicleBlacklisted(vehicle)
    for _, v in ipairs(Config.UeberschlagBlacklist) do
        if vehicle == v then
            return true
        end
    end
    return false
end