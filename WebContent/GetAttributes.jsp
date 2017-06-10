<%@page import="com.sun.xml.txw2.Document"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@page import="com.mongodb.*" %>
<%@page import="java.util.*" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.0/jquery.min.js"></script>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Get Attributes</title>
</head>
<body>
<h1>Get Client's Observe Attributes</h1>
<br>
<hr>
<ol>
</ol>
<table>
<tr>
<td>
Select Client:
</td>
<td>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</td>
<td>
<% String database = "Paxshal";
	
MongoClient mongoClient = new MongoClient( "localhost" , 27017 );

DB db = mongoClient.getDB(database);

DBCollection coll = db.getCollection("Device_List");

//out.println(coll);
DBCursor cursor = coll.find();
//System.out.println("Cursor is :"+cursor.next());
out.println("<select id=\"ClientName\">");
try{
	while(cursor.hasNext())
	{
		
		DBObject object = cursor.next();
	//	System.out.println("Here it is :" +cursor.next().get("_id"));
		out.println("<option value = " + object.get("_id") + ">"+object.get("_id")+"</option>");
	//	System.out.println("Here ");
	}
}
finally{
	mongoClient.close();
	cursor.close();
} 
out.println("/<select>");
%>
</td>
</tr>
<tr>
<td>
Get Notification Time
</td>
<td>
</td>
<td>
<input type="submit" value="Get Time" onclick="GetTime($('#ClientName').val(),'time_limit')">
</td>
</tr>
<tr>
<td>
Get Price Limit
</td>
<td>
</td>
<td>
<input type="submit" value="Get Limit" onclick="GetPrice($('#ClientName').val())">
</td>
</tr>
<tr>
<td>
Get Weight Attribute
</td>
<td>
</td>
<td>
<input type="submit" value="Get Weight" onclick="GetTime($('#ClientName').val(),'weight_limit_max')">
</td>
</tr>
<tr>
<td>
Get Step size
</td>
<td>
</td>
<td>
<input type="submit" value="Get Step" onclick="GetTime($('#ClientName').val(),'step_size')">
</td>
</tr>
</table>
<br><br>Response : <div><p id="resp"></p></div>
</body>
<script>

function GetTime(ClientName,value) {

	if(ClientName == "Cart_007")
	{
	ajaxObj = {
		type : "GET",
		url : "http://localhost:8080/Assignment2/restClient/ClientInfo/TimeParameter/get/"+ClientName+"/",
		datatype : "application/html",
		error : function(jqXHR, textStatus, errorThrown) {
			console.log(jqXHR.responseText);
		},
		success : function(data) {
			//console.log(data['success']);
			//window.location='Home.jsp';
			$('#resp').html(data);
		},
		complete : function(XMLHttpRequest) {
			 console.log( XMLHttpRequest.getAllResponseHeaders() );
		}
	};

	return $.ajax(ajaxObj);
	}else if(ClientName == "Rack1")
		{
		
		ajaxObj = {
				type : "GET",
				url : "http://localhost:8080/Assignment2/client/handler/discover/get/"+value+"/",
				datatype : "application/html",
				error : function(jqXHR, textStatus, errorThrown) {
					console.log(jqXHR.responseText);
				},
				success : function(data) {
					//console.log(data['success']);
					//window.location='Home.jsp';
					$('#resp').html(data);
				},
				complete : function(XMLHttpRequest) {
					 console.log( XMLHttpRequest.getAllResponseHeaders() );
				}
			};

			return $.ajax(ajaxObj);
		
		}
}

function GetPrice(ClientName) {

	//alert("Hi"+clientName);
	ajaxObj = {
		type : "GET",
		url : "http://localhost:8080/Assignment2/restClient/ClientInfo/MaxPrice/get/"+ClientName+"/",
		datatype : "application/html",
		error : function(jqXHR, textStatus, errorThrown) {
			console.log(jqXHR.responseText);
		},
		success : function(data) {
			//console.log(data['success']);
			//window.location='Home.jsp';
			$('#resp').html(data);
		},
		complete : function(XMLHttpRequest) {
			 console.log( XMLHttpRequest.getAllResponseHeaders() );
		}
	};

	return $.ajax(ajaxObj);
}
</script>
</html>