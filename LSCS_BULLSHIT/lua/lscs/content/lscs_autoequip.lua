-- Place this in lua/lscs/content/ as well
-- Wipe force powers on first join for clean slate
hook.Add("LSCS:OnPlayerFullySpawned", "WipeForceOnFirstJoin", function(ply)
    -- Clear all equipped force powers on spawn for clean slate
    if ply.lscsClearEquipped then
        ply:lscsClearEquipped("force", nil) -- Clear all force equipment
        ply:lscsBuildPlayerInfo() -- Rebuild player data
    end
end)

-- Give force powers only when switching TO allowed jobs
hook.Add("OnPlayerChangedTeam", "HandleForceOnJobChange", function(ply, oldTeam, newTeam)
    local allowedJobs = {
        [TEAM_IQA] = true,
        [TEAM_IQL] = true,
        [TEAM_IQFB] = true,
        [TEAM_IQSS] = true,
        [TEAM_IQGIQ] = true,
        [TEAM_IQDV] = true,
        [TEAM_IQCA] = true,
    }
    
    -- Define job-specific force powers (in addition to the universal ones)
    local jobSpecificPowers = {
        -- [TEAM_IQA] = {"",},
        [TEAM_IQL] = {"item_force_throw",},
        [TEAM_IQFB] = {"item_force_throw", "item_force_push", "item_force_pull"},
        [TEAM_IQSS] = {"item_force_kneeldown","item_force_throw", "item_force_push", "item_force_pull",},
        [TEAM_IQGIQ] = {"item_force_kneeldown","item_force_throw", "item_force_push", "item_force_pull",},
        [TEAM_IQDV] = {"item_force_kneeldown","item_force_throw", "item_force_push", "item_force_pull", "item_force_choke",},
        [TEAM_IQCA] = {"item_force_kneeldown","item_force_throw", "item_force_push", "item_force_pull", "item_force_choke", "item_force_sfrockthrow"},
    }
    
    -- If switching TO an allowed job, give the force powers
    if allowedJobs[newTeam] then
        timer.Simple(2, function()
            if IsValid(ply) and ply.lscsAddInventory then
                -- Clear existing force powers first
                ply:lscsClearEquipped("force", nil)
                
                -- Give universal force powers to EVERYONE in allowed jobs (auto-equip with true)
                ply:lscsAddInventory("item_force_jump", true)
                ply:lscsAddInventory("item_force_opentemple", true)
                
                -- Give job-specific powers
                local specificPowers = jobSpecificPowers[newTeam]
                if specificPowers then
                    for _, powerClass in pairs(specificPowers) do
                        ply:lscsAddInventory(powerClass, true) -- Auto-equip
                    end
                end
                
                -- Force rebuild of player info to sync everything
                ply:lscsBuildPlayerInfo()
                
                -- Build message about what they received
                local powerList = {"Jump", "Open Temple"}
                local specificPowers = jobSpecificPowers[newTeam]
                if specificPowers then
                    for _, powerClass in pairs(specificPowers) do
                        local powerName = string.sub(powerClass, 12) -- Remove "item_force_" prefix
                        powerName = string.upper(string.sub(powerName, 1, 1)) .. string.sub(powerName, 2) -- Capitalize
                        table.insert(powerList, powerName)
                    end
                end
                
                if ply.ChatPrint then
                    ply:ChatPrint("You have gained access to force powers: " .. table.concat(powerList, ", "))
                end
            end
        end)
    end
    
    -- If switching FROM an allowed job to non-allowed, remove ALL force powers
    if allowedJobs[oldTeam] and not allowedJobs[newTeam] then
        if ply.lscsGetInventory and ply.lscsRemoveItem then
            -- First unequip all force powers properly (this calls UnEquip functions)
            ply:lscsClearEquipped("force", nil)
            
            -- Then remove ALL force powers from inventory
            local inventory = ply:lscsGetInventory()
            local itemsToRemove = {}
            
            -- Find all force power items
            for id, class in pairs(inventory) do
                if string.StartWith(class, "item_force_") then
                    table.insert(itemsToRemove, id)
                end
            end
            
            -- Remove all found force power items
            for _, id in pairs(itemsToRemove) do
                ply:lscsRemoveItem(id)
            end
            
            -- Rebuild player data to sync changes
            ply:lscsBuildPlayerInfo()
            
            if ply.ChatPrint then
                ply:ChatPrint("You have lost access to all force powers.")
            end
        end
    end
end)