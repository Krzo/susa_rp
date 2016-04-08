local x,y = guiGetScreenSize()
local w,h = 800,600
local px,py = x/2-w/2, y/2-h/2
local blurStrength = 5
local blurShader = dxCreateShader("susa_data/BlurShader.fx")
local myScreenSource = dxCreateScreenSource(x,y)

	local useredit = dxElement:create("edit","",px+260,py+207,305,30,{116,116,116,255},1,"default-bold",false,"none",nil,{61,64,62,200},{61,64,62,255},nil,{230,230,230,180})
			useredit:setBackgroundColor({148, 157, 164,100})
	local loginbutton = dxElement:create("button","susa_data/login.png",px+308,py+350,170,45,{255,255,255,255},1,"default-bold",false,"none",nil,{255,255,255,255},{255,255,255,255},nil,{255,255,255,255})
			loginbutton:setFunction("Login")
	local regbutton = dxElement:create("button","susa_data/reg.png",px+308,py+400,170,45,{255,255,255,255},1,"default-bold",false,"none",nil,{255,255,255,255},{255,255,255,255},nil,{255,255,255,255})
			regbutton:setFunction("Register")
	local passedit = dxElement:create("edit","",px+260,py+275,305,30,{116,116,116,255},1,"default-bold",false,"none",nil,{61,64,62,200},{61,64,62,255},nil,{230,230,230,180})
			passedit:setBackgroundColor({148, 157, 164,100})
			passedit:setHidden(true)

	function LoginPanel()
		-- ## cameramatrix mit mouse
		if myScreenSource and blurShader then
			dxUpdateScreenSource(myScreenSource)
			dxSetShaderValue(blurShader,"ScreenSource",myScreenSource);
			dxSetShaderValue(blurShader,"BlurStrength",blurStrength);
			dxSetShaderValue(blurShader,"UVSize",x,y);
			dxDrawImage(0, 0,x,y,blurShader)
		end
		dxDrawImage ( px, py, w, h,"susa_data/login_form.png",0, 0,0,tocolor(255,255,255,255), false)
		showCursor(true)
		setCameraMatrix( -2039.0190429688, 92.347702026367, 53.365600585938, -2038.2268066406, 92.829689025879, 52.991344451904)
		toggleControl("chatbox",false)
		fadeCamera(true)
		setPlayerHudComponentVisible("all",false)
	end
	addEventHandler("onClientRender",root,LoginPanel)
	
	addEventHandler("onClientResourceStart",resourceRoot,
		function()
			setElementData(localPlayer,"LoginMenu",true)
			local username, password = loadLoginFromXML()
			useredit:setText(username)
            passedit:setText(password)
			setBlurLevel(0)
		end
	)
	
	--[[bindKey("m","down",
		function()
			showCursor(not isCursorShowing())
		end
	)--]]
	
	function EnterKey(button,pr)
		if (getElementData(localPlayer,"LoginMenu")) then
			if button == "enter" and pr then
				Login()
			end
		end
	end
	addEventHandler("onClientKey",root,EnterKey)
	
	function Login()
		username = useredit:setText()
		password = passedit:setText()
		if(username == "" or password == "") then
			outputChatBox("Please insert a username and a password",255,0,255)
		else
			triggerServerEvent("LoginEvent",localPlayer,localPlayer,username,password)
		end
		
	end

	function Register()
		username = useredit:setText()
		password = passedit:setText()
		if(username == "" or password == "") then
			outputChatBox("Please insert a username and a password.",255,24,24)
		else
			triggerServerEvent("RegisterEvent",localPlayer,localPlayer,username,password)
		end
	end	
	
	function closePanel()
		removeEventHandler("onClientRender",root,LoginPanel)
		passedit:setVisibility(false)
		useredit:setVisibility(false)
		loginbutton:setVisibility(false)
		regbutton:setVisibility(false)
		fadeCamera(true)
		setCameraTarget(localPlayer)
		showCursor(false)
		toggleControl("chatbox",true)
		setPlayerHudComponentVisible("all",true)
		setElementData(localPlayer,"LoginMenu",false)
		blurShader = nil
		myScreenSource = nil
		blurStrength = 0
		toggleControl("enter_exit",true)
		toggleAllControls(true,true,true)
	end
	addEvent("closeLogin",true)
	addEventHandler("closeLogin",root,closePanel)
	
	function loadLoginFromXML()
		local xml_save_log_File = xmlLoadFile ("susa_data/userdata.xml")
		if not xml_save_log_File then
			xml_save_log_File = xmlCreateFile("susa_data/userdata.xml", "login")
		end
		local usernameNode = xmlFindChild (xml_save_log_File, "username", 0)
		local passwordNode = xmlFindChild (xml_save_log_File, "password", 0)
		if usernameNode and passwordNode  then
			return xmlNodeGetValue(usernameNode), xmlNodeGetValue(passwordNode)
		else
			return "", ""
		end
		xmlUnloadFile ( xml_save_log_File )
	end	
	
	function saveLoginToXML(username, password)
		local xml_save_log_File = xmlLoadFile ("susa_data/userdata.xml")
			if not xml_save_log_File then
				xml_save_log_File = xmlCreateFile("susa_data/userdata.xml", "login")
			end
			if (username ~= "") then
				local usernameNode = xmlFindChild (xml_save_log_File, "username", 0)
				if not usernameNode then
					usernameNode = xmlCreateChild(xml_save_log_File, "username")
				end
				xmlNodeSetValue (usernameNode, tostring(username))
			end
			if (password ~= "") then
				local passwordNode = xmlFindChild (xml_save_log_File, "password", 0)
				if not passwordNode then
					passwordNode = xmlCreateChild(xml_save_log_File, "password")
				end		
				xmlNodeSetValue (passwordNode, tostring(password))
			end
		xmlSaveFile(xml_save_log_File)
		xmlUnloadFile (xml_save_log_File)
		end
	addEvent("saveLoginToXML", true)
	addEventHandler("saveLoginToXML", getRootElement(), saveLoginToXML)