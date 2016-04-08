
	function saving(p,typ,money)
		local username = getElementData(p,"username")
		if typ == 1 then
			local f = dbQuery(db, "UPDATE accounts SET d_licence=?, money=? WHERE username=?",1 )
			setPlayerMoney(p,money)
			dbFree(f)
		elseif typ == 2 then
			local f = dbQuery(db, "UPDATE accounts SET b_licence=?,money=? WHERE username=?",1)
			setPlayerMoney(p,money)
			dbFree(f)
		end	
	end
	addEvent("licence",true)
	addEventHandler("licence",root,saving)