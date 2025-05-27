<%@ page import="bean.Manager" %><%--
  Created by IntelliJ IDEA.
  User: DELL
  Date: 2024/7/11
  Time: 16:36
  To change this template use File | Settings | File Templates.
--%>
<%@ page import="java.util.List"%>
<%@ page import="bean.Status"%>
<%@ page import="bean.Reservation"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    Manager loginForm = (Manager) session.getAttribute("loginForm");
%>
<!DOCTYPE html>
<html>
<head>
    <title>今日访客</title>
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
            justify-content: space-between;
        }
        .container {
            width: 90%;
            max-width: 1200px;
            padding: 20px;
            border-radius: 10px;
            background-color: rgba(128, 0, 128, 0.5);
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
            margin: 20px 0;
        }
        h2 {
            text-align: center;
            margin-bottom: 20px;
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
            display: flex;
            justify-content: center;
            margin-top: 20px;
        }
        .button-container button {
            padding: 8px 16px; /* 调整按钮的内边距，使其扁平化 */
            border-radius: 5px;
            border: 1px solid white;
            background-color: rgba(255, 255, 255, 0.2);
            color: white;
            font-size: 16px;
            cursor: pointer;
            transition: background-color 0.3s, transform 0.3s, border-color 0.3s;
        }
        .button-container button:hover {
            background-color: rgba(255, 255, 255, 0.3);
            transform: scale(1.05);
            border-color: rgba(255, 255, 255, 0.8);
        }
        @media (max-width: 768px) {
            .container {
                padding: 20px;
            }
            table {
                width: 100%;
                transform: none;
                margin-left: 0;
            }
            th, td {
                padding: 8px;
                font-size: 14px;
            }
            .button-container {
                flex-direction: column;
                align-items: center;
                gap: 10px;
            }
            .button-container button {
                padding: 8px 16px;
                font-size: 14px;
                flex: 1;
                margin: 0 5px;
            }
        }
    </style>
    <script>
        function validateForm() {
            var checkboxes = document.getElementsByName('row');
            var checked = false;
            for (var i = 0; i < checkboxes.length; i++) {
                if (checkboxes[i].checked) {
                    checked = true;
                    break;
                }
            }
            if (!checked) {
                alert("请至少选择一个访客记录");
            }
            return checked;
        }
    </script>
</head>
<body>
<div class="container">
    <h2>今日访客</h2>
    <form method="post" action="/ReservationController" onsubmit="return validateForm()">
        <input type="hidden" name="action" value="changestatus">
        <div>用户名：<%= loginForm.getName() %></div>
        <table>
            <tr>
                <th></th>
                <th>申请单号</th>
                <th>访问状态</th>
                <th>入校时间</th>
            </tr>
            <%
                List<Status> curList = (List<Status>) session.getAttribute("statuses");
                int index = 0;
                while (index < curList.size()) {
                    Status status = curList.get(index);
                    if (status != null) {
            %>
            <tr>
                <td><input name="row" type="checkbox" value="<%= status.getRid() %>"></td>
                <td><%= status.getRid() %></td>
                <td><%= status.getStatus() %></td>
                <td><%= status.getTime() %></td>
            </tr>
            <%
                    }
                    index++;
                }
            %>
        </table>
        <div class="button-container">
            <button type="submit">保存</button>
        </div>
    </form>
</div>
</body>
</html>
