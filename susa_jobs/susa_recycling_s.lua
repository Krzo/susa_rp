--[[addEvent("StartJobTrash",true)
addEventHandler("StartJobTrash",root,
	function(plr)
		local trash,startJob = getElementData(plr,"susa:trash"),getElementData(plr,"startJob")
		local username = getElementData(plr,"username")
		if not startJob == true then
			if trash == 1 then
				local veh = createVehicle(408,-2103.07324,-200.06686 ,35,0,0,90,"SUSARECYCLING")
				setElementData(veh,"Owner",username)
				setElementData(plr,"startJob",true)
				--triggerClientEvent(plr,"DistanceTraveled",plr,plr,veh,-2103.07324,-200.06686,34)
				setElementPosition(plr, -2106.49609, -204.58014, 35.32031)
				setElementRotation(plr,-0, 0, 354.7961730957)
				outputChatBox("Please enter your vehicle to start the job.")
			elseif trash == 0 then
				outputChatBox("You didn"t select this job. Please go to the town hall and select the bus job.",plr,255,24,24,false)
			end
		else
				outputChatBox("You already started this job.",plr,255,24,24,false)
		end
	end
)
function getDistanceTraveled ( veh, x1, y1, z1 )
	local veh = getPedOccupiedVehicle ( lp )
	if veh then
		if getPedOccupiedVehicleSeat ( lp ) == 0 then
			local x2, y2, z2 = getElementPosition ( veh )
			local nd = getDistanceBetweenPoints3D ( x1, y1, z1, x2, y2, z2 ) / 100
			KMDistance = KMDistance + nd
			setTimer ( getDistanceTraveled, 500, 1, veh, x2, y2, z2 )
			setElementData(veh,KMDistance)
		end
	end
end
]]
local trucker_vehicle = {}
local trucker_trailer = {}
local trucker_marker = {}
local trucker_blip = {}

addEvent("StartJobTrash",true)
addEventHandler("StartJobTrash",root,function(plr)
	local pname = getElementData(plr,"username")
	local money = getPlayerMoney(plr)
	local salary = 1950
	setElementData(plr,"startJob",true)
	setElementInterior(plr,0)
	local trucker_job = math.random(1,4)
	trucker_vehicle[pname] = createVehicle(515,-2124.294921875, -201.05187988281, 36.427909851074,0,0,90,"SUSATRUCK")
	warpPedIntoVehicle(plr,trucker_vehicle[pname])

	addEventHandler("onVehicleExit",trucker_vehicle[pname],
		function()
			destroyElement(trucker_vehicle[pname])
			destroyElement(trucker_marker[pname])
			setVehicleDamageProof(trucker_vehicle[pname],true)
			outputChatBox("You canceled the job.",plr,255,24,24,false)
			setElementPosition(plr,-2135.15894, -248.15774, 34.42152)
			outputDebugString(pname.."left the trucker job.")
		end
	)
	outputChatBox("Deliver the truck to the given position!",plr,0,180,0,false)
	if trucker_job == 1 then
		trucker_marker[pname] = createMarker(-2458.697265625, 2223.4350585938, 4.84375,"checkpoint",3,200,0,0)
		trucker_trailer[pname] = createVehicle(435,  -2108.5324707031, -201.33465576172, 36.43017578125, 0.39323854446411, -0.00042839589877985, 90, "SUSATRUCK")
		trucker_blip[pname] = createBlip(-2458.697265625, 2223.4350585938, 4.84375,0,2,255,0,0)
		attachTrailerToVehicle(trucker_vehicle[pname], trucker_trailer[pname])
		local km = getDistanceBetweenPoints3D(-2108.5324707031, -201.33465576172,36.43017578125, -2458.697265625, 2223.4350585938,4.84375)
		price = math.floor(km)
	elseif trucker_job == 2 then
		trucker_marker[pname] = createMarker( -1918.103515625, -1711.6270751953, 21.261976242065,"checkpoint",3,200,0,0)
		trucker_blip[pname] = createBlip(-1918.103515625, -1711.6270751953, 21.261976242065,0,2,255,0,0)
		trucker_trailer[pname] = createVehicle(584	,  -2108.5324707031, -201.33465576172, 36.43017578125, 0.39323854446411, -0.00042839589877985, 90, "SUSATRUCK")
		attachTrailerToVehicle(trucker_vehicle[pname], trucker_trailer[pname])
		local km = getDistanceBetweenPoints3D(-2108.5324707031, -201.33465576172,36.43017578125, -1918.103515625, -1711.6270751953, 21.261976242065)
		price = math.floor(km)
	elseif trucker_job == 3 then
		trucker_marker[pname] = createMarker(-181.32675170898, -277.97436523438, 0.89027327299118,"checkpoint",3,200,0,0)
		trucker_blip[pname] = createBlip(-181.32675170898, -277.97436523438, 0.89027327299118,0,2,255,0,0)
		trucker_trailer[pname] = createVehicle(450,  -2108.5324707031, -201.33465576172, 36.43017578125, 0.39323854446411, -0.00042839589877985, 90, "SUSATRUCK")
		attachTrailerToVehicle(trucker_vehicle[pname], trucker_trailer[pname])
		local km = getDistanceBetweenPoints3D(-2108.5324707031, -201.33465576172,36.43017578125, -181.32675170898, -277.97436523438, 0.89027327299118)
		price = math.floor(km)
	elseif trucker_job == 4 then
		trucker_marker[pname] = createMarker(-100.05390167236, 1109.0577392578, 19.7421875,"checkpoint",3,200,0,0)
		trucker_blip[pname] = createBlip(-100.05390167236, 1109.0577392578, 19.7421875,0,2,255,0,0)
		trucker_trailer[pname] = createVehicle(591,  -2108.5324707031, -201.33465576172, 36.43017578125, 0.39323854446411, -0.00042839589877985, 90, "SUSATRUCK")
		attachTrailerToVehicle(trucker_vehicle[pname], trucker_trailer[pname])
		local km = getDistanceBetweenPoints3D(-2108.5324707031, -201.33465576172,36.43017578125, -100.05390167236, 1109.0577392578, 19.7421875)
		price = math.floor(km)
	end
	setElementVisibleTo(trucker_marker[pname],getRootElement(),false)
	setElementVisibleTo(trucker_blip[pname],getRootElement(),false)

	setElementVisibleTo(trucker_marker[pname],plr,true)
	setElementVisibleTo(trucker_blip[pname],plr,true)

	addEventHandler("onMarkerHit",trucker_marker[pname],
		function(hitted)
			if hitted == plr then
				setPlayerMoney(plr,money+price)
				destroyElement(trucker_marker[pname])
				destroyElement(trucker_blip[pname])
				destroyElement(trucker_vehicle[pname])
				destroyElement(trucker_trailer[pname])
				setTimer(setElementPosition,1000,1,plr,-2129.3664550781, -237.04539489746, 38.3203125)
				outputChatBox("You successfully finished the job.You get "..price.." $!",plr,0,180,0,false)
				setElementData(plr,"startJob",false)
			end
	end)
	addEventHandler("onVehicleExit",trucker_marker[pname],
		function(plr,seat)
		if seat == 0 then
			setTimer(setElementPosition,50,1,plr,-2129.3664550781, -237.04539489746, 38.3203125)
			setTimer(outputChatBox,50,1,"Your job has been canceled, you have been warped to the taxi base.",plr,255,24,24,false)
			setTimer(destroyElement,50,1,trucker_marker[pname])
			setTimer(destroyElement,50,1,trucker_blip[pname])
			setTimer(destroyElement,50,1,trucker_vehicle[pname])
			setTimer(destroyElement,50,1,trucker_trailer[pname])
			setElementData(plr,"startJob",false)
		end
	end)
end)
