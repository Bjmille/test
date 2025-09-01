include("shared.lua")
AddCSLuaFile()

function ENT:Draw()
    self:DrawModel()
    
    -- Optional: Add 3D2D text above the entity
    local pos = self:GetPos() + Vector(0, 0, 80)
    local ang = Angle(0, LocalPlayer():EyeAngles().y - 90, 90)
    
    cam.Start3D2D(pos, ang, 0.1)
        draw.SimpleText("LSCS Vendor", "DermaDefault", 0, 0, Color(255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
        draw.SimpleText("Press E to customize vehicle", "DermaDefault", 0, 20, Color(200, 200, 200), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
    cam.End3D2D()
end

function ENT:Initialize()
    -- Client-side initialization if needed
end
