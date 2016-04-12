--addEvent("onClientHydraulics",true)
--addEvent("onClientSpoiler",true)
addEvent("onTuningJoin",true)
addEvent("onTuningLeave",true)
addEvent("onTuningPartSelected",true)
addEvent("onTuningPartsRemove",true)
local dimension = 6000
local tuneinterior = {
	{6959, -2060.5, 446.39999, 138.8},
	{6959, -2076.1001, 446, 138.8, 0, 90, 0},
	{6959, -2059.3994, 428.7998, 138.8, 0, 90, 270},
	{1080, -2076.1001, 433.20001, 141.5 },
	{1078, -2072.8999, 428.89999, 142.7, 0, 0, 90},
	{14826, -2073.3999, 433.29999, 139.5, 0, 0, 287.478}
}

addEventHandler("onTuningJoin",root,
	function(plr,veh)
		setElementDimension(plr,dimension)
		setElementDimension(veh,dimension)
		setTimer(setElementFrozen,5000,1,veh,true)
		setTimer(setElementHealth,5000,1,veh,1000)
		setElementFrozen(plr,true)
		setElementPosition(veh, -2069.1520996094, 434.58093261719, 141.32582092285)
		setElementRotation(veh, -0.32335954904556, 0.0089773759245872, 24.630849838257,"ZYX")
		toggleAllControls(plr,false,false,false)
		toggleControl(plr,"enter_exit",false) -- so the player can't exit the player when hes in the tuning shop
		setVehicleEngineState(veh,false)
		for i,v in ipairs(tuneinterior) do
			local id,x,y,z,rx,ry,rz = unpack(tuneinterior[i])
			local obj = createObject(id,x,y,z,rx,ry,rz)
			setElementDimension(obj,dimension)
		end
		dimension = dimension + 1
	end
)
addEventHandler("onTuningLeave",root,
	function(plr,veh)
		setElementDimension(veh,0)
		setElementFrozen(veh,false)
		setElementFrozen(plr,false)
		setElementDimension(plr,0)
		toggleControl(plr,"enter_exit",true)
		toggleAllControls(plr,true,true,true)
		setVehicleEngineState(veh,true)
		setElementPosition(veh, -1958.4428710938, 221.25570678711, 32.252658843994)
		setElementRotation(veh, 7.4617896080017, -4.2971258163452, 87.149810791016)
		setElementAlpha(veh,100)
		setTimer(setElementAlpha,5000,1,veh,255)
	end
)

addEventHandler("onTuningPartSelected",root,
	function(plr,veh,id,price)
		if client ~= source then return end
		local money = getPlayerMoney(plr)
		local upgr = getVehicleUpgrades(veh)
		for k,v in ipairs(upgr) do
			if veh and id ~= nil or id ~= 0 and id ~= v then
				addVehicleUpgrade(veh,id)
				setPlayerMoney(plr,money-price)
			elseif veh and id ~= nil or i~= 0 and id == v then
				removeVehicleUpgrade(veh,id)
			end
		end
		outputChatBox(price,plr)
	end
)

addEventHandler("onTuningPartsRemove",root,
	function(plr,veh,id,price)
		if client ~= source then return end
		local money = getPlayerMoney(plr)
		if veh and id ~= nil or id ~= 0 then
			removeVehicleUpgrade(veh,id)
			setPlayerMoney(plr,money+price)
		end
	end
)

addEventHandler("saveTuningParts",root,
	function()
	end
)
--[[addEventHandler("onClientHydraulics",root,
	function(plr,veh)
		if client ~= source then return end
		if veh then
			local hydr = getVehicleUpgradeOnSlot(veh,9) -- 9 = Hydraulics
			--outputConsole(hydr)
			if hydr == 1087 then
				outputChatBox("You already had hydraulics. Removed hydraulics now.",plr,255,24,24,false)
				removeVehicleUpgrade(veh,1087)
			elseif hydr ~= 1087 then
				addVehicleUpgrade(veh,1087)
				outputChatBox("You succesfully upgraded your car. You now have: #ffffffhydraulics.",plr,0,180,0,true)
			end
		end
	end
)
addEventHandler("onClientSpoiler",root,
	function(plr,veh)
		if client ~= source then return end
		if veh then
			local spoiler = getVehicleUpgradeOnSlot(veh,2) -- 2 = Spoiler
			if spoiler then end
		end
	end
)--]]
