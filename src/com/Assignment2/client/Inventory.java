package com.Assignment2.client;

import java.net.UnknownHostException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.DecimalFormat;

import javax.naming.spi.DirStateFactory.Result;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
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

import org.bson.Document;
import org.codehaus.jettison.json.JSONException;
import org.codehaus.jettison.json.JSONObject;

import com.mongodb.BasicDBObject;
import com.mongodb.MongoClient;
import com.mongodb.client.MongoCollection;
import com.mongodb.client.MongoDatabase;
import com.mysql.jdbc.PreparedStatement;
import com.mysql.jdbc.ResultSetMetaData;
import com.sun.research.ws.wadl.Request;


@Path("/handler")
public class Inventory extends Thread{
	
	//Thread t = new Thread();
	static String time = "0";
	
	
	/**********Update**********/
	
	
	
	@Path("/Update1/post/{ProductId}")
	@PUT
	@Produces("text/html")
	@Consumes({MediaType.APPLICATION_FORM_URLENCODED,
		MediaType.APPLICATION_JSON})
	public Response Update_client_Inventory(@PathParam("ProductId")String data, String par) throws JSONException, UnknownHostException, InstantiationException, IllegalAccessException, ClassNotFoundException, SQLException {
		
		Connection conn = null;
		Statement stmt = null;
		//System.out.println("data at server: "+data);
		Class.forName("com.mysql.jdbc.Driver").newInstance();
		//System.out.println("Connecting to a selected database...");
	      conn = DriverManager.getConnection("jdbc:mysql://localhost/inventory","root","root");
	     // System.out.println("Connected database successfully...");
	      //System.out.println("Creating statement...");
	      stmt = conn.createStatement();
	      JSONObject param = new JSONObject(par);
	      String productname = param.getString("ProductName");
	      String quantity = param.getString("Quantity");
	      String weight = param.getString("Weight");
	      String price = param.getString("Price");
	      String type = param.getString("Type");
	    //  String sql = "UPDATE rack1 " +
         //         "SET product_name="+"'"+ productname+"'," +"product_weight="+"'"+ weight+"'," +"product_quantity="+"'"+ quantity+"'," +"product_price="+"'"+price+"',"+"product_type="+"'"+type+"'"+" WHERE product_id="+"'"+data+"'";
	//      System.out.println(sql);
	    //  stmt.executeUpdate(sql);
	    //  ResultSet rs = stmt.executeQuery(sql);
	      
	      PreparedStatement ps = (PreparedStatement) conn.prepareStatement("Update rack1 set product_name=?, product_price = ?, product_quantity=?,product_weight=?,product_type=? where product_id=?");
	      ps.setString(1, productname);
		  ps.setString(2, price);
		  ps.setString(3, quantity);
		  ps.setString(4, weight);
		  ps.setString(5, type);
		  ps.setString(6,data);  
		  int rs = ps.executeUpdate();
		  
		  if(rs<0)
		  {
			  return Response.status(200).entity("No such product found in the rack.").build();
			  
		  }
		  return Response.status(200).entity("The product Item information is updated in the rack.").build();

	}

	/**********Read**********/
	
	@Path("/Read1/get/{clientName}")
	@GET
	@Produces("text/html")
	//@Consumes("text/plain")
	public Response Read_Inventory_SQL(@PathParam("clientName")String client) throws JSONException, UnknownHostException, SQLException, InstantiationException, IllegalAccessException, ClassNotFoundException {
		Connection conn1 = null;
		Statement stmt2 = null;
		String str="";
		ResultSet rs;
		Class.forName("com.mysql.jdbc.Driver").newInstance();
		conn1 = (Connection) DriverManager.getConnection("jdbc:mysql://localhost/inventory","root","root");
		
	    System.out.println("Creating statement...");
	    System.out.println(client);
	    stmt2 = conn1.createStatement();
	    if(client.equals("rack1")){
	    	System.out.println("Hello ");
	    	 rs=stmt2.executeQuery("select * from rack1");	
	    }
	    else{
	    	 rs=stmt2.executeQuery("select * from rack1 WHERE product_name="+"'"+client+"'");
	    }
	    
	    String trial= "<html><head><body><table border=1 style=width:100%><tr><td>Product Name</td><td>Product Price</td><td>Product Quantity</td><td>Product Weight</td><td>Product Type</td></tr>";
	 //   String start = "<html><head><body>";
	    while(rs.next()){
	    	str+="<tr><td>"+ rs.getString("product_name") + "</td>" + "<td>" + rs.getString("product_price") + "</td>"+ "<td>" + rs.getString("product_quantity") + "</td>"+ "<td>" + rs.getString("product_weight") + "</td>"+ "<td>" + rs.getString("product_type") + "</td></tr>";
	    //	str+="Product Name is " + rs.getString("product_name") + ", Product weight is " + rs.getString("product_weight") + ", Product Price is " + rs.getString("product_price")+", Product Quantity is " + rs.getString("product_quantity")+ ", Its of " + rs.getString("product_type") + " type <br/>";
	    	
//	    	System.out.println(rs.getString("product_name") + "," + rs.getString("product_weight") + "," + rs.getString("product_price")+ "," + rs.getString("product_type"));
	    }
	    String end = "</table></body></head></html>"; 
	   
		
		
	   //return Response.status(200).entity("<html><head><body>"+str+" <br>"+"</body></head></html>").build();
	    return Response.status(200).entity(trial+str+end).build();
	}
	
	@Path("/execute/get/{clientName}")
	@GET
	@Produces("text/html")
	//@Consumes("text/plain")
	public Response execute_Inventory_SQL(@PathParam("clientName")String client) throws JSONException, UnknownHostException, SQLException, InstantiationException, IllegalAccessException, ClassNotFoundException {
		Connection conn1 = null;
		Statement stmt2 = null;
		String str="";
		ResultSet rs;
		Class.forName("com.mysql.jdbc.Driver").newInstance();
		conn1 = (Connection) DriverManager.getConnection("jdbc:mysql://localhost/inventory","root","root");
		
	    System.out.println("Creating statement...");
	    System.out.println(client);
	    stmt2 = conn1.createStatement();
	    if(client.equals("rack1")){
	    	System.out.println("Hello ");
	    	 rs=stmt2.executeQuery("select * from rack1");
	    	 str = "Rack 1 is in use";
	    }
	    else if(client.equals("rack2")){
	    	 //rs=stmt2.executeQuery("select * from rack1 WHERE product_name="+"'"+client+"'");
	    	str = "Rack 2 is NOT in use";
	    }
	    else if(client.equals("rack3")){
	    	 //rs=stmt2.executeQuery("select * from rack1 WHERE product_name="+"'"+client+"'");
	    	str = "Rack 3 is NOT in use";
	    }
	    else{
	    	 //rs=stmt2.executeQuery("select * from rack1 WHERE product_name="+"'"+client+"'");
	    	str = "Rack 4 is NOT in use";
	    }
	   /* while(rs.next()){
	    	
	    	str+="Product Name is " + rs.getString("product_name") + ", Product weight is " + rs.getString("product_weight") + ", Product Price is " + rs.getString("product_price")+ ", Its of " + rs.getString("product_type") + " type <br/>";
	    	System.out.println(rs.getString("product_name") + "," + rs.getString("product_weight") + "," + rs.getString("product_price")+ "," + rs.getString("product_type"));
	    }*/
	   
		
		
	    return Response.status(200).entity("<html><head><body>"+str+" </body></head></html>").build();
	
	}
	
	
	/**********Discover attributes Device Management (GET)**********/
	
	@Path("/discover/get/{clientName}/")
	@GET
	@Produces("text/html")
	//@Consumes("text/plain")
	public Response discover_Inventory_SQL(@PathParam("clientName")String clientValue) throws JSONException, UnknownHostException, SQLException, InstantiationException, IllegalAccessException, ClassNotFoundException {
		Connection conn1 = null;
		Statement stmt2 = null;
		Class.forName("com.mysql.jdbc.Driver").newInstance();
		String str="";
		ResultSet rs;
		
		conn1 = (Connection) DriverManager.getConnection("jdbc:mysql://localhost/inventory","root","root");
		
	  //  System.out.println("Creating statement...");
	//    System.out.println(client);
	    stmt2 = conn1.createStatement();
	   
	    
	    //rs=stmt2.executeQuery("select * from rack1 WHERE product_name="+"'"+client+"'");
	    //client1Exist= true;
	  if(clientValue.equals("time_limit")){
	    	 rs=stmt2.executeQuery("select time_limit from observe_inventory");
	    	 while(rs.next()){
	    	 str = "Current Notification Time of client Rack1 is " + rs.getString("time_limit") + " seconds.";
	    	 }
	    }
	    else if(clientValue.equals("quantity")){
	    	rs=stmt2.executeQuery("select quantity from observe_inventory");
	    	while(rs.next()){ 
	    	str = "Current Quantity limit of client Rack1 is " + rs.getString("quantity") + ".";
	    	 }
	    }
	   
	    else if(clientValue.equals("step_size")){
	    	rs=stmt2.executeQuery("select step_size from observe_inventory");
	    	while(rs.next()){ 
	    	str = "Current Step size of client Rack1 is " + rs.getString("step_size") +".";
	    	}
	    }
	   
	    return Response.status(200).entity("<html><head><body> "+str+"</body></head></html>").build();
	
	}
	
	/**********Add**********/
	
	@Path("/write1/post/")
	@POST
	@Produces("text/html")
	@Consumes(MediaType.APPLICATION_JSON)
	public Response create_Inventory(@PathParam("ClientName")String data, String par) throws JSONException, UnknownHostException, InstantiationException, IllegalAccessException, ClassNotFoundException, SQLException {
		
		Connection conn = null;
		Statement stmt = null;
		//System.out.println("data at server: "+data);
		Class.forName("com.mysql.jdbc.Driver").newInstance();
		//System.out.println("Connecting to a selected database...");
	      conn = DriverManager.getConnection("jdbc:mysql://localhost/inventory","root","root");
	     // System.out.println("Connected database successfully...");
	     // System.out.println("Creating statement...");
	      stmt = conn.createStatement();
	      JSONObject param = new JSONObject(par);
	      String productid = param.getString("ProductId");	      
	      String productname = param.getString("ProductName");
	      String quantity = param.getString("Quantity");
	      String weight = param.getString("Weight");
	      String price = param.getString("Price");
	      String type = param.getString("Type");
	    
	     // System.out.println("Name is:"+productname);
	      
	   //   String sql = "INSERT INTO rack1(product_id,product_name,product_price,product_quantity,product_weight,product_type) " +
	    	//	  		"VALUES("+"'"+productid+"',"+productname+"','"+price+"',"+"'"+quantity+"',"+"'"+weight+"'"+",'"+type+"')";
	      //System.out.println(sql);
	  //    stmt.executeUpdate(sql);
	     
	      PreparedStatement ps = (PreparedStatement) conn.prepareStatement("Insert into rack1 values(?,?,?,?,?,?)");
		  ps.setString(1,productid);  
		  ps.setString(2, productname);
		  ps.setString(3, price);
		  ps.setString(4, quantity);
		  ps.setString(5, weight);
		  ps.setString(6, type);
		  ps.execute();
		  
	      
	      // System.out.println("Inserted records into the table...");
		return Response.status(200).entity("<html><head><body>New Inventory is added into the Rack.</body></head></html>").build();

	}
	/**********Write Attribute Time Device Management (PUT)**********/	

	
	@Path("TimeParameter/put/")
	@PUT
	@Produces("text/html")
	@Consumes({ MediaType.APPLICATION_FORM_URLENCODED,
		MediaType.APPLICATION_JSON})
	public Response NotificationTime(String NotificationTime) throws JSONException, UnknownHostException {
		
		
		Connection conn =null;
		Statement stmt = null;
		
	    try {
			
	    	Class.forName("com.mysql.jdbc.Driver");
			
	    	conn = (Connection) DriverManager.getConnection("jdbc:mysql://localhost/inventory","root","root");
		
			stmt = conn.createStatement();
			  
			String sql = "use inventory";
			stmt.execute(sql);
				  
				
			PreparedStatement pstmt = (PreparedStatement) conn.prepareStatement("UPDATE observe_inventory SET time_limit = "+ NotificationTime);
				
			pstmt.executeUpdate();
			
			PreparedStatement ps = (PreparedStatement) conn.prepareStatement("Select * from observe_inventory");
			
			ResultSet rs = ps.executeQuery();
			
			String str = "";
					
			ResultSetMetaData rsm = (ResultSetMetaData) rs.getMetaData();
				  
			String trial= "<html><head><body><br><h4>The client resource model is</h4><table border=1><tr><td>"+rsm.getColumnName(1)+"</td><td>"+rsm.getColumnName(2)+"</td><td>"+rsm.getColumnName(3)+"</td><td>"+rsm.getColumnName(4)+"</td></tr>";
			while(rs.next())
				  
			{
					  
					  //json.put(rsm.getColumnName(1), rs.getString(1));
					  //json.put(rsm.getColumnName(2), rs.getString(2));
					  //json.put(rsm.getColumnName(3), rs.getString(3));
					  str+="<tr><td>"+ rs.getString(1) + "</td>" + "<td>" + rs.getString(2) + "</td>"+ "<td>" + rs.getString(3) + "</td>"+"<td>" + rs.getString(4) + "</td></tr>";
					  
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
	
	
	/**********Write Attribute MinQuantity Device Management (PUT)**********/	

	@Path("MinQuant/put/")
	@PUT
	@Produces("text/html")
	@Consumes({ MediaType.APPLICATION_FORM_URLENCODED,
		MediaType.APPLICATION_JSON})
	public Response MaximumPrice(String MinQuant) throws JSONException, UnknownHostException {
		
		
		//System.out.println(MaxWeight);
		Connection conn =null;
		Statement stmt = null;
		
	    try {
			
	    	Class.forName("com.mysql.jdbc.Driver");
			
	    	conn = (Connection) DriverManager.getConnection("jdbc:mysql://localhost/inventory","root","root");
		
			stmt = conn.createStatement();
			  
			String sql = "use inventory";
			stmt.execute(sql);
				  
				
			PreparedStatement pstmt = (PreparedStatement) conn.prepareStatement("UPDATE observe_inventory SET quantity = "+ MinQuant);
				
			pstmt.executeUpdate();
			
			PreparedStatement ps = (PreparedStatement) conn.prepareStatement("Select * from observe_inventory");
			
			ResultSet rs = ps.executeQuery();
			
			String str = "";
					
			ResultSetMetaData rsm = (ResultSetMetaData) rs.getMetaData();
				  
			String trial= "<html><head><body><br><h4>The client resource model is</h4><table border=1><tr><td>"+rsm.getColumnName(1)+"</td><td>"+rsm.getColumnName(2)+"</td><td>"+rsm.getColumnName(3)+"</td><td>"+rsm.getColumnName(4)+"</td></tr>";
			while(rs.next())
				  
			{
					  str+="<tr><td>"+ rs.getString(1) + "</td>" + "<td>" + rs.getString(2) + "</td>"+ "<td>" + rs.getString(3) + "</td>"+"<td>" + rs.getString(4) + "</td></tr>";
					  
			}
				  String end = "</table></body></head></html>"; 
				  return Response.status(200).entity("Quantity Attribute updated."+trial+str+end).build();
			
	    
	    } catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	    return Response.status(200).entity("No such Client found").build();
		
	}
	

	/**********Write Attribute Step Device Management (PUT)**********/	

	@Path("Step/put/")
	@PUT
	@Produces("text/html")
	@Consumes({ MediaType.APPLICATION_FORM_URLENCODED,
		MediaType.APPLICATION_JSON})
	public Response Step(String step) throws JSONException, UnknownHostException {
		
		
		//System.out.println(MaxWeight);
		Connection conn =null;
		Statement stmt = null;
		
	    try {
			
	    	Class.forName("com.mysql.jdbc.Driver");
			
	    	conn = (Connection) DriverManager.getConnection("jdbc:mysql://localhost/inventory","root","root");
		
			stmt = conn.createStatement();
			  
			String sql = "use inventory";
			stmt.execute(sql);
				  
				
			PreparedStatement pstmt = (PreparedStatement) conn.prepareStatement("UPDATE observe_inventory SET step_size = "+ step);
				
			pstmt.executeUpdate();
			
			PreparedStatement ps = (PreparedStatement) conn.prepareStatement("Select * from observe_inventory");
			
			ResultSet rs = ps.executeQuery();
			
			String str = "";
					
			ResultSetMetaData rsm = (ResultSetMetaData) rs.getMetaData();
				  
			String trial= "<html><head><body><br><h4>The client resource model is</h4><table border=1><tr><td>"+rsm.getColumnName(1)+"</td><td>"+rsm.getColumnName(2)+"</td><td>"+rsm.getColumnName(3)+"</td><td>"+rsm.getColumnName(4)+"</td></tr>";
			while(rs.next())
				  
			{
					  str+="<tr><td>"+ rs.getString(1) + "</td>" + "<td>" + rs.getString(2) + "</td>"+ "<td>" + rs.getString(3) + "</td>"+"<td>" + rs.getString(4) + "</td></tr>";
					  
			}
				  String end = "</table></body></head></html>"; 
				  return Response.status(200).entity("Step Attribute updated."+trial+str+end).build();
			
	    
	    } catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	    return Response.status(200).entity("No such Client found").build();
		
	}

/**********Write all 3 Attributes Device Management (PUT)**********/	
	
	@Path("allAttributes/put/{MaxWeight}/{NotifyTime}/")
	@PUT
	@Produces("text/html")
	@Consumes({ MediaType.APPLICATION_FORM_URLENCODED,
		MediaType.APPLICATION_JSON})
	public Response BothTimeandPrice(@PathParam("MaxWeight") String MinQuant,@PathParam("NotifyTime") String NotifyTime,String Step) throws JSONException, UnknownHostException {
	
		Connection conn =null;
		Statement stmt = null;
		
	    try {
			
	    	
	    	Class.forName("com.mysql.jdbc.Driver");
			
	    	conn = (Connection) DriverManager.getConnection("jdbc:mysql://localhost/inventory","root","root");
		
			stmt = conn.createStatement();
			  
			String sql = "use inventory";
			stmt.execute(sql);
				  
				
			PreparedStatement pstmt = (PreparedStatement) conn.prepareStatement("UPDATE observe_inventory SET quantity = " + MinQuant +",step_size = "+ Step+",time_limit = "+ NotifyTime);
			pstmt.executeUpdate();
			
			PreparedStatement ps = (PreparedStatement) conn.prepareStatement("Select * from observe_inventory");
			
			ResultSet rs = ps.executeQuery();
			
			String str = "";
					
			ResultSetMetaData rsm = (ResultSetMetaData) rs.getMetaData();
				  
			String trial= "<html><head><body><br><h4>The client resource model is</h4><table border=1><tr><td>"+rsm.getColumnName(1)+"</td><td>"+rsm.getColumnName(2)+"</td><td>"+rsm.getColumnName(3)+"</td><td>"+rsm.getColumnName(4)+"</td></tr>";
			while(rs.next())
				  
			{
					  str+="<tr><td>"+ rs.getString(1) + "</td>" + "<td>" + rs.getString(2) + "</td>"+ "<td>" + rs.getString(3) + "</td>"+"<td>" + rs.getString(4) + "</td></tr>";
					  
			}
				  String end = "</table></body></head></html>"; 
				  return Response.status(200).entity("Time, Quantity and Step Attribute updated."+trial+str+end).build();
			
	    
	    } catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	    return Response.status(200).entity("No such Client found").build();
		
		
		
	}
	
	/***CHANGES*****/

	/**********Notify Information Reporting**********/

	static int cancel = 0;
	static String str="";
	static String trial,end;
	static Connection conn =null;
	static Statement stmt = null;

	static JSONObject json;
	public void run()
	{
		json = new JSONObject();
		try {
			Class.forName("com.mysql.jdbc.Driver").newInstance();
			conn = (Connection) DriverManager.getConnection("jdbc:mysql://localhost/inventory","root","root");
			stmt = conn.createStatement();
			 PreparedStatement ps = (PreparedStatement)conn.prepareStatement("Select time_limit,quantity from observe_inventory");
			  ResultSet rs = ps.executeQuery();
			 rs.next();
			  int t = rs.getInt(1);
			  int quantity = rs.getInt(2);
				
				ResultSet rst;
				
				
			    rst=stmt.executeQuery("select * from rack1");	
			    trial= "<html><head><body>";
		    	
			    while(rst.next()){
			    	if(cancel == 1)
					{
					//	System.out.println("over " + cancel);
						
						break;
					}else{
					  
						
						
			    	str+="Product Name is " + rst.getString("product_name") +", Product Price is " + rst.getString("product_price")+ ", Product Quantity is " + rst.getString("product_quantity")+", Product weight is " + rst.getString("product_weight")  + ", Its of " + rst.getString("product_type") + " type<br/>";
			    	//System.out.println(rst.getString("product_name") + "," + rst.getString("product_weight") + "," + rst.getString("product_price")+ "," + rst.getString("product_type"));
			  
			    	if(rst.getInt("product_quantity") <= quantity)
					{
						str+="***Product Id "+rst.getString("product_id")+" is having low stock balance with "+ rst.getInt("product_quantity")+" quantity left.<br/>";
					}
			    	
			    		str+="<br/>";
			    		end= "</body></head></html>";
			    	
					  
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
		} catch (InterruptedException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (InstantiationException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IllegalAccessException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (ClassNotFoundException e) {
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
	@Path("ContinuousInventory/")
	@GET
	@Produces("text/html")
	@Consumes("application/json")
	public Response SendMessage() throws JSONException
	{
		if(cancel == 1)
		{
			return null;
		}
		if(str != null){
			//System.out.println("inside not null"+json);
		return Response.status(200).entity(trial+str+end).build();
		}else
			return Response.status(200).build();	
		
	}
	
	Inventory t;
	
	/**********Observe Information Reporting (GET)**********/

	@Path("/observe/{clientName}/")
	@GET
	@Produces("text/plain")
	public Response observe(@PathParam("clientName")String clientId) throws SQLException, InstantiationException, IllegalAccessException, ClassNotFoundException
	{	
		Connection conn = null;
		Statement stmt = null;
		
		System.out.println("Client is"+clientId);
		
		Class.forName("com.mysql.jdbc.Driver").newInstance();
		conn = (Connection) DriverManager.getConnection("jdbc:mysql://localhost/inventory","root","root");
		
		 PreparedStatement pstmt = (PreparedStatement) conn.prepareStatement("Select * from observe_inventory");
			//pstmt.setString(1, Id);
			  
		ResultSet rss = pstmt.executeQuery();
			
		if(!rss.next())
		{
			PreparedStatement ps = (PreparedStatement) conn.prepareStatement("INSERT INTO observe_inventory values (TRUE,15,500,10)");
			  
			//	  ps.setString(1,clientId);  
				  ps.executeUpdate();
					
			return Response.status(200).entity("Server started observing Client "+ clientId).build();
				 
		}
		else
			{
		  PreparedStatement ps = (PreparedStatement) conn.prepareStatement("UPDATE observe_inventory SET occupied = TRUE");
		  
	  ps.executeUpdate();
		 
		  t = new Inventory();
		  
		  t.start();
			
		  return Response.status(200).entity("Server started observing Client "+ clientId).build();
		  
		}
		
	
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
			conn = (Connection) DriverManager.getConnection("jdbc:mysql://localhost/inventory","root","root");
			stmt = conn.createStatement();
			
			if(Id.equals("Rack1"))
			{	 
			  String sql = "use inventory";
			  stmt.execute(sql);
			  
			
			  PreparedStatement pstmt = (PreparedStatement) conn.prepareStatement("UPDATE observe_inventory SET occupied=FALSE");
			
			  pstmt.executeUpdate();
				
			//  t.stop();
			  return Response.status(200).entity("Observation of client "+ Id + " is Stopped.").build();

			  
			}
			else
			{
				return Response.status(200).entity("No Such Client found").build();

			}
			
	  
	    } catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return null;
		
	}
	
	/****LEFT****/
	
	@Path("/stepsize/post/")
	@POST
	@Produces("text/html")
	@Consumes({MediaType.APPLICATION_FORM_URLENCODED,
		MediaType.APPLICATION_JSON})
	public Response stepsize_query(@PathParam("ClientName")String data, String par) throws JSONException, UnknownHostException, InstantiationException, IllegalAccessException, ClassNotFoundException, SQLException {
		
		Connection conn = null;
		Statement stmt = null;
		System.out.println("data at server: "+data);
		Class.forName("com.mysql.jdbc.Driver").newInstance();
		System.out.println("Connecting to a selected database...");
	      conn = DriverManager.getConnection("jdbc:mysql://localhost/inventory","root","root");
	      System.out.println("Connected database successfully...");
	      System.out.println("Creating statement...");
	      stmt = conn.createStatement();
	      JSONObject param = new JSONObject(par);
	      String weightlimit = param.getString("step_size");
	     // String weight = param.getString("Weight");
	      //String price = param.getString("Price");
	     // String type = param.getString("Type");
	    
	      String sql = "UPDATE observe_inventory "+
  		  		"SET step_size="+"'"+weightlimit+"'";
	      System.out.println(sql);
	      stmt.executeUpdate(sql);
	      System.out.println("Inserted records into the table...");
		return Response.status(200).entity("<html><head><body>Inventory Registration Process has been completed with Server_Walmart. <br> <br>To Update inventory <a href="+"http://localhost:8080/Assignment2/Update1.jsp"+">click here</a></body></head></html>").build();

	}

	@Path("/weightlimitmax/post/")
	@POST
	@Produces("text/html")
	@Consumes({MediaType.APPLICATION_FORM_URLENCODED,
		MediaType.APPLICATION_JSON})
	public Response weightlimitmax_query(@PathParam("ClientName")String data, String par) throws JSONException, UnknownHostException, InstantiationException, IllegalAccessException, ClassNotFoundException, SQLException {
		
		Connection conn = null;
		Statement stmt = null;
		System.out.println("data at server: "+data);
		Class.forName("com.mysql.jdbc.Driver").newInstance();
		System.out.println("Connecting to a selected database...");
	      conn = DriverManager.getConnection("jdbc:mysql://localhost/inventory","root","root");
	      System.out.println("Connected database successfully...");
	      System.out.println("Creating statement...");
	      stmt = conn.createStatement();
	      JSONObject param = new JSONObject(par);
	      String weightlimit = param.getString("quantity");
	     // String weight = param.getString("Weight");
	      //String price = param.getString("Price");
	     // String type = param.getString("Type");
	    
	      String sql = "UPDATE observe_inventory "+
  		  		"SET quantity="+"'"+weightlimit+"'";
	      System.out.println(sql);
	      stmt.executeUpdate(sql);
	      System.out.println("Inserted records into the table...");
		return Response.status(200).entity("<html><head><body>Inventory Registration Process has been completed with Server_Walmart. <br> <br>To Update inventory <a href="+"http://localhost:8080/Assignment2/Update1.jsp"+">click here</a></body></head></html>").build();

	}

	@Path("/delete1/post/{Client_Id}")
	@DELETE
	@Produces("text/html")
	//@Consumes("text/plain")
	public Response Delete_client_Inventory(@PathParam("Client_Id")String delete_data) throws JSONException, UnknownHostException, ClassNotFoundException, SQLException {
		
		Connection conn = null;
		Statement stmt = null;
		
		Class.forName("com.mysql.jdbc.Driver");
	//	System.out.println("Connecting to a selected database...");
	      conn = DriverManager.getConnection("jdbc:mysql://localhost/inventory","root","root");
	     // System.out.println("Connected database successfully...");
	     // System.out.println("Creating statement...");
	      
	      stmt = conn.createStatement();
	      
	      String sql = "DELETE FROM rack1 " +
                  "WHERE product_id="+"'"+delete_data+"'";
	      System.out.println(sql);
	      stmt.executeUpdate(sql);
	      
		
		
		return Response.status(200).entity("Product Item deleted from the rack.").build();

	}

	//
	 


	
}