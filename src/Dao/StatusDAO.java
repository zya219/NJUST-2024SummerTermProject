package Dao;
import bean.Status;
import utils.DBConnectionPool;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class StatusDAO {
    Connection conn = null;
    Statement stmt = null;

    public List<Status> getAllStatuses() {
        List<Status> statuses = new ArrayList<>();
        try {
            conn = DBConnectionPool.getInstance().getConnection();
            stmt = conn.createStatement();
            String sql = "SELECT * FROM v_status WHERE status='未入校' AND rid IN (SELECT rid FROM reservation WHERE date = DATE_FORMAT(CURDATE(), '%Y-%m-%d'))";
            ResultSet rs = stmt.executeQuery(sql);
            while (rs.next()) {
                Status status = new Status(
                        rs.getInt("rId"),
                        rs.getString("status"),
                        null
                );
                statuses.add(status);
            }
            String sql1 = "SELECT * FROM v_status WHERE status='已入校' AND rid IN (SELECT rid FROM reservation WHERE date = DATE_FORMAT(CURDATE(), '%Y-%m-%d'))";
            ResultSet rs1 = stmt.executeQuery(sql1);
            while (rs1.next()) {
                Status status = new Status(
                        rs1.getInt("rId"),
                        rs1.getString("status"),
                        rs1.getString("etime")
                );
                statuses.add(status);
            }
        } catch (Exception e) {
            e.printStackTrace();
            System.out.println(e.getMessage());
        } finally {
            // 确保资源被释放
            if (stmt != null) {
                try {
                    stmt.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
            if (conn != null) {
                try {
                    conn.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        }
        return statuses;
    }

    public int changeV_status(Status oldStatus) {
        int oldrid = oldStatus.getRid();
        PreparedStatement prep = null;
        try {
            conn = DBConnectionPool.getInstance().getConnection();
            String sql = "UPDATE v_status SET etime=CASE WHEN status='未入校' THEN NOW() ELSE etime END, status='已入校' WHERE rid=? AND status='未入校'";
            prep = conn.prepareStatement(sql);
            prep.setInt(1, oldrid);
            prep.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            // 确保资源被释放
            if (prep != null) {
                try {
                    prep.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
            if (conn != null) {
                try {
                    conn.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        }
        return 0;
    }

}
