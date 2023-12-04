<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page language="java" import="java.text.*,java.sql.*" %>
<%
  Connection conn = null;
  Statement stmt = null;
  ResultSet rs = null;

  try {
    Class.forName("oracle.jdbc.driver.OracleDriver");
    conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:orcl", "y2k", "1234");

    stmt = conn.createStatement();
    String sql = "SELECT a.reservation_id, a.star_rating, a.review, a.review_date, b.restaurant_name, c.category_name " +
            "FROM Reservation a, Restaurant b, Category c " +
            "WHERE a.star_rating IS NOT NULL " +
            "AND a.rv_restaurant_id = b.restaurant_id " +
            "AND b.rt_category_id = c.category_id";
    rs = stmt.executeQuery(sql);

    StringBuilder sb = new StringBuilder();
    sb.append("[");

    while (rs.next()) {
      sb.append("{\"reservation_id\":\"" + rs.getInt("reservation_id") + "\",");
      sb.append("\"star_rating\":\"" + rs.getInt("star_rating") + "\",");
      sb.append("\"review\":\"" + rs.getString("review") + "\",");
      sb.append("\"review_date\":\"" + rs.getDate("review_date") + "\",");
      sb.append("\"restaurant_name\":\"" + rs.getString("restaurant_name") + "\",");
      sb.append("\"category_name\":\"" + rs.getString("category_name") + "\"},");
    }

    if (sb.length() > 1) {
      sb.deleteCharAt(sb.length()-1);
    }

    sb.append("]");

    String reviewSearchResult = sb.toString();
%>
<script>
  sessionStorage.setItem("reviewSearchResult", '<%= reviewSearchResult %>');
  location.href="reviewSearch.html";
</script>
<%
  } catch (Exception e) {
    e.printStackTrace();
  } finally {
    if (rs != null) try { rs.close(); } catch (SQLException e) { e.printStackTrace(); }
    if (stmt != null) try { stmt.close(); } catch (SQLException e) { e.printStackTrace(); }
    if (conn != null) try { conn.close(); } catch (SQLException e) { e.printStackTrace(); }
  }
%>
