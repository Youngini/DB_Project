<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page language="java" import="java.text.*,java.sql.*" %>
<%@ page language="java" import="java.util.Scanner" %>
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
    // 중복 확인을 위한 아이디 가져오기
    String ID = request.getParameter("ID");

    // 아이디 중복 확인 로직 수행
    boolean isDuplicate = true;

    try{
        sql="select manager_id\n" +
                "from manager\n" +
                "where login_id='"+ID+"'";
        rs = stmt.executeQuery(sql);
        if(rs.next()){
            isDuplicate = true;
        }
        else{
            isDuplicate = false;
        }

    }
    catch(Exception e){
        e.printStackTrace();
    }





    // 결과를 문자열로 변환하여 응답
    response.setContentType("text/plain");
    response.setCharacterEncoding("UTF-8");
    response.getWriter().write(String.valueOf(isDuplicate));
%>