function replaceModel()  
  txd = engineLoadTXD("susa_data/wheels/J2_wheels.txd", 1082 )
  engineImportTXD(txd, 1082)
 
  dff = engineLoadDFF("susa_data/wheels/wheel_gn1.dff", 1082 )
  engineReplaceModel(dff, 1082)
 
  dff = engineLoadDFF("susa_data/wheels/wheel_gn2.dff", 1085 )
  engineReplaceModel(dff, 1085)
 
  dff = engineLoadDFF("susa_data/wheels/wheel_gn3.dff", 1096 )
  engineReplaceModel(dff, 1096)
 
  dff = engineLoadDFF("susa_data/wheels/wheel_gn4.dff", 1097 )
  engineReplaceModel(dff, 1097)
 
  dff = engineLoadDFF("susa_data/wheels/wheel_gn5.dff", 1098 )
  engineReplaceModel(dff, 1098)
 
  dff = engineLoadDFF("susa_data/wheels/wheel_sr1.dff", 1079 )
  engineReplaceModel(dff, 1079)
 
  dff = engineLoadDFF("susa_data/wheels/wheel_sr2.dff", 1075 )
  engineReplaceModel(dff, 1075)
 
  dff = engineLoadDFF("susa_data/wheels/wheel_sr3.dff", 1074 )
  engineReplaceModel(dff, 1074)
 
  dff = engineLoadDFF("susa_data/wheels/wheel_sr4.dff", 1081 )
  engineReplaceModel(dff, 1081)
 
  dff = engineLoadDFF("susa_data/wheels/wheel_sr5.dff", 1080 )
  engineReplaceModel(dff, 1080)
 
  dff = engineLoadDFF("susa_data/wheels/wheel_sr6.dff", 1073 )
  engineReplaceModel(dff, 1073)
 
  dff = engineLoadDFF("susa_data/wheels/wheel_lr1.dff", 1077 )
  engineReplaceModel(dff, 1077)
 
  dff = engineLoadDFF("susa_data/wheels/wheel_lr2.dff", 1083 )
  engineReplaceModel(dff, 1083)
 
  dff = engineLoadDFF("susa_data/wheels/wheel_lr3.dff", 1078 )
  engineReplaceModel(dff, 1078)
 
  dff = engineLoadDFF("susa_data/wheels/wheel_lr4.dff", 1076 )
  engineReplaceModel(dff, 1076)
 
  dff = engineLoadDFF("susa_data/wheels/wheel_lr5.dff", 1084 )
  engineReplaceModel(dff, 1084)
 
  dff = engineLoadDFF("susa_data/wheels/wheel_or1.dff", 1025 )
  engineReplaceModel(dff, 1025)
 
end
addEventHandler ( "onClientResourceStart", getResourceRootElement(getThisResource()), replaceModel)
 
addCommandHandler ( "reloadwheel", replaceModel )


function replaceModel()
   local txd = engineLoadTXD ( "susa_data/sfgarage/oldgarage_sfse.txd")
   engineImportTXD ( txd, 11387 )
   
   local txd = engineLoadTXD ( "susa_data/sfgarage/oldgarage_sfse.txd")
   engineImportTXD ( txd, 11326 )
   
   local txd = engineLoadTXD ( "susa_data/sfgarage/hubint1_sfse.txd")
   engineImportTXD ( txd, 11389 )
 end
 addEventHandler ( "onClientResourceStart", getResourceRootElement(getThisResource()),
     function()
         replaceModel()
         setTimer (replaceModel, 1000, 1)
     end
)

addEventHandler("onClientClick",root,
	function()
		if isCursorShowing() then
			playSoundFrontEnd(38)
		end
	end
)