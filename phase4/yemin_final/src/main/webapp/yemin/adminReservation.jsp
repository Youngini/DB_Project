<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%@ page language="java" import="java.text.*,java.sql.*" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.HashMap" %>
<html>
<head>
    <meta charset="EUC-KR">
    <title>예약의 민족</title>
    <script>
        function sendReservationPage(reservationJson){
            var reservations = reservationJson; // JSP 스크립트릿 변수를 JavaScript 변수에 할당

            // sessionStorage에 배열을 JSON 문자열로 저장
            sessionStorage.setItem('reservations', reservations);
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

    try{
        sql="select reservation_date, reservation_time, party_size\n" +
                "from reservation\n" +
                "where rv_restaurant_id='"+restaurant_id+"'";
        rs = stmt.executeQuery(sql);
        if(rs.next())
        {
            String reservation_date = rs.getString("reservation_date");
            String reservation_time = rs.getString("reservation_time");
            String party_size = rs.getString("party_size");

            StringBuilder jsonReservationInfo = new StringBuilder();
            jsonReservationInfo.append("[");
            jsonReservationInfo.append("{");
            jsonReservationInfo.append("\"reservation_date\": \"" + reservation_date + "\",");
            jsonReservationInfo.append("\"reservation_time\": \"" + reservation_time + "\",");
            jsonReservationInfo.append("\"party_size\": \"" + party_size + "\"");
            jsonReservationInfo.append("}");
            while(rs.next())
            {
                reservation_date = rs.getString("reservation_date");
                reservation_time = rs.getString("reservation_time");
                party_size = rs.getString("party_size");

                jsonReservationInfo.append(",");
                jsonReservationInfo.append("{");
                jsonReservationInfo.append("\"reservation_date\": \"" + reservation_date + "\",");
                jsonReservationInfo.append("\"reservation_time\": \"" + reservation_time + "\",");
                jsonReservationInfo.append("\"party_size\": \"" + party_size + "\"");
                jsonReservationInfo.append("}");
            }
            jsonReservationInfo.append("]");
            String reservations= jsonReservationInfo.toString();
            out.println("<script>");
            out.println("sendReservationPage('" + reservations + "');");
            out.println("</script>");

        }
        else {
            out.println("<script>");
            out.println("sendReservationPage('" + null + "');");
            out.println("</script>");

        }

        out.println("<script type=\"text/javascript\">");
        out.println("window.location.replace('adminReservation.html');");
        out.println("</script>");


    }
    catch (Exception e) {
        e.printStackTrace();
    }

%>

</body>
</html>
