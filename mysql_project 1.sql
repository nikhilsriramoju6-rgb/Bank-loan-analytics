use bank_loan_project;
select * from finance_1mysql;
select * from finance_2mysql;
alter table finance_1mysql rename column ï»¿id to id; 


#KPI 1
-- Year wise loan amount --
select year(issue_D) as Year_of_issue_d, sum(loan_amnt) as Total_loan_amnt
from finance_1mysql
group by Year_of_issue_D
order by Year_of_issue_D;

#KPI 2
-- Grade and sub grade wise revol_bal --
select 
grade , sub_grade, sum(revol_bal) as total_revol_bal
from finance_1mysql inner join finance_2mysql
on(finance_1mysql.id = finance_2mysql.id) 
group by grade , sub_grade
order by grade , sub_grade;

#KPI 3
-- Total Payment for Verified Status Vs Total Payment for Non Verified Status --
select verification_status, concat("$",format(round(sum(total_pymnt)/100000,"2"),2),"M") as total_payment
from finance_1mysql inner join finance_2mysql
on(finance_1mysql.id = finance_2mysql.id)
group by verification_status;

#KPI 4
-- State wise and last_credit_pull_d wise loan status --
select addr_state, last_credit_pull_D ,loan_status
from finance_1mysql inner join finance_2mysql 
on(finance_1mysql.id = finance_2mysql.id)
group by addr_state, last_credit_pull_D , loan_status
order by last_credit_pull_D;

#KPI 5 
-- Home ownership Vs last payment date stats --
select 
home_ownership,last_pymnt_d,
concat("$",format(round(sum(last_pymnt_amnt)/ 10000,2),2),"K") as total_amount
from finance_1mysql inner join finance_2mysql 
on(finance_1mysql.id = finance_2mysql.id)
group by home_ownership,last_pymnt_d
order by last_pymnt_d desc, home_ownership desc;


