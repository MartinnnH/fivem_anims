-- CROUCH
local dict = 'move_ped_crouched'
local crouched = false
local c = false

RegisterCommand('crouch', function()
	local ped = PlayerPedId()
	if not IsPedInAnyVehicle(ped, false) then
		c = true
		CreateThread(function()
			while c do
				Wait(0)
				ped = PlayerPedId()
				if not IsEntityDead(ped) then
					DisableControlAction(0, 26, true)
				end
			end
		end)
		if not IsEntityDead(ped) then
			if not IsPauseMenuActive() then
				if IsDisabledControlJustPressed(0, 26) then
					while not HasAnimSetLoaded(dict) do
						RequestAnimSet(dict)
						Wait(0)
					end
					if crouched then
						ResetPedMovementClipset(ped, 0)
						crouched = false
						Wait(1000)
						c = false
					else
						SetPedMovementClipset(ped, dict, 0.25)
						crouched = true
					end
				end
			end
		end
	end
end, false)

RegisterKeyMapping('crouch', Config.CrouchName, 'keyboard', Config.CrouchBind)
