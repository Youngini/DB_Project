--Type 1
--1)
SELECT restaurant_name
FROM Restaurant
WHERE restaurant_name LIKE '%짬뽕%';
-- rerstaurant_name에 짬뽕이 포함된 restaurant의 이름을 찾아라

--2)
SELECT restaurant_name, phone, open_time, total_party_size, restaurant_address
FROM Restaurant
WHERE total_party_size >= 80;
-- total_party_size가 80 이상인 restaurant의 이름, 전화번호, 오픈시간, 총 테이블 수, 주소를 찾아라

--Type 2
--1)
SELECT b.restaurant_name, a.star_rating, a.review, a.review_date
FROM Reservation a, Restaurant b
WHERE a.rv_restaurant_id = b.restaurant_id
AND a.star_rating >= 4;
-- Reservation 테이블과 Restaurant 테이블을 조인하여 star_rating이 4 이상인 restaurant의 이름, star_rating, review, review_date를 찾아라

--2)
SELECT a.restaurant_name,b.menu_item_name, b.description, b.price
FROM Restaurant a, Menu b
WHERE a.restaurant_id = b.m_restaurant_id
AND a.rt_category_id='CT001'
AND price<=10000;
-- Restaurant 테이블과 Menu 테이블을 조인하여 카테고리가 'CT001'이고 가격이 10000원 이하인 restaurant 당 menu의 이름, 설명, 가격을 찾아라

--3) 로그인기능 (추가)
SELECT c.customer_id
FROM customer c
WHERE login_id = 'geymh0c'
AND login_pw='bg0hE*R7niz~H';

--4) 메뉴 검색 (추가)
SELECT restaurant_name, menu_item_name
FROM restaurant, menu
WHERE menu_item_name LIKE '%돼지갈비%'
AND restaurant_id = m_restaurant_id;

--Type 3
--1)
SELECT b.restaurant_name, COUNT (*) AS menu_num
FROM Menu a, Restaurant b
WHERE a.m_restaurant_id = b.restaurant_id
AND b.rt_category_id='CT003'
AND b.total_party_size>70
GROUP BY b.restaurant_name;
-- Restaurant 테이블과 Menu 테이블을 조인하여 카테고리가 'CT003'이고 total_party_size가 70 이상인 restaurant 당 menu의 개수를 찾아라

--2)
SELECT b.restaurant_name, a.menu_item_name, MAX(a.price) AS Max_price
FROM Menu a, Restaurant b
WHERE a.m_restaurant_id = b.restaurant_id
AND b.rt_category_id='CT004'
GROUP BY b.restaurant_name,a.menu_item_name;
-- Restaurant 테이블과 Menu 테이블을 조인하여 카테고리가 'CT004'인 restaurant 당 menu의 가장 비싼 가격을 찾아라

--Type 4
--1)
SELECT b.customer_id, b.name, a.reservation_date, c.restaurant_name
FROM Reservation a, Customer b, Restaurant c
WHERE c.restaurant_id = a.rv_restaurant_id
AND a.rv_customer_id = b.customer_id
AND a.status IN
(SELECT status
FROM Reservation a
WHERE status = 1);
-- Reservation 테이블과 Customer 테이블, Restaurant 테이블을 조인하여 status가 1인 reservation의 customer_id, name, reservation_date, restaurant_name을 찾아라

--2)
SELECT b.restaurant_name, a.star_rating, a.review, a.party_size
FROM Reservation a, Restaurant b
WHERE a.rv_restaurant_id = b.restaurant_id
AND a.star_rating >= ALL(select c.star_rating from Reservation c where c.star_rating is not null);
-- Reservation 테이블과 Restaurant 테이블을 조인하여 star_rating이 가장 높은 restaurant의 name, star_rating, review, party_size를 찾아라

-- Type5 
--1)
SELECT restaurant_name
FROM restaurant
WHERE EXISTS(
   SELECT 1
   FROM menu m
   WHERE m.menu_item_name LIKE'대게%'
   AND m.m_restaurant_id = restaurant_id
);
-- menu 테이블에서 menu_item_name에 '대게'가 포함된 레코드가 있는 restaurant 이름을 찾아라

--2)
SELECT m.name
FROM manager m
WHERE EXISTS(
   SELECT 1
   FROM restaurant rt
   WHERE rt.restaurant_address LIKE('대구%') or rt.restaurant_address LIKE('제주%')
   AND rt.rt_manager_id = m.manager_id
)
AND m.birth BETWEEN TO_DATE('1990-01-01','YYYY-MM-DD') AND TO_DATE('1999-12-31','YYYY-MM-DD');
-- restaurant 테이블에서 restaurant_address에 '대구' 또는 '제주'가 포함된 레코드가 있는 manager의 이름을 찾아라

-- Type 6
-- 1)
SELECT c.name as customer_name, c.phone as customer_phone, rt.restaurant_name
FROM customer c, restaurant rt, reservation rv
WHERE c.customer_id in (
   select rv_customer_id
   FROM reservation
   where star_rating BETWEEN 4 AND 5
)
AND c.customer_id = rv_customer_id
AND rt.restaurant_id = rv_restaurant_id;
-- Customer 테이블과 Restaurant 테이블, Reservation 테이블을 조인하여 star_rating이 4 이상인  reservation의 customer_id와 일치하는 customer의 이름과 전화번호, restaurant의 이름을 찾아라

-- 2)
SELECT c.category_name, COUNT(*) as in_seoul
FROM category c
JOIN restaurant r ON c.category_id = r.rt_category_id
WHERE r.restaurant_address LIKE '서울%'
AND c.category_id IN ('CT001', 'CT002')
GROUP BY c.category_name;
-- Category 테이블과 Restaurant 테이블을 조인하여 restaurant_address에 '서울'이 포함된 restaurant의 카테고리별 개수를 찾아라

--Type 7
--1)
SELECT category_name, SUM(total_party_size) AS total_size
FROM (
    SELECT c.category_name, r.total_party_size
    FROM Category c
    JOIN Restaurant r ON c.category_id = r.rt_category_id
    WHERE c.category_name IN ('한식', '일식', '중식')
)
GROUP BY category_name
ORDER BY category_name DESC;
-- Category 테이블과 Restaurant 테이블을 조인하여 카테고리가 '한식', '일식', '중식'인 restaurant의 카테고리별 총 수용인원을 카테고리 이름의 역순으로 찾아라

--2)
SELECT category_name, menu_item_name, description, han_max_price
FROM (
    SELECT c.category_name, m.menu_item_name, m.description, MAX(m.price) AS han_max_price
    FROM Category c
    JOIN Restaurant r ON c.category_id = r.rt_category_id
    JOIN Menu m ON r.restaurant_id = m.m_restaurant_id
    WHERE c.category_name IN ('한식', '일식', '양식')
    GROUP BY c.category_name, m.menu_item_name, m.description
)
ORDER BY category_name DESC;
-- Category 테이블과 Restaurant 테이블, Menu 테이블을 조인하여 카테고리가 '한식', '일식', '양식'인 restaurant의 카테고리별 메뉴의 이름, 설명, 가격을 카테고리 이름의 역순으로 찾아라

-- Type 8
-- 1)
SELECT r.special_request, r.party_size,r.reservation_date
FROM Reservation r, Payment p
WHERE r.special_request IS NOT NULL
AND r.reservation_id = p.p_reservation_id
AND p.price >= 100000
ORDER BY r.party_size ASC;
-- Reservation 테이블과 Payment 테이블을 조인하여 special_request가 null이 아니고 결제금액이 100000원 이상인 레코드를 party_size가 작은 순서대로 찾아라

--2)
SELECT c.name, c.email, c.phone, r.star_rating, r.review, p.price
FROM Customer c, Reservation r, Payment p
WHERE c.customer_id = r.rv_customer_id
AND r.reservation_id = p.p_reservation_id
AND star_rating >= 5
ORDER BY price DESC;
-- Customer 테이블과 Reservation 테이블, Payment 테이블을 조인하여 star_rating이 5 이상인 레코드를 결제금액이 큰 순서대로 찾아라

--Type 9
--1)
SELECT c.category_name, COUNT(*) AS restaurant_cnt
FROM Category c, Restaurant r
WHERE c.category_id = r.rt_category_id
AND r.last_order_time <= 21
GROUP BY c.category_name
ORDER BY c.category_name DESC;
-- Category 테이블과 Restaurant 테이블을 조인하여 last_order_time이 21시 이전인 restaurant의 카테고리별 개수를 카테고리 이름의 역순으로 찾아라

--2)
SELECT r.status, COUNT(*) AS method_of_payment_num
FROM Reservation r, Payment p
WHERE r.reservation_id = p.p_reservation_id
AND p.refund_price/p.price >= 0.8
GROUP BY r.status
ORDER BY r.status DESC;
-- Reservation 테이블과 Payment 테이블을 조인하여 환불금액이 결제금액의 80% 이상인 reservation의 status별 개수를 status의 역순으로 찾아라

--3) 카테고리 별 예약 많은 순  (추가)
SELECT restaurant.restaurant_name,category_name, COUNT(reservation.reservation_id) AS 예약수
FROM Restaurant
JOIN category on restaurant.rt_category_id=category.category_id
LEFT JOIN Reservation ON restaurant.restaurant_id = reservation.rv_restaurant_id
where category_name='양식'
GROUP BY restaurant.restaurant_name,category_name
having COUNT(reservation.reservation_id) > 0
ORDER BY 예약수 DESC;

--4) 리뷰 많은 순 정렬 (추가)
SELECT restaurant_id, restaurant_name, count(review)
FROM Restaurant, Reservation
WHERE restaurant_id = rv_restaurant_id
AND review is NOT NULL
Group by restaurant_id, restaurant_name
Order by count(review) DESC;

--Type 10
--1) (수정)
SELECT restaurant_name, total_party_size,restaurant_address, open_time, last_order_time
FROM restaurant
WHERE total_party_size >= 45
MINUS
(SELECT restaurant_name,total_party_size, restaurant_address, open_time, last_order_time
FROM restaurant
WHERE total_party_size > 50)
order by total_party_size asc;
-- a,b 사이 인원으로 레스토랑 찾기: total_party_size가 45 이상인 레코드에서 total_party_size가 50 초과인 레코드를 제외한 restaurant의 이름,수용인원, 주소, 오픈시간, 마지막 주문시간을 수용인원 오름차순으로 찾아라

--2) (수정)
SELECT restaurant_name, star_rating, review, review_date, total_party_size
FROM Reservation a, Restaurant b
WHERE a.star_rating >= 4
AND a.rv_restaurant_id = b.restaurant_id
INTERSECT
SELECT b.restaurant_name, a.star_rating, a.review, a.review_date, total_party_size
FROM Reservation a, Restaurant b
WHERE a.review IS NOT NULL
order by star_rating desc;
-- star_rating이 4 이상인 레코드에서 review가 null이 아닌 restaurant의 이름, star_rating, review, review_date, total_party_size를 star_rating 내림차순으로 찾아라

-- Delete 문 (추가)

--1) customer
DELETE FROM customer
WHERE login_id = 'geymh0c'
AND login_pw= 'bg0hE*R7niz~H'

