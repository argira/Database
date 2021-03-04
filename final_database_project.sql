--/ CREATE MAIN TABLES FROM ERD MODEL/--


CREATE TABLE caart_Model (
  Model_id NUMBER(20),
  Model_name varchar(255) not null,
  PRIMARY KEY (Model_id)
);
CREATE TABLE caart_Make (
  Make_id NUMBER(20),
  Make_name varchar(255) not null (unique),
  PRIMARY KEY (Make_id)
);

CREATE TABLE caart_ZipCode (
  Zip_code NUMBER(20),
  PRIMARY KEY (Zip_code)
);

CREATE TABLE caart_State (
  State_id CHAR (5),
  State_name varchar(255) NOT NULL,
  PRIMARY KEY (State_id)
);

CREATE TABLE caart_City (
  City_id NUMBER(20),
  City_name varchar(255) UNIQUE,
  PRIMARY KEY (City_id)
);

create table caart_country (
country_id number,
country_name varchar(50),
Primary key (country_id));

CREATE TABLE caart_Payment_Type (
  payment_code CHAR(5),
  payment_type_name varchar(255) not null,
  PRIMARY KEY (payment_code)
);


CREATE TABLE caart_Purchase_location(
  purloc_id number(20),
  Purchase_loc_name varchar(200) not null UNIQUE,
  purchase_loc_address  varchar(255)
  State_id number(20),
  City_id number(20),
  Zip_code  number(20),
  PRIMARY KEY (purloc_id),
  FOREIGN KEY (state_id) references caart_state,
  FOREIGN key (city_id) references caart_city,
  FOREIGN KEY (zip_code) references caart_zipcode);


CREATE TABLE caart_Customer (
  customer_id NUMBER(20),
  customer_name varchar(255) not null UNIQUE,
  customer_address varchar(255) not null,
  customer_phone varchar(255),
  State_CODE CHAR(20),
  city_id NUMBER(20),
  Zip_code NUMBER(20),
  COUNTRY_CODE CHAR(10),
  PRIMARY KEY (customer_id),
  FOREIGN KEY (state_id) references caart_state,
  FOREIGN KEY (city_id) references caart_city,
  FOREIGN KEY (zip_code) references caart_zipcode
  FOREIGN KEY (country_CODE) references caart_country
);


CREATE TABLE caart_Sale Type (
  Sales_code NUMBER(20),
  Sale_type_name varchar(255) not null UNIQUE,
  PRIMARY KEY (Sales_code)
);


CREATE TABLE caart_Style_car (
  style_id NUMBER(20),
  make_id NUMBER(20) NOT NULL,
  model_id NUMBER(20) NOT NULL Unique,
  PRIMARY KEY (style_id),
  FOREIGN KEY (make_id) references caart_make,
  FOREIGN KEY (model_id) references caart_model
);

CREATE TABLE caart_CARS (
  Auto_id NUMBER(20) not null,
  Style_id NUMBER(20) not null,
  VinNo VARCHAR(30) not null UNIQUE,
  Year NUMBER(4) not null,
  State/Plate varchar(50) not null,
   PRIMARY KEY (Auto_id),
  FOREIGN KEY (style_id) references caart_style_car
);


create table caart_inventory(
inventory_id number(20), auto_id number(20) not null, purchasedate date not null, purchase_cost number(20) not null, purloc_id number(20),
primary key (inventory_id),
foreign key (purloc_id) references caart_purchase_location,
foreign key (auto_id) references caart_cars);


CREATE TABLE caart_Sales (
  Sales_id NUMBER(20),
  customer_id NUMBER(20) not null,
  auto_id NUMBER(20) not null,
  sales_date DATE not null,
  sales_price NUMBER(20) not null,
  sales_code NUMBER(20) not null,
  PRIMARY KEY (Sales_id),
  FOREIGN KEY (customer_id) references caart_customer,
  FOREIGN KEY (auto_id) references caart_cars,
  FOREIGN KEY (sales_code) references caart_sales
);

CREATE TABLE caart_Payments (
  payment_id NUMBER(20),
  payment_code NUMBER(20) not null,
  sale_id NUMBER(20) not null,
  payment_amount NUMBER(20) not null,
  payment_date DATE not null,
  balance NUMBER(20) not null,
  PRIMARY KEY (payment_id),
  FOREIGN KEY (sale_id) references caart_sales,
  FOREIGN KEY (PAYMENT_CODE) REFERENCES CAART_PAYMENT_TYPE


--/Caart autostatus, sale type and payment type codes are to be predetermined/--
--/and significant when seen on any table/--

INSERT INTO CAART_COUNTRY VALUES('US','UNITED STATES');
INSERT INTO CAART_COUNTRY VALUES('GT','GUATEMALA');

INSERT INTO CAART_AUTOSTATUS VALUES ('tun','Tuning','Requires tuning');
INSERT INTO CAART_AUTOSTATUS VALUES ('ok','Ready','no repair or tunning needed');

INSERT INTO CAART_PAYMENT_TYPE VALUES ('DP','DOWN PAYMENT');
INSERT INTO CAART_PAYMENT_TYPE VALUES ('FP','FULL PAYMENT');
INSERT INTO CAART_PAYMENT_TYPE VALUES ('MP','MONTHLY PAYMENT');

INSERT INTO CAART_SALE_TYPE VALUES('F','FULL');
INSERT INTO CAART_SALE_TYPE VALUES('C','CREDIT');
INSERT INTO CAART_SALE_TYPE VALUES('T','TRADE-IN');

--/State also needs to be predetermined, code to be the state abbreviation--/
--/and we will populate the table in advance/--

INSERT INTO CAART_STATE VALUES('AL','ALABAMA');
INSERT INTO CAART_STATE VALUES('AK','ALASKA');
INSERT INTO CAART_STATE VALUES('AZ','ARIZONA');
INSERT INTO CAART_STATE VALUES('CA','CALIFORNIA');
INSERT INTO CAART_STATE VALUES('CO','COLORADO');
INSERT INTO CAART_STATE VALUES('CT','CONNECTICUT');
INSERT INTO CAART_STATE VALUES('DE','DELAWARE');
INSERT INTO CAART_STATE VALUES('FL','FLORIDA');
INSERT INTO CAART_STATE VALUES('GA','GEORGIA');
INSERT INTO CAART_STATE VALUES('HI','HAWAII');
INSERT INTO CAART_STATE VALUES('ID','IDAHO');
INSERT INTO CAART_STATE VALUES('IL','ILLINOIS');
INSERT INTO CAART_STATE VALUES('IN','INDIANA');
INSERT INTO CAART_STATE VALUES('IA','IOWA');
INSERT INTO CAART_STATE VALUES('KS','KANSAS');
INSERT INTO CAART_STATE VALUES('KY','KENTUCKY');
INSERT INTO CAART_STATE VALUES('LA','LOUISIANA');
INSERT INTO CAART_STATE VALUES('ME','MAINE');
INSERT INTO CAART_STATE VALUES('MD','MARYLAND');
INSERT INTO CAART_STATE VALUES('MA','MASSACHUSETT');
INSERT INTO CAART_STATE VALUES('MI','MICHIGAN');
INSERT INTO CAART_STATE VALUES('MN','MINNESOTA');
INSERT INTO CAART_STATE VALUES('MI','MISSISSIPPI');
INSERT INTO CAART_STATE VALUES('MO','MISSOURI');
INSERT INTO CAART_STATE VALUES('MT','MONTANA');
INSERT INTO CAART_STATE VALUES('NEBRASKA','NE');
INSERT INTO CAART_STATE VALUES('NV','NEVADA');
INSERT INTO CAART_STATE VALUES('NH','NEW HAMPSHIRE');
INSERT INTO CAART_STATE VALUES('NJ','NEW JERSEY');
INSERT INTO CAART_STATE VALUES('NM','NEW MEXICO');
INSERT INTO CAART_STATE VALUES('NY','NEW YORK');
INSERT INTO CAART_STATE VALUES('NC','NORTH CAROLINA');
INSERT INTO CAART_STATE VALUES('NS','NORTH DAKOTA');
INSERT INTO CAART_STATE VALUES('OH','OHIO');
INSERT INTO CAART_STATE VALUES('OK','OKLAHOMA');
INSERT INTO CAART_STATE VALUES('OR','OREGON');
INSERT INTO CAART_STATE VALUES('PA','PENNSYLVANIA');
INSERT INTO CAART_STATE VALUES('RI','RHODE ISLAND');
INSERT INTO CAART_STATE VALUES('SC','SOUTH CAROLINA');
INSERT INTO CAART_STATE VALUES('SD','SOUTH DAKOTA');
INSERT INTO CAART_STATE VALUES('TN','TENNESSEE');
INSERT INTO CAART_STATE VALUES('TX','TEXAS');
INSERT INTO CAART_STATE VALUES('UT','UTAH');
INSERT INTO CAART_STATE VALUES('VT','VERMONT');
INSERT INTO CAART_STATE VALUES('VA','VIRGINIA');
INSERT INTO CAART_STATE VALUES('WA','WASHINGTON');
INSERT INTO CAART_STATE VALUES('WV','WEST VIRGINIA');
INSERT INTO CAART_STATE VALUES('WI','WISCONSIN');
INSERT INTO CAART_STATE VALUES('WY','WYOMING');
INSERT INTO CAART_STATE VALUES('GU','GUAM');
INSERT INTO CAART_STATE VALUES('PR','PUERTO RICO');
INSERT INTO CAART_STATE VALUES('VI','VIRGIN ISLANDS');
INSERT INTO CAART_STATE VALUES('N/A','NOT AVAILABLE');

--/ we create the sequence for the remaining tables--/
--/ to allow for the insertion of values without worrying about the key--/
--/this will require a trigger at the insertion of a row --/



CREATE SEQUENCE CARS_SEQUENCE
START WITH 1
INCREMENT BY 1
CACHE 10;

CREATE SEQUENCE caart_sales_sequence
START WITH 1
INCREMENT BY 1
CACHE 10;

CREATE SEQUENCE CAART_CUSTOMER_SEQUENCE
START WITH 1
INCREMENT BY 1
CACHE 10;

CREATE SEQUENCE INVENTORY_SEQUENCE
START WITH 1
INCREMENT BY 1
CACHE 10;

CREATE SEQUENCE CAART_PAYMENT_SEQUENCE
START WITH 1
INCREMENT BY 1
CACHE 10;

CREATE SEQUENCE STYLE_SEQUENCE
START WITH 1
INCREMENT BY 1
CACHE 10;

CREATE SEQUENCE CITY_SEQUENCE
START WITH 1
INCREMENT BY 1
CACHE 10;

CREATE SEQUENCE MODEL_SEQUENCE
START WITH 1
INCREMENT BY 1
CACHE 10;

CREATE SEQUENCE MAKE_SEQUENCE
START WITH 1
INCREMENT BY 1
CACHE 10;

CREATE SEQUENCE PURLOC_SEQUENCE
START WITH 1
INCREMENT BY 1
CACHE 10;

--//CREATING THE TRIGGERS FOR THE SEQUENCES//--

CREATE OR REPLACE TRIGGER car_sales_ONINSERT
  BEFORE INSERT ON CAART_sales
  FOR EACH ROW
BEGIN
  SELECT caart_sales_SEQUENCE.nextval
  INTO :new.sales_ID
  FROM dual;
END;

CREATE OR REPLACE TRIGGER CARS_ONINSERT
  BEFORE INSERT ON CAART_CARS
  FOR EACH ROW
BEGIN
  SELECT CARS_SEQUENCE.nextval
  INTO :new.AUTO_ID
  FROM dual;
END;

CREATE OR REPLACE TRIGGER CUSTOMER_ONINSERT
  BEFORE INSERT ON CAART_CUSTOMER
  FOR EACH ROW
BEGIN
  SELECT CAART_CUSTOMER_SEQUENCE.NEXTVAL
  INTO :new.CUSTOMER_ID
  FROM dual;
END;

CREATE OR REPLACE TRIGGER INVENTORY_ONINSERT
  BEFORE INSERT ON CAART_INVENTORY
  FOR EACH ROW
BEGIN
  SELECT INVENTORY_SEQUENCE.NEXTVAL
  INTO :new.INVENTORY_ID
  FROM dual;
END;

CREATE OR REPLACE TRIGGER PAYMENTS_ONINSERT
  BEFORE INSERT ON CAART_PAYMENTS
  FOR EACH ROW
BEGIN
  SELECT CAART_PAYMENT_SEQUENCE.NEXTVAL
  INTO :new.PAYMENT_ID
  FROM dual;
END;

CREATE OR REPLACE TRIGGER STYLE_CAR_ONINSERT
  BEFORE INSERT ON CAART_STYLE_CAR
  FOR EACH ROW
BEGIN
  SELECT STYLE_SEQUENCE.NEXTVAL
  INTO :new.STYLE_ID
  FROM dual;
END;

CREATE OR REPLACE TRIGGER CITY_ONINSERT
  BEFORE INSERT ON CAART_CITY
  FOR EACH ROW
BEGIN
  SELECT CITY_SEQUENCE.NEXTVAL
  INTO :new.CITY_ID
  FROM dual;
END;

CREATE OR REPLACE TRIGGER MODEL_ONINSERT
  BEFORE INSERT ON CAART_MODEL
  FOR EACH ROW
BEGIN
  SELECT MODEL_SEQUENCE.NEXTVAL
  INTO :new.MODEL_ID
  FROM dual;
END;

CREATE OR REPLACE TRIGGER make_oninsert
  BEFORE INSERT ON CAART_MAKE
  FOR EACH ROW
BEGIN
  SELECT MAKE_SEQUENCE.NEXTVAL
  INTO :new.MAKE_ID
  FROM dual;
END;

CREATE OR REPLACE TRIGGER PURLOC_ONINSERT
  BEFORE INSERT ON CAART_PURCHASE_LOCATION
  FOR EACH ROW
BEGIN
  SELECT PURLOC_SEQUENCE.NEXTVAL
  INTO :new.PURLOC_ID
  FROM dual;
END;

commit;

--//INSERT INTO THE CAART_MAKE THE LIST OF MAKES WHICH IS DETERMINED//--

insert into caart_make (MAKE_NAME) values('ACURA');
insert into caart_make (MAKE_NAME) values('AUDI');
insert into caart_make (MAKE_NAME) values('CHEVROLET');
insert into caart_make (MAKE_NAME) values('CHRYSLER');
insert into caart_make (MAKE_NAME) values('DODGE');
insert into caart_make (MAKE_NAME) values('FIAT');
insert into caart_make (MAKE_NAME) values('FORD');
insert into caart_make (MAKE_NAME) values('FOREST RIVER');
insert into caart_make (MAKE_NAME) values('GMC');
insert into caart_make (MAKE_NAME) values('HONDA');
insert into caart_make (MAKE_NAME) values('JAGUAR');
insert into caart_make (MAKE_NAME) values('JEEP');
insert into caart_make (MAKE_NAME) values('MERCEDEZ-BENZ');
insert into caart_make (MAKE_NAME) values('MINI');
insert into caart_make (MAKE_NAME) values('NISSAN');
insert into caart_make (MAKE_NAME) values('RAM');
insert into caart_make (MAKE_NAME) values('SUBARU');
insert into caart_make (MAKE_NAME) values('TOYOTA');
insert into caart_make (MAKE_NAME) values('VOLKSWAGEN');
insert into caart_make (MAKE_NAME) values('YAMAHA');

--//INSERT INTO CAART_MODEL ALL THE MODELS THAT HAVE BEEN SOLD//--

insert into caart_model (model_name) values('300');
insert into caart_model (model_name) values('500');
insert into caart_model (model_name) values('2500');
insert into caart_model (model_name) values('300C');
insert into caart_model (model_name) values('4RUNNER');
insert into caart_model (model_name) values('A4');
insert into caart_model (model_name) values('ACADIA');
insert into caart_model (model_name) values('BAJA');
insert into caart_model (model_name) values('C5500');
insert into caart_model (model_name) values('CALIBER');
insert into caart_model (model_name) values('CAMARO');
insert into caart_model (model_name) values('CHALLENGER');
insert into caart_model (model_name) values('CHARGER');
insert into caart_model (model_name) values('CHARGER SE');
insert into caart_model (model_name) values('CIVIC');
insert into caart_model (model_name) values('CIVIC LX');
insert into caart_model (model_name) values('COMMANDER');
insert into caart_model (model_name) values('COOPER');
insert into caart_model (model_name) values('COROLLA');
insert into caart_model (model_name) values('COROLLA MATRIX');
insert into caart_model (model_name) values('CRUZE');
insert into caart_model (model_name) values('ELEMENT');
insert into caart_model (model_name) values('EQUINOX');
insert into caart_model (model_name) values('ESCAPE');
insert into caart_model (model_name) values('F150');
insert into caart_model (model_name) values('F150 SUPER');
insert into caart_model (model_name) values('F350');
insert into caart_model (model_name) values('FOCUS');
insert into caart_model (model_name) values('FORESTER');
insert into caart_model (model_name) values('GMT-400');
insert into caart_model (model_name) values('GT-R');
insert into caart_model (model_name) values('JETTA');
insert into caart_model (model_name) values('JOURNEY');
insert into caart_model (model_name) values('LEBARON');
insert into caart_model (model_name) values('LIBERTY');
insert into caart_model (model_name) values('MAGNUM R/T');
insert into caart_model (model_name) values('ODYSSEY');
insert into caart_model (model_name) values('OTEHR');
insert into caart_model (model_name) values('PICKUP');
insert into caart_model (model_name) values('PICKUP 1.5');
insert into caart_model (model_name) values('PILOT');
insert into caart_model (model_name) values('PT CRUISER');
insert into caart_model (model_name) values('R');
insert into caart_model (model_name) values('RAM 1500');
insert into caart_model (model_name) values('RAM 2500');
insert into caart_model (model_name) values('RAM 2500S');
insert into caart_model (model_name) values('RAM 3500');
insert into caart_model (model_name) values('RAV4');
insert into caart_model (model_name) values('RSX');
insert into caart_model (model_name) values('SENTRA2.0');
insert into caart_model (model_name) values('SIERRA');
insert into caart_model (model_name) values('SILVERADO');
insert into caart_model (model_name) values('TACOMA');
insert into caart_model (model_name) values('TACOMA ACC');
insert into caart_model (model_name) values('TACOMA XTR');
insert into caart_model (model_name) values('TUNDRA');
insert into caart_model (model_name) values('XJR');
insert into caart_model (model_name) values('XTERRA');
insert into caart_model (model_name) values('YARIS');
insert into caart_model (model_name) values('YZFR3');
insert into caart_model (model_name) values('MAGNUM SE');


--//INSERT INTO THE STYLE CAR THE COMBINATION OF MAKES WITH MODELS, MODEL NEEDS TO BE UNIQUE//--


insert into caart_style_car (MAKE_ID,model_id) values (1,49);
insert into caart_style_car (make_id, model_id) values (2,6);
insert into caart_style_car (make_id, model_id) values (3,9);
insert into caart_style_car (make_id, model_id) values (3,11);
insert into caart_style_car (make_id, model_id) values (3,21);
insert into caart_style_car (make_id, model_id) values (3,23);
insert into caart_style_car (make_id, model_id) values (3,30);
insert into caart_style_car (make_id, model_id) values (3,52);
insert into caart_style_car (make_id, model_id) values (4,1);
insert into caart_style_car (make_id, model_id) values (4,4);
insert into caart_style_car (make_id, model_id) values (4,34);
insert into caart_style_car (make_id, model_id) values (4,42);
insert into caart_style_car (make_id, model_id) values (5,10);
insert into caart_style_car (make_id, model_id) values (5,12);
insert into caart_style_car (make_id, model_id) values (5,13);
insert into caart_style_car (make_id, model_id) values (5,14);
insert into caart_style_car (make_id, model_id) values (5,33);
insert into caart_style_car (make_id, model_id) values (5,36);
insert into caart_style_car (make_id, model_id) values (5,44);
insert into caart_style_car (make_id, model_id) values (5,45);
insert into caart_style_car (make_id, model_id) values (5,46);
insert into caart_style_car (make_id, model_id) values (5,47);
insert into caart_style_car (make_id, model_id) values (5,61);
insert into caart_style_car (make_id, model_id) values (6,2);
insert into caart_style_car (make_id, model_id) values (7,24);
insert into caart_style_car (make_id, model_id) values (7,25);
insert into caart_style_car (make_id, model_id) values (7,26);
insert into caart_style_car (make_id, model_id) values (7,27);
insert into caart_style_car (make_id, model_id) values (7,28);
insert into caart_style_car (make_id, model_id) values (8,38);
insert into caart_style_car (make_id, model_id) values (9,7);
insert into caart_style_car (make_id, model_id) values (9,51);
insert into caart_style_car (make_id, model_id) values (10,15);
insert into caart_style_car (make_id, model_id) values (10,16);
insert into caart_style_car (make_id, model_id) values (10,22);
insert into caart_style_car (make_id, model_id) values (10,37);
insert into caart_style_car (make_id, model_id) values (10,41);
insert into caart_style_car (make_id, model_id) values (11,57);
insert into caart_style_car (make_id, model_id) values (12,17);
insert into caart_style_car (make_id, model_id) values (12,35);
insert into caart_style_car (make_id, model_id) values (13,43);
insert into caart_style_car (make_id, model_id) values (14,18);
insert into caart_style_car (make_id, model_id) values (15,50);
insert into caart_style_car (make_id, model_id) values (15,58);
insert into caart_style_car (make_id, model_id) values (15,31);
insert into caart_style_car (make_id, model_id) values (16,3);
insert into caart_style_car (make_id, model_id) values (17,8);
insert into caart_style_car (make_id, model_id) values (17,29);
insert into caart_style_car (make_id, model_id) values (18,5);
insert into caart_style_car (make_id, model_id) values (18,19);
insert into caart_style_car (make_id, model_id) values (18,20);
insert into caart_style_car (make_id, model_id) values (18,39);
insert into caart_style_car (make_id, model_id) values (18,40);
insert into caart_style_car (make_id, model_id) values (18,48);
insert into caart_style_car (make_id, model_id) values (18,53);
insert into caart_style_car (make_id, model_id) values (18,54);
insert into caart_style_car (make_id, model_id) values (18,55);
insert into caart_style_car (make_id, model_id) values (18,56);
insert into caart_style_car (make_id, model_id) values (18,59);
insert into caart_style_car (make_id, model_id) values (19,32);
insert into caart_style_car (make_id, model_id) values (20,60);

--//INSERT INTO THE CAART_CITY ALL THE CITIES WHERE CARS HAVE BEEN PURCHASED//--
--//INSERT ALSSO THE CITIES FROM CUSTOMERS ADDRESS//--

INSERT INTO CAART_CITY(city_name) VALUES ('MERIDIAN');
INSERT INTO CAART_CITY(city_name) VALUES ('DAYTON');
INSERT INTO CAART_CITY(city_name) VALUES ('EUGENE');
INSERT INTO CAART_CITY(city_name) VALUES ('FONTANA');
INSERT INTO CAART_CITY(city_name) VALUES ('LOS ANGELES');
INSERT INTO CAART_CITY(city_name) VALUES ('PORTLAND');
INSERT INTO CAART_CITY(city_name) VALUES ('PUYALLUP');
INSERT INTO CAART_CITY(city_name) VALUES ('SPOKANE VALLEY');
INSERT INTO CAART_CITY(city_name) VALUES ('BAKERSFIELD');
INSERT INTO CAART_CITY(city_name) VALUES ('COLORADO SPRINGS');
INSERT INTO CAART_CITY(city_name) VALUES ('LITTLETON');
INSERT INTO CAART_CITY(city_name) VALUES ('ARLINGTON');
INSERT INTO CAART_CITY(city_name) VALUES ('WOODBURN');
INSERT INTO CAART_CITY(CITY_NAME) VALUES ('SALEM');
insert into caart_city(city_name)values('KEIZER');
insert into caart_city(city_name)values('ALBANY');
insert into caart_city(city_name)values('MCMINNVILLE');
insert into caart_city(city_name)values('QUETZALTENANGO');
insert into caart_city(city_name)values('PHOENIX');
insert into caart_city(city_name)values('SCIO');
insert into caart_city(city_name)values('LYONS');
insert into caart_city(city_name)values('CANBY');
insert into caart_city(city_name)values('HUEHUETENANGO');
INSERT INTO CAART_CITY(CITY_NAME)VALUES('NOT AVAILABLE');

--// WILL INSERT ALL THE ZIPCODES FOR BOTH PURCHASED LOCATIONS AND CUSTOMERS//--

INSERT INTO CAART_ZIPCODE VALUES (83642);
INSERT INTO CAART_ZIPCODE VALUES (45417);
INSERT INTO CAART_ZIPCODE VALUES (97402);
INSERT INTO CAART_ZIPCODE VALUES (92335);
INSERT INTO CAART_ZIPCODE VALUES (91605);
INSERT INTO CAART_ZIPCODE VALUES (97230);
INSERT INTO CAART_ZIPCODE VALUES (97217);
INSERT INTO CAART_ZIPCODE VALUES (98374);
INSERT INTO CAART_ZIPCODE VALUES (99216);
INSERT INTO CAART_ZIPCODE VALUES (93307);
INSERT INTO CAART_ZIPCODE VALUES (90001);
INSERT INTO CAART_ZIPCODE VALUES (80907);
INSERT INTO CAART_ZIPCODE VALUES (80125);
INSERT INTO CAART_ZIPCODE VALUES (97218);
INSERT INTO CAART_ZIPCODE VALUES (98223);
INSERT INTO CAART_ZIPCODE VALUES (97071);
INSERT INTO CAART_ZIPCODE VALUES (97305);
INSERT INTO CAART_ZIPCODE VALUES (97301);
INSERT INTO CAART_ZIPCODE VALUES (99999);
INSERT INTO CAART_ZIPCODE VALUES (97266);
INSERT INTO CAART_ZIPCODE VALUES (97304);
INSERT INTO CAART_ZIPCODE VALUES (97303);
INSERT INTO CAART_ZIPCODE VALUES (97266);
INSERT INTO CAART_ZIPCODE VALUES (97322);
INSERT INTO CAART_ZIPCODE VALUES (85023);
INSERT INTO CAART_ZIPCODE VALUES (97128);
INSERT INTO CAART_ZIPCODE VALUES (97358);
INSERT INTO CAART_ZIPCODE VALUES (97013);
INSERT INTO CAART_ZIPCODE VALUES (97317);
INSERT INTO CAART_ZIPCODE VALUES (97374);


--//SINCE PURCHASING LOCATIONS ARE JUST A FEW, WE WILL ENTER NOW THE PURCHASING LOCATIONS--//

INSERT INTO CAART_PURCHASE_LOCATION(PURCHASE_LOC_NAME,PURCHASE_LOC_ADDRESS,STATE_ID,CITY_ID,ZIP_CODE)
VALUES ('iaai-Boise','1881 W Marcon LN','ID',1,83642);
INSERT INTO CAART_PURCHASE_LOCATION(PURCHASE_LOC_NAME,PURCHASE_LOC_ADDRESS,STATE_ID,CITY_ID,ZIP_CODE)
VALUES ('iaai-Dayton','400 Cherokee Drve','OH',3,45417);
INSERT INTO CAART_PURCHASE_LOCATION(PURCHASE_LOC_NAME,PURCHASE_LOC_ADDRESS,STATE_ID,CITY_ID,ZIP_CODE)
VALUES ('iaai-Eugene','1000 Bethel Drive','OR',4,97402);
INSERT INTO CAART_PURCHASE_LOCATION(PURCHASE_LOC_NAME,PURCHASE_LOC_ADDRESS,STATE_ID,CITY_ID,ZIP_CODE)
VALUES ('iaai-Fontana','13901 San Berdardino Avenue','CA',5,92335);
INSERT INTO CAART_PURCHASE_LOCATION(PURCHASE_LOC_NAME,PURCHASE_LOC_ADDRESS,STATE_ID,CITY_ID,ZIP_CODE)
VALUES ('IAAI-North Hollywood','7245 Laurel Canyon Blvd.','CA',6,91605);
INSERT INTO CAART_PURCHASE_LOCATION(PURCHASE_LOC_NAME,PURCHASE_LOC_ADDRESS,STATE_ID,CITY_ID,ZIP_CODE)
VALUES ('IAAI-Portland','4415 NE 158th Avenue','OR',7,97230);
INSERT INTO CAART_PURCHASE_LOCATION(PURCHASE_LOC_NAME,PURCHASE_LOC_ADDRESS,STATE_ID,CITY_ID,ZIP_CODE)
VALUES ('IAAI-Portland West','10498 Vancouver Way','OR',7,97217);
INSERT INTO CAART_PURCHASE_LOCATION(PURCHASE_LOC_NAME,PURCHASE_LOC_ADDRESS,STATE_ID,CITY_ID,ZIP_CODE)
VALUES ('IAAI-Seattle','15801 110th Ave E','WA',8,98374);
INSERT INTO CAART_PURCHASE_LOCATION(PURCHASE_LOC_NAME,PURCHASE_LOC_ADDRESS,STATE_ID,CITY_ID,ZIP_CODE)
VALUES ('IAAI-Spokane','3520 N Tschirley Rd','WA',9,99216);
INSERT INTO CAART_PURCHASE_LOCATION(PURCHASE_LOC_NAME,PURCHASE_LOC_ADDRESS,STATE_ID,CITY_ID,ZIP_CODE)
VALUES ('Copart-BAKERSFIELD','2216 COY AVENUE','CA',10,93307);
INSERT INTO CAART_PURCHASE_LOCATION(PURCHASE_LOC_NAME,PURCHASE_LOC_ADDRESS,STATE_ID,CITY_ID,ZIP_CODE)
VALUES ('Copart - LOS ANGELES','8423 SOUTH ALAMEDA','CA',6,90001);
INSERT INTO CAART_PURCHASE_LOCATION(PURCHASE_LOC_NAME,PURCHASE_LOC_ADDRESS,STATE_ID,CITY_ID,ZIP_CODE)
VALUES ('Copart - COLORADO SPRINGS','3701 N. NEVADA AVE','CO',11,80907);
INSERT INTO CAART_PURCHASE_LOCATION(PURCHASE_LOC_NAME,PURCHASE_LOC_ADDRESS,STATE_ID,CITY_ID,ZIP_CODE)
VALUES ('Copart - DENVER SOUTH','8300 BLAKELAND DRIVE','CO',12,80125);
INSERT INTO CAART_PURCHASE_LOCATION(PURCHASE_LOC_NAME,PURCHASE_LOC_ADDRESS,STATE_ID,CITY_ID,ZIP_CODE)
VALUES ('Copart - EUGENE','29815 ENID ROAD EAST','OR',4,97402);
INSERT INTO CAART_PURCHASE_LOCATION(PURCHASE_LOC_NAME,PURCHASE_LOC_ADDRESS,STATE_ID,CITY_ID,ZIP_CODE)
VALUES ('copart - PORTLAND NORTH','6900 N.E. CORNFOOT DRIVE','OR',7,97218);
INSERT INTO CAART_PURCHASE_LOCATION(PURCHASE_LOC_NAME,PURCHASE_LOC_ADDRESS,STATE_ID,CITY_ID,ZIP_CODE)
VALUES ('Copart - NORTH SEATTLE','16701 51ST AVE NE','WA',13,98223);
INSERT INTO CAART_PURCHASE_LOCATION(PURCHASE_LOC_NAME,PURCHASE_LOC_ADDRESS,STATE_ID,CITY_ID,ZIP_CODE)
VALUES ('Copart - Portland South','2885 NATIONAL WAY','OR',14,97071);
INSERT INTO CAART_PURCHASE_LOCATION(PURCHASE_LOC_NAME,PURCHASE_LOC_ADDRESS,STATE_ID,CITY_ID,ZIP_CODE)
VALUES ('CUSTOMER TRADE-IN','NO ADDRESS','OR',15,97305);



--// CREATE A PROCEDURE TO ENTER ALL THE CARS INTO THE DATABASE //--
--// THIS IS ONE OF THE MAIN TRANSACTION TABLES AND TO TYPE ALL THE CARS WILL TAKE A LONG TIME//--

CREATE OR REPLACE PROCEDURE addCAR( -- ADD A CAR TO THE CAR TABLE)
   p_STYLEID IN NUMBER:=0, -- THE STYLE ID
   p_VINNO IN VARCHAR2:=0, -- The VIN No
   p_auto_year IN NUMBER:=0, --The model year of the car
   p_plate IN VARCHAR2:='NO PLATE') -- The plate and state number if any
IS -- Required by the syntax, but it doesn�t do anything
BEGIN
   INSERT INTO caart_cars
    (style_id,vinno,auto_year,state_plate)
    VALUES(p_styleid,p_vinno,p_auto_year,p_plate);
END;
/

--// NOW WE EXECUTE THE PROCEDURE TO ENTER THE CARS IN THE CARS TABLE//--
--// FOR THIS TABLE WE HAVE DEFINED VIN TO BE UNIQUE, ALTHOUGH WE ARE NOT USING AS PK//--
--// THIS WILL ALIGN WITH DATA WAREHOUSING PRACTICES//--



--// WE CREATE A PROCEDURE TO ENTER THE CARS INTO THE INVENTORY //--

CREATE OR REPLACE PROCEDURE addinventory( -- ADD A CAR TO THE inventory)
   p_autoid IN NUMBER:=0, -- THE auto ID
   p_purchasedate IN date:=cast('99/99/9999' as date), -- The Purchcase date
   p_cost IN NUMBER:=0, --the amount paid for the car
   p_purlocid IN NUMBER:=0) -- The ID for the purchase location
IS -- Required by the syntax, but it doesn�t do anything
BEGIN
   INSERT INTO caart_inventory
    (auto_id,purchasedate,purchase_cost,purloc_id)
    VALUES(p_autoid,p_purchasedate,p_cost,p_purlocid);
END;
/

--// WE NEED TO ENTER NOW THE CARS WE CREATED INTO THE INVENTORY //--



--// WE CREATE A PROCEDURE TO ALSO ENTER THE CUSTOMER INFORMATION--//

CREATE OR REPLACE PROCEDURE addcustomer( -- ADD A CUSTOMER
   p_name IN varchar2:='not available',
   p_address IN varchar2:='not available', -- The customer address, street and number
   p_phone IN varchar2:='not available', --the customer phone number
   p_cityid IN number:=25, -- The ID for the city
   p_stateid in char:='N/A', -- the id for the state for the customer address
   p_zipcode in number:=99999, -- the zip code for the customer address
   p_country in varchar:='US') -- the country code for the customer address
IS -- Required by the syntax, but it doesn�t do anything
BEGIN
   INSERT INTO caart_customer
    (customer_name,customer_address,customer_phone,CITY_ID, STATE_id,zip_code,country_code)
    VALUES(p_name,p_address,p_phone,p_cityid,p_stateid,p_zipcode,p_country);
END;
/

--// NOW WE RUN THE PROCEDURE TO ENTER THE CUSOTMER DATA //--
--//THIS INFORMATION MUST BE TREATED CAREFULLY, IT IS REAL CUSTOMER DARA AND IT IS CONFIDENTIAL//--



--// NOW WE CREATE A PROCEDURE TO ENTER THE CAR SALES//--

CREATE OR REPLACE PROCEDURE RECORDSALES( -- RECORD A SALE
   p_SALE_CUSTOMERID IN NUMBER:=0, -- The customer that purchased the car
   p_SALE_AUTOID IN NUMBER:=0, -- The auto that was sold
   p_sale_date IN date:=cast('00-jan-9999'as date), --date the car was sold
   p_sale_price IN number:=0, -- The cash price for the car
   p_sale_code in char:='F') -- The sale type code
IS -- Required by the syntax, but it doesn�t do anything
BEGIN
   INSERT INTO caart_sales
    (customer_id,auto_id,sales_date,sales_price,sales_code)
    VALUES(p_sale_customerid,p_sale_autoid,p_sale_date,p_sale_price,p_sale_code);
END;
/

--// AND NOW WE PROCEED TO ENTER THE SALES RECORDS//--


--// CREATE A PROCEDURE TO RECORD PAYMENTS//--

CREATE OR REPLACE PROCEDURE RECORD_PAYMENTS( -- RECORD PAYMENTS
   p_PAYMENT_CODE IN CHAR:='NA', -- Payment type
   p_saleid_pay IN NUMBER:=0, -- the sale transaction id the payment is for
   p_pay_amount IN number:=0, --the payment amount
   p_pay_date IN date:=cast('01-jan-9999'as date), -- The payment date
   p_balance in number:=0) -- remaining balance of the sale after payment
IS -- Required by the syntax, but it doesn�t do anything
BEGIN
   INSERT INTO caart_payments
    (payment_code,sale_id,payment_amount,payment_date,balance)
    VALUES(p_payment_code,p_saleid_pay,p_pay_amount,p_pay_date,p_balance);
END;
/

--// NOW WE ENTER ALL THE PAYMENT RECORDS WE HAVE //--
