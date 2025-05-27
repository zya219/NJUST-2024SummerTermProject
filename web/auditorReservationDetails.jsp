<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="bean.Reservation" %>

<%
    Reservation reservation = (Reservation) request.getAttribute("reservation");
    String currentDate = (String) request.getAttribute("currentDate");
%>

<!DOCTYPE html>
<html>
<head>
    <title>审核员 - 预约详情</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <style>
        body, html {
            margin: 0;
            padding: 0;
            height: 100%;
            width: 100%;
            font-family: Arial, sans-serif;
            background: url("image/background.png") no-repeat center center fixed;
            background-size: cover;
            color: white;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
        }
        .container {
            width: 90%;
            max-width: 800px;
            padding: 20px;
            border-radius: 10px;
            background-color: rgba(128, 0, 128, 0.5);
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
            display: flex;
            flex-direction: column;
            align-items: center;
            margin-top: 20px;
        }
        h2 {
            margin-top: 0;
            margin-bottom: 20px;
            text-align: center;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }
        table, th, td {
            border: 1px solid white;
        }
        th, td {
            padding: 10px;
            text-align: center;
        }
        th {
            background-color: rgba(255, 255, 255, 0.2);
            color: white;
        }
        td {
            background-color: rgba(255, 255, 255, 0.1);
        }
        .button-container {
            margin-top: 20px;
            display: flex;
            justify-content: center;
            gap: 10px;
            flex-wrap: wrap; /* 使按钮在小屏幕上换行 */
        }
        input[type="submit"], .back-button {
            padding: 10px 20px;
            border-radius: 5px;
            border: 1px solid white;
            background-color: rgba(255, 255, 255, 0.2);
            color: white;
            font-size: 16px;
            cursor: pointer;
            transition: background-color 0.3s, transform 0.3s, border-color 0.3s;
            text-decoration: none;
            display: inline-block;
            white-space: nowrap; /* 防止按钮换行 */
        }
        input[type="submit"]:hover, .back-button:hover {
            background-color: rgba(255, 255, 255, 0.3);
            transform: scale(1.05);
            border-color: rgba(255, 255, 255, 0.8);
        }
        @media (max-width: 768px) {
            .container {
                padding: 10px;
            }
            th, td {
                padding: 8px;
                font-size: 14px;
            }
            input[type="submit"], .back-button {
                padding: 8px 16px;
                font-size: 14px;
                margin: 5px 0; /* 增加按钮之间的间距 */
            }
        }
    </style>
</head>
<body>
<div class="container">
    <h2>预约详情</h2>
    <table>
        <tr>
            <th>预约ID</th>
            <td><%= reservation.getRid() %></td>
        </tr>
        <tr>
            <th>申请理由</th>
            <td><%= reservation.getReason() %></td>
        </tr>
        <tr>
            <th>访客ID</th>
            <td><%= reservation.getVid() %></td>
        </tr>
        <tr>
            <th>联系电话</th>
            <td><%= reservation.getTel() %></td>
        </tr>
        <tr>
            <th>申请时间</th>
            <td><%= reservation.getDate() %></td>
        </tr>
        <tr>
            <th>状态</th>
            <td><%= reservation.getStatus() %></td>
        </tr>
    </table>

    <div class="button-container">
        <%
            if (!"通过".equals(reservation.getStatus()) && !"拒绝".equals(reservation.getStatus())) {
        %>
        <form action="ReservationController" method="post">
            <input type="hidden" name="action" value="approveReservation">
            <input type="hidden" name="rid" value="<%= reservation.getRid() %>">
            <input type="hidden" name="date" value="<%= currentDate %>">
            <input type="submit" value="通过">
        </form>

        <form action="ReservationController" method="post">
            <input type="hidden" name="action" value="rejectReservation">
            <input type="hidden" name="rid" value="<%= reservation.getRid() %>">
            <input type="hidden" name="date" value="<%= currentDate %>">
            <input type="submit" value="拒绝">
        </form>
        <%
            }
        %>

        <form action="ReservationController" method="get">
            <input type="hidden" name="action" value="filterByDateAndStatus">
            <input type="hidden" name="date" value="<%= currentDate %>">
            <input type="submit" value="返回">
        </form>
    </div>
</div>
</body>
</html>
