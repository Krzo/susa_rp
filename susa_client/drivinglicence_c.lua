drivinglicence = {
    button = {},
    window = {},
    label = {},
	gridlist = {}
}
local screenW, screenH = guiGetScreenSize()
drivinglicence.window[1] = guiCreateWindow((screenW - 356) / 2, (screenH - 247) / 2, 356, 247, "Driving Licence", false)
guiWindowSetMovable(drivinglicence.window[1], false)
guiWindowSetSizable(drivinglicence.window[1], false)
guiSetVisible(drivinglicence.window[1],false)

drivinglicence.gridlist[1] = guiCreateGridList(10, 29, 206, 208, false, drivinglicence.window[1])
Licencecol = guiGridListAddColumn(drivinglicence.gridlist[1], "Licence Type", 0.5)
pricecol = guiGridListAddColumn(drivinglicence.gridlist[1], "Price", 0.5)
guiGridListAddRow(drivinglicence.gridlist[1])
guiGridListAddRow(drivinglicence.gridlist[1])
guiGridListSetItemText(drivinglicence.gridlist[1], 0, 1, "Driving Licence", false, false)
guiGridListSetItemText(drivinglicence.gridlist[1], 0, 2, "1800 $", false, false)
drivinglicence.label[1] = guiCreateLabel(226, 29, 120, 80, "Welcome to the Driving School of SUSA RP. Here you can buy your Driving Licence.", false, drivinglicence.window[1])
guiLabelSetHorizontalAlign(drivinglicence.label[1], "left", true)
drivinglicence.button[1] = guiCreateButton(236, 201, 108, 36, "Leave", false, drivinglicence.window[1])
guiSetFont(drivinglicence.button[1], "default-bold-small")
drivinglicence.button[2] = guiCreateButton(236, 164, 108, 36, "Buy Licence", false, drivinglicence.window[1])
guiSetFont(drivinglicence.button[2], "default-bold-small")


	addEventHandler("onClientMarkerHit",resourceRoot,
		function(p)
			local id = getElementID(source)
			if p == localPlayer then
				if(id == "20") then
					guiSetVisible(drivinglicence.window[1],true)
					showCursor(true)
				end
			end
		end
	)

	addEventHandler("onClientGUIClick",drivinglicence.button[1],
		function()
			guiSetVisible(drivinglicence.window[1],false)
			showCursor(false)
		end
	)

	addEventHandler("onClientGUIClick",drivinglicence.button[2],
		function()
		local money = getPlayerMoney(localPlayer)
		local row,col = guiGridListGetSelectedItem(drivinglicence.gridlist[1])
			if row == 0 then
				if getElementData(localPlayer,"susa:d_licence") == 0 then
					if money >= 1800 then
						setElementData(localPlayer,"susa:d_licence",1)
						triggerServerEvent("licence",localPlayer,localPlayer,1)
						setPlayerMoney(money-1800,false)
						outputChatBox("You successfully bought your driving licence",24,255,24)
					else
						outputChatBox("You don't have enough money for this licence. You need 1800$",255,24,24)
					end
				else
					outputChatBox("You already own this licence!",255,24,24)
				end
			end
		end
	)
