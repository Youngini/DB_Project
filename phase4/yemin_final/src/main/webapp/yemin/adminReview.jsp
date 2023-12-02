<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%@ page language="java" import="java.text.*,java.sql.*" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.HashMap" %>
<html>
<head>
  <meta charset="EUC-KR">
  <title>예약의 민족</title>
  <script>
    function sendReviewPage(reviewJson){
      var reviews = reviewJson; // JSP 스크립트릿 변수를 JavaScript 변수에 할당

      // sessionStorage에 배열을 JSON 문자열로 저장
      sessionStorage.setItem('reviews', reviews);
    }
    function sendRestaurant_id(r_id){
      sessionStorage.setItem('r_id', r_id);
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

  String restaurant_id = request.getParameter("r_id");
    out.println("<script>");
    out.println("sendRestaurant_id('" + restaurant_id + "');");
    out.println("</script>");
  try{


    sql = "SELECT b.restaurant_name, a.star_rating, a.review, a.review_date FROM Reservation a, Restaurant b "+"where b.restaurant_id='"+restaurant_id+"' " +"AND a.rv_restaurant_id = b.restaurant_id ";
    rs = stmt.executeQuery(sql);

    if(rs.next()) {
      String restaurant_name = rs.getString("restaurant_name");
      String review = rs.getString("review");
      String star_rating = rs.getString("star_rating");
      String review_date = rs.getString("review_date");

      StringBuilder jsonRestaurantInfo = new StringBuilder();
      jsonRestaurantInfo.append("[");
      jsonRestaurantInfo.append("{");
      jsonRestaurantInfo.append("\"restaurant_name\": \"" + restaurant_name + "\",");
      jsonRestaurantInfo.append("\"review\": \"" + review + "\",");
      jsonRestaurantInfo.append("\"star_rating\": \"" + star_rating + "\",");
      jsonRestaurantInfo.append("\"review_date\": \"" + review_date + "\"");
      jsonRestaurantInfo.append("}");
      while(rs.next())
      {
        restaurant_name = rs.getString("restaurant_name");
        review = rs.getString("review");
        star_rating = rs.getString("star_rating");
        review_date = rs.getString("review_date");

        jsonRestaurantInfo.append(",");
        jsonRestaurantInfo.append("{");
        jsonRestaurantInfo.append("\"restaurant_name\": \"" + restaurant_name + "\",");
        jsonRestaurantInfo.append("\"review\": \"" + review + "\",");
        jsonRestaurantInfo.append("\"star_rating\": \"" + star_rating + "\",");
        jsonRestaurantInfo.append("\"review_date\": \"" + review_date + "\"");
        jsonRestaurantInfo.append("}");
      }
      jsonRestaurantInfo.append("]");
      String reviews= jsonRestaurantInfo.toString();
        out.println("<script>");
        out.println("sendReviewPage('" + reviews + "');");
        out.println("</script>");
    }
    else {
      out.println("<script>");
      out.println("sendReviewPage('" + null + "');");
      out.println("</script>");
    }
    out.println("<script type=\"text/javascript\">");
    out.println("window.location.replace('adminReview.html');");
    out.println("</script>");




  }
    catch (Exception e) {
      e.printStackTrace();
    }

%>

</body>
</html>
