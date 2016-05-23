
	function saving(p,typ,money)
		local username = getElementData(p,"username")
		if typ == 1 then
			setElementData(p,"susa:d_licence",1)
			local f = dbQuery(db, "UPDATE accounts SET d_licence=?, money=? WHERE username=?",1 )
			dbFree(f)
		elseif typ == 2 then
			setElementData(p,"susa:b_licence",1)
			local f = dbQuery(db, "UPDATE accounts SET b_licence=?,money=? WHERE username=?",1)
			dbFree(f)
		elseif typ == 3 then
			setElementData(p,"susa:taxi",1)
			local f = dbQuery(db, "UPDATE accounts SET taxi_licence=?,money=? WHERE username=?",1)
			dbFree(f)
		elseif typ == 4 then
			setElementData(p,"susa:trash",1)
			local f = dbQuery(db, "UPDATE accounts SET bus_licence=?,money=? WHERE username=?",1)
			dbFree(f)
		elseif typ == 5 then
			setElementData(p,"susa:bus",1)
			local f = dbQuery(db, "UPDATE accounts SET trashman_licence=?,money=? WHERE username=?",1)
			dbFree(f)
		elseif typ == 6 then
			setElementData(p,"susa:tuning",1)
			local f = dbQuery(db, "UPDATE accounts SET tuning_licence=?,money=? WHERE username=?",1)
			dbFree(f)
		end
		setPlayerMoney(p,money)
	end
	addEvent("licence",true)
	addEventHandler("licence",root,saving)

	addCommandHandler("leave",
	 function(plr)
		 setElementData(plr,"susa:taxi",0)
		 setElementData(plr,"susa:bus",0)
		 setElementData(plr,"susa:trash",0)
		 outputChatBox("You successfully quit your job. Now you can accept other jobs.",plr,0,180,0,false)
	 end
)
