package com.Assignment2.server;

import java.net.UnknownHostException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Iterator;
import com.mongodb.Block;
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
import javax.ws.rs.core.Response.ResponseBuilder;

import org.bson.Document;
import org.bson.conversions.Bson;
import org.codehaus.jackson.map.util.JSONPObject;
import org.codehaus.jettison.json.JSONException;
import org.codehaus.jettison.json.JSONObject;
//import org.eclipse.jdt.internal.compiler.ast.Block;

import com.mongodb.BasicDBObject;
import com.mongodb.DB;
import com.mongodb.DBCollection;
import com.mongodb.DBCursor;
import com.mongodb.DBObject;
import com.mongodb.MongoClient;
import com.mongodb.client.FindIterable;
import com.mongodb.client.MongoCollection;
import com.mongodb.client.MongoCursor;
import com.mongodb.client.MongoDatabase;
import org.bson.Document;
import com.mongodb.client.FindIterable;

import static com.mongodb.client.model.Filters.*;
import static com.mongodb.client.model.Sorts.ascending;
import static java.util.Arrays.asList;

@Path("/clientserver/")
public class Server_USA {

	@Path("/Register/post")
	@POST
	@Produces("text/html")
	@Consumes({MediaType.APPLICATION_FORM_URLENCODED,
		MediaType.APPLICATION_JSON})
	public Response Register_Inventory(JSONObject data) throws JSONException, UnknownHostException {
		
		
		System.out.println("data at server: "+data);
		
		MongoClient mongoClient = new MongoClient( "localhost" , 27017 );
//Get database and collection    
		MongoDatabase db = mongoClient.getDatabase("ServerSideDatabase");
        System.out.println("Connect to database successfully");
        MongoCollection<Document> coll = db.getCollection("INVENTORY_LIST");
        System.out.println("Collection created successfully");
        
        Document document = new Document();
        
//Add document to database
        
        document.put("_id",data.getString("ProductId"));
        document.put("product_name",data.getString("Name"));
        document.put("quantity",data.getString("Quantity"));
        document.put("price",data.getString("Price"));
        document.put("weight",data.getString("Weight"));
        document.put("type",data.getString("Type"));
        
        
        //document.put("client_manufacturer",data.getString("manufacturer"));
        //document.put("client_model",data.getString("model"));
        //document.put("client_version",data.getString("version"));
        //document.put("client_ip",data.getString("ip"));
        //document.put("client_type",data.getString("type"));
        
        coll.insertOne(document);
        
        System.out.println("document created successfully");
        
        mongoClient.close();
		return Response.status(200).entity("<html><head><body>Inventory Registration Process has been completed with Server_Walmart. <br> <br>To Update inventory <a href="+"http://localhost:8080/Assignment2/Update.jsp"+">click here</a></body></head></html>").build();

	}
	
	
	@Path("/Update/post/{ClientName}")
	@PUT
	@Produces("text/html")
	@Consumes({MediaType.APPLICATION_FORM_URLENCODED,
		MediaType.APPLICATION_JSON})
	public Response Update_Inventory(@PathParam("ClientName")String data, String par) throws JSONException, UnknownHostException {
		
		
		System.out.println("data at server: "+data);
		
		MongoClient mongoClient = new MongoClient( "localhost" , 27017 );
	    
		MongoDatabase db = mongoClient.getDatabase("ServerSideDatabase");
        System.out.println("Connect to database successfully");
        MongoCollection<Document> coll = db.getCollection("INVENTORY_LIST");
        System.out.println("Collection created successfully");
        
        //MongoDatabase db1 = mongoClient.getDatabase("Kathan");
        
        
        Document document = new Document();
        
        JSONObject param = new JSONObject(par);
        
        BasicDBObject query = new BasicDBObject();
        
        query.put("_id", data);
        System.out.println(data);  
     
        document.put("product_name",param.getString("ProductName"));
        document.put("quantity",param.getString("Quantity"));
        document.put("price",param.getString("Price"));
        document.put("weight",param.getString("Weight"));
        document.put("type",param.getString("Type"));
      
        System.out.println(par);
    //    System.out.println(product_name +);
        //document.put("client_manufacturer",data.getString("manufacturer"));
        //document.put("client_model",data.getString("model"));
        //document.put("client_version",data.getString("version"));
        //document.put("client_ip",data.getString("ip"));
        //document.put("client_type",data.getString("type"));
        
        BasicDBObject updated = new BasicDBObject();
        updated.put("$set", document);
        
        coll.updateMany(query,updated);
        
        System.out.println("document created successfully");
        
        mongoClient.close();
		return Response.status(200).entity("<html><head><body>Update inventory Request has been completed with Server_Walmart. <br> <br>To go back to main menu <a href="+"http://localhost:8080/Assignment2/Home.jsp"+">click here</a></body></head></html>").build();

	}
	/*
	@Path("/Update1/post/{ClientName}")
	@PUT
	@Produces("text/html")
	@Consumes({MediaType.APPLICATION_FORM_URLENCODED,
		MediaType.APPLICATION_JSON})
	public Response Update_client_Inventory(@PathParam("ClientName")String data, String par) throws JSONException, UnknownHostException, InstantiationException, IllegalAccessException, ClassNotFoundException, SQLException {
		
		Connection conn = null;
		   Statement stmt = null;
		System.out.println("data at server: "+data);
		Class.forName("com.mysql.jdbc.Driver").newInstance();
		System.out.println("Connecting to a selected database...");
	      conn = DriverManager.getConnection("jdbc:mysql://localhost/client_detail","root","kathan");
	      System.out.println("Connected database successfully...");
	      System.out.println("Creating statement...");
	      stmt = conn.createStatement();
	      JSONObject param = new JSONObject(par);
	      String productname = param.getString("ProductName");
	      String weight = param.getString("Weight");
	      String price = param.getString("Price");
	      String type = param.getString("Type");
	      String sql = "UPDATE cart1 " +
                  "SET product_name="+"'"+ productname+"'," +"product_weight="+"'"+ weight+"'," +"product_price="+"'"+price+"',"+"product_type="+"'"+type+"'"+" WHERE client_id="+"'"+data+"'";
	      System.out.println(sql);
	      stmt.executeUpdate(sql);
	    //  ResultSet rs = stmt.executeQuery(sql);
	      
		
		
				return Response.status(200).entity("<html><head><body>Update inventory Request has been completed with Server_Walmart. <br> <br>To go back to main menu <a href="+"http://localhost:8080/Assignment2/Home.jsp"+">click here</a></body></head></html>").build();

	}
	*/
	@Path("/Delete/{Client_Id}")
	@DELETE
	@Produces("text/html")
	//@Consumes("text/plain")
	public Response Delete_Inventory(@PathParam("Client_Id")String delete_data) throws JSONException, UnknownHostException {
		
		System.out.println("data at server: "+delete_data);
		
		MongoClient mongoClient = new MongoClient( "localhost" , 27017 );
	    
		MongoDatabase db = mongoClient.getDatabase("ServerSideDatabase");
        
        MongoCollection<Document> coll = db.getCollection("INVENTORY_LIST");
      //  System.out.println("Collection created successfully");
        
        Document document = new Document();
        
        BasicDBObject query = new BasicDBObject();
        
        query.put("_id", delete_data);
       
        
       // document.remove(query);
       
       // coll.deleteOne(document);
       db.getCollection("INVENTORY_LIST").deleteOne(query);
       
        
        System.out.println("document created successfully");
        
        mongoClient.close();
		return Response.status(200).entity("<html><head><body>Delete inventory Process has been completed with Server_Walmart. <br> <br>The data related to client is deleted from Server Resource Model. <br> <br> To go back to main menu:<a href="+"http://localhost:8080/Assignment2/Home.jsp"+">click here</a></body></head></html>").build();

	}
	
	@Path("/Read/get/{clientName}")
	@GET
	@Produces("text/html")
	//@Consumes("text/plain")
	public Response Read_Inventory(@PathParam("clientName")String client) throws JSONException, UnknownHostException {
		
		MongoClient mongoClient = new MongoClient( "localhost" , 27017 );
	    System.out.println(client);
		MongoDatabase db = mongoClient.getDatabase("ServerSideDatabase");
		System.out.println("Connect to database successfully");
        //MongoCollection<Document> coll = db.getCollection("INVENTORY_LIST");
     //   System.out.println("Collection created successfully");
        
        //BasicDBObject whereQuery = new BasicDBObject();
    /*	//whereQuery.put("_id", data);
    	FindIterable<Document> cursor = coll.find(whereQuery);
    	while(((Iterator<DBObject>) cursor).hasNext()) {
    	    System.out.println(((Iterator<DBObject>) cursor).next());
    	}    */
        
        System.out.println("here: "+client);
        MongoCursor<Document> cursor = db.getCollection("INVENTORY_LIST").find().iterator();
        	    
    	  while(cursor.hasNext())
          {
          	Document doc = cursor.next();
          	if(doc.getString("product_name").equals(client))
          	{
          		System.out.println(doc.toJson());
          		mongoClient.close();
          	
          		return Response.status(200).entity("<html><head><body>"+doc.toJson()).build();
          	    
          		//return Response.status(200).entity(doc.toJson()).build();
          	}
          }
         
    	    
    	return Response.status(200).entity("<html><head><body> <br> <br>Read done <br> <br> To go back to main menu:<a href="+"http://localhost:8080/Assignment2/Home.jsp"+">click here</a></body></head></html>").build();

		
		
	
	}
	@Path("/Read1/get/")
	@GET
	@Produces("text/html")
	//@Consumes("text/plain")
	public Response Read_All_Inventory(@PathParam("clientName")String client) throws JSONException, UnknownHostException {
		
		MongoClient mongoClient = new MongoClient( "localhost" , 27017 );
	    System.out.println(client);
		MongoDatabase db = mongoClient.getDatabase("ServerSideDatabase");
		System.out.println("Connect to database successfully");
        //MongoCollection<Document> coll = db.getCollection("INVENTORY_LIST");
     //   System.out.println("Collection created successfully");
        
        //BasicDBObject whereQuery = new BasicDBObject();
    /*	//whereQuery.put("_id", data);
    	FindIterable<Document> cursor = coll.find(whereQuery);
    	while(((Iterator<DBObject>) cursor).hasNext()) {
    	    System.out.println(((Iterator<DBObject>) cursor).next());
    	}    */
        
        System.out.println("here: "+client);
        MongoCursor<Document> cursor = db.getCollection("INVENTORY_LIST").find().iterator();
      /*  
        FindIterable<Document> iterable = db.getCollection("INVENTORY_LIST").find();
        
        iterable.forEach(new Block<Document>() {
            @Override
            public Response apply(final Document document) {
                System.out.println(document);
             return Response.ok(document,MediaType.APPLICATION_JSON).build(); 
            }
        });
        
     */
        String str="";
    	  while(cursor.hasNext())
          {
          	
        //  	if(doc.getString("product_name").equals(client))
          //	{
    		  Document doc = cursor.next();
          		System.out.println(doc.toJson());
          		
          		 str+=doc.toJson()+"<br>";
          		
         // 	}
          }
    	  mongoClient.close();
    	  return Response.status(200).entity(str).build();
    	  
    	//	return Response.status(200).entity("<html><head><body>"+document;
    	    
//  	return Response.status(200).entity("<html><head><body> <br> <br>Read done <br> <br> To go back to main menu:<a href="+"http://localhost:8080/Assignment2/Home.jsp"+">click here</a></body></head></html>").build();

		
		
	
	}

/*	@Path("/Read1/get/{clientName}")
	@GET
	@Produces("text/html")
	//@Consumes("text/plain")
	public Response Read_Inventory_SQL(@PathParam("clientName")String client) throws JSONException, UnknownHostException, SQLException {
		Connection conn1 = null;
		Statement stmt2 = null;
		String str="";
		ResultSet rs;
		
		conn1 = (Connection) DriverManager.getConnection("jdbc:mysql://localhost/client_detail","root","kathan");
		
	    System.out.println("Creating statement...");
	    System.out.println(client);
	    stmt2 = conn1.createStatement();
	    if(client.equals("All")){
	    	System.out.println("Hello ");
	    	 rs=stmt2.executeQuery("select * from cart1");	
	    }
	    else{
	    	 rs=stmt2.executeQuery("select * from cart1 WHERE product_name="+"'"+client+"'");
	    }
	    while(rs.next()){
	    	str+="Product Name is " + rs.getString("product_name") + ", Product weight is " + rs.getString("product_weight") + ", Product Price is " + rs.getString("product_price")+ ", Its of " + rs.getString("product_type") + " type <br/>";
	    	System.out.println(rs.getString("product_name") + "," + rs.getString("product_weight") + "," + rs.getString("product_price")+ "," + rs.getString("product_type"));
	    }
	    
		
		
	    return Response.status(200).entity("<html><head><body> <br> <br>"+str+" <br> <br> To go back to main menu:<a href="+"http://localhost:8080/Assignment2/Home.jsp"+">click here</a></body></head></html>").build();
	
	}
*/	
	
}
