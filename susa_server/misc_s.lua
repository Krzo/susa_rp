-- JOBS/HOUSES/CARS: Blips etc..

addEventHandler("onResourceStart",resourceRoot,
	function()
		-- ************************* RATHAUS *************************
		createBlip(-2762.1213378906, 375.85440063477, 5.5007591247559,56,3) -- Rathaus Blip
		local r = createMarker(-2764.7946777344, 375.89514160156,3.5007591247559, "cylinder",5,255,24,24,255,root) -- Rathaus Marker
		setElementID(r,"15")
		-- ************************* RATHAUS *************************
		-- ************************* WANG CARS ***********************
		local c = createPickup(-1968.54626, 293.75320, 35.17188,3,1274,500)
		createBlip(-1968.54626, 293.75320, 36.17188,55,3)
		setElementID(c,"16")
		-- ************************* WANG CARS ***********************
		-- ************************* TRANSFENDER *********************
		local t = createMarker(-1936.5153808594, 247.02676391602, 31.878150939941,"cylinder",3,255,24,24,255,root)--Transfender Tuning Shop
		createBlip( -1936.5153808594, 247.02676391602, 33.878150939941,27,3)
		setElementID(t,"17")
		-- ************************* LINE ****************************
		local l = createMarker(-2090.83545, 84.22278, 34.27200,"cylinder",3,255,24,24,255,root)
		createBlip( -2090.83545, 84.22278, 35.27200,42,3)
		setElementID(l,"18")
		-- ************************* RECYCLING ***********************
		local re = createMarker(-2135.15894, -248.15774, 34.42152,"cylinder",3,255,24,24,255,root)
		createBlip( -2135.15894, -248.32774, 35.92152,51,3)
		setElementID(re,"19")
		-- ************************* BUS ***********************
		local b = createMarker(-2048.12134, -210.88930, 32.96884,"cylinder",3,255,24,24,255,root)
		createBlip(-2048.12134, -210.88930, 34.96884,24,3)
		setElementID(b,"21")

	end
	)

	function syncTime()
		local realTime = getRealTime()
		local hour = realTime.hour
		local minute = realTime.minute
		setMinuteDuration ( 60000 )
		setTime( hour , minute )
	end
	setTimer ( syncTime, 500, 1 )
	setTimer ( syncTime, 3000000, 0 )
	function SyncTime2()
		setTimer ( syncTime, 4000, 1 )
	end
	addEventHandler ( "onResourceStart", getRootElement(), SyncTime2 )

	addEventHandler ( "onResourceStart", getResourceRootElement(getThisResource()),
     function()
        --[[createObject(11388, -2048.216796875, 166.73092651367, 34.468391418457, 0.000000, 0.000000, 0.000000,false) --
		createObject(11389, -2048.1174316406, 166.71966552734, 30.975694656372, 0.000000, 0.000000, 0.000000,false) --
		createObject(11390, -2048.1791992188, 166.76277160645, 32.235980987549, 0.000000, 0.000000, 0.000000,false) --
		createObject(11391, -2056.2062988281, 158.56985473633, 29.087089538574, 0.000000, 0.000000, 0.000000,false) --
		createObject(11392, -2047.8289794922, 167.54446411133, 27.835615158081, 0.000000, 0.000000, 0.000000,false) --
		createObject(11393, -2043.5166015625, 161.337890625, 29.320350646973, 0.000000, 0.000000, 0.000000,false) ---]]
		createObject(2893, -2050.9458007813, 171.15930175781, 29.112930297852, 7.9376220703125, 0.000000, 89.45068359375,false) --
		createObject(2893, -2050.9458007813, 169.32849121094, 29.112930297852, 7.9376220703125, 0.000000, 89.45068359375,false) ---
		createObject(2893, -2050.9458007813, 177.69999694824, 29.112930297852, 7.9376220703125, 0.000000, 89.45068359375,false) ---
		createObject(2893, -2050.9458007813, 179.59997558594, 29.112930297852, 7.9376220703125, 0.000000, 89.45068359375,false) ---
		createObject(2893, -2050.9458007813, 177.69999694824, 29.112930297852,343,0,270,false  )
		createObject(2893, -2050.9458007813, 179.59997558594, 29.112930297852,343,0,270,false  )
		local tune1 = createObject(2893, -2050.9458007813, 171.15930175781, 29.112930297852,343,0,270,false  )
		local tune2 = createObject(2893, -2050.9458007813, 169.32849121094, 29.112930297852,343,0,270,false  )

 		local tow = createVehicle(415, -2052.4907226563, 154.04287719727, 28.589487075806, 0, 0, 0, "YARRAK")
		addVehicleUpgrade ( tow, 1010 )
		setVehicleDamageProof( tow, true)
		setVehicleIdleRespawnDelay ( tow, 10000 )
		setVehicleLocked(tow,true)
		setGarageOpen(22,true)
		setGarageOpen(18,true)
     end
	)

	---------------------------------------------------------------------------------------------
	---------------------------------------------------------------------------------------------
	---------------------------------------------------------------------------------------------
	---------------------------------------------------------------------------------------------
	local leftkey = "n"
	local rightkey = "m"
	local bothkey = "k"
	---------------------------------------------------------------------------------------------
	---------------------------------------------------------------------------------------------
	---------------------------------------------------------------------------------------------
	---------------------------------------------------------------------------------------------

	local LightState1 = {0}
	local LightState2 = {0}

	local BlinkT = {}
	local BlinkS = {}

	function Blinker(thePlayer,mode)
		local vehicle = getPedOccupiedVehicle(thePlayer)
			if vehicle then
				if BlinkT[vehicle] then
					killTimer(BlinkT[vehicle])
					BlinkT[vehicle] = nil
					setVehicleLightState(vehicle,0,LightState1[vehicle])
					setVehicleLightState(vehicle,1,LightState2[vehicle])
					setVehicleLightState(vehicle,3,0)
					setVehicleLightState(vehicle,2,0)
					setVehicleOverrideLights(vehicle,0)
				else
					setVehicleOverrideLights(vehicle,2)
					setElementData(vehicle,"asd","asd")

					local a,b = getVehicleLightState(vehicle,0),getVehicleLightState(vehicle,1)
					LightState1[vehicle] = a
					LightState2[vehicle] = b

					if mode == leftkey then
						setVehicleLightState ( vehicle, 1, 1 )
						setVehicleLightState ( vehicle, 2, 1 )
						if a == 0 then
							BlinkT[vehicle] = setTimer(Blink,400,0,vehicle,1,0,3)
						elseif a == 1 then
							BlinkT[vehicle] = setTimer(Blink,400,0,vehicle,2,0,3)
						end
					elseif mode == rightkey then
						setVehicleLightState ( vehicle, 0, 1 )
						setVehicleLightState ( vehicle, 3, 1 )
						if b == 0 then
							BlinkT[vehicle] = setTimer(Blink,400,0,vehicle,1,1,2)
						elseif b == 1 then
							BlinkT[vehicle] = setTimer(Blink,400,0,vehicle,2,1,2)
						end
					elseif mode == bothkey then
							BlinkT[vehicle] = setTimer(Blink,400,0,vehicle,3,0,1)
					end
				end
			end
		end

	function Blink(vehicle,how,l1,l2)
			if vehicle then
				if getElementData(vehicle,"asd") then
					if not BlinkS[vehicle] and how == 1 then
						setVehicleLightState ( vehicle, l1, 1 )
						setVehicleLightState ( vehicle, l2, 1 )
						BlinkS[vehicle] = true
					elseif BlinkS[vehicle] and how == 1 then
						setVehicleLightState ( vehicle, l1, 0 )
						setVehicleLightState ( vehicle, l2, 0 )
						BlinkS[vehicle] = false
					elseif not BlinkS[vehicle] and how == 2 then
						setVehicleLightState ( vehicle, l2, 1 )
						BlinkS[vehicle] = true
					elseif BlinkS[vehicle] and how == 2 then
						setVehicleLightState ( vehicle, l2, 0 )
						BlinkS[vehicle] = false
					elseif not BlinkS[vehicle] and how == 3 then
						setVehicleLightState ( vehicle, 0, 1 )
						setVehicleLightState ( vehicle, 1, 1 )
						setVehicleLightState ( vehicle, 2, 1 )
						setVehicleLightState ( vehicle, 3, 1 )
						BlinkS[vehicle] = true
					elseif BlinkS[vehicle] and how == 3 then
						setVehicleLightState ( vehicle, 0, 0 )
						setVehicleLightState ( vehicle, 1, 0 )
						setVehicleLightState ( vehicle, 2, 0 )
						setVehicleLightState ( vehicle, 3, 0 )
						BlinkS[vehicle] = false
					end
				else
					killTimer(BlinkT[vehicle])
					BlinkT[vehicle] = nil
			end
		end
	end

	addEventHandler ( "onVehicleEnter", getRootElement(),
	function(thePlayer)
		bindKey ( thePlayer, leftkey, "down", Blinker, thePlayer, leftkey)
		bindKey ( thePlayer, rightkey, "down", Blinker, thePlayer, rightkey)
		bindKey ( thePlayer, bothkey, "down", Blinker, thePlayer, bothkey)
	end)

	addEventHandler ( "onVehicleExit", getRootElement(),
	function(thePlayer)
		unbindKey ( thePlayer, leftkey, "down", Blinker)
		unbindKey ( thePlayer, rightkey, "down", Blinker)
		unbindKey ( thePlayer, bothkey, "down", Blinker)
	end)
