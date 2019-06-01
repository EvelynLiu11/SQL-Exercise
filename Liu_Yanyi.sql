/* Assignment 3 Evelyn Liu
October 10, 2018 */

-- Query 1 
select count(*)
from employee;

-- Query 2
select FIRST_NAME, LAST_NAME, TITLE,START_DATE
from employee;

-- Query 3
select FIRST_NAME,LAST_NAME
from employee
where title='Teller'
order by START_DATE;

-- Query 4
select count(*) as "Number of employees at Headquarters"
from employee
where ASSIGNED_BRANCH_ID in
(select branch_id
from branch
where NAME='Headquarters') ;

-- Query 5
select FIRST_NAME,LAST_NAME,TITLE
from employee,branch
where NAME='Headquarters' and BRANCH_ID=ASSIGNED_BRANCH_ID;

-- Query 6
select b.NAME,count(*) as "Number of Employees" 
from branch b,employee e
where e.ASSIGNED_BRANCH_ID=b.BRANCH_ID
group by b.BRANCH_ID;

-- Query 7
select distinct PRODUCT_TYPE_CD
from product;

-- Query 8
select NAME
from product
where name like '%account%';

-- Query 9
select FIRST_NAME,LAST_NAME,BIRTH_DATE
from individual
order by BIRTH_DATE;

-- Query 10
select avg(AVAIL_BALANCE),min(AVAIL_BALANCE),max(AVAIL_BALANCE)
from account;

-- Query 11
select p.NAME, avg(AVAIL_BALANCE),min(AVAIL_BALANCE),max(AVAIL_BALANCE)
from account a,product p
where p.PRODUCT_CD=a.PRODUCT_CD
group by p.NAME;

-- Query 12
select CUST_ID,count(ACCOUNT_ID) as "# of account balance > $1000"
from account
where AVAIL_BALANCE>1000
group by CUST_ID;

-- Query 13
select CUST_ID,count(ACCOUNT_ID) as "# of account balance > $1000", avg(AVAIL_BALANCE)
from account
where AVAIL_BALANCE>1000
group by CUST_ID;

-- Query 14
select CUST_ID,count(ACCOUNT_ID) as "# of account balance > $1000", avg(AVAIL_BALANCE)
from account
group by CUST_ID
having avg(AVAIL_BALANCE)>1000;

-- Query 15
select max(PENDING_BALANCE),OPEN_BRANCH_ID,PRODUCT_CD
from account
group by OPEN_BRANCH_ID,PRODUCT_CD
having max(PENDING_BALANCE)>2000;

-- Query 16
select max(PENDING_BALANCE),b.NAME as "Branch Name",p.NAME as "Product Name"
from account a,branch b,product p
where a.OPEN_BRANCH_ID=b.BRANCH_ID and
a.PRODUCT_CD=p.PRODUCT_CD
group by b.NAME,p.Name
having max(PENDING_BALANCE)>2000;

-- Query 17
select a.ACCOUNT_ID,a.CUST_ID,PRODUCT_CD,a.OPEN_BRANCH_ID
from account a
where AVAIL_BALANCE < (select avg(AVAIL_BALANCE) from account);

-- Query 18
select a.ACCOUNT_ID,i.LAST_NAME,i.FIRST_NAME,p.NAME as "Product Name",b.NAME as "Opening Branch Name"
from account a,product p,individual i,branch b
where AVAIL_BALANCE < (select avg(AVAIL_BALANCE) from account) and
a.OPEN_BRANCH_ID=b.BRANCH_ID and
a.CUST_ID=i.CUST_ID and
a.PRODUCT_CD=p.PRODUCT_CD
order by i.LAST_NAME;

-- Query 19
select LAST_NAME,FIRST_NAME
from individual
where CUST_ID in 
(select a.CUST_ID 
from account a
group by a.CUST_ID
having count(a.ACCOUNT_ID)>2);

-- Query 20
select e.LAST_NAME as "employee LName",e.FIRST_NAME as "employee FName",timestampdiff(year,e.START_DATE,curdate()) as "years with company",s.LAST_NAME as "supervisor LName"
from employee e,employee s
where e.SUPERIOR_EMP_ID = s.EMP_ID
order by s.LAST_NAME;

-- Query 21
select s.LAST_NAME as "Supervisor Last Name", count(e.EMP_ID) as "Number of employees"
from employee e,employee s
where e.SUPERIOR_EMP_ID=s.EMP_ID
group by s.LAST_NAME;

-- Query 22
select *
from account
where STATUS='ACTIVE' and CLOSE_DATE is NULL;

-- Query 23
select *
from account a
where not exists 
(select ac.ACCOUNT_ID 
from acc_transaction ac 
where a.ACCOUNT_ID = ac.ACCOUNT_ID);

-- Query 24
create view view_accounts as
select *
from account a
where exists 
(select ac.ACCOUNT_ID 
from acc_transaction ac 
where a.ACCOUNT_ID = ac.ACCOUNT_ID);

-- Query 25
select PRODUCT_CD,avg(AVAIL_BALANCE),min(AVAIL_BALANCE),max(AVAIL_BALANCE)
from account
where STATUS='ACTIVE' and
PRODUCT_CD ='cd' or PRODUCT_CD='chk' or PRODUCT_CD='mm' or PRODUCT_CD='sav'
group by PRODUCT_CD;