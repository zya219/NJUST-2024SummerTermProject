package Dao;

import bean.Visitor;
import utils.DBConnectionPool;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class VisitorDAO {
    Connection conn = null;
    Statement stmt = null;

    public int checkLogin(Visitor loginForm) {
        String visitorname = loginForm.getVisitorname();
        String vid = loginForm.getId();

        try {
            // 使用连接池获取连接
            conn = DBConnectionPool.getInstance().getConnection();

            stmt = conn.createStatement();
            String sql = "SELECT id, name FROM v_login";
            ResultSet rs = stmt.executeQuery(sql);

            while (rs.next()) {
                String id = rs.getString("id");
                String name = rs.getString("name");

                if (id.equals(vid) && name.equals(visitorname)) {
                    return 0;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            System.err.println("SQLState: " + e.getSQLState());
            System.err.println("Error Code: " + e.getErrorCode());
            System.err.println("Message: " + e.getMessage());
        } catch (Exception e) {
            e.printStackTrace();
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
        return 1;
    }
}
