<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page language="java" import="java.text.*,java.sql.*" %>
<%@ page language="java" import="java.util.Scanner" %>
<%@ page language="java" import="java.util.*" %>
<%@ page import="com.sun.tools.jconsole.JConsoleContext" %>

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

    String name=request.getParameter("name");
    String birth=request.getParameter("birth");
    String phoneNum=request.getParameter("phoneNum");
    String email=request.getParameter("email");
    String ID=request.getParameter("ID");
    String PW=request.getParameter("PW");

    try{
        sql="Insert Into Customer (customer_id,name,login_id,login_pw,email,phone,birth) values ('','"+name+"','"+ID+"','"+PW+"','"+email+"','"+phoneNum+"','"+birth+"')";
        out.println(sql);
        stmt.executeUpdate(sql);
        out.println("<script>alert('회원가입이 완료되었습니다.'); location.href='main.html';</script>");

    }
    catch(Exception e){
        out.println("error");
    }


%>
