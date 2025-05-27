<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>管理员登录</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0"> <!-- 添加viewport元标签以支持响应式设计 -->
    <style>
        body, html {
            margin: 0;
            padding: 0;
            height: 100%;
            font-family: Arial, sans-serif;
            display: flex;
            align-items: center;
            justify-content: center;
            background: url("image/background.png") no-repeat center center fixed;
            background-size: cover;
        }
        .login-container {
            background-color: rgba(128, 0, 128, 0.5); /* 半透明紫色背景，透明度为0.5 */
            padding: 40px;
            border-radius: 10px;
            width: 90%;
            max-width: 350px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2); /* 阴影效果 */
            color: white;
        }
        .login-container h2 {
            text-align: center;
            margin-bottom: 20px;
        }
        form {
            display: flex;
            flex-direction: column;
        }
        form .input-group {
            margin-bottom: 15px;
            display: flex;
            flex-direction: column;
        }
        form .input-group label {
            margin-bottom: 5px;
        }
        form .input-group input {
            padding: 10px;
            border-radius: 5px;
            border: none;
            font-size: 16px; /* 统一输入框字体大小 */
        }
        form .captcha-group {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 15px;
        }
        form .captcha-group input {
            width: 40%; /* 调整验证码输入框宽度 */
            padding: 10px;
            border-radius: 5px;
            border: none;
            font-size: 16px;
        }
        form .captcha-group span {
            background-color: white;
            color: black;
            padding: 10px;
            border-radius: 5px;
            cursor: pointer;
            user-select: none;
            min-width: 60px; /* 固定验证码显示框长度 */
            text-align: center; /* 居中文本 */
        }
        form .login-button {
            display: flex;
            justify-content: center;
        }
        form .login-button input {
            padding: 10px 20px;
            border-radius: 5px;
            border: 1px solid white; /* 添加边框 */
            background-color: rgba(255, 255, 255, 0.2); /* 按钮背景颜色 */
            color: white; /* 按钮文字颜色 */
            font-size: 16px;
            cursor: pointer;
            transition: background-color 0.3s, transform 0.3s, border-color 0.3s; /* 过渡动画 */
        }
        form .login-button input:hover {
            background-color: rgba(255, 255, 255, 0.3); /* 鼠标悬停时背景颜色变化 */
            transform: scale(1.05); /* 放大效果 */
            border-color: rgba(255, 255, 255, 0.8); /* 边框颜色变化 */
        }
    </style>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script>
        $(document).ready(function() {
            function generateCaptcha() {
                var length = 5;
                var characters = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';
                var captcha = '';
                for (var i = 0; i < length; i++) {
                    captcha += characters.charAt(Math.floor(Math.random() * characters.length));
                }
                $("#captcha-question").text(captcha);
                $("#captcha-answer").val(captcha);
            }

            function validateCaptcha(answer) {
                return answer === $("#captcha-answer").val();
            }

            generateCaptcha();

            $("#captcha-question").click(function() {
                generateCaptcha();
            });

            $("form").submit(function(event) {
                var captcha = $("#captcha").val();
                if (!validateCaptcha(captcha)) {
                    event.preventDefault();
                    alert("验证码不正确");
                }
            });
        });

        function showError(message) {
            alert(message);
        }
    </script>
</head>
<body>
<div class="login-container">
    <h2>管理员登录</h2>
    <form name="loginForm" method="post" action="LoginController">
        <input type="hidden" name="action" value="managerlogin">
        <div class="input-group">
            <label for="managername">姓名：</label>
            <input type="text" id="managername" name="managername" required>
        </div>
        <div class="input-group">
            <label for="managerid">工号：</label>
            <input type="text" id="managerid" name="managerid" required>
        </div>
        <div class="input-group">
            <label for="password">密码：</label>
            <input type="password" id="password" name="password" required>
        </div>
        <div class="captcha-group">
            <label for="captcha">验证码：</label>
            <input type="hidden" id="captcha-answer">
            <input type="text" id="captcha" name="captcha" required>
            <span id="captcha-question"></span>
        </div>
        <div class="login-button">
            <input type="submit" value="登录">
        </div>
    </form>
</div>
<%
    // 获取错误代码
    Integer errorCode = (Integer) request.getAttribute("errorCode");
    if (errorCode != null) {
        String errorMessage;
        switch (errorCode) {
            case 1:
            case 2:
                errorMessage = "用户信息错误";
                break;
            case 3:
                errorMessage = "密码错误";
                break;
            default:
                errorMessage = "未知错误";
        }
%>
<script>
    $(document).ready(function() {
        showError("<%= errorMessage %>");
    });
</script>
<%
    }
%>
</body>
</html>
