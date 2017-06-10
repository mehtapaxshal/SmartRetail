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
<title>Checkout</title>
</head>
<body>
<script type="text/javascript">
/*function success(){
	
	
	document.getElementById("payment").innerHTML="Payment Done...!!!! Thank you for shopping. Have a great Day!!!";
	
	
}
*/

/*function openRegister(){
	
	
	window.open("Register.jsp", "Registration", "scrollbars=1,resizable=1,height=300,width=450");
	//document.getElementById("payment").innerHTML="Payment Done...!!!! Thank you for shopping. Have a great Day!!!";
	
	
}*/

$(document).ready(function(){
    $("button").click(function(){
        $(payment).hide(1000);
    });
});

function success(clientName, value) {

	var time = Date();
	var obj = '{"client_id":"' + clientName + '","amount":"' + value +'","checkoutTime":"' + time +'"}';
	var jsonObj = JSON.parse(obj);

	ajaxObj = {
		type : "PUT",
		url : "http://localhost:8080/Assignment2/rest/client/Checkout/",
		data : JSON.stringify(jsonObj),
		error : function(jqXHR, textStatus, errorThrown) {
			console.log(jqXHR.responseText);
		},
		success : function(data) {
			// console.log("hey");
			//window.location='Home.jsp';
			$('#paymentDone').text(data);
		},
		complete : function(XMLHttpRequest) {
			 console.log( XMLHttpRequest.getAllResponseHeaders() );
		}
	};

	return $.ajax(ajaxObj);
}


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
<h1>Checkout Cart Simulation</h1>
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
<input type="hidden" name="Client_id" id="client" value="Cart_007">
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
<form action="Update.jsp" method="post">
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
<h3>
Cart Items:
</h3>
<form action="Checkout" method="get">
<table>
<tr>
<td>
Items in the Cart
</td>
<td width="100">
</td>
<td>
<input type = "submit" value = "submit">
</td>
</tr>
</table>
</form>
<br><br>
Your Items:
<br><br>
<table border="1">
            <!-- column headers -->
            <tr>
                <c:forEach var="columnName" items="${result.columnNames}">
           	         <th><c:out value="${columnName}"/></th>
                </c:forEach>
            </tr>
            <!-- column data -->
            <c:forEach var="row" items="${result.rowsByIndex}">
                <tr>
                    <c:forEach var="column" items="${row}">
                        <td><c:out value="${column}"/></td>
                    </c:forEach>
                </tr>
            </c:forEach>
</table>
<br>
<h5>Please Confirm the products and proceed to payment...</h5>


<div><p>Total amount to be paid is $${amount}</p></div>
<div>${discount}</div>
<br>
<div>${finalPrice}</div>
<br>
<button onclick="success($('#client').val(),${deducted})">Checkout</button>
<p id="paymentDone"> </p>
<div id="payment">
<h3>Add Item</h3>
<form action="addItem" method="get">
<table>
<tr>
<td>Enter item</td>
<td>
<input type="text" name="item" id="item" placeholder="Enter item" required>
</td>
</tr>
<tr>
<td>Enter quantity</td>
<td>
<input type="text" name="quantity" id="quantity" placeholder="Enter quantity" required>
</td>
</tr>
<tr>
<td>Enter price</td>
<td>
<input type="text" name="price" id="price" placeholder="Enter price" required>
</td>
</tr>
<tr>
<td>Enter type</td>
<td>
<input type="text" name="type" id="type" placeholder="Enter type" required>
</td>
</tr>
<tr>
<td></td>
</tr>
<tr>
<td></td>
<td>
<input type = "submit" value = "submit">
</td>
</tr>
</table>
</form>
<br>
<form action="addItem" method="post">
<table>
<tr>
<td>
Remove Item
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

String sql = "use Assignment2";

stmt.execute(sql);
out.println("<select name=\"itemList\">");

	
	String sql_select = "SELECT * FROM CHECKOUT_ITEM";
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
<select name="quantity">
<option value="1">1</option>
<option value="2">2</option>
<option value="3">3</option>
<option value="4">4</option>
<option value="5">5</option>
<option value="6">6</option>
<option value="7">7</option>
<option value="8">8</option>
<option value="9">9</option>
<option value="10">10</option>
</select>
</td>
<td>
<input type = "submit" value = "submit">
</td>
</tr>
</table>
</form>
</div>
</body>
</html>