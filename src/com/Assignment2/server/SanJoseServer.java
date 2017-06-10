package com.Assignment2.server;

import java.net.UnknownHostException;

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

import org.bson.Document;
import org.codehaus.jettison.json.JSONException;
import org.codehaus.jettison.json.JSONObject;

import com.mongodb.BasicDBObject;
import com.mongodb.Block;
import com.mongodb.DBCollection;
import com.mongodb.DBObject;
import com.mongodb.MongoClient;
import com.mongodb.client.FindIterable;
import com.mongodb.client.MongoCollection;
import com.mongodb.client.MongoCursor;
import com.mongodb.client.MongoDatabase;
import com.mongodb.client.result.DeleteResult;
import com.mongodb.util.JSON;


@Path("/client")
public class SanJoseServer {

	
/**********Registration (POST)**********/
	
	@Path("/Register/post/")
	@POST
	@Produces("text/html")
	@Consumes({ MediaType.APPLICATION_FORM_URLENCODED,
		MediaType.APPLICATION_JSON })
	public Response Serve(String obj) throws JSONException, UnknownHostException {
		
		JSONObject data = new JSONObject(obj);
        
	//	System.out.println("data at server: "+data);
		
		MongoClient mongoClient = new MongoClient( "localhost" , 27017 );
	    
		MongoDatabase db = mongoClient.getDatabase("Paxshal");
    //    System.out.println("Connect to database successfully");
        MongoCollection<Document> coll = db.getCollection("Device_List");
      //  System.out.println("Collection created successfully");
        
        Document document = new Document();
        
        document.put("_id",data.getString("name"));
        document.put("client_manufacturer",data.getString("manufacturer"));
        document.put("client_model",data.getString("model"));
        //document.put("client_version",data.getString("version"));
        //document.put("client_ip",data.getString("ip"));
        document.put("client_type",data.getString("type"));
        
        coll.insertOne(document);
        
       // System.out.println("document created successfully");
        
        mongoClient.close();
		return Response.status(200).entity("Your Registration Process has been completed with the Server").build();

	}
	
	/**********Update (PUT)**********/
	
	@Path("/Update/put/{clientName}")
	@PUT
	@Produces("text/html")
	@Consumes({ MediaType.APPLICATION_FORM_URLENCODED,
		MediaType.APPLICATION_JSON })
	public Response Serve_Update(@PathParam("clientName")String clientId, String data) throws JSONException, UnknownHostException {
		
		
		//System.out.println("data at server: "+data);
		
		MongoClient mongoClient = new MongoClient( "localhost" , 27017 );
	    
		MongoDatabase db = mongoClient.getDatabase("Paxshal");
        //System.out.println("Connect to database successfully");
        MongoCollection<Document> coll = db.getCollection("Device_List");
      //  System.out.println("Collection created successfully");
        
        Document document = new Document();
      
        BasicDBObject query = new BasicDBObject();

        JSONObject partsData = new JSONObject(data);
        System.out.println("Client: "+ clientId + "manufacturer " + partsData.optString("manufacturer"));
        
       		query.put("_id", clientId);
           
              document.put("client_manufacturer",partsData.getString("manufacturer"));
              document.put("client_model",partsData.getString("model"));
              document.put("client_type",partsData.getString("type"));
              
              BasicDBObject updated = new BasicDBObject();
              updated.put("$set", document);
              
              coll.updateMany(query,updated);

       /*query.put("_id", clientId);
      //  System.out.println(data.get("name"));  
     
        document.put("client_manufacturer",partsData.getString("manufacturer"));
        document.put("client_model",partsData.getString("model"));
       // document.put("client_version",partsData.getString("version"));
       // document.put("client_ip",partsData.getString("ip"));
        document.put("client_type",partsData.getString("type"));
        
        BasicDBObject updated = new BasicDBObject();
        updated.put("$set", document);
        
        coll.updateMany(query,updated);*/
        
        
        mongoClient.close();
		return Response.status(200).entity("Your Update Process has been completed with the Server").build();

	}
	
/**********De-Register Client**********/
	
	@Path("/Delete/{clientName}")
	@DELETE
	@Produces("text/plain")
	public Response Delete(@PathParam("clientName")String clientId) throws JSONException, UnknownHostException {
		
		MongoClient mongoClient = new MongoClient( "localhost" , 27017 );
	    
		MongoDatabase db = mongoClient.getDatabase("Paxshal");
        
     //   System.out.println("Collection created successfully");
        
        
        BasicDBObject query = new BasicDBObject();
  
        System.out.println("Client to be deleted is "+clientId);
  
        query.put("_id", clientId);
       
        FindIterable<Document> iterable = db.getCollection("Device_List").find(new Document("_id",clientId));
        
        iterable.forEach(new Block<Document>(){
        public void apply(final Document document1){
        		
        		System.out.println("Document to be deleted is "+document1);
        	}
        	
        });
        
        DeleteResult x;
       	x = db.getCollection("Device_List").deleteMany(new Document("_id",clientId));
        //System.out.println(x);
        int count = (int) x.getDeletedCount();
       	
       	if(count !=1)
        {
        	System.out.println("Error...No such Document found");
           
             mongoClient.close();
             return Response.status(200).entity("Error... Client ID not found in database.").build();

        	//return 
        }else{
        	 System.out.println("document deleted successfully");
             mongoClient.close();
      		 return Response.status(200).entity("De-Registration Process has been completed with Server.").build();

        }
        
   }
	

/**********Add Inventory (POST)**********/
	
	@Path("/SetInventory/post/")
	@POST
	@Produces("text/html")
	@Consumes({ MediaType.APPLICATION_FORM_URLENCODED,
		MediaType.APPLICATION_JSON })
	public void SetInventory(String obj) throws JSONException, UnknownHostException {
		
		JSONObject data = new JSONObject(obj);
    
		MongoClient mongoClient = new MongoClient( "localhost" , 27017 );
	    
		MongoDatabase db = mongoClient.getDatabase("Paxshal");
    //    System.out.println("Connect to database successfully");
        MongoCollection<Document> coll = db.getCollection("INVENTORY_LIST");
      //  System.out.println("Collection created successfully");
        
        
        MongoCursor<Document> cursor = db.getCollection("INVENTORY_LIST").find().iterator();
        int total=0;
        while(cursor.hasNext())
        {
    		Document doc = cursor.next();
        	if(doc.getString("_id").equals(data.getString("ProductId")))
        	{
        		total = data.getInt("Quantity") + Integer.parseInt(doc.getString("quantity"));
        	//	db."INVENTORY_LIST".update({'_id':'B1234'},{$set:{'quantity':'total'}});
        		 	BasicDBObject newDocument = new BasicDBObject();
        	        newDocument.append("$set", new BasicDBObject().append("quantity", total));
        	    	
        	        BasicDBObject searchQuery = new BasicDBObject().append("_id", data.getString("ProductId"));

        	        coll.updateOne(searchQuery, newDocument);
        	        
        	        mongoClient.close();
        	        return;
        	}
        	
        	
        }
  
        Document document = new Document();
        
        document.put("_id",data.getString("ProductId"));
        document.put("product_name",data.getString("ProductName"));
        document.put("price",data.getString("Price"));
        document.put("quantity",data.getString("Quantity"));
        document.put("weight",data.getString("Weight"));
        document.put("type",data.getString("Type"));
        
        coll.insertOne(document);
        
       // System.out.println("document created successfully");
        
        mongoClient.close();
//		return Response.status(200).entity("Your Registration Process has been completed with the Server").build();

	}
	

	
/**********Update Inventory (POST)**********/
	
	@Path("/UpdateInventory/post/{ProductId}/")
	@PUT
	@Produces("text/html")
	@Consumes({ MediaType.APPLICATION_FORM_URLENCODED,
		MediaType.APPLICATION_JSON })
	public void UpdateInventory(@PathParam("ProductId")String ProductId ,String obj) throws JSONException, UnknownHostException {
		
		JSONObject data = new JSONObject(obj);
    
		MongoClient mongoClient = new MongoClient( "localhost" , 27017 );
	    
		MongoDatabase db = mongoClient.getDatabase("Paxshal");
    //    System.out.println("Connect to database successfully");
        MongoCollection<Document> coll = db.getCollection("INVENTORY_LIST");
      //  System.out.println("Collection created successfully");
        
        
        MongoCursor<Document> cursor = db.getCollection("INVENTORY_LIST").find().iterator();
        while(cursor.hasNext())
        {
    		Document doc = cursor.next();
        	if(doc.getString("_id").equals(ProductId))
        	{
        		 	BasicDBObject newDocument = new BasicDBObject();
        	        newDocument.append("$set", new BasicDBObject().append("quantity", data.getString("Quantity")));
        	    	
        	        BasicDBObject searchQuery = new BasicDBObject().append("_id", ProductId);

        	        coll.updateOne(searchQuery, newDocument);
        	        
        	        newDocument.append("$set", new BasicDBObject().append("product_name", data.getString("ProductName")));
        	        coll.updateOne(searchQuery, newDocument);
         	       
        	        newDocument.append("$set", new BasicDBObject().append("price", data.getString("Price")));
        	        coll.updateOne(searchQuery, newDocument);
         	       
        	        newDocument.append("$set", new BasicDBObject().append("weight", data.getString("Weight")));
        	        coll.updateOne(searchQuery, newDocument);
         	       
        	        newDocument.append("$set", new BasicDBObject().append("type", data.getString("Type")));
        	        coll.updateOne(searchQuery, newDocument);
         	       
         	       
        	        mongoClient.close();
        	        return;
        	}
        	
        	
        }
  
        mongoClient.close();
//		return Response.status(200).entity("Your Registration Process has been completed with the Server").build();

	}
	
	
	
	
/**********Delete Inventory (DELETE)**********/
	
	@Path("/DeleteInventory/post/{ProductId}/")
	@DELETE
	@Produces("text/html")
	@Consumes({ MediaType.APPLICATION_FORM_URLENCODED,
		MediaType.APPLICATION_JSON })
	public void DeleteInventory(@PathParam("ProductId")String ProductId) throws JSONException, UnknownHostException {
		
	
		MongoClient mongoClient = new MongoClient( "localhost" , 27017 );
	    
		MongoDatabase db = mongoClient.getDatabase("Paxshal");
        MongoCollection<Document> coll = db.getCollection("INVENTORY_LIST");         
          Document document = new Document();
          
          BasicDBObject query = new BasicDBObject();
          
          query.put("_id", ProductId);
         
          
         // document.remove(query);
         
         // coll.deleteOne(document);
         db.getCollection("INVENTORY_LIST").deleteOne(query);
         
          
       	        mongoClient.close();
        	        return;
        	
        	
        	
}
  	
	
	/**********Checkout Success**********/
	
	@Path("/Checkout/")
	@PUT
	@Produces("text/plain")
	public Response Checkout(String data) throws JSONException, UnknownHostException {
		
		//JSONObject partsData = new JSONObject(data);
	     //System.out.println("Client: "+ partsData.optString("_id") + "manufacturer " + partsData.optString("amount")+"time " + partsData.optString("checkoutTime"));
	      //System.out.println(partsData); 
        //BasicDBObject query = new BasicDBObject();
  
        MongoClient mongoClient = new MongoClient( "localhost" , 27017 );
	    
		MongoDatabase db = mongoClient.getDatabase("Paxshal");
    //    System.out.println("Connect to database successfully");
        MongoCollection<Document> coll = db.getCollection("CheckoutLog");
      //  System.out.println("Collection created successfully");
        
        Document document = new Document();
        
        document = Document.parse(data);
        /*document.put("_id",data.getString("name"));
        document.put("client_manufacturer",data.getString("manufacturer"));
        document.put("client_model",data.getString("model"));
        //document.put("client_version",data.getString("version"));
        //document.put("client_ip",data.getString("ip"));
        document.put("client_type",data.getString("type"));*/
        
        
        coll.insertOne(document);
       // coll.insertOne(partsData);
       
		
       // System.out.println("document created successfully");
        
        mongoClient.close();
		 return Response.status(200).entity("Payment Done...!!!! Thank you for shopping. Have a great Day!!!").build();	
   
}
	
	@Path("/get/{clientName}")
	@GET
	@Produces("text/html")
	public Response Getinfo(@PathParam("clientName")String clientId) throws JSONException, UnknownHostException {
		
		MongoClient mongoClient = new MongoClient( "localhost" , 27017 );
	    
		MongoDatabase db = mongoClient.getDatabase("Paxshal");
        
        MongoCursor<Document> cursor = db.getCollection("Device_List").find().iterator();
        
        while(cursor.hasNext())
        {
        	Document doc = cursor.next();
        	if(doc.getString("_id").equals(clientId))
        	{
        	//	System.out.println(doc.toJson());
        		mongoClient.close();
        	
        		return Response.status(200).entity("<html><head><body><br> <br>The data requested from the server is <br><br>"+doc.toJson()).build();
        	      
        		//return Response.status(200).entity(doc.toJson()).build();
        	}
        }
       
      
      
 		//return Response.status(200).entity("<html><head><body>your De-Registration Process has been completed with Server_USA. <br> <br>The data related to client is deleted from Server Resource Model. <br> <br> To go back to main menu:<a href="+"http://localhost:8080/Assignment2/Home.jsp"+">click here</a></body></head></html>").build();
        	return Response.status(200).entity("Client Not found in datbase").build();
	}
	
	
	/*KATHAN*/
	
	
	@Path("/getInventory/{clientName}")
	@GET
	@Produces("text/html")
	public Response ReadInventory(@PathParam("clientName")String client) throws JSONException, UnknownHostException {
		
		System.out.println("i am " + client);
		MongoClient mongoClient = new MongoClient( "localhost" , 27017 );
	    
		MongoDatabase db = mongoClient.getDatabase("Paxshal");
        
        MongoCursor<Document> cursor = db.getCollection("INVENTORY_LIST").find().iterator();
        
        while(cursor.hasNext())
        {
    		//System.out.println("i am " + client);

        	Document doc = cursor.next();
        	if(doc.getString("product_name").equals(client))
        	{
        	//	System.out.println(doc.toJson());
        		mongoClient.close();
        	
        		return Response.status(200).entity("<html><head><body><br> <br>The data requested from the server is <br><br>"+doc.toJson()).build();
        	      
        		//return Response.status(200).entity(doc.toJson()).build();
        	}
        }
       
      
      
 		//return Response.status(200).entity("<html><head><body>your De-Registration Process has been completed with Server_USA. <br> <br>The data related to client is deleted from Server Resource Model. <br> <br> To go back to main menu:<a href="+"http://localhost:8080/Assignment2/Home.jsp"+">click here</a></body></head></html>").build();
        	return Response.status(200).entity("Product Item Not found in datbase").build();
	}
	
	
	/**********Read ALL Inventory Products**********/
	
	@Path("/Read1/get/")
	@GET
	@Produces("text/html")
	//@Consumes("text/plain")
	public Response Read_All_Inventory(@PathParam("clientName")String client) throws JSONException, UnknownHostException {
		
		MongoClient mongoClient = new MongoClient( "localhost" , 27017 );
	    System.out.println(client);
		MongoDatabase db = mongoClient.getDatabase("Paxshal");
		System.out.println("Connect to database successfully");
    
        System.out.println("here: "+client);
        MongoCursor<Document> cursor = db.getCollection("INVENTORY_LIST").find().iterator();
    
        String str="";
    	  while(cursor.hasNext())
          {
          	
        //  	if(doc.getString("product_name").equals(client))
          //	{
    		  Document doc = cursor.next();
          	//	System.out.println(doc.toJson());
          		
          		 str+=doc.toJson()+"<br><br>";
          		
         // 	}
          }
    	  mongoClient.close();
    	  return Response.status(200).entity(str).build();
    	  
    	
	
	}	
	

	
/*	
	@Path("/Register/post")
	@POST
	@Produces("text/html")
	@Consumes({MediaType.APPLICATION_FORM_URLENCODED,
		MediaType.APPLICATION_JSON})
	public Response Register_Inventory(JSONObject data) throws JSONException, UnknownHostException {
		
		
		System.out.println("data at server: "+data);
		
		MongoClient mongoClient = new MongoClient( "localhost" , 27017 );
//Get database and collection    
		MongoDatabase db = mongoClient.getDatabase("Paxshal");
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
	    
		MongoDatabase db = mongoClient.getDatabase("Paxshal");
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
	
	@Path("/Delete/{Client_Id}")
	@DELETE
	@Produces("text/html")
	//@Consumes("text/plain")
	public Response Delete_Inventory(@PathParam("Client_Id")String delete_data) throws JSONException, UnknownHostException {
		
		System.out.println("data at server: "+delete_data);
		
		MongoClient mongoClient = new MongoClient( "localhost" , 27017 );
	    
		MongoDatabase db = mongoClient.getDatabase("Paxshal");
        
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
	
	*/
	
}
