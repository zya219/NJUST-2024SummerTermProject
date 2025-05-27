package Controller;

import Service.LoginService;
import bean.Manager;
import bean.Visitor;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

public class LoginController extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        handleRequest(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        handleRequest(request, response);
    }

    private void handleRequest(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("UTF-8");
        HttpSession session = request.getSession();
        String action = request.getParameter("action");

        if ("visitorlogin".equals(action)) {
            String visitorname = request.getParameter("visitorname");
            String vid = request.getParameter("visitorid");
            Visitor loginForm = new Visitor(visitorname, vid);
            LoginService service = new LoginService();
            int errorCode = service.checkvLogin(loginForm);

            if (errorCode != 0) {
                request.setAttribute("errorCode", errorCode);
                request.getRequestDispatcher("./visitorlogin.jsp").forward(request, response);
            } else {
                session.setAttribute("identity", 0);   // 访客
                session.setAttribute("vid", vid); // 确保vid正确设置到session
                response.sendRedirect("ReservationController?action=listReservationsByVid");
            }
        }

        if ("managerlogin".equals(action)) {
            String managername = request.getParameter("managername");
            String mid = request.getParameter("managerid");
            int managerid = Integer.parseInt(mid);
            String password = request.getParameter("password");
            Manager loginForm = new Manager(managerid, managername, password, null);
            LoginService service = new LoginService();
            int errorCode = service.checkmLogin(loginForm);

            if (errorCode < 4) {
                request.setAttribute("errorCode", errorCode);
                request.getRequestDispatcher("./managerlogin.jsp").forward(request, response);
            } else {
                if (errorCode == 4) { // 审核员
                    session.setAttribute("identity", 1);
                    ReservationController reservationController = new ReservationController();
                    reservationController.doGet(request, response);
                }
                if (errorCode == 5) { // 管理员
                    session.setAttribute("loginForm", loginForm);
                    session.setAttribute("identity", 2);
                    ReservationController reservationController = new ReservationController();
                    reservationController.doGet(request, response);
                }
            }
        }
    }
}
