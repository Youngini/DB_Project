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

  String newPassword = request.getParameter("newPassword");
  String manager_id = request.getParameter("manager_id");

  if (newPassword == null || newPassword.isEmpty()) {
%>
<script>
  alert("모든 값을 입력해주세요!");
  location.href = "adminChangePw.html";
</script>
<%
} else {
  try {
    sql = "update manager set login_pw = '" + newPassword + "' where manager_id = '" + manager_id + "'";
    rs = stmt.executeQuery(sql);

    sql="select manager_id from manager" +" where login_pw = '"+newPassword+"'";
    rs=stmt.executeQuery(sql);

    if(!rs.next())
    {
      out.println("<script type=\"text/javascript\">");
      out.println("alert('비밀번호 변경 실패!');");
      out.println("location='adminChangePw.html';");
      out.println("</script>");

    }
    else
    {
      out.println("<script type=\"text/javascript\">");
      out.println("alert('비밀번호 변경 성공!');");
      out.println("location='adminPage.html';");
      out.println("</script>");


    }




  } catch (SQLException e) {
    e.printStackTrace();
  }

  // 비밀번호 변경 작업 수행 코드...
  // 데이터베이스 연결 및 쿼리 실행 코드...


  }
%>
</body>
</html>