	local x,y = guiGetScreenSize()
	local pw,ph = 388, 388
	local px,py = x/2-pw/2,y/2-ph/2
	local tickk
	local price = 0
	local endTime
	local angle = 0
	local startTime
	local showingshop = false
	local row
	local carshow
	local Carwindow = {
		button = {},
		gridlist = {},
		window = {},
		label = {}
	}
	local cars = {
		{"Nissan GTR",50000,429},
		{"Mercedes AMG GT ",90000,415},
		{"McLaren MP4 12C",80000,541},
		{"Lexus IS300 Tunable ",100000,560},
		{"BMW E92",60000,411},
		{"Impala SS Tunable",100000,567},
		{"GTA V Nightshade",25000,475},
		{"Pontiac LeMans",30000,518},
		{"Elegy SRT",28000,562},
		{"Chevrolet El Camino SS",15000,600},
		{"Ford F100",16000,478},
		{"Ford Mustang",65000,402},
		{"GTA V Sandking",35000,495}
	}

	local screenW, screenH = guiGetScreenSize()
	Carwindow.window[1] = guiCreateWindow(px, py, 388, 388, "San Fierro Car Shop", false)
	guiWindowSetSizable(Carwindow.window[1], false)
	guiSetAlpha(Carwindow.window[1], 0.90)
	guiSetVisible(Carwindow.window[1], false)

	Carwindow.gridlist[1] = guiCreateGridList(9, 25, 220, 353, false, Carwindow.window[1])
	guiGridListAddColumn(Carwindow.gridlist[1], "Vehicle", 0.6)
	guiGridListAddColumn(Carwindow.gridlist[1], "Price", 0.5)
	guiGridListAddColumn(Carwindow.gridlist[1], "ID", 0.3)
	Carwindow.label[1] = guiCreateLabel(233, 28, 139, 190, "Select your car and then press \"Buy\" to buy your car.\nCar Functions are:\n/getmycar - Car position\n/sellmycar - Sell your car for 40% of the original price\n", false, Carwindow.window[1])
	guiLabelSetHorizontalAlign(Carwindow.label[1], "left", true)
	Carwindow.button[1] = guiCreateButton(241, 261, 126, 49, "Buy", false, Carwindow.window[1])
	guiSetFont(Carwindow.button[1], "default-bold-small")
	Carwindow.button[2] = guiCreateButton(241, 319, 126, 49, "Leave", false, Carwindow.window[1])
	guiSetFont(Carwindow.button[2], "default-bold-small")


	for i,v in ipairs(cars) do
		local car,price,id = unpack(cars[i])
		row = guiGridListAddRow(Carwindow.gridlist[1])
		guiGridListSetItemText(Carwindow.gridlist[1], row, 1, tostring(car), false, false)
		guiGridListSetItemText(Carwindow.gridlist[1], row, 2, tostring(price), false, false)
		guiGridListSetItemText(Carwindow.gridlist[1], row, 3, tostring(id), false, false)
	end

	addEventHandler("onClientPickupHit",resourceRoot,
		function(plr)
			local id = getElementID(source)
			local licence = getElementData(plr,"susa:d_licence")
			if id == "16" then
				if plr == localPlayer then
					outputChatBox("Welcome in the San Fierro Car Shop!",0,180,0,false)
					showCursor(not isCursorShowing())
					guiAddInterpolateEffect(Carwindow.window[1],0,0,0,0,px,py,388,388,1,"Linear","OutBack",true)
					guiSetVisible(Carwindow.window[1],true)
					addEventHandler("onClientRender",root,rotateCamera)
				end
			end
		end
	)



	function rotateCamera()
		angle = angle + 0.5
		if angle >= 359 then angle = 0 end
		setElementRotation(carshow,0,0,angle)
	end

	addEventHandler("onClientGUIClick",Carwindow.button[2],
		function()
			showCursor(false)
			guiSetVisible(Carwindow.window[1],false)
			setCameraTarget(localPlayer)
			removeEventHandler("onClientRender",root,rotateCamera)
			if isElement(carshow) then destroyElement(carshow) end
		end
	)
	addEventHandler("onClientGUIClick",Carwindow.gridlist[1],
		function()
			local id = guiGridListGetItemText(Carwindow.gridlist[1],guiGridListGetSelectedItem(Carwindow.gridlist[1]),3)
			if isElement(carshow) then destroyElement(carshow) end
			carshow = createVehicle(id,-1951.75806, 298.48566, 48.30313,-0, 0, 101.23359680176,"SUSA")
			setCameraMatrix(-1958.7713623047, 302.42260742188, 50.619598388672, -1958.0671386719, 301.90463256836, 50.134014129639)
			guiSetPosition(Carwindow.window[1],px+388,py,false)
			local r,g,b = math.random(255),math.random(255),math.random(255)
			setVehicleColor(carshow,r,g,b)
		end
	)

	addEventHandler("onClientGUIClick",Carwindow.button[1],
		function()
			local carname = guiGridListGetItemText(Carwindow.gridlist[1],guiGridListGetSelectedItem(Carwindow.gridlist[1]),1)
			local price = guiGridListGetItemText(Carwindow.gridlist[1],guiGridListGetSelectedItem(Carwindow.gridlist[1]),2)
			local id = guiGridListGetItemText(Carwindow.gridlist[1],guiGridListGetSelectedItem(Carwindow.gridlist[1]),3)
			triggerServerEvent("CarBuy",localPlayer,localPlayer,carname,price,id)
			--showingshop = false
			--removeEventHandler("onClientRender",root,DrawShop)
			guiSetVisible(Carwindow.window[1],false)
			showCursor(false)
			setCameraTarget(localPlayer)
			removeEventHandler("onClientRender",root,rotateCamera)
			if isElement(carshow) then destroyElement(carshow) end
		end
	)

	addCommandHandler("car",
		function()
			setElementPosition(localPlayer,-1968.54626, 293.75320, 35.17188)
		end
	)
