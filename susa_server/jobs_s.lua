
	function saving(p,typ,money)
		local username = getElementData(p,"username")
		if typ == 1 then
			local f = dbQuery(db, "UPDATE accounts SET d_licence=?, money=? WHERE username=?",1 )
			dbFree(f)
		elseif typ == 2 then
			local f = dbQuery(db, "UPDATE accounts SET b_licence=?,money=? WHERE username=?",1)
			dbFree(f)
		elseif typ == 3 then
			local f = dbQuery(db, "UPDATE accounts SET taxi_licence=?,money=? WHERE username=?",1)
			dbFree(f)
		elseif typ == 4 then
			local f = dbQuery(db, "UPDATE accounts SET bus_licence=?,money=? WHERE username=?",1)
			dbFree(f)
		elseif typ == 5 then
			local f = dbQuery(db, "UPDATE accounts SET trashman_licence=?,money=? WHERE username=?",1)
			dbFree(f)
		elseif typ == 6 then
			local f = dbQuery(db, "UPDATE accounts SET tuning_licence=?,money=? WHERE username=?",1)
			dbFree(f)
		end
		setPlayerMoney(p,money)
	end
	addEvent("licence",true)
	addEventHandler("licence",root,saving)
