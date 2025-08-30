include("shared.lua")
include("entities/battalion_display_base.lua")

function ENT:Initialize()
    self.battalionType = "navy"
    
    -- Imperial Navy color scheme (Teal/Ocean theme)
    self.hcolor = Color(30, 60, 80)
    self.bcolor = Color(15, 30, 40)
    self.htextcolor = Color(100, 200, 255)
    self.textcolor = Color(180, 220, 255)
    self.pagenum = Color(150, 200, 255)
    self.pcolor = Color(50, 150, 200)
    self.comcolor = Color(60, 120, 140)
    self.troopcolor = Color(80, 140, 160)
    self.hinttext = Color(170, 210, 255)
    self.era = false
    
    self.currentPage = self:GetNWInt("CurrentPage", 1)
    self.maxPages = self:GetNWInt("MaxPages", 3)
end

function ENT:Think()
    self.currentPage = self:GetNWInt("CurrentPage", 1)
    self.maxPages = self:GetNWInt("MaxPages", 3)
end