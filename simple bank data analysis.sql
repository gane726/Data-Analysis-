-- Write a query to display the customer number, firstname, customer’s date of birth. 
-- Display in sorted order of date of birth year and within that sort by firstname.
select * from customer;

select custid,fname,dob
from customer
order by year(dob) asc,fname asc;

-- Write a query to display the customer’s number, first name, and middle name. The customer’s who don’t have a middle name, 
-- for them display the last name. Give the alias name as Cust_Name.

select custid,fname,mname,
case when mname is null then ltname else mname end as Cust_Name
from customer;

-- Write a query to display account number, customer’s number, customer’s firstname,lastname,account opening date.

select acc.acnumber,cust.custid,cust.fname,cust.ltname,acc.aod
from account as acc
inner join customer as cust on cust.custid = acc.custid;

-- Write a query to display the number of customer’s from Delhi. Give the count an alias name of Cust_Count.

select city,count(*) as Cust_Count_InDelhi
from customer
where city = "Delhi"
group by city;

-- Write a query to display  the customer number, customer firstname,account number for the customer’s 
-- whose accounts were created after 15th of any month.
select cust.custid,cust.fname,acc.acnumber,acc.aod
from customer as cust
inner join account as acc on acc.custid = cust.custid
where extract(day from acc.aod)>15;

-- Write a query to display the female customers firstname, city and account number who are not into business, service or studies.

select cust.fname,cust.city,acc.acnumber
from customer as cust
inner join account as acc on cust.custid = acc.custid
where cust.occupation not in ("Service","Student","Business");

-- Write a query to display city name and count of branches in that city. Give the count of branches an alias name of Count_Branch.

select bcity,count(*) as Branch_Counts_inEachCity
from branch
group by bcity;

-- Write a query to display account id, customer’s firstname, customer’s lastname for the customer’s whose account is Active.

select acc.acnumber,cust.fname,cust.ltname
from account as acc
inner join customer as cust on acc.custid = cust.custid
where acc.astatus = "Active";

-- Write a query to display the customer’s number, customer’s firstname, branch id and loan amount for people who have taken loans.

select cust.custid,cust.fname,l.bid,l.loan_amount
-- case when l.loan_amount is null and l.bid is null then "Not taken Loan" else l.loan_amount end as status
-- if(l.loan_amount is null ,"Not taken a loan",l.loan_amount)
from customer as cust
inner join loan as l on cust.custid = l.custid;

-- Write a query to display customer number, customer name, account number where the account status is terminated.

select cust.custid,concat_ws(" ",cust.fname,cust.ltname) as Customer_Name,acc.acnumber,acc.astatus
from customer as cust 
inner join account as acc on cust.custid = acc.custid
where acc.astatus = "Terminated";

-- Write a query to display the transaction type and number of counts the transactions where made in different type
select transaction_type,count(*) as TotalTransactions
from trandetails
group by transaction_type;

-- write a query to display the medium of tranactions where it is made by cash or check
select * from trandetails;
select medium_of_transaction,count(*) as tranasctionCounts_MadeByCashOrCheck
from trandetails
group by medium_of_transaction;

-- write a query to display total customers in each branch
select b.bname,count(acc.custid) as TotalCustomers
from branch as b
left join account as acc on b.bid = acc.bid
group by b.bname
order by TotalCustomers desc;
