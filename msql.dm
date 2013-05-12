var/debug=1//to see the output from Core.dm


mob/verb/view_table()
	var/dbConnection/connector = new()
	var/dbconnection=connector.getConnection(connector.getDbi())

	if(dbconnection)
		var/DBQuery/resultset = connector.runQuery(dbconnection,"SELECT * FROM `SQLchars`")
		if(resultset.RowCount() > 0)
			while(resultset.NextRow())
				var/list/row_data = resultset.GetRowData()
				for(var/D in row_data)
					usr << "[D] = [row_data[D]]"

			resultset.Close(); //free up and erase data.


		else
			if(resultset) resultset.Close();
			src << "No Results.";


mob/verb/insert_table()
	set category="Tests"
	var/SQL="INSERT INTO `SQLchars` (ckey, name) VALUES('[ckey]', '[name]' )"
	var/SQL2="INSERT INTO `SQLchars2` (ckey, name) VALUES('[ckey]', '[name]' )"
	var/SQL3="INSERT INTO `SQLchars3` (ckey, name) VALUES('[ckey]', '[name]' )"
	var/SQL4="INSERT INTO `SQLchars4` (ckey, name) VALUES('[ckey]', '[name]' )"
	var/Client="Insert[src.ckey]"
	var/SQLHandler/S=new/SQLHandler(1)//create in debug mode
	S.SQLInsert(Client,SQL)
	S.SQLInsert(Client,SQL2)
	S.SQLInsert(Client,SQL3)
	S.SQLInsert(Client,SQL4)
	S.SQLExecute(Client)



mob/verb/create_table()
	var/SQL="CREATE TABLE SQLchars ( ckey VARCHAR(30), PRIMARY KEY(ckey))"
	var/Client="Create[src.ckey]"
	var/SQLHandler/S=new/SQLHandler(1)//this is debug mode
	S.SQLInsert(Client,SQL)
	S.SQLExecute(Client)


mob/verb/delete_table()
	var/dbConnection/connector = new()
	var/dbconnection=connector.getConnection(connector.getDbi())

	if(dbconnection)
		var/DBQuery/resultset = connector.runQuery(dbconnection,"DROP TABLE SQLchars")
		if(resultset)
			usr << "Done"

			resultset.Close(); //free up and erase data.

		else
			if(!resultset)
				resultset.Close();
				src << "Failed.";






