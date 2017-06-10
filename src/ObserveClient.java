

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class ObserveClient
 */
@WebServlet("/ObserveClient")
public class ObserveClient extends HttpServlet {
	private static final long serialVersionUID = 1L;
    int observeNum = 0;   
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ObserveClient() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
	
	
	observeNum = 1;
	response.sendRedirect("Home.jsp");
	
	
	}

}
