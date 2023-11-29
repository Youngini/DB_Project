<%@ page language="java" contentType="text/html; charset=EUC-KR"
		 pageEncoding="EUC-KR"%>
<%@ page language="java" import="java.text.*,java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="EUC-KR">
	<title>예약의 민족</title>
	<script>
		// 함수 정의
		function sendToAdminPage(rest_name, adminPw) {
			sessionStorage.setItem('rest_name', rest_name); // rest_name 저장
			location.href = 'adminPage.html'; // 페이지 리디렉션
		}

		function sendToAdminPwCheck(adminPw){
			sessionStorage.setItem('adminPw', adminPw); // adminPw 저장
			location.href = 'adminPwCheck1.html';
		}
	</script>
</head>
<body>
<%
	String adminId = request.getParameter("adminId");
	String adminPw = request.getParameter("adminPw");

	if (adminId.equals("1") && adminPw.equals("1")){
		String manage_id = "123"; // 매니저 아이디 변수에 넣기
		// 매니저 아이디 넣어서 레스토랑 조회 쿼리문
		String rest_name = "정다운분식";
		out.println("<script>sendToAdminPage('"+ rest_name +"');</script>"); // JavaScript 함수 호출
	}
	else {
		out.println("<script type=\"text/javascript\">");
		out.println("alert('로그인 실패!');");
		out.println("location='loginAdmin.html';");
		out.println("</script>");
	}
%>

</body>
</html>
