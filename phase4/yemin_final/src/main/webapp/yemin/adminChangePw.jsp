<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ page language="java" import="java.text.*,java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>������ ����</title>
</head>
<body>
<%
  String newPassword = request.getParameter("newPassword");

  if (newPassword == null || newPassword.isEmpty()) {
%>
<script>
  alert("��� ���� �Է����ּ���!");
  location.href = "adminChangePw.html";
</script>
<%
} else {
  // ��й�ȣ ���� �۾� ���� �ڵ�...
  // �����ͺ��̽� ���� �� ���� ���� �ڵ�...

%>
<script>
  alert("��й�ȣ�� ����Ǿ����ϴ�!");
  location.href = "adminChangePw.html";
</script>
<%
  }
%>
</body>
</html>
