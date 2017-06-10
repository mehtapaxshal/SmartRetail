

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.codehaus.jettison.json.JSONException;
import org.codehaus.jettison.json.JSONObject;

import com.mysql.jdbc.PreparedStatement;
//import com.mysql.jdbc.ResultSet;
import com.sun.jersey.api.client.Client;
import com.sun.jersey.api.client.ClientResponse;
import com.sun.jersey.api.client.WebResource;

/**
 * Servlet implementation class Register
 */
@WebServlet("/Register")
public class Register extends HttpServlet {
	private static final long serialVersionUID = 1L;
    
	static String name,manufacturer,model,type;
	static String json;
	JSONObject Details = new JSONObject();

	Connection conn =null;
	Statement stmt = null;
	/**
     * @see HttpServlet#HttpServlet()
     */
    public Register() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		
		int bs_info = 0;
		
		try {
			Class.forName("com.mysql.jdbc.Driver");
			System.out.println("Connecting to database...");
		    conn = (Connection) DriverManager.getConnection("jdbc:mysql://localhost/Assignment2","root","root");
		
		    
		    PreparedStatement ps = (PreparedStatement) conn.prepareStatement("SELECT bs_info FROM SERVER_INFO");
			ResultSet rs = (ResultSet) ps.executeQuery();
			
			while(rs.next())
			{
				bs_info=rs.getInt("bs_info");
			}
		 
		   if(bs_info==1)
		   {
			   name = request.getParameter("Client_Name");		
				manufacturer = request.getParameter("Client_Manufacturer");		
				model = request.getParameter("Client_Model");		
			//	version = request.getParameter("Client_Software");		
				type = request.getParameter("Client_Type");		
			//	ip = request.getParameter("IP");
				try {
					toJson();
				} catch (JSONException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
				
				
				String receive_response = post_request(Details);
				//doGet(request, response);
				response.setContentType("text/html");
				PrintWriter out = response.getWriter();
				
			
				out.println(receive_response);
		   }else
		   {
			   System.out.println("Registration not possible");
		   }
		    
		    
		} catch (ClassNotFoundException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			System.out.println("Registration not possible without bootstrap");
			
			response.sendRedirect("Error.jsp");
			//e.printStackTrace();
		}
		
	
	}
	
	
	public String post_request(JSONObject Details){
		
		
		Client client = Client.create();
		System.out.println(" :status: 1");
		
    	WebResource webResource = client.resource("http://localhost:8080/Assignment2/rest/client/Register/post");
    	System.out.println(" :status: 2");
		
		ClientResponse response = webResource.accept("text/html").type("application/json").post(ClientResponse.class,Details);
		
		System.out.println(response + " :status:" + response.getStatus());
		
		if(response.getStatus()!=200)
		{
			throw new RuntimeException("Failed : HTTP error code : " + response.getStatus());
			
		}
		
		String receive = response.getEntity(String.class);
		System.out.println("Output from Server .... ");
		System.out.println(receive);
    	return receive;
    	
	}
	
	
	public void toJson() throws JSONException{
		
		ArrayList<String> Cart = new ArrayList<String>();
		
		
		Cart.add(name);
		Cart.add(manufacturer);
		Cart.add(model);
		//Cart.add(version);
		//Cart.add(ip);
		Cart.add(type);
		
		Details.put("name", Cart.get(0));
		Details.put("manufacturer", Cart.get(1));
		Details.put("model", Cart.get(2));
	//	Details.put("version", Cart.get(3));
	//	Details.put("ip", Cart.get(4));
		Details.put("type", Cart.get(3));
		
		//jsonArray.add(Details);
		
		//System.out.println(Details);
		//json = "{\"name\":" + "\""+Cart.get(0) + "\""+","+"\"manufacturer\":"+ "\""+Cart.get(1)+"\""+"}";

		
		
	}

}
