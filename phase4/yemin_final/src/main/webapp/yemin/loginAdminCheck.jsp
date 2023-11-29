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
		function sendToAdminPage(rest_name, r_id){
			sessionStorage.setItem('rest_name', rest_name);
			sessionStorage.setItem('r_id', r_id);
			location.href = 'adminPage.html'; // 페이지 리디렉션
		}

		function savePw(adminPw){
			sessionStorage.setItem('adminPw', adminPw);
		}
	</script>
</head>
<body>
<%
	String serverIP = "localhost";
	String strSID = "xe";
	String portNum = "1521";
	String user = "y2k";
	String pass = "1234";
	String url = "jdbc:oracle:thin:@"+serverIP+":"+portNum+":"+strSID;
	String sql;


	Connection conn = null;
	ResultSet rs;
	Statement stmt=null;
	Class.forName("oracle.jdbc.driver.OracleDriver");
	conn = DriverManager.getConnection(url,user,pass);

	try {
		stmt = conn.createStatement();
	} catch (SQLException ex) {
		ex.printStackTrace();
	}


	String adminId = request.getParameter("adminId");
	String adminPw = request.getParameter("adminPw");

	try {
		sql = "SELECT manager_id\n" +
				"FROM manager \n" +
				"WHERE login_id = '" + adminId + "'\n" +
				"AND login_pw='" + adminPw + "'";
		rs = stmt.executeQuery(sql);
		if(!rs.next()) {
			out.println("<script type=\"text/javascript\">");
			out.println("alert('로그인 실패!');");
			out.println("location='loginAdmin.html';");
			out.println("</script>");
		}
		else
		{
			out.println("<script>savePw('" + adminPw + "');</script>");
			String manager_id = rs.getString("manager_id"); // 매니저 아이디 변수에 넣기
			sql="select restaurant_name,restaurant_id from restaurant where rt_manager_id = '" + manager_id + "'";
			rs = stmt.executeQuery(sql);
			rs.next();
			String rest_name = rs.getString("restaurant_name");
			String r_id = rs.getString("restaurant_id");

			out.println("<script>sendToAdminPage('"+ rest_name +"','"+ r_id +"');</script>");

		}

	} catch (SQLException e) {
		e.printStackTrace();
	}


//	if (adminId.equals("1") && adminPw.equals("1")){
//		out.println("<script>savePw('" + adminPw + "');</script>");
//		String manage_id = "123"; // 매니저 아이디 변수에 넣기
//		// 매니저 아이디 넣어서 레스토랑 조회 쿼리
//		String rest_name = "정다운분식";
//		out.println("<script>sendToAdminPage('"+ rest_name +"');</script>");
//
//		// JavaScript 함수 호출
//	}
//	else {
//		out.println("<script type=\"text/javascript\">");
//		out.println("alert('로그인 실패!');");
//		out.println("location='loginAdmin.html';");
//		out.println("</script>");
//	}
%>

</body>
</html>