addEvent("StartJob",true)
addEventHandler("StartJob",root,
	function(plr)
		if source ~= client then end
		local taxi,bus,trash = getElementData(plr,"susa:taxi"),getElementData(plr,"susa:bus"),getElementData(plr,"susa:trash")
		local username = getElementData(plr,"username")
		if taxi == 1 then
			local veh = createVehicle(420,-2082.5,66.2998046875,34,0,0,90,"SUSALINE")
			setElementData(veh,"Owner",username)
			triggerClientEvent(plr,"startDistanceCounter",plr,veh,-2082.5,66.2998046875,34)
			warpPedIntoVehicle(plr,veh)
		elseif taxi == 0 then
			outputChatBox("You didn't select this job. Please go to the town hall and select the taxi job.",plr,255,24,24,false)
		elseif bus == 1 then
			local veh = createVehicle(431,-2080.89331, 61.22795, 33.76588,0,0,90,"SUSABUS")
			setElementData(veh,"Owner",username)
			getDistanceTraveled(veh,-2080.89331, 61.22795, 33.76588)
			warpPedIntoVehicle(plr,veh)
		elseif bus == 0 then
			outputChatBox("You didn't select this job. Please go to the town hall and select the bus job.",plr,255,24,24,false)
		end
	end
)

--[[
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
