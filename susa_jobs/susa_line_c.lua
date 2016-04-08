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

addCommandHandler("gui",
	function()
		guiSetVisible(Line.window[1],true)
		showCursor(true)
	end
)

addEventHandler("onClientGUIClick",Line.button[1],
	function()
		triggerServerEvent("StartJob",localPlayer,localPlayer)
		guiSetVisible(Line.window[1],false)
		showCursor(false)
	end
)

addEventHandler("onClientGUIClick",Line.button[2],
	function()
		guiSetVisible(Line.window[1],false)
		showCursor(false)
	end
)
