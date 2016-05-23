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

Line.label[1] = guiCreateLabel(11, 21, 363, 117, "Welcome to SUSA-Taxi. Your job is to drive the passenger to the given destination on the map. You will get 60 cents per driven kilometre.", false, Line.window[1])
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
	local taxi,bus = getElementData(localPlayer,"susa:taxi") or 0
	if taxi == 1 then
		triggerServerEvent("StartJob",localPlayer,localPlayer,1)
		guiSetVisible(Line.window[1],false)
		showCursor(false)
	elseif taxi == 0 then
		outputChatBox("You don't have the taxi licence, go to the town hall and accept the taxi job.",255,24,24,false)
	end
end
)

addEventHandler("onClientGUIClick",Line.button[2],
	function()
		guiSetVisible(Line.window[1],false)
		showCursor(false)
	end
)
