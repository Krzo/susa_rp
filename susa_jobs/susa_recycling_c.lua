addEvent("DistanceTraveled",true)
recycling = {
    button = {},
    window = {},
    label = {}
}
local screenW, screenH = guiGetScreenSize()
recycling.window[1] = guiCreateWindow((screenW - 384) / 2, (screenH - 212) / 2, 384, 212, "SUSA-TRANS", false)
guiWindowSetSizable(recycling.window[1], false)
guiWindowSetMovable(recycling.window[1],false)
guiSetVisible(recycling.window[1],false)

recycling.label[1] = guiCreateLabel(11, 21, 363, 117, "Welcome to Susa-Trans. This company provides different kinds of transportations all around San Andreas. Your job is to deliver the trailer safely to the given position. After that you'll be revenued and automatically transported back here.", false, recycling.window[1])
guiLabelSetHorizontalAlign(recycling.label[1], "left", true)
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
  local startJob = getElementData(localPlayer,"startJob") or false
	if trash == 1 then
    if startJob == false then
  		triggerServerEvent("StartJobTrash",localPlayer,localPlayer)
  		guiSetVisible(recycling.window[1],false)
  		outputChatBox("You successfully started the Trucker job.",0,180,0,false)
  		showCursor(false)
    end
	elseif trash == 0 then
		outputChatBox("You didn't select the trashman job. Go to the town hall to select it.",255,24,24,false)
	end
end
)

addEventHandler("onClientGUIClick",recycling.button[2],
	function()
		guiSetVisible(recycling.window[1],false)
		showCursor(false)
    setElementData(localPlayer,"startJob",false)
	end
)

function DistanceTraveled(plr,veh,x1,y1,z1)
  local KMDistance = 0
  outputChatBox("type veh:"..type(veh))
	if veh then
		local x2, y2, z2 = getElementPosition ( veh )
		local nd = getDistanceBetweenPoints3D ( x1, y1, z1, x2, y2, z2 ) / 100
		KMDistance = KMDistance + nd
		setTimer ( DistanceTraveled, 500, 1, veh, x2, y2, z2 )
		setElementData(veh,"KMDistance",KMDistance)
		outputChatBox("Kilometer: "..tostring(KMDistance))
	end
end
addEventHandler("DistanceTraveled",root,DistanceTraveled)

addEventHandler("onClientVehicleEnter",root,
  function(plr,s)
    local startJob = getElementData(plr,"startJob")
    local owner = getElementData(source,"Owner")
    local username = getElementData(plr,"username")
    local vehid = getElementModel(source)
    local x,y,z = getElementPosition(source)
    if startJob then
        if owner == username then
            if vehid == 408 then
                DistanceTraveled(plr,source,x1,y1,z1)
            end
        end
    end
  end
)
