<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.0/jquery.min.js"></script>

<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Update</title>
</head>
<body>
<h1>
Registration Section
</h1>
<h4>
Update Module:
</h4>
<table>
<tr>
<td>
Manufacturer Name 
</td>
<td>
<input type="text" name="Client_Manufacturer" id="manufacturer">
</td>
</tr>
<tr>
<td>
Model Number
</td>
<td>
<input type="text" name="Client_Model" id="model">
</td>
</tr>
<!--<tr>
<td>
Software Version
</td>
<td>
<input type="text" name="Client_Software" id="version">
</td>
</tr>
<tr>
<tr>
<td>
IP Address
</td>
<td>
<input type="text" name="IP" id="IP">
</td>
</tr>
-->
<tr>
<td>
Type
</td>
<td>
<input type="text" name="Client_Type" id="type">
</td>
</tr>
<tr>
<td>
<input type="hidden" name="Client_id" id="ClientId" value="Rack1">
</td>
</tr>
<tr>
<td>
</td>
<td>
<input type="submit" value="submit" onclick="updateInventory($('#ClientId').val(),$('#manufacturer').val(),$('#model').val(),$('#type').val())">
</td>
</tr>
</table>
<br>
<br>
Server Response : <div><p id="resp"></p></div>
</body>

<script>

function updateInventory(clientName,manufactNo,modelNo,type) {

	alert("Hi "+clientName);
	var obj = '{"manufacturer":"' + manufactNo + '","model":"' + modelNo +'","type":"' + type +'"}';
	var jsonObj = JSON.parse(obj);

	//alert(obj);
	ajaxObj = {
		type : "PUT",
		url : "http://localhost:8080/Assignment2/rest/client/Update/put/" + clientName +"/",
		data: JSON.stringify(jsonObj),
		error : function(jqXHR, textStatus, errorThrown) {
			
			$('#resp').text("Something went wrong...!!!");
			
			console.log(jqXHR.responseText);
		},
		success : function(data) {
			// console.log("hey");
			
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
	
	window.location = "ClientInventory.jsp"
}
</script>

</html>