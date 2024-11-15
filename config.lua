Config = {}

Config.Debug                =   false                   -- Debug Modus aktivieren / deaktivieren
Config.Locale               =   'de'                    -- Sprache einstellen (Set Default Language)

Config.AdminGroups          =   {'admin'}               -- Gruppen die Commands ausführen dürfen.

Config.Ueberschlag          =   true                    -- Soll das Fahrzeug bei einem Überschlag verunfallen?
Config.UeberschlagWinkel    =   160                     -- Winkel den das Auto erreichen muss um sich zu überschlagen
Config.UeberschlagBlacklist =   {"bati"}                -- Fahrzeuge die vom Script ausgenommen werden sollen
Config.AntiUCommand         =   "antiueber"             -- Command um die Überschlagsüberprüfung für sich selbst zu deaktivieren

Config.GrosseHoehe          =   false                   -- Soll das Fahrzeug verunfallen wenn es aus großer Höhe fällt?
Config.MaxHoehe             =   10                      -- Maximale Höhe, die ein Fahrzeug fallen darf ohne zu verunfallen
Config.HoeheBlacklist       =   {"monster", "sanchez"}  -- Fahrzeuge die vom Script ausgenommen werden sollen
Config.AntiGHCommand        =   "antigh"                -- Command um die Überprüfung der Großen Höhe für sich selbst zu deaktivieren