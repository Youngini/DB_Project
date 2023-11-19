CREATE TABLE Customer(
    customer_id   CHAR(7)      NOT NULL,
    name      VARCHAR(10)   NOT NULL,
    login_id   VARCHAR(10)   NOT NULL,
    login_pw   VARCHAR(20)   NOT NULL,
    email      VARCHAR(30)   NOT NULL,
    phone      CHAR(13)   NOT NULL,
    birth      DATE,
    UNIQUE (login_id),
    UNIQUE(email),
    UNIQUE(phone),
    PRIMARY KEY (customer_id)
);

CREATE TABLE Manager(
    manager_id   CHAR(7)      NOT NULL,
    name      VARCHAR(10)   NOT NULL,
    login_id   VARCHAR(10)   NOT NULL,
    login_pw   VARCHAR(20)   NOT NULL,
    email      VARCHAR(30)   NOT NULL,
    phone      CHAR(13)   NOT NULL,
    birth      DATE,
    UNIQUE (login_id),
    UNIQUE(email),
    UNIQUE(phone),
    PRIMARY KEY (manager_id)
);

CREATE TABLE Category(
    category_id   CHAR(5)      NOT NULL,
    category_name   VARCHAR(20)   NOT NULL,
    UNIQUE (category_name),
    PRIMARY KEY (category_id)
);

CREATE TABLE Restaurant(
    restaurant_id      CHAR(7)      NOT NULL,
    phone         VARCHAR(13)   NOT NULL,
    open_time      DECIMAL(3,1)     NOT NULL,
    last_order_time  DECIMAL(3,1)    NOT NULL,
    total_party_size   INT      NOT NULL,
    restaurant_address   VARCHAR(200)   NOT NULL,
    restaurant_name      VARCHAR(100)   NOT NULL,
    rt_manager_id      CHAR(7)      NOT NULL,
    rt_category_id      CHAR(5),
    UNIQUE (phone),
    UNIQUE (restaurant_address),
    PRIMARY KEY (restaurant_id),
    FOREIGN KEY (rt_manager_id) REFERENCES Manager(manager_id) ON DELETE CASCADE,
    FOREIGN KEY (rt_category_id) REFERENCES Category(category_id) on delete set null
);

create table menu
(
    menu_id char(10) not null,
    menu_item_name varchar(50) not null,
    description varchar(100) ,
    price INT not null,
    m_restaurant_id char(7) not null,
    PRIMARY KEY(menu_id),
    FOREIGN KEY(m_restaurant_id) REFERENCES restaurant(restaurant_id) on delete cascade
);

CREATE TABLE Reservation(
    reservation_id      CHAR(7)      NOT NULL,
    status         INT      NOT NULL,
    special_request      VARCHAR(200),
    party_size      INT      NOT NULL,
    reservation_date   DATE      NOT NULL,
    star_rating      INT,
    review         VARCHAR(200),
    review_date      DATE,
    reservation_time   DECIMAL(3,1)      NOT NULL,
    rv_customer_id      CHAR(7)      NOT NULL,
    rv_restaurant_id   CHAR(7)      NOT NULL,
    PRIMARY KEY (reservation_id),
    FOREIGN KEY (rv_customer_id) REFERENCES Customer(customer_id) on delete cascade,
    FOREIGN KEY (rv_restaurant_id) REFERENCES Restaurant(restaurant_id) 
);

create table orders
(
    o_reservation_id char(7) not null,
    o_menu_id char(10) not null,
    count int not null,
    primary key(o_menu_id, o_reservation_id),
    foreign key(o_menu_id) REFERENCES menu(menu_id),
    foreign key(o_reservation_id) REFERENCES reservation(reservation_id) on delete cascade
    
);

CREATE TABLE Payment(
    payment_id      CHAR(7)      NOT NULL,
    method_of_payment   INT      ,
    refund_date      DATE      ,
    price         INT      NOT NULL,
    payment_date      DATE      , 
    refund_price      INT       ,
    p_reservation_id   CHAR(7)      NOT NULL,
    PRIMARY KEY (payment_id),
    FOREIGN KEY (p_reservation_id) REFERENCES Reservation(reservation_id) on delete cascade
);








