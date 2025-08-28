include("shared.lua")
include("battalion_display_base.lua")

function ENT:Initialize()
    self.battalionType = "supercommando"
    
    -- Super Commando color scheme (Purple/Mandalorian theme)
    self.hcolor = Color(60, 30, 80)
    self.bcolor = Color(30, 15, 40)
    self.htextcolor = Color(180, 100, 255)
    self.textcolor = Color(220, 180, 255)
    self.pagenum = Color(200, 150, 255)
    self.pcolor = Color(150, 50, 200)
    self.comcolor = Color(100, 60, 140)
    self.troopcolor = Color(120, 80, 160)
    self.hinttext = Color(210, 170, 255)
    self.era = false
    
    self.currentPage = self:GetNWInt("CurrentPage", 1)
    self.maxPages = self:GetNWInt("MaxPages", 3)
end

function ENT:Think()
    self.currentPage = self:GetNWInt("CurrentPage", 1)
    self.maxPages = self:GetNWInt("MaxPages", 3)
end