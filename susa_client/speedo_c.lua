local sx, sy = guiGetScreenSize()
local w,h = 350,350
local s = 1.05
local x, y = sx/s-w/s,sy/s-h/s
local dxSet = {}
local alpha = 0
-- useful
function getVehicleRPM(vehicle)
	if not vehicle then return "0" end
	local currentGearSpeed
	if getVehicleEngineState(vehicle) == false then return "0" end
	local speedx, speedy, speedz = getElementVelocity(vehicle)
	local actualspeed = (speedx^2 + speedy^2 + speedz^2)^(0.5)
	local kmh = actualspeed * 180
	local gear = getVehicleCurrentGear(vehicle)
	local handling = getVehicleHandling(vehicle)
	local acceleration = handling["engineAcceleration"]
	local maxSpeed = handling["maxVelocity"]
	local gears = handling["numberOfGears"]
	local gearSpeed = maxSpeed/gears
	local currentGearSpeed = 0
	if not (gear == 0) then
		currentGearSpeed = kmh/gear
	end
	local gearDiff = gearSpeed - currentGearSpeed
	if currentGearSpeed > gearSpeed then gearDiff = 1 end
	local RPM = math.ceil( (maxSpeed/gearDiff)*100)*3
	return RPM
end

function getElementSpeed(element,unit)
	if (unit == nil) then unit = 0 end
	if (isElement(element)) then
		local x,y,z = getElementVelocity(element)
		if (unit=="mph" or unit==1 or unit =='1') then
			return (x^2 + y^2 + z^2) ^ 0.5 * 100
		else
			return (x^2 + y^2 + z^2) ^ 0.5 * 1.8 * 100
		end
	else
		outputDebugString("Not an element. Can't get speed")
		return false
	end
end

-- draw
function drawSpeedo()
	local veh = getPedOccupiedVehicle(localPlayer)
	if veh then
		local vehSpeed = getElementSpeed(veh, "kph")
		local vehRPM = getVehicleRPM(veh)
		local vehFuel = getElementData(veh, "fuel") or 100
		alpha = alpha + 10
		if alpha >= 254 then
			alpha = 255
		end
		dxDrawImage(x, y, 350, 350, "susa_data/speedo.png", 0, 0, 0, tocolor(255, 255, 255, alpha), false)
		dxDrawImage(x+27, y+76, 293, 243, "susa_data/nadel.png", vehSpeed, 0, 0, tocolor(255, 255, 255, alpha), false) -- speed
		dxDrawImage(x+149, y+5, 189, 184, "susa_data/nadel.png", 90+vehRPM/100, 0, 0, tocolor(255, 255, 255, alpha), false) -- rpm
	end
end

addEventHandler("onClientVehicleEnter", root,
	function(p)
	if p == localPlayer then
		addEventHandler("onClientRender", root, drawSpeedo)
	end
end)

addEventHandler("onClientVehicleStartExit", root, function(p)
	if p == localPlayer then
		removeEventHandler("onClientRender", root, drawSpeedo)
	end
end)
