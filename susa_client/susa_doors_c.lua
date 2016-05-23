Doors = {
    button = {},
    window = {}
}
local x,y = guiGetScreenSize()
local w,h = 200,200
local px,py = x/1.05-w/1.05,y/2.5-h/2.5
Doors.window[1] = guiCreateWindow(px, py, w, h, "SUSA-CAR", false)
guiWindowSetSizable(Doors.window[1], false)
guiWindowSetMovable(Doors.window[1], false)
guiSetVisible(Doors.window[1],false)
Doors.button[1] = guiCreateButton(11, 33, 78, 33, "Hood", false, Doors.window[1])
Doors.button[2] = guiCreateButton(106, 33, 78, 33, "Trunk", false, Doors.window[1])
Doors.button[3] = guiCreateButton(11, 119, 78, 33, "Front left", false, Doors.window[1])
Doors.button[4] = guiCreateButton(11, 76, 78, 33, "Front right", false, Doors.window[1])
Doors.button[5] = guiCreateButton(106, 119, 78, 33, "Rear left", false, Doors.window[1])
Doors.button[6] = guiCreateButton(106, 76, 78, 33, "Rear right", false, Doors.window[1])
Doors.button[7] = guiCreateButton(10, 158, 174, 33, "Close", false, Doors.window[1])

function openGUI()
  local veh = getPedOccupiedVehicle(localPlayer)
  if veh then
    guiSetVisible(Doors.window[1],not guiGetVisible(Doors.window[1]))
    showCursor(not isCursorShowing())
  else
    outputChatBox("You need to be in a vehicle to use this command.",255,24,24,false)
  end
end
bindKey("f2","down",openGUI)

addEventHandler("onClientGUIClick",resourceRoot,
  function()
    local veh = getPedOccupiedVehicle(localPlayer)
    if not veh then return end
    if source == Doors.button[1] then
      triggerServerEvent("hood",localPlayer,localPlayer)
    elseif source == Doors.button[2] then
      triggerServerEvent("trunk",localPlayer,localPlayer)
    elseif source == Doors.button[3] then
      triggerServerEvent("fleft",localPlayer,localPlayer)
    elseif source == Doors.button[4] then
      triggerServerEvent("fright",localPlayer,localPlayer)
    elseif source == Doors.button[5] then
      triggerServerEvent("rleft",localPlayer,localPlayer)
    elseif source == Doors.button[6] then
      triggerServerEvent("rright",localPlayer,localPlayer)
    elseif source == Doors.button[7] then
      guiSetVisible(Doors.window[1],false)
      showCursor(false)
    end
  end
)
