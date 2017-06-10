

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.Statement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.mysql.jdbc.PreparedStatement;

/**
 * Servlet implementation class FactoryBS
 */
@WebServlet("/FactoryBS")
public class FactoryBS extends HttpServlet {
	private static final long serialVersionUID = 1L;
    
	Connection conn =null;
	Statement stmt = null;
	
    /**
     * @see HttpServlet#HttpServlet()
     */
    public FactoryBS() {
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
		//doGet(request, response);
		

		try {
			Class.forName("com.mysql.jdbc.Driver");
			System.out.println("Connecting to database...");
		    conn = (Connection) DriverManager.getConnection("jdbc:mysql://localhost/Assignment2","root","root");
			
		    System.out.println("Creating statement...");
		    stmt = conn.createStatement();
		  //  String sql = "CREATE TABLE SERVER_INFO (client_id VARCHAR(255) not NULL, server_info VARCHAR(255), bs_info INTEGER)";
		    
		   // stmt.execute(sql);
		    PreparedStatement ps = (PreparedStatement) conn.prepareStatement("INSERT INTO SERVER_INFO VALUES ('Cart_007','Server_USA',1)");
		 
		    //ResultSet rs=(ResultSet) ps.executeQuery();
		   // stmt.executeUpdate(ps);
		    ps.execute();
		    
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		
		response.sendRedirect("Success.jsp");
	}

}
