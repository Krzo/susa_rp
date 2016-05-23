local root = getRootElement()
local thisResourceRoot = getResourceRootElement(getThisResource())
local drift_records = {}
--local drift_record_number = 0
--local drift_record_player = "N/A"



-- Drift Ranks
function updatelvl()
    local players = getElementsByType ( "player" )
    for theKey,thePlayer in ipairs(players) do
        totaldrift = tonumber(getElementData(thePlayer, "Drift Score" ))
        if totaldrift < 99000 then
        setElementData(thePlayer, "Drift Rank", "Newbie" )
        elseif totaldrift > 100000 and totaldrift < 500000 then
        setElementData(thePlayer, "Drift Rank", "Trained" )
        elseif totaldrift > 500000 and totaldrift < 1000000 then
        setElementData(thePlayer, "Drift Rank", "Drifter" )
        elseif totaldrift > 1000000 and totaldrift < 5000000 then
        setElementData(thePlayer, "Drift Rank", "Adv. Drifter" )
        elseif totaldrift > 5000000 and totaldrift < 25000000 then
        setElementData(thePlayer, "Drift Rank", "Best Drifter" )
        elseif totaldrift > 25000000 and totaldrift < 50000000 then
        setElementData(thePlayer, "Drift Rank", "Drift Expert" )
        elseif totaldrift > 50000000 and totaldrift < 100000000 then
        setElementData(thePlayer, "Drift Rank", "Drift King" )
        elseif totaldrift > 100000000 and totaldrift < 250000000 then
        setElementData(thePlayer, "Drift Rank", "Drift Master" )
		elseif totaldrift > 250000000 and totaldrift < 500000000 then
        setElementData(thePlayer, "Drift Rank", "Drift Legend" )
        elseif totaldrift > 500000000 then
        setElementData(thePlayer, "Drift Rank", "Drift Elite" )
        end
 end
end
setTimer( updatelvl, 10000, 0 )


addEventHandler ( "onResourceStart", thisResourceRoot,
	function()
		addEvent("driftClienteListo", true)
		addEventHandler("driftClienteListo", root, function(player)
			triggerClientEvent(player, "driftActualizarRecord", root, drift_record_number, drift_record_player)
		end)
	end
)


addEventHandler("onVehicleDamage", root, function()
	thePlayer = getVehicleOccupant(source, 0)
	if thePlayer then
		triggerClientEvent(thePlayer, "driftCarCrashed", root, source)
	end
end)

-- saving / Load
