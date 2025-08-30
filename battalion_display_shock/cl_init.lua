include("shared.lua")
include("entities/battalion_display_base.lua")

function ENT:Initialize()
    self.battalionType = "shock"
    
    -- Shock Trooper color scheme (Red theme)
    self.hcolor = Color(80, 30, 30)
    self.bcolor = Color(40, 15, 15)
    self.htextcolor = Color(255, 100, 100)
    self.textcolor = Color(255, 200, 200)
    self.pagenum = Color(255, 150, 150)
    self.pcolor = Color(200, 50, 50)
    self.comcolor = Color(140, 60, 60)
    self.troopcolor = Color(160, 80, 80)
    self.hinttext = Color(255, 170, 170)
    self.era = false
    
    self.currentPage = self:GetNWInt("CurrentPage", 1)
    self.maxPages = self:GetNWInt("MaxPages", 3)
end

function ENT:Think()
    self.currentPage = self:GetNWInt("CurrentPage", 1)
    self.maxPages = self:GetNWInt("MaxPages", 3)
end