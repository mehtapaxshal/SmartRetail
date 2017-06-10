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
<title>Registration</title>
</head>
<body>
<h1>
Registration Section:
</h1>
<!--<form action="Register" method="post">-->
<table>
<tr>
<td>
Client Name
</td>
<td>
<input type="text" name="Client_Name" id="client" required>
</td>
</tr>
<tr>
<td>
Manufacturer 
</td>
<td>
<input type="text" name="Client_Manufacturer" id="manufacturer" required>
</td>
</tr>
<tr>
<td>
Model Number
</td>
<td>
<input type="text" name="Client_Model" id="model" required>
</td>
</tr>
<!-- <tr>
<td>
Software Version
</td>
<td>
<input type="text" name="Client_Software">
</td>
</tr>
<tr>
<tr>
<td>
IP Adress
</td>
<td>
<input type="text" name="IP" required>
</td>
</tr>
-->
<tr>
<td>
Type
</td>
<td>
<input type="text" name="Client_Type" id="type" required>
</td>
</tr>
<tr>
</tr>
<tr>
<td>
</td>
<td>
<input type="submit" value="submit" onclick="RegisterCart($('#client').val(),$('#manufacturer').val(),$('#model').val(),$('#type').val())">
</td>
</tr>
</table>
<br>
<br>
Server Response : <div><p id="resp"></p></div>
</body>
<script>
var clientId;
function RegisterCart(client,manufacturer,model,type) {

	//alert("Hi"+clientName);
	clientId = client;
	//alert(clientId);
	var obj = '{"name":"' + client + '","manufacturer":"' + manufacturer + '","model":"' + model +'","type":"' + type +'"}';
	var jsonObj = JSON.parse(obj);
	ajaxObj = {
		type : "POST",
		url : "http://localhost:8080/Assignment2/rest/client/Register/post/",
		data : JSON.stringify(jsonObj),
		error : function(jqXHR, textStatus, errorThrown) {
			
			$('#resp').text("Client is already registered.");
			console.log(jqXHR.responseText);
		},
		success : function(data) {
			// console.log("hey");
			//window.location='Home.jsp';
			$('#resp').text(data);
		},
		complete : function(XMLHttpRequest) {
			
			setTimeout('close()', 3000);			 
			console.log( XMLHttpRequest.getAllResponseHeaders() );
		}
	};

	return $.ajax(ajaxObj);
}

function close(){
	
	//alert(clientId);
	if(clientId == "Cart_007")
		window.location = "ClientCheckout.jsp"
		else if(clientId =="Rack1")
				window.location = "ClientInventory.jsp"
				else
					window.location = "ClientCheckout.jsp"
						

}

</script>
</html>