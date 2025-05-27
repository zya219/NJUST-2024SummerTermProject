<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="bean.Reservation" %>
<%@ page import="java.util.List" %>

<!DOCTYPE html>
<html>
<head>
    <title>访客主页</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"> <!-- 添加viewport元标签以支持响应式设计 -->
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
            justify-content: space-between;
        }
        .header, .table-section {
            width: 90%; /* 调整色块宽度到页面的90% */
            max-width: 1200px;
            padding: 20px;
            border-radius: 10px;
            background-color: rgba(128, 0, 128, 0.5); /* 半透明紫色背景 */
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2); /* 阴影效果 */
            margin: 20px 0;
            display: flex;
            align-items: center;
        }
        .header {
            flex-direction: row; /* 水平排列 */
            justify-content: space-between;
        }
        .header h2 {
            margin: 0;
        }
        .header .button-container {
            display: flex;
            justify-content: center;
        }
        .header .button-container form {
            margin: 0;
        }
        .header .button-container input[type="submit"] {
            padding: 10px 20px;
            border-radius: 5px;
            border: 1px solid white; /* 添加边框 */
            background-color: rgba(255, 255, 255, 0.2); /* 按钮背景颜色 */
            color: white; /* 按钮文字颜色 */
            font-size: 16px;
            cursor: pointer;
            transition: background-color 0.3s, transform 0.3s, border-color 0.3s; /* 过渡动画 */
        }
        .header .button-container input[type="submit"]:hover {
            background-color: rgba(255, 255, 255, 0.3); /* 鼠标悬停时背景颜色变化 */
            transform: scale(1.05); /* 放大效果 */
            border-color: rgba(255, 255, 255, 0.8); /* 边框颜色变化 */
        }
        .table-section {
            flex: 2;
            text-align: center;
            overflow: auto;
            display: flex;
            flex-direction: column;
            justify-content: flex-start; /* 调整内容在顶部 */
            height: 60vh; /* 增加色块高度，调整为所需的值 */
            padding-top: 20px; /* 添加顶部内边距 */
        }
        .table-section h2 {
            margin-top: 20px; /* 增加顶部边距，使其位置稍微向下 */
            align-self: center; /* 确保标题居中 */
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
            align-self: flex-start; /* 确保表格在顶部 */
        }
        table, th, td {
            border: 1px solid white; /* 表格边框颜色 */
        }
        th, td {
            padding: 10px;
            text-align: center;
        }
        th {
            background-color: rgba(255, 255, 255, 0.2); /* 表头背景颜色 */
            color: white;
        }
        td {
            background-color: rgba(255, 255, 255, 0.1); /* 表格内容背景颜色 */
        }
        a {
            color: white;
            text-decoration: none;
        }
        a:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>
<div class="header">
    <h2>访客主页</h2>
    <div class="button-container">
        <form name="NewReservationForm" action="NewReservation.jsp" method="get">
            <input type="submit" value="新建访问申请">
        </form>
    </div>
</div>
<div class="table-section">
    <h2>现有访问申请</h2>
    <table>
        <tr>
            <th>访问单号</th>
            <th>申请时间</th>
            <th>申请理由</th>
            <th>申请状态</th>
        </tr>
        <%
            List<Reservation> userReservations = (List<Reservation>) session.getAttribute("Reservations");
            if (userReservations != null && !userReservations.isEmpty()) {
                for (Reservation userReservation : userReservations) {
        %>
        <tr>
            <td><a href="ReservationController?action=showOrderDetails&rId=<%= userReservation.getRid() %>"><%= userReservation.getRid() %></a></td>
            <td><a href="ReservationController?action=showOrderDetails&rId=<%= userReservation.getRid() %>"><%= userReservation.getDate() %></a></td>
            <td><a href="ReservationController?action=showOrderDetails&rId=<%= userReservation.getRid() %>"><%= userReservation.getReason() %></a></td>
            <td><a href="ReservationController?action=showOrderDetails&rId=<%= userReservation.getRid() %>"><%= userReservation.getStatus() %></a></td>
        </tr>
        <%
            }
        } else {
        %>
        <tr>
            <td colspan="4">暂无申请</td>
        </tr>
        <%
            }
        %>
    </table>
</div>
</body>
</html>
