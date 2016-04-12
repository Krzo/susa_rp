	function RegisterFunc(p,username,password)
		if not (p ~= client) then
			local username = string.lower(username)
			local password = sha256(password)
			local q = dbQuery(db,"SELECT * FROM accounts WHERE username=?",username)
			local getaccs = dbPoll(q,-1)
			if getaccs and #getaccs == 0 then
				local e = dbExec(db,"INSERT INTO accounts(username,password,skin,x,y,z,money,team,d_licence,b_licence,inte,dim) VALUES (?,?,?,?,?,?,?,?,?,?,?,?)",username,password,58,-2091.23218, -109.71035, 35.32031,5500,nil,0,0,0,0)
				if e then
					--outputDebugString("INSERT successfully") -- Debug
					spawnPlayer(p,-2091.23218, -109.71035, 35.32031,180)
					setElementData(p,"loggedIN",true)
					triggerClientEvent(p,"closeLogin",p)
					setElementModel(p,58)
					setPlayerMoney(p,5500)
					setElementData(p,"username",string.lower(username))
					setElementData(p,"susa:b_licence",0)
					setElementData(p,"susa:d_licence",0)
					setElementData(p,"susa:d_licence",0)
					setElementData(p,"susa:b_licence",0)
					setElementData(p,"susa:taxi",0)
					setElementData(p,"susa:trash",0)
					setElementData(p,"susa:bus",0)
					setElementData(p,"susa:tuning",0)
					triggerClientEvent(p,"saveLoginToXML",getRootElement(),username,password)
				end
			else
				outputChatBox("This account already exists",p,180,0,0)
			end
		end
	end
	addEvent("RegisterEvent",true)
	addEventHandler("RegisterEvent",root,RegisterFunc)

	function LoginFunc(p,username,password)
		if not(p ~= client) then
			local t
			local username = string.lower(username)
			query = dbQuery(db, "SELECT * FROM accounts WHERE username = '"..username.."'")
			result = dbPoll(query, -1)
			local passwordsha = sha256(password)
			if result and #result == 1 then
				datas = result[1]
				if (datas.password == passwordsha) then
					triggerClientEvent(p,"closeLogin",p)
					local m = datas.money
					local s = datas.skin
					local tp = datas.team
					local x,y,z = datas.x,datas.y,datas.z
					local drft = datas.drift
					local inte = datas.inte
					local dim = datas.dim
					local d_licence = datas.d_licence or 0
					local b_licence = datas.b_licence or 0
					local bus_licence = datas.bus_licence or 0
					local taxi_licence = datas.taxi_licence or 0
					local trashman_licence = datas.trashman_licence or 0
					local tuning_licence = datas.tuning_licence or 0
					setElementData(p,"susa:d_licence",d_licence)
					setElementData(p,"susa:b_licence",b_licence)
					setElementData(p,"susa:taxi",taxi_licence)
					setElementData(p,"susa:trash",trashman_licence)
					setElementData(p,"susa:bus",bus_licence)
					setElementData(p,"susa:tuning",tuning_licence)
					setElementData(p,"loggedIN",true)
					setElementData(p,"username",string.lower(username))
					if tp and tp ~= nil then
						t = getTeamFromName(tp)
					else
						t = nil
					end
					triggerClientEvent(p,"saveLoginToXML",getRootElement(),username,password)
					local name = string.gsub(getPlayerName(p), "#%x%x%x%x%x%x", "")
					outputChatBox("You succcessfully logged in. Welcome, "..name.."",p,24,255,24)
					spawnPlayer(p,x,y,z,0,skin,inte,dim)
					setPlayerTeam(p,tp)
					setPlayerMoney(p,m)
					setElementDimension(p,dim)
					setElementInterior(p,inte)
					setElementModel(p,tonumber(s))
				else
					outputChatBox("Your password is not correct!",p,255,24,24)

				end
			else
				outputChatBox("This account does not exist", p,255,24,24)
			end
		end
	end
	addEvent("LoginEvent",true)
	addEventHandler("LoginEvent", root, LoginFunc)

	function onQuit ()
		local data = getElementData(source,"loggedIN")
		local username = getElementData(source,"username")
		if ( data ) then
			local money = getPlayerMoney(source)
			local skin = getElementModel ( source )
			local inte, dim = getElementInterior ( source ), getElementDimension ( source )
			local x, y, z = getElementPosition ( source )
			local d_licence,b_licence = getElementData(source,"susa:d_licence"),getElementData(source,"susa:b_licence")
			dbFree(dbQuery(db, "UPDATE accounts SET x=?, y=?, z=?, skin=?, inte=?, dim=?, money=?,d_licence=?,b_licence=? WHERE username=?", x, y, z, skin,inte,dim,money,d_licence,b_licence, username ))
		end
	end
	addEventHandler ("onPlayerQuit", root, onQuit)

		function onStop ()
		for _,v in ipairs(getElementsByType("player")) do
			local data = getElementData(v,"loggedIN")
			local username = getElementData(v,"username")
			if ( data ) then
				local money = getPlayerMoney(v)
				local skin = getElementModel ( v )
				local inte, dim = getElementInterior ( v ), getElementDimension ( v )
				local x, y, z = getElementPosition ( v )
				local d_licence,b_licence = getElementData(v,"susa:d_licence"),getElementData(v,"susa:b_licence")
				dbFree(dbQuery(db, "UPDATE accounts SET x=?, y=?, z=?, skin=?, inte=?, dim=?, money=?,d_licence=?,b_licence=? WHERE username=?", x, y, z, skin,inte,dim,money,d_licence,b_licence, username ))
			end
		end
	end
	addEventHandler ("onResourceStop", resourceRoot, onStop)
