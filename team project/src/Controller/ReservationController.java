package Controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import Service.ReservationService;
import bean.Reservation;
import bean.Status;
import java.util.List;

public class ReservationController extends HttpServlet {
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
        ReservationService reservationService = new ReservationService();

        String action = request.getParameter("action");

        if ("submitApplication".equals(action)) {
            submitApplication(request, response, reservationService);
        } else if ("showOrderDetails".equals(action)) {
            showReservationDetails(request, response, reservationService);
        } else if ("withdrawReservation".equals(action)) {
            withdrawReservation(request, response, reservationService);
        } else if ("listReservationsByVid".equals(action)) {
            listReservationsByVid(request, response, reservationService);
        } else if ("filterByDate".equals(action)) {
            filterByDate(request, response, reservationService);
        } else if ("showAuditorOrderDetails".equals(action)) {
            showAuditorReservationDetails(request, response, reservationService);
        } else if ("approveReservation".equals(action)) {
            approveReservation(request, response, reservationService);
        } else if ("rejectReservation".equals(action)) {
            rejectReservation(request, response, reservationService);
        } else if ("filterByDateAndStatus".equals(action)) {
            filterByDateAndStatus(request, response, reservationService);
        } else if ("clearFilters".equals(action)) {
            clearFilters(request, response, reservationService);
        } else {
            Object Identity = session.getAttribute("identity");
            String identity = Identity != null ? Identity.toString() : "";
            if (identity.equals("0")) {
                listReservationsByVid(request, response, reservationService);
            } else if (identity.equals("1")) {
                listAllReservations(request, response, reservationService);
                request.getRequestDispatcher("./auditorHome.jsp").forward(request, response);
            } else if (identity.equals("2") || "changestatus".equals(action)) {
                if ("changestatus".equals(action)) {
                    String[] rows = request.getParameterValues("row");
                    for (String row : rows) {
                        Status oldStatus = new Status();
                        int oldRid = Integer.parseInt(row);
                        oldStatus.setRid(oldRid);
                        reservationService.changeV_status(oldStatus);
                    }
                }
                List<Status> statuses = reservationService.getAllStatuses();
                session.setAttribute("statuses", statuses);
                response.sendRedirect("./todayvisitor.jsp");
            }
        }
    }

    private void submitApplication(HttpServletRequest request, HttpServletResponse response, ReservationService reservationService) throws ServletException, IOException {
        String visitTime = request.getParameter("visitTime");
        String visitReason = request.getParameter("visitReason");
        String vid = request.getParameter("vid");
        String tel = request.getParameter("tel");

        if (visitTime != null && !visitTime.isEmpty() &&
                visitReason != null && !visitReason.isEmpty() &&
                vid != null && !vid.isEmpty() &&
                tel != null && !tel.isEmpty()) {
            Reservation newReservation = new Reservation();
            newReservation.setDate(visitTime);
            newReservation.setReason(visitReason);
            newReservation.setVid(vid);
            newReservation.setTel(tel);
            newReservation.setStatus("待审核"); // 设定默认状态

            reservationService.addReservation(newReservation);

            request.setAttribute("message", "申请提交成功");

            // 刷新预订列表
            listReservationsByVid(request, response, reservationService);
        } else {
            request.setAttribute("error", "所有字段都是必填项");
            request.getRequestDispatcher("./NewReservation.jsp").forward(request, response);
        }
    }

    private void showReservationDetails(HttpServletRequest request, HttpServletResponse response, ReservationService reservationService) throws ServletException, IOException {
        String rId = request.getParameter("rId");
        Reservation reservation = reservationService.getReservationById(Integer.parseInt(rId));
        request.setAttribute("reservation", reservation);
        request.getRequestDispatcher("/reservationDetails.jsp").forward(request, response);
    }

    private void withdrawReservation(HttpServletRequest request, HttpServletResponse response, ReservationService reservationService) throws ServletException, IOException {
        int rid = Integer.parseInt(request.getParameter("rid"));
        reservationService.deletePendingReservations(rid);
        // 刷新预订列表
        listReservationsByVid(request, response, reservationService);
    }

    private void listReservationsByVid(HttpServletRequest request, HttpServletResponse response, ReservationService reservationService) throws ServletException, IOException {
        HttpSession session = request.getSession();
        String vid = (String) session.getAttribute("vid");
        List<Reservation> userReservations = reservationService.getReservationsByVid(vid);
        session.setAttribute("Reservations", userReservations);
        request.getRequestDispatcher("./allReservation.jsp").forward(request, response);
    }

    private void listAllReservations(HttpServletRequest request, HttpServletResponse response, ReservationService reservationService) throws ServletException, IOException {
        List<Reservation> allReservations = reservationService.getAllReservations();
        request.setAttribute("allReservations", allReservations);
    }

    private void filterByDate(HttpServletRequest request, HttpServletResponse response, ReservationService reservationService) throws ServletException, IOException {
        String date = request.getParameter("date");
        List<Reservation> filteredReservations;
        if (date == null || date.isEmpty()) {
            filteredReservations = reservationService.getAllReservations();
        } else {
            filteredReservations = reservationService.getReservationsByDate(date);
        }
        request.setAttribute("allReservations", filteredReservations);
        request.setAttribute("currentDate", date);
        request.getRequestDispatcher("./auditorHome.jsp").forward(request, response);
    }


    private void showAuditorReservationDetails(HttpServletRequest request, HttpServletResponse response, ReservationService reservationService) throws ServletException, IOException {
        String rId = request.getParameter("rId");
        String date = request.getParameter("date");
        Reservation reservation = reservationService.getReservationById(Integer.parseInt(rId));
        request.setAttribute("reservation", reservation);
        request.setAttribute("currentDate", date);
        request.getRequestDispatcher("/auditorReservationDetails.jsp").forward(request, response);
    }


    private void approveReservation(HttpServletRequest request, HttpServletResponse response, ReservationService reservationService) throws ServletException, IOException {
        int rid = Integer.parseInt(request.getParameter("rid"));
        String date = request.getParameter("date");

        Reservation reservation = reservationService.getReservationById(rid);
        if (!"通过".equals(reservation.getStatus()) && !"拒绝".equals(reservation.getStatus())) {
            reservationService.changeV_status(rid, "通过");
        }

        filterByDateAndStatus(request, response, reservationService);
    }

    private void rejectReservation(HttpServletRequest request, HttpServletResponse response, ReservationService reservationService) throws ServletException, IOException {
        int rid = Integer.parseInt(request.getParameter("rid"));
        String date = request.getParameter("date");

        Reservation reservation = reservationService.getReservationById(rid);
        if (!"通过".equals(reservation.getStatus()) && !"拒绝".equals(reservation.getStatus())) {
            reservationService.changeV_status(rid, "拒绝");
        }

        filterByDateAndStatus(request, response, reservationService);
    }

    private void filterByDateAndStatus(HttpServletRequest request, HttpServletResponse response, ReservationService reservationService) throws ServletException, IOException {
        String date = request.getParameter("date");
        String status = request.getParameter("status");

        List<Reservation> filteredReservations;
        if ((date == null || date.isEmpty()) && (status == null || status.isEmpty())) {
            filteredReservations = reservationService.getAllReservations();
        } else {
            filteredReservations = reservationService.getReservationsByDateAndStatus(date, status);
        }

        request.setAttribute("allReservations", filteredReservations);
        request.setAttribute("currentDate", date);
        request.setAttribute("currentStatus", status);
        request.getRequestDispatcher("./auditorHome.jsp").forward(request, response);
    }

    private void clearFilters(HttpServletRequest request, HttpServletResponse response, ReservationService reservationService) throws ServletException, IOException {
        List<Reservation> allReservations = reservationService.getAllReservations();
        request.setAttribute("allReservations", allReservations);
        request.setAttribute("currentDate", "");
        request.setAttribute("currentStatus", "");
        request.getRequestDispatcher("./auditorHome.jsp").forward(request, response);
    }

}
