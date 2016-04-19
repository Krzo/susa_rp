addEvent("StartJobTrash",true)
addEventHandler("StartJobTrash",root,
	function(plr)
		if source ~= client then end
		local trash = getElementData(plr,"susa:trash")
		local username = getElementData(plr,"username")
		if trash == 1 then
			local veh = createVehicle(408,-2103.07324,-200.06686 ,35,0,0,90,"SUSARECYCLING")
			outputChatBox("asdfsdf")
			setElementData(veh,"Owner",username)
			triggerClientEvent(plr,"DistanceTraveled",plr,plr,veh,-2103.07324,-200.06686,34)
			warpPedIntoVehicle(plr,veh)
		elseif trash == 0 then
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
