<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%@ page language="java" import="java.text.*,java.sql.*" %>
<%@ page import="netscape.javascript.JSObject" %>
<html>
<head>
  <title>Order Page</title>
  <script>
    function displayMenu(menus, rt_id, rt_name){
      sessionStorage.setItem("menus", menus);
      sessionStorage.setItem("rt_id", rt_id);
      sessionStorage.setItem("rt_name", rt_name);

      window.location.href = "userOrder.html";
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
  conn = DriverManager.getConnection(url,user,pass);

  try {
    stmt = conn.createStatement();
  } catch (SQLException ex) {
    ex.printStackTrace();
  }

  String restaurant_id= request.getParameter("rt_id");
  String restaurant_name = request.getParameter("rt_name");


  try{
    sql= "select * from menu where m_restaurant_id = '" + restaurant_id + "'";
    out.println(sql);
    rs = stmt.executeQuery(sql);
    String menu_id;
    String menu_name;
    String price;
    StringBuilder sb = new StringBuilder();
    sb.append("[");
    while(rs.next()) {
      menu_id = rs.getString("menu_id");
     menu_name = rs.getString("menu_item_name");
     price = rs.getString("price");
        sb.append("{\"menu_id\":\""+menu_id+"\",\"menu_name\":\""+menu_name+"\",\"price\":\""+price+"\"},");

    }
    sb.deleteCharAt(sb.length()-1);
    sb.append("]");
    String menus = sb.toString();
    out.println("<script>displayMenu('"+menus+"','"+restaurant_id+"','"+restaurant_name+"');</script>");




  }
  catch (SQLException ex) {
    ex.printStackTrace();
  }
%>
