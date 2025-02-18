<%--
  Created by IntelliJ IDEA.
  User: daou_psh0855
  Date: 25. 2. 18.
  Time: 오후 4:13
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>로그인 페이지</title>
</head>
<body>
<h2>로그인</h2>
<form method="POST" action="http://localhost:8080/BoardProject/login">
    <label for="id">ID:</label>
    <input type="text" id="member_id" name="member_id" required><br>

    <label for="pw">PW:</label>
    <input type="password" id="password" name="password" required><br>

    <button type="submit">로그인</button>
</form>
</body>
</html>

