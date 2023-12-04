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
        function sendInfor(resv_date,resv_time,resv_party_size){
            sessionStorage.setItem("date",resv_date);
            sessionStorage.setItem("time",resv_time);
            sessionStorage.setItem("party",resv_party_size);
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

    String name=request.getParameter("name");
    String date=request.getParameter("date");
    String time=request.getParameter("time");
    String party_size=request.getParameter("people");
    out.println("<script>sendInfor('"+date+"','"+time+"','"+party_size+"');</script>");

    try{
        sql = "SELECT " +
                "a.restaurant_id, " +
                "a.restaurant_name, " +
                "NVL(SUM(b.party_size), 0) as party_size, " +
                "a.total_party_size, " +
                "a.phone, " +
                "a.open_time, " +
                "a.last_order_time, " +
                "a.restaurant_address " +
                "FROM " +
                "restaurant a " +
                "LEFT JOIN " +
                "reservation b " +
                "ON " +
                "a.restaurant_id = b.rv_restaurant_id " +
                "AND TO_CHAR(b.reservation_date, 'YYYY-MM-DD') = '"+date+"' " +
                "AND b.reservation_time = "+time+" " +
                "AND (b.status = 0 OR b.status = 1) " +
                "LEFT JOIN " +
                "menu m " +
                "ON " +
                "a.restaurant_id = m.m_restaurant_id " +
                "WHERE " +
                "a.restaurant_name LIKE '%"+name+"%' "+
                "OR " +
                "m.menu_item_name LIKE '%"+name+"%' " +
                "GROUP BY " +
                "a.restaurant_id, " +
                "a.restaurant_name, " +
                "a.total_party_size, " +
                "a.phone, " +
                "a.open_time, " +
                "a.last_order_time, " +
                "a.restaurant_address " +
                "HAVING " +
                "a.total_party_size - NVL(SUM(b.party_size), 0) >= "+party_size+" " +
                "OR " +
                "SUM(b.party_size) IS NULL";

        rs = stmt.executeQuery(sql);
        String rt_id;
        String rt_name;
        String rt_party_size;
        String rt_total_party_size;
        String rt_address;
        String rt_phone;
        String rt_open_time;
        String rt_last_order_time;

        StringBuilder sb = new StringBuilder();
        sb.append("[");
        while(rs.next()){
            rt_id=rs.getString("restaurant_id");
            rt_name=rs.getString("restaurant_name");
            rt_party_size=rs.getString("party_size");
            rt_total_party_size=rs.getString("total_party_size");
            rt_address=rs.getString("restaurant_address");
            rt_phone=rs.getString("phone");
            rt_open_time=rs.getString("open_time");
            rt_last_order_time=rs.getString("last_order_time");
            out.println(rt_party_size);

            rt_party_size=String.valueOf(Integer.parseInt(rt_total_party_size)-Integer.parseInt(rt_party_size));



            sb.append("{\"rt_id\":\""+rt_id+"\",");
            sb.append("\"rt_name\":\""+rt_name+"\",");
            sb.append("\"rt_party_size\":\""+rt_party_size+"\",");
            sb.append("\"rt_total_party_size\":\""+rt_total_party_size+"\",");
            sb.append("\"rt_address\":\""+rt_address+"\",");
            sb.append("\"rt_phone\":\""+rt_phone+"\",");
            sb.append("\"rt_open_time\":\""+rt_open_time+"\",");
            sb.append("\"rt_last_order_time\":\""+rt_last_order_time+"\"},");


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