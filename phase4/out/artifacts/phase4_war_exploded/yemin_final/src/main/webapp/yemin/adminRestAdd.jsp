<%@ page language="java" contentType="text/html; charset=EUC-KR"
         pageEncoding="EUC-KR"%>
<%@ page language="java" import="java.text.*,java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>예약의 민족</title>
</head>
<body>
<%
    String storeName1 = request.getParameter("storeName");
    String address1 = request.getParameter("address");
    String phoneNum1 =  request.getParameter("phoneNum");
    String category1 = request.getParameter("category");
    String openTime1 = request.getParameter("openTime");
    String lastOrder1 = request.getParameter("lastOrder");
    String maxReserve1 = request.getParameter("maxReserve");

    if (storeName1 == null || address1 == null || phoneNum1 == null || category1 == null || openTime1 == null || lastOrder1 == null || maxReserve1 == null) {
%>
<script>
    alert("모든 값을 입력해주세요!");
    location.href = "adminRestAdd.html";
</script>
<%
} else {
    // 데이터베이스 연결 및 쿼리 실행 코드...
%>
<script>
    alert("가게 등록이 완료되었습니다!");
    location.href = "adminRestAdd.html";
</script>
<%
    }
%>
</body>
</html>
