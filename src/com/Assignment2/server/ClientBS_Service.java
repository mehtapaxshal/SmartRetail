package com.Assignment2.server;

import java.util.HashMap;
import java.util.Map;

import javax.ws.rs.Consumes;
import javax.ws.rs.GET;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;
import javax.ws.rs.Produces;
import javax.ws.rs.QueryParam;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;

import org.codehaus.jettison.json.JSONException;


@Path("/client/BootStrap")
public class ClientBS_Service {

	
	static Map<String, String> client_info = new HashMap<String, String>();
	
	
	@Path("/get/{cart}")
	@GET
	@Produces("text/html")
	@Consumes("text/plain")
	
	public Response Serve(@PathParam("cart") String cart) throws JSONException {
	
		System.out.println("In Server1\n");
		client_info.put("Cart_007","Server_USA");
		
	//	SendServerInfo();
		
		return Response.status(200).entity("<html><head><body>your BootStrap Process has been completed. <br> you are assigned to: "+client_info.get(cart)+".<br>For Registration: <a href="+"http://localhost:8080/Assignment2/Register.jsp"+">click here</a></body></head></html>").build();
	
	//	return Response.status(200).entity("hello").build();
		
	}

	
	
	@Path("/Server")
	@GET
	@Produces("text/html")
	@Consumes("text/plain")
	
	public Response ServerBS() throws JSONException {
	
		client_info.put("Cart_007","Server_USA");
		
		
		return Response.status(200).entity("<html><head><body>your BootStrap Process has been completed. <br> you are assigned to: "+client_info.get("Cart_007")+".<br>For Registration: <a href="+"http://localhost:8080/Assignment2/Register.jsp"+">click here</a></body></head></html>").build();
	
	//	return Response.status(200).entity("hello").build();
		
	}
	
	
}
