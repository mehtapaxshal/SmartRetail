

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.Statement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

//import com.mysql.jdbc.Connection;
import com.mysql.jdbc.PreparedStatement;
import com.sun.jersey.api.client.Client;
import com.sun.jersey.api.client.ClientResponse;
import com.sun.jersey.api.client.WebResource;

/**
 * Servlet implementation class SendReqBS
 */
@WebServlet("/SendReqBS")
public class SendReqBS extends HttpServlet {
	private static final long serialVersionUID = 1L;
    
	String client_name;
	
	
	Connection conn =null;
	Statement stmt = null;
	
	
    /**
     * @see HttpServlet#HttpServlet()
     */
    public SendReqBS() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
    
    
    public String ReceiveBS(){
    	
     	Client client = Client.create();
    	
    	WebResource webResource = client.resource("http://localhost:8080/Assignment2/rest/client/BootStrap/get/"+client_name);
		
		ClientResponse response = webResource.get(ClientResponse.class);
		
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
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		
		client_name = request.getParameter("ClientBSinfo");
		
		
		String receive = ReceiveBS();
		
		response.setContentType("text/html");
		PrintWriter out = response.getWriter();
		
	
		out.println(receive);
		
		
		try {
			Class.forName("com.mysql.jdbc.Driver");
			System.out.println("Connecting to database...");
		    conn = (Connection) DriverManager.getConnection("jdbc:mysql://localhost/Assignment2","root","root");
			
		    System.out.println("Creating statement...");
		    stmt = conn.createStatement();
//		    String sql = "CREATE TABLE SERVER_INFO (client_id VARCHAR(255) not NULL, server_info VARCHAR(255), bs_info INTEGER)";
		    
	//	    stmt.execute(sql);
		    PreparedStatement ps = (PreparedStatement) conn.prepareStatement("INSERT INTO SERVER_INFO VALUES ('Cart_007','Server_USA',1)");
			  
		   // ps.setString(1, client_name);
		    //ResultSet rs=(ResultSet) ps.executeQuery();
		   // stmt.executeUpdate(ps);
		    ps.executeUpdate();
		    
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		
		//response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
