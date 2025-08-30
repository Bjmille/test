ENT.Type = "anim"
ENT.Base = "base_gmodentity"

ENT.PrintName = "Imperial Super Commandos Information"
ENT.Author = "Imperial Command"
ENT.Category = "Imperial Roleplay"
ENT.Spawnable = true
ENT.AdminOnly = false

function ENT:SetupDataTables()
    self:NetworkVar("Int", 0, "CurrentPage")
    self:NetworkVar("Int", 1, "MaxPages") 
end