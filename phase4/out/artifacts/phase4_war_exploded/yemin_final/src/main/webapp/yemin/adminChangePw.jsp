<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ page language="java" import="java.text.*,java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>예약의 민족</title>
</head>
<body>
<%
  String newPassword = request.getParameter("newPassword");

  if (newPassword == null || newPassword.isEmpty()) {
%>
<script>
  alert("모든 값을 입력해주세요!");
  location.href = "adminChangePw.html";
</script>
<%
} else {
  // 비밀번호 변경 작업 수행 코드...
  // 데이터베이스 연결 및 쿼리 실행 코드...

%>
<script>
  alert("비밀번호가 변경되었습니다!");
  location.href = "adminChangePw.html";
</script>
<%
  }
%>
</body>
</html>
