<%--
  Created by IntelliJ IDEA.
  User: DELL
  Date: 2024/7/11
  Time: 12:24
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
  <title>选择身份页面</title>
  <meta name="viewport" content="width=device-width, initial-scale=1.0"> <!-- 添加viewport元标签以支持响应式设计 -->
  <style>
    body, html {
      margin: 0;
      padding: 0;
      height: 100%;
      overflow: hidden; /* 防止出现滚动条 */
      font-family: Arial, sans-serif; /* 设置全局字体 */
    }
    main {
      background: url("image/background.png") no-repeat center center;
      background-size: cover;
      height: 100vh;
      width: 100vw;
      display: flex;
      flex-direction: column;
      align-items: center;
      justify-content: center;
    }
    .bar {
      background-color: rgba(128, 0, 128, 0.5); /* 半透明紫色背景 */
      width: 100%;
      padding: 30px 0;
      display: flex;
      flex-direction: column;
      align-items: center;
      justify-content: center;
    }
    p {
      font-size: 8vw; /* 增加标题字体大小 */
      text-align: center;
      letter-spacing: 0.5vw;
      color: white;
      margin: 0;
      margin-bottom: 40px; /* 增加标题和按钮间的间距 */
    }
    .button-container {
      display: flex;
      flex-direction: column; /* 修改为列布局 */
      justify-content: center;
      align-items: center;
      gap: 20px; /* 增加按钮间的间距 */
    }
    div {
      margin: 0 2vw;
    }
    button {
      background-color: rgba(255, 255, 255, 0.2); /* 按钮背景颜色 */
      color: white; /* 按钮文字颜色 */
      height: 10vh; /* 调整按钮高度 */
      width: 70vw; /* 修改为百分比宽度以适应不同屏幕 */
      max-width: 200px;
      font-size: 5vw; /* 修改为相对单位以适应不同屏幕 */
      font-weight: bold; /* 加粗按钮文字 */
      border: 1px solid white; /* 按钮边框 */
      border-radius: 10px; /* 圆角边框 */
      box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2); /* 阴影效果 */
      cursor: pointer;
      transition: background-color 0.3s, transform 0.3s, border-color 0.3s; /* 过渡动画 */
    }
    button:hover {
      background-color: rgba(255, 255, 255, 0.3); /* 鼠标悬停时背景颜色变化 */
      transform: scale(1.05); /* 放大效果 */
      border-color: rgba(255, 255, 255, 0.8); /* 边框颜色变化 */
    }
    .button-text {
      font-weight: 700; /* 加粗按钮文字 */
    }
    a {
      text-decoration: none; /* 移除链接下划线 */
    }

    @media (min-width: 768px) {
      p {
        font-size: 4vw; /* 较大屏幕上的标题字体大小 */
      }
      .button-container {
        flex-direction: row; /* 在较大屏幕上保持水平布局 */
      }
      button {
        width: 12vw; /* 在较大屏幕上使用固定宽度 */
        max-width: 200px;
        font-size: 1.5vw; /* 在较大屏幕上使用相对字体大小 */
      }
    }
  </style>
</head>
<body>
<main>
  <div class="bar">
    <p>校园访客管理系统</p>
    <div class="button-container">
      <div><a href="visitorlogin.jsp"><button><span class="button-text">访客登录</span></button></a></div>
      <div><a href="managerlogin.jsp"><button><span class="button-text">工作人员登录</span></button></a></div>
    </div>
  </div>
</main>
</body>
</html>
