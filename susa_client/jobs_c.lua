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
Licencecol = guiGridListAddColumn(Town_Hall.gridlist[1], "Type", 0.5)
pricecol = guiGridListAddColumn(Town_Hall.gridlist[1], "Price/Salary", 0.5)
for i = 0, 10 do
guiGridListAddRow(Town_Hall.gridlist[1])
end
guiGridListSetItemText(Town_Hall.gridlist[1], 4, 1, "Tuning License", false, false)
guiGridListSetItemText(Town_Hall.gridlist[1], 4, 2, "8000 $", false, false)
guiGridListSetItemText(Town_Hall.gridlist[1], 0, 1, "Boat Licence", false, false)
guiGridListSetItemText(Town_Hall.gridlist[1], 0, 2, "3400 $", false, false)
guiGridListSetItemText(Town_Hall.gridlist[1], 1, 1, "Taxi-driver", false, false)
guiGridListSetItemText(Town_Hall.gridlist[1], 1, 2, "60 cent/km", false, false) --Taxistation -> CAN
guiGridListSetItemText(Town_Hall.gridlist[1], 2, 1, "trashman", false, false)
guiGridListSetItemText(Town_Hall.gridlist[1], 2, 2, "1950 $", false, false)
guiGridListSetItemText(Town_Hall.gridlist[1], 3, 1, "Bus-driver", false, false)
guiGridListSetItemText(Town_Hall.gridlist[1], 3, 2, "40 cent/marker", false, false)
guiGridListSetItemText(Town_Hall.gridlist[1], 5, 1, "Driving Licence", false, false)
guiGridListSetItemText(Town_Hall.gridlist[1], 5, 2, "1800 $", false, false)
Town_Hall.label[1] = guiCreateLabel(226, 29, 120, 80, "Welcome in the town hall of SUSA RP. Here you can buy Licences such as driving or boat Licences.", false, Town_Hall.window[1])
guiLabelSetHorizontalAlign(Town_Hall.label[1], "left", true)
Town_Hall.button[1] = guiCreateButton(236, 201, 108, 36, "Leave", false, Town_Hall.window[1])
guiSetFont(Town_Hall.button[1], "default-bold-small")
Town_Hall.button[2] = guiCreateButton(236, 164, 108, 36, "Select", false, Town_Hall.window[1])
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
			if getElementData(localPlayer,"susa:b_licence") == 0 then
				if money >= 3400 then

					local money = money-3400
					outputChatBox("You successfully bought your boat licence",24,255,24)
					triggerServerEvent("licence", localPlayer,localPlayer,2,money)
				else
					outputChatBox("You don't have enough money for this licence. You need 3400$",255,24,24)
				end
			else
				outputChatBox("You already own this licence!",255,24,24)
			end
		elseif row == 5 then
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
		elseif row == 1 then
			if getElementData(localPlayer,"susa:taxi") == 0 and getElementData(localPlayer,"susa:trash") == 0 and getElementData(localPlayer,"susa:bus") == 0 then

					outputChatBox("You successfully started the Job",24,255,24)
					triggerServerEvent("licence", localPlayer,localPlayer,3,money)
			else
				outputChatBox("You already have a Job!",255,24,24)
			end
		elseif row == 2 then
			if getElementData(localPlayer,"susa:trash") == 0  and getElementData(localPlayer,"susa:taxi") ==0 and getElementData(localPlayer,"susa:bus") == 0 then

					outputChatBox("You successfully started the Job",24,255,24)
					triggerServerEvent("licence", localPlayer,localPlayer,4,money)
			else
				outputChatBox("You already have a Job!",255,24,24)
			end
		elseif row == 3 then
			if getElementData(localPlayer,"susa:bus") == 0 and getElementData(localPlayer,"susa:taxi") == 0 and getElementData(localPlayer,"susa:trash") == 0 then

					outputChatBox("You successfully started the Job",24,255,24)
					triggerServerEvent("licence", localPlayer,localPlayer,5,money)
			else
				outputChatBox("You already have a Job!",255,24,24)
			end
		elseif row == 4 then
			if getElementData(localPlayer,"susa:tuning") == 0 or getElementData(localPlayer,"susa:tuning") == false then
				if getElementData(localPlayer,"susa:d_licence") == 1 then
					if money >= 8000 then

						local money = money-8000
						outputChatBox("You successfully bought your tuning licence",24,255,24)
						triggerServerEvent("licence", localPlayer,localPlayer,6,money)
					else
						outputChatBox("You don't have enough money for this licence. You need 8000$",255,24,24)
					end
				else
					outputChatBox("You dont have the driving licence!",255,24,24)
				end
		else
				outputChatBox("You alredy have the tuning licence",255,24,24)
			end
		end
	end
	addEventHandler("onClientGUIClick",Town_Hall.button[2],buttonclick,false)
