include("shared.lua")
include("battalion_display_base.lua")

function ENT:Initialize()
    self.battalionType = "isb"
    
    -- ISB color scheme (Black/White Intelligence theme)
    self.hcolor = Color(20, 20, 20)
    self.bcolor = Color(10, 10, 10)
    self.htextcolor = Color(255, 255, 255)
    self.textcolor = Color(220, 220, 220)
    self.pagenum = Color(180, 180, 180)
    self.pcolor = Color(255, 200, 50)
    self.comcolor = Color(60, 60, 60)
    self.troopcolor = Color(80, 80, 80)
    self.hinttext = Color(200, 200, 200)
    self.era = false
    
    self.currentPage = self:GetNWInt("CurrentPage", 1)
    self.maxPages = self:GetNWInt("MaxPages", 3)
end

function ENT:Think()
    self.currentPage = self:GetNWInt("CurrentPage", 1)
    self.maxPages = self:GetNWInt("MaxPages", 3)
end