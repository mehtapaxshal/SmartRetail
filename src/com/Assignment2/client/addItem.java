package com.Assignment2.client;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.jsp.jstl.sql.Result;
import javax.servlet.jsp.jstl.sql.ResultSupport;
import javax.xml.parsers.ParserConfigurationException;

import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;
import org.xml.sax.SAXException;

import com.mysql.jdbc.PreparedStatement;

/**
 * Servlet implementation class addItem
 */
@WebServlet("/addItem")
public class addItem extends HttpServlet {
	private static final long serialVersionUID = 1L;
	Connection conn =null;
	Statement stmt = null;
    ResultSet rs = null;
	   
    /**
     * @see HttpServlet#HttpServlet()
     */
    public addItem() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		//response.getWriter().append("Served at: ").append(request.getContextPath());
		try{
			
			Class.forName("com.mysql.jdbc.Driver");
			//System.out.println("Connecting to database...");
		    conn = (Connection) DriverManager.getConnection("jdbc:mysql://localhost/Assignment2","root","root");
			
		    stmt = conn.createStatement();
		    
		    String sql = "use Assignment2";
		    
		    stmt.execute(sql);
		    
		    PreparedStatement pst = (PreparedStatement) conn.prepareStatement("Select * from checkout_item");
		    
		    ResultSet rs = pst.executeQuery();
		    
		  while(rs.next())
		  {
			  
			  if(rs.getString(1).equals(request.getParameter("item")))
			  {
				  PreparedStatement ps = (PreparedStatement) conn.prepareStatement("update checkout_item set quantity = ? where item=?");
				  int result = Integer.parseInt((request.getParameter("quantity")))+rs.getInt("quantity");
				  ps.setInt(1,result);  
				  ps.setString(2, rs.getString(1));
				  ps.executeUpdate();
				  RequestDispatcher rd = request.getRequestDispatcher("Checkout");
				  rd.forward(request, response);
				  return;
			  }
			  
		  }
			/*dBuilder = dbFactory.newDocumentBuilder();
			Document doc = dBuilder.parse(fXmlFile);
			
			doc.getDocumentElement().normalize();

		//	System.out.println("Root element :" + doc.getDocumentElement().getNodeName());
			NodeList nList = doc.getElementsByTagName("store");
			for (int temp = 0; temp < nList.getLength(); temp++) {

				Node nNode = nList.item(temp);
						
			//	System.out.println("\nCurrent Element :" + nNode.getNodeName());
						
				if (nNode.getNodeType() == Node.ELEMENT_NODE) {

					Element eElement = (Element) nNode;

			
					  PreparedStatement ps = (PreparedStatement) conn.prepareStatement("INSERT INTO CHECKOUT_ITEM VALUES (?,?,?,?)");
					  ps.setString(1, eElement.getAttribute("item"));
					  ps.setString(2, eElement.getElementsByTagName("quantity").item(0).getTextContent());
					  ps.setString(3, eElement.getElementsByTagName("price").item(0).getTextContent());
					  ps.setString(4, eElement.getElementsByTagName("type").item(0).getTextContent());
					  
					  ps.execute();
					  
				}
				
				}*/
		    	
		    	PreparedStatement ps = (PreparedStatement) conn.prepareStatement("INSERT INTO CHECKOUT_ITEM VALUES (?,?,?,?)");
				ps.setString(1,request.getParameter("item"));  
				ps.setString(2,request.getParameter("quantity"));  
				ps.setString(3,request.getParameter("price"));  
				ps.setString(4,request.getParameter("type"));  
		    	ps.execute();
		    
		    	
		    	/*String sql_select = "SELECT * FROM CHECKOUT_ITEM";
			    rs = stmt.executeQuery(sql_select);
			    Result result = ResultSupport.toResult(rs);
			    request.setAttribute("result", result);
				 
			    rs.beforeFirst();
			 //System.out.println("quantity:"+rs.getInt("quantity"));
				 while(rs.next())
			    {
			    	amount = amount + (rs.getInt("quantity") * rs.getFloat("price"));
			    }
			    
			    request.setAttribute("amount", "$" + amount);
			    amount = 0 ;
			    RequestDispatcher rd = request.getRequestDispatcher("/ClientCheckout.jsp");
			    rd.forward(request, response);
			    */
		    
		    RequestDispatcher rd = request.getRequestDispatcher("Checkout");
		    rd.forward(request, response);
		
			
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	
	
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		//doGet(request, response);	
	
		String selection;
		int quantity;
		selection = (String) request.getParameter("itemList");
		quantity = Integer.parseInt(request.getParameter("quantity"));
		//System.out.println(quantity);
		
		try{
			
			Class.forName("com.mysql.jdbc.Driver");
			//System.out.println("Connecting to database...");
		    conn = (Connection) DriverManager.getConnection("jdbc:mysql://localhost/Assignment2","root","root");
			
		    stmt = conn.createStatement();
		    
		    String sql = "use Assignment2";
		    
		    stmt.execute(sql);
		    
		    PreparedStatement pst = (PreparedStatement) conn.prepareStatement("Select * from checkout_item");
		    
		    ResultSet rs = pst.executeQuery();
		    
		    while(rs.next())
		    {
		    
		    	if(selection.equals(rs.getString(1)))
		    	{
		    		
		    		
		    		if(quantity==1 && rs.getInt(2)==1)
		    		{
		    		PreparedStatement ps = (PreparedStatement) conn.prepareStatement("delete from checkout_item where item=?");
				    ps.setString(1, selection);
				    ps.execute();
				    response.sendRedirect("Checkout");
	    			
		    		}else
		    		{
		    			if(quantity<=rs.getInt(2))
		    			{
		    			int updated = rs.getInt(2)-quantity;
		    			PreparedStatement ps = (PreparedStatement) conn.prepareStatement("update checkout_item set quantity = ? where item=?");
					    ps.setInt(1, updated);
		    			ps.setString(2, selection);
		    			ps.execute();
		    			response.sendRedirect("Checkout");
		    			}
		    			else if(quantity > rs.getInt(2))
		    			{
		    		//		request.setAttribute("Error", "Entered quantity is not valid.");
		    			//	RequestDispatcher rd = request.getRequestDispatcher("Checkout");
		    			  //  rd.forward(request, response);
		    				PrintWriter out = response.getWriter();
		    				out.println("<script type=\"text/javascript\">");
		    				   out.println("alert('Quantity invalid');");
		    				   out.println("location='Checkout';");
		    				   out.println("</script>");//response.sendRedirect("Checkout");
			    			  
		    			}
		    		}
		    	}
		    	
		    	
		    }
		    /*<%! String s1 = " ";%>
		    <% s1 = (String) request.getAttribute("Error"); %>*/

		   
} catch (ClassNotFoundException e) {
	// TODO Auto-generated catch block
	e.printStackTrace();
} catch (SQLException e) {
	// TODO Auto-generated catch block
	e.printStackTrace();
}


}

}
