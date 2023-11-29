<%@ page language="java" contentType="text/html; charset=EUC-KR"
		 pageEncoding="EUC-KR"%>
<%@ page language="java" import="java.text.*,java.sql.*" %>
<%@ page language="java" import="java.util.Scanner" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="EUC-KR">
	<title>예약의 민족</title>
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
		sql = "SELECT c.customer_id\n" +
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
			out.println("<script type=\"text/javascript\">");
			out.println("alert('로그인 성공');");
			out.println("window.location.replace('main.html');");
			out.println("</script>");
		}

	} catch (SQLException e) {
		e.printStackTrace();
	}

%>

</body>
</html>