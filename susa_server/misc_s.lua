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
		-- ************************* DrivingLicence ***********************
		local dl = createMarker(-2026.59656, -100.73959, 33.42152,"cylinder",3,255,24,24,255,root)
		createBlip( -2026.59656, -100.73959, 35.92152,24,3)
		setElementID(dl,"20")
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