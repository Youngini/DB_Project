<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%@ page language="java" import="java.text.*,java.sql.*" %>
<html>
<head>
    <title>Title</title>
    <script>
        function sendReservationInfo(reservation_id,reservation_date,reservation_time,status,restaurant_name,restaurant_address) {
            sessionStorage.setItem("reservation_id",reservation_id);
            sessionStorage.setItem("reservation_date",reservation_date);
            sessionStorage.setItem("reservation_time",reservation_time);
            sessionStorage.setItem("status",status);
            sessionStorage.setItem("restaurant_name",restaurant_name);
            sessionStorage.setItem("restaurant_address",restaurant_address);
            location.href="reservation.html"
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

    String reservation_id=request.getParameter("reservation_id");
    out.println(reservation_id);
    try{
        sql="select * from reservation where reservation_id='"+reservation_id+"'";
        rs=stmt.executeQuery(sql);
        rs.next();
        String reservation_date=rs.getString("reservation_date");
        String reservation_time=rs.getString("reservation_time");
        String status=rs.getString("status");
        String rv_restaurant_id=rs.getString("rv_restaurant_id");
        sql="select * from restaurant where restaurant_id='"+rv_restaurant_id+"'";
        rs=stmt.executeQuery(sql);
        rs.next();
        String restaurant_name=rs.getString("restaurant_name");
        String restaurant_address=rs.getString("restaurant_address");
        out.println(reservation_id+" "+reservation_date+" "+reservation_time+" "+status+" "+restaurant_name+" "+restaurant_address);
        out.println("<script>sendReservationInfo('"+reservation_id+"','"+reservation_date+"','"+reservation_time+"','"+status+"','"+restaurant_name+"','"+restaurant_address+"')</script>");

    }
    catch(SQLException ex)
    {
        ex.printStackTrace();
    }



%>