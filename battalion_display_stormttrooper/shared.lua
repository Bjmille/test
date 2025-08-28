ENT.Type = "anim"
ENT.Base = "base_gmodentity"

ENT.PrintName = "Stormtrooper Corps Information"
ENT.Author = "Imperial Command"
ENT.Category = "Imperial Roleplay"
ENT.Spawnable = true
ENT.AdminOnly = false

function ENT:SetupDataTables()
    self:NetworkVar("Int", 0, "CurrentPage")
    self:NetworkVar("Int", 1, "MaxPages") 
end

if SERVER then
    function ENT:Initialize()
        self:SetModel("models/hunter/plates/plate2x4.mdl")
        self:PhysicsInit(SOLID_VPHYSICS)
        self:SetMoveType(MOVETYPE_VPHYSICS)
        self:SetSolid(SOLID_VPHYSICS)
        
        local phys = self:GetPhysicsObject()
        if IsValid(phys) then
            phys:Wake()
        end
        
        self:SetUseType(SIMPLE_USE)
        
        self:SetNWInt("CurrentPage", 1)
        self:SetNWInt("MaxPages", 3)
    end
    
    function ENT:Use(activator, caller)
        if not IsValid(activator) or not activator:IsPlayer() then return end
        
        local currentPage = self:GetNWInt("CurrentPage", 1)
        local maxPages = self:GetNWInt("MaxPages", 3)
        
        -- Simple page cycling for server-side
        local newPage = currentPage + 1
        if newPage > maxPages then
            newPage = 1
        end
        
        self:SetNWInt("CurrentPage", newPage)
    end
end