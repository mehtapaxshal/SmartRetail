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
<title>Smart Retail</title>
</head>
<body>
<h1>Server Simulation</h1>
<br>
<hr>
<ol>
</ol>
<h3>
BootStrap Section:
</h3>
<table>
<tr>
<td>
Factory BootStrap (Default values)
</td>
<td>
</td>
<td>
</td>
<td>
<!-- <form action="FactoryBS" method="post">-->
<input type="submit" value="submit" onclick="factoryBS()">
</td>
<tr>
<td>
Server Initiated BootStrap
</td>
<td>
</td>
<td>
</td>
<td>
<!-- <form action="ServerBS" method="post">-->
<input type="submit" value="submit" onclick="serverBS()">
</td>
</tr>
</table>
<br>
<h3>
Get Client Information Section:
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<% String database = "Paxshal";
	
MongoClient mongoClient = new MongoClient( "localhost" , 27017 );

DB db = mongoClient.getDB(database);

DBCollection coll = db.getCollection("Device_List");

//out.println(coll);
DBCursor cursor = coll.find();
//System.out.println("Cursor is :"+cursor.next());
out.println("<select id=\"clientList\">");
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
</h3>
<table>
<tr>
<td>
Items (GET)
</td>
<!-- <td>
<input type="text" id="client_info" placeholder="Enter Client Name">
</td>-->
<td>
<input type="submit" value ="submit" onclick="getInventory($('#clientList').val())">
</td>
</table>
<table>
<tr>
<td>
Get specific item
</td>
<td>
<input type="text" id="product_id" placeholder="Enter product Name">
</td>
<td>
<input type="submit" value ="Get item" onclick="getProduct($('#clientList').val(),$('#product_id').val())">
</td>
</tr>
<tr>
<td>
Discount (POST)
</td>
<td>
<input type="text" id="defaultdiscount" placeholder="Enter discount amount">
</td>
<td>
<input type="submit" value ="submit" onclick="giveDefaultDiscount($('#defaultdiscount').val(),$('#clientList').val())">
</td>
</tr>

<tr>
<td>
Extra Discount (PUT)
</td>
<td>
<input type="text" id="discount" placeholder="Enter discount amount">
</td>
<td>
<input type="submit" value ="submit" onclick="giveDiscount($('#discount').val(),$('#clientList').val())">
</td>
</tr>

<tr>
<td>
Remove Discount (DELETE)
</td>
<td>
</td>
<td>
<input type="submit" value ="submit" onclick="deleteDiscount($('#clientList').val())">
</td>
</tr>
<tr>
<td>
Set Observe attributes (PUT)
</td>
<td>
</td>
<td>
<form action="SetAttributes.jsp" method="post">
<input type="submit" value ="submit">
</form>
</td>
</tr>

<tr>
<td>
Discover Observe attributes (GET)
</td>
<td>
</td>
<td>
<form action="GetAttributes.jsp" method="post">
<input type="submit" value ="submit">
</form>
</td>
</tr>

<tr>
<td>
No. of carts currently in used (Execute-POST)
</td>
<td>
</td>
<td>
<input type="submit" value ="submit" onclick="CartCount()">
</td>
</tr>
</table>
<br><br>Observe Response <div id="" style="overflow:scroll; height:200px"><p id="response"></p></div>
<br><br>Response : <div><p id="resp"></p></div>

<input type="submit" value="Observe" onclick="observeClient($('#ID_List').val())">

<% //String database = "Paxshal";
	
MongoClient mongoClientObserve = new MongoClient( "localhost" , 27017 );

DB dbObserve = mongoClientObserve.getDB(database);

DBCollection collObserve = dbObserve.getCollection("Device_List");

List<String> myList1 = null;
DBCursor cursorObserve = collObserve.find();
//System.out.println("Cursor is :"+cursor.next());
out.println("<select id=\"ID_List\">");
try{
	while(cursorObserve.hasNext())
	{
		DBObject object = cursorObserve.next();
	//	System.out.println("Here it is :" +cursor.next().get("_id"));
		out.println("<option value = " + object.get("_id") + ">"+object.get("_id")+"</option>");
	}
}
finally{
	mongoClientObserve.close();
	cursorObserve.close();
	mongoClient.close();
	cursor.close();
} 
out.println("/<select>");
%>

<input type="submit" value="Cancel" onclick="cancelClient($('#ID_List').val())">

</body>
<script>

function factoryBS() {

	ajaxObj = {
		type : "POST",
		url : "http://localhost:8080/Assignment2/restClient/ClientInfo/FactoryBS/post/",
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

function serverBS() {

	ajaxObj = {
		type : "POST",
		url : "http://localhost:8080/Assignment2/restClient/ClientInfo/FactoryBS/post/",
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

function getInventory(clientName) {

	//alert("Hi"+clientName);
	ajaxObj = {
		type : "GET",
		url : "http://localhost:8080/Assignment2/restClient/ClientInfo/get/" + clientName +"/",
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

function getProduct(clientName,product) {

	//alert("Hi"+clientName);
	var obj = '{"clientId":"' + clientName + '","product":"' + product +'"}';
	var jsonObj = JSON.parse(obj);
	var query = JSON.stringify(jsonObj)
	ajaxObj = {
		type : "GET",
		url : "http://localhost:8080/Assignment2/restClient/ClientInfo/get/product/" + query +"/",
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

function giveDefaultDiscount(defaultdiscount,clientName) {

	//alert("Hi "+clientName +" "+ defaultdiscount);
	
	var data = '{"ClientID":"' + clientName + '","Discount":"' + defaultdiscount+'"}'; 
	var jsonData = JSON.parse(data);
	ajaxObj = {
		type : "POST",
		url : "http://localhost:8080/Assignment2/restClient/ClientInfo/DefaultDiscount/",
		data : JSON.stringify(jsonData),
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

function giveDiscount(discount,clientName) {

	//alert("Hi "+clientName +" "+ discount);
	ajaxObj = {
		type : "PUT",
		url : "http://localhost:8080/Assignment2/restClient/ClientInfo/Discount/" + clientName +"/",
		data : discount,
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

function deleteDiscount(clientName) {

	
//	var data = '{"ClientID":"' + clientName + '","Discount":"' + defaultdiscount+'"}'; 
	//var jsonData = JSON.parse(data);
	ajaxObj = {
		type : "DELETE",
		url : "http://localhost:8080/Assignment2/restClient/ClientInfo/DeleteDiscount/"+ clientName +"/",
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


function observeClient(clientName) {
var i=0;
i++;
	//alert("O C "+i);
	ajaxObj = {
		type : "GET",
		url : "http://localhost:8080/Assignment2/restClient/ClientInfo/ClientObserve/get/" + clientName +"/",
		error : function(jqXHR, textStatus, errorThrown) {
			console.log(jqXHR.responseText);
		},
		success : function(data) {
			// console.log("hey");
			//window.location='Home.jsp';
			//alert("oserve client "+data);
			$('#resp').text(data);
			
		},
		complete : function(XMLHttpRequest) {
			 
			ReceiveMessage();
			PriceLimit();
		//	setTimeout(ReceiveMessage,1000);
			console.log( XMLHttpRequest.getAllResponseHeaders() );
		}
	};

	return $.ajax(ajaxObj);
}

function cancelClient(clientName) {

	//alert("Hi "+clientName);
	ajaxObj = {
		type : "GET",
		url : "http://localhost:8080/Assignment2/restClient/ClientInfo/ClientObserveCancel/get/"+ clientName +"/",
		error : function(jqXHR, textStatus, errorThrown) {
			
			console.log("hey");
			console.log(jqXHR.responseText);
		},
		success : function(data) {
			// console.log("hey");
			//window.location='Home.jsp';
			$('#resp').text(data);
			
		},
		complete : function(XMLHttpRequest) {
			 console.log( XMLHttpRequest.getAllResponseHeaders() );
		}
	};

	return $.ajax(ajaxObj);
}

function ReceiveMessage() {
var i =0;
i++;
	//alert("recieve message "+i);
	ajaxObj = {
		
		type : "GET",
		url : "http://localhost:8080/Assignment2/restClient/ClientInfo/Continuous/",
		datatype : "application/html; application/json; charset=utf-8",
		error : function(jqXHR, textStatus, errorThrown) {
				
			console.log(jqXHR.responseText);
		},
		success : function(data) {
			// console.log("hey");
			//window.location='Home.jsp';
		//	alert("recieve message success "+JSON.stringify(data));
			$('#response').text(JSON.stringify(data));
			if(data == null)
				{
				//setTimeout(ReceiveMessage,10000);	
				return;
				//ReceiveMessage();
				}else
					{
					ReceiveMessage();
					//setTimeout(ReceiveMessage,1000);	
					}
			//$('#response').text(JSON.stringify(data));
			//ReceiveMessage();
	
		},
		complete : function(XMLHttpRequest) {
			//alert("Hi end");
			 
			console.log( XMLHttpRequest.getAllResponseHeaders() );
		}
	};

	return $.ajax(ajaxObj);
}


function PriceLimit() {

	
		ajaxObj = {
			
			type : "GET",
			url : "http://localhost:8080/Assignment2/restClient/ClientInfo/ContinuousPrice/",
			error : function(jqXHR, textStatus, errorThrown) {
					
				console.log(jqXHR.responseText);
			},
			success : function(data) {
			
				var x = $.trim(data);
				if(x == 'cancel')
					{
						$('#resp').text("Observation Stopped.");
						request.abort();
					}
				if(x != null)
				{	
					//alert("Amount");
					$('#resp').text(data);
					PriceLimit();
				}
			},
			complete : function(XMLHttpRequest) {
				//alert("Hi end");
				 
				console.log( XMLHttpRequest.getAllResponseHeaders() );
			}
		};

		return $.ajax(ajaxObj);
	}


function CartCount() {

	//alert("Hi "+clientName +" "+ defaultdiscount);

	ajaxObj = {
		type : "POST",
		url : "http://localhost:8080/Assignment2/restClient/ClientInfo/CartCount/",
		datatype : "application/html",
		error : function(jqXHR, textStatus, errorThrown) {
			console.log(jqXHR.responseText);
		},
		success : function(data) {
			//console.log(data['success']);
			//window.location='Home.jsp';
			$('#resp').html("Total number of carts currently in used are " + data);
		},
		complete : function(XMLHttpRequest) {
			 console.log( XMLHttpRequest.getAllResponseHeaders() );
		}
	};

	return $.ajax(ajaxObj);
}
</script>

</html>