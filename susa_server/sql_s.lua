addEventHandler("onResourceStart",resourceRoot,
	function()
		db = dbConnect("mysql","dbname=accounts;host=localhost","root","")
		if(db)then
			outputDebugString("Database: connected",3)
		else
			outputConsole("Database: not connected",1)
		end
	end
)