-- JOBS Client  (Rathaus,Berufe,...)

Town_Hall = {
	window = {},
    gridlist = {},
    button = {},
    label = {}
}

local screenW, screenH = guiGetScreenSize() 
Town_Hall.window[1] = guiCreateWindow((screenW - 356) / 2, (screenH - 247) / 2, 356, 247, "Town Hall", false)
guiWindowSetMovable(Town_Hall.window[1], false)
guiWindowSetSizable(Town_Hall.window[1], false)
guiSetVisible(Town_Hall.window[1],false)
Town_Hall.gridlist[1] = guiCreateGridList(10, 29, 206, 208, false, Town_Hall.window[1])
Licencecol = guiGridListAddColumn(Town_Hall.gridlist[1], "Licence Type", 0.5)
pricecol = guiGridListAddColumn(Town_Hall.gridlist[1], "Price", 0.5)
guiGridListAddRow(Town_Hall.gridlist[1])
guiGridListAddRow(Town_Hall.gridlist[1])
guiGridListSetItemText(Town_Hall.gridlist[1], 0, 1, "Driving Licence", false, false)
guiGridListSetItemText(Town_Hall.gridlist[1], 0, 2, "1800 $", false, false)
guiGridListSetItemText(Town_Hall.gridlist[1], 1, 1, "Boat Licence", false, false)
guiGridListSetItemText(Town_Hall.gridlist[1], 1, 2, "3400 $", false, false)
Town_Hall.label[1] = guiCreateLabel(226, 29, 120, 80, "Welcome in the town hall of SUSA RP. Here you can buy Licences such as driving or boat Licences.", false, Town_Hall.window[1])
guiLabelSetHorizontalAlign(Town_Hall.label[1], "left", true)
Town_Hall.button[1] = guiCreateButton(236, 201, 108, 36, "Leave", false, Town_Hall.window[1])
guiSetFont(Town_Hall.button[1], "default-bold-small")
Town_Hall.button[2] = guiCreateButton(236, 164, 108, 36, "Buy Licence", false, Town_Hall.window[1])
guiSetFont(Town_Hall.button[2], "default-bold-small")


	addEventHandler("onClientMarkerHit",resourceRoot,
		function(p)
			local id = getElementID(source)
			if p == localPlayer then 
				if(id == "15") then
					guiSetVisible(Town_Hall.window[1],true)
					showCursor(true)
				end
			end
		end
	)
	
	function leave()
		guiSetVisible(Town_Hall.window[1],false)
		showCursor(false)
	end
	addEventHandler("onClientGUIClick",Town_Hall.button[1],leave,false)

	function buttonclick()
	local money = getPlayerMoney(localPlayer)
	local row,col = guiGridListGetSelectedItem(Town_Hall.gridlist[1])
		if row == 0 then
			if getElementData(localPlayer,"susa:d_licence") == 0 then
				if money >= 1800 then
					local money = money-3400
					setElementData(localPlayer,"susa:d_licence",1)
					triggerServerEvent("licence",localPlayer,localPlayer,1,money)
					setPlayerMoney(money-1800,false)
					outputChatBox("You successfully bought your driving licence",24,255,24)
				else
					outputChatBox("You don't have enough money for this licence. You need 1800$",255,24,24)
				end
			else
				outputChatBox("You already own this licence!",255,24,24)
			end
		elseif row == 1 then
			if getElementData(localPlayer,"susa:b_licence") == 0 then
				if money >= 3400 then
					setElementData(localPlayer,"susa:b_licence",1)
					local money = money-3400
					outputChatBox("You successfully bought your boat licence",24,255,24)
					triggerServerEvent("licence", localPlayer,localPlayer,2,money)
				else
					outputChatBox("You don't have enough money for this licence. You need 3400$",255,24,24)
				end
			else
				outputChatBox("You already own this licence!",255,24,24)
			end
		end
	end
	addEventHandler("onClientGUIClick",Town_Hall.button[2],buttonclick,false)