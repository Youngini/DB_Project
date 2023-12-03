<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%@ page language="java" import="java.text.*,java.sql.*" %>



<!DOCTYPE html>
<html>
<head>
    <meta charset="EUC-KR">
    <title>예약의 민족</title>
    <script>
        function sendToAdminPage(restaurantsJson){
            var restaurants = restaurantsJson; // JSP 스크립트릿 변수를 JavaScript 변수에 할당

            // sessionStorage에 배열을 JSON 문자열로 저장
            sessionStorage.setItem('restaurants', restaurants);
        }
    </script>
    <style>
        body {
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }

        .button-container {
            display: flex;
            flex-direction: column;
            align-items: center;
            gap: 20px;
        }

        button {
            padding: 20px 40px;
            font-size: 18px;
        }
    </style>
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

    String store_name = request.getParameter("store_name");
    String address = request.getParameter("address");
    String phone_number = request.getParameter("phone_number");
    String category = request.getParameter("category");
    String open_time = request.getParameter("open_time");
    String last_order= request.getParameter("last_order");
    String max_reserve = request.getParameter("max_reserve");
    String manager_id = request.getParameter("manager_id");

//    out.println(store_name+address+phone_number+category+open_time+last_order+max_reserve+manager_id);

//    //Insert Into Restaurant (restaurant_id,phone,open_time,last_order_time,total_party_size,restaurant_address,restaurant_name,rt_manager_id,rt_category_id) values ( 'RT00001' ,'063-538-4515' ,10 ,20.5 ,63 ,'전라북도 정읍시 내장산로 941-9 (내장동)' ,'신세계회관' ,'M000544' ,'CT001');
    try {
        sql = "select category_id from category where category_name = '" + category + "'";
        rs = stmt.executeQuery(sql);
        rs.next();
        category = rs.getString("category_id");
        sql = "Insert Into Restaurant (restaurant_id,phone,open_time,last_order_time,total_party_size,restaurant_address,restaurant_name,rt_manager_id,rt_category_id) values " + "('','" + phone_number + "'," + open_time + "," + last_order + "," + max_reserve + ",'" + address + "','" + store_name + "','" + manager_id + "','" + category + "')";
        out.println(sql);
        stmt.executeUpdate(sql);

        sql="select restaurant_name,restaurant_id from restaurant where rt_manager_id = '" + manager_id + "'";
        rs = stmt.executeQuery(sql);
        if (rs.next()) {
            String rest_name = rs.getString("restaurant_name");
            String r_id = rs.getString("restaurant_id");

            StringBuilder jsonBuilder = new StringBuilder();
            jsonBuilder.append("[");
            jsonBuilder.append("{\"").append(r_id).append("\": \"").append(rest_name).append("\"}");

            while (rs.next()) {
                rest_name = rs.getString("restaurant_name");
                r_id = rs.getString("restaurant_id");
                jsonBuilder.append(",{\"").append(r_id).append("\": \"").append(rest_name).append("\"}");
            }

            jsonBuilder.append("]");

            String restaurantsJson = jsonBuilder.toString();
            out.println("<script>sendToAdminPage('" + restaurantsJson + "');</script>");
            //out.println(restaurantsJson);

        }

        out.println("<script>alert('가게 등록에 성공했습니다.'); location='adminPage.html';</script>");

//    sql="select max(restaurant_id), restaurant_name from restaurant where restaurant_name = '" + store_name + "'";
//    rs = stmt.executeQuery(sql);
//    if(rs.next()){
//        String restaurant_id = rs.getString("max(restaurant_id)");
//        String restaurant_name = rs.getString("restaurant_name");
//        out.println("<script>alert('"+restaurant_name+"의 아이디는 "+restaurant_id+" 입니다.'); location.href='adminPage.jsp';</script>");
//    }
//    else{
//        out.println("<script>alert('가게 등록에 실패했습니다.'); location.href='adminPage.jsp';</script>");
//    }
    } catch (SQLException ex) {
        ex.printStackTrace();
    }





%>
</body>
</html>