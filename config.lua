Config = {}

-- 🏁 Position des Verleih-Menüs
Config.RentalPosition = vector3(242.4, -863.4, 30.50)

-- 🚗 Spawnposition für Fahrzeuge
Config.SpawnVehicle = {
    coords = vector3(244.9, -861.3, 29.4),
    heading = 250.0393
}

-- 🚙 Fahrzeugmodell
Config.DefaultVehicle = "weevil"

-- 💰 Mietpreis
Config.RentalPrice = 200

-- 📏 Reichweite bei Rückgabe
Config.ReturnRange = 5.0

-- 🔤 Kennzeichen-Präfix
Config.PlatePrefix = "RENT"

-- ⏱️ Auto-Entfernung nach Minuten (0 = nie)
Config.AutoDeleteAfterMinutes = 0

-- 🎯 Marker-Einstellungen
Config.Marker = {
    type = 21,              -- Marker-Typ (z. B. 1 = Zylinder)
    size = {x = 0.5, y = 0.5, z = 0.5}, -- Größe
    color = {r = 0, g = 255, b = 255, a = 100}, -- Farbe & Transparenz
    drawDistance = 10.0    -- Sichtweite
}
