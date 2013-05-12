SQLHandler
	var/list/ClientsSQL=list()//list of the clients SQL
	var/Caller//the client calling it
	var/Hdebug=0//running the handler with new(number) turns on debug mode

	New(var/num)
		..()
		if(num)
			Hdebug=1

	proc/SQLInsert(var/Client,var/SQL)//readytoSQL=0//if its 1 it sends the query
		///////////////////////IF MORE THAN ONE//////////////////////////
		if(Caller)
			ClientsSQL.Add(SQL)//add the query to the list
			if(Hdebug)world<<"<font color=gray>Insert: [Caller]'s query was added list"
		else
			Caller=Client
			ClientsSQL.Add(SQL)//add the query to the list
			if(Hdebug)
				world<<"<font color=blue>Insert: [Client] is now added to the query list"


	proc/Test()
		////////////////////////////
		world<<"<font color=purple>Testing the Client and SQL"
		world<<"<font color=purple>Client: [Caller]"
		///////////////////////////
		for(var/S in ClientsSQL)
			world<<"<font color=purple>SQL[S]"



	proc/SQLExecute(var/Client)
		if(Caller==Client  && ClientsSQL.len)
			if(Hdebug)
				world<<"<font color=blue>Execute: [Client] is now getting ready to execute"
				Test()

			////////////////////////////////////////
			var/dbConnection/connector = new()
			var/dbconnection=connector.getConnection(connector.getDbi())
			/////////////////////////////////////////////

			//////////////////////////////////////////////////
			var/list/SQLquery=new/list()//loop through all the clients queries
			for(var/S in ClientsSQL)
				SQLquery.Add("[S];")//create a new query

			///////////////////////////////////////////////////
			var/constructQuery=dd_list2text(SQLquery, ;)
			if(Hdebug)world<<"<font color=blue>Executing:[constructQuery]"
			///////////////////////////////////////////////

			if(dbconnection)
				var/DBQuery/resultset = connector.runQuery(dbconnection,"START TRANSACTION;[constructQuery] COMMIT;")
				//the final ; will come from the for loop
				if(resultset)
					world << "<font color=blue>Done"
					resultset.Close(); //free up and erase data.

				else
					if(!resultset)
						resultset.Close();
						world << "<font color=red>Queries Failed.";
		else
			world<<"No Clients Found"