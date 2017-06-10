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
<title>Set Attributes</title>
</head>
<body>
<h1>Set Client's Observe Attributes</h1>
<br>
<hr>
<ol>
</ol>
<table>
<tr>
<td>
</td>
<td>
<% String database = "Paxshal";	
MongoClient mongoClient = new MongoClient( "localhost" , 27017 );

DB db = mongoClient.getDB(database);

DBCollection coll = db.getCollection("Device_List");

//out.println(coll);
DBCursor cursor = coll.find();
//System.out.println("Cursor is :"+cursor.next());
out.println("<select name=\"clientList\" id=\"clientList\">");
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
//	mongoClient.close();
	//cursor.close();
} 
out.println("/<select>");
%>
</td>
</tr>
<tr>
<td>
Notification Time (seconds)
</td>
<td>
<input type="text" id="NotifyTime">
</td>
<td>
<input type="submit" value="Set Time" onclick="SetTime($('#NotifyTime').val(),$('#clientList').val())">
</td>
</tr>
<tr>
<td>
Maximum Price (dollars)
</td>
<td>
<input type="text" id="MaxPrice">
</td>
<td>
<input type="submit" value="Set Limit" onclick="SetPrice($('#MaxPrice').val(),$('#clientList').val())">
</td>
</tr>
<tr>
<td>
Maximum Weight
</td>
<td>
<input type="text" id="MaxWeight">
</td>
<td>
<input type="submit" value="Set Limit" onclick="SetWeight($('#MaxWeight').val(),$('#clientList').val())">
</td>
</tr>
<tr>
<td>
Step
</td>
<td>
<input type="text" id="step">
</td>
<td>
<input type="submit" value="Set Limit" onclick="SetStep($('#step').val(),$('#clientList').val())">
</td>
</tr>
<tr>
<td>
</td>
<td>
<input type="submit" value="Submit" onclick="allAttributes($('#NotifyTime').val(),$('#MaxPrice').val(),$('#clientList').val(),$('#MaxWeight').val(),$('#step').val())">
</td>
</tr>
</table>
<br><br>Response : <div><p id="resp"></p></div>
</body>
<script>

function SetTime(NotifyTime,clientName) {

	//alert(clientName);
	if(clientName == "Cart_007")
	{
	ajaxObj = {
		type : "PUT",
		url : "http://localhost:8080/Assignment2/restClient/ClientInfo/TimeParameter/put/",
		data : NotifyTime,
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
	}else if(clientName == "Rack1")
	{
		ajaxObj = {
			type : "PUT",
			url : "http://localhost:8080/Assignment2/client/handler/TimeParameter/put/",
			data : NotifyTime,
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

function SetPrice(MaxPrice,clientName) {

	//alert("Hi"+clientName);
	
	ajaxObj = {
		type : "PUT",
		url : "http://localhost:8080/Assignment2/restClient/ClientInfo/MaxPrice/put/",
		data : MaxPrice,
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

function allAttributes(NotifyTime,MaxPrice,clientName,MaxWeight,Step) {

	//alert("Hi"+clientName);
	if(clientName == "Cart_007")
	{	
	ajaxObj = {
		type : "PUT",
		url : "http://localhost:8080/Assignment2/restClient/ClientInfo/allAttributes/put/" + NotifyTime +"/",
		data : MaxPrice,
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
	}else if(clientName == "Rack1")
	{	
		ajaxObj = {
			type : "PUT",
			url : "http://localhost:8080/Assignment2/client/handler/allAttributes/put/" +MaxWeight+"/",
			data : Step,
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


function SetWeight(MaxWeight,clientName) {

	ajaxObj = {
			type : "PUT",
			url : "http://localhost:8080/Assignment2/client/handler/MaxWeight/put/",
			data : MaxWeight,
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
	
function SetStep(step,clientName) {

	ajaxObj = {
			type : "PUT",
			url : "http://localhost:8080/Assignment2/client/handler/Step/put/",
			data : step,
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