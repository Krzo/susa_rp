local bus_vehicle = {}
local bus_marker = {}
local bus_blip = {}

addEvent("StartJobBus",true)
addEventHandler("StartJobBus",root,function(plr)
	local pname = getElementData(plr,"username")
	local money = getPlayerMoney(plr)
	local salary = 1950
	setElementData(plr,"startJob",true)
	setElementInterior(plr,0)
	local bus_job = math.random(1,4)
	bus_vehicle[pname] = createVehicle(431,-2021.69019, -140.13574, 35.30790,0,0,90,"SUSABUS")
	warpPedIntoVehicle(plr,bus_vehicle[pname])
	
	addEventHandler("onVehicleExit",bus_vehicle[pname],
		function()
			destroyElement(bus_vehicle[pname])
			destroyElement(bus_marker[pname])
			setVehicleDamageProof(bus_vehicle[pname],true)
			outputChatBox("You canceled the job.",plr,255,24,24,false)
			setElementPosition(plr,-2046.07593, -120.85522, 35.24471)
			outputDebugString(pname.."left the bus job.")
		end
	)
	outputChatBox("Deliver the tourists to the given position!",plr,0,180,0,false)
	if bus_job == 1 then
		bus_marker[pname] = createMarker(339.73578, -1527.47070, 33.40385,"checkpoint",3,200,0,0)
		bus_blip[pname] = createBlip(339.73578, -1527.47070, 33.40385,0,2,255,0,0)
		local km = getDistanceBetweenPoints3D(339.73578, -1527.47070, 33.40385, -2021.69019, -140.13574, 35.30790)
		price = math.floor(km)
	elseif bus_job == 2 then
		bus_marker[pname] = createMarker( 2038.48816, 1167.65759, 10.67188,"checkpoint",3,200,0,0)
		bus_blip[pname] = createBlip(2038.48816, 1167.65759, 10.67188,0,2,255,0,0)
		local km = getDistanceBetweenPoints3D(2038.48816, 1167.65759, 10.67188, -2021.69019, -140.13574, 35.30790)
		price = math.floor(km)
	elseif bus_job == 3 then
		bus_marker[pname] = createMarker(1721.05334, 1369.50415, 10.49994,"checkpoint",3,200,0,0)
		bus_blip[pname] = createBlip(1721.05334, 1369.50415, 10.49994,0,2,255,0,0)
		local km = getDistanceBetweenPoints3D(1721.05334, 1369.50415, 10.49994, -2021.69019, -140.13574, 35.30790)
		price = math.floor(km)
	elseif bus_job == 4 then
		bus_marker[pname] = createMarker(2772.47217, -1875.79456, 9.76361,"checkpoint",3,200,0,0)
		bus_blip[pname] = createBlip(2772.47217, -1875.79456, 9.76361,0,2,255,0,0)
		local km = getDistanceBetweenPoints3D(2772.47217, -1875.79456, 9.76361, -2021.69019, -140.13574, 35.30790)
		price = math.floor(km)
	end
	setElementVisibleTo(bus_marker[pname],getRootElement(),false)
	setElementVisibleTo(bus_blip[pname],getRootElement(),false)

	setElementVisibleTo(bus_marker[pname],plr,true)
	setElementVisibleTo(bus_blip[pname],plr,true)

	addEventHandler("onMarkerHit",bus_marker[pname],
		function(hitted)
			if hitted == plr then
				setPlayerMoney(plr,money+price)
				destroyElement(bus_marker[pname])
				destroyElement(bus_blip[pname])
				destroyElement(bus_vehicle[pname])
				setTimer(setElementPosition,1000,1,plr,-2046.07593, -120.85522, 35.24471)
				outputChatBox("You successfully finished the job.You get "..price.." $!",plr,0,180,0,false)
				setElementData(plr,"startJob",false)
			end
	end)
end)