<%@ page language="java" contentType="text/html; charset=EUC-KR"
         pageEncoding="EUC-KR"%>
<%@ page language="java" import="java.text.*,java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>������ ����</title>
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
    alert("��� ���� �Է����ּ���!");
    location.href = "adminRestAdd.html";
</script>
<%
} else {
    // �����ͺ��̽� ���� �� ���� ���� �ڵ�...
%>
<script>
    alert("���� ����� �Ϸ�Ǿ����ϴ�!");
    location.href = "adminRestAdd.html";
</script>
<%
    }
%>
</body>
</html>
