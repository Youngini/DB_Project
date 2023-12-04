<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<html>
<head>
  <title>사용자 페이지</title>
  <script>
    function displayReservations(reservations) {
      sessionStorage.setItem("reservations", reservations);
      location.href="userPage.html";
    }
  </script>
</head>
<body>
</body>
</html>
<%
  request.setCharacterEncoding("UTF-8");
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
  conn = DriverManager.getConnection(url, user, pass);

  try {
    stmt = conn.createStatement();
  } catch (SQLException ex) {
    ex.printStackTrace();
  }

  String customerId = request.getParameter("customer_id");


  try {
    sql = "SELECT reservation_id,restaurant_name ,reservation_date,reservation_time FROM Reservation,restaurant WHERE rv_customer_id ='"+customerId+"' and rv_restaurant_id=restaurant_id";
    rs = stmt.executeQuery(sql);
    out.println(sql);

    StringBuilder sb = new StringBuilder();
    sb.append("[");
    while (rs.next()) {
      sb.append("{");
      sb.append("\"reservation_id\":\""+rs.getString("reservation_id")+"\",");
      sb.append("\"restaurant_name\":\""+rs.getString("restaurant_name")+"\",");
      sb.append("\"reservation_date\":\""+rs.getString("reservation_date")+"\",");
      sb.append("\"reservation_time\":\""+rs.getString("reservation_time")+"\"");

      sb.append("},");
    }
    if (sb.length() > 1) {
      sb.deleteCharAt(sb.length()-1);
    }
    sb.append("]");

    String reservations = sb.toString();
    out.println(reservations);
    out.println("<script>displayReservations('"+reservations+"');</script>");

  } catch (SQLException ex) {
    ex.printStackTrace();
  }
%>
