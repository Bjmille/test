include("shared.lua")
include("entities/battalion_display_base.lua")

function ENT:Initialize()
    self.battalionType = "stormtrooper"
    
    -- Stormtrooper color scheme (Gray/White theme)
    self.hcolor = Color(40, 40, 40)
    self.bcolor = Color(20, 20, 20)
    self.htextcolor = Color(255, 255, 255)
    self.textcolor = Color(200, 200, 200)
    self.pagenum = Color(150, 150, 150)
    self.pcolor = Color(100, 150, 255)
    self.comcolor = Color(80, 80, 80)
    self.troopcolor = Color(120, 120, 120)
    self.hinttext = Color(180, 180, 180)
    self.era = false
    
    self.currentPage = self:GetNWInt("CurrentPage", 1)
    self.maxPages = self:GetNWInt("MaxPages", 3)
end

function ENT:Think()
    self.currentPage = self:GetNWInt("CurrentPage", 1)
    self.maxPages = self:GetNWInt("MaxPages", 3)
end