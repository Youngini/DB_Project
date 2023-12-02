<%@ page language="java" contentType="text/html; charset=EUC-KR"
		 pageEncoding="EUC-KR"%>
<%@ page language="java" import="java.text.*,java.sql.*" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.HashMap" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="EUC-KR">
	<title>예약의 민족</title>
	<script>
		// 함수 정의
		function sendToAdminPage(restaurantsJson){
			var restaurants = restaurantsJson; // JSP 스크립트릿 변수를 JavaScript 변수에 할당

			// sessionStorage에 배열을 JSON 문자열로 저장
			sessionStorage.setItem('restaurants', restaurants);



		}

		function saveManager_Info(manager_id,manager_name,adminPw){
			sessionStorage.setItem('manager_id', manager_id);
			sessionStorage.setItem('manager_name', manager_name);
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
		sql = "SELECT manager_id, name\n" +
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

			String manager_id = rs.getString("manager_id"); // 매니저 아이디 변수에 넣기
			String manager_name = rs.getString("name"); // 매니저 이름 변수에 넣기
			out.println("<script>saveManager_Info('" + manager_id + "','" +manager_name+"','"+ adminPw + "');</script>");
			sql="select restaurant_name,restaurant_id from restaurant where rt_manager_id = '" + manager_id + "'";
			rs = stmt.executeQuery(sql);
			if (rs.next()) {
				String rest_name = rs.getString("restaurant_name");
				String r_id = rs.getString("restaurant_id");

				StringBuilder jsonBuilder = new StringBuilder();
				jsonBuilder.append("[");
				jsonBuilder.append("{\"").append(r_id).append("\": \"").append(rest_name).append("\"}");

				while (rs.next()) {
					rest_name = rs.getString("restaurant_name");
					r_id = rs.getString("restaurant_id");
					jsonBuilder.append(",{\"").append(r_id).append("\": \"").append(rest_name).append("\"}");
				}

				jsonBuilder.append("]");

				String restaurantsJson = jsonBuilder.toString();
				out.println("<script>sendToAdminPage('" + restaurantsJson + "');</script>");
				//out.println(restaurantsJson);

			}
			else{
				String rest_name = "가게없음";
				String r_id = "가게없음";

				out.println("<script>sendToAdminPage('" + r_id + "','" + rest_name + "');</script>");

			}
			out.println("<script type=\"text/javascript\">");
			out.println("window.location.replace('adminPage.html');");
			out.println("</script>");

		}

	} catch (SQLException e) {
		e.printStackTrace();
	}



%>

</body>
</html>