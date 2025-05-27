package Dao;

import bean.Reservation;
import utils.DBConnectionPool;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ReservationDAO {
    public List<Reservation> getAllReservations() {
        List<Reservation> reservations = new ArrayList<>();
        Connection connection = null;
        Statement statement = null;
        ResultSet resultSet = null;

        try {
            // 使用连接池获取连接
            connection = DBConnectionPool.getInstance().getConnection();

            // 执行SQL查询
            String sql = "SELECT * FROM reservation";
            statement = connection.createStatement();
            resultSet = statement.executeQuery(sql);

            while (resultSet.next()) {
                int rid = resultSet.getInt("rid");
                String reason = resultSet.getString("reason");
                String vid = resultSet.getString("vid");
                String tel = resultSet.getString("tel");
                String date = resultSet.getString("date");
                String status = resultSet.getString("status");

                Reservation reservation = new Reservation(rid, reason, vid, tel, date, status);
                reservations.add(reservation);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            // 确保资源被释放
            try {
                if (resultSet != null) {
                    resultSet.close();
                }
                if (statement != null) {
                    statement.close();
                }
                if (connection != null) {
                    connection.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        return reservations;
    }

    public Reservation getReservationById(int id) {
        Reservation reservation = null;
        Connection connection = null;
        PreparedStatement statement = null;
        ResultSet resultSet = null;

        try {
            // 使用连接池获取连接
            connection = DBConnectionPool.getInstance().getConnection();

            // 执行SQL查询
            String sql = "SELECT * FROM reservation WHERE rid = ?";
            statement = connection.prepareStatement(sql);
            statement.setInt(1, id);
            resultSet = statement.executeQuery();

            if (resultSet.next()) {
                int rid = resultSet.getInt("rid");
                String reason = resultSet.getString("reason");
                String vid = resultSet.getString("vid");
                String tel = resultSet.getString("tel");
                String date = resultSet.getString("date");
                String status = resultSet.getString("status");

                reservation = new Reservation(rid, reason, vid, tel, date, status);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            // 确保资源被释放
            try {
                if (resultSet != null) {
                    resultSet.close();
                }
                if (statement != null) {
                    statement.close();
                }
                if (connection != null) {
                    connection.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        return reservation;
    }

    public void saveReservation(Reservation reservation) {
        Connection connection = null;
        PreparedStatement statement = null;

        try {
            // 使用连接池获取连接
            connection = DBConnectionPool.getInstance().getConnection();

            // 执行SQL插入
            String sql = "INSERT INTO reservation (reason, vid, tel, date, status) VALUES (?, ?, ?, ?, ?)";
            statement = connection.prepareStatement(sql);
            statement.setString(1, reservation.getReason());
            statement.setString(2, reservation.getVid());
            statement.setString(3, reservation.getTel());
            statement.setString(4, reservation.getDate());
            statement.setString(5, reservation.getStatus());
            statement.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            // 确保资源被释放
            try {
                if (statement != null) {
                    statement.close();
                }
                if (connection != null) {
                    connection.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }

    public List<Reservation> getReservationsByVid(String vid) {
        List<Reservation> reservations = new ArrayList<>();
        Connection connection = null;
        PreparedStatement statement = null;
        ResultSet resultSet = null;

        try {
            // 使用连接池获取连接
            connection = DBConnectionPool.getInstance().getConnection();

            // 执行SQL查询
            String sql = "SELECT * FROM reservation WHERE vid = ?";
            statement = connection.prepareStatement(sql);
            statement.setString(1, vid);
            resultSet = statement.executeQuery();

            while (resultSet.next()) {
                int rid = resultSet.getInt("rid");
                String reason = resultSet.getString("reason");
                String tel = resultSet.getString("tel");
                String date = resultSet.getString("date");
                String status = resultSet.getString("status");

                Reservation reservation = new Reservation(rid, reason, vid, tel, date, status);
                reservations.add(reservation);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            // 确保资源被释放
            try {
                if (resultSet != null) {
                    resultSet.close();
                }
                if (statement != null) {
                    statement.close();
                }
                if (connection != null) {
                    connection.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        return reservations;
    }

    public void deletePendingReservations(int rid) {
        Connection connection = null;
        PreparedStatement statement = null;

        try {
            // 使用连接池获取连接
            connection = DBConnectionPool.getInstance().getConnection();

            // 执行SQL删除
            String sql = "DELETE FROM reservation WHERE rid = ? AND status = '待审核'";
            statement = connection.prepareStatement(sql);
            statement.setInt(1, rid);
            statement.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            // 确保资源被释放
            try {
                if (statement != null) {
                    statement.close();
                }
                if (connection != null) {
                    connection.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }

    public List<Reservation> getReservationsByDate(String date) {
        List<Reservation> reservations = new ArrayList<>();
        Connection connection = null;
        PreparedStatement statement = null;
        ResultSet resultSet = null;

        try {
            // 使用连接池获取连接
            connection = DBConnectionPool.getInstance().getConnection();

            // 执行SQL查询
            String sql = "SELECT * FROM reservation WHERE date = ?";
            statement = connection.prepareStatement(sql);
            statement.setString(1, date);
            resultSet = statement.executeQuery();

            while (resultSet.next()) {
                int rid = resultSet.getInt("rid");
                String reason = resultSet.getString("reason");
                String vid = resultSet.getString("vid");
                String tel = resultSet.getString("tel");
                String dateResult = resultSet.getString("date");
                String status = resultSet.getString("status");

                Reservation reservation = new Reservation(rid, reason, vid, tel, dateResult, status);
                reservations.add(reservation);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            // 确保资源被释放
            try {
                if (resultSet != null) {
                    resultSet.close();
                }
                if (statement != null) {
                    statement.close();
                }
                if (connection != null) {
                    connection.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        return reservations;
    }

    public void updateReservationStatus(int rid, String status) {
        Connection connection = null;
        PreparedStatement statement = null;
        PreparedStatement insertStatement = null;

        try {
            // 使用连接池获取连接
            connection = DBConnectionPool.getInstance().getConnection();

            // 更新 reservation 表中的状态
            String sql = "UPDATE reservation SET status = ? WHERE rid = ?";
            statement = connection.prepareStatement(sql);
            statement.setString(1, status);
            statement.setInt(2, rid);
            int rowsUpdated = statement.executeUpdate();

            // 检查是否成功更新状态
            if (rowsUpdated > 0 && "通过".equals(status)) {
                // 向 v_status 表插入一条新记录
                String insertSql = "INSERT INTO v_status (rid, status, etime) VALUES (?, ?, ?)";
                insertStatement = connection.prepareStatement(insertSql);
                insertStatement.setInt(1, rid);
                insertStatement.setString(2, "未入校");
                insertStatement.setTimestamp(3, null); // 这里可以设置为 null 或者 new Timestamp(System.currentTimeMillis())
                insertStatement.executeUpdate();
            }
        } catch (SQLException e) {
            e.printStackTrace();
            // 添加日志记录
            System.err.println("Error updating reservation status: " + e.getMessage());
        } finally {
            // 确保资源被释放
            try {
                if (insertStatement != null) {
                    insertStatement.close();
                }
                if (statement != null) {
                    statement.close();
                }
                if (connection != null) {
                    connection.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }

    public List<Reservation> getReservationsByDateAndStatus(String date, String status) {
        List<Reservation> reservations = new ArrayList<>();
        Connection connection = null;
        PreparedStatement statement = null;
        ResultSet resultSet = null;

        try {
            // 使用连接池获取连接
            connection = DBConnectionPool.getInstance().getConnection();

            StringBuilder sql = new StringBuilder("SELECT * FROM reservation WHERE 1=1");

            if (date != null && !date.isEmpty()) {
                sql.append(" AND date = ?");
            }
            if (status != null && !status.isEmpty()) {
                sql.append(" AND status = ?");
            }

            statement = connection.prepareStatement(sql.toString());

            int paramIndex = 1;
            if (date != null && !date.isEmpty()) {
                statement.setString(paramIndex++, date);
            }
            if (status != null && !status.isEmpty()) {
                statement.setString(paramIndex, status);
            }

            resultSet = statement.executeQuery();

            while (resultSet.next()) {
                int rid = resultSet.getInt("rid");
                String reason = resultSet.getString("reason");
                String vid = resultSet.getString("vid");
                String tel = resultSet.getString("tel");
                String dateResult = resultSet.getString("date");
                String statusResult = resultSet.getString("status");

                Reservation reservation = new Reservation(rid, reason, vid, tel, dateResult, statusResult);
                reservations.add(reservation);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            // 确保资源被释放
            try {
                if (resultSet != null) {
                    resultSet.close();
                }
                if (statement != null) {
                    statement.close();
                }
                if (connection != null) {
                    connection.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }

        return reservations;
    }
}
