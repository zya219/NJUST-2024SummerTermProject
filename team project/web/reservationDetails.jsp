<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="bean.Reservation" %>

<%
    Reservation reservation = (Reservation) request.getAttribute("reservation");
%>

<!DOCTYPE html>
<html>
<head>
    <title>预约详情</title>
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
            padding: 40px;
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
            flex-wrap: wrap;
        }
        .button-container form, .button-container a {
            flex: 1;
            max-width: 200px;
            text-align: center;
        }
        .button-container a, .button-container input[type="submit"] {
            display: inline-block;
            width: 100%;
            padding: 10px 20px;
            border-radius: 5px;
            border: 1px solid white;
            background-color: rgba(255, 255, 255, 0.2);
            color: white;
            font-size: 16px;
            cursor: pointer;
            text-decoration: none;
            text-align: center;
            transition: background-color 0.3s, transform 0.3s, border-color 0.3s;
            box-sizing: border-box;
            font-weight: normal;
            line-height: 1.5; /* 确保行高一致 */
        }
        .button-container a:hover, .button-container input[type="submit"]:hover {
            background-color: rgba(255, 255, 255, 0.3);
            transform: scale(1.05);
            border-color: rgba(255, 255, 255, 0.8);
        }
        input[type="submit"] {
            appearance: none;
            -webkit-appearance: none;
            -moz-appearance: none;
            padding: 10px 20px; /* 确保内边距一致 */
            border: none; /* 去除默认边框 */
            background: none; /* 去除默认背景 */
            color: inherit; /* 继承父元素颜色 */
            font: inherit; /* 继承父元素字体 */
            line-height: inherit; /* 继承行高 */
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
        <form action="ReservationController" method="post">
            <input type="hidden" name="action" value="withdrawReservation">
            <input type="hidden" name="rid" value="<%= reservation.getRid() %>">
            <input type="submit" value="撤回订单">
        </form>
        <a href="allReservation.jsp" class="back-button">返回主页</a>
    </div>
</div>
</body>
</html>
