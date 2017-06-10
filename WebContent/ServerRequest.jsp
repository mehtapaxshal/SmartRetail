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

<body onLoad="observe()">
<h1>
SMART RETAIL SHOP</h1><br>
<h3>Rack Inventory Information</h3>
<table>
<tr>
<td>
Cart Name
</td>
<td>


<select id="read_item_name" name="read_item_name">
<option value="rack1">rack1</option>
<option value="rack2">rack2</option>
<option value="rack3">rack3</option>
<option value="rack4">rack4</option>
</select>
<td>
<input type="submit" onclick="getInventory($('#read_item_name').val())">
</td>
</tr>
<tr>
<td>
Enter Product Name
</td>
<td>
<input type="text" id="read_product_name">
</td>
<td>
<input type="submit" onclick="getInventory($('#read_product_name').val())">
</td>
</tr>

</table>
<br><br>Response : <div><p id="response"></p></div>


<br>
<br>
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
<% String database = "Paxshal";
	
MongoClient mongoClientObserve = new MongoClient( "localhost" , 27017 );

DB dbObserve = mongoClientObserve.getDB(database);

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
<% String database1 = "Paxshal";
	
MongoClient mongoClientObserve1 = new MongoClient( "localhost" , 27017 );

DB dbObserve1 = mongoClientObserve1.getDB(database1);

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

<h3>
Write Attribute Module</h3>
<table>
<tr>
<td>
Observe:
</td>
<td>
<input type="text" id="occupy_value">
</td>
<td>
<input type=submit value="submit" onclick="setoccupied($('#occupy_value').val())">
</td>
</tr>
<tr>
<td>
Time Limit:
</td>
<td>
<input type="text" id="timelimit_value">
</td>
<td>
<input type=submit value="submit" onclick="settimelimit($('#timelimit_value').val())">
</td>
</tr>
<tr>
<td>
Max. Time Limit:
</td>
<td>
<input type="text" id="maxtimelimit_value">
</td>
<td>
<input type=submit value="submit" onclick="setmaxtimelimit($('#maxtimelimit_value').val())">
</td>
</tr>
<tr>
<td>
Max. Weight Limit:
</td>
<td>
<input type="text" id="weight_value_max">
</td>
<td>
<input type=submit value="submit" onclick="weightquerymax($('#weight_value_max').val())">
</td>
</tr>
<tr>
<td>
Step Size:
</td>
<td>
<input type="text" id="stepsize">
</td>
<td>
<input type=submit value="submit" onclick="stepsize($('#stepsize').val())">
</td>
</tr>

</table>

<h3>
Client Discovery
</h3>
<table>
<tr>
<td value="observe" class="Client_id">
Check observe bit
</td>

<td>

<input type="submit" onclick="discoverInventory('observe')">
</td>
</tr>
<tr>
<td>
Check time limit
</td>
<td>

<input type="submit" onclick="discoverInventory('time_limit')">
</td>
</tr>
<tr>
<td>
Check Max time limit
</td>
<td>
<input type="hidden" class = "Client_id" value="max_time_limit">
<input type="submit" onclick="discoverInventory('max_time_limit')">
</td>
</tr>
<tr>
<td>
Check Max weight limit
</td>
<td>
<input type="hidden" class = "Client_id" value="weight_limit_max">
<input type="submit" onclick="discoverInventory('weight_limit_max')">
</td>
</tr>
<tr>
<td>
Check step size
</td>
<td>
<input type="hidden" class = "Client_id" value="step_size">
<input type="submit" onclick="discoverInventory('step_size')">
</td>
</tr>

</table>
Response : <div id="discover" name="discover">

<p>Write attribute detail: </p>

</div>

<h3>
Execute:
</h3>
<table>
<tr>
<td>
Select Cart
</td>
<td>


<select id="item_name" name="item_name">
<option value="rack1">rack1</option>
<option value="rack2">rack2</option>
<option value="rack3">rack3</option>
<option value="rack4">rack4</option>
</select>
<td>
<input type="submit" onclick="executeInventory($('#item_name').val())">
</td>
</tr>
</table>
Execution : <div id="execute" name="execute">

<p>Active Cart Detail: </p>

</div>


<br><br>
Response : <div><p id="response"></p></div>
<div id="observe" name="observe" style="overflow:scroll; height:500px">
</div>

<p>Observer Details:</p>

</body>
<script>

function getInventory(clientName) {

	//alert("Hi "+clientName);
	ajaxObj = {
		type : "GET",
		url : "http://localhost:8080/Assignment2/client/handler/Read1/get/"+ clientName +"/",
		datatype : "application/html",
		error : function(jqXHR, textStatus, errorThrown) {
			console.log(jqXHR.responseText);
		},
		success : function(data) {
			//console.log(data['success']);
			//window.location='Home.jsp';
			$('#response').html(data);
		//	alert("Hello " + data);
		},
		complete : function(XMLHttpRequest) {
			 console.log( XMLHttpRequest.getAllResponseHeaders() );
		}
	};

	return $.ajax(ajaxObj);
}
</script>
<script>
var time=2000;
var arr;
function observe(){
var flag = 0;
 
//i = setInterval(function(){
       ajaxObj = {
		type : "GET",
		url : "http://localhost:8080/Assignment2/client/handler/observe",
		datatype : "application/html",
		error : function(jqXHR, textStatus, errorThrown) {
			console.log(jqXHR.responseText);
		},
		success : function(data) {
		
		arr = data.split(" ");
		time = parseInt(arr[1]);
	//	alert("success");
		/*	if (arr[1]>0 && arr[0]==1){
				//notify();
	

			}*/
			//console.log(data['success']);
			//window.location='Home.jsp';
			//$('#response').html(data);
			//alert("Hello " + data);
		//	setTimeout(observe,10000);
		},
		complete : function(XMLHttpRequest) {
		//alert("complete");
		if (arr[1]>0 && arr[0]==1){
		setInterval(notify,time);
	}	
		if(arr[2] == 1){
		alert("Salt Price is out of Range!");
		setInterval(notify,time);	
	}	 console.log( XMLHttpRequest.getAllResponseHeaders() );
		}
	};
	//alert("Time is "+time);
	$.ajax(ajaxObj);
  //  },time);  
   
   
}


function notify()
    {
    	
        ajaxObj = {
		type : "GET",
		url : "http://localhost:8080/Assignment2/client/handler/notification",
		datatype : "application/html",
		error : function(jqXHR, textStatus, errorThrown) {
			console.log(jqXHR.responseText);
		},
		success : function(data) {
			//console.log(data['success']);
			//window.location='Home.jsp';
			//$('#response').html(data);
			//alert("Hello " + data);
			$("#observe").append(data);
			//$('<iframe id="notify"/>').appendTo('#observe')
              //            .contents().find('body').append(data);
			//$("#observeframe").appendTo('#observe')
             //             .contents().find('body').append(data);
			
		},
		complete : function(XMLHttpRequest) {
			 console.log( XMLHttpRequest.getAllResponseHeaders() );
		}
	};
	$.ajax(ajaxObj);
    }
</script>
<script>

function setInventory(productId,productName,productPrice,productQuantity,productWeight,productType) {


	var data = '{"ProductId":"' + productId + '","ProductName":"' + productName + '","Price":"' + productPrice + '","Quantity":"' + productQuantity +'","Weight":"' + productWeight  + '","Type":"' + productType + '"}';
//	alert("Hi "+clientName);
	var json = JSON.parse(data);
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
</script>
<script>

function getInventory(clientName) {

	//alert("Hi "+clientName);
	ajaxObj = {
		type : "GET",
		url : "http://localhost:8080/Assignment2/client/handler/Read1/get/"+ clientName +"/",
		datatype : "application/html",
		error : function(jqXHR, textStatus, errorThrown) {
			console.log(jqXHR.responseText);
		},
		success : function(data) {
			//console.log(data['success']);
			//window.location='Home.jsp';
			$('#response').html(data);
		//	alert("Hello " + data);
		},
		complete : function(XMLHttpRequest) {
			 console.log( XMLHttpRequest.getAllResponseHeaders() );
		}
	};

	return $.ajax(ajaxObj);
}
</script>
<script>

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
</script>
<script>

function deleteInventory(clientID) {

	alert("Hi "+clientID);
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
<script>
function setoccupied(occupied) {
	
	var data = '{"Occupied":"' + occupied + '"}';
//	alert("Hi "+clientName);
	var json = JSON.parse(data);
//	alert("Hi "+json);
	ajaxObj = {
		type : "POST",
		data : JSON.stringify(json),
		url : "http://localhost:8080/Assignment2/client/handler/occupied/post/",
		datatype : "application/html",
		error : function(jqXHR, textStatus, errorThrown) {
			console.log(jqXHR.responseText);
		},
		success : function(data) {
			//console.log(data['success']);
		//	window.location='attribute.jsp';
			//$('#response').html(data);
		},
		complete : function(XMLHttpRequest) {
			 console.log( XMLHttpRequest.getAllResponseHeaders() );
		}
	};

	return $.ajax(ajaxObj);
	

}
</script>
<script>
function settimelimit(timelimit) {
	
	var data = '{"time_limit":"' + timelimit + '"}';
//	alert("Hi "+clientName);
	var json = JSON.parse(data);
//	alert("Hi "+json);
	ajaxObj = {
		type : "POST",
		data : JSON.stringify(json),
		url : "http://localhost:8080/Assignment2/client/handler/timelimit/post/",
		datatype : "application/html",
		error : function(jqXHR, textStatus, errorThrown) {
			console.log(jqXHR.responseText);
		},
		success : function(data) {
			//console.log(data['success']);
		//	window.location='attribute.jsp';
			//$('#response').html(data);
		},
		complete : function(XMLHttpRequest) {
			 console.log( XMLHttpRequest.getAllResponseHeaders() );
		}
	};

	return $.ajax(ajaxObj);
	

}
</script>
<script>
function setmaxtimelimit(maxtimelimit) {
	
	var data = '{"max_time_limit":"' + maxtimelimit + '"}';
//	alert("Hi "+clientName);
	var json = JSON.parse(data);
//	alert("Hi "+json);
	ajaxObj = {
		type : "POST",
		data : JSON.stringify(json),
		url : "http://localhost:8080/Assignment2/client/handler/maxtimelimit/post/",
		datatype : "application/html",
		error : function(jqXHR, textStatus, errorThrown) {
			console.log(jqXHR.responseText);
		},
		success : function(data) {
			//console.log(data['success']);
		//	window.location='attribute.jsp';
			//$('#response').html(data);
		},
		complete : function(XMLHttpRequest) {
			 console.log( XMLHttpRequest.getAllResponseHeaders() );
		}
	};

	return $.ajax(ajaxObj);
	

}
function weightquerymax(weightlimit) {
	
	var data = '{"weight_limit_max":"' + weightlimit + '"}';
//	alert("Hi "+clientName);
	var json = JSON.parse(data);
//	alert("Hi "+json);
	ajaxObj = {
		type : "POST",
		data : JSON.stringify(json),
		url : "http://localhost:8080/Assignment2/client/handler/weightlimitmax/post/",
		datatype : "application/html",
		error : function(jqXHR, textStatus, errorThrown) {
			console.log(jqXHR.responseText);
		},
		success : function(data) {
			//console.log(data['success']);
		//	window.location='attribute.jsp';
			//$('#response').html(data);
		},
		complete : function(XMLHttpRequest) {
			 console.log( XMLHttpRequest.getAllResponseHeaders() );
		}
	};

	return $.ajax(ajaxObj);
	

}

</script>
<script>
function weightquery(weightlimit) {
	
	var data = '{"weight_limit":"' + weightlimit + '"}';
//	alert("Hi "+clientName);
	var json = JSON.parse(data);
//	alert("Hi "+json);
	ajaxObj = {
		type : "POST",
		data : JSON.stringify(json),
		url : "http://localhost:8080/Assignment2/client/handler/weightlimit/post/",
		datatype : "application/html",
		error : function(jqXHR, textStatus, errorThrown) {
			console.log(jqXHR.responseText);
		},
		success : function(data) {
			//console.log(data['success']);
	//		window.location='attribute.jsp';
			//$('#response').html(data);
		},
		complete : function(XMLHttpRequest) {
			 console.log( XMLHttpRequest.getAllResponseHeaders() );
		}
	};

	return $.ajax(ajaxObj);
	

}
function stepsize(step) {
	
	var data = '{"step_size":"' + step + '"}';
//	alert("Hi "+clientName);
	var json = JSON.parse(data);
//	alert("Hi "+json);
	ajaxObj = {
		type : "POST",
		data : JSON.stringify(json),
		url : "http://localhost:8080/Assignment2/client/handler/stepsize/post/",
		datatype : "application/html",
		error : function(jqXHR, textStatus, errorThrown) {
			console.log(jqXHR.responseText);
		},
		success : function(data) {
			//console.log(data['success']);
		//	window.location='attribute.jsp';
			//$('#response').html(data);
		},
		complete : function(XMLHttpRequest) {
			 console.log( XMLHttpRequest.getAllResponseHeaders() );
		}
	};

	return $.ajax(ajaxObj);
	

}

</script>
<script>

function discoverInventory(clientName) {

//	alert("Hi "+clientName);
	ajaxObj = {
		type : "GET",
		url : "http://localhost:8080/Assignment2/client/handler/discover/get/"+ clientName +"/",
		datatype : "application/html",
		error : function(jqXHR, textStatus, errorThrown) {
			console.log(jqXHR.responseText);
		},
		success : function(data) {
			//console.log(data['success']);
			//window.location='Home.jsp';
			$('#response').html(data);
		//	alert("Hello " + data);
			$("#discover").html("<p>"+data+"</p>");
		},
		complete : function(XMLHttpRequest) {
			 console.log( XMLHttpRequest.getAllResponseHeaders() );
		}
	};

	return $.ajax(ajaxObj);
}
</script>
<script>

function executeInventory(clientName) {

	//alert("Hi "+clientName);
	ajaxObj = {
		type : "GET",
		url : "http://localhost:8080/Assignment2/client/handler/execute/get/"+ clientName +"/",
		datatype : "application/html",
		error : function(jqXHR, textStatus, errorThrown) {
			console.log(jqXHR.responseText);
		},
		success : function(data) {
			//console.log(data['success']);
			//window.location='Home.jsp';
			$('#execute').html(data);
		//	alert("Hello " + data);
		},
		complete : function(XMLHttpRequest) {
			 console.log( XMLHttpRequest.getAllResponseHeaders() );
		}
	};

	return $.ajax(ajaxObj);
}
</script>

</html>
