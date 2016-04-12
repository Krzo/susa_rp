local db
addEventHandler("onResourceStart",resourceRoot,
	function()
		db = dbConnect("mysql","dbname=accounts;host=localhost","root","")
		if(db)then
			outputDebugString("Database: connected",3)
		else
			outputConsole("Database: not connected",1)
		end
	end
)

function spawnVehiclesFromDatabase()
        local sql = dbQuery(db, "SELECT * FROM cars")
        local result, num_rows = dbPoll(sql, -1)
        for _, row in pairs (result) do
                local spawnedVehicle = createVehicle(row["CARID"], row["SPAWNX"], row["SPAWNY"], row["SPAWNZ"], row["ROTX"], row["ROTY"], row["ROTZ"])
                setVehicleColor( spawnedVehicle, row["R"], row["G"], row["B"])
                setElementData( spawnedVehicle, "Owner", row["OWNER"] )
                setElementData( spawnedVehicle, "Price", row["PRICE"] )
                setElementData( spawnedVehicle, "CarKey", row["CARKEY"] )
                toggleVehicleRespawn( spawnedVehicle, true )
				setVehicleEngineState(spawnedVehicle,false)
                setVehicleIdleRespawnDelay( spawnedVehicle, 300*1000 )
                setVehicleRespawnDelay( spawnedVehicle, 1*1000 )
				setVehicleHandling(spawnedVehicle,"suspensionLowerLimit",-0.045)
				if (row["CARID"] == 560) then
					setVehicleHandling(spawnedVehicle,"suspensionLowerLimit",-0.01)
				end
				if (row["CARID"] == 560) then
					setVehicleHandling(spawnedVehicle,"suspensionLowerLimit",-0.01)
				end
        end
end
addEventHandler("onResourceStart", resourceRoot, spawnVehiclesFromDatabase)


addCommandHandler("sellmycar",
	function(player,cmd)
	if client ~= source then return end
	local pName = getElementData(player,"username")
	local money = getPlayerMoney(player)
	local sql = dbQuery(db,"SELECT * FROM cars WHERE OWNER=?",pName)
	local result, num_rows = dbPoll(sql, -1)
	if result then
		if num_rows >= 1 then
			price = result[1]["PRICE"]
			local sellprice = price * 0.40
			Delcar = dbExec(db,"DELETE FROM cars WHERE OWNER=?",pName )
		if Delcar then
			outputChatBox("You just sold your car for 40% of the original price: "..sellprice,player,0,180,0)
			setPlayerMoney(player,money+sellprice,false)
			for _, veh in pairs ( getElementsByType("vehicle") ) do 
				if(tostring(getElementData(veh, "Owner")) == tostring(pName)) then
					destroyElement(veh)
				end
			end
			else 
				outputDebugString(Delcar)
		end
		else 
			outputChatBox("Sie besitzen kein Auto",player, 255, 0,0)
	end
	end
end)

addEventHandler("onVehicleStartEnter",root,
	function(plr,seat,_,door)
		local d_licence = getElementData(plr,"susa:d_licence")
		local accname = getAccountName(getPlayerAccount(plr))
		local admin = isObjectInACLGroup ("user."..accname, aclGetGroup ( "Admin" ) )
		local username = getElementData(plr,"username")
		local owner = getElementData(source,"Owner")
		bindKey(plr,"x","down","engine")
		bindKey(plr,"l","down","light")
		if not admin then
			if d_licence == 1 and seat == 0 then
				if owner == false then
					outputChatBox("You can't drive this car.",plr,180,0,0,false)
					owner = "--"
				end
				if owner == username then
					outputChatBox("Press 'X' for Engine and 'L' for the Lights",plr,0,180,0,false)
				else
					cancelEvent()
					outputChatBox("This is not your car! This car belongs to: "..owner.." .If you already have one use /getmycar !",plr,180,0,0,false)
				end
			elseif seat ~= 0 and door ~= 0  then
				return true
			else
				cancelEvent()
				outputChatBox("You don't have the right licence for this vehicle.",plr,255,24,24)
			end
		end
	end
)

addEventHandler("onVehicleExit",root,
	function(p,seat)
		if seat == 0 then
			setVehicleEngineState(source,false)
		end
	end
)

addEvent("CarBuy",true)
local function CarBuyFunc(lp,veh,price,id)
	local username = getElementData(lp,"username") 
	local GetData = dbQuery(db,"SELECT * FROM cars WHERE OWNER=?", username)
	if GetData then
		result, Rows = dbPoll(GetData, -1)
	end
	if result then
		if Rows >= 1 then
			outputChatBox("You already have a car.", lp, 255,0,0)
			return
		elseif Rows < 1 then
			local sx,sy,sz = -1935.45764, 269.70041, 44.49506
			local carid = tonumber(id)
			local money = getPlayerMoney(lp)
			if money > tonumber(price) then
				setPlayerMoney(lp,money-price)
				local r,g,b = math.random(1,255),math.random(1,255),math.random(1,255)
				local exec = dbExec(db,"INSERT INTO cars(CARID,SPAWNX,SPAWNY,SPAWNZ,ROTX,ROTY,ROTZ,OWNER,R,G,B,PRICE) VALUES (?,?,?,?,?,?,?,?,?,?,?,?)",carid,sx,sy,sz,0,0,50,username,r,g,b,price)
				if exec then
					outputDebugString("Inserting Car Shop successfull!")
				else
					outputDebugString("Inserting Car Shop wasn't successfull!")
				end
				local spawnedVehicle = createVehicle(carid, sx, sy, sz, 0, 0, 90)
				setElementData(spawnedVehicle, "Owner", username)
				setVehicleEngineState(spawnedVehicle,false)
				warpPedIntoVehicle(lp,spawnedVehicle)
				setVehicleColor(spawnedVehicle,r,g,b,r,g,b,r,g,b,r,g,b)
				setVehicleHandling(spawnedVehicle,"suspensionLowerLimit",-0.045)
			elseif money < tonumber(price) then
				outputChatBox("You don't have enough money left. You need: "..tonumber(price-money).." $ more to buy this car.", lp, 255,0,0)
				return
			end
		end
	end
end
addEventHandler("CarBuy",root,CarBuyFunc)

	addCommandHandler("light",
		function(plr)
			local veh = getPedOccupiedVehicle(plr)
			local driver = getPedOccupiedVehicleSeat(plr)
			if veh and driver then
				if ( getVehicleOverrideLights ( veh ) ~= 2 ) then
					setVehicleOverrideLights ( veh, 2 )
					playSoundFrontEnd(plr,38)
				else
					setVehicleOverrideLights ( veh, 1 )
					playSoundFrontEnd(plr,38)
				end
			end
		end
	)
	

	addCommandHandler("engine",
		function(plr)
			local veh = getPedOccupiedVehicle(plr)
			local driver = getPedOccupiedVehicleSeat(plr)
			if veh and driver then
				local state = getVehicleEngineState ( veh )
				setVehicleEngineState ( veh, not state )
				playSoundFrontEnd(plr,38)
			end
		end
	)
	
	addEventHandler("onVehicleExplode",root,
		function()
			local owner = getElementData(source,"Owner")
			if owner ~= "" then
				dbExec(db,"DELETE FROM cars WHERE OWNER=?",pName )
			end
			
		end
	)

	function park_func(player, cmd )
	local pName = getElementData(player,"username")
	local veh = getPedOccupiedVehicle(player)
		if veh then
			local x,y,z = getElementPosition(veh)
			local rx,ry,rz = getElementRotation(veh)
			local vehicleOwner = getElementData(veh, "Owner")
			local vehicleKey = getElementData(veh, "CarKey")
			if tostring(vehicleOwner) == tostring(pName) then
				parkVehicle( tostring(vehicleOwner), x,y,z,rx,ry,rz)
				outputChatBox("You parked your car at : "..x..","..y..","..z,player,200,200,0)
			else
				outputChatBox("This car doesn't belong to you.", player, 200, 200, 0)
			end
		else
			outputChatBox("You are not in a car!", player, 200, 200, 0)
		end
	end
	addCommandHandler("park", park_func)
	
	function parkVehicle( owner, posx, posy, posz, rotx, roty, rotz, r, g, b )
		local sql = dbQuery(db, "SELECT * FROM cars WHERE OWNER = ?", owner )
		local result, num_rows = dbPoll(sql, -1)
		if num_rows == 1 then
			if owner ~= "" then
				dbExec(db, "UPDATE cars SET SPAWNX=?, SPAWNY=?, SPAWNZ=?, ROTX=?, ROTY=?, ROTZ=?,R=?,G=?,B=? WHERE OWNER=?", posx, posy, posz, rotx, roty, rotz,r,g,b,owner)
			end
		end
	end
	
	function saveVehiclesToDatabase()
        for _, v in pairs (getElementsByType("vehicle")) do
			local x,y,z = getElementPosition(v)
			local rx,ry,rz = getElementRotation(v)
			local owner = getElementData(v,"Owner") or ""
			local r,g,b = getVehicleColor(v,false)
			parkVehicle(owner,x,y,z,rx,ry,rz,r,g,b)
        end
	end
	addEventHandler("onResourceStop", resourceRoot, saveVehiclesToDatabase)
	
	
	function GetPosCar(plr)
		local pName = getElementData(plr,"username")
		for _, veh in pairs ( getElementsByType("vehicle") ) do 
			local owner = tostring(getElementData(veh, "Owner"))
			if (owner ~= "") then
				if(owner == tostring(pName)) then
					local x,y,z = getElementPosition(plr)
					--[[local city = getZoneName(x,y,z,true)
					local cityZone = getZoneName(x,y,z)
					local vehName = getVehicleName(veh)
					outputChatBox("Car Position of "..vehName.." : "..cityZone.." ( "..city.." ) | "..math.floor(x).." , "..math.floor(y).." , "..math.floor(z),plr,200,200,0,false)--]]
					--createBlipAttachedTo(veh,55,0.5,255,255,255,255,0,99999,plr)
					setElementPosition(veh,x,y,z+3)
					warpPedIntoVehicle(plr,veh)
					break
				end
			end
		end
	end
	addCommandHandler("getmycar",GetPosCar)
	
	function adminCar(plr)
		local pName = getElementData(plr,"username")
		for _, veh in pairs ( getElementsByType("vehicle") ) do 
			if(tostring(getElementData(veh, "Owner")) == tostring(pName)) then
				warpPedIntoVehicle(plr,veh)
			end
		end
	end
	addCommandHandler("admincar",adminCar)
	
	function clearChat(plr)
	local accName = getAccountName ( getPlayerAccount ( plr ) )
	local admnName = getPlayerName(plr)
		if isObjectInACLGroup ("user."..accName, aclGetGroup ( "Admin" ) ) then
			outputChatBox(" ")
			outputChatBox(" ")
			outputChatBox(" ")
			outputChatBox(" ")
			outputChatBox(" ")
			outputChatBox(" ")
			outputChatBox(" ")
			outputChatBox(" ")
			outputChatBox(" ")
			outputChatBox(" ")
			outputChatBox(" ")
			outputChatBox(" ")
			outputChatBox(" ")
			outputChatBox(" ")
			outputChatBox(" ")
			outputChatBox(" ")
			outputChatBox(" ")
			outputChatBox(" ")
			outputChatBox(" ")
			outputChatBox(" ")
			outputChatBox(" ")		
			outputChatBox ( "SUSA-BOT : Admin [".. admnName .."] cleared the chat", getRootElement(), 255, 24, 24, true )		
		   else
		   outputChatBox ("Access denied", plr, 255, 0, 0)
		 end
	end
	addCommandHandler("clearchat", clearChat)
	
	
	
