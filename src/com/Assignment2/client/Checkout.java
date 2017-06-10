package com.Assignment2.client;

import java.io.File;
import java.io.IOException;
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
import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.parsers.ParserConfigurationException;

import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;
import org.xml.sax.SAXException;

import com.mysql.jdbc.PreparedStatement;

/**
 * Servlet implementation class Checkout
 */
@WebServlet("/Checkout")
public class Checkout extends HttpServlet {
	private static final long serialVersionUID = 1L;
    String selection;
    float amount = 0;  
    Connection conn =null;
	Statement stmt = null;
    ResultSet rs = null;
	
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Checkout() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		
		selection = request.getParameter("isCart");
		//System.out.println("Cart selected is : "+selection);

		File fXmlFile = new File("C:/Users/paxshal/workspace/Assignment2/ClientSimulate.xml");
		DocumentBuilderFactory dbFactory = DocumentBuilderFactory.newInstance();
		DocumentBuilder dBuilder;
		try {
			
			Class.forName("com.mysql.jdbc.Driver");
			//System.out.println("Connecting to database...");
		    conn = (Connection) DriverManager.getConnection("jdbc:mysql://localhost/Assignment2","root","root");
			
		    stmt = conn.createStatement();
		    
		    String sql = "use Assignment2";
		    
		    stmt.execute(sql);
		    
		    PreparedStatement pst = (PreparedStatement) conn.prepareStatement("Select * from checkout_item");
		    
		    ResultSet rs = pst.executeQuery();
		    
		    if(!rs.next())
		    {
		  
			dBuilder = dbFactory.newDocumentBuilder();
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
				
				}
		    }
		    	
		    	String sql_select = "SELECT * FROM CHECKOUT_ITEM";
			    rs = stmt.executeQuery(sql_select);
			    Result result = ResultSupport.toResult(rs);
			    request.setAttribute("result", result);
			    int quantity = 0;
			    rs.beforeFirst();
			 //System.out.println("quantity:"+rs.getInt("quantity"));
				 while(rs.next())
			    {
					quantity = quantity + (rs.getInt("quantity"));
			    	amount = amount + (rs.getInt("quantity") * rs.getFloat("price"));
			    }
				 
				PreparedStatement ps = (PreparedStatement) conn.prepareStatement("select * from cart_pay");
				ResultSet r = ps.executeQuery();  
			    if(r.next())
			    {
					PreparedStatement p = (PreparedStatement) conn.prepareStatement("update cart_pay set quantity = ? , price = ?");
					p.setInt(1, quantity);
					p.setFloat(2, amount);
					p.executeUpdate();
			    }
				request.setAttribute("amount", amount);
			    
			    String s = "SELECT discount FROM cart_pay";
			    ResultSet rst = stmt.executeQuery(s);
			    int discount=0;
			    if(rst.next())
			    {
			    	discount = Integer.parseInt(rst.getString(1));
			    }
			    String discountString = "<html><head><body>Congratulations. "+ discount +"% discount is given to you.</body></head></html>";
			    request.setAttribute("discount", discountString);
			    float deducted = amount-(amount*discount/100);
			    String finalPrice = "<html><head><body>Final amount to be paid is $"+ deducted +"</body></head></html>";
			    request.setAttribute("deducted", deducted);
			    request.setAttribute("finalPrice", finalPrice);
			    amount = 0 ;
			    
			    RequestDispatcher rd = request.getRequestDispatcher("/ClientCheckout.jsp");
			    rd.forward(request, response);
			    
			
		} catch (ParserConfigurationException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		} catch (SAXException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		
	
	//	response.sendRedirect("ClientCheckout.jsp");
		//response.getWriter().append("Served at: ").append(request.getContextPath());
	}

}
