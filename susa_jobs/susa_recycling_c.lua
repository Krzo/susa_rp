addEvent("DistanceTraveled",true)
recycling = {
    button = {},
    window = {},
    label = {}
}
local screenW, screenH = guiGetScreenSize()
recycling.window[1] = guiCreateWindow((screenW - 384) / 2, (screenH - 212) / 2, 384, 212, "SUSA-RECYCLING", false)
guiWindowSetSizable(recycling.window[1], false)
guiWindowSetMovable(recycling.window[1],false)
guiSetVisible(recycling.window[1],false)

recycling.label[1] = guiCreateLabel(11, 21, 363, 117, "Trashman 1950 $", false, recycling.window[1])
recycling.button[1] = guiCreateButton(10, 166, 146, 29, "Accept", false, recycling.window[1])
recycling.button[2] = guiCreateButton(218, 166, 146, 29, "Decline", false, recycling.window[1])

	addEventHandler("onClientMarkerHit",resourceRoot,
		function(p)
			local id = getElementID(source)
			if p == localPlayer then 
				if(id == "19") then
					guiSetVisible(recycling.window[1],true)
					showCursor(true)
				end
			end
		end
	)

addEventHandler("onClientGUIClick",recycling.button[1],
	function()
	local trash = getElementData(localPlayer,"susa:trash") or 0 
	if trash == 1 then
		triggerServerEvent("StartJobTrash",localPlayer,localPlayer)
		guiSetVisible(recycling.window[1],false)
		outputChatBox("You successfully started the Trashman job.",0,180,0,false)
		showCursor(false)
	elseif trash == 0 then
		outputChatBox("you dont have the trash licence")
	end
end
)

addEventHandler("onClientGUIClick",recycling.button[2],
	function()
		guiSetVisible(recycling.window[1],false)
		showCursor(false)
	end
)
local KMDistance = 0
local function DistanceTraveled(lp,veh,x1,y1,z1)
outputChatBox("DistanceTraveled() ttriggered!")
	local veh = getPedOccupiedVehicle(localPlayer)
	if isElement(veh) then outputChatBox("veh is element") end
	if veh  then
		outputChatBox("whatthafack")
		if getPedOccupiedVehicleSeat (lp) == 0 then
			outputChatBox("sürüyo iste amk saysana")
			local x2, y2, z2 = getElementPosition ( veh )
			local nd = getDistanceBetweenPoints3D ( x1, y1, z1, x2, y2, z2 ) / 100
			KMDistance = KMDistance + nd
			setTimer ( DistanceTraveled, 500, 1, veh, x2, y2, z2 )
			setElementData(veh,KMDistance)
			outputChatBox("Kilometer: "..tostring(KMDistance))
		end
	end
end
addEventHandler("DistanceTraveled",root,DistanceTraveled)
