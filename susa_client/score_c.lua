local screenW, screenH = guiGetScreenSize()
local scroll = 0
local transalpha,step = 0,15
local playerTable =  getElementsByType("player")
local recw,rech = 700,500
local px,py = screenW/2-recw/2,screenH/2-rech/2
local rechohe = 25
local state = nil
local linien = 23
local forum = "-"
local tx,ty = (screenW - 120) / 2,(screenH - 15) / 2


function renderScoreboard()
		if not turn then
			transalpha = transalpha - step
		elseif turn then
			transalpha = transalpha + step
		end
		playerTable = getElementsByType("player")
		if (transalpha >= 254) then
			transalpha = 255
		elseif transalpha <= 0 then
			transalpha = 0
			removeEventHandler("onClientRender",root,renderScoreboard)
		end
        dxDrawImage(px,py,recw,rech,"susa_data/scoreboard.png",0,0,0,tocolor(255,255,255,transalpha),false)
    local count  = 0
		for i = 1 + scroll,linien + scroll do
			if (playerTable[i]) then
				count = count + rechohe
				local team
				local nameofplayer = getPlayerName(playerTable[i])
				local posx,posy,posz = getElementPosition(playerTable[i])
				local loc = getZoneName(posx,posy,posz)
				local money = getElementData(playerTable[i],"money") or "0"
				local ping = getPlayerPing(playerTable[i]) or "..."
        local drft = getElementData(playerTable[i],"Drift Rank") or "--"
				dxDrawText(nameofplayer, (tx) - 185, ty - 120 + count, ((tx) - 228) + 125,  (ty - 188) + 22, tocolor(255, 255, 255, transalpha), 1.00, "default-bold", "left", "center", false, false, false, true, false)
				dxDrawText(money.." $", (tx) - 100, ty - 120 + count, ((tx) - 100) + 83,  (ty - 188) + 24, tocolor(255, 255, 255, transalpha), 1.00, "default-bold", "center", "center", false, false, false, true, false)
				dxDrawText(loc, (tx) +1 , ty - 120 + count, ((tx) - 20) + 125,  (ty - 188) + 22, tocolor(255, 255, 255, transalpha), 1.00, "default-bold", "center", "center", false, false, false, true, false)
				dxDrawText(tostring(ping), tx+ 215, ty - 120 + count, (tx+ 215) + 85, ( ty - 188) + 24, tocolor(255, 255, 255, transalpha), 1.00, "default-bold", "center", "center", false, false, false, true, false)
				dxDrawText(drft, (tx) + 140, ty - 120 + count, ((tx) + 100) + 83,(ty - 188) + 24, tocolor(255, 255, 255, transalpha), 1.00, "default-bold", "center", "center", false, false, false, true, false)
			end
		end
end

function ScoreBoardScrollUp()
	if (scroll > 0) then
		scroll = scroll - 1
	end
end

function ScoreBoardScrollDown()
	if (playerTable[linien+scroll]) then
		scroll = scroll + 1
	end
end

bindKey("tab","both",function (_,state)
	if state == "down" then
		turn = true
		addEventHandler("onClientRender",getRootElement(),renderScoreboard)
		bindKey("mouse_wheel_down","down",ScoreBoardScrollDown)
		bindKey("mouse_wheel_up","down",ScoreBoardScrollUp)
	else
		turn = false
		unbindKey("mouse_wheel_down","down",ScoreBoardScrollDown)
		unbindKey("mouse_wheel_up","down",ScoreBoardScrollUp)
	end
end)
