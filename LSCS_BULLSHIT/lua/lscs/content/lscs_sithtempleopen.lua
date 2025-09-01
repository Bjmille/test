local force = {}
force.PrintName = "Open Temple"
force.Author = "Ported from WOS"
force.Description = "Open Temple Doors"
force.id = "opentemple" -- lowercase only
force.IconOverride = "wos/forceicons/open_temple.png" -- using original icon path

force.Equip = function( ply )
	-- Called when force power is equipped
end

force.UnEquip = function( ply )
	-- Called when force power is unequipped
end

force.StartUse = function( ply )
	-- Check if player has enough force points (35 required)
	if ply:lscsGetForce() < 35 then return end
	
	-- Check if we're on the correct map
	if game.GetMap() ~= "rp_imperial_mandalore" then return end
	
	-- Trace from player to see what they're looking at
	local tr = util.TraceLine(util.GetPlayerTrace(ply))
	
	-- Check if we hit a valid entity
	if not IsValid(tr.Entity) then return end
	
	-- Check if the entity is a door type
	local entityClass = tr.Entity:GetClass()
	if entityClass ~= "func_door" and entityClass ~= "prop_door_rotating" and entityClass ~= "func_door_rotating" then return end
	
	-- Check if it's the specific temple door
	if tr.Entity:GetName() ~= "sithtempledoor" then return end
	
	-- Take the required force points
	ply:lscsTakeForce( 35 )
	
	-- Play force use animation (equivalent to wOS force animation)
	LSCS:PlayVCDSequence( ply, "gesture_signal_halt", 0.5 )
	
	-- Unlock and open the door
	tr.Entity:Fire("unlock", "", 0)
	tr.Entity:Fire("Open", "", 0)
	
	-- Play a sound effect for the force power
	ply:EmitSound("npc/combine_gunship/ping_search.wav", 75, 100, 1.0)
	
	-- Optional: Add a brief delay before the power can be used again
	-- This is handled internally by LSCS force system
	
	return true
end

force.StopUse = function( ply )
	-- Called when the force power key is released
	-- No specific action needed for this power
end

-- Register the force power with LSCS
LSCS:RegisterForce( force )