<%@page import="javax.ws.rs.core.Request"%>
<%@page import="org.codehaus.jettison.json.JSONObject"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<%@page import="java.util.HashMap"%>
<%@page import="java.sql.ResultSetMetaData"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@ taglib prefix="sql" 
           uri="http://java.sun.com/jsp/jstl/sql" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.0/jquery.min.js"></script>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Inventory</title>
</head>
<body>
<script>
function deleteCart(clientName) {

	//alert("Hi"+clientName);
	ajaxObj = {
		type : "DELETE",
		url : "http://localhost:8080/Assignment2/rest/client/Delete/" + clientName +"/",
		error : function(jqXHR, textStatus, errorThrown) {
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
</script>
<h1>Inventory Rack Simulation</h1>
<br>
<hr>
<ol>
</ol>
<br>
<h3>
Registration Section:
</h3>
<table>
<tr>
<td>
<input type="hidden" name="Client_id" id="client" value="Rack1">
</td>
</tr>
<tr>
<td>
Register Cart (POST)
</td>
<td>
</td>
<td>
<form action="Register.jsp" method="post">
<input type="submit" value="submit">
</form>
</td>
</tr>
<tr>
<td>
Update Cart Information (PUT)
</td>
<td>
</td>
<td>
<form action="UpdateInventory.jsp" method="post">
<input type="submit" value="submit">
</form>
</td>
</tr>
<tr>
<td>
De-Register Cart (DELETE)
</td>
<td>
</td>
<td>
<input type="submit" value ="submit" onclick="deleteCart($('#client').val())">
</td>
</tr>
</table>
<br>
<br>
<br>
Server Response : <div><p id="resp"></p></div>
<br>

<!-- <h1>
Registration Section:
</h1>
<table>
<tr>
<td>
Product Id
</td>
<td>
<input type="text" id="product_id">
</td>
</tr>
<tr>
<td>
Product Name
</td>
<td>
<input type="text" id="product_name">
</td>
</tr>
<tr>
<td>
Product Quantity
</td>
<td>
<input type="text" id="product_quantity">
</td>
</tr>
<tr>
<td>
Product Price
</td>
<td>
<input type="text" id="product_price">
</td>
</tr>
<tr>
<tr>
<td>
Product Weight
</td>
<td>
<input type="text" id="product_weight">
</td>
</tr>
<tr>
<td>
Product Type
</td>
<td>
<input type="text" id="product_type">
</td>
</tr>
<tr>
</tr>
<tr>
<td>
</td>
<td>
<input type="submit" onclick="setInventory($('#product_id').val(),$('#product_name').val(),$('#product_quantity').val(),$('#product_price').val(),$('#product_weight').val(),$('#product_type').val())">
</td>
</tr>
</table>
<br>
<h5>
Update Module:
</h5>
<table>
<tr>
<td>
Item Name
</td>
<td>


<select id="update_Client_id" name="update_Client_id">
<option value="1">Product 1</option>
<option value="2">Product 2</option>
<option value="3">Product 3</option>
<option value="4">Product4</option>
<option value="5">Product5</option>
<option value="6">Product6</option>
</select>

</tr>
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
Quantity
</td>
<td>
<input type="text" id="update_product_quantity">
</td>
</tr>
<tr>
<td>
Price
</td>
<td>
<input type="text" id="update_product_price">
</td>
</tr>
<tr>
<tr>
<td>
Weight
</td>
<td>
<input type="text" id="update_product_weight">
</td>
</tr>
<tr>
<td>
Type
</td>
<td>
<input type="text" id="update_product_type">
</td>
</tr>
<tr>
<td>
<input type="hidden" id="update_Client_id" value="pallet_milk">
</td>
</tr>
<tr>
<td>
</td>
<td>
<input type="submit" onclick="updateInventory($('#update_Client_id').val(),$('#update_product_name').val(),$('#update_product_quantity').val(),$('#update_product_price').val(),$('#update_product_weight').val(),$('#update_product_type').val())">
</td>
</tr>
</table>

<h1>
Read Request:
</h1>
<table>
<tr>
<td>
Product Name
</td>
<td>
<input type="text" id="client_Name">
</td>
<tr>
</tr>
<tr>
<td>
</td>
<td>
<input type="submit" onclick="readInventory($('#client_Name').val())">
</td>
</tr>
<td>
Get all Inventory
</td>
<td>
<input type="submit" value="Click here to know complete inventory"onclick="readAllInventory()">
</td>
</tr>
</table>
Response from Server is : <div><p id="response"></p></div>

<table>
<tr>
<td>
Delete Inventory
</td>
<td>
<% 
Connection conn =null;
Statement stmt = null;
ResultSet rs = null;
try{
	
Class.forName("com.mysql.jdbc.Driver");
	
conn = (Connection) DriverManager.getConnection("jdbc:mysql://localhost/Assignment2","root","root");

stmt = conn.createStatement();

String sql = "use inventory";

stmt.execute(sql);
out.println("<select name=\"itemList\">");

	
	String sql_select = "SELECT * FROM rack1";
    rs = stmt.executeQuery(sql_select);
   	while(rs.next())
   	{
   		out.println("<option value = \"" + rs.getString(1).trim() + "\">"+rs.getString(1)+"</option>");
   	}
}catch (SQLException e) {
	// TODO Auto-generated catch block
	e.printStackTrace();
}
finally{

} 
out.println("/<select>");
%>
</td>
</tr>
<tr>
<td>
<input type="hidden" id="delete_Client_id" value="pallet_milk">
<input type="submit" onclick="deleteInventory($('#delete_Client_id').val())">
</td>
</tr>
</table>
-->

</body>
<script>

function setInventory(productId,productName,productQuantuty,productPrice,productWeight,productType) {

//alert("Hi "+productNumber);
	var data = '{"ProductId":"' + productId + '","Name":"' + productName + '","Quantity":"' + productQuantuty + '","Price":"' + productPrice + '","Weight":"' + productWeight +  '","Type":"' + productType + '"}';
//	alert("Hi "+clientName);
	var json = JSON.parse(data);
	ajaxObj = {
		type : "POST",
		data : JSON.stringify(json),
		url : "http://localhost:8080/Assignment2/rest/client/Register/post",
		datatype : "json",
		contentType: "application/json;",
		error : function(jqXHR, textStatus, errorThrown) {
			console.log(jqXHR.responseText);
		},
		success : function(data) {
			//console.log(data['success']);
			window.location='Home2.jsp';
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

function updateInventory(productId,productName,quantity,price,weight,type) {


	var data = '{"ProductName":"' + productName + '","Quantity":"' + quantity + '","Price":"' + price + '","Weight":"' + weight + '","Type":"' + type + '"}';
	alert("Hi "+productName);
	var json = JSON.parse(data);
//	alert("Hi "+json);
	ajaxObj = {
		type : "PUT",
		data : JSON.stringify(json),
		url : "http://localhost:8080/Assignment2/rest/client/Update/post/"+ productId +"/",
		datatype : "application/html",
		error : function(jqXHR, textStatus, errorThrown) {
			console.log(jqXHR.responseText);
		},
		success : function(data) {
			//console.log(data['success']);
			window.location='Home.jsp';
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

function deleteInventory(clientName) {

//	alert("Hi "+clientName);
	ajaxObj = {
		type : "DELETE",
		url : "http://localhost:8080/Assignment2/rest/client/Delete/"+ clientName +"/",
		datatype : "application/html",
		error : function(jqXHR, textStatus, errorThrown) {
			console.log(jqXHR.responseText);
		},
		success : function(data) {
			//console.log(data['success']);
			//window.location='Home.jsp';
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

function readInventory(clientName) {

	//alert("Hi "+clientName);
	ajaxObj = {
		type : "GET",
		url : "http://localhost:8080/Assignment2/rest/client/getInventory/"+ clientName,
		//datatype : "application/html",
		error : function(jqXHR, textStatus, errorThrown) {
			console.log(jqXHR.responseText);
		},
		success : function(data) {
			//console.log(data['success']);
			//window.location='Home.jsp';
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

function readAllInventory() {

	//alert("Hi "+clientName);
	ajaxObj = {
		type : "GET",
		url : "http://localhost:8080/Assignment2/rest/client/Read1/get/",
		datatype : "application/html",
		error : function(jqXHR, textStatus, errorThrown) {
			console.log(jqXHR.responseText);
		},
		success : function(data) {
			//console.log(data['success']);
			//window.location='Home.jsp';
			$('#response').html(data);
		},
		complete : function(XMLHttpRequest) {
			 console.log( XMLHttpRequest.getAllResponseHeaders() );
		}
	};

	return $.ajax(ajaxObj);
}
</script>

</html>