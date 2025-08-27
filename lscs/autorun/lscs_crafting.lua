local meta = FindMetaTable( "Player" )

if SERVER then
	util.AddNetworkString( "lscs_craft_saber" )

	function meta:lscsCraftSaber( dont_mess_with_pickup_notifications )
		local HiltR, HiltL = self:lscsGetHilt()
		local BladeR, BladeL = self:lscsGetBlade()

		-- Check if player has weapon from DarkRP job first, but don't require it for the hook
		local SWEP = self:GetWeapon( "weapon_lscs" )
		local OldBP
		local weapon = nil

		if IsValid( SWEP ) then
			-- Player has the weapon, update it completely like the original system
			OldBP = SWEP:GetBlockPoints()
			
			-- Strip and re-give to ensure clean state, but only if they already have it
			self:StripWeapon( "weapon_lscs" )
			
			if not dont_mess_with_pickup_notifications then self:SetSuppressPickupNotices( true ) end
			self:Give("weapon_lscs")
			if not dont_mess_with_pickup_notifications then self:SetSuppressPickupNotices( false) end
			
			self:SelectWeapon( "weapon_lscs" )
			
			weapon = self:GetWeapon( "weapon_lscs" )
			
			if IsValid( weapon ) then
				weapon:SetHiltR( HiltR or "" )
				weapon:SetHiltL( HiltL or "" )

				if HiltR and HiltR ~= "" then
					weapon:SetBladeR( BladeR or "" )
				end
				if HiltL and HiltL ~= "" then
					weapon:SetBladeL( BladeL or "" )
				end

				if OldBP then weapon:SetBlockPoints( OldBP ) end
			end
			
			self:EmitSound("lscs/equip.mp3")
		end

		-- Always run the hook regardless of whether they have the weapon
		-- This ensures inventory saving and other systems still work
		hook.Run( "LSCS:OnPlayerCraftedSaber", self, weapon )
	end

	net.Receive( "lscs_craft_saber", function( len, ply )
		ply:lscsCraftSaber()
	end )
else
	function meta:lscsCraftSaber()
		net.Start( "lscs_craft_saber" )
		net.SendToServer()
	end
end