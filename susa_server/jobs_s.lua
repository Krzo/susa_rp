
	function saving(p,typ,money)
		local username = getElementData(p,"username")
		if typ == 1 then
			dbQuery(db, "UPDATE accounts SET d_licence=?, money=? WHERE username=?",1 )
			setPlayerMoney(p,money)
		elseif typ == 2 then
			dbQuery(db, "UPDATE accounts SET b_licence=?,money=? WHERE username=?",1)
			setPlayerMoney(p,money)
		elseif typ == 3 then
			dbQuery(db, "UPDATE accounts SET taxi=?,money=? WHERE username=?",1)
			setPlayerMoney(p,money)
		elseif typ == 4 then
			dbQuery(db, "UPDATE accounts SET bus=?,money=? WHERE username=?",1)
			setPlayerMoney(p,money)
		elseif typ == 5 then
			dbQuery(db, "UPDATE accounts SET trash=?,money=? WHERE username=?",1)
			setPlayerMoney(p,money)
		elseif typ == 6 then
			dbQuery(db, "UPDATE accounts SET tuning=?,money=? WHERE username=?",1)
			setPlayerMoney(p,money)
		end	
	end
	addEvent("licence",true)
	addEventHandler("licence",root,saving)