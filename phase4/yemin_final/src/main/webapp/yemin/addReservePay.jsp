<%@ page language="java" contentType="text/html; charset=EUC-KR"
         pageEncoding="EUC-KR"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="EUC-KR">
    <title>결제 정보 등록</title>
</head>
<body>
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

    // 사용자로부터 입력받은 데이터
    String rt_id = request.getParameter("rt_id");
    String customer_id = request.getParameter("customer_id");
    String date = request.getParameter("date");
    String time = request.getParameter("time");
    String party_size= request.getParameter("party_size");

    // ... 나머지 변수들도 같은 방식으로 작성 ...

    try {
        sql="Insert Into Reservation (reservation_id,status,special_request,party_size,reservation_date,star_rating,review,review_date,reservation_time,rv_customer_id,rv_restaurant_id) values ( '' , 1 , '' , "+party_size+" , '"+date+"' , 0 , '' , '' , "+time+" , '"+customer_id+"' , '"+rt_id+"' )";
        out.println(sql);
        stmt.executeUpdate(sql);

        out.println("<script type=\"text/javascript\">");
        out.println("alert('예약에 성공하였습니다.');");
        out.println("location='userPayment.html';");
        out.println("</script>");
    } catch(SQLException e) {
        e.printStackTrace();
        out.println("<script type=\"text/javascript\">");
        out.println("alert('예약에 실패하였습니다. 다시 시도해주세요.');");
        out.println("location='userPayment.html';");
        out.println("</script>");
    }
%>
</body>
</html>