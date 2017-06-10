<%@page import="com.sun.xml.txw2.Document"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@page import="com.mongodb.*" %>
<%@page import="java.util.*" %>

<!DOCTYPE html>
<!--[if lt IE 7]>      <html class="no-js lt-ie9 lt-ie8 lt-ie7"> <![endif]-->
<!--[if IE 7]>         <html class="no-js lt-ie9 lt-ie8"> <![endif]-->
<!--[if IE 8]>         <html class="no-js lt-ie9"> <![endif]-->
<!--[if gt IE 8]><!--> <html class="no-js"> <!--<![endif]-->
	<head>
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<title>Smart Retail Store</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css" integrity="sha384-1q8mTJOASx8j1Au+a5WDVnPi2lkFfwwEAa8hDDdjZlpLegxhjVME1fgjWPGmkzs7" crossorigin="anonymous">

<!-- Optional theme -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap-theme.min.css" integrity="sha384-fLW2N01lMqjakBkx3l/M9EahuwpSfeNvV63J5ezn3uZzapT0u7EYsXMjQV+0En5r" crossorigin="anonymous">

<!-- Latest compiled and minified JavaScript -->
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js" integrity="sha384-0mSbJDEHialfmuBBQP6A4Qrprq5OVfW37PRR3j5ELqxss1yVqOtnepnHVP9aJ7xS" crossorigin="anonymous"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.0/jquery.min.js"></script>


	<!-- Place favicon.ico and apple-touch-icon.png in the root directory -->
	

	<link href='https://fonts.googleapis.com/css?family=Source+Sans+Pro:400,300,600,400italic,700' rel='stylesheet' type='text/css'>
	
	<!-- Animate.css -->
	<link rel="stylesheet" href="css/animate.css"/>
	<!-- Icomoon Icon Fonts-->
	<link rel="stylesheet" href="./css/icomoon.css">
	<!-- Simple Line Icons -->
	<link rel="stylesheet" href="./css/simple-line-icons.css">
	<!-- Owl Carousel -->
	<link rel="stylesheet" href="./css/owl.carousel.min.css">
	<link rel="stylesheet" href="./css/owl.theme.default.min.css">
	<!-- Bootstrap  -->
	<link rel="stylesheet" href="./css/bootstrap.css">

	<link rel="stylesheet" href="./css/style.css">

	<!-- Styleswitcher ( This style is for demo purposes only, you may delete this anytime. ) -->
	<link rel="stylesheet" id="theme-switch" href="./css/style.css">
	<!-- End demo purposes only -->


	<style>
	/* For demo purpose only */
	
	/* For Demo Purposes Only ( You can delete this anytime :-) */
	#colour-variations {
		padding: 10px;
		-webkit-transition: 0.5s;
	  	-o-transition: 0.5s;
	  	transition: 0.5s;
		width: 140px;
		position: fixed;
		left: 0;
		top: 100px;
		z-index: 999999;
		background: #fff;
		/*border-radius: 4px;*/
		border-top-right-radius: 4px;
		border-bottom-right-radius: 4px;
		-webkit-box-shadow: 0 0 9px 0 rgba(0,0,0,.1);
		-moz-box-shadow: 0 0 9px 0 rgba(0,0,0,.1);
		-ms-box-shadow: 0 0 9px 0 rgba(0,0,0,.1);
		box-shadow: 0 0 9px 0 rgba(0,0,0,.1);
	}
	#colour-variations.sleep {
		margin-left: -140px;
	}
	#colour-variations h3 {
		text-align: center;;
		font-size: 11px;
		letter-spacing: 2px;
		text-transform: uppercase;
		color: #777;
		margin: 0 0 10px 0;
		padding: 0;;
	}
	#colour-variations ul,
	#colour-variations ul li {
		padding: 0;
		margin: 0;
	}
	#colour-variations li {
		list-style: none;
		display: inline;
	}
	#colour-variations li a {
		width: 20px;
		height: 20px;
		position: relative;
		float: left;
		margin: 5px;
	}
	#colour-variations li a[data-theme="style"] {
		background: #6173f4;
	}
	#colour-variations li a[data-theme="pink"] {
		background: #f64662;
	}
	#colour-variations li a[data-theme="blue"] {
		background: #2185d5;
	}
	#colour-variations li a[data-theme="turquoise"] {
		background: #00b8a9;
	}
	#colour-variations li a[data-theme="orange"] {
		background: #ff6600;
	}
	#colour-variations li a[data-theme="lightblue"] {
		background: #5585b5;
	}
	#colour-variations li a[data-theme="brown"] {
		background: #a03232;
	}
	#colour-variations li a[data-theme="green"] {
		background: #65d269;
	}

	.option-toggle {
		position: absolute;
		right: 0;
		top: 0;
		margin-top: 5px;
		margin-right: -30px;
		width: 30px;
		height: 30px;
		background: #f64662;
		text-align: center;
		border-top-right-radius: 4px;
		border-bottom-right-radius: 4px;
		color: #fff;
		cursor: pointer;
		-webkit-box-shadow: 0 0 9px 0 rgba(0,0,0,.1);
		-moz-box-shadow: 0 0 9px 0 rgba(0,0,0,.1);
		-ms-box-shadow: 0 0 9px 0 rgba(0,0,0,.1);
		box-shadow: 0 0 9px 0 rgba(0,0,0,.1);
	}
	.option-toggle i {
		top: 2px;
		position: relative;
	}
	.option-toggle:hover, .option-toggle:focus, .option-toggle:active {
		color:  #fff;
		text-decoration: none;
		outline: none;
	}
	</style>
	<!-- End demo purposes only -->


	<!-- Modernizr JS -->
	<script src="js/modernizr-2.6.2.min.js"></script>
	<!-- FOR IE9 below -->
	<!--[if lt IE 9]>
	<script src="js/respond.min.js"></script>
	<![endif]-->

	</head>
	<body>
	
	<script>

	var json;
function setInventory(productId,productName,productPrice,productQuantity,productWeight,productType) {


	var data = '{"ProductId":"' + productId + '","ProductName":"' + productName + '","Price":"' + productPrice + '","Quantity":"' + productQuantity +'","Weight":"' + productWeight  + '","Type":"' + productType + '"}';

	json = JSON.parse(data);
	
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
			$('#respGet').html(data);
		},
		complete : function(XMLHttpRequest) {
			 
			SaveServer();
			
			console.log( XMLHttpRequest.getAllResponseHeaders() );
		}
	};

	return $.ajax(ajaxObj);
}


function SaveServer() {


	ajaxObj = {
		type : "POST",
		headers: { 
        'Accept': 'text/html',
        'Content-Type': 'application/json' 
    },
		data : JSON.stringify(json),
		url : "http://localhost:8080/Assignment2/rest/client/SetInventory/post/",
		datatype : "json",
		error : function(jqXHR, textStatus, errorThrown) {
			console.log(jqXHR.responseText);
		},
		success : function(data) {
			//console.log(data['success']);
			//window.location='Server_Request.jsp';
			//$('#respGet').html(data);
		},
		complete : function(XMLHttpRequest) {
			
			console.log( XMLHttpRequest.getAllResponseHeaders() );
		}
	};

	return $.ajax(ajaxObj);
}

var json1;
var ProductIDs;
function updateInventory(ProductID,productName,productPrice,productQuantity,productWeight,productType) {

	ProductIDs = ProductID;
	var data = '{"ProductName":"' + productName + '","Price":"' + productPrice + '","Quantity":"' + productQuantity + '","Weight":"' + productWeight + '","Type":"' + productType +'"}';
//	alert("Hi "+clientName);
	json1 = JSON.parse(data);
//	alert("Hi "+json);
	ajaxObj = {
		type : "PUT",
		data : JSON.stringify(json1),
		url : "http://localhost:8080/Assignment2/client/handler/Update1/post/"+ ProductID +"/",
		datatype : "application/html",
		error : function(jqXHR, textStatus, errorThrown) {
			console.log(jqXHR.responseText);
		},
		success : function(data) {
			//console.log(data['success']);
			//window.location='Server_Request.jsp';
			$('#respGet').html(data);
		},
		complete : function(XMLHttpRequest) {
			 
			UpdateServer();
			console.log( XMLHttpRequest.getAllResponseHeaders() );
		}
	};

	return $.ajax(ajaxObj);
}

function UpdateServer() {


	ajaxObj = {
		type : "PUT",
		headers: { 
        'Accept': 'text/html',
        'Content-Type': 'application/json' 
    },
		data : JSON.stringify(json1),
		url : "http://localhost:8080/Assignment2/rest/client/UpdateInventory/post/"+ ProductIDs+"/",
		datatype : "json",
		error : function(jqXHR, textStatus, errorThrown) {
			console.log(jqXHR.responseText);
		},
		success : function(data) {
			//console.log(data['success']);
			//window.location='Server_Request.jsp';
			//$('#respGet').html(data);
		},
		complete : function(XMLHttpRequest) {
			
			console.log( XMLHttpRequest.getAllResponseHeaders() );
		}
	};

	return $.ajax(ajaxObj);
}


var productDelete;
function deleteInventory(clientID) {

	productDelete = clientID;
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
			$('#respGet').html(data);
		},
		complete : function(XMLHttpRequest) {
			
			DeleteServer(); 
			console.log( XMLHttpRequest.getAllResponseHeaders() );
		}
	};

	return $.ajax(ajaxObj);
}

function DeleteServer() {


	ajaxObj = {
		type : "DELETE",
		url : "http://localhost:8080/Assignment2/rest/client/DeleteInventory/post/"+ productDelete+"/",
		datatype : "json",
		error : function(jqXHR, textStatus, errorThrown) {
			console.log(jqXHR.responseText);
		},
		success : function(data) {
			//console.log(data['success']);
			//window.location='Server_Request.jsp';
			//$('#respGet').html(data);
		},
		complete : function(XMLHttpRequest) {
			
			console.log( XMLHttpRequest.getAllResponseHeaders() );
		}
	};

	return $.ajax(ajaxObj);
}

</script>
	<header role="banner" id="fh5co-header">
			<div class="container">
				<!-- <div class="row"> -->
			    <nav class="navbar navbar-default">
		        <div class="navbar-header">
		        	<!-- Mobile Toggle Menu Button -->
					<a href="#" class="js-fh5co-nav-toggle fh5co-nav-toggle" data-toggle="collapse" data-target="#navbar" aria-expanded="false" aria-controls="navbar"><i></i></a>
		          	<a class="navbar-brand" href="index.html">Smart Retail Shop</a> 
		        </div>
		        <div id="navbar" class="navbar-collapse collapse">
		          <ul class="nav navbar-nav navbar-right">
		            <li class="active"><a href="#" data-nav-section="home"><span>Home</span></a></li>
		            <li><a href="#" data-nav-section="about"><span>About</span></a></li>
		            <li><a href="#" data-nav-section="services"><span>Services</span></a></li>
		            <li><a href="#" data-nav-section="features"><span>Features</span></a></li>
		            <li><a href="#" data-nav-section="testimonials"><span>Testimonials</span></a></li>
		            <li><a href="#" data-nav-section="pricing"><span>Pricing</span></a></li>
		            <li><a href="#" data-nav-section="press"><span>Press</span></a></li>
		          </ul>
		        </div>
			    </nav>
			  <!-- </div> -->
		  </div>
	</header>

		<!-- You may change the background color here. -->
		
		    <div class="item" style="background: #352f44;">
		    	<div class="container" style="position: relative;margin-top:50px">
		    		
			    			<div class="fh5co-owl-text-wrap">
						    	<div class="fh5co-owl-text">
						    		<h1 class="fh5co-lead to-animate" style="margin-top:200px;"></h1>

					<div class="row">
					<div class="col-xs-6 col-sm-6 col-md-6">
<h3 style="color:white">
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
						<br><br>
						</div>
						<div class="col-xs-6 col-sm-6 col-md-6">
						<h2 style="color:white">Response : <div><p style="color:white; font-size:large" id="resp"></p></h2>
						</div>
						
						
						
						
	</div>					
<!--  -->						
</div>

						    	</div>
						   </div>
		    		</div>
		    	
			
		    
		</div>
	</div>
	
	<div id="fh5co-about-us" data-section="about">
		<div class="container">
			<div class="row row-bottom-padded-lg" id="about-us">
				<div class="col-md-12 section-heading text-center">
					<div class="row">
					<div class="col-xs-6 col-sm-6 col-md-6">
					
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
</table>

</div>

					<div class=""  style="float:left">
					Response : <div><p id="respGet"></p>
	</div>
</div>
					<div class="row">
						<div class="col-md-12 col-md-offset-2 to-animate">
							<p id="response"></p>
						</div>
					</div>
				</div>
				<div class="col-md-4 to-animate">
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
</table></center>

				</div>
				<div class="col-md-4 to-animate">
<center><h3>
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
<% String database = "Paxshal";
	
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

</center>
				</div>
				<div class="col-md-4 to-animate">
<center><h3>
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
</center>
				</div>
			</div>
			
		</div>
	</div>
	<div id="fh5co-our-services" data-section="services">
		<div class="container">
			<div class="row row-bottom-padded-sm">
				<div class="col-md-12 section-heading text-center">
					<h2 class="to-animate">Discount: <div></h2>
					<div class="row">
						
					</div>
<center>
<table>
<tr>
<td>
Select Client
</td>
<td>
&nbsp;&nbsp;&nbsp;&nbsp;
</td>
<td>
<% //String databaseB = "Paxshal";
	
MongoClient mongoClientDiscount = new MongoClient( "localhost" , 27017 );

DB databaseDiscount = mongoClientDiscount.getDB(databaseB);

DBCollection collDiscount = databaseDiscount.getCollection("Device_List");

//out.println(coll);
DBCursor cursorDiscount = collDiscount.find();
//System.out.println("Cursor is :"+cursor.next());
out.println("<select id=\"clientList\">");
try{
	while(cursorDiscount.hasNext())
	{
		
		DBObject object = cursorDiscount.next();
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
</td>
</tr>
</table>
</center>
				</div>

				<div class="col-md-4 to-animate">

<table>
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
</table></div>
				<div class="col-md-4 to-animate">
<center>
<table>
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

</table>

</center>
				</div>
				<div class="col-md-4 to-animate">
<center>
<table>
<tr>
<td>
Delete Discount (DELETE)
</td>
<td>
</td>
<td>
<input type="submit" value ="submit" onclick="deleteDiscount($('#clientList').val())">
</td>
</tr></table>

</center>
				</div>
			</div>
			<div class="col-md-4 col-md-offset-2 to-animate">Response : 
							<p id="respDiscount"></p>
						</div>
			</div>	
			
	</div>
	
	<div id="fh5co-features" data-section="features">
		<div class="container">
			<div class="row">
				<div class="col-md-12 section-heading text-center">
					<h2 class="single-animate animate-features-1">Set Attributes</h2>
					<div class="row">
						<div class="col-md-8 col-md-offset-2 single-animate animate-features-2">
							<h3>Set Attributes testing</h3>
						</div>
					</div>
				</div>
			</div>
			<div class="row row-bottom-padded-sm">
				<div style="float:left;" class="col-md-4 to-animate">
<table>
<tr>
<td>
Select Client:
</td>
<td>
<% //String database = "Paxshal";	
MongoClient mongoClient = new MongoClient( "localhost" , 27017 );

DB db = mongoClient.getDB(database);

DBCollection coll = db.getCollection("Device_List");

//out.println(coll);
DBCursor cursor = coll.find();
//System.out.println("Cursor is :"+cursor.next());
out.println("<select name=\"clientListSet\" id=\"clientListSet\">");
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
<input type="submit" value="Set Time" onclick="SetTime($('#NotifyTime').val(),$('#clientListSet').val())">
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
<input type="submit" value="Set Limit" onclick="SetPrice($('#MaxPrice').val(),$('#clientListSet').val())">
</td>
</tr>
<tr>
<td>
Quantity
</td>
<td>
<input type="text" id="MinQuant">
</td>
<td>
<input type="submit" value="Set Limit" onclick="SetWeight($('#MinQuant').val(),$('#clientListSet').val())">
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
<input type="submit" value="Set Limit" onclick="SetStep($('#step').val(),$('#clientListSet').val())">
</td>
</tr>
<tr>
<td>
</td>
<td>
<input type="submit" value="Submit" onclick="allAttributes($('#NotifyTime').val(),$('#MaxPrice').val(),$('#clientListSet').val(),$('#MinQuant').val(),$('#step').val())">
</td>
</tr>
</table>
</div>
				<div style="float:right;" class="col-md-4 to-animate">
<center>
<table>
<tr>
<td>
Select Client:
</td>
<td>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</td>
<td>
<% //String database1 = "Paxshal";
	
MongoClient mongoClient1 = new MongoClient( "localhost" , 27017 );

DB db1 = mongoClient1.getDB(database);

DBCollection coll1 = db1.getCollection("Device_List");

//out.println(coll);
DBCursor cursor1 = coll1.find();
//System.out.println("Cursor is :"+cursor.next());
out.println("<select id=\"ClientName\">");
try{
	while(cursor1.hasNext())
	{
		
		DBObject object = cursor1.next();
	//	System.out.println("Here it is :" +cursor.next().get("_id"));
		out.println("<option value = " + object.get("_id") + ">"+object.get("_id")+"</option>");
	//	System.out.println("Here ");
	}
}
finally{
	mongoClient1.close();
	cursor1.close();
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
Get Quantity Attribute
</td>
<td>
</td>
<td>
<input type="submit" value="Get Quantity" onclick="GetTime($('#ClientName').val(),'quantity')">
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

</center>
				</div>
	
	
			</div>
		
	<div class="col-xs-6 col-sm-6 col-md-6">
						<h2 style="color:black">Response : <div><p id="respdiscover"></p></h2>
						</div>
							
		</div>
	</div>

	<div id="fh5co-testimonials" data-section="testimonials">		
		<div class="container">
			<div class="row">
				<div class="col-md-12 section-heading text-center">
					<h2 class="to-animate">Observe</h2>
					<div class="row">
						<div class="col-md-8 col-md-offset-2 subtext to-animate">
							<h3>Far far away, behind the word mountains, far from the countries Vokalia and Consonantia, there live the blind texts.</h3>
										
				
						</div>
					</div>
				</div>
			</div>
					<div style="float: left;" class="col-md-4 to-animate">

<center>
<table>
<tr>
<td>
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
</td>
</tr>
</table>
</center>
</div>
<div style="float: right;" class="col-md-4 to-animate">
					
				<h3 style="color:white;">Response : </h3><div><p style="color:white;" id="respOk"></p></div>

				</div>
				
<div class="row">
				<div class="col-md-12">
					
				
				<br><br><h3 style="color:white;">Response from Cart :</h3> <div><p></p></div>

<div id="respObserve" name="observe" style="margin-left:70px;overflow:scroll;width:90%; height:200px; border:2px solid black;color:white;">

</div>
				</div>
				
				<div class="col-md-12">
					
				
				<br><br><h3 style="color:white;">Response from Inventory :</h3> <div><p></p></div>

<div id="respObserveInventory" name="observe" style="margin-left:70px;overflow:scroll;width:90%; height:200px; border:2px solid black;color:white;">

</div>
				</div>

	<div class="col-md-12">
					
		<br><br>		
<div id="respObservePrice" name="observe" style="color:white;">

</div>
				</div>
			</div>
			
		</div>
	</div>

	<div id="fh5co-pricing" data-section="pricing">
		<div class="container">
			<div class="row">
				<div class="col-md-12 section-heading text-center">
					<h2 class="single-animate animate-pricing-1">Execute</h2>
					<div class="row">
						<div class="col-md-8 col-md-offset-2 subtext single-animate animate-pricing-2">
							<h3>Far far away, behind the word mountains, far from the countries Vokalia and Consonantia, there live the blind texts.</h3>
						</div>
					</div>
				</div>
			</div>
			<div class="row">
			<table>
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
		</div>
	</div>

	<div id="fh5co-press" data-section="press">
		<div class="container">
			<div class="row">
				<div class="col-md-12 section-heading text-center">
					<h2 class="single-animate animate-press-1">Press Releases</h2>
					<div class="row">
						<div class="col-md-8 col-md-offset-2 subtext single-animate animate-press-2">
							<h3>Far far away, behind the word mountains, far from the countries Vokalia and Consonantia, there live the blind texts.</h3>
						</div>
					</div>
				</div>
			</div>
			<div class="row">
				<div class="col-md-6">
					<!-- Press Item -->
					<div class="fh5co-press-item to-animate">
						<div class="fh5co-press-img" style="background-image: url(images/img_7.jpg)">
						</div>
						<div class="fh5co-press-text">
							<h3 class="h2 fh5co-press-title">Simplicity <span class="fh5co-border"></span></h3>
							<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Veritatis eius quos similique suscipit dolorem cumque vitae qui molestias illo accusantium...</p>
							<p><a href="#" class="btn btn-primary btn-sm">Learn more</a></p>
						</div>
					</div>
					<!-- Press Item -->
				</div>

				<div class="col-md-6">
					<!-- Press Item -->
					<div class="fh5co-press-item to-animate">
						<div class="fh5co-press-img" style="background-image: url(images/img_8.jpg)">
						</div>
						<div class="fh5co-press-text">
							<h3 class="h2 fh5co-press-title">Versatile <span class="fh5co-border"></span></h3>
							<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Veritatis eius quos similique suscipit dolorem cumque vitae qui molestias illo accusantium...</p>
							<p><a href="#" class="btn btn-primary btn-sm">Learn more</a></p>
						</div>
					</div>
					<!-- Press Item -->
				</div>
				
				<div class="col-md-6">
					<!-- Press Item -->
					<div class="fh5co-press-item to-animate">
						<div class="fh5co-press-img" style="background-image: url(images/img_9.jpg);">
						</div>
						<div class="fh5co-press-text">
							<h3 class="h2 fh5co-press-title">Aesthetic <span class="fh5co-border"></span></h3>
							<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Veritatis eius quos similique suscipit dolorem cumque vitae qui molestias illo accusantium...</p>
							<p><a href="#" class="btn btn-primary btn-sm">Learn more</a></p>
						</div>
					</div>
					<!-- Press Item -->
				</div>

				<div class="col-md-6">
					<!-- Press Item -->
					<div class="fh5co-press-item to-animate">
						<div class="fh5co-press-img" style="background-image: url(images/img_10.jpg);">
						</div>
						<div class="fh5co-press-text">
							<h3 class="h2 fh5co-press-title">Creative <span class="fh5co-border"></span></h3>
							<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Veritatis eius quos similique suscipit dolorem cumque vitae qui molestias illo accusantium...</p>
							<p><a href="#" class="btn btn-primary btn-sm">Learn more</a></p>
						</div>
					</div>
					<!-- Press Item -->
				</div>

			</div>
		</div>
	</div>
	
<div class="row" id="team">
				<div class="col-md-12 section-heading text-center to-animate">
					<h2>Team</h2>
				</div>
				<div class="col-md-12">
					<div class="row row-bottom-padded-lg">
						<div class="col-md-4 text-center to-animate">
							<div class="person">
								<img src="images/person2.jpg" class="img-responsive img-rounded" alt="Person">
								<h3 class="name">John Doe</h3>
								<div class="position">Web Developer</div>
								<p>Far far away, behind the word mountains, far from the countries Vokalia and Consonantia, there live the blind texts. Separated they live in Bookmarksgrove right at the coast of the Semantics.</p>
								<ul class="social social-circle">
									<li><a href="#"><i class="icon-twitter"></i></a></li>
									<li><a href="#"><i class="icon-linkedin"></i></a></li>
									<li><a href="#"><i class="icon-instagram"></i></a></li>
									<li><a href="#"><i class="icon-github"></i></a></li>
								</ul>
							</div>
						</div>
						<div class="col-md-4 text-center to-animate">
							<div class="person">
								<img src="images/person3.jpg" class="img-responsive img-rounded" alt="Person">
								<h3 class="name">Rob Smith</h3>
								<div class="position">Web Designer</div>
								<p>Far far away, behind the word mountains, far from the countries Vokalia and Consonantia, there live the blind texts. Separated they live in Bookmarksgrove right at the coast of the Semantics.</p>
								<ul class="social social-circle">
									<li><a href="#"><i class="icon-twitter"></i></a></li>
									<li><a href="#"><i class="icon-linkedin"></i></a></li>
									<li><a href="#"><i class="icon-instagram"></i></a></li>
									<li><a href="#"><i class="icon-dribbble"></i></a></li>
								</ul>
							</div>
						</div>
						<div class="col-md-4 text-center to-animate">
							<div class="person">
								<img src="images/person4.jpg" class="img-responsive img-rounded" alt="Person">
								<h3 class="name">Kathan Sheth</h3>
								<div class="position">Photographer</div>
								<p>Far far away, behind the word mountains, far from the countries Vokalia and Consonantia, there live the blind texts. Separated they live in Bookmarksgrove right at the coast of the Semantics.</p>
								<ul class="social social-circle">
									<li><a href="#"><i class="icon-twitter"></i></a></li>
									<li><a href="https://www.linkedin.com/in/kathan-sheth-42004958"><i class="icon-linkedin"></i></a></li>
									<li><a href="#"><i class="icon-instagram"></i></a></li>
									<li><a href="#"><i class="icon-github"></i></a></li>
								</ul>
							</div>
						</div>
					</div>
				</div>
			</div>
	<footer id="footer" role="contentinfo">
		<div class="container">
			<div class="row row-bottom-padded-sm">
				<div class="col-md-12">
					<p class="copyright text-center">&copy; 2015 Free <a href="index.html">Crew</a>. All Rights Reserved. <br> Free HTML5 Template by <a href="http://freehtml5.co/" target="_blank">FREEHTML5.co</a> | Images by <a href="http://pexels.com/" target="_blank">Pexels</a> &amp;  <a href="http://unsplash.com/" target="_blank">Unsplash</a></p>
				</div>
			</div>
			<div class="row">
				<div class="col-md-12 text-center">
					<ul class="social social-circle">
						<li><a href="#"><i class="icon-twitter"></i></a></li>
						<li><a href="#"><i class="icon-facebook"></i></a></li>
						<li><a href="#"><i class="icon-youtube"></i></a></li>
						<li><a href="#"><i class="icon-pinterest"></i></a></li>
						<li><a href="#"><i class="icon-linkedin"></i></a></li>
						<li><a href="#"><i class="icon-instagram"></i></a></li>
						<li><a href="#"><i class="icon-dribbble"></i></a></li>
					</ul>
				</div>
			</div>
		</div>
	</footer>
	
	
	
	
	<!-- jQuery -->
	<script src="js/jquery.min.js"></script>
	<!-- jQuery Easing -->
	<script src="js/jquery.easing.1.3.js"></script>
	<!-- Bootstrap -->
	<script src="js/bootstrap.min.js"></script>
	<!-- Waypoints -->
	<script src="js/jquery.waypoints.min.js"></script>
	<!-- Owl Carousel -->
	<script src="js/owl.carousel.min.js"></script>

	<!-- For demo purposes only styleswitcher ( You may delete this anytime ) -->
	<script src="js/jquery.style.switcher.js"></script>
	<script>
	$(function(){
		$('#colour-variations ul').styleSwitcher({
			defaultThemeId: 'theme-switch',
			hasPreview: false,
			cookie: {
	          	expires: 30,
	          	isManagingLoad: true
	      	}
		});	
		$('.option-toggle').click(function() {
			$('#colour-variations').toggleClass('sleep');
		});
	});
	</script>
	<!-- End demo purposes only -->

	<!-- Main JS (Do not remove) -->
	<script src="js/main.js"></script>
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
			$('#respGet').html(data);
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
			$('#respGet').html(data);
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
			$('#respDiscount').html(data);
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
			$('#respDiscount').html(data);
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
			$('#respDiscount').html(data);
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
				$('#respOk').text(data);
				
			},
			complete : function(XMLHttpRequest) {
				 
				ReceiveMessage();
				PriceLimit();
			//	setTimeout(ReceiveMessage,1000);
				//console.log( XMLHttpRequest.getAllResponseHeaders() );
			}
		};

			return $.ajax(ajaxObj);
		}else if(clientName == "Rack1")
		{
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
							$('#respOk').text(data);
							
						},
						complete : function(XMLHttpRequest) {
							 
							ModifyReceiveMessage();
							//alert("here");
						//	Quantity();
							
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
				$('#respOk').text(data);
				
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
						$('#respOk').text(data);
						
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
				$('#respObserve').html(data);
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
					//alert("success");
					$('#respObserveInventory').html(data);
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
							$('#respObservePrice').text("Observation Stopped.");
							return;
							//request.abort();
						}
					else if(x != null)
					{	
						//alert("Amount");
						$('#respObservePrice').text(data);
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

<!-- Set Attributes Script -->

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
			$('#respdiscover').html(data);
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
				$('#respdiscover').html(data);
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
			$('#respdiscover').html(data);
		},
		complete : function(XMLHttpRequest) {
			 console.log( XMLHttpRequest.getAllResponseHeaders() );
		}
	};

	return $.ajax(ajaxObj);
		
}

function allAttributes(NotifyTime,MaxPrice,clientName,MaxWeight,Step) {

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
			$('#respdiscover').html(data);
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
			url : "http://localhost:8080/Assignment2/client/handler/allAttributes/put/" +MaxWeight+"/"+NotifyTime+"/",
			data : Step,
			datatype : "application/html",
			error : function(jqXHR, textStatus, errorThrown) {
				console.log(jqXHR.responseText);
			},
			success : function(data) {
				//console.log(data['success']);
				//window.location='Home.jsp';
				$('#respdiscover').html(data);
			},
			complete : function(XMLHttpRequest) {
				 console.log( XMLHttpRequest.getAllResponseHeaders() );
			}
		};

		return $.ajax(ajaxObj);
		}


}


function SetWeight(MinQuant,clientName) {

	ajaxObj = {
			type : "PUT",
			url : "http://localhost:8080/Assignment2/client/handler/MinQuant/put/",
			data : MinQuant,
			datatype : "application/html",
			error : function(jqXHR, textStatus, errorThrown) {
				console.log(jqXHR.responseText);
			},
			success : function(data) {
				//console.log(data['success']);
				//window.location='Home.jsp';
				$('#respdiscover').html(data);
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
				$('#respdiscover').html(data);
			},
			complete : function(XMLHttpRequest) {
				 console.log( XMLHttpRequest.getAllResponseHeaders() );
			}
		};

		return $.ajax(ajaxObj);
	}
</script>

<!-- Get Attributes Script -->

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
			$('#respdiscover').html(data);
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
					$('#respdiscover').html(data);
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
			$('#respdiscover').html(data);
		},
		complete : function(XMLHttpRequest) {
			 console.log( XMLHttpRequest.getAllResponseHeaders() );
		}
	};

	return $.ajax(ajaxObj);
}
</script>



	</body>
</html>
 id="ow&gt;"