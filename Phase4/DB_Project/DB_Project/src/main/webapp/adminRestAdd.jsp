<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="EUC-KR"%>
<%@ page language="java" import="java.text.*,java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>예약의 민족</title>
</head>
<% 
String storeName1 = request.getParameter("storeName");
String address1 = request.getParameter("address");
String phoneNum1 =  request.getParameter("phoneNum"); 
String category1 = request.getParameter("category");
String openTime1 = request.getParameter("openTime");
String lastOrder1 = request.getParameter("lastOrder");
String maxReserve1 = request.getParameter("maxReserve");

try {
    Class.forName("com.mysql.jdbc.Driver");
    Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/dbName", "username", "password");
    PreparedStatement pstmt = conn.prepareStatement("INSERT INTO store (storeName, address, phoneNum, category, openTime, lastOrder, maxReserve) VALUES (?, ?, ?, ?, ?, ?, ?)");
    pstmt.setString(1, storeName1);
    pstmt.setString(2, address1);
    pstmt.setString(3, phoneNum1);
    pstmt.setString(4, category1);
    pstmt.setString(5, openTime1);
    pstmt.setString(6, lastOrder1);
    pstmt.setString(7, maxReserve1);
    pstmt.executeUpdate();
    pstmt.close();
    conn.close();
} catch (Exception e) {
    e.printStackTrace();
}
%>
<body>
    <script>
        alert("가게 등록이 완료되었습니다!");
        location.href = "adminRestAdd.html";
    </script>
</body>
</html>
