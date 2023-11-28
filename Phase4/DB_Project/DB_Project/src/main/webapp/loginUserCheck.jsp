<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page language="java" import="java.text.*,java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>예약의 민족</title>
</head>
<body>
<%
	String userId = request.getParameter("userId");
	String userPw = request.getParameter("userPw");
	
	if (userId.equals("1") && userPw.equals("1")){
		String sent = "로그인 성공!";
		out.println(sent);
		response.sendRedirect("main.html");
	}
	else {
		out.println("<script type=\"text/javascript\">");
		out.println("alert('로그인 실패!');");
		out.println("location='loginUser.html';");
		out.println("</script>");
	}
%>

</body>
</html>
