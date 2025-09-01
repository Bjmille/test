-- Modified inventory saver that doesn't persist dropped items
-- This file goes to: lua/lscs/content

if CLIENT then return end -- all this is serverside only.

local meta = FindMetaTable( "Player" )

local NumberToEquippedEntry = {
	[0] = true,
	[1] = false,
	[-1] = nil, -- just for looks, doesnt actually do anything
}

-- Track dropped items per player to exclude them from saving
local DroppedItems = {}

function meta:lscsWriteInventory()
	local ID = self:AccountID()

	if not ID then return end

	local inv = self:lscsGetInventory()
	local eq = self:lscsGetEquipped()

	local data = ""

	-- Get list of dropped items for this player
	local dropped = DroppedItems[ID] or {}

	for index, item in pairs( inv ) do
		-- Skip dropped items when saving
		if not dropped[index] then
			data = data..tostring( index ).."="..tostring( item )..","
		end
	end

	data = data .."#"

	for index, equipped in pairs( eq ) do
		-- Skip dropped items when saving equipped state
		if not dropped[index] then
			local eq_string

			if equipped == true then
				eq_string = "0" -- equipped right hand

			elseif equipped == false then
				eq_string = "1" -- equipped left hand

			else
				eq_string = "-1" -- unequipped
			end

			data = data..tostring( index ).."="..eq_string..","
		end
	end

	if not file.Exists( "lscs", "DATA" ) then
		file.CreateDir( "lscs" )
	end

	if not file.Exists( "lscs/"..ID, "DATA" ) then
		file.CreateDir( "lscs/"..ID )
	end

	file.Write( "lscs/"..ID.."/inventory.txt", data )
end

function meta:lscsReadInventory()
	local ID = self:AccountID()

	if not ID then return end

	if not file.Exists( "lscs/"..ID, "DATA" ) then return end

	local file_data = file.Read( "lscs/"..ID.."/inventory.txt", "DATA" )

	if not file_data then return end -- can this fail? i dont know...  probably yes.

	local data = string.Explode( "#", file_data )

	local inventory_string = data[1]
	local equipped_string = data[2]

	local inventory = {}
	local equipped = {}

	if inventory_string and inventory_string ~= "" then
		for _, entry in pairs( string.Explode( ",", inventory_string ) ) do
			local item_piece = string.Explode( "=", entry ) 
			local index = tonumber( item_piece[1] )
	
			if not index then continue end

			inventory[ index ] = item_piece[ 2 ]
		end
	end

	if equipped_string and equipped_string ~= "" then
		for _, entry in pairs( string.Explode( ",", equipped_string ) ) do
			local item_piece = string.Explode( "=", entry ) 
			local index = tonumber( item_piece[1] )

			if not index then continue end

			equipped[ index ] = NumberToEquippedEntry[ tonumber( item_piece[ 2 ] ) ]
		end
	end

	self:lscsWipeInventory() -- clear original inventory

	for index, item in pairs( inventory ) do
		self:lscsAddInventory( item, equipped[ index ] )
	end

	-- Clear dropped items tracking for this player on spawn
	DroppedItems[ID] = nil
end

-- Track when items are added to inventory (don't save on every add)
hook.Add( "LSCS:PostPlayerInventory", "!!!lscs_inventory_saver", function( ply, item, index )
	if not IsValid( ply ) then return end

	-- Only save inventory, don't track as dropped
	ply:lscsWriteInventory()
end )

-- Modified: Track dropped items and don't save them
hook.Add( "LSCS:OnPlayerDroppedItem", "!!!lscs_inventory_saver", function( ply, item_entity )
	if not IsValid( ply ) then return end
	
	local ID = ply:AccountID()
	if not ID then return end

	-- Initialize dropped items table for this player if needed
	if not DroppedItems[ID] then
		DroppedItems[ID] = {}
	end

	-- Find the inventory index of the dropped item
	local inv = ply:lscsGetInventory()
	for index, item_class in pairs( inv ) do
		if item_entity:GetClass() == item_class then
			-- Mark this inventory slot as dropped
			DroppedItems[ID][index] = true
			break
		end
	end

	-- Save inventory without the dropped item
	ply:lscsWriteInventory()
end )

hook.Add( "LSCS:OnPlayerEquippedItem", "!!!lscs_inventory_saver", function( ply, item )
	ply:lscsWriteInventory()
end)

hook.Add( "LSCS:OnPlayerUnEquippedItem", "!!!lscs_inventory_saver", function( ply, item )
	ply:lscsWriteInventory()
end)

hook.Add( "PlayerInitialSpawn", "!!!lscs_inventory_saver", function( ply )
	-- ply:Give("weapon_lscs") -- shouldn't be needed
	ply:lscsReadInventory()
end )

-- Clear dropped items tracking when player disconnects to prevent memory leaks
hook.Add( "PlayerDisconnected", "!!!lscs_inventory_saver_cleanup", function( ply )
	local ID = ply:AccountID()
	if ID then
		DroppedItems[ID] = nil
	end
end )

--[[
-- alternative to playerinitialspawn hook above:
hook.Add( "LSCS:OnPlayerFullySpawned", "!!!lscs_inventory_saver", function( ply )
	-- ply:Give("weapon_lscs") -- shouldn't be needed
	ply:lscsReadInventory()
	ply:lscsCraftSaber()
end )
]]

-- more info about inventory saving:
-- https://github.com/SpaxscE/lscs_templates_and_info/blob/main/how_to_save_and_restore_inventory.lua

 -- for more functions and info see:
 -- https://github.com/SpaxscE/lscs_templates_and_info/blob/main/useful_lua_functions.lua