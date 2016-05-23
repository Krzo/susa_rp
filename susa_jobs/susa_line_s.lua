local taxi_marker = {}
local taxi_blip = {}
local taxi_vehicle = {}
local taxi_ped = {}
addEvent("StartJob",true)
addEventHandler("StartJob",root,
	function(plr,typ)
		if source ~= client then end
		local taxi,bus,trash = getElementData(plr,"susa:taxi"),getElementData(plr,"susa:bus"),getElementData(plr,"susa:trash")
		local username = getElementData(plr,"username")
		if taxi == 1 then
			outputChatBox("Welcome to your taxi drive. Please drive to the given destionation, you can find it on your map.",plr,0,180,0,false)
			taxi_vehicle[username] = createVehicle(420,-2082.5,66.2998046875,34,0,0,90,"SUSALINE")
			setElementData(taxi_vehicle[username],"Owner",username)
			warpPedIntoVehicle(plr,taxi_vehicle[username])
			startTaxi(plr)
		elseif taxi == 0 then
			outputChatBox("You didn't select this job. Please go to the town hall and select the taxi job.",plr,255,24,24,false)
		end
	end
)

function startTaxi(plr)
	local pname = getElementData(plr,"username")
	local job = math.random(1,3)
	local money = getPlayerMoney(plr)
	local skinid = math.random(9,29)
	taxi_ped[pname] = createPed(skinid,0,0,0)
	if job == 1 then
			taxi_marker[pname] = createMarker(-2618.25684, 1377.85107, 6.6627,"checkpoint",3,200,0,0)
			taxi_blip[pname] = createBlip(-2618.25684, 1377.85107, 6.6627,0,2,255,0,0)
			km = getDistanceBetweenPoints3D(-2618.25684, 1377.85107, 6.6627, -2458.697265625, 2223.4350585938,4.84375)
			price = math.floor(km*0.6) --60 cent / km
			warpPedIntoVehicle(taxi_ped[pname], taxi_vehicle[pname], 3)
	elseif job == 2 then
			taxi_marker[pname] = createMarker(-289.72549, -2173.98340, 28.13791,"checkpoint",3,200,0,0)
			taxi_blip[pname] = createBlip(-289.72549, -2173.98340, 28.13791,0,2,255,0,0)
			km = getDistanceBetweenPoints3D(-289.72549, -2173.98340, 28.13791, -2458.697265625, 2223.4350585938,4.84375)
			price = math.floor(km*0.6) --60 cent / km
			warpPedIntoVehicle(taxi_ped[pname], taxi_vehicle[pname], 2)
	elseif job == 3 then
			taxi_marker[pname] = createMarker(-289.72549, -2173.98340, 28.13791,"checkpoint",3,200,0,0)
			taxi_blip[pname] = createBlip(-289.72549, -2173.98340, 28.13791,0,2,255,0,0)
			km = getDistanceBetweenPoints3D(-289.72549, -2173.98340, 28.13791, -2458.697265625, 2223.4350585938,4.84375)
			price = math.floor(km*0.6) --60 cent / km
			warpPedIntoVehicle(taxi_ped[pname], taxi_vehicle[pname], 3)
	elseif job == 4 then
			taxi_marker[pname] = createMarker(334.16718, -1519.81006, 35.45603,"checkpoint",3,200,0,0)
			taxi_blip[pname] = createBlip(334.16718, -1519.81006, 35.45603,0,2,255,0,0)
			km = getDistanceBetweenPoints3D(334.16718, -1519.81006, 35.45603, -2458.697265625, 2223.4350585938,4.84375)
			price = math.floor(km*0.6) --60 cent / km
			warpPedIntoVehicle(taxi_ped[pname], taxi_vehicle[pname], 4)
	end

	setElementVisibleTo(taxi_marker[pname],getRootElement(),false)
	setElementVisibleTo(taxi_blip[pname],getRootElement(),false)
	setElementVisibleTo(taxi_marker[pname],plr,true)
	setElementVisibleTo(taxi_blip[pname],plr,true)
	addEventHandler("onMarkerHit",taxi_marker[pname],
		function(hitted)
			if hitted == plr then
				setPlayerMoney(plr,money+price)
				destroyElement(taxi_marker[pname])
				destroyElement(taxi_blip[pname])
				destroyElement(taxi_vehicle[pname])
				destroyElement(taxi_ped[pname])
				setTimer(setElementPosition,1000,1,plr,-2098.07153, 86.90060, 35.32031)
				outputChatBox("You successfully finished your job.You drove "..math.floor(km).." km. This means you get: "..price.."$ (60 cent/km)! ",plr,0,180,0,false)
				setElementData(plr,"startJob",false)
			end
	end)
	addEventHandler("onVehicleExit",taxi_vehicle[pname],
		function(plr,seat)
		if seat == 0 then
			setTimer(setElementPosition,50,1,plr,-2098.07153, 86.90060, 35.32031)
			setTimer(outputChatBox,50,1,"Your job has been canceled, you have been warped to the taxi base.",plr,255,24,24,false)
			setTimer(destroyElement,50,1,taxi_vehicle[pname])
			setTimer(destroyElement,50,1,taxi_marker[pname])
			setTimer(destroyElement,50,1,taxi_blip[pname])
			setTimer(destroyElement,50,1,taxi_ped[pname])
			setElementData(plr,"startJob",false)
		end
	end)
end
