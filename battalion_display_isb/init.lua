AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
AddCSLuaFile("entities/battalion_display_base.lua")

include("shared.lua")

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
    
    local newPage = currentPage + 1
    if newPage > maxPages then
        newPage = 1
    end
    
    self:SetNWInt("CurrentPage", newPage)
end