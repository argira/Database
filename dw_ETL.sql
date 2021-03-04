CREATE TABLE sales_date AS
  SELECT n AS SALES_DateID,
  TO_DATE('31/12/2015','DD/MM/YYYY') + NUMTODSINTERVAL(n,'day') AS Full_Date,
  TO_CHAR(TO_DATE('31/12/2007','DD/MM/YYYY') + NUMTODSINTERVAL(n,'day'),'DD') AS Days,
  TO_CHAR(TO_DATE('31/12/2007','DD/MM/YYYY') + NUMTODSINTERVAL(n,'day'),'Mon') AS Month_Short,
  TO_CHAR(TO_DATE('31/12/2007','DD/MM/YYYY') + NUMTODSINTERVAL(n,'day'),'MM') AS Month_Num,
  TO_CHAR(TO_DATE('31/12/2007','DD/MM/YYYY') + NUMTODSINTERVAL(n,'day'),'Month') AS Month_Long,
  TO_CHAR(TO_DATE('31/12/2007','DD/MM/YYYY') + NUMTODSINTERVAL(n,'day'),'YYYY') AS Year
  FROM (
  select level n
  from dual
  connect by level <= 3000
  );
  
  CREATE TABLE PUR_date AS
  SELECT n AS DateID,
  TO_DATE('31/12/2015','DD/MM/YYYY') + NUMTODSINTERVAL(n,'day') AS Full_Date,
  TO_CHAR(TO_DATE('31/12/2007','DD/MM/YYYY') + NUMTODSINTERVAL(n,'day'),'DD') AS Days,
  TO_CHAR(TO_DATE('31/12/2007','DD/MM/YYYY') + NUMTODSINTERVAL(n,'day'),'Mon') AS Month_Short,
  TO_CHAR(TO_DATE('31/12/2007','DD/MM/YYYY') + NUMTODSINTERVAL(n,'day'),'MM') AS Month_Num,
  TO_CHAR(TO_DATE('31/12/2007','DD/MM/YYYY') + NUMTODSINTERVAL(n,'day'),'Month') AS Month_Long,
  TO_CHAR(TO_DATE('31/12/2007','DD/MM/YYYY') + NUMTODSINTERVAL(n,'day'),'YYYY') AS Year
  FROM (
  select level n
  from dual
  connect by level <= 3000
  );

CREATE TABLE Purchase_dim (
  purchase_surrogatekey number,
  purchase_id number,
  Purchase_loc_name varchar2(255),
  Purchase_loc_addrs varchar2(255),
  SCD_current_flag int,
  Start_date  date,
  End_date date,
  PRIMARY KEY (purchase_surrogatekey)
);
ALTER TABLE PURCHASE_DIM add PURCHASE_CITY varchar(50);
ALTER TABLE PURCHASE_DIM add PURCHASE_ZIPCODE number;
ALTER TABLE PURCHASE_DIM add PURCHASE_state varchar(50);
select * from purchase_dim;

CREATE TABLE Customer_dim(
  Customer_surrogatekey number,
  Customer_id number,
  Customer_name varchar(255),
  Customer_address varchar(255),
  SCD_current_flag integer,
  Start_date date,
  End_date date,
  PRIMARY KEY(customer_surrogatekey)
);

ALTER TABLE customer_dim add customer_CITY varchar(50);
ALTER TABLE customer_DIM add customer_ZIPCODE number;
ALTER TABLE customer_DIM add customer_state varchar(50); 
ALTER TABLE customer_DIM add customer_country varchar(50);
ALTER TABLE customer_DIM add customer_phone varchar(50);
--ALTER TABLE CUSTOMER_DIM ADD SALE_TYPE CHAR(20);
--ALTER TABLE CUSTOMER_DIM DROP COLUMN SALE_TYPE;
SELECT * FROM CUSTOMER_DIM;
DELETE FROM CUSTOMER_DIM;

CREATE TABLE Auto_dim (
  Auto_id number,
  Make_name varchar(50),
  Model_name varchar(50),
  VIN_Num varchar(100),
  Car_Year varchar (20),
  Auto_plate_state varchar(50),
  PRIMARY KEY (auto_ID)
);

--DROP TABLE AUTO_DIM;
SELECT * FROM AUTO_DIM;


CREATE TABLE Purchases_Fact (
  DATE_ID number,
  auto_id number,
  Purchase_surrogatekey number,
  Purchase_cost number,
  FOREIGN KEY (AUTO_ID) REFERENCES AUTO_DIM,
  FOREIGN KEY (PURCHASE_SURROGATEKEY) REFERENCES PURCHASE_DIM
);

COMMIT;
SELECT * FROM PURCHASES_FACT;


CREATE TABLE Sales_fact (
  SALES_DATE_ID NUMBER,
  auto_id NUMBER,
  Customer_surrogatekey NUMBER,
  Sales_price number,
  Payment_count number,
  Payment_sum number,
  FOREIGN KEY (SALES_DATE_ID) REFERENCES SALES_DATE,
  FOREIGN KEY (AUTO_ID) REFERENCES AUTO_DIM,
  FOREIGN KEY (CUSTOMER_SURROGATEKEY) REFERENCES CUSTOMER_DIM
);

DROP TABLE SALE_DATE;
COMMIT;


DROP SEQUENCE CUSTOMER_DIM_SEQUENCE;
CREATE SEQUENCE CUSTOMER_DIM_SEQUENCE
START WITH 1
INCREMENT BY 1
CACHE 10;

CREATE OR REPLACE TRIGGER CUST_DIM_ONINSERT
  BEFORE INSERT ON CUSTOMER_DIM
  FOR EACH ROW
BEGIN
  SELECT CUSTOMER_DIM_SEQUENCE.nextval
  INTO :new.CUSTOMER_SURROGATEKEY
  FROM dual;
END;


INSERT INTO CUSTOMER_DIM (CUSTOMER_ID, CUSTOMER_NAME, CUSTOMER_ADDRESS,customer_state, customer_city, customer_zipcode,
customer_country,customer_phone,SCD_CURRENT_FLAG,START_DATE,END_DATE)
SELECT  caart_customer.customer_id, caart_customer.customer_name, caart_customer.customer_address,caart_state.state_name,caart_city.city_name,
caart_zipcode.zip_code,caart_country.country_name,CAART_CUSTOMER.CUSTOMER_PHONE,1,CAST('01-AUG-2018'AS DATE),CAST('01-JAN-5000'AS DATE)
FROM CAART_CUSTOMER
join caart_state on caart_state.state_id=caart_customer.state_id
join caart_city on caart_city.city_id=caart_customer.city_id
join caart_zipcode on caart_zipcode.zip_code=caart_customer.zip_code
join caart_country on caart_country.country_code=caart_customer.country_code;

--delete from customer_dim;

COMMIT;


CREATE SEQUENCE PURCHASE_DIM_SEQUENCE
START WITH 1
INCREMENT BY 1
CACHE 10;

CREATE OR REPLACE TRIGGER PUR_DIM_ONINSERT
  BEFORE INSERT ON PURCHASE_DIM
  FOR EACH ROW
BEGIN
  SELECT PURCHASE_DIM_SEQUENCE.nextval
  INTO :new.PURCHASE_SURROGATEKEY
  FROM dual;
END;
--DROP SEQUENCE PURCHASE_DIM_SEQUENCE;

--DELETE FROM purchase_dim;
INSERT INTO PURCHASE_DIM (PURCHASE_ID,PURCHASE_LOC_NAME,PURCHASE_LOC_ADDRS,purchase_state, PURCHASE_CITY, PURCHASE_ZIPCODE,SCD_CURRENT_FLAG,START_DATE,END_DATE)
SELECT  CAART_INVENTORY.INVENTORY_ID,CAART_PURCHASE_LOCATION.PURCHASE_LOC_NAME,CAART_PURCHASE_LOCATION.PURCHASE_LOC_ADDRESS,caart_state.state_name,
caart_city.city_name,caart_zipcode.zip_code,1,CAST('01-AUG-2018'AS DATE),CAST('01-JAN-5000' AS DATE)
FROM CAART_INVENTORY
JOIN CAART_PURCHASE_LOCATION ON CAART_INVENTORY.PURLOC_ID=CAART_PURCHASE_LOCATION.PURLOC_ID
JOIN CAART_STATE ON CAART_STATE.STATE_ID=CAART_PURCHASE_LOCATION.STATE_ID
JOIN CAART_CITY ON CAART_CITY.CITY_ID=CAART_PURCHASE_LOCATION.CITY_ID
JOIN CAART_ZIPCODE ON CAART_ZIPCODE.ZIP_CODE=CAART_PURCHASE_LOCATION.ZIP_CODE
;

--DELETE FROM PURCHASE_DIM;
SELECT * FROM PURCHASE_DIM;
SELECT * FROM AUTO_DIM;



INSERT INTO AUTO_DIM (AUTO_ID,MAKE_NAME,MODEL_NAME,VIN_NUM,CAR_YEAR, AUTO_PLATE_STATE)
SELECT CAART_CARS.AUTO_ID,CAART_MAKE.MAKE_NAME,CAART_MODEL.MODEL_NAME,
CAART_CARS.VINNO,CAART_CARS.AUTO_YEAR,CAART_CARS.STATE_PLATE
FROM CAART_CARS
JOIN CAART_STYLE_CAR ON CAART_STYLE_CAR.STYLE_ID=CAART_CARS.STYLE_ID
JOIN CAART_MAKE ON CAART_MAKE.MAKE_ID=CAART_STYLE_CAR.MAKE_ID
JOIN CAART_MODEL ON CAART_MODEL.MODEL_ID=CAART_STYLE_CAR.MODEL_ID;

SELECT * FROM AUTO_DIM;




DELETE FROM PURCHASE_DIM;
SELECT * FROM PURCHASE_DIM;

SELECT * FROM PURCHASE_DIM;
SELECT * FROM AUTO_DIM;

--/ CREATE THE TRANSITION TABLES FOR PURCHASES FACT /--
create table history_purchase_table (
inventory_id number primary key,
purchasedate date,
auto_id number not null,
purloc_id number,
purchase_cost number,
insert_on date);

create table transition_purchase_table (
purchase_id number primary key,
timeid date,
autoid number not null,
purloc_id number,
purchase_cost number,
insert_on date,
deleted char(1));

INSERT INTO history_purchase_table(INVENTORY_ID,PURCHASEDATE,AUTO_ID,PURLOC_ID,PURCHASE_COST,INSERT_ON)
SELECT INVENTORY_ID, PURCHASEDATE,AUTO_ID,PURLOC_ID,PURCHASE_COST,CAST('12-AUG-2018' AS DATE)
FROM CAART_INVENTORY;


CREATE OR REPLACE TRIGGER inventory_history
AFTER INSERT ON CAART_INVENTORY
FOR EACH ROW
BEGIN
INSERT INTO history_purchase_table(INVENTORY_ID,PURCHASEDATE,AUTO_ID,PURLOC_ID,PURCHASE_COST,INSERT_ON)
VALUES (:NEW.INVENTORY_ID, :NEW.PURCHASEDATE, :NEW.AUTO_ID, :NEW.PURLOC_ID,    
       :NEW.PURCHASE_COST, SYSDATE);
END;
/

--DROP TRIGGER INVENTORY_HISTORY;

MERGE INTO transition_purchase_table des
USING (
SELECT inventory_id   AS purchase_id,
purchasedate         AS timeid,
auto_id               AS autoid,
purloc_id             as purloc_id,
purchase_cost         as purchase_cost,
insert_on
FROM  history_purchase_table s
WHERE NOT EXISTS(
SELECT null
FROM   transition_purchase_table d
WHERE  d.purchase_id = s.inventory_id
AND    d.insert_on = s.insert_on
--        OR (d.insert_on IS NULL
--               AND s.insert_on IS NULL)
--            )
--               ) 
))src
ON (src.purchase_id = des.purchase_id)
WHEN MATCHED THEN UPDATE SET
timeid = src.timeid,
autoid      = src.autoid,
purchase_cost = src.purchase_cost,
insert_on   = src.insert_on

WHEN NOT MATCHED THEN INSERT (des.purchase_id,des.timeid,des.autoid,des.purloc_id,des.purchase_cost,des.insert_on,des.deleted)
VALUES (
src.purchase_id,
src.timeid,
src.autoid,
src.purloc_id,
src.purchase_cost,
src.insert_on,
NULL );

select * from TRANSITION_PURCHASE_TABLE;
select * from HISTORY_PURCHASE_TABLE;

UPDATE transition_purchase_table dest
SET    deleted = 'Y'
WHERE  deleted IS NULL
AND    NOT EXISTS   (
SELECT null
FROM   caart_inventory src
WHERE  src.inventory_id = dest.purchase_id);


INSERT INTO PURCHASE_FACT
SELECT  PUR_DATE.DATE_ID,AUTOID,PURCHASE_DIM.PURCHASE_SURROGATEKEY,PURCHASE_COST
FROM   transition_purchase_table s
JOIN PUR_DATE ON PUR_DATE.FULL_DATE=S.TIMEID
JOIN PURCHASE_DIM ON PURCHASE_DIM.PURCHASE_ID=s.PURCHASE_ID;

commit;
--/ CREATE THE TRANSITION TABLES FOR SALES/--

create table history_sales_table (
sales_id number primary key,
sales_date date,
auto_id number not null,
customer_id number,
sales_price number,
payments_made number,
payments_total number,
balance number,
insert_on date); -- the triger will enter this date when the transaction is inserted, to identify new records

create table transition_sales_table (
sales_id number primary key,
sales_date_id date,
auto_id number not null,
customer_id number,
sales_price number,
payments_made number,
payments_total number,
insert_on date,
deleted char(1)); -- will identify if a record has been deleted

create table payments_summary (
sale_id number, payments_made number, payments_total number);
drop table payments_summary;
insert into payments_summary
select sale_id,count(payment_id),sum(payment_amount)
from caart_payments group by sale_id;

select * from payments_summary;

INSERT INTO history_sales_table(sales_id,sales_date,auto_id,customer_id,sales_price,payments_made,payments_total,insert_on)
SELECT distinct
sales_ID, sales_date,AUTO_ID,customer_ID,sales_price,payments_summary.payments_made,payments_summary.payments_total,
CAST('12-AUG-2018' AS DATE)
FROM CAART_sales
join caart_payments on caart_payments.sale_id=CAART_sales.SALES_ID
join payments_summary on payments_summary.sale_id = caart_sales.sales_id;

select * from HISTORY_SALES_TABLE;

CREATE OR REPLACE TRIGGER sales_history
AFTER INSERT ON CAART_sales
FOR EACH ROW
BEGIN
INSERT INTO history_sales_table(sales_ID,sales_date,AUTO_ID,customer_ID,sales_price,INSERT_ON)
VALUES (:NEW.sales_ID, :NEW.sales_date, :NEW.AUTO_ID, :NEW.customer_ID,    
       :NEW.sales_price,SYSDATE);
END;
/

--Create or replace trigger update_sales_history
--AFTER UPDATE ON CAART_PAYMENTS
--FOR EACH ROW
--BEGIN
--insert into payments_summary
--VALUES (:NEW.sale_id,count(:NEW.payment_id),sum(:NEW.payment_amount)); 
--END;
/
--DROP TRIGGER INVENTORY_HISTORY;

MERGE INTO transition_SALES_table des
USING (
SELECT SALES_id   AS SALES_id,
SALES_DATE        AS SALES_DATE_ID,
auto_id               AS auto_id,
CUSTOMER_id             as CUSTOMER_id,
SALES_PRICE         as SALES_PRICE,
PAYMENTS_MADE      AS PAYMENTS_MADE,
PAYMENTS_TOTAL     AS PAYMENTS_TOTAL,
insert_on
FROM  history_SALES_table s
WHERE NOT EXISTS(
SELECT null
FROM   transition_SALES_table d
WHERE  d.SALES_id = s.SALES_id
AND    d.insert_on = s.insert_on
--        OR (d.insert_on IS NULL
--               AND s.insert_on IS NULL)
--            )
--               ) 
))src
ON (src.SALES_id = des.SALES_id)
WHEN MATCHED THEN UPDATE SET
auto_id      = src.auto_id,
CUSTOMER_ID = src.CUSTOMER_ID,
SALES_PRICE = SRC.SALES_PRICE,
PAYMENTS_MADE = SRC.PAYMENTS_MADE,
PAYMENTS_TOTAL = SRC.PAYMENTS_TOTAL,
insert_on   = src.insert_on

WHEN NOT MATCHED THEN INSERT
VALUES (
src.SALES_id,
src.SALES_DATE_ID,
src.auto_id,
src.CUSTOMER_id,
src.SALES_PRICE,
src.PAYMENTS_MADE,
SRC.PAYMENTS_TOTAL,
SRC.INSERT_ON,
NULL );

select * from TRANSITION_SALES_TABLE;
select * from HISTORY_SALES_TABLE;

UPDATE transition_SALES_table dest
SET    deleted = 'Y'
WHERE  deleted IS NULL
AND    NOT EXISTS   (
SELECT null
FROM   caart_SALES src
WHERE  src.SALES_id = dest.SALES_id);



INSERT INTO SALES_FACT
SELECT  SALES_DATE.SALES_DATEID,AUTO_ID,CUSTOMER_DIM.CUSTOMER_SURROGATEKEY,SALES_PRICE,
PAYMENTS_MADE,PAYMENTS_TOTAL
FROM   transition_sales_table s
JOIN sales_DATE ON sales_DATE.FULL_DATE=S.sales_date_id
JOIN customer_DIM ON customer_DIM.customer_ID=s.customer_ID;

COMMIT;

SELECT * FROM SALES_FACT;
select * from sales_date;
