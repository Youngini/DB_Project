<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%@ page language="java" import="java.text.*,java.sql.*" %>
<html>
<head>
    <title>Title</title>
    <script>
        function sendTosearch(SearchResult, customer_id, customer_name) {
            sessionStorage.setItem("SearchResult",SearchResult);
            location.href="search.html"+"?customer_id="+customer_id+"&customer_name="+customer_name;

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

    String customer_id=request.getParameter("customer_id");
    String customer_name=request.getParameter("customer_name");
    out.println(customer_name);

    String name=request.getParameter("name");
    String date=request.getParameter("date");
    String time=request.getParameter("time");
    String party_size=request.getParameter("people");

    try{
        sql="SELECT t.restaurant_id, t.restaurant_name, t.party_size, t.total_party_size\n" +
                "FROM (\n" +
                "    SELECT a.restaurant_id, a.restaurant_name, sum(b.party_size) as party_size, a.total_party_size\n" +
                "    FROM restaurant a, reservation b \n" +
                "    WHERE a.restaurant_name LIKE '%"+name+"%'\n" +
                "    AND a.restaurant_id = b.rv_restaurant_id\n" +
                "    AND b.reservation_date = '"+date+"'\n" +
                "    AND b.reservation_time = "+time+"\n" +
                "    AND (b.status = 0 OR b.status = 1)\n" +
                "    GROUP BY a.restaurant_id, a.restaurant_name, a.total_party_size\n" +
                ") t\n" +
                "WHERE t.total_party_size - t.party_size >= "+party_size+"\n" ;
        //out.println(sql);
        rs=stmt.executeQuery(sql);
        String rt_id;
        String rt_name;
        String rt_party_size;
        String rt_total_party_size;
        StringBuilder sb = new StringBuilder();
        sb.append("[");
        while(rs.next()){
            rt_id=rs.getString("restaurant_id");
            rt_name=rs.getString("restaurant_name");
            rt_party_size=rs.getString("party_size");
            rt_total_party_size=rs.getString("total_party_size");


            sb.append("{\"rt_id\":\""+rt_id+"\",");
            sb.append("\"rt_name\":\""+rt_name+"\",");
            sb.append("\"rt_party_size\":\""+rt_party_size+"\",");
            sb.append("\"rt_total_party_size\":\""+rt_total_party_size+"\"},");

        }
        sb.deleteCharAt(sb.length()-1);

        sb.append("]");

        String SearchResult = sb.toString();
        out.println(SearchResult);
        out.println("<script>sendTosearch('"+SearchResult+"','"+customer_id+"','"+customer_name+"');</script>");


    }
    catch (SQLException ex) {
        ex.printStackTrace();
    }



%>
