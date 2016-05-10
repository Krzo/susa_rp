local taxi_marker = {}
local taxi_blip = {}
local taxi_vehicle = {}
addEvent("StartJob",true)
addEventHandler("StartJob",root,
	function(plr,typ)
		if source ~= client then end
		local taxi,bus,trash = getElementData(plr,"susa:taxi"),getElementData(plr,"susa:bus"),getElementData(plr,"susa:trash")
		local username = getElementData(plr,"username")
		if taxi == 1 then
			local taxi_vehicle = createVehicle(420,-2082.5,66.2998046875,34,0,0,90,"SUSALINE")
			setElementData(taxi_vehicle,"Owner",username)
			warpPedIntoVehicle(plr,taxi_vehicle)
			startTaxi(plr)
		elseif taxi == 0 then
			outputChatBox("You didn't select this job. Please go to the town hall and select the taxi job.",plr,255,24,24,false)
		end
	end
)

function startTaxi(plr)
	local pname = getElementData(plr,"username")
	local job = math.random(1,4)
	if job == 1 then
			trucker_marker[pname] = createMarker(-2618.25684, 1377.85107, 6.6627,"checkpoint",3,200,0,0)
			trucker_blip[pname] = createBlip(-2618.25684, 1377.85107, 6.6627,0,2,255,0,0)
	end
end
