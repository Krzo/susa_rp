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

addCommandHandler("guui",
	function()
		guiSetVisible(recycling.window[1],true)
		showCursor(true)
	end
)

addEventHandler("onClientGUIClick",recycling.button[1],
	function()
		triggerServerEvent("StartJob",localPlayer,localPlayer)
		guiSetVisible(recycling.window[1],false)
		showCursor(false)
	end
)

addEventHandler("onClientGUIClick",recycling.button[2],
	function()
		guiSetVisible(recycling.window[1],false)
		showCursor(false)
	end
)
