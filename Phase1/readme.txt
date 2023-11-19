1. 구상 개요

식당을 예약하기 위해서는 직접 식당에 전화를 하거나 식당의 웹사이트에 접속하여 예약을 해야한다. 하지만, 하나의 웹사이트에서 다양한 식당을 예약할 수 있다면 불필요한 시간을 절약할 수 있다고 생각했다. 다양한 식당 카테고리를 형성하여, 식사 혹은 행사에 적합한 식당을 손쉽게 예약할 수 있고 예약시간을 구체적으로 설정하고 그 시간에 맞춰 메뉴까지 미리 주문할 수 있는 웹사이트를 구상하게 되었다.

2. Entity type, attribute 설명

(1) CUSTOMER
웹사이트에서 예약을 하는 주체
customer_ID를 primary key로 설정하고 db에서 식별. 
이름, 휴대전화, 이메일, login_ID, login_PWD을 attribute로 가짐.

(2) MANAGER
웹사이트에 restaurant을 등록하고 예약을 받는 restaurant관리자.
manager_ID를 primary key로 설정하고 db에서 식별.
이름, 휴대전화, 이메일, login_ID, login_PWD, restaurant_ID을 attribute로 가짐. 한명의 manager가 여러개의 식당을 운영할 수 있으므로 restaurant_ID를 multivalued attribute로 설정.

(3) RESTAURANT
manager가 운영하는 restaurant. Manager가 없으면 restaurant이 존재할 수 없으므로 weak entity로 설정.
각 restaurant을 식별할 수 있는 restaurant_ID를 partial key로 설정.
식당의 이름, 전화번호, 주소, 운영시간, 수용인원을 attribute로 가짐.

(4) MENU
restaurant가 제공하는 menu. restaurant가 없으면 menu가 존재할 수 없으므로 weak entity로 설정.
menu_id를 partial key로 설정. 
menu의 이름, 가격, 설명을 attribute로 가짐.

(5) RESERVATION
customer가 예약하는 정보를 저장.
customer가 없으면 reservation이 존재할 수 없으므로 weak entity로 설정.
reservation_id를 partial key로 설정.
reservation된 식당의 id(restaurant_id), 예약날짜, 예약시간, 예약인원, 예약상태, 요청사항, review을 attribute로 가짐.
review은 composite attribute로 별점, 코멘트, 작성일시를 attribute로 가진다.

(6) CATEGORY
식당의 카테고리. Ex)한식,일식,중식 등등
category_id를 primary key로 설정.
category의 이름을 attribute로 가짐.

(7) PAYMENT
결제 기능을 수행 관리.
결제 내역을 따로 관리하기 위하여 만든 entity.
reservation이 없는 payment가 존재할 수 없으므로 weak entity로 설정
payment_ID를 partial key로 설정.
결제 가격, 지불 방식, 결제 날짜, 환불을 attribute로 가짐.
환불의 composite attribute로는 환불 날짜 및 환불 금액이 존재

3. Relationship 설명

(1) MANAGES
manager가 관리하는 restaurant들을 나타내는 관계
restaurant는 manager에 의존하기 때문에 idenifying relationship이고,
manager가 여러개의 restaurant들을 관리할 수 있어서 1 : m 관계로 나타냄

(2) SERVES
restaurant에 있는 menu들을 나타내는 관계
menu는 restaurant에 의존하기 때문에 idenifying relationship이고,
restaurant에 다양한 menu가 있을 수 있어서 1 : n 관계로 나타냄

(3) INCLUDES
restaurant의 category를 나타내는 관계
restaurant는 하나의 category를 가지고, category 하나엔 다수의 restaurant를 가져서 1 : n 관계로 나타냄

(4) HAS
restaurant이  reservation의 정보를 나타내는 관계
restaurant는 다수의 reservation을 가질 수 있어서 1 : n 관계

(5) RESERVES
Customer의 restaurant 예약을 나타내는 관계
customer은 다수의 restaurant에 예약을 만들 수 있어서 1 : n 관계

(6) ORDERS
Menu entity에서 주문을 하기 위한 관계
하나의 reservation에 다수의 menu가 있을 수 있고, 하나의 메뉴에 다수의 reservation이 존재할 수 있으니 m : n 관계로 나타냄

(7) REQUIRES
reservation에 대한 payment를 나타냄
reservation 1개 당 payment는 한 번 일어나기 때문에 1:1 관계


4. 구현 목표
식당 및 메뉴 예약 시스템을 구축하는 것이 목표이다.
다양한 음식점 중 사용자의 조건에 맞게 검색을 할 수 있고, 조건에 맞는 음식점을 골라 바로 예약 및 메뉴 선정을 하면 더 편의성이 올라갈 것 같아서 고안하게 되었다. 한 플랫폼에서 음식점을 검색하고 또 다른 플랫폼에서 예약을 하는 것 보다는 하나의 플랫폼에서 검색 및 예약이 가능하면 편의성이 올라갈 것이다.


