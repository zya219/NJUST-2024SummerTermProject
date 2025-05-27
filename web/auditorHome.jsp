<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="bean.Reservation" %>
<%@ page import="java.util.List" %>

<!DOCTYPE html>
<html>
<head>
    <title>审核员主页</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <style>
        body, html {
            margin: 0;
            padding: 0;
            height: 100%;
            width: 100%;
            font-family: Arial, sans-serif; /* 修改为常见的系统字体 */
            background: url("image/background.png") no-repeat center center fixed;
            background-size: cover;
            color: white;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: space-between;
        }
        .container {
            width: 90%;
            max-width: 1200px;
            padding: 20px;
            border-radius: 10px;
            background-color: rgba(128, 0, 128, 0.5); /* 半透明紫色背景 */
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2); /* 阴影效果 */
            margin: 20px 0;
        }
        h2 {
            text-align: center;
            margin-bottom: 20px;
        }
        form {
            display: flex;
            flex-direction: column;
            align-items: center;
            margin-bottom: 0; /* 减少与下方元素的间距 */
        }
        .form-group {
            display: flex;
            justify-content: center;
            align-items: center;
            margin-bottom: 10px;
            flex-wrap: nowrap; /* 确保按钮在同一行 */
        }
        .form-group label {
            margin: 0 10px;
        }
        .form-group input, .form-group select {
            padding: 10px;
            border-radius: 5px;
            border: none;
            font-size: 16px;
            margin: 5px 10px; /* 增加间隙 */
        }
        .form-group button, .show-all-button {
            padding: 10px 20px;
            border-radius: 5px;
            border: 1px solid white; /* 添加边框 */
            background-color: rgba(255, 255, 255, 0.2); /* 按钮背景颜色 */
            color: white; /* 按钮文字颜色 */
            font-size: 16px;
            cursor: pointer;
            transition: background-color 0.3s, transform 0.3s, border-color 0.3s; /* 过渡动画 */
            margin: 5px 10px; /* 增加间隙 */
            white-space: nowrap; /* 防止按钮换行 */
        }
        .form-group button:hover, .show-all-button:hover {
            background-color: rgba(255, 255, 255, 0.3); /* 鼠标悬停时背景颜色变化 */
            transform: scale(1.05); /* 放大效果 */
            border-color: rgba(255, 255, 255, 0.8); /* 边框颜色变化 */
        }
        .filter-info {
            display: flex;
            justify-content: center;
            align-items: center;
            margin-top: 10px;
        }
        .filter-info p {
            margin: 0 10px; /* 减少与上方元素的间距 */
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
        a {
            color: white;
            text-decoration: none;
        }
        a:hover {
            text-decoration: underline;
        }
        /* 针对手机端的样式调整 */
        @media (max-width: 768px) {
            .form-group {
                flex-direction: column;
                align-items: flex-start;
                width: 100%;
            }
            .form-group label {
                margin: 5px 0;
            }
            .form-group input, .form-group select, .form-group button, .show-all-button {
                width: 100%;
                margin: 5px 0;
            }
            table, th, td {
                font-size: 14px;
                padding: 8px;
            }
        }
    </style>
</head>
<body>
<div class="container">
    <h2>所有申请列表</h2>
    <form action="ReservationController" method="get">
        <input type="hidden" name="action" value="filterByDateAndStatus">
        <div class="form-group">
            <label for="date">选择日期:</label>
            <input type="date" id="date" name="date" value="<%= request.getAttribute("currentDate") %>">
            <label for="status">选择状态:</label>
            <select id="status" name="status">
                <option value="">所有状态</option>
                <option value="待审核" <%= "待审核".equals(request.getAttribute("currentStatus")) ? "selected" : "" %>>待审核</option>
                <option value="通过" <%= "通过".equals(request.getAttribute("currentStatus")) ? "selected" : "" %>>通过</option>
                <option value="拒绝" <%= "拒绝".equals(request.getAttribute("currentStatus")) ? "selected" : "" %>>拒绝</option>
            </select>
            <button type="submit">筛选</button>
            <button type="submit" form="clearFiltersForm" class="show-all-button">显示所有申请</button>
        </div>
    </form>
    <form id="clearFiltersForm" action="ReservationController" method="get">
        <input type="hidden" name="action" value="clearFilters">
    </form>

    <div class="filter-info">
        <%
            String currentDate = (String) request.getAttribute("currentDate");
            String currentStatus = (String) request.getAttribute("currentStatus");
            if (currentDate != null && !currentDate.isEmpty()) {
        %>
        <p>当前筛选日期: <%= currentDate %></p>
        <%
        } else {
        %>
        <p>当前筛选日期: 显示所有申请</p>
        <%
            }
            if (currentStatus != null && !currentStatus.isEmpty()) {
        %>
        <p>当前筛选状态: <%= currentStatus %></p>
        <%
        } else {
        %>
        <p>当前筛选状态: 所有状态</p>
        <%
            }
        %>
    </div>
    <table>
        <tr>
            <th>申请编号</th>
            <th>访客ID</th>
            <th>申请时间</th>
            <th>申请理由</th>
            <th>状态</th>
        </tr>
        <%
            List<Reservation> allReservations = (List<Reservation>) request.getAttribute("allReservations");
            if (allReservations != null && !allReservations.isEmpty()) {
                for (Reservation reservation : allReservations) {
        %>
        <tr>
            <td><a href="ReservationController?action=showAuditorOrderDetails&rId=<%= reservation.getRid() %>&date=<%= currentDate %>&status=<%= currentStatus %>"><%= reservation.getRid() %></a></td>
            <td><a href="ReservationController?action=showAuditorOrderDetails&rId=<%= reservation.getRid() %>&date=<%= currentDate %>&status=<%= currentStatus %>"><%= reservation.getVid() %></a></td>
            <td><a href="ReservationController?action=showAuditorOrderDetails&rId=<%= reservation.getRid() %>&date=<%= currentDate %>&status=<%= currentStatus %>"><%= reservation.getDate() %></a></td>
            <td><a href="ReservationController?action=showAuditorOrderDetails&rId=<%= reservation.getRid() %>&date=<%= currentDate %>&status=<%= currentStatus %>"><%= reservation.getReason() %></a></td>
            <td><a href="ReservationController?action=showAuditorOrderDetails&rId=<%= reservation.getRid() %>&date=<%= currentDate %>&status=<%= currentStatus %>"><%= reservation.getStatus() %></a></td>
        </tr>
        <%
            }
        } else {
        %>
        <tr>
            <td colspan="5">暂无申请</td>
        </tr>
        <%
            }
        %>
    </table>
</div>
</body>
</html>
