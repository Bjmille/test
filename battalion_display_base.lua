local size = -750 / 2

function math.inrange(val, min, max)
    return val <= max and val >= min
end

local arrow_icon = Material("materials/shared/arrow.png")
local implogo_icon = Material("materials/shared/implogo.png")
local replogo_icon = Material("materials/shared/replogo.png")

surface.CreateFont("BATTALION:Main", {
	font = "Roboto",
	size = 35
})

surface.CreateFont("BATTALION:Title", {
	font = "Roboto",
	size = 65
})

surface.CreateFont("BATTALION:Subtitle", {
	font = "Roboto",
	size = 50
})

surface.CreateFont("BATTALION:Small", {
	font = "Roboto",
	size = 28
})

-- Battalion Data Structure
local battalions = {
    ["stormtrooper"] = {
        name = "Stormtrooper Corps",
        motto = "Precision. Loyalty. Victory.",
        description = "The backbone of the Imperial Army",
        pages = {
            {
                title = "Overview",
                content = {
                    "The Stormtrooper Corps represents the",
                    "elite soldiers of the Galactic Empire.",
                    "",
                    "Primary Duties:",
                    "• Planetary occupation and control",
                    "• Urban combat operations", 
                    "• Crowd control and civil enforcement",
                    "• Base security and patrol duties"
                }
            },
            {
                title = "Training & Equipment",
                content = {
                    "Rigorous training in:",
                    "• Advanced marksmanship",
                    "• Close quarters combat",
                    "• Vehicle operation",
                    "• Tactical communications",
                    "",
                    "Standard Equipment:",
                    "• E-11 Blaster Rifle",
                    "• Stormtrooper Armor",
                    "• Thermal Detonators"
                }
            },
            {
                title = "Chain of Command",
                content = {
                    "Command Structure:",
                    "",
                    "Stormtrooper Commander",
                    "    ↓",
                    "Stormtrooper Sergeant",
                    "    ↓", 
                    "Senior Trooper",
                    "    ↓",
                    "Stormtrooper"
                }
            }
        }
    },
    ["501st"] = {
        name = "501st Legion",
        motto = "Vader's Fist",
        description = "The most elite fighting force",
        pages = {
            {
                title = "Legion Overview",
                content = {
                    "The 501st Legion, known as 'Vader's Fist',",
                    "is the most elite unit in the Imperial Army.",
                    "",
                    "Special Operations:",
                    "• High-value target elimination",
                    "• Rebel stronghold assaults",
                    "• VIP protection missions",
                    "• Classified operations for Lord Vader"
                }
            },
            {
                title = "Elite Training",
                content = {
                    "Advanced Specializations:",
                    "• Exotic weapon systems",
                    "• Zero-G combat operations",
                    "• Stealth infiltration",
                    "• Counter-insurgency tactics",
                    "",
                    "Enhanced Equipment:",
                    "• Modified E-11s with scopes",
                    "• Reinforced armor plating",
                    "• Advanced comlink systems"
                }
            },
            {
                title = "Command Structure",
                content = {
                    "Legion Leadership:",
                    "",
                    "501st Commander",
                    "    ↓",
                    "501st Captain", 
                    "    ↓",
                    "501st Lieutenant",
                    "    ↓",
                    "501st Trooper"
                }
            }
        }
    },
    ["shock"] = {
        name = "Shock Troopers",
        motto = "Swift Justice. No Mercy.",
        description = "Elite security and enforcement",
        pages = {
            {
                title = "Unit Purpose",
                content = {
                    "Shock Troopers serve as the Empire's",
                    "premier security and enforcement unit.",
                    "",
                    "Core Responsibilities:",
                    "• Coruscant security operations",
                    "• High-profile prisoner transport",
                    "• Emergency response deployment",
                    "• Imperial facility protection"
                }
            },
            {
                title = "Specialized Training",
                content = {
                    "Combat Specializations:",
                    "• Riot suppression tactics",
                    "• Prisoner handling protocols",
                    "• Rapid deployment techniques",
                    "• Non-lethal subjugation methods",
                    "",
                    "Distinctive Gear:",
                    "• Red-marked armor",
                    "• Stun weapons",
                    "• Riot shields"
                }
            },
            {
                title = "Organization",
                content = {
                    "Command Hierarchy:",
                    "",
                    "Shock Commander",
                    "    ↓",
                    "Shock Sergeant",
                    "    ↓",
                    "Shock Corporal",
                    "    ↓", 
                    "Shock Trooper"
                }
            }
        }
    },
    ["supercommando"] = {
        name = "Imperial Super Commandos",
        motto = "Death from Above",
        description = "Elite Mandalorian warriors",
        pages = {
            {
                title = "Elite Warriors",
                content = {
                    "Imperial Super Commandos are elite",
                    "Mandalorian warriors serving the Empire.",
                    "",
                    "Specialized Missions:",
                    "• Deep reconnaissance operations", 
                    "• Sabotage and demolition",
                    "• Jetpack assault tactics",
                    "• Counter-Mandalorian operations"
                }
            },
            {
                title = "Mandalorian Heritage",
                content = {
                    "Unique Capabilities:",
                    "• Mandalorian armor expertise",
                    "• Jetpack combat proficiency",
                    "• Traditional weapons mastery",
                    "• Beskar armor maintenance",
                    "",
                    "Special Equipment:",
                    "• Custom Mandalorian armor",
                    "• Jetpack systems",
                    "• Vibro-weapons"
                }
            },
            {
                title = "Command Structure",
                content = {
                    "Leadership Ranks:",
                    "",
                    "Super Commando Commander",
                    "    ↓",
                    "Super Commando Captain",
                    "    ↓",
                    "Super Commando",
                    "    ↓",
                    "Commando Trainee"
                }
            }
        }
    },
    ["navy"] = {
        name = "Imperial Navy",
        motto = "Rule the Stars",
        description = "Masters of space warfare",
        pages = {
            {
                title = "Naval Operations",
                content = {
                    "The Imperial Navy dominates the galaxy",
                    "through superior space-based warfare.",
                    "",
                    "Primary Duties:",
                    "• Star Destroyer operations",
                    "• Fleet coordination and tactics",
                    "• Orbital bombardment support",
                    "• Hyperspace navigation"
                }
            },
            {
                title = "Naval Training",
                content = {
                    "Officer Specializations:",
                    "• Ship systems management",
                    "• Tactical analysis and planning",
                    "• Crew coordination",
                    "• Emergency protocols",
                    "",
                    "Equipment & Uniform:",
                    "• Naval officer uniform",
                    "• Code cylinders",
                    "• Rank insignia plaques"
                }
            },
            {
                title = "Naval Hierarchy",
                content = {
                    "Officer Ranks:",
                    "",
                    "Admiral",
                    "    ↓",
                    "Captain",
                    "    ↓",
                    "Commander",
                    "    ↓",
                    "Lieutenant"
                }
            }
        }
    },
    ["isb"] = {
        name = "Imperial Security Bureau",
        motto = "Knowledge is Power",
        description = "Intelligence and security operations",
        pages = {
            {
                title = "Intelligence Division",
                content = {
                    "The ISB serves as the Empire's primary",
                    "intelligence and internal security agency.",
                    "",
                    "Core Functions:",
                    "• Counter-intelligence operations",
                    "• Rebel activity monitoring",
                    "• Internal security investigations",
                    "• Information gathering and analysis"
                }
            },
            {
                title = "Agent Training",
                content = {
                    "Specialized Skills:",
                    "• Interrogation techniques",
                    "• Surveillance and observation",
                    "• Data analysis and reporting",
                    "• Undercover operations",
                    "",
                    "Standard Equipment:",
                    "• ISB uniform and insignia",
                    "• Encrypted communication devices",
                    "• Data recording equipment"
                }
            },
            {
                title = "ISB Structure",
                content = {
                    "Agency Hierarchy:",
                    "",
                    "ISB Colonel",
                    "    ↓",
                    "ISB Major",
                    "    ↓",
                    "ISB Agent",
                    "    ↓",
                    "ISB Operative"
                }
            }
        }
    }
}

function ENT:GetCurrentPage()
    return self:GetNWInt("CurrentPage", 1)
end

function ENT:GetMaxPages()
    return self:GetNWInt("MaxPages", 3)
end

function ENT:NextPage()
    if self.currentPage < self.maxPages then
        self.currentPage = self.currentPage + 1
        self:SetNWInt("CurrentPage", self.currentPage)
    end
end

function ENT:PrevPage()
    if self.currentPage > 1 then
        self.currentPage = self.currentPage - 1
        self:SetNWInt("CurrentPage", self.currentPage)
    end
end

function ENT:Use(activator, caller)
    if not IsValid(activator) or not activator:IsPlayer() then return end
    
    local trace = activator:GetEyeTrace()
    if trace.Entity != self then return end
    
    local cursor = self:WorldToLocal(trace.HitPos) * Vector(10, 10, 10)
    
    -- Left arrow (previous page)
    if math.inrange(cursor.y, -size - 64 - 64, -size) and math.inrange(cursor.x, -size - 64 - 64, -size) then
        self:PrevPage()
    end
    
    -- Right arrow (next page)
    if math.inrange(cursor.y, size, size + 64 + 64) and math.inrange(cursor.x, -size - 64 - 64, -size) then
        self:NextPage()
    end
end

function ENT:DrawPage()
    local battalion = battalions[self.battalionType]
    local page = battalion.pages[self.currentPage]
    
    if not page then return end
    
    -- Draw title
    draw.SimpleText(page.title, "BATTALION:Subtitle", 0, size + 90, self.htextcolor, 1, 1)
    
    -- Draw content
    local yOffset = -200
    for i, line in ipairs(page.content) do
        local font = "BATTALION:Main"
        local color = self.textcolor
        
        -- Check for special formatting
        if string.find(line, "•") then
            font = "BATTALION:Small"
        elseif line == "" then
            -- Skip empty lines but add spacing
            yOffset = yOffset + 25
            continue
        elseif string.find(line, ":") and not string.find(line, "•") then
            color = self.htextcolor
        end
        
        draw.SimpleText(line, font, 0, yOffset, color, 1, 1)
        yOffset = yOffset + (font == "BATTALION:Small" and 32 or 40)
    end
end

function ENT:Draw()
    -- Don't draw the model to make the baseplate invisible
    -- self:DrawModel()
    
    local trace = LocalPlayer():GetEyeTrace()
    if trace.Entity != self then return end
    
    local cursor = self:WorldToLocal(trace.HitPos) * Vector(10, 10, 10)
    local pos = self:LocalToWorld(Vector(0, 0, 2.5))
    local ang = self:LocalToWorldAngles(Angle(0, 90, 0))
    
    -- Distance check
    if LocalPlayer():GetPos():Distance(self:GetPos()) >= 500 then return end
    
    cam.Start3D2D(pos, ang, 0.1)
        -- Background - Make transparent
        draw.RoundedBox(0, -750 / 2, -750 / 2, 750, 80, Color(0, 0, 0, 0)) -- Transparent header
        draw.RoundedBox(0, -750 / 2, -620 / 2, 750, 700, Color(0, 0, 0, 0)) -- Transparent main background
        
        -- Battalion name and motto
        local battalion = battalions[self.battalionType]
        draw.SimpleText(battalion.name, "BATTALION:Title", 0, size + 20, self.htextcolor, 1, 1)
        draw.SimpleText(battalion.motto, "BATTALION:Small", 0, size + 80, self.pagenum, 1, 1)
        
        -- Navigation arrows
        if self.currentPage > 1 then
            if math.inrange(cursor.y, -size - 64 - 64, -size) and math.inrange(cursor.x, -size - 64 - 64, -size) then
                surface.SetDrawColor(self.pcolor)
            else
                surface.SetDrawColor(Color(255, 255, 255))
            end
            
            surface.SetMaterial(arrow_icon)
            surface.DrawTexturedRectRotated(-size - 64, -size - 64, 64, 64, 180)
        end
        
        if self.currentPage < self.maxPages then
            if math.inrange(cursor.y, size, size + 64 + 64) and math.inrange(cursor.x, -size - 64 - 64, -size) then
                surface.SetDrawColor(self.pcolor)
            else
                surface.SetDrawColor(Color(255, 255, 255))
            end
            
            surface.SetMaterial(arrow_icon)
            surface.DrawTexturedRectRotated(size + 64, -size - 64, 64, 64, 0)
        end
        
        -- Page counter
        draw.SimpleText("Page ".. self.currentPage.. " of ".. self.maxPages, "BATTALION:Small", 0, -size - 50, self.pagenum, 1, 1)
        
        -- Draw current page content
        self:DrawPage()
        
    cam.End3D2D()
    
    -- Logo
    cam.Start3D2D(pos, ang, 0.1)
        if self.era == true then
            surface.SetDrawColor(Color(255, 255, 255))
            surface.SetMaterial(replogo_icon)
            surface.DrawTexturedRectRotated(size + 50, -size - 720, 70, 70, 0)
        elseif self.era == false then
            surface.SetDrawColor(Color(255, 255, 255))
            surface.SetMaterial(implogo_icon)
            surface.DrawTexturedRectRotated(size + 50, -size - 720, 70, 70, 0)
        end
    cam.End3D2D()
end