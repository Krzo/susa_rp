bus = {
    button = {},
    window = {},
    label = {}
}
local screenW, screenH = guiGetScreenSize()
bus.window[1] = guiCreateWindow((screenW - 384) / 2, (screenH - 212) / 2, 384, 212, "SUSA-TRANS", false)
guiWindowSetSizable(bus.window[1], false)
guiWindowSetMovable(bus.window[1],false)
guiSetVisible(bus.window[1],false)

bus.label[1] = guiCreateLabel(11, 21, 363, 117, "Welcome to Susa-Bus. This company provides different kinds of transportations all around San Andreas. Your job is to deliver the tourists safely to the given position. After that you'll be revenued and automatically transported back here.", false, bus.window[1])
guiLabelSetHorizontalAlign(bus.label[1], "left", true)
bus.button[1] = guiCreateButton(10, 166, 146, 29, "Accept", false, bus.window[1])
bus.button[2] = guiCreateButton(218, 166, 146, 29, "Decline", false, bus.window[1])

	addEventHandler("onClientMarkerHit",resourceRoot,
		function(p)
			local id = getElementID(source)
			if p == localPlayer then
				if(id == "21") then
					guiSetVisible(bus.window[1],true)
					showCursor(true)
				end
			end
		end
	)

addEventHandler("onClientGUIClick",bus.button[1],
	function()
	local busjob = getElementData(localPlayer,"susa:bus") or 0
  local startJob = getElementData(localPlayer,"startJob") or false
	if busjob == 1 then
    if startJob == false then
  		triggerServerEvent("StartJobBus",localPlayer,localPlayer)
  		guiSetVisible(bus.window[1],false)
  		outputChatBox("You successfully started the Bus job.",0,180,0,false)
  		showCursor(false)
    else
      outputChatBox("You already started this job. If you press 'Decline', you'll stop having this job.",255,24,24,false)
    end
	elseif busjob == 0 then
		outputChatBox("You didn't select the trashman job. Go to the town hall to select it.",255,24,24,false)
	end
end
)

addEventHandler("onClientGUIClick",bus.button[2],
	function()
		guiSetVisible(bus.window[1],false)
		showCursor(false)
    setElementData(localPlayer,"startJob",false)
	end
)
