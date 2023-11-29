<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page language="java" import="java.text.*,java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Lab9_result</title>
</head>
<style>
.left-box {
  float: left;
  width: 50%;
}
.right-box {
  float: right;
  width: 50%;
}
</style>
<body>
<% 
	String serverIP = "localhost";
	String strSID = "xe";
	String portNum = "1521";
	String user = "university";
	String pass = "comp322";
	String url = "jdbc:oracle:thin:@"+serverIP+":"+portNum+":"+strSID;
	
	//System.out.println(url);
	//out.println(url);
	Connection conn = null;
	PreparedStatement pstmt;
	ResultSet rs;
	Class.forName("oracle.jdbc.driver.OracleDriver");
	conn = DriverManager.getConnection(url,user,pass);
	
	
	
	
%>


<%
//Q1
	String pname1=request.getParameter("pname1");
	String dnum=request.getParameter("dnum");
	String salary=request.getParameter("salary");
	
	String query=String.format("select fname,lname,salary\n"
					+"from employee e, project p, works_on w\n"
					+"where p.dnum =%s\n"
					+"and p.pname = '%s'\n"
					+"and w.essn=e.ssn\n"
					+"and w.pno=p.pnumber\n"
					+"and e.salary>=%s\n"
					+"order by salary desc",dnum,pname1,salary);
	
	pstmt = conn.prepareStatement(query);
	rs = pstmt.executeQuery(); 
%>
<div class='left-box'>
<h4>------ Q1 Result--------</h4>
<%
	out.println("<table border=\"1\">");
	ResultSetMetaData rsmd = rs.getMetaData();
	int cnt = rsmd.getColumnCount();
	for(int i =1;i<=cnt;i++){
		out.println("<th>"+rsmd.getColumnName(i)+"</th>");
	}
	while(rs.next()){
		out.println("<tr>");
		out.println("<td>"+rs.getString(1)+"</td>");
		out.println("<td>"+rs.getString(2)+"</td>");
		out.println("<td>"+rs.getString(3)+"</td>"); // html 
		
		out.println("</tr>");		
	}
	out.println("</table>");
	
%>



<%
//Q2
	String super_ssn1=request.getParameter("super_ssn1");
	String address=request.getParameter("address");
	
	query=String.format("select dname,ssn,fname,lname\n"
						+"from department, employee\n"
						+"where super_ssn='%s'\n"
						+"and address like '%%%s%%'\n"
						+"and dno=dnumber\n",super_ssn1,address);
	
	pstmt = conn.prepareStatement(query);
	rs = pstmt.executeQuery(); 
%>

<h4>------ Q2 Result--------</h4>
<%
	out.println("<table border=\"1\">");
	rsmd = rs.getMetaData();
	cnt = rsmd.getColumnCount();
	for(int i =1;i<=cnt;i++){
		out.println("<th>"+rsmd.getColumnName(i)+"</th>");
	}
	while(rs.next()){
		out.println("<tr>");
		out.println("<td>"+rs.getString(1)+"</td>");
		out.println("<td>"+rs.getString(2)+"</td>");
		out.println("<td>"+rs.getString(3)+"</td>"); 
		out.println("<td>"+rs.getString(4)+"</td>");// html 
		
		out.println("</tr>");		
	}
	out.println("</table>");
%>

<%
//Q3

	String pname2=request.getParameter("pname2");
	String hours1=request.getParameter("hours1");
	
	query=String.format("select fname,lname,hours\n"
						+"from employee e ,works_on w,project p\n"
						+"where pname='%s'\n"
						+"and p.pnumber=w.pno\n"
						+"and e.ssn=w.essn\n"
						+"and w.hours>=%s\n"
						+"order by hours asc\n",pname2,hours1);
	
	
	pstmt = conn.prepareStatement(query);
	rs = pstmt.executeQuery(); 
%>

<h4>------ Q3 Result--------</h4>
<%
	out.println("<table border=\"1\">");
	rsmd = rs.getMetaData();
	cnt = rsmd.getColumnCount();
	for(int i =1;i<=cnt;i++){
		out.println("<th>"+rsmd.getColumnName(i)+"</th>");
	}
	while(rs.next()){
		out.println("<tr>");
		out.println("<td>"+rs.getString(1)+"</td>");
		out.println("<td>"+rs.getString(2)+"</td>");
		out.println("<td>"+rs.getString(3)+"</td>"); 

		
		out.println("</tr>");		
	}
	out.println("</table>");
	
%>
</div>

<div class='right-box'>

<%
//Q4

	String pname3=request.getParameter("pname3");
	String hours2=request.getParameter("hours2");
	
	query=String.format("select distinct dname,fname,lname\n"
						+"from employee e, department d, project p, works_on w\n"
						+"where p.pname like '%s%%'\n"
						+"and w.pno=p.pnumber\n"
						+"and w.essn=e.ssn\n"
						+"and d.dnumber=e.dno\n"
						+"and w.hours>=%s\n"
						+"order by lname asc\n",pname3,hours2);
	
	pstmt = conn.prepareStatement(query);
	rs = pstmt.executeQuery(); 
%>

<h4>------ Q4 Result--------</h4>
<%
	out.println("<table border=\"1\">");
	rsmd = rs.getMetaData();
	cnt = rsmd.getColumnCount();
	for(int i =1;i<=cnt;i++){
		out.println("<th>"+rsmd.getColumnName(i)+"</th>");
	}
	while(rs.next()){
		out.println("<tr>");
		out.println("<td>"+rs.getString(1)+"</td>");
		out.println("<td>"+rs.getString(2)+"</td>");
		out.println("<td>"+rs.getString(3)+"</td>"); 

		
		out.println("</tr>");		
	}
	out.println("</table>");
	
%>

<%
//Q5

	String super_ssn2=request.getParameter("super_ssn2");
	
	query=String.format("select dname, lname, fname, dependent_name \n"
						+"from employee e, department d, dependent\n"
						+"where super_ssn='%s'\n"
						+"and relationship='Spouse'\n"
						+"and ssn=essn\n"
						+"and e.dno=d.dnumber\n",super_ssn2);

	
	pstmt = conn.prepareStatement(query);
	rs = pstmt.executeQuery(); 
%>

<h4>------ Q5 Result--------</h4>
<%
	out.println("<table border=\"1\">");
	rsmd = rs.getMetaData();
	cnt = rsmd.getColumnCount();
	for(int i =1;i<=cnt;i++){
		out.println("<th>"+rsmd.getColumnName(i)+"</th>");
	}
	while(rs.next()){
		out.println("<tr>");
		out.println("<td>"+rs.getString(1)+"</td>");
		out.println("<td>"+rs.getString(2)+"</td>");
		out.println("<td>"+rs.getString(3)+"</td>"); 
		out.println("<td>"+rs.getString(4)+"</td>"); 


		
		out.println("</tr>");		
	}
	out.println("</table>");
	
%>
</div>
<%
	rs.close();
	pstmt.close();
	conn.close();
%>
</body>
</html>