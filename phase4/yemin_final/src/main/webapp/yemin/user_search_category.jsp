<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%@ page language="java" import="java.text.*,java.sql.*" %>
<html>
<head>
  <title>Title</title>
  <script>
    function sendToSearchCategory(SearchResult,category_name) {
      console.log(SearchResult);
      console.log(category_name);
      console.log(window.location.href);

      sessionStorage.setItem("SearchResult",SearchResult);
      location.href="user_search_category.html?category_name="+category_name;
    }
    function sendCustomerInfo(customer_id,customer_name) {
      sessionStorage.setItem("customer_id",customer_id);
      sessionStorage.setItem("customer_name",customer_name);
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
  String sql = null;


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

  String category = request.getParameter("category_name");
  String customer_id = request.getParameter("customer_id");
  String customer_name = request.getParameter("customer_name");
  String sort = request.getParameter("sort");
  out.println(sort);
  out.println(customer_id);
  out.println(category);
  out.println("\n");
  out.println("<script>sendCustomerInfo('"+customer_id+"','"+customer_name+"');</script>");

  try{
    sql = "select category_id from category where category_name = '" + category + "'";
    rs = stmt.executeQuery(sql);
    rs.next();
    String category1 = rs.getString("category_id");

    if (sort != null && sort.equals("reviews")) {


      sql = "SELECT restaurant.restaurant_id, restaurant.restaurant_name, restaurant.restaurant_address, restaurant.total_party_size, COUNT(reservation.reservation_id) AS 리뷰수\n"+
            "FROM Restaurant\n"+
            "JOIN category ON restaurant.rt_category_id = category.category_id\n"+
            "JOIN Reservation ON restaurant.restaurant_id = reservation.rv_restaurant_id\n"+
            "WHERE review IS NOT NULL AND category_id = '" + category1 + "'\n"+
            "GROUP BY restaurant.restaurant_id, restaurant.restaurant_name, restaurant.restaurant_address, restaurant.total_party_size\n"+
            "ORDER BY 리뷰수 DESC";

      out.println(sql);
    }

    else if (sort != null && sort.equals("reservations")) {

      sql = "SELECT restaurant.restaurant_id, restaurant.restaurant_name, restaurant.restaurant_address, restaurant.total_party_size, COUNT(reservation.reservation_id) AS 예약수\n"+
      "FROM Restaurant\n"+
      "JOIN category ON restaurant.rt_category_id = category.category_id\n"+
      "LEFT JOIN Reservation ON restaurant.restaurant_id = reservation.rv_restaurant_id\n"+
      "WHERE category_id = '" + category1 + "'\n"+
      "GROUP BY restaurant.restaurant_id, restaurant.restaurant_name, restaurant.restaurant_address, restaurant.total_party_size\n"+
      "HAVING COUNT(reservation.reservation_id) > 0\n"+
      "ORDER BY 예약수 DESC";

      out.println(sql);
    }

    else {
      sql= "select * from restaurant where rt_category_id = '" + category1 + "' order by restaurant_name asc";
    }
    out.println("페이지 넘어가라1");
    rs = stmt.executeQuery(sql);
    String rt_id;
    String rt_name;
    String rt_address;
    String rt_party_size;
    StringBuilder sb = new StringBuilder();
    sb.append("[");
    out.println("페이지 넘어가라2");

    while (rs.next())
    {
      rt_id = rs.getString("restaurant_id");
      rt_name = rs.getString("restaurant_name");
      rt_address = rs.getString("restaurant_address");
      rt_party_size=rs.getString("total_party_size");


      sb.append("{");
      sb.append("\"rt_id\":\""+rt_id+"\",");
      sb.append("\"rt_name\":\""+rt_name+"\",");
      sb.append("\"rt_address\":\""+rt_address+"\",");
      sb.append("\"rt_party_size\":\""+rt_party_size+"\"");

      sb.append("},");

    }
    sb.deleteCharAt(sb.length()-1);
    sb.append("]");

    String SearchResult = sb.toString();
    out.println("페이지 넘어가라3");
    out.println("<script>sendToSearchCategory('"+SearchResult+"','"+category+"');</script>");
    out.println("페이지 넘어갔나");
  }
  catch (SQLException ex) {
    ex.printStackTrace();
  }
%>
