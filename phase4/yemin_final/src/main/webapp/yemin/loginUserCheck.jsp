<%@ page language="java" contentType="text/html; charset=EUC-KR"
		 pageEncoding="EUC-KR"%>
<%@ page language="java" import="java.text.*,java.sql.*" %>
<%@ page language="java" import="java.util.Scanner" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="EUC-KR">
	<title>예약의 민족</title>
	<script>
		// 함수 정의
		function sendToUserPage(customer_id, customer_name, customer_pw) {
			sessionStorage.setItem('customer_id', customer_id);
			sessionStorage.setItem('customer_name', customer_name);
			sessionStorage.setItem('customer_pw', customer_pw);
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

	String userId = request.getParameter("userId");
	String userPw = request.getParameter("userPw");


	try {
		sql = "SELECT c.customer_id, c.name\n" +
				"FROM customer c\n" +
				"WHERE login_id = '" + userId + "'\n" +
				"AND login_pw='" + userPw + "'";
		rs = stmt.executeQuery(sql);
		if(!rs.next()) {
			out.println("<script type=\"text/javascript\">");
			out.println("alert('로그인 실패!');");
			out.println("location='loginUser.html';");
			out.println("</script>");
		}
		else
		{
			String customer_id = rs.getString("customer_id");
			String customer_name = rs.getString("name");
			String customer_pw = userPw;
			out.println("<script>sendToUserPage('" + customer_id + "', '" + customer_name + "', '" + customer_pw + "');</script>");



			out.println("<script type=\"text/javascript\">");
			out.println("alert('로그인 성공');");
			out.println("window.location.replace('userMain.html');");
			out.println("</script>");
		}

	} catch (SQLException e) {
		e.printStackTrace();
	}

%>

</body>
</html>