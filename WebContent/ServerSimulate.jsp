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
<title>Welcome</title>
</head>
<body>

<script>

function setInventory(productId,productName,productPrice,productQuantity,productWeight,productType) {


	var data = '{"ProductId":"' + productId + '","ProductName":"' + productName + '","Price":"' + productPrice + '","Quantity":"' + productQuantity +'","Weight":"' + productWeight  + '","Type":"' + productType + '"}';
	alert("Hi ");
	var json = JSON.parse(data);
<%
String dataBase = "Paxshal";

MongoClient setClient = new MongoClient( "localhost" , 27017 );

DB databaseSet = setClient.getDB(dataBase);

DBCollection collSet = databaseSet.getCollection("IVENTORY_LIST");

//out.println(coll);
//DBCursor cursorSet = collSet.find();
//System.out.println("Cursor is :"+cursor.next());
//DBObject document = (DBObject) json;

%>
	
//	alert("Hi "+json);
	ajaxObj = {
		type : "POST",
		headers: { 
        'Accept': 'text/html',
        'Content-Type': 'application/json' 
    },
		data : JSON.stringify(json),
		url : "http://localhost:8080/Assignment2/client/handler/write1/post/",
		datatype : "json",
		error : function(jqXHR, textStatus, errorThrown) {
			console.log(jqXHR.responseText);
		},
		success : function(data) {
			//console.log(data['success']);
			//window.location='Server_Request.jsp';
			$('#response').html(data);
		},
		complete : function(XMLHttpRequest) {
			 console.log( XMLHttpRequest.getAllResponseHeaders() );
		}
	};

	return $.ajax(ajaxObj);
}

function updateInventory(ProductID,productName,productPrice,productQuantity,productWeight,productType) {


	var data = '{"ProductName":"' + productName + '","Price":"' + productPrice + '","Quantity":"' + productQuantity + '","Weight":"' + productWeight + '","Type":"' + productType +'"}';
//	alert("Hi "+clientName);
	var json = JSON.parse(data);
//	alert("Hi "+json);
	ajaxObj = {
		type : "PUT",
		data : JSON.stringify(json),
		url : "http://localhost:8080/Assignment2/client/handler/Update1/post/"+ ProductID +"/",
		datatype : "application/html",
		error : function(jqXHR, textStatus, errorThrown) {
			console.log(jqXHR.responseText);
		},
		success : function(data) {
			//console.log(data['success']);
			//window.location='Server_Request.jsp';
			$('#response').html(data);
		},
		complete : function(XMLHttpRequest) {
			 console.log( XMLHttpRequest.getAllResponseHeaders() );
		}
	};

	return $.ajax(ajaxObj);
}
function deleteInventory(clientID) {

	//alert("Hi "+clientID);
	ajaxObj = {
		type : "DELETE",
		url : "http://localhost:8080/Assignment2/client/handler/delete1/post/"+ clientID +"/",
		datatype : "application/html",
		error : function(jqXHR, textStatus, errorThrown) {
			console.log(jqXHR.responseText);
		},
		success : function(data) {
			//console.log(data['success']);
			//window.location='Server_Request.jsp';
			$('#response').html(data);
		},
		complete : function(XMLHttpRequest) {
			 console.log( XMLHttpRequest.getAllResponseHeaders() );
		}
	};

	return $.ajax(ajaxObj);
}
</script>
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
<% String databaseB = "Paxshal";
	
MongoClient mongoClientB = new MongoClient( "localhost" , 27017 );

DB databaseBoot = mongoClientB.getDB(databaseB);

DBCollection collB = databaseBoot.getCollection("Device_List");

//out.println(coll);
DBCursor cursorB = collB.find();
//System.out.println("Cursor is :"+cursor.next());
out.println("<select id=\"clientList\">");
try{
	while(cursorB.hasNext())
	{
		
		DBObject object = cursorB.next();
	//	System.out.println("Here it is :" +cursor.next().get("_id"));
		out.println("<option value = " + object.get("_id") + ">"+object.get("_id")+"</option>");
	//	System.out.println("Here ");
	}
}
finally{
	mongoClientB.close();
	cursorB.close();
} 
out.println("/<select>");
%>
</tr>
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
<input type="submit" value="submit" onclick="factoryBS($('#clientList').val())">
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
<input type="submit" value="submit" onclick="serverBS($('#clientList').val())">
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
<div>
<table>
<tr>
<td>
Get Items (GET)
</td>
<td>
<input type="text" id="client_info" placeholder="Enter Client Name">
</td>
<td>
<input type="submit" value ="submit" onclick="getInventory($('#client_info').val())">
</td>
</tr>
<tr>
<td>
</td>
<td>
<input type="text" id="item" placeholder="Enter product Name">
</td>
<td>
<input type="submit" value ="Submit" onclick="getItem($('#client_info').val(),$('#item').val())">
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
Delete Discount (DELETE)
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
</div>
<div>
<table>
<h3>
Add new Inventory in Rack
</h3>
<table>
<tr>
<td>
Select Cart
</td>
<td>
<select id="write_item_name" name="write_item_name">
<option value="rack1">rack1</option>
<option value="rack2">rack2</option>
<option value="rack3">rack3</option>
<option value="rack4">rack4</option>
</select>
</td>
<tr>
<tr>
<td>
Product Id 
</td>
<td>
<input type="text" id="write_product_id">
</td>
</tr>
<tr>
<td>
Product Name 
</td>
<td>
<input type="text" id="write_product_name">
</td>
</tr>
<tr>
<td>
Product Price
</td>
<td>
<input type="text" id="write_product_price">
</td>
</tr>
<tr>
<td>
Product Quantity
</td>
<td>
<input type="text" id="write_product_quantity">
</td>
</tr>
<tr>
<td>
Product Weight
</td>
<td>
<input type="text" id="write_product_weight">
</td>
</tr>

<tr>
<tr>
<td>
Product Type
</td>
<td>
<input type="text" id="write_product_type">
</td>
</tr>
<tr>
<td>
</td>
<td>
<input type="submit" onclick="setInventory($('#write_product_id').val(),$('#write_product_name').val(),$('#write_product_price').val(),$('#write_product_quantity').val(),$('#write_product_weight').val(),$('#write_product_type').val())">
</td>
</tr>
</table>
</div>
<div>
<h3>
Update an Item in Rack:
</h3>
<table>
<tr>
<td>
Select Client
</td>
<td>
<select id="update_item_name" name="update_item_name">
<option value="rack1">rack1</option>
<option value="rack2">rack2</option>
<option value="rack3">rack3</option>
<option value="rack4">rack4</option>
</select>
</td>
</tr>
<tr>
<td>
Product Id
</td>
<td>
<% String databaseI = "Paxshal";
	
MongoClient mongoClientObserve = new MongoClient( "localhost" , 27017 );

DB dbObserve = mongoClientObserve.getDB(databaseI);

DBCollection collObserve = dbObserve.getCollection("INVENTORY_LIST");

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
}
out.println("/<select>");
%>
</td>
<tr>
<tr>
<td>
Product Name 
</td>
<td>
<input type="text" id="update_product_name">
</td>
</tr>
<tr>
<td>
Product Price
</td>
<td>
<input type="text" id="update_product_price">
</td>
</tr>
<tr>
<td>
Product Quantity
</td>
<td>
<input type="text" id="update_product_quantity">
</td>
</tr>

<tr>
<td>
Product Weight
</td>
<td>
<input type="text" id="update_product_weight">
</td>
</tr>
<tr>
<td>
Product Type
</td>
<td>
<input type="text" id="update_product_type">
</td>
</tr>
<tr>
<td>
</td>
<td>
<input type="submit" onclick="updateInventory($('#ID_List').val(),$('#update_product_name').val(),$('#update_product_price').val(),$('#update_product_quantity').val(),$('#update_product_weight').val(),$('#update_product_type').val())">
</td>
</tr>
</table>
</div>

<div>
<h3>
Delete an Inventory:
</h3>
<table>
<tr>
<td>
Select Cart
</td>
<td>
<select id="delete_item_name" name="delete_item_name">
<option value="rack1">rack1</option>
<option value="rack2">rack2</option>
<option value="rack3">rack3</option>
<option value="rack4">rack4</option>
</select>
</td>
</tr>

<tr>
<td>
Cart Name
</td>
<td>
<% //String database1 = "Paxshal";
	
MongoClient mongoClientObserve1 = new MongoClient( "localhost" , 27017 );

DB dbObserve1 = mongoClientObserve1.getDB(database);

DBCollection collObserve1 = dbObserve1.getCollection("INVENTORY_LIST");

DBCursor cursorObserve1 = collObserve1.find();
//System.out.println("Cursor is :"+cursor.next());
out.println("<select id=\"ProductID_List\">");
try{
	while(cursorObserve1.hasNext())
	{
		DBObject object1 = cursorObserve1.next();
	//	System.out.println("Here it is :" +cursor.next().get("_id"));
		out.println("<option value = " + object1.get("_id") + ">"+object1.get("_id")+"</option>");
	}
}
finally{
	mongoClientObserve1.close();
	cursorObserve1.close();
}
out.println("/<select>");
%>
</td>
<tr>
<td>
</td>
<td>
<input type="submit" onclick="deleteInventory($('#ProductID_List').val())">
</td>
</tr>
</table>
</div>
<br><br>Price Response <div><p id="Priceresponse"></p></div>


<br><br>Observe Response <div id="" style="overflow:scroll; height:100px"><p id="response"></p></div>
<br><br>Response : <div><p id="resp"></p></div>

<input type="submit" value="Observe" onclick="observeClient($('#ObserveID_List').val())">

<% //String database = "Paxshal";
	
MongoClient mongoClientObserve5 = new MongoClient( "localhost" , 27017 );

DB dbObserve5 = mongoClientObserve5.getDB(database);

DBCollection collObserve5 = dbObserve5.getCollection("Device_List");

DBCursor cursorObserve5 = collObserve5.find();
//System.out.println("Cursor is :"+cursor.next());
out.println("<select id=\"ObserveID_List\">");
try{
	while(cursorObserve5.hasNext())
	{
		DBObject object = cursorObserve5.next();
	//	System.out.println("Here it is :" +cursor.next().get("_id"));
		out.println("<option value = " + object.get("_id") + ">"+object.get("_id")+"</option>");
	}
}
finally{
	mongoClientObserve5.close();
	cursorObserve5.close();
	mongoClient.close();
	cursor.close();
} 
out.println("/<select>");
%>

<input type="submit" value="Cancel" onclick="cancelClient($('#ObserveID_List').val())">

</body>
<script>

function factoryBS(client) {

		ajaxObj = {
		type : "POST",
		url : "http://localhost:8080/Assignment2/restClient/ClientInfo/FactoryBS/post/",
		data : client,
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

function serverBS(client) {

	ajaxObj = {
		type : "POST",
		url : "http://localhost:8080/Assignment2/restClient/ClientInfo/FactoryBS/post/",
		data : client,
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

function getItem(clientName,item) {

	//alert("Hi"+clientName);
	ajaxObj = {
		type : "GET",
		url : "http://localhost:8080/Assignment2/restClient/ClientInfo/get/product/" + clientName +"/"+ item +"/",
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
		
		if(clientName == "Cart_007")
		{
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
		}else if(clientName == "Rack1")
		{
			//alert("here");
			 ajaxObj = {
						type : "GET",
						url : "http://localhost:8080/Assignment2/client/handler/observe/"+clientName+"/",
						datatype : "application/html",
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
							 
							ModifyReceiveMessage();
						//	PriceLimit();
						//	setTimeout(ReceiveMessage,1000);
							console.log( XMLHttpRequest.getAllResponseHeaders() );
						}
			};
					$.ajax(ajaxObj);
				    
		}
	}

	function cancelClient(clientName) {

		//alert("Hi "+clientName);
		if(clientName == "Cart_007")
		{
		ajaxObj = {
			type : "GET",
			url : "http://localhost:8080/Assignment2/restClient/ClientInfo/ClientObserveCancel/get/"+ clientName +"/",
			error : function(jqXHR, textStatus, errorThrown) {
				
			//	console.log("hey");
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
		}else if(clientName == "Rack1")
		{
			ajaxObj = {
					type : "GET",
					url : "http://localhost:8080/Assignment2/client/handler/ClientObserveCancel/get/"+ clientName +"/",
					error : function(jqXHR, textStatus, errorThrown) {
						
					//	console.log("hey");
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
				$('#response').html(data);
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

	function ModifyReceiveMessage() {
			//alert("recieve message "+i);
			ajaxObj = {
				
				type : "GET",
				url : "http://localhost:8080/Assignment2/client/handler/ContinuousInventory/",
				datatype : "application/html",
				error : function(jqXHR, textStatus, errorThrown) {
						
					console.log(jqXHR.responseText);
				},
				success : function(data) {
					// console.log("hey");
					//window.location='Home.jsp';
				//	alert("recieve message success "+JSON.stringify(data));
					$('#response').html(data);
					if(data == null)
						{
						//setTimeout(ReceiveMessage,10000);	
						return;
						//ReceiveMessage();
						}else
							{
								ModifyReceiveMessage();
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
							$('#Priceresponse').text("Observation Stopped.");
							return;
							//request.abort();
						}
					else if(x != null)
					{	
						//alert("Amount");
						$('#Priceresponse').text(data);
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