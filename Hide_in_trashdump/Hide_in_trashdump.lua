player = GetPlayerPed(-1)

function GetPlayerLookingVector(playerped, radius)
	local yaw = GetEntityHeading(playerped)
	local pitch = 90.0-GetGameplayCamRelativePitch()

	if yaw > 180 then
		yaw = yaw - 360
	elseif yaw < -180 then
		yaw = yaw + 360
	end

	local pitch = pitch * math.pi / 180
	local yaw = yaw * math.pi / 180
	local x = radius * math.sin(pitch) * math.sin(yaw)
	local y = radius * math.sin(pitch) * math.cos(yaw)
	local z = radius * math.cos(pitch)

	local playerpedcoords = GetEntityCoords(playerped)
	local xcorr = -x+ playerpedcoords.x
	local ycorr = y+ playerpedcoords.y
	local zcorr = z+ playerpedcoords.z
	local Vector = vector3(tonumber(xcorr), tonumber(ycorr), tonumber(zcorr))
	return Vector
end

small = {684586828, 666561306, 218085040, 218085040, 4236481708}
big = {4088277111, 1511880420, 682791951, 2707782415}
function has_value (tab, val)
  for index, value in ipairs(tab) do
      if value == val then
          return true
      end
    end
    
    return false
  end
  
function GetPedInDirection(coordFrom, coordTo)
  local rayHandle = StartShapeTestRay(coordFrom.x, coordFrom.y, coordFrom.z, coordTo.x, coordTo.y, coordTo.z, 16, GetPlayerPed(-1), 0)
  local _,flag_PedHit,PedCoords,_,PedHit = GetShapeTestResult(rayHandle)
  return flag_PedHit, PedCoords, PedHit
end


------------------------------------------------------------------------------------------------
function get_in_1(bin)
    
  RequestAnimDict('anim@heists@load_box')
  RequestAnimDict('veh@plane@velum@front@ds@enter_exit')
  RequestAnimDict('move_duck_for_cover')
  RequestAnimDict('anim@veh@apc@ps@enter_exit_common')

  if not HasAnimDictLoaded('anim@veh@apc@ps@enter_exit_common') and not HasAnimDictLoaded('anim@heists@load_box') and not HasAnimDictLoaded('veh@plane@velum@front@ds@enter_exit') and not HasAnimDictLoaded('move_duck_for_cover') then
    Citizen.Wait(1)
  end

  DisableCamCollisionForEntity(bin)

  AttachEntityToEntity(player, bin, 0, 0.0, -1.0, 1.0, 0.0, 0.0, 0.0, 0, 1, 0, 1, 1, 1)

  DetachEntity(player, 1, 1)

  TaskPlayAnim(player, 'anim@heists@load_box', 'load_box_1', 8.0, 8.0, -1, 512, 0.0)

  Citizen.Wait(1111)

  TaskPlayAnim(player, 'veh@plane@velum@front@ds@enter_exit', 'climb_up', 8.0, 8.0, -1, 512, 0.0)

  Citizen.Wait(1600)

  AttachEntityToEntity(player, bin, 0, 0.0, 0.5, 1.0, 45.0, 0.0, 180.0, 0, 1, 0, 1, 1, 1)

  TaskPlayAnim(player, 'move_duck_for_cover', 'loop', 8.0, 8.0, -1, 1, 0.0)

end

function get_out_1(bin)

  AttachEntityToEntity(player, bin, 0, 0.0, -0.3, 0.5, 0.0, 0.0, 180.0, 0, 1, 0, 1, 1, 1)

  TaskPlayAnim(player, 'anim@veh@apc@ps@enter_exit_common', 'get_out', 8.0, 8.0, -1, 512, 0.0)
  
  DisableCamCollisionForEntity(bin)

  Citizen.Wait(1111)

  DetachEntity(player, 1, 1)

  RemoveAnimDict('anim@heists@load_box')
  RemoveAnimDict('veh@plane@velum@front@ds@enter_exit')
  RemoveAnimDict('move_duck_for_cover')
  RemoveAnimDict('anim@veh@apc@ps@enter_exit_common')
end
------------------------------------------------------------------------------------------------
function get_in_2(bin)

  RequestAnimDict('anim@heists@load_box')
  RequestAnimDict('anim@veh@apc@ds@enter_exit_front')
  RequestAnimDict('anim@veh@armordillo@turret@idle_duck')
  RequestAnimDict('anim@veh@apc@ps@enter_exit_common')

  if not HasAnimDictLoaded('anim@veh@apc@ps@enter_exit_common') and not HasAnimDictLoaded('anim@heists@load_box') and not HasAnimDictLoaded('anim@veh@apc@ds@enter_exit_front') and not HasAnimDictLoaded('anim@veh@armordillo@turret@idle_duck') then
    Citizen.Wait(1)
  end

  AttachEntityToEntity(player, bin, 0, 0.0, -1.5, 1.0, 0.0, 0.0, 0.0, 0, 1, 0, 1, 1, 1)

  DetachEntity(player, 1, 1)

  TaskPlayAnim(player, 'anim@heists@load_box', 'load_box_1', 8.0, 8.0, -1, 512, 0.0)
  
  Citizen.Wait(1111)
  
  TaskPlayAnim(player, 'anim@veh@apc@ds@enter_exit_front', 'climb_up', 8.0, 8.0, -1, 512, 0.0)
  
  Citizen.Wait(1600)
  
  AttachEntityToEntity(player, bin, 0, 0.0, 0.0, 1.0, 0.0, 0.0, 180.0, 0, 1, 0, 1, 1, 1)
  
  TaskPlayAnim(player, 'anim@veh@armordillo@turret@idle_duck', 'sit', 8.0, 8.0, -1, 1, 0.0)
end

function get_out_2(bin)

  DisableCamCollisionForEntity(bin)

  AttachEntityToEntity(player, bin, 0, 0.0, -0.6, 1.0, 0.0, 0.0, 180.0, 0, 1, 0, 1, 1, 1)

  TaskPlayAnim(player, 'anim@veh@apc@ps@enter_exit_common', 'get_out', 8.0, 8.0, -1, 512, 0.0)

  DisableCamCollisionForEntity(bin)

  Citizen.Wait(1111)

  DetachEntity(player, 1, 1)

  RemoveAnimDict('anim@heists@load_box')
  RemoveAnimDict('anim@veh@apc@ds@enter_exit_front')
  RemoveAnimDict('anim@veh@armordillo@turret@idle_duck')
  RemoveAnimDict('anim@veh@apc@ps@enter_exit_common')

end
------------------------------------------------------------------------------------------------
function get_in_3(bin)

  RequestAnimDict('veh@van@ds@enter_exit')
  RequestAnimDict('veh@van@rds_rear@enter_exit')

  if not HasAnimDictLoaded('veh@van@ds@enter_exit') and not HasAnimDictLoaded('anim@heists@load_box') then
    Citizen.Wait(1)
  end

  AttachEntityToEntity(player, bin, 0, 0.5, -1.0, 1.0, 0.0, 0.0, 0.0, 0, 1, 0, 1, 1, 1)

  DetachEntity(player, 1, 1)

  TaskPlayAnim(player, 'veh@van@ds@enter_exit', 'd_open_out', 8.0, 8.0, -1, 512, 0.0)
  
  Citizen.Wait(1111)
  
  AttachEntityToEntity(player, bin, 0, 0.0, 0.0, 1.0, 0.0, 0.0, 180.0, 0, 0, 1, 1, 1, 1)

  RemoveAnimDict('veh@van@ds@enter_exit')
end

function get_out_3(bin)

  AttachEntityToEntity(player, bin, 0, 0.5, -1.0, 1.0, 0.0, 0.0, 180.0, 0, 1, 0, 1, 1, 1)

  TaskPlayAnim(player, 'veh@van@rds_rear@enter_exit', 'd_close_out', 8.0, 8.0, -1, 512, 0.0)

  Citizen.Wait(1111)

  DetachEntity(player, 1, 1)

  RemoveAnimDict('veh@van@ds@enter_exit')
  RemoveAnimDict('veh@van@rds_rear@enter_exit')


end
------------------------------------------------------------------------------------------------

Citizen.CreateThread(function()
  while true do
    
    if IsControlJustReleased(1, 288) then -------------- F1
      flag_PedHit, PedCoords, target = GetPedInDirection(GetEntityCoords(player), GetPlayerLookingVector(player, 5))
      
      if IsEntityAttachedToEntity(player, target) == false then
        DisableCamCollisionForEntity(target)
        if has_value (small, GetEntityModel(target)) then
          get_in_1(target)
        elseif has_value (big, GetEntityModel(target)) then
          get_in_2(target)
        elseif GetEntityModel(target) == 682074297 then
          get_in_3(target)
        end
      end
    end

    if IsControlJustReleased(1, 289) then -------------- F2
      target = GetEntityAttachedTo(player)
      if IsEntityAttachedToEntity(player, target) == 1 then
        if has_value (small, GetEntityModel(target)) then
          get_out_1(target)
        elseif has_value (big, GetEntityModel(target)) then
          get_out_2(target)
        elseif GetEntityModel(target) == 682074297 then
          get_out_3(target)
        end
      end
    end
    
    if IsControlJustReleased(1, 170) then -------------- F3
      flag_PedHit, PedCoords, target = GetPedInDirection(GetEntityCoords(player), GetPlayerLookingVector(player, 1))
      if has_value (small, GetEntityModel(target)) or has_value (big, GetEntityModel(target)) or GetEntityModel(target) == 682074297 then
        
        if has_value (small, GetEntityModel(target)) then
          AttachEntityToEntity(player, target, 0, 0.0, -1.0, 1.0, 0.0, 0.0, 0.0, 0, 1, 0, 1, 1, 1)
          anim_dict = 'anim@heists@load_box'
          anim_clip = 'load_box_1'
        elseif has_value (big, GetEntityModel(target)) then
          AttachEntityToEntity(player, target, 0, 0.0, -1.5, 1.0, 0.0, 0.0, 0.0, 0, 1, 0, 1, 1, 1)
          anim_dict = 'anim@heists@load_box'
          anim_clip = 'load_box_1'
        elseif GetEntityModel(target) == 682074297 then
          AttachEntityToEntity(player, target, 0, 0.5, -1.0, 1.0, 0.0, 0.0, 0.0, 0, 1, 0, 1, 1, 1)
          anim_dict = 'veh@van@ds@enter_exit'
          anim_clip = 'd_open_out'
        end

        RequestAnimDict(anim_dict)

        if not HasAnimDictLoaded(anim_dict) then
          Citizen.Wait(1)
        end

        TaskPlayAnim(player, anim_dict, anim_clip, 8.0, 8.0, -1, 512, 0.0)
        Citizen.Wait(1111)
        ClearPedTasks(player)
        if GetEntityAttachedTo(target) ~= 0 then
          print("Somebody in")
        else
          print("Empty")
        end

        DetachEntity(player, 1, 1)
        RemoveAnimDict(anim_dict)
        end
    end
    
    Citizen.Wait(1)
  end
end)
