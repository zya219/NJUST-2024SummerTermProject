package Service;

import Dao.ReservationDAO;
import Dao.StatusDAO;
import bean.Reservation;
import bean.Status;
import java.util.List;

public class ReservationService {

    static StatusDAO statusDAO = new StatusDAO();
    private ReservationDAO reservationDAO = new ReservationDAO();

    public List<Reservation> getAllReservations() {
        return reservationDAO.getAllReservations();
    }

    public Reservation getReservationById(int id) {
        return reservationDAO.getReservationById(id);
    }

    public void addReservation(Reservation reservation) {
        reservationDAO.saveReservation(reservation);
    }

    public void changeV_status(Status oldstatus) {
        statusDAO.changeV_status(oldstatus);
    }

    public List<Status> getAllStatuses() {
        return statusDAO.getAllStatuses();
    }

    public List<Reservation> getReservationsByVid(String vid) {
        return reservationDAO.getReservationsByVid(vid);
    }

    public void deletePendingReservations(int rid) {
        reservationDAO.deletePendingReservations(rid);
    }

    public List<Reservation> getReservationsByDate(String date) {
        return reservationDAO.getReservationsByDate(date);
    }

    public void changeV_status(int rid, String status) {
        reservationDAO.updateReservationStatus(rid, status);
    }

    public List<Reservation> getReservationsByDateAndStatus(String date, String status) {
        return reservationDAO.getReservationsByDateAndStatus(date, status);
    }

}
