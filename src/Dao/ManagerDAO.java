package Dao;
import bean.Manager;
import utils.DBConnectionPool;

import java.sql.*;

public class ManagerDAO {
    Connection conn = null;
    Statement stmt = null;

    public int checkLogin(Manager loginForm) {
        int managerid = loginForm.getId();
        String managername = loginForm.getName();
        String password = loginForm.getPw();
        ResultSet rs = null;

        try {
            // 使用连接池获取连接
            conn = DBConnectionPool.getInstance().getConnection();
            stmt = conn.createStatement();
            String sql = "SELECT mid, name, pw, type FROM m_login";
            rs = stmt.executeQuery(sql);

            while (rs.next()) {
                int mid = rs.getInt("mid");
                String name = rs.getString("name");
                String pw = rs.getString("pw");
                String type = rs.getString("type");
                if (mid == managerid && name.equals(managername)) {
                    if (pw.equals(password)) {
                        if (type.equals("审核员")) {
                            return 4;
                        }
                        if (type.equals("管理员")) {
                            return 5;
                        }
                    }
                    return 3;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            // 确保资源被释放
            try {
                if (rs != null) {
                    rs.close();
                }
                if (stmt != null) {
                    stmt.close();
                }
                if (conn != null) {
                    conn.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        return 2;
    }
}
