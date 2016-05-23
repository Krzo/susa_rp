function replaceModel()
  txd = engineLoadTXD("susa_data/wheels/J2_wheels.txd", 1082 )
  engineImportTXD(txd, 1082)

  dff = engineLoadDFF("susa_data/wheels/wheel_gn1.dff", 1082 )
  engineReplaceModel(dff, 1082)

  dff = engineLoadDFF("susa_data/wheels/wheel_gn2.dff", 1085 )
  engineReplaceModel(dff, 1085)

  dff = engineLoadDFF("susa_data/wheels/wheel_gn3.dff", 1096 )
  engineReplaceModel(dff, 1096)

  dff = engineLoadDFF("susa_data/wheels/wheel_gn4.dff", 1097 )
  engineReplaceModel(dff, 1097)

  dff = engineLoadDFF("susa_data/wheels/wheel_gn5.dff", 1098 )
  engineReplaceModel(dff, 1098)

  dff = engineLoadDFF("susa_data/wheels/wheel_sr1.dff", 1079 )
  engineReplaceModel(dff, 1079)

  dff = engineLoadDFF("susa_data/wheels/wheel_sr2.dff", 1075 )
  engineReplaceModel(dff, 1075)

  dff = engineLoadDFF("susa_data/wheels/wheel_sr3.dff", 1074 )
  engineReplaceModel(dff, 1074)

  dff = engineLoadDFF("susa_data/wheels/wheel_sr4.dff", 1081 )
  engineReplaceModel(dff, 1081)

  dff = engineLoadDFF("susa_data/wheels/wheel_sr5.dff", 1080 )
  engineReplaceModel(dff, 1080)

  dff = engineLoadDFF("susa_data/wheels/wheel_sr6.dff", 1073 )
  engineReplaceModel(dff, 1073)

  dff = engineLoadDFF("susa_data/wheels/wheel_lr1.dff", 1077 )
  engineReplaceModel(dff, 1077)

  dff = engineLoadDFF("susa_data/wheels/wheel_lr2.dff", 1083 )
  engineReplaceModel(dff, 1083)

  dff = engineLoadDFF("susa_data/wheels/wheel_lr3.dff", 1078 )
  engineReplaceModel(dff, 1078)

  dff = engineLoadDFF("susa_data/wheels/wheel_lr4.dff", 1076 )
  engineReplaceModel(dff, 1076)

  dff = engineLoadDFF("susa_data/wheels/wheel_lr5.dff", 1084 )
  engineReplaceModel(dff, 1084)

  dff = engineLoadDFF("susa_data/wheels/wheel_or1.dff", 1025 )
  engineReplaceModel(dff, 1025)

end
addEventHandler ( "onClientResourceStart", getResourceRootElement(getThisResource()), replaceModel)

addCommandHandler ( "reloadwheel", replaceModel )


function replaceModel()
   local txd = engineLoadTXD ( "susa_data/sfgarage/oldgarage_sfse.txd")
   engineImportTXD ( txd, 11387 )

   local txd = engineLoadTXD ( "susa_data/sfgarage/oldgarage_sfse.txd")
   engineImportTXD ( txd, 11326 )

   local txd = engineLoadTXD ( "susa_data/sfgarage/hubint1_sfse.txd")
   engineImportTXD ( txd, 11389 )
 end
 addEventHandler ( "onClientResourceStart", getResourceRootElement(getThisResource()),
     function()
         replaceModel()
         setTimer (replaceModel, 1000, 1)
         bindKey( "vehicle_fire", "both", toggleNOS );
         bindKey( "vehicle_secondary_fire", "both", toggleNOS );
     end
)

addEventHandler("onClientClick",root,
	function()
		if isCursorShowing() then
			playSoundFrontEnd(38)
		end
	end
)

function toggleNOS( key, state )
	local veh = getPedOccupiedVehicle( localPlayer );
	if veh and not isEditingPosition then
		if state == "up" then
			removeVehicleUpgrade( veh, 1010 );
			setControlState( "vehicle_fire", false );
		else
			addVehicleUpgrade( veh, 1010 );
		end
	end
end

-- cruise control
	limit = true
	key = "c"
	allowedTypes = { "Automobile", "Bike", "Boat", "Train" }

	function getElementSpeed(element,unit)
		if (unit == nil) then unit = 0 end
		if (isElement(element)) then
			local x,y,z = getElementVelocity(element)
			if (unit=="mph" or unit==1 or unit =='1') then
				return (x^2 + y^2 + z^2) ^ 0.5 * 100
			else
				return (x^2 + y^2 + z^2) ^ 0.5 * 1.61 * 100
			end
		else
			outputDebugString("Not an element. Can't get speed")
			return false
		end
	end

	function setElementSpeed(element, unit, speed) -- only work if element is moving!
		if (unit == nil) then unit = 0 end
		if (speed == nil) then speed = 0 end
		speed = tonumber(speed)
		local acSpeed = getElementSpeed(element, unit)
		if (acSpeed~=false) then -- if true - element is valid, no need to check again
			local diff = speed/acSpeed
			local x,y,z = getElementVelocity(element)
			setElementVelocity(element,x*diff,y*diff,z*diff)
			return true
		else
			return false
		end
	end

	function in_array(e, t)
		for _,v in pairs(t) do
			if (v==e) then return true end
		end
		return false
	end

	function round2(num, idp)
	  return tonumber(string.format("%." .. (idp or 0) .. "f", num))
	end


	function angle(vehicle)
		local vx,vy,vz = getElementVelocity(vehicle)
		local modV = math.sqrt(vx*vx + vy*vy)

		if not isVehicleOnGround(vehicle) then return 0,modV end

		local rx,ry,rz = getElementRotation(vehicle)
		local sn,cs = -math.sin(math.rad(rz)), math.cos(math.rad(rz))
		local cosX = (sn*vx + cs*vy)/modV
		return math.deg(math.acos(cosX))*0.5, modV
	end

	lp = getLocalPlayer()
	ccEnabled = false

	myveh = false
	targetSpeed = 1
	multiplier = 1

	function cc()
		if (not isElement(myveh)) then
			removeEventHandler("onClientRender", getRootElement(), cc)
			ccEnabled=false
			outputChatBox("#ff1818SUSA-DRIVE#ffffff: Cruise Control #ff1818DISABLED", 255,255,255,true)
			return false
		end
		local x,y = angle(myveh)
		-- outputChatBox(x)
		if (x<15) then
			local speed = getElementSpeed(myveh)
			local targetSpeedTmp = speed + multiplier
			if (targetSpeedTmp > targetSpeed) then
				targetSpeedTmp = targetSpeed
			end
			if (targetSpeedTmp > 3) then
				setElementSpeed(myveh, "k", targetSpeedTmp)
			end
		end
	end

	bindKey(key, "up", function()
		local veh = getPedOccupiedVehicle(lp)
		if (veh) then
			if (lp==getVehicleOccupant(veh)) then
				myveh = veh
				if (ccEnabled) then
					removeEventHandler("onClientRender", getRootElement(), cc)
					ccEnabled=false
					outputChatBox("#ff1818SUSA-DRIVE#ffffff: Cruise Control #ff1818DISABLED", 255,255,255,true)
				else
					targetSpeed = getElementSpeed(veh)
					if targetSpeed > 4 then
						if (limit) then
							if in_array(getVehicleType(veh), allowedTypes) then
								targetSpeed = round2(targetSpeed)
								outputChatBox("#ff1818SUSA-DRIVE#ffffff: Cruise Control #00b400ENABLED at #ffffff"..targetSpeed.."km/h", 255,255,255,true)
								addEventHandler("onClientRender", getRootElement(), cc)
								ccEnabled=true
							end
						else
							targetSpeed = round2(targetSpeed)
							outputChatBox("#ff1818SUSA-DRIVE#ffffff: Cruise Control #00b400ENABLED at #ffffff"..targetSpeed.."km/h", 255,255,255,true)
							addEventHandler("onClientRender", getRootElement(), cc)
							ccEnabled=true
						end
					end
				end
			end
		end
	end)

	addEventHandler("onClientPlayerVehicleExit", getLocalPlayer(), function(veh, seat)
		if (seat==0) then
			if (ccEnabled) then
				removeEventHandler("onClientRender", getRootElement(), cc)
				ccEnabled=false
				outputChatBox("#ff1818SUSA-DRIVE#ffffff: Cruise Control #ff1818DISABLED", 255,255,255,true)
			end
		end
	end)
