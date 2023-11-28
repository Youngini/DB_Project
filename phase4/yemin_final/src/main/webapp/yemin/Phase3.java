package phase3;

import java.util.Scanner;
import java.sql.*;

public class Phase3 {
    public static final String URL = "jdbc:oracle:thin:@localhost:1521:xe"; //맥 os 환경에서 작업하여 sid : xe 로 설정

    //public static final String URL = "jdbc:oracle:thin:@localhost:1521:orcl"; //윈도우 환경에서 작업하여 sid : orcl 로 설정


    public static void main(String[] args) {

        Connection conn = null; // Connection object
        Statement stmt = null;	// Statement object
        ResultSet rs ; // ResultSet object
        int count = 0;  // the number of rows counted
        String sql;

        try {
            // Load a JDBC driver for Oracle DBMS
            Class.forName("oracle.jdbc.driver.OracleDriver");
            // Get a Connection object
            System.out.println("Driver Loading: Success!");
        } catch (ClassNotFoundException e) {
            System.err.println("error = " + e.getMessage());
            System.exit(1);
        }

        // Make a connection
        try {
            Scanner login = new Scanner(System.in);
            System.out.print("ID : ");
            String id = login.next();
            System.out.print("PW : ");
            String pw = login.next();
            conn = DriverManager.getConnection(URL, id, pw);
            System.out.println("Oracle Connected.");
        } catch (SQLException ex) {
            ex.printStackTrace();
            System.err.println("Cannot get a connection: " + ex.getLocalizedMessage());
            System.err.println("Cannot get a connection: " + ex.getMessage());
            System.exit(1);
        }

        try {
            stmt = conn.createStatement();
        } catch (SQLException ex) {
            ex.printStackTrace();
        }



        while(true) {
            Scanner scanner = new Scanner(System.in);

            System.out.println("--------------------");
            System.out.println("1. 사용자 로그인(탈퇴 기능 포함)");
            System.out.println("2. 식당 이름 검색");
            System.out.println("3. 인원 수에 따른 식당 검색");
            System.out.println("4. 별점에 따른 식당 검색");
            System.out.println("5. 카테고리와 가격을 통한 레스토랑의 메뉴 정보 검색");
            System.out.println("6. 메뉴 검색");
            System.out.println("7. 카테고리 별 예약 많은 순 정렬");
            System.out.println("8. 리뷰 많은 순 정렬");
            System.out.println("9. 최소 인원, 최대 인원에 맞는 식당 찾기");
            System.out.println("10. 별점이 특정 점수 이상인 모든 review 찾기");
            System.out.println("11.종료");
            System.out.println("--------------------");

            System.out.println("아래에서 번호 입력");
            int num = scanner.nextInt();
            System.out.println("--------------------");
            switch (num) {
                case 1:
                    System.out.println("사용자 로그인(탈퇴 기능 포함)을 선택\n");
                    System.out.print("ID : ");
                    // ID : 'geymh0c'
                    String c_uid = scanner.next();
                    System.out.print("PW : ");
                    // PW : 'bg0hE*R7niz~H';
                    String c_upw = scanner.next();

                    //쿼리문

                    try {
                        sql = "SELECT c.customer_id\n" +
                                "FROM customer c\n" +
                                "WHERE login_id = '" + c_uid + "'\n" +
                                "AND login_pw='" + c_upw + "'";
                        rs = stmt.executeQuery(sql);
                        if(!rs.next()) {
                            System.out.println("ID 또는 PW이 없습니다.\n");
                            break;
                        }
                        else
                        {
                            String c_id = rs.getString("customer_id");
                            System.out.println("로그인 성공");
                            System.out.println("C_ID : " + c_id);
                        }

                    } catch (SQLException e) {
                        e.printStackTrace();
                    }


                    System.out.println("--------------------");
                    System.out.println("1. 사용자 계정 탈퇴");
                    System.out.println("2. 뒤로 돌아가기");
                    int next1 = scanner.nextInt();
                    if (next1 == 1) {
                        System.out.println("계정 탈퇴 선택\n");
                        System.out.println("계정 확인\n");
                        System.out.print("ID : ");
                        // ID : 'geymh0c'
                        String c_uid_check = scanner.next();
                        System.out.print("PW : ");
                        // PW : 'bg0hE*R7niz~H';
                        String c_upw_check = scanner.next();

                        if (c_uid_check.equals(c_uid) && c_upw_check.equals(c_upw)) {
                            System.out.println("사용자 확인 성공\n");

                            //쿼리문
                            try{
                                sql="DELETE FROM customer\n" +
                                        "WHERE login_id = '" + c_uid + "'\n" +
                                        "AND login_pw='" + c_upw + "'";
                                rs=stmt.executeQuery(sql);
                                sql="SELECT c.customer_id\n" +
                                        "FROM customer c\n" +
                                        "WHERE login_id = '" + c_uid + "'\n" +
                                        "AND login_pw='" + c_upw + "'";
                                rs=stmt.executeQuery(sql);
                                if(!rs.next()) {
                                    System.out.println("사용자 탈퇴를 완료했습니다.\n");
                                    break;
                                }
                                else
                                {
                                    System.out.println("사용자 탈퇴를 실패했습니다.\n");
                                    break;
                                }
                            }
                            catch (SQLException e) {
                                e.printStackTrace();
                            }

                            // DELETE FROM customer
                            // WHERE customer_id = 'c_id';
                            // 위와 같은 경우면 'C000001';
                            System.out.println("사용자 탈퇴를 완료했습니다.\n");
                            break;
                        }
                        else {
                            System.out.println("ID와 PW가 불일치합니다.\n");
                            break;
                        }
                    }
                    else if(next1 == 2) {
                    }
                    else {
                        System.out.println("잘못 선택하셨습니다. 다시 선택해주세요.\n");
                    }

                    break;

                case 2:
                    System.out.println("식당 이름 검색 선택");
                    System.out.print("검색할 식당 입력 : ");
                    // 짬뽕
                    String r_name = scanner.next();

                    // 쿼리문
                    try{
                        sql = "SELECT restaurant_name\n" +
                                "FROM Restaurant\n" +
                                "WHERE restaurant_name LIKE '%" + r_name + "%'";
                        rs = stmt.executeQuery(sql);
                        if(!rs.next()) {
                            System.out.println("식당이 없습니다.\n");
                            break;
                        }
                        else
                        {
                            count++;
                            String r_name_result = rs.getString("restaurant_name");
                            System.out.println("식당 이름 : " + r_name_result);

                            while(rs.next()) {
                                r_name_result = rs.getString("restaurant_name");
                                System.out.println("식당 이름 : " + r_name_result);
                                count++;
                            }
                            System.out.println("--------------------");
                            System.out.printf("총 %d개의 식당 검색 완료\n", count);
                            count=0;

                        }

                    } catch (SQLException e) {
                        e.printStackTrace();
                    }


                    break;

                case 3:
                    System.out.println("인원 수에 따른 식당 검색 선택");
                    System.out.print("원하는 인원 수 입력: ");
                    // 80
                    int p_size = scanner.nextInt();

                    // 쿼리문
                    try{
                        sql = "SELECT restaurant_name, phone, open_time, total_party_size, restaurant_address\n" +
                                "FROM Restaurant\n" +
                                "WHERE total_party_size >= " + p_size;
                        rs = stmt.executeQuery(sql);
                        if(!rs.next()) {
                            System.out.println("식당이 없습니다.\n");
                            break;
                        }
                        else
                        {
                            count++;
                            String r_name_result = rs.getString("restaurant_name");
                            String r_phone_result = rs.getString("phone");
                            String r_open_time_result = rs.getString("open_time");
                            String r_total_party_size_result = rs.getString("total_party_size");
                            String r_restaurant_address_result = rs.getString("restaurant_address");
                            System.out.println("--------------------");
                            System.out.println("식당 이름 : " + r_name_result);
                            System.out.println("식당 전화번호 : " + r_phone_result);
                            System.out.println("식당 오픈 시간 : " + r_open_time_result);
                            System.out.println("식당 수용 인원 : " + r_total_party_size_result);
                            System.out.println("식당 주소 : " + r_restaurant_address_result);
                            while(rs.next()) {
                                r_name_result = rs.getString("restaurant_name");
                                r_phone_result = rs.getString("phone");
                                r_open_time_result = rs.getString("open_time");
                                r_total_party_size_result = rs.getString("total_party_size");
                                r_restaurant_address_result = rs.getString("restaurant_address");
                                System.out.println("--------------------");
                                System.out.println("식당 이름 : " + r_name_result);
                                System.out.println("식당 전화번호 : " + r_phone_result);
                                System.out.println("식당 오픈 시간 : " + r_open_time_result);
                                System.out.println("식당 수용 인원 : " + r_total_party_size_result);
                                System.out.println("식당 주소 : " + r_restaurant_address_result);
                                count++;
                            }
                            System.out.println("--------------------");
                            System.out.printf("인원 수가 %d명 이상인 식당 검색 완료\n", p_size);
                            System.out.printf("총 %d개의 식당 검색 완료\n", count);
                            count=0;
                        }

                    } catch (SQLException e) {
                        e.printStackTrace();
                    }



                    break;
                case 4:
                    System.out.println("별점에 따른 식당 검색 선택");
                    System.out.print("별점 선택 : ");
                    // 4
                    int s_rating = scanner.nextInt();

                    // 쿼리문
                    try{
                        sql = "SELECT b.restaurant_name, a.star_rating, a.review, a.review_date\n" +
                                "FROM Reservation a, Restaurant b\n" +
                                "WHERE a.rv_restaurant_id = b.restaurant_id\n" +
                                "AND a.star_rating >= " + s_rating;
                        rs = stmt.executeQuery(sql);
                        if(!rs.next()) {
                            System.out.println("식당이 없습니다.\n");
                            break;
                        }
                        else
                        {
                            count++;
                            String r_name_result = rs.getString("restaurant_name");
                            String r_star_rating_result = rs.getString("star_rating");
                            String r_review_result = rs.getString("review");
                            String r_review_date_result = rs.getString("review_date");
                            System.out.println("--------------------");
                            System.out.println("식당 이름 : " + r_name_result);
                            System.out.println("식당 별점 : " + r_star_rating_result);
                            System.out.println("식당 리뷰 : " + r_review_result);
                            System.out.println("식당 리뷰 날짜 : " + r_review_date_result);
                            while(rs.next()) {
                                r_name_result = rs.getString("restaurant_name");
                                r_star_rating_result = rs.getString("star_rating");
                                r_review_result = rs.getString("review");
                                r_review_date_result = rs.getString("review_date");
                                System.out.println("--------------------");
                                System.out.println("식당 이름 : " + r_name_result);
                                System.out.println("식당 별점 : " + r_star_rating_result);
                                System.out.println("식당 리뷰 : " + r_review_result);
                                System.out.println("식당 리뷰 날짜 : " + r_review_date_result);
                                count++;
                            }
                            System.out.println("--------------------");
                            System.out.printf("별점이 %d점 이상인 식당 검색 성공\n", s_rating);
                            System.out.printf("총 %d개의 식당 검색 완료\n", count);
                            count=0;

                        }

                    } catch (SQLException e) {
                        e.printStackTrace();
                    }



                    break;
                case 5:
                    System.out.println("카테고리와 가격을 통해 레스토랑의 메뉴 정보 검색 선택");
                    System.out.print("카테고리 입력 : ");
                    // 한식
                    String ctg_name = scanner.next();
                    System.out.print("가격 입력 : ");
                    int price = scanner.nextInt();
                    // 20000

                    try{
                        sql = "SELECT a.restaurant_name,b.menu_item_name, b.description, b.price\n" +
                                "FROM Restaurant a, Menu b, Category c\n" +
                                "WHERE a.restaurant_id = b.m_restaurant_id\n" +
                                "AND category_name = '" + ctg_name + "'\n" +
                                "AND a.rt_category_id=c.category_id\n" +
                                "AND price<=" + price;
                        rs = stmt.executeQuery(sql);
                        if(!rs.next()) {
                            System.out.println("식당이 없습니다.\n");
                            break;
                        }
                        else
                        {
                            count++;
                            String r_name_result = rs.getString("restaurant_name");
                            String m_name_result = rs.getString("menu_item_name");
                            String m_description_result = rs.getString("description");
                            String m_price_result = rs.getString("price");
                            System.out.println("--------------------");
                            System.out.println("식당 이름 : " + r_name_result);
                            System.out.println("메뉴 이름 : " + m_name_result);
                            System.out.println("메뉴 설명 : " + m_description_result);
                            System.out.println("메뉴 가격 : " + m_price_result);
                            while(rs.next()) {
                                r_name_result = rs.getString("restaurant_name");
                                m_name_result = rs.getString("menu_item_name");
                                m_description_result = rs.getString("description");
                                m_price_result = rs.getString("price");
                                System.out.println("--------------------");
                                System.out.println("식당 이름 : " + r_name_result);
                                System.out.println("메뉴 이름 : " + m_name_result);
                                System.out.println("메뉴 설명 : " + m_description_result);
                                System.out.println("메뉴 가격 : " + m_price_result);
                                count++;
                            }
                            System.out.println("--------------------");
                            System.out.printf("카테고리가 %s이고, 가격이 %d 이하인 레스토랑의 메뉴 정보 검색 완료\n",ctg_name, price);
                            System.out.printf("총 %d개의 식당 검색 완료\n", count);
                            count=0;

                        }

                    } catch (SQLException e) {
                        e.printStackTrace();
                    }



                    break;
                case 6:
                    System.out.println("메뉴 검색 선택");
                    System.out.print("메뉴 입력 : ");
                    // 돼지갈비
                    String m_i_name = scanner.next();

                    // 쿼리문
                    try{
                        sql="SELECT restaurant_name, menu_item_name\n" +
                                "FROM restaurant, menu\n" +
                                "WHERE menu_item_name LIKE '%" + m_i_name + "%'\n" +
                                "AND restaurant_id = m_restaurant_id";
                        rs = stmt.executeQuery(sql);
                        if(!rs.next()) {
                            System.out.println("식당이 없습니다.\n");
                            break;
                        }
                        else
                        {
                            count++;
                            String r_name_result = rs.getString("restaurant_name");
                            String m_name_result = rs.getString("menu_item_name");
                            System.out.println("--------------------");
                            System.out.println("식당 이름 : " + r_name_result);
                            System.out.println("메뉴 이름 : " + m_name_result);
                            while(rs.next()) {
                                r_name_result = rs.getString("restaurant_name");
                                m_name_result = rs.getString("menu_item_name");
                                System.out.println("--------------------");
                                System.out.println("식당 이름 : " + r_name_result);
                                System.out.println("메뉴 이름 : " + m_name_result);
                                count++;
                            }
                            System.out.println("--------------------");
                            System.out.printf("%s가 있는 식당 검색 완료\n",m_i_name);
                            System.out.printf("총 %d개의 식당 검색 완료\n", count);
                            count=0;

                        }

                    }
                    catch(SQLException e){
                        e.printStackTrace();
                    }



                    break;
                case 7:
                    System.out.println("카테고리 별 예약 많은 순 정렬 선택");
                    System.out.print("카테고리 입력 : ");
                    String category7 = scanner.next();

                    // 쿼리문
                    try{
                        sql="SELECT restaurant.restaurant_name, category_name,COUNT(reservation.reservation_id) AS 예약수\n" +
                                "FROM Restaurant\n" +
                                "JOIN category on restaurant.rt_category_id=category.category_id\n" +
                                "LEFT JOIN Reservation ON restaurant.restaurant_id = reservation.rv_restaurant_id\n" +
                                "where category_name='" + category7 + "'\n" +
                                "GROUP BY restaurant.restaurant_name,category_name\n" +
                                "having COUNT(reservation.reservation_id) > 0\n" +
                                "ORDER BY 예약수 DESC";
                        rs = stmt.executeQuery(sql);
                        if(!rs.next()) {
                            System.out.println("식당이 없습니다.\n");
                            break;
                        }
                        else
                        {
                            count++;
                            String r_name_result = rs.getString("restaurant_name");
                            String r_category_result = rs.getString("category_name");
                            String r_reservation_result = rs.getString("예약수");

                            System.out.println("--------------------");
                            System.out.println("식당 이름 : " + r_name_result);
                            System.out.println("카테고리 : " + r_category_result);
                            System.out.println("예약 수 : " + r_reservation_result);
                            while(rs.next()) {
                                r_name_result = rs.getString("restaurant_name");
                                r_category_result = rs.getString("category_name");
                                r_reservation_result = rs.getString("예약수");
                                System.out.println("--------------------");
                                System.out.println("식당 이름 : " + r_name_result);
                                System.out.println("카테고리 : " + r_category_result);
                                System.out.println("예약 수 : " + r_reservation_result);
                                count++;
                            }
                            System.out.println("--------------------");
                            System.out.printf("%s 카테고리 별 예약 많은 순 정렬 완료\n", category7);
                            System.out.printf("총 %d개의 식당 검색 완료\n", count);
                            count=0;
                        }

                    }
                    catch(SQLException e){
                        e.printStackTrace();
                    }




                    break;
                case 8:
                    System.out.println("리뷰 많은 순 정렬 선택\n");

                    // 쿼리문
                   try{
                          sql="SELECT restaurant.restaurant_name, COUNT(reservation.reservation_id) AS 리뷰수\n" +
                                 "FROM Restaurant\n" +
                                 "JOIN Reservation ON restaurant.restaurant_id = reservation.rv_restaurant_id\n" +
                                 "where review is not null\n" +
                                 "GROUP BY restaurant.restaurant_name\n" +
                                 "ORDER BY 리뷰수 DESC";
                          rs = stmt.executeQuery(sql);
                          if(!rs.next()) {
                            System.out.println("식당이 없습니다.\n");
                            break;
                          }
                          else
                          {
                              count++;
                            String r_name_result = rs.getString("restaurant_name");
                            String r_review_result = rs.getString("리뷰수");
                            System.out.println("--------------------");
                            System.out.println("식당 이름 : " + r_name_result);
                            System.out.println("리뷰 수 : " + r_review_result);
                            while(rs.next()) {
                                 r_name_result = rs.getString("restaurant_name");
                                 r_review_result = rs.getString("리뷰수");
                                 System.out.println("--------------------");
                                 System.out.println("식당 이름 : " + r_name_result);
                                 System.out.println("리뷰 수 : " + r_review_result);
                                    count++;
                            }
                            System.out.println("--------------------");
                            System.out.println("리뷰 많은 순 정렬 완료\n");
                            System.out.printf("총 %d개의 식당 검색 완료\n", count);
                            count=0;

                          }



                   }
                    catch(SQLException e){
                        e.printStackTrace();
                    }



                    break;
                case 9:
                    System.out.println("최소 인원, 최대 인원에 맞는 식당 찾기 선택\n");
                    System.out.print("최소 인원 입력 : ");
                    // 30
                    int first_size = scanner.nextInt();
                    System.out.print("최대 인원 입력 : ");
                    // 45
                    int second_size = scanner.nextInt();
                    if(second_size < first_size) {
                        System.out.println("최소 인원이 최대 인원보다 많습니다!\n");
                        break;
                    }
                    else {
                        // 쿼리문
                        try{
                            sql="SELECT restaurant_name, total_party_size,restaurant_address, open_time, last_order_time\n" +
                                    "FROM restaurant\n" +
                                    "WHERE total_party_size >= " + first_size + "\n" +
                                    "MINUS\n" +
                                    "(SELECT restaurant_name,total_party_size, restaurant_address, open_time, last_order_time\n" +
                                    "FROM restaurant\n" +
                                    "WHERE total_party_size > " + second_size + ")\n" +
                                    "order by total_party_size asc";
                            rs = stmt.executeQuery(sql);
                            if(!rs.next()) {
                                System.out.println("식당이 없습니다.\n");
                                break;
                            }
                            else
                            {
                                count++;
                                String r_name_result = rs.getString("restaurant_name");
                                String r_total_party_size_result = rs.getString("total_party_size");
                                String r_restaurant_address_result = rs.getString("restaurant_address");
                                String r_open_time_result = rs.getString("open_time");
                                String r_last_order_time_result = rs.getString("last_order_time");
                                System.out.println("--------------------");
                                System.out.println("식당 이름 : " + r_name_result);
                                System.out.println("식당 수용 인원 : " + r_total_party_size_result);
                                System.out.println("식당 주소 : " + r_restaurant_address_result);
                                System.out.println("식당 오픈 시간 : " + r_open_time_result);
                                System.out.println("식당 마지막 주문 시간 : " + r_last_order_time_result);
                                while(rs.next()) {
                                    r_name_result = rs.getString("restaurant_name");
                                    r_total_party_size_result = rs.getString("total_party_size");
                                    r_restaurant_address_result = rs.getString("restaurant_address");
                                    r_open_time_result = rs.getString("open_time");
                                    r_last_order_time_result = rs.getString("last_order_time");
                                    System.out.println("--------------------");
                                    System.out.println("식당 이름 : " + r_name_result);
                                    System.out.println("식당 수용 인원 : " + r_total_party_size_result);
                                    System.out.println("식당 주소 : " + r_restaurant_address_result);
                                    System.out.println("식당 오픈 시간 : " + r_open_time_result);
                                    System.out.println("식당 마지막 주문 시간 : " + r_last_order_time_result);
                                    count++;
                                }
                                System.out.println("--------------------");
                                System.out.printf("최소 인원이 %d명, 최대 인원이 %d명인 식당 검색 완료\n", first_size, second_size);
                                System.out.printf("총 %d개의 식당 검색 완료\n", count);
                                count=0;
                            }
                            break;
                        }
                        catch(SQLException e){
                            e.printStackTrace();
                        }

                    }

                case 10:
                    System.out.println("별점이 특정 점수 이상인 모든 review 찾기 선택");
                    System.out.print("별점 입력 : ");
                    // 4
                    int rating10 = scanner.nextInt();
                    if (rating10 > 5) {
                        System.out.println("별점은 5점 이하 입니다!\n");
                        break;
                    }
                    else {
                        // 쿼리문
                        try{
                            sql="SELECT restaurant_name, star_rating, review, review_date, total_party_size\n" +
                                    "FROM Reservation a, Restaurant b\n" +
                                    "WHERE a.star_rating >= " + rating10 + "\n" +
                                    "AND a.rv_restaurant_id = b.restaurant_id\n" +
                                    "INTERSECT\n" +
                                    "SELECT b.restaurant_name, a.star_rating, a.review, a.review_date, total_party_size\n" +
                                    "FROM Reservation a, Restaurant b\n" +
                                    "WHERE a.review IS NOT NULL\n"+
                                    "ORDER BY star_rating desc";
                            rs = stmt.executeQuery(sql);
                            if(!rs.next()) {
                                System.out.println("식당이 없습니다.\n");
                                break;
                            }
                            else
                            {
                                count++;
                                String r_name_result = rs.getString("restaurant_name");
                                String r_star_rating_result = rs.getString("star_rating");
                                String r_review_result = rs.getString("review");
                                String r_review_date_result = rs.getString("review_date");
                                String r_total_party_size_result = rs.getString("total_party_size");
                                System.out.println("--------------------");
                                System.out.println("식당 이름 : " + r_name_result);
                                System.out.println("식당 별점 : " + r_star_rating_result);
                                System.out.println("식당 리뷰 : " + r_review_result);
                                System.out.println("식당 리뷰 날짜 : " + r_review_date_result);
                                System.out.println("식당 수용 인원 : " + r_total_party_size_result);
                                while(rs.next()) {
                                    r_name_result = rs.getString("restaurant_name");
                                    r_star_rating_result = rs.getString("star_rating");
                                    r_review_result = rs.getString("review");
                                    r_review_date_result = rs.getString("review_date");
                                    r_total_party_size_result = rs.getString("total_party_size");
                                    System.out.println("--------------------");
                                    System.out.println("식당 이름 : " + r_name_result);
                                    System.out.println("식당 별점 : " + r_star_rating_result);
                                    System.out.println("식당 리뷰 : " + r_review_result);
                                    System.out.println("식당 리뷰 날짜 : " + r_review_date_result);
                                    System.out.println("식당 수용 인원 : " + r_total_party_size_result);
                                    count++;
                                }
                                System.out.println("--------------------");
                                System.out.printf("별점이 %d점 이상인 모든 review 찾기 완료\n", rating10);
                                System.out.printf("총 %d개의 식당 검색 완료\n", count);
                                count=0;
                            }
                            break;
                        }
                        catch(SQLException e){
                            e.printStackTrace();
                        }


                        System.out.printf("별점이 %d점 이상인 모든 review 찾기 완료\n", rating10);
                        break;
                    }
                case 11:
                    System.out.println("프로그램을 종료합니다.");
                    scanner.close();
                    System.exit(0);
                    break;
                default:
                    System.out.println("잘못된 입력입니다. 번호를 다시 선택해주세요.");
                    break;
            }
        }
    }
}
