<%@ page language="java" contentType="text/html; charset=EUC-KR"
		 pageEncoding="EUC-KR"%>
<%@ page language="java" import="java.text.*,java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="EUC-KR">
	<title>������ ����</title>
	<script>
		// �Լ� ����
		function sendToAdminPage(rest_name, adminPw) {
			sessionStorage.setItem('rest_name', rest_name); // rest_name ����
			location.href = 'adminPage.html'; // ������ ���𷺼�
		}

		function sendToAdminPwCheck(adminPw){
			sessionStorage.setItem('adminPw', adminPw); // adminPw ����
			location.href = 'adminPwCheck1.html';
		}
	</script>
</head>
<body>
<%
	String adminId = request.getParameter("adminId");
	String adminPw = request.getParameter("adminPw");

	if (adminId.equals("1") && adminPw.equals("1")){
		String manage_id = "123"; // �Ŵ��� ���̵� ������ �ֱ�
		// �Ŵ��� ���̵� �־ ������� ��ȸ ������
		String rest_name = "���ٿ�н�";
		out.println("<script>sendToAdminPage('"+ rest_name +"');</script>"); // JavaScript �Լ� ȣ��
	}
	else {
		out.println("<script type=\"text/javascript\">");
		out.println("alert('�α��� ����!');");
		out.println("location='loginAdmin.html';");
		out.println("</script>");
	}
%>

</body>
</html>
