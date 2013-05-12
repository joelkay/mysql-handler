var// my server
	my_database = "zadmin_saotest"//database for SAO TESTS
	my_server = "178.175.140.206"
	server_port = 3306
	my_username = "saodev"
	my_password = "hyve9evyg"



dbConnection
	proc
		getDbi(databasename = my_database ,serverip = my_server,serverport = server_port)
			set background=1
			//database name can also be refered to as
			//the schema or inital catalog - i use one named byond.

			//server ip can be a host name. Set for localhost, only change if remote.

			//serverport is 3306. No need to set this unless you changed.

			var/dbi = "dbi:mysql:[databasename]:[serverip]:[serverport]"
			return dbi



		getConnection(dbi,username = my_username,password = my_password) //returns the connection or null.
			set background=1
			//world<<"[dbi],[username],[password]"

			var/DBConnection/dbcon = new()  //This is an instance of a connection object.
			                                         //See db.html for more info on callable functions
			dbcon.Connect(dbi,username,password)
			if(dbcon.IsConnected())

				world.log << text("Connected to mysql using the dbi [].</font>",dbi)
				return dbcon

			//add logging here

			world.log << text("The connection to mysql failed using the dbi [].\n\nError Text: []</font>",dbi,dbcon.ErrorMsg())

			return null


		runQuery(DBConnection/dbcon,querytext = null) //returns the set or null
			set background=1
			if(dbcon != null && dbcon.IsConnected() && querytext !=null) //check if we are connected, and if the query is not empty.

				//var/sanitised=dbcon.Quote(querytext)
				var/DBQuery/query = dbcon.NewQuery(querytext)
				//sanitise the query and pass it through
				if(debug) world<<"[querytext]"
				query.Execute()
				return query

			world.log << text("The mysql query has failed.\n\nError Text: []</font>",dbcon.ErrorMsg())
			return null







