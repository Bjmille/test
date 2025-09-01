AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

function ENT:Initialize()
    -- Set model (you can change this to whatever model you want)
    self:SetModel("models/lt_c/holograms/console_hr.mdl")
    
    self:SetSolid(SOLID_VPHYSICS)
    self:PhysicsInit(SOLID_BBOX)
    self:SetHullType(HULL_HUMAN)
    self:SetHullSizeNormal()
    self:SetNPCState(NPC_STATE_SCRIPT)
    self:CapabilitiesAdd(CAP_ANIMATEDFACE)
    self:CapabilitiesAdd(CAP_TURN_HEAD)
    self:SetUseType(SIMPLE_USE)
    self:DropToFloor()

    if not self.notInitialSpawn then
        self.vendorUID = os.time()
    end

    local TRIES = 0

    local function Randomize()
        if TRIES >= 50 then return end
        TRIES = TRIES + 1

        timer.Simple(0, function()
            if IsValid(self) then
                -- Set a random stance/sequence
                local sequences = {
                    "idle_all_01",
                    "idle_all_02",
                    "pose_standing_01",
                    "pose_standing_02"
                }
                
                self:ResetSequence(table.Random(sequences))

                -- Randomize skin if the model has multiple skins
                local COUNT = self:SkinCount()
                if COUNT > 0 then
                    local SKIN = math.random(0, COUNT - 1)
                    self:SetSkin(SKIN)
                end

                -- Randomize bodygroups if available
                for k, v in ipairs(self:GetBodyGroups()) do
                    if #v.submodels > 1 then
                        local randomBodygroup = math.random(0, #v.submodels - 1)
                        self:SetBodygroup(k, randomBodygroup)
                    end
                end
            else
                Randomize()
            end
        end)
    end

    Randomize()

    local phys = self:GetPhysicsObject()

    if phys:IsValid() then
        phys:Wake()
        phys:EnableMotion(false)
    end
end

function ENT:Use(activator)
    if not IsValid(activator) or not activator:IsPlayer() then return end
    
    -- Open LSCS menu for the player
    activator:ConCommand("lscs_openmenu")
end