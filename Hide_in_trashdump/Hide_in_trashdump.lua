RegisterCommand("Hide_in_trashdump", function()
	local ped = PlayerPedId()
	local small_trashdump = {684586828, 666561306, 218085040, 218085040, 4236481708, -58485588}
	local big_trashdump = {4088277111, 1511880420, 682791951, 2707782415}
	local biotoilet = 682074297
  local _, _, _, _, target = GetShapeTestResult(StartShapeTestRay(GetEntityCoords(ped),GetOffsetFromEntityInWorldCoords(ped, 0.0, 1.0, 0.0), 16, ped, 0))
	
	local small_trashdump_anim_set_by_index = {
		[0] = {
					 {vector3(0.0, -1.0, 1.0), vector3(0.0, 0.0, 0.0)}, 
					 {vector3(0.0, 0.5, 1.0), vector3(45.0, 0.0, 180.0)}, 
					 {vector3(0.0, -0.3, 0.5), vector3(0.0, 0.0, 180.0)}
					}, 
		{'anim@heists@load_box', 'load_box_1'},
		{'veh@plane@velum@front@ds@enter_exit', 'climb_up'},
		{'move_duck_for_cover', 'loop'},
		{'anim@veh@apc@ps@enter_exit_common', 'get_out'}
	}
	local big_trashdump_anim_set_by_index = {
		[0] = {
					 {vector3(0.0, -1.5, 1.0), vector3(0.0, 0.0, 0.0)}, 
					 {vector3(0.0, 0.0, 1.0), vector3(0.0, 0.0, 180.0)}, 
					 {vector3(0.0, -0.6, 1.0), vector3(0.0, 0.0, 180.0)}
					}, 
		{'anim@heists@load_box', 'load_box_1'},
		{'anim@veh@apc@ds@enter_exit_front', 'climb_up'},
		{'anim@veh@armordillo@turret@idle_duck', 'sit'},
		{'anim@veh@apc@ps@enter_exit_common', 'get_out'}
	}
	local biotoilet_anim_set_by_index = {
		[0] = {
					 {vector3(0.5, -1.0, 1.0), vector3(0.0, 0.0, 0.0)}, 
					 {vector3(0.0, 0.0, 1.0), vector3(0.0, 0.0, 180.0)}, 
					 {vector3(0.5, -1.0, 1.0), vector3(0.0, 0.0, 180.0)}
					}, 
		{'veh@van@ds@enter_exit', 'd_open_out'},
		{},
		{},
		{'veh@van@rds_rear@enter_exit', 'd_close_out'}
	}

	function has_value (tab, val)
		for index, value in ipairs(tab) do
			if value == val then
					return true
			end
		end
		
		return false
	end

	if not has_value(small_trashdump, GetEntityModel(target)) and not has_value(big_trashdump, GetEntityModel(target)) and GetEntityModel(target) ~= biotoilet then _, _, _, _, target = GetShapeTestResult(StartShapeTestRay(GetOffsetFromEntityInWorldCoords(ped, 0.0, 1.0, 0.0),GetEntityCoords(ped), 16, ped, 0))	end
	if not has_value(small_trashdump, GetEntityModel(target)) and not has_value(big_trashdump, GetEntityModel(target)) and GetEntityModel(target) ~= biotoilet then return end
	
	local anim_set
	if has_value(small_trashdump, GetEntityModel(target)) then anim_set = small_trashdump_anim_set_by_index end
	if has_value(big_trashdump, GetEntityModel(target)) then anim_set = big_trashdump_anim_set_by_index end
	if target == biotoilet then anim_set = biotoilet_anim_set_by_index end

	if not IsEntityAttachedToEntity(ped, target) then ------------------------------Get in
		if GetEntityModel(target) ~= biotoilet then
			for j = 1, 3, 1 do
				RequestAnimDict(anim_set[j][1])
			end

			for j = 1, 3, 1 do
				local i = 1
				RequestAnimDict(anim_set[j][1])
				while not HasAnimDictLoaded(anim_set[j][1]) and i < 30 do
					i = i + 1
					Citizen.Wait(100)
				end	
				if not HasAnimDictLoaded(anim_set[j][1]) then return end
			end
			
			--DisableCamCollisionForObject(target)
			AttachEntityToEntity(ped, target, 0, anim_set[0][1][1], anim_set[0][1][2], 0, 1, 0, 1, 1, 1)
 			DetachEntity(ped, 1, 1)
			
			TaskPlayAnim(ped, anim_set[1][1], anim_set[1][2], 8.0, 8.0, 1111, 512, 0.0)

			Citizen.Wait(1111)
			
			TaskPlayAnim(ped, anim_set[2][1], anim_set[2][2], 8.0, 8.0, 1600, 512, 0.0)

			Citizen.Wait(1600)

			AttachEntityToEntity(ped, target, 0, anim_set[0][2][1], anim_set[0][2][2], 0, 0, 0, 1, 1, 1)

			TaskPlayAnim(ped, anim_set[3][1], anim_set[3][2], 8.0, 8.0, -1, 1, 0.0)
			for j = 1, 3 do
				RemoveAnimDict(anim_set[j][1])
			end

			do return end
		else
			for j = 1, 2 do
				RequestAnimDict(anim_set[j][1])
			end

			for j = 1, 2 do
				local i = 1
				RequestAnimDict(anim_set[j][1])
				while not HasAnimDictLoaded(anim_set[j][1]) and i < 30 do
					i = i + 1
					Citizen.Wait(100)
				end
				if not HasAnimDictLoaded(anim_set[j][1]) then return end
			end
			
			AttachEntityToEntity(ped, target, 0, anim_set[0][1][1], anim_set[0][1][2], 0, 1, 1, 1, 1, 1)
 			DetachEntity(ped, 1, 1)

			TaskPlayAnim(ped, anim_set[1][1], anim_set[1][2], 8.0, 8.0, -1, 512, 0.0)
			Citizen.Wait(1111)
			
			AttachEntityToEntity(ped, target, 0, anim_set[0][2][1], anim_set[0][2][2], 0, 0, 1, 1, 1, 1)

			for j = 1, 2 do
				RemoveAnimDict(anim_set[j][1])
			end
			
			do return end
		end
	end
 
	if IsEntityAttachedToEntity(ped, target) then -------------------------------Get out
		local i = 1
		RequestAnimDict(anim_set[4][1])
		while not HasAnimDictLoaded(anim_set[4][1]) and i < 30 do
			i = i + 1
			Citizen.Wait(100)
		end
		if not HasAnimDictLoaded(anim_set[4][1]) then return end

		AttachEntityToEntity(ped, target, 0, anim_set[0][3][1], anim_set[0][3][2], 0, 1, 1, 1, 1, 1)

		TaskPlayAnim(ped, anim_set[4][1], anim_set[4][2], 8.0, 8.0, -1, 512, 0.0)
		
		DisableCamCollisionForEntity(target)
		Citizen.Wait(1111)

		DetachEntity(ped, 1, 1)

		RemoveAnimDict(anim_set[4][1])
	end
end)

RegisterCommand("Check_trashdump", function()
	local ped = PlayerPedId()
	local small_trashdump = {684586828, 666561306, 218085040, 218085040, 4236481708, -58485588}
	local big_trashdump = {4088277111, 1511880420, 682791951, 2707782415}
	local biotoilet = 682074297
  local _, _, _, _, target = GetShapeTestResult(StartShapeTestRay(GetEntityCoords(ped),GetOffsetFromEntityInWorldCoords(ped, 0.0, 1.0, 0.0), 16, ped, 0))

	local small_trashdump_anim_set_by_index = {
		[0] = {{vector3(0.0, -1.0, 1.0), vector3(0.0, 0.0, 0.0)}}, 
		{'anim@heists@load_box', 'load_box_1'}
	}
	local big_trashdump_anim_set_by_index = {
		[0] = {{vector3(0.0, -1.5, 1.0), vector3(0.0, 0.0, 0.0)}}, 
		{'anim@heists@load_box', 'load_box_1'}
	}
	local biotoilet_anim_set_by_index = {
		[0] = {{vector3(0.5, -1.0, 1.0), vector3(0.0, 0.0, 0.0)}}, 
		{'veh@van@ds@enter_exit', 'd_open_out'}
	}
	
	function has_value (tab, val)
		for index, value in ipairs(tab) do
			if value == val then
					return true
			end
		end
		
		return false
	end

	if not has_value(small_trashdump, GetEntityModel(target)) and not has_value(big_trashdump, GetEntityModel(target)) and GetEntityModel(target) ~= biotoilet then _, _, _, _, target = GetShapeTestResult(StartShapeTestRay(GetOffsetFromEntityInWorldCoords(ped, 0.0, 1.0, 0.0),GetEntityCoords(ped), 16, ped, 0))	end
	if not has_value(small_trashdump, GetEntityModel(target)) and not has_value(big_trashdump, GetEntityModel(target)) and GetEntityModel(target) ~= biotoilet then return end
	
	local anim_set
	if has_value(small_trashdump, GetEntityModel(target)) then anim_set = small_trashdump_anim_set_by_index end
	if has_value(big_trashdump, GetEntityModel(target)) then anim_set = big_trashdump_anim_set_by_index end
	if target == biotoilet then anim_set = biotoilet_anim_set_by_index end
	
	local i = 1
	RequestAnimDict(anim_set[1][1])
	while not HasAnimDictLoaded(anim_set[1][1]) and i < 30 do
		i = i + 1
		Citizen.Wait(100)
	end
	if not HasAnimDictLoaded(anim_set[1][1]) then return end
	
	AttachEntityToEntity(ped, target, 0, anim_set[0][1][1], anim_set[0][1][2], 0, 1, 0, 1, 1, 1)
	DetachEntity(ped, 1, 1)
	
	TaskPlayAnim(ped, anim_set[1][1], anim_set[1][2], 8.0, 8.0, 1111, 512, 0.0)
	Citizen.Wait(1111)
	ClearPedTasks(ped)

	if GetEntityAttachedTo(target) ~= 0 then
		print("Somebody in")
	else
		print("Empty")
	end

	DetachEntity(ped, 1, 1)
	RemoveAnimDict(anim_set[1][1])
end)
