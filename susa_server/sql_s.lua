addEventHandler("onResourceStart",resourceRoot,
	function()
		db = dbConnect("mysql","dbname=accounts;host=localhost","root","")
		if(db)then
			outputServerLog("Database: connected")
		else
			outputServerLog("Database: not connected")
		end
	end
)
