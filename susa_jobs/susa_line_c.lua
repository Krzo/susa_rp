addEvent("startDistanceCounter",true)
Line = {
    button = {},
    window = {},
    label = {}
}
local screenW, screenH = guiGetScreenSize()
Line.window[1] = guiCreateWindow((screenW - 384) / 2, (screenH - 212) / 2, 384, 212, "SUSA-Line", false)
guiWindowSetSizable(Line.window[1], false)
guiWindowSetMovable(Line.window[1],false)
guiSetVisible(Line.window[1],false)

Line.label[1] = guiCreateLabel(11, 21, 363, 117, "Taxi-Driver Salary: 60cent/km\n\nBus-Driver Salary: 40cent/marker", false, Line.window[1])
Line.button[1] = guiCreateButton(10, 166, 146, 29, "Accept", false, Line.window[1])
Line.button[2] = guiCreateButton(218, 166, 146, 29, "Decline", false, Line.window[1])

	addEventHandler("onClientMarkerHit",resourceRoot,
		function(p)
			local id = getElementID(source)
			if p == localPlayer then 
				if(id == "18") then
					guiSetVisible(Line.window[1],true)
					showCursor(true)
				end
			end
		end
	)

addEventHandler("onClientGUIClick",Line.button[1],
	function()
	local taxi,bus = getElementData(localPlayer,"susa:taxi") or 0, getElementData(localPlayer,"susa:bus") or 0 
	if taxi == 1 then
		triggerServerEvent("StartJob",localPlayer,localPlayer,1)
		guiSetVisible(Line.window[1],false)
		showCursor(false)
	elseif taxi == 0 then
		outputChatBox("you dont have the taxi licence")
	elseif bus == 1 then
		triggerServerEvent("StartJob",localPlayer,localPlayer,2)
		guiSetVisible(Line.window[1],false)
		showCursor(false)
	elseif bus == 0 then
		outputChatBox("you dont have the bus licence")
	end
end
)

addEventHandler("onClientGUIClick",Line.button[2],
	function()
		guiSetVisible(Line.window[1],false)
		showCursor(false)
	end
)

local KMDistance = 0
local function getDistanceTraveled(lp,veh,x1,y1,z1)
outputChatBox("getDistanceTraveled() ttriggered!")
	local veh = getPedOccupiedVehicle(localPlayer)
	if isElement(veh) then outputChatBox("veh is element") end
	if veh  then
		outputChatBox("whatthafack")
		if getPedOccupiedVehicleSeat (lp) == 0 then
			outputChatBox("sürüyo iste amk saysana")
			local x2, y2, z2 = getElementPosition ( veh )
			local nd = getDistanceBetweenPoints3D ( x1, y1, z1, x2, y2, z2 ) / 100
			KMDistance = KMDistance + nd
			setTimer ( getDistanceTraveled, 500, 1, veh, x2, y2, z2 )
			setElementData(veh,KMDistance)
			outputChatBox("Kilometer: "..tostring(KMDistance))
		end
	end
end
addEventHandler("startDistanceCounter",root,getDistanceTraveled)
