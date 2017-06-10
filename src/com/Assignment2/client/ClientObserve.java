package com.Assignment2.client;

import java.awt.Toolkit;
import java.net.UnknownHostException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.DecimalFormat;
import java.util.Timer;

import javax.websocket.server.ServerEndpoint;
import javax.ws.rs.Consumes;
import javax.ws.rs.DELETE;
import javax.ws.rs.GET;
import javax.ws.rs.POST;
import javax.ws.rs.PUT;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;
import javax.ws.rs.Produces;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;

import org.codehaus.jettison.json.JSONException;
import org.codehaus.jettison.json.JSONObject;

import com.mongodb.util.JSON;
import com.mysql.jdbc.PreparedStatement;
import com.mysql.jdbc.ResultSetMetaData;



@Path("/ClientInfo/")
public class ClientObserve extends Thread {

	static int cancel = 0;

	static Connection conn =null;
	static Statement stmt = null;
	

	/**********Factory BootStrap (POST)
	 * @throws SQLException **********/

	
	@Path("FactoryBS/post/")
	@POST
	@Produces("text/html")
//	@Consumes("text/html")
	@Consumes({ MediaType.APPLICATION_FORM_URLENCODED,
		MediaType.APPLICATION_JSON })
	
	public Response factoryBS(String clientId) throws JSONException, UnknownHostException, ClassNotFoundException, SQLException {
		
		Connection conn =null;
		Statement stmt = null;
		
		JSONObject json = new JSONObject();
		//System.out.println("Client here is :" + clientId);
		
		Class.forName("com.mysql.jdbc.Driver");
		//System.out.println("Connecting to database...");
	    try {
			
	    	if(clientId.equals("Cart_007"))
	    	{
	    		conn = (Connection) DriverManager.getConnection("jdbc:mysql://localhost/Assignment2","root","root");
	    		
	    		stmt = conn.createStatement();
	    		String sql = "use assignment2";
				stmt.execute(sql);
				  
	    		PreparedStatement pstmt = (PreparedStatement) conn.prepareStatement("Select * from server_info");
				ResultSet rs =pstmt.executeQuery();
				ResultSetMetaData rsm = (ResultSetMetaData) rs.getMetaData();	
				if(rs.next())
				{
					
					return Response.status(200).entity("The Bootstrap has already been done previously. <br><br>The Client Database is: <br><table border=2><tr><td>"+rsm.getColumnName(1)+"</td><td>"+rsm.getColumnName(2)+"</td><td>"+rsm.getColumnName(3)+"</td></tr><tr><td>"+rs.getString(1)+"</td><td>"+rs.getString(2)+"</td><td>"+rs.getString(3)+"</td></tr></table>").build();
					
				}else
				{
			   
				PreparedStatement ps = (PreparedStatement) conn.prepareStatement("INSERT INTO SERVER_INFO VALUES ('Cart_007','SanJose_Server',1)");
	    		ps.execute();
	    		PreparedStatement p = (PreparedStatement) conn.prepareStatement("Select * from server_info");
				ResultSet r =p.executeQuery();
				ResultSetMetaData rm = (ResultSetMetaData) r.getMetaData();	
				
				if(r.next())
				{
					return Response.status(200).entity("The Bootstrap is successful.<br><br> The Client Database is: <br><table border=2><tr><td>"+rm.getColumnName(1)+"</td><td>"+rm.getColumnName(2)+"</td><td>"+rm.getColumnName(3)+"</td></tr><tr><td>"+r.getString(1)+"</td><td>"+r.getString(2)+"</td><td>"+r.getString(3)+"</td></tr></table>").build();
				}
				}
	    	}
	    	else if(clientId.equals("Rack1"))
	    	{
	    		conn = (Connection) DriverManager.getConnection("jdbc:mysql://localhost/inventory","root","root");
				
	    		stmt = conn.createStatement();
	    		String sql = "use inventory";
				stmt.execute(sql);
				  
	    		PreparedStatement pstmt = (PreparedStatement) conn.prepareStatement("Select * from server_info");
				ResultSet rs =pstmt.executeQuery();
				ResultSetMetaData rsm = (ResultSetMetaData) rs.getMetaData();	
				if(rs.next())
				{
					
					return Response.status(200).entity("The Bootstrap has already been done previously. <br><br>The Client Database is: <br><table border=2><tr><td>"+rsm.getColumnName(1)+"</td><td>"+rsm.getColumnName(2)+"</td><td>"+rsm.getColumnName(3)+"</td></tr><tr><td>"+rs.getString(1)+"</td><td>"+rs.getString(2)+"</td><td>"+rs.getString(3)+"</td></tr></table>").build();
					
				}else
				{
			   
				PreparedStatement ps = (PreparedStatement) conn.prepareStatement("INSERT INTO SERVER_INFO VALUES ('Rack1','SanJose_Server',1)");
	    		ps.execute();
	    		PreparedStatement p = (PreparedStatement) conn.prepareStatement("Select * from server_info");
				ResultSet r =p.executeQuery();
				ResultSetMetaData rm = (ResultSetMetaData) r.getMetaData();	
				
				if(r.next())
				{
					return Response.status(200).entity("The Bootstrap is successful. <br><br>The Client Database is: <br><table border=2><tr><td>"+rm.getColumnName(1)+"</td><td>"+rm.getColumnName(2)+"</td><td>"+rm.getColumnName(3)+"</td></tr><tr><td>"+r.getString(1)+"</td><td>"+r.getString(2)+"</td><td>"+r.getString(3)+"</td></tr></table>").build();
				}
				}
	    	}
	    		
		
	    } catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			conn.close();
	    }
		  
	    return Response.status(200).entity("There is something wrong.").build();
		
	  
		
	}
		
/**********READ Device Management (GET)**********/
	
	@Path("get/{clientName}/")
	@GET
	@Produces("text/html")
	@Consumes("text/html")
	public Response GetClient(@PathParam("clientName")String clientId) throws JSONException, UnknownHostException, ClassNotFoundException {
		
		Connection conn =null;
		Connection conn1 =null;
		
		Statement stmt = null;
		Statement stmt2 = null;
		
		JSONObject json = new JSONObject();
		//System.out.println("Client here is :" + clientId);
		
		Class.forName("com.mysql.jdbc.Driver");
		//System.out.println("Connecting to database...");
	    try {
			conn = (Connection) DriverManager.getConnection("jdbc:mysql://localhost/Assignment2","root","root");
			 conn1 = (Connection) DriverManager.getConnection("jdbc:mysql://localhost/inventory","root","root");
				
			  //System.out.println("Creating statement...");
			  stmt = conn.createStatement();
			  //String sql = "CREATE TABLE SERVER_INFO (client_id VARCHAR(255) not NULL, server_info VARCHAR(255), bs_info INTEGER)";
			    
			  //stmt.execute(sql);
			  if(clientId.equalsIgnoreCase(("Cart_007")))
			  {
				  
				  String sql = "use assignment2";
				  stmt.execute(sql);
				  
				  
				  PreparedStatement ps = (PreparedStatement) conn.prepareStatement("SELECT * from Checkout_Item");
				    //ResultSet rs=(ResultSet) ps.executeQuery();
				   // stmt.executeUpdate(ps);
				  //ps.setString(1,clientId);  
				  String str = "";
				  ResultSet rs = ps.executeQuery();
					
				  ResultSetMetaData rsm = (ResultSetMetaData) rs.getMetaData();
				  
				  String trial= "<html><head><body><table border=1><tr><td>"+rsm.getColumnName(1)+"</td><td>"+rsm.getColumnName(2)+"</td><td>"+rsm.getColumnName(3)+"</td><td>"+rsm.getColumnName(4)+"</td></tr>";
				  while(rs.next())
				  {
					  
					  //json.put(rsm.getColumnName(1), rs.getString(1));
					  //json.put(rsm.getColumnName(2), rs.getString(2));
					  //json.put(rsm.getColumnName(3), rs.getString(3));
					  str+="<tr><td>"+ rs.getString(1) + "</td>" + "<td>" + rs.getString(2) + "</td>"+ "<td>" + rs.getString(3) + "</td><td>" + rs.getString(4) + "</td></tr>";
					  
				//	  System.out.println(json);
					  
					  
				  }
				  String end = "</table></body></head></html>"; 
				  return Response.status(200).entity(trial+str+end).build();
				 // return Response.status(200).entity("The resource object of requested client is " + json).build();
				  
			  }else if(clientId.equals("Rack1"))
			  {
				  	String str="";
					ResultSet rs;
					
				    System.out.println("Creating statement...");
				    stmt2 = conn1.createStatement();
				    rs=stmt2.executeQuery("select * from rack1");	
				    	 //rs=stmt2.executeQuery("select * from rack1 WHERE product_name="+"'"+client+"'");
				    
				    String trial= "<html><head><body><table border=1 style=width:100%><tr><td>Product Name</td><td>Product Price</td><td>Product Quantity</td><td>Product Weight</td><td>Product Type</td></tr>";
				 //   String start = "<html><head><body>";
				    while(rs.next()){
				    	str+="<tr><td>"+ rs.getString("product_name") + "</td>" + "<td>" + rs.getString("product_price") + "</td>"+ "<td>" + rs.getString("product_quantity") + "</td>"+ "<td>" + rs.getString("product_weight") + "</td>"+ "<td>" + rs.getString("product_type") + "</td></tr>";
				    //	str+="Product Name is " + rs.getString("product_name") + ", Product weight is " + rs.getString("product_weight") + ", Product Price is " + rs.getString("product_price")+", Product Quantity is " + rs.getString("product_quantity")+ ", Its of " + rs.getString("product_type") + " type <br/>";
				    	
//				    	System.out.println(rs.getString("product_name") + "," + rs.getString("product_weight") + "," + rs.getString("product_price")+ "," + rs.getString("product_type"));
				    }
				    String end = "</table></body></head></html>"; 
				   //return Response.status(200).entity("<html><head><body>"+str+" <br>"+"</body></head></html>").build();
				    return Response.status(200).entity(trial+str+end).build();  
			  }
			  else if(clientId.equalsIgnoreCase(("Cart_006")))
			  {
				  
				  String sql = "use cart6";
				  stmt.execute(sql);
				 
				  
				  PreparedStatement ps = (PreparedStatement) conn.prepareStatement("SELECT * from Server_Info");
				    //ResultSet rs=(ResultSet) ps.executeQuery();
				   // stmt.executeUpdate(ps);
				  //ps.setString(1,clientId);  
				  ResultSet rs = ps.executeQuery();
				  ResultSetMetaData rsm = (ResultSetMetaData) rs.getMetaData();
				  if(rs.next())
				  {
					  
					  json.put(rsm.getColumnName(1), rs.getString(1));
					  json.put(rsm.getColumnName(2), rs.getString(2));
					  json.put(rsm.getColumnName(3), rs.getString(3));
				
					   
			//		  System.out.println(json);
					  return Response.status(200).entity("The resource object of requested client is " + json).build();
	  
					  
				  }

			  }
	    
		
	    } catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		  return Response.status(200).entity("No such Client found").build();
		
	  
	}
	

/**********READ Particular Resource Device Management (GET)
 * @throws SQLException **********/
	
	
	@Path("get/product/{clientName}/{itemName}/")
	@GET
	@Produces("text/html")
	@Consumes("text/html")
	public Response GetClientBootstrap(@PathParam("clientName")String clientId,@PathParam("itemName")String product) throws JSONException, UnknownHostException, ClassNotFoundException, SQLException {
		
		Connection conn =null;
		Statement stmt,stmt2 = null;
		Connection conn1 = (Connection) DriverManager.getConnection("jdbc:mysql://localhost/inventory","root","root");
			
		JSONObject json = new JSONObject();
	  
		Class.forName("com.mysql.jdbc.Driver");
		//System.out.println("Connecting to database...");
	    try {
			  //System.out.println("Creating statement...");
			  //String sql = "CREATE TABLE SERVER_INFO (client_id VARCHAR(255) not NULL, server_info VARCHAR(255), bs_info INTEGER)";
			    
			  //stmt.execute(sql);
			  if(clientId.equals("Cart_007"))
			  {
				  conn = (Connection) DriverManager.getConnection("jdbc:mysql://localhost/Assignment2","root","root");
				  stmt = conn.createStatement();
				  
				  String str="";
					
				  String sql = "use assignment2";
				  stmt.execute(sql);
				  
				  
				  PreparedStatement ps = (PreparedStatement) conn.prepareStatement("SELECT * from checkout_item where item = ?");
				    //ResultSet rs=(ResultSet) ps.executeQuery();
				   // stmt.executeUpdate(ps);
				  ps.setString(1,product);  
				  ResultSet rs = ps.executeQuery();
				  ResultSetMetaData rsm = (ResultSetMetaData) rs.getMetaData();
				  
				  
				  if(rs.next())
				  {
					  
					  /*json.put(rsm.getColumnName(1), rs.getString(1));
					  json.put(rsm.getColumnName(2), rs.getString(2));
					  json.put(rsm.getColumnName(3), rs.getString(3));
					  json.put(rsm.getColumnName(4), rs.getString(4));*/
					  String trial= "<html><head><body><table border=1 style=width:100%><tr><td>"+rsm.getColumnName(1)+"</td><td>"+rsm.getColumnName(2)+"</td><td>"+rsm.getColumnName(3)+"</td><td>"+rsm.getColumnName(4)+"</td></tr>";
					  str+="<tr><td>"+ rs.getString(1) + "</td>" + "<td>" + rs.getString(2) + "</td>"+ "<td>" + rs.getString(3) + "</td>"+ "<td>" + rs.getString(4) +"</td></tr>";
					  String end = "</table></body></head></html>"; 
					  
					//  System.out.println(json);
					  //return Response.status(200).entity("The item in "+ clientId +" present is " + json).build();
					  return Response.status(200).entity(trial+str+end).build();
					  
				  }else
				  {
					  return Response.status(200).entity("No such item in the "+ clientId).build();
					  
				  }

			  }else if(clientId.equals("Rack1"))
			  {
				  	String str="";
					ResultSet rs;
					
				    stmt2 = conn1.createStatement();
				   // rs=stmt2.executeQuery("select * from rack1");	
				    	 rs=stmt2.executeQuery("select * from rack1 WHERE product_name="+"'"+product+"'");
				    
				    String trial= "<html><head><body><table border=1 style=width:100%><tr><td>Product Name</td><td>Product Price</td><td>Product Quantity</td><td>Product Weight</td><td>Product Type</td></tr>";
				 //   String start = "<html><head><body>";
				    while(rs.next()){
				    	str+="<tr><td>"+ rs.getString("product_name") + "</td>" + "<td>" + rs.getString("product_price") + "</td>"+ "<td>" + rs.getString("product_quantity") + "</td>"+ "<td>" + rs.getString("product_weight") + "</td>"+ "<td>" + rs.getString("product_type") + "</td></tr>";
				     }
				    String end = "</table></body></head></html>"; 
				   //return Response.status(200).entity("<html><head><body>"+str+" <br>"+"</body></head></html>").build();
				    return Response.status(200).entity(trial+str+end).build();
			  }
			 
		
	    } catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	    return Response.status(200).entity("No such Client found").build();
		
	}
	

/**********Create Device Management (POST)**********/
	
	@Path("DefaultDiscount/")
	@POST
	@Produces("text/html")
	@Consumes({ MediaType.APPLICATION_FORM_URLENCODED,
		MediaType.APPLICATION_JSON })
	public Response DefaultDiscount(String json) throws JSONException, UnknownHostException {
		
		
		 JSONObject jsonData = new JSONObject(json);
	       
		
	/*	System.out.println("data at server: "+json);

		System.out.println("client: "+jsonData.getString("ClientID"));
		System.out.println("discount: "+jsonData.getInt("Discount"));*/
		
		String clientId = jsonData.getString("ClientID");
		int discountValue = jsonData.getInt("Discount");
		
		Connection conn =null;
		Statement stmt = null;
		
		//JSONObject json = new JSONObject();
		//System.out.println("Client here is :" + clientId);
		
		//System.out.println("Connecting to database...");
	    try {
			
	    		Class.forName("com.mysql.jdbc.Driver");
			
	    		conn = (Connection) DriverManager.getConnection("jdbc:mysql://localhost/Assignment2","root","root");
	    		stmt = conn.createStatement();
			  if(clientId.equals("Cart_007"))
			  {
				  
				  String sql = "use assignment2";
				  stmt.execute(sql);
				  int quantity=0;
				  float price=0;
				  PreparedStatement pstmt = (PreparedStatement) conn.prepareStatement("Select quantity,price from checkout_item");
				  ResultSet rs =pstmt.executeQuery();
				  while(rs.next())
				  {
					  quantity = quantity + rs.getInt(1);
					  price = price + (rs.getInt(1) * rs.getFloat(2));
					  
				  }
				 // System.out.println("Quantity total is "+quantity +"And price is $"+ price);
				  
				  java.util.Date date = new java.util.Date();			  
				  java.sql.Timestamp time = new java.sql.Timestamp(date.getTime());
				  
				  PreparedStatement ps = (PreparedStatement) conn.prepareStatement("Insert into cart_pay values(?,?,?,?)");
				  ps.setInt(1,quantity);  
				  ps.setFloat(2,price);  
				  ps.setInt(3,discountValue);  
				  ps.setTimestamp(4,time);
				  ps.execute();
				  return Response.status(200).entity("New Object Instance is created and default Discount of " + discountValue +"% is applied.").build();
				  
			  }
			  else if(clientId.equals("Cart_006"))
			  {
				  
				  String sql = "use cart6";
				  stmt.execute(sql);
				 
				  java.util.Date date = new java.util.Date();			  
				  java.sql.Timestamp time = new java.sql.Timestamp(date.getTime());
					 
				  PreparedStatement ps = (PreparedStatement) conn.prepareStatement("Insert into cart_pay values(0,0,?,?)");
				  ps.setInt(1,discountValue);  
				  ps.setTimestamp(2,time);
					   
				  return Response.status(200).entity("New Object Instance is created and default Discount of " + discountValue +"% is applied.").build();
					
			  }
	    
		
	    } catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	    return Response.status(200).entity("No such Client found").build();
		
	}
	
	
	
/**********Delete Device Management (DELETE)**********/	
	
	@Path("DeleteDiscount/{clientName}/")
	@DELETE
	@Produces("text/html")
	@Consumes("text/html")
	public Response DeleteDiscount(@PathParam("clientName")String clientId) throws JSONException, UnknownHostException {
		
		Connection conn =null;
		Statement stmt = null;
		
		  try {
			
	    	Class.forName("com.mysql.jdbc.Driver");
			
	    	conn = (Connection) DriverManager.getConnection("jdbc:mysql://localhost/Assignment2","root","root");
		
			 stmt = conn.createStatement();
			   if(clientId.equals("Cart_007"))
			  {
				  
				  String sql = "use assignment2";
				  stmt.execute(sql);
				  
				  PreparedStatement pst = (PreparedStatement) conn.prepareStatement("delete from cart_pay");
				  pst.execute();
				  
				  return Response.status(200).entity("Object Instance Discount deleted.").build();
				  
			  }
			  else if(clientId.equals("Cart_006"))
			  {
				  
				  String sql = "use cart6";
				  stmt.execute(sql);
				 
				 
				  PreparedStatement pst = (PreparedStatement) conn.prepareStatement("delete from cart_pay");
				  pst.execute();
				  return Response.status(200).entity("Object Instance Discount deleted.").build();
				
			  }
	    
		
	    } catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	    return Response.status(200).entity("No such Client found").build();
		
	}
	

/**********Write Device Management (PUT)**********/
	
	
	@Path("Discount/{clientName}/")
	@PUT
	@Produces("text/html")
	@Consumes({ MediaType.APPLICATION_FORM_URLENCODED,
		MediaType.APPLICATION_JSON})
	public Response Discount(@PathParam("clientName")String clientId, String discountValue) throws JSONException, UnknownHostException {
		
		Connection conn =null;
		Statement stmt = null;
		
		  try {
			
	    	Class.forName("com.mysql.jdbc.Driver");
			
	    	conn = (Connection) DriverManager.getConnection("jdbc:mysql://localhost/Assignment2","root","root");
		
			  //System.out.println("Creating statement...");
			  stmt = conn.createStatement();
			   if(clientId.equals("Cart_007"))
			  {
				  
				  String sql = "use assignment2";
				  stmt.execute(sql);
				  
				  PreparedStatement pst = (PreparedStatement) conn.prepareStatement("select * from cart_pay");
				  ResultSet rs = pst.executeQuery();
				  
				  if(rs.next())
				  {
					  java.util.Date date = new java.util.Date();			  
					  java.sql.Timestamp time = new java.sql.Timestamp(date.getTime());
					  PreparedStatement ps = (PreparedStatement) conn.prepareStatement("Update cart_pay set discount = discount + ?, time = ?");
					    //ResultSet rs=(ResultSet) ps.executeQuery();
					   // stmt.executeUpdate(ps);
					  ps.setString(1,discountValue);  
					  ps.setTimestamp(2,time);
						 
					  ps.executeUpdate();
					  
				  }else{
					  
					  java.util.Date date = new java.util.Date();			  
					  java.sql.Timestamp time = new java.sql.Timestamp(date.getTime());
					
				  PreparedStatement ps = (PreparedStatement) conn.prepareStatement("Insert into cart_pay values(0,0,?,?)");
				    //ResultSet rs=(ResultSet) ps.executeQuery();
				   // stmt.executeUpdate(ps);
				  ps.setString(1,discountValue);  
				  ps.setTimestamp(2,time);
					
				  ps.execute();
				  /*ResultSetMetaData rsm = (ResultSetMetaData) rs.getMetaData();
				  if(rs.next())
				  {
					  
					  json.put(rsm.getColumnName(1), rs.getString(1));
					
					  
					  return Response.status(200).entity("Discount of " + discountValue +"% is applied.").build();
	  
					  
				  }*/
				  }
				  return Response.status(200).entity("Addtional Discount of " + discountValue +"% is applied.").build();
				  
			  }
			  else if(clientId.equals("Cart_006"))
			  {
				  
				  String sql = "use cart6";
				  stmt.execute(sql);
				 
				 
				  PreparedStatement pst = (PreparedStatement) conn.prepareStatement("select * from cart_pay");
				  ResultSet rs = pst.executeQuery();
				  
				  if(rs.next())
				  {
					  java.util.Date date = new java.util.Date();			  
					  java.sql.Timestamp time = new java.sql.Timestamp(date.getTime());
					 PreparedStatement ps = (PreparedStatement) conn.prepareStatement("Update cart_pay set discount = ?, time = ?");
					    //ResultSet rs=(ResultSet) ps.executeQuery();
					   // stmt.executeUpdate(ps);
					  ps.setString(1,discountValue);  
					  ps.setTimestamp(2,time);
						 
					  ps.executeUpdate();
					  
				  }else{
					  
					  java.util.Date date = new java.util.Date();			  
					  java.sql.Timestamp time = new java.sql.Timestamp(date.getTime());
					
				  PreparedStatement ps = (PreparedStatement) conn.prepareStatement("Insert into cart_pay values(0,0,?,?)");
				    //ResultSet rs=(ResultSet) ps.executeQuery();
				   // stmt.executeUpdate(ps);
				  ps.setString(1,discountValue);  
				  ps.setTimestamp(2,time);
					
				  ps.execute();
				
				  }
				  return Response.status(200).entity("Addtional Discount of " + discountValue +"% is applied.").build();
					 

			  }
	    
		
	    } catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	    return Response.status(200).entity("No such Client found").build();
		
	}
	
	
/**********Notify Information Reporting**********/
	
	static JSONObject json;
	static String json2="";
	
	public void run()
	{
		json = new JSONObject();
		try {
			conn = (Connection) DriverManager.getConnection("jdbc:mysql://localhost/Assignment2","root","root");
		
			stmt = conn.createStatement();
			 PreparedStatement ps = (PreparedStatement)conn.prepareStatement("Select time from observe_cart");
			  ResultSet rs = ps.executeQuery();
			
			PreparedStatement statement = (PreparedStatement)conn.prepareStatement("Select * from checkout_item");
			  ResultSet rs1 = statement.executeQuery();
			  ResultSetMetaData rsm = (ResultSetMetaData) rs1.getMetaData();
					
			 	 
			  rs.next();
			 
			  int t = rs.getInt(1);
			
			  while(rs1.next())
			  {
				if(cancel == 1)
				{
				//	System.out.println("over " + cancel);
					
					break;
				}else{
				  
					DecimalFormat df = new DecimalFormat("#.##");
							
					//json = new JSONObject();
					
					json.put(rsm.getColumnName(1), rs1.getString(1));
					json.put(rsm.getColumnName(2), rs1.getInt(2));
					json.put(rsm.getColumnName(3), df.format(rs1.getFloat(3)));
					json.put(rsm.getColumnName(4), rs1.getString(4));
					
					json2 += json; 
				//	System.out.println(rs1.getString(1) + " " + rs1.getInt(2));
					
					//SendMessage();
					
				}
				 
				 
			  }
			  Thread.sleep(t * 1000);
			  if(cancel == 0)
			  {
				  run();
			  }
				  //System.out.println(rs1.getShort(1));
//			  if(rs1.)
			  
			  
		
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (JSONException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (InterruptedException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally{
			
			try {
				conn.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		
	}


/**********Notify Information Reporting**********/
	
	static int i = 0;
	@Path("Continuous/")
	@GET
	@Produces("text/html")
	@Consumes("application/json")
	public Response SendMessage() throws JSONException
	{
		String trial = "<html><head><body>";
		String end="</body></head></html>";
		//i++;
		//System.out.println("Here in Send Message"+i);
		//System.out.println("Send Message"+json);
		//String yes;
		//yes="{\"id\":\"Pax"+ i +"\"}";
		//System.out.println("New String is " + yes);
		if(cancel == 1)
		{
			return null;
		}
		if(json2 != null){
			//System.out.println("inside not null"+json);
		return Response.status(200).entity(trial+json2+end).build();
		}else
			return Response.status(200).build();	
		
		
	}
	

	@Path("ContinuousPrice/")
	@GET
	@Produces("text/html")
	@Consumes("application/json")
	public Response SendAlert() throws JSONException, SQLException
	{
		
		try {
			
			if(cancel == 1)
			{
				//System.out.println("Here cancel is" + cancel);
				return Response.status(200).entity("cancel").build();
				//return null;
			}
			conn = (Connection) DriverManager.getConnection("jdbc:mysql://localhost/Assignment2","root","root");
			stmt = conn.createStatement();
			PreparedStatement ps = (PreparedStatement)conn.prepareStatement("Select quantity,price from checkout_item");
			ResultSet rs = ps.executeQuery();
			
			PreparedStatement statement = (PreparedStatement)conn.prepareStatement("Select price from observe_cart");
			ResultSet rs1 = statement.executeQuery();
			//ResultSetMetaData rsm = (ResultSetMetaData) rs1.getMetaData();
			float amount = 0;
			while(rs.next())
			{
				amount += (rs.getInt(1)*rs.getFloat(2));
				
			}
			
			if(rs1.next())
			{
				
				if(amount >= rs1.getFloat(1))
				{
					//System.out.println("yes alert ");					
					return Response.status(200).entity("Total purchase of "+ amount +"$ is being done from the cart").build();
					
				}else if(amount <= rs1.getFloat(1))
				{
					return Response.status(200).entity("").build();
					
				}
			}
			
			
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally{
			
			conn.close();
		}
		return null;
		
		
		
		
	}
	
	
/**********Observe Information Reporting (GET)**********/
	
	ClientObserve t;
	
	@Path("ClientObserve/get/{clientName}/")
	@GET
	@Produces("text/html")
	@Consumes("text/html")
	public Response ObserveClient(@PathParam("clientName")String clientId) throws JSONException, UnknownHostException, ClassNotFoundException {
		
		Connection conn =null;
		Statement stmt = null;
		cancel = 0;
		//System.out.println("Client here is :" + clientId);
		
		Class.forName("com.mysql.jdbc.Driver");
		//System.out.println("Connecting to database...");
	    
		try {
			conn = (Connection) DriverManager.getConnection("jdbc:mysql://localhost/Assignment2","root","root");
			stmt = conn.createStatement();
			//System.out.println("Chere.");
			     
			if(clientId.equals("Cart_007"))
			{	  //System.out.println("Creating statement...");
			  //String sql = "CREATE TABLE SERVER_INFO (client_id VARCHAR(255) not NULL, server_info VARCHAR(255), bs_info INTEGER)";
			    
			  //stmt.execute(sql);
			  
			  String sql = "use assignment2";
			  stmt.execute(sql);
			  
			  PreparedStatement pstmt = (PreparedStatement) conn.prepareStatement("Select * from observe_cart");
				//pstmt.setString(1, Id);
				  
			ResultSet rs = pstmt.executeQuery();
				
			if(!rs.next())
			{
				PreparedStatement ps = (PreparedStatement) conn.prepareStatement("INSERT INTO observe_cart values (TRUE,15,1000)");
				  
				//	  ps.setString(1,clientId);  
					  ps.executeUpdate();
						
				return Response.status(200).entity("Server started observing Client "+ clientId).build();
						 
					 
			}
			else
				{
			  
				  
			  PreparedStatement ps = (PreparedStatement) conn.prepareStatement("UPDATE observe_cart SET observe = TRUE");
			  
		//	  ps.setString(1,clientId);  
			  ps.executeUpdate();
			 
			  
			  
			// System.out.println("here it is "+ rs1.getString(1));
			  t = new ClientObserve();
			  
			  t.start();
			//  new ClientObserve();
				
			  return Response.status(200).entity("Server started observing Client "+ clientId).build();
			  
				}
			}
			else if(clientId.equals("Cart_006"))
			{	  //System.out.println("Creating statement...");
			  //String sql = "CREATE TABLE SERVER_INFO (client_id VARCHAR(255) not NULL, server_info VARCHAR(255), bs_info INTEGER)";
			    
			  //stmt.execute(sql);
			  
			  String sql = "use cart6";
			  stmt.execute(sql);
			  
			  
			PreparedStatement pstmt = (PreparedStatement) conn.prepareStatement("Select * from observe_cart");
				//pstmt.setString(1, Id);
				  
			ResultSet rs = pstmt.executeQuery();
			
			  if(!rs.next())
				{
					PreparedStatement ps = (PreparedStatement) conn.prepareStatement("INSERT INTO observe_cart values (TRUE,15,1000)");
					  
					//	  ps.setString(1,clientId);  
						  ps.executeUpdate();
					
					//	  new ClientObserve();
							
						  return Response.status(200).entity("Server started observing Client "+ clientId).build();
							 
						 
				}else {
			  
			 // PreparedStatement ps = (PreparedStatement) conn.prepareStatement("UPDATE SERVER_INFO SET observe=TRUE where client_id = ?");
			    //ResultSet rs=(ResultSet) ps.executeQuery();
			   // stmt.executeUpdate(ps);
			 // ps.setString(1,clientId);  
			  PreparedStatement ps = (PreparedStatement) conn.prepareStatement("UPDATE observe_cart SET observe = TRUE");
			  
			//  ps.execute();
			  ps.executeUpdate();
				
			//  new ClientObserve();
				
			  return Response.status(200).entity("Server started observing Client "+ clientId).build();
 
					}
			}
			
			 
	    
	    } catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	  
		return Response.status(200).entity("No such Client found to be observed.").build();

}
	

/**********Cancel Information Reporting (GET)**********/
	
	@Path("ClientObserveCancel/get/{clientName}/")
	@GET
	@Produces("text/html")
	@Consumes("text/html")
	public Response CancelClient(@PathParam("clientName") String Id) throws JSONException, UnknownHostException, ClassNotFoundException {
		
		Connection conn =null;
		Statement stmt = null;
		
		//System.out.println("Client here is :" + Id);
		
		Class.forName("com.mysql.jdbc.Driver");
		//System.out.println("Connecting to database...");
	    
		cancel = 1;
		try {
			conn = (Connection) DriverManager.getConnection("jdbc:mysql://localhost/Assignment2","root","root");
			stmt = conn.createStatement();
			
			if(Id.equals("Cart_007"))
			{	 
			  String sql = "use assignment2";
			  stmt.execute(sql);
			  
			
			  PreparedStatement pstmt = (PreparedStatement) conn.prepareStatement("UPDATE observe_cart SET observe=FALSE");
			
			  pstmt.executeUpdate();
				
			//  t.stop();
			  return Response.status(200).entity("Observation of client "+ Id + " is Stopped.").build();

			  
			}
			else if(Id.equals("Cart_006"))
			{	  //System.out.println("Creating statement...");
				  //String sql = "CREATE TABLE SERVER_INFO (client_id VARCHAR(255) not NULL, server_info VARCHAR(255), bs_info INTEGER)";
				    
				  //stmt.execute(sql);
				  
				  String sql = "use cart6";
				  stmt.execute(sql);
				  
				
				//PreparedStatement pstmt = (PreparedStatement) conn.prepareStatement("Select client_id from server_info where client_id = ?");
				//pstmt.setString(1, Id);
				
				  PreparedStatement pstmt = (PreparedStatement) conn.prepareStatement("UPDATE observe_cart SET observe=FALSE");
					 
				pstmt.executeUpdate();
				
				  return Response.status(200).entity("Observation of client "+ Id + " is Stopped.").build();
			
			}else
			{
				return Response.status(200).entity("No Such Client found").build();

			}
			
			
			
			
	    
	    } catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return null;
		
	  
		
	}
	

/**********Write Attribute Time Device Management (PUT)**********/	
	
	@Path("TimeParameter/put/")
	@PUT
	@Produces("text/html")
	@Consumes({ MediaType.APPLICATION_FORM_URLENCODED,
		MediaType.APPLICATION_JSON})
	public Response NotificationTime(String NotificationTime) throws JSONException, UnknownHostException {
		
		
	/*	System.out.println("data at server: "+discountValue);

		System.out.println("for client: "+clientId);*/
		
		
		Connection conn =null;
		Statement stmt = null;
		
	//System.out.println("Client here is :" + clientId);
		
		//System.out.println("Connecting to database...");
	    try {
			
	    	Class.forName("com.mysql.jdbc.Driver");
			
	    	conn = (Connection) DriverManager.getConnection("jdbc:mysql://localhost/Assignment2","root","root");
		
			stmt = conn.createStatement();
			  
			String sql = "use assignment2";
			stmt.execute(sql);
				  
				
			PreparedStatement pstmt = (PreparedStatement) conn.prepareStatement("UPDATE observe_cart SET time = "+ NotificationTime);
				
			pstmt.executeUpdate();
			
			PreparedStatement ps = (PreparedStatement) conn.prepareStatement("Select * from observe_cart");
			
			ResultSet rs = ps.executeQuery();
			
			String str = "";
					
			ResultSetMetaData rsm = (ResultSetMetaData) rs.getMetaData();
				  
			String trial= "<html><head><body><br><h4>The client resource model is</h4><table border=1><tr><td>"+rsm.getColumnName(1)+"</td><td>"+rsm.getColumnName(2)+"</td><td>"+rsm.getColumnName(3)+"</td></tr>";
			while(rs.next())
				  
			{
					  
					  //json.put(rsm.getColumnName(1), rs.getString(1));
					  //json.put(rsm.getColumnName(2), rs.getString(2));
					  //json.put(rsm.getColumnName(3), rs.getString(3));
					  str+="<tr><td>"+ rs.getString(1) + "</td>" + "<td>" + rs.getString(2) + "</td>"+ "<td>" + rs.getString(3) + "</td></tr>";
					  
				//	  System.out.println(json);
					  
					  
			}
				  String end = "</table></body></head></html>"; 
				  return Response.status(200).entity("Notification Time Attribute updated."+trial+str+end).build();
				 // return Response.status(200).entity("The resource object of requested client is " + json).build();
			//return Response.status(200).entity("Notification Time Attribute updated.").build();

	    
	    } catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	    return Response.status(200).entity("No such Client found").build();
		
	}
	
	
/**********Write Attribute MaxPrice Device Management (PUT)**********/	

	@Path("MaxPrice/put/")
	@PUT
	@Produces("text/html")
	@Consumes({ MediaType.APPLICATION_FORM_URLENCODED,
		MediaType.APPLICATION_JSON})
	public Response MaximumPrice(String MaxPrice) throws JSONException, UnknownHostException {
		
		
	/*	System.out.println("data at server: "+discountValue);

		System.out.println("for client: "+clientId);*/
		
		
		Connection conn =null;
		Statement stmt = null;
		
		//System.out.println("Client here is :" + clientId);
		
		//System.out.println("Connecting to database...");
	    try {
			
	    	Class.forName("com.mysql.jdbc.Driver");
			
	    	conn = (Connection) DriverManager.getConnection("jdbc:mysql://localhost/Assignment2","root","root");
		
			stmt = conn.createStatement();
			  
			String sql = "use assignment2";
			stmt.execute(sql);
				  
				
			PreparedStatement pstmt = (PreparedStatement) conn.prepareStatement("UPDATE observe_cart SET price = "+ MaxPrice);
				
			pstmt.executeUpdate();
					
			PreparedStatement ps = (PreparedStatement) conn.prepareStatement("Select * from observe_cart");
			
			ResultSet rs = ps.executeQuery();
			
			String str = "";
					
			ResultSetMetaData rsm = (ResultSetMetaData) rs.getMetaData();
				  
			String trial= "<html><head><body><br><h4>The client resource model is</h4><table border=1><tr><td>"+rsm.getColumnName(1)+"</td><td>"+rsm.getColumnName(2)+"</td><td>"+rsm.getColumnName(3)+"</td></tr>";
			while(rs.next())
				  
			{
					  
					  //json.put(rsm.getColumnName(1), rs.getString(1));
					  //json.put(rsm.getColumnName(2), rs.getString(2));
					  //json.put(rsm.getColumnName(3), rs.getString(3));
					  str+="<tr><td>"+ rs.getString(1) + "</td>" + "<td>" + rs.getString(2) + "</td>"+ "<td>" + rs.getString(3) + "</td></tr>";
					  
				//	  System.out.println(json);
					  
					  
			}
				  String end = "</table></body></head></html>"; 
				  return Response.status(200).entity("Price Limit Attribute updated."+trial+str+end).build();
				
			
			//return Response.status(200).entity("Price Limit Attribute updated.").build();

	    
	    } catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	    return Response.status(200).entity("No such Client found").build();
		
	}
	
	
/**********Write Both Attributes Device Management (PUT)**********/	
	
	@Path("allAttributes/put/{NotifyTime}/")
	@PUT
	@Produces("text/html")
	@Consumes({ MediaType.APPLICATION_FORM_URLENCODED,
		MediaType.APPLICATION_JSON})
	public Response BothTimeandPrice(@PathParam("NotifyTime") String NotificationTime,String MaxPrice) throws JSONException, UnknownHostException {
		
		
	/*	System.out.println("data at server: "+discountValue);

		System.out.println("for client: "+clientId);*/
		
		
		Connection conn =null;
		Statement stmt = null;
		
		//System.out.println("Client here is :" + clientId);
		
		//System.out.println("Connecting to database...");
	    try {
			
	    	Class.forName("com.mysql.jdbc.Driver");
			
	    	conn = (Connection) DriverManager.getConnection("jdbc:mysql://localhost/Assignment2","root","root");
		
			stmt = conn.createStatement();
			  
			String sql = "use assignment2";
			stmt.execute(sql);
				  
				
			PreparedStatement pstmt = (PreparedStatement) conn.prepareStatement("UPDATE observe_cart SET time = "+ NotificationTime  +",price = "+ MaxPrice);
				
			pstmt.executeUpdate();
			
			PreparedStatement ps = (PreparedStatement) conn.prepareStatement("Select * from observe_cart");
			
			ResultSet rs = ps.executeQuery();
			
			String str = "";
					
			ResultSetMetaData rsm = (ResultSetMetaData) rs.getMetaData();
				  
			String trial= "<html><head><body><br><h4>The client resource model is</h4><table border=1><tr><td>"+rsm.getColumnName(1)+"</td><td>"+rsm.getColumnName(2)+"</td><td>"+rsm.getColumnName(3)+"</td></tr>";
			while(rs.next())
				  
			{
					  
					  //json.put(rsm.getColumnName(1), rs.getString(1));
					  //json.put(rsm.getColumnName(2), rs.getString(2));
					  //json.put(rsm.getColumnName(3), rs.getString(3));
					  str+="<tr><td>"+ rs.getString(1) + "</td>" + "<td>" + rs.getString(2) + "</td>"+ "<td>" + rs.getString(3) + "</td></tr>";
					  
				//	  System.out.println(json);
					  
					  
			}
				  String end = "</table></body></head></html>"; 
				  return Response.status(200).entity("Both Notification Time and Price Limit Attributes updated."+trial+str+end).build();
				
			//return Response.status(200).entity("Both Notification Time and Price Limit Attributes updated.").build();

	    
	    } catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	    return Response.status(200).entity("No such Client found").build();
		
	}
	

/**********Discover Attribute Time Device Management (GET)**********/	
	
	@Path("TimeParameter/get/{ClientId}")
	@GET
	@Produces("text/html")
	@Consumes({ MediaType.APPLICATION_FORM_URLENCODED,
		MediaType.APPLICATION_JSON})
	public Response GetNotificationTime(@PathParam("ClientId") String ClientName) throws JSONException, UnknownHostException {
		
		
		Connection conn =null;
		Statement stmt = null;
		
		try {
			
	    	Class.forName("com.mysql.jdbc.Driver");
			
	    	conn = (Connection) DriverManager.getConnection("jdbc:mysql://localhost/Assignment2","root","root");
		
			stmt = conn.createStatement();
			
			  if(ClientName.equals("Cart_007"))
			  {
			
			String sql = "use assignment2";
			stmt.execute(sql);
				  
			PreparedStatement pstmt = (PreparedStatement) conn.prepareStatement("Select time from observe_cart");
			ResultSet rs = pstmt.executeQuery();
				
				if(rs.next())
				{
				
					return Response.status(200).entity("Current Notification Time of client "+ClientName +" is " + rs.getString(1) + " seconds.").build();
				
				}else
				{
					return Response.status(200).entity("Value not available in database").build();
				
				}
			  }else if(ClientName.equals("Cart_006"))
			  
			  {
				  String sql = "use cart6";
					stmt.execute(sql);
						  
					PreparedStatement pstmt = (PreparedStatement) conn.prepareStatement("Select time from observe_cart");
					ResultSet rs = pstmt.executeQuery();
						
						if(rs.next())
						{
						
							return Response.status(200).entity("Current Notification Time of client "+ClientName +" is " + rs.getString(1) + " seconds.").build();
						
						}else
						{
							return Response.status(200).entity("Value not available in database").build();
						
						}

			  }
	    } catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	    return Response.status(200).entity("No such Client found").build();
		
	}

/**********Discover Attribute Price Limit Device Management (GET)**********/	
	
	@Path("MaxPrice/get/{ClientId}")
	@GET
	@Produces("text/html")
	@Consumes({ MediaType.APPLICATION_FORM_URLENCODED,
		MediaType.APPLICATION_JSON})
	public Response GetPriceLimit(@PathParam("ClientId") String ClientName) throws JSONException, UnknownHostException {
		
		
		Connection conn =null;
		Statement stmt = null;
		
		try {
			
	    	Class.forName("com.mysql.jdbc.Driver");
			
	    	conn = (Connection) DriverManager.getConnection("jdbc:mysql://localhost/Assignment2","root","root");
		
			stmt = conn.createStatement();
			
			  if(ClientName.equals("Cart_007"))
			  {
			
			String sql = "use assignment2";
			stmt.execute(sql);
				  
			PreparedStatement pstmt = (PreparedStatement) conn.prepareStatement("Select price from observe_cart");
			ResultSet rs = pstmt.executeQuery();
				
				if(rs.next())
				{
				
					return Response.status(200).entity("Current Maximum Price Limit of the client "+ ClientName +" is " + rs.getString(1) + " dollars.").build();
				
				}else
				{
					return Response.status(200).entity("Value not available in database").build();
				
				}
			  }else if(ClientName.equals("Cart_006"))
			  {
				  	String sql = "use cart6";
					stmt.execute(sql);
						  
					PreparedStatement pstmt = (PreparedStatement) conn.prepareStatement("Select price from observe_cart");
					ResultSet rs = pstmt.executeQuery();
						
						if(rs.next())
						{
						
							return Response.status(200).entity("Current Maximum Price Limit of the client "+ ClientName +" is " + rs.getString(1) + " dollars.").build();
								
						}else
						{
							return Response.status(200).entity("Value not available in database").build();
						
						}

			  }
	    } catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	    return Response.status(200).entity("No such Client found").build();
		
	}
	
/**********Execute Device Management (POST) (number of carts currently in used)**********/	
	
	@Path("CartCount/")
	@POST
	@Produces("text/html")
	@Consumes("text/html")
	public Response CartCount() throws JSONException, UnknownHostException {
		
		Connection conn =null;
		Statement stmt = null;
		
		try{
			
	    		Class.forName("com.mysql.jdbc.Driver");
			
	    		conn = (Connection) DriverManager.getConnection("jdbc:mysql://localhost/Assignment2","root","root");
	    		stmt = conn.createStatement();
			   
				  String sql = "use assignment2";
				  stmt.execute(sql);
				  
				  PreparedStatement ps = (PreparedStatement) conn.prepareStatement("Select Count(*) from checkout_item");
				  ResultSet rs = ps.executeQuery();
				  
				  String sql1 = "use cart6";
				  stmt.execute(sql1);
				 
				  PreparedStatement ps1 = (PreparedStatement) conn.prepareStatement("Select Count(*) from checkout_item");
				  ResultSet rs1 = ps1.executeQuery();
				 	
				
				  rs.next();
				  rs1.next();
				  	if(rs.getInt(1)>0 && rs1.getInt(1)>0)
				  	{
					  return Response.status(200).entity("2").build();
				  	}else if((rs.getInt(1)>0 && rs1.getInt(1)==0) || (rs.getInt(1)==0 && rs1.getInt(1)>0))
				  	{
					  return Response.status(200).entity("1").build();
				  	}else
				  	{
				  	  return Response.status(200).entity("0").build();
				  	}
				 
				
		
	    } catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	    return Response.status(200).entity("0").build();
		
	}
}
