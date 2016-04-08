local tmenu = {}
--local tuningparts = {"Spoiler","Exhaust","Front-Bumper","Rear Bumper","Rims","Hydraulics","Color"}
tmenu.x,tmenu.y = guiGetScreenSize()
tmenu.pw,tmenu.ph = 250, 350
tmenu.px,tmenu.py = tmenu.x/1-tmenu.pw/1,tmenu.y/2-tmenu.ph/2
local angle = 0
local showingshop = false
local gridlist = dxGrid:Create ( tmenu.px, tmenu.py, tmenu.pw,tmenu.ph )
gridlist:SetVisible(false)
gridlist:AddColumn("Tuning Shop San Fierro",250)

	addEventHandler("onClientMarkerHit",root,
		function(plr)
			local id = getElementID(source)
			local veh = getPedOccupiedVehicle(plr)
			if plr == localPlayer then
				if id == "17" and veh and getElementDimension(plr) == 0 then
					showingshop = true
					outputChatBox("Welcome in the San Fierro Tuning Shop!",0,180,0,false)
					triggerServerEvent("onTuningJoin",localPlayer,localPlayer,veh)
					setCameraMatrix(-2063.2409667969, 445.85540771484, 142.69630432129, -2063.6955566406, 444.99108886719, 142.48107910156)
					addEventHandler("onClientRender",root,DrawTune)
					showCursor(true)
					gridlist:SetVisible(true)
					--[[for i,v in ipairs(tuningparts) do
						gridlist:AddItem(1,tuningparts[i],255,255,255)
					end--]]
					gridlist:AddItem(1,"Color",_,255,255,255)
					local upgrades = getVehicleCompatibleUpgrades ( veh )
					for _, upgrade in pairs ( upgrades ) do
						local name = getVehicleUpgradeSlotName ( upgrade )
						outputChatBox(name..":"..upgrade)
						gridlist:AddItem(1,name,{upgrade,math.random(1000,2000)},255,255,255)
					end
					gridlist:AddItem(1,"Remove Parts",_,255,255,255)
					exports.cpicker:openPicker(veh,"#ff9900","Pick a color for your vehicle")
				else
					outputChatBox("You need a car to enter the tuning shop.",255,24,24,false)
				end
			end
		end
	)
	
	addEventHandler("onClientKey",root,
		function(btn)
			if showingshop and not isMouseOverElement(tmenu.px, tmenu.py, tmenu.pw,tmenu.ph) then
				if btn == "mouse_wheel_up" then
					angle = angle - 35 
					if angle <= 0 then angle = 359 end
				elseif btn == "mouse_wheel_down" then
					angle = angle + 35
					if angle >= 359 then angle = 0 end
				end
				outputChatBox(angle)
			end
		end
	)
	
	addEventHandler("onClientDoubleClick",root,
		function()
			if isMouseOverElement(tmenu.px, tmenu.py, tmenu.pw,tmenu.ph) and showingshop then
				local index = gridlist:GetSelectedItem()
				if index ~= -1 then
					local selectedpart,data = gridlist:GetItemDetails(1,index)
					local id = data[1]
					local price = data[2]					
					outputChatBox("You added: "..selectedpart.." to your car. ID of this part: "..id,0,180,0,false )
					local veh = getPedOccupiedVehicle(localPlayer)
					--[[if selectedpart == "Hydraulics" and selectedpart ~= nil then
						triggerServerEvent("onClientHydraulics",localPlayer,localPlayer,veh)
					elseif selectedpart == "Spoiler" and selectedpart ~= nil then					
						triggerServerEvent("onClientSpoiler",localPlayer,localPlayer,veh)
					end--]]
					if selectedpart ~= "Remove Parts" then
						triggerServerEvent("onTuningPartSelected",localPlayer,localPlayer,veh,id,price)
					elseif selectedpart == "Remove Parts" then
						triggerServerEvent("onTuningPartsRemove",localPlayer,localPlayer,veh)
					end
				end
			else
				selectedpart = nil
			end
		end
	)
	
	--[[addEventHandler("onClientDoubleClick",root,
		function()
			if isMouseOverElement(tmenu.px, tmenu.py, tmenu.pw,tmenu.ph) then
				local index = gridlist:GetSelectedItem()
				if index ~= -1 then
					local selectedpart,data = gridlist:GetItemDetails(1,index)
					local id = data[1]
					local price = data[2]					
					outputChatBox("You successfully removed: "..selectedpart.." from your car. ID of this part: "..id,180,0,0,false )
					local veh = getPedOccupiedVehicle(localPlayer)
					triggerServerEvent("onTuningPartsRemove",localPlayer,localPlayer,veh,id,price)
				end
			else
				selectedpart = nil
			end
		end
	)--]]
	
	addCommandHandler("leave",
		function()
			local veh = getPedOccupiedVehicle(localPlayer)
			triggerServerEvent("onTuningLeave",localPlayer,localPlayer,veh)
			setCameraTarget(localPlayer)
			removeEventHandler("onClientRender",root,DrawTune)
			showCursor(false)
			gridlist:SetVisible(false)
			showingshop = false
			exports.cpicker:closePicker(veh)
		end
	)
	
	addEventHandler("onColorPickerChange",root,
		function(element,hex,r,g,b)
			setVehicleColor(element, r, g, b)
		end
	)
	
	addCommandHandler("tune",
		function()
			local veh = getPedOccupiedVehicle(localPlayer)
			if veh then
				setElementPosition(veh,-1935.0046386719, 234.51217651367, 34.3125) 
			else
				setElementPosition(localPlayer,-1935.0046386719, 234.51217651367, 34.3125) 
			end
		end
	)
	
	function DrawTune()
		--angle = angle + 0.3
		--if angle >= 359 then angle = 0 end
		if showingshop then
			local veh = getPedOccupiedVehicle(localPlayer)
			setElementRotation(veh,0,0,angle)
		end
	end