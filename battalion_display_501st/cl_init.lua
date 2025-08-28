include("shared.lua")
include("battalion_display_base.lua")

function ENT:Initialize()
    self.battalionType = "501st"
    
    -- 501st Legion color scheme (Blue theme)
    self.hcolor = Color(30, 50, 80)
    self.bcolor = Color(15, 25, 40)
    self.htextcolor = Color(100, 150, 255)
    self.textcolor = Color(200, 220, 255)
    self.pagenum = Color(150, 180, 255)
    self.pcolor = Color(50, 100, 200)
    self.comcolor = Color(60, 90, 140)
    self.troopcolor = Color(80, 110, 160)
    self.hinttext = Color(170, 190, 255)
    self.era = false
    
    self.currentPage = self:GetNWInt("CurrentPage", 1)
    self.maxPages = self:GetNWInt("MaxPages", 3)
end

function ENT:Think()
    self.currentPage = self:GetNWInt("CurrentPage", 1)
    self.maxPages = self:GetNWInt("MaxPages", 3)
end