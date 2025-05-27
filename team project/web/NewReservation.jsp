<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    String vid = (String) session.getAttribute("vid");
%>

<!DOCTYPE html>
<html>
<head>
    <title>新建访问申请</title>
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
            width: 200%;
            border-collapse: collapse;
            margin-top: 20px;
            transform: translateX(-50%);
            margin-left: 50%;
        }
        table, th, td {
            border: 1px solid white;
        }
        th, td {
            padding: 10px;
            text-align: left;
        }
        th {
            background-color: rgba(255, 255, 255, 0.15);
            color: white;
        }
        td {
            background-color: rgba(255, 255, 255, 0.1);
        }
        textarea, input[type="text"], input[type="datetime-local"] {
            width: calc(100% - 22px);
            padding: 10px;
            border-radius: 5px;
            border: none;
            margin-bottom: 10px;
            background-color: rgba(255, 255, 255, 0.8);
            color: black;
            box-sizing: border-box;
        }
        textarea {
            height: 100px;
            resize: none;
        }
        .button-container {
            margin-top: 20px;
            display: flex;
            justify-content: center;
            gap: 10px;
            flex-wrap: nowrap;
            width: 100%; /* 确保在移动端按钮保持在一行 */
        }
        input[type="submit"], .cancel-button {
            padding: 8px 16px; /* 调整按钮的内边距，使其扁平化 */
            border-radius: 5px;
            border: 1px solid white;
            background-color: rgba(255, 255, 255, 0.2);
            color: white;
            font-size: 16px;
            cursor: pointer;
            transition: background-color 0.3s, transform 0.3s, border-color 0.3s;
            text-decoration: none;
            display: inline-block;
            box-sizing: border-box;
        }
        input[type="submit"]:hover, .cancel-button:hover {
            background-color: rgba(255, 255, 255, 0.3);
            transform: scale(1.05);
            border-color: rgba(255, 255, 255, 0.8);
        }
        .cancel-button {
            display: inline-block;
            text-align: center;
            line-height: 22px; /* 调整行高以使按钮高度一致 */
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
                text-align: center;
            }
            textarea, input[type="text"], input[type="datetime-local"] {
                width: 100%;
                padding: 8px;
                font-size: 14px;
            }
            .button-container {
                flex-wrap: nowrap;
                justify-content: space-between; /* 在手机端按钮保持在一行 */
            }
            input[type="submit"], .cancel-button {
                appearance: none;
                -webkit-appearance: none;
                -moz-appearance: none;
                padding: 8px 16px;
                font-size: 14px;
                flex: 1;
                margin: 0 5px; /* 增加按钮之间的间距 */
            }
        }
    </style>
</head>
<body>
<div class="container">
    <h2>新建访问申请</h2>
    <form name="NewReservationForm" action="ReservationController" method="post">
        <input type="hidden" name="action" value="submitApplication">
        <input type="hidden" id="vid" name="vid" value="<%= vid %>">
        <table>
            <tr>
                <th>访客ID：</th>
                <td><%= vid %></td>
            </tr>
            <tr>
                <th>访问时间：</th>
                <td><input type="datetime-local" id="visitTime" name="visitTime" required></td>
            </tr>
            <tr>
                <th>访问目的：</th>
                <td><textarea id="visitReason" name="visitReason" required></textarea></td>
            </tr>
            <tr>
                <th>联系电话：</th>
                <td><input type="text" id="tel" name="tel" required></td>
            </tr>
        </table>
        <div class="button-container">
            <input type="submit" value="提交申请">
            <a href="allReservation.jsp" class="cancel-button">取消</a>
        </div>
    </form>
</div>
</body>
</html>
