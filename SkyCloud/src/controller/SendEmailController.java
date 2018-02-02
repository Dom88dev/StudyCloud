package controller;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class SendEmailController
 */
@WebServlet("/SendEmailController")
public class SendEmailController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public SendEmailController() {
        super();
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		request.setCharacterEncoding("UTF-8");
		
		response.setContentType("text/html;charset=UTF-8");
		response.setCharacterEncoding("UTF-8");
		System.out.println("접속 성공");
		
		String email = request.getParameter("email");
		System.out.println("email보내기 :" + email);
		
		// 난수 생성
		StringBuffer Num = new StringBuffer();
		int n=0;
		for(int i=0; i<6; i++) {
			n= (int)(Math.random()*10);
			Num.append(n);
		}
		String emailNum = Num.toString();
		
		System.out.println(emailNum);
		
		RequestDispatcher view = request.getRequestDispatcher("/register.jsp?emailNum="+emailNum);
		view.forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
		
	}

}





















