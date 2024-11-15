ESX = nil

ESX = exports["es_extended"]:getSharedObject()

if Config.Ueberschlag then
    RegisterCommand(Config.AntiUCommand, function(source, args)
        if source > 0 then
            local _source = source
            local xPlayer = ESX.GetPlayerFromId(_source)
            if xPlayer then
                if Config.Debug then
                    print("^0[^3DEBUG^0] ^1tg_accident^0: xPlayer object retrieved.")
                end

                local players = ESX.GetPlayers()
                for _, player in ipairs(players) do
                    local xPlayer = ESX.GetPlayerFromId(player)
                    local playerGroup = xPlayer.getGroup()

                    for _, AllowedGroup in ipairs(Config.AdminGroups) do
                        if playerGroup == AllowedGroup then
                            TriggerClientEvent("tg_accident:antiueberschlag", _source)
                            return
                        end
                    end
                end

                if Config.Debug then
                    print("^0[^3DEBUG^0] ^1tg_accident^0: /"..Config.AntiUCommand.." was executed by ID: ".._source)
                end
            end
        else
            if Config.Debug then
                print("^0[^3DEBUG^0] ^1tg_accident^0: /"..Config.AntiUCommand.." was executed by ^4server console^0, ^4RCON client^0 or a ^4resource^0.")
            end
        end
    end, false)
end

if Config.GrosseHoehe then
    RegisterCommand(Config.AntiGHCommand, function(source, args)
        if source > 0 then
            local _source = source
            local xPlayer = ESX.GetPlayerFromId(_source)
            if xPlayer then
                if Config.Debug then
                    print("^0[^3DEBUG^0] ^1tg_accident^0: xPlayer object retrieved.")
                end

                local players = ESX.GetPlayers()
                for _, player in ipairs(players) do
                    local xPlayer = ESX.GetPlayerFromId(player)
                    local playerGroup = xPlayer.getGroup()

                    for _, AllowedGroup in ipairs(Config.AdminGroups) do
                        if playerGroup == AllowedGroup then
                            TriggerClientEvent("tg_accident:antigh", _source)
                            return
                        end
                    end
                end

                if Config.Debug then
                    print("^0[^3DEBUG^0] ^1tg_accident^0: /"..Config.AntiGHCommand.." was executed by ID: ".._source)
                end
            end
        else
            if Config.Debug then
                print("^0[^3DEBUG^0] ^1tg_accident^0: /"..Config.AntiGHCommand.." was executed by ^4server console^0, ^4RCON client^0 or a ^4resource^0.")
            end
        end
    end, false)
end