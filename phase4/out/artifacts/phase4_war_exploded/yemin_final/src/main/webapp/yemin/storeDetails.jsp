<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%@ page language="java" import="java.text.*,java.sql.*" %>
<html>
<head>
  <title>Title</title>
  <script>
    function sendToStoreDetail(rt_name,rt_address,rt_phone,rt_total_party_size,rt_open_time,rt_last_order_time,rt_category_id,restaurant_id){
      sessionStorage.setItem("rt_name",rt_name);
      sessionStorage.setItem("rt_address",rt_address);
      sessionStorage.setItem("rt_phone",rt_phone);
      sessionStorage.setItem("rt_total_party_size",rt_total_party_size);
      sessionStorage.setItem("rt_open_time",rt_open_time);
      sessionStorage.setItem("rt_last_order_time",rt_last_order_time);
      sessionStorage.setItem("rt_category_id",rt_category_id);
      sessionStorage.setItem("rt_id",restaurant_id);
      location.href = "storeDetail.html?rt_id="+restaurant_id;
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

  try{
    sql= "select * from restaurant where restaurant_id = '" + restaurant_id + "'";
    out.println(sql);
    rs = stmt.executeQuery(sql);
    rs.next();
    String rt_name = rs.getString("restaurant_name");
    String rt_address = rs.getString("restaurant_address");
    String rt_phone = rs.getString("phone");
    String rt_total_party_size = rs.getString("total_party_size");
    String rt_open_time = rs.getString("open_time");
    String rt_last_order_time = rs.getString("last_order_time");
    String rt_category_id = rs.getString("rt_category_id");
    out.println(rt_name + rt_address + rt_phone + rt_total_party_size + rt_open_time + rt_last_order_time + rt_category_id);


    out.println("<script>sendToStoreDetail('"+rt_name+"','"+rt_address+"','"+rt_phone+"','"+rt_total_party_size+"','"+rt_open_time+"','"+rt_last_order_time+"','"+rt_category_id+"','"+restaurant_id+"');</script>");





  }
  catch (SQLException ex) {
    ex.printStackTrace();
  }


%>