<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="javax.servlet.http.HttpSession" %>
<%@ page import="java.time.format.DateTimeFormatter" %>
<%@ page import="com.daou.boardproject.board.vo.BoardVO" %>
<%@ page import="java.util.List" %>
<%
  // 세션을 다른 변수명으로 저장
  HttpSession userSession = request.getSession(false); // false: 세션이 없으면 새로 만들지 않음
  if (userSession == null || userSession.getAttribute("member") == null) {
    // 로그인되지 않은 경우 로그인 페이지로 리다이렉트
    response.sendRedirect("/BoardProject/login");
    return;
  }
%>

<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>Board Page</title>
</head>
<body>
<h1>Board Page</h1>
<p>로그인한 사용자만 이 페이지에 접근할 수 있습니다.</p>

<!-- 로그인된 사용자 정보 표시 -->
<p>Welcome, <%= userSession.getAttribute("member") %></p>

<!-- 게시글 목록 출력 -->
<h2>게시글 목록</h2>
<table border="1">
  <thead>
  <tr>
    <th>제목</th>
    <th>작성자</th>
    <th>작성일</th>
    <th>수정일</th>
  </tr>
  </thead>
  <tbody>
  <%
    // contents 리스트에서 각 게시글 정보 출력
    List<BoardVO> contents = (List<BoardVO>) request.getAttribute("contents");

    // LocalDateTime 포맷터 설정
    DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");

    for (BoardVO board : contents) {
  %>
  <tr>
    <td><%= board.getTitle() %></td>
    <td><%= board.getMember_id() %></td>
    <td><%= board.getCreated_at().format(formatter) %></td>
    <td><%= board.getUpdated_at().format(formatter) %></td>
  </tr>
  <% } %>
  </tbody>
</table>

</body>
</html>
