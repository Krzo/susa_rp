addEvent("hood",true)
addEvent("trunk",true)
addEvent("fleft",true)
addEvent("fright",true)
addEvent("rleft",true)
addEvent("rright",true)

addEventHandler("hood",root,
  function(plr)
    local veh = getPedOccupiedVehicle(plr)
    if not veh then return end
      if getVehicleDoorOpenRatio (veh, 0) == 0 then
          setVehicleDoorOpenRatio(veh, 0, 1, 2500)
      else
          setVehicleDoorOpenRatio(veh, 0, 0, 1500)
      end
  end
)
addEventHandler("trunk",root,
  function(plr)
    local veh = getPedOccupiedVehicle(plr)
    if not veh then return end
    if getVehicleDoorOpenRatio (veh, 1) == 0 then
        setVehicleDoorOpenRatio(veh, 1, 1, 2500)
    else
        setVehicleDoorOpenRatio(veh, 1, 0, 1500)
    end
  end
)

addEventHandler("fleft",root,
  function(plr)
    local veh = getPedOccupiedVehicle(plr)
    if not veh then return end
    if getVehicleDoorOpenRatio (veh, 2) == 0 then
        setVehicleDoorOpenRatio(veh, 2, 1, 2500)
    else
        setVehicleDoorOpenRatio(veh, 2, 0, 1500)
    end
  end
)

addEventHandler("fright",root,
  function(plr)
    local veh = getPedOccupiedVehicle(plr)
    if not veh then return end
    if getVehicleDoorOpenRatio (veh, 3) == 0 then
        setVehicleDoorOpenRatio(veh, 3, 1, 2500)
    else
        setVehicleDoorOpenRatio(veh, 3, 0, 1500)
    end
  end
)

addEventHandler("rleft",root,
  function(plr)
    local veh = getPedOccupiedVehicle(plr)
    if not veh then return end
    if getVehicleDoorOpenRatio (veh, 4) == 0 then
        setVehicleDoorOpenRatio(veh, 4, 1, 2500)
    else
        setVehicleDoorOpenRatio(veh, 4, 0, 1500)
    end
  end
)

addEventHandler("rright",root,
  function(plr)
    local veh = getPedOccupiedVehicle(plr)
    if not veh then return end
    if getVehicleDoorOpenRatio (veh, 5) == 0 then
        setVehicleDoorOpenRatio(veh, 5, 1, 2500)
    else
        setVehicleDoorOpenRatio(veh, 5, 0, 1500)
    end
  end
)
