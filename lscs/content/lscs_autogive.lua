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
    
    -- If switching TO an allowed job, give the force powers
    if allowedJobs[newTeam] then
        -- Use a longer delay and check if LSCS methods exist
        timer.Simple(2, function()
            if IsValid(ply) and ply.lscsAddInventory then
                -- Give multiple force powers
                ply:lscsAddInventory("item_force_opentemple", nil)
                ply:lscsAddInventory("item_force_jump", nil) -- Add force jump/leap
                
                if ply.ChatPrint then
                    ply:ChatPrint("You have gained access to Base Inquisitor force powers!")
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