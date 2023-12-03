<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%@ page language="java" import="java.text.*,java.sql.*" %>
<html>
<head>
    <title>Title</title>
  <script>
    function sendToSeachCategory(SearchResult,category_name) {
      sessionStorage.setItem("SearchResult",SearchResult);
        location.href="search_category.html?category_name="+category_name;
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

  String category = request.getParameter("category_name");
  out.println(category);
  try{
    sql = "select category_id from category where category_name = '" + category + "'";
    rs = stmt.executeQuery(sql);
    rs.next();
    category = rs.getString("category_id");


    sql= "select * from restaurant where rt_category_id = '" + category + "'"+ "order by restaurant_name asc";
    out.println(sql);
    rs = stmt.executeQuery(sql);
    String rt_id;
    String rt_name;
    String rt_address;
    String rt_party_size;
    StringBuilder sb = new StringBuilder();
    sb.append("[");
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
    out.println("<script>sendToSeachCategory('"+SearchResult+"','"+category+"');</script>");





  }
  catch (SQLException ex) {
    ex.printStackTrace();
  }


%>