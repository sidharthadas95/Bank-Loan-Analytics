CREATE DATABASE P245;
show databases;
use  P245;
show tables;
select * from Finance_1; 
select * from Finance_2;

/*KPI 1Year wise loan amount Stats*/
select year(str_to_date(issue_d, "%d-%b-%yy"))as years,sum(loan_amnt) 
from finance_1
group by year(str_to_date(issue_d, "%d-%b-%yy"));

/*Grade and sub grade wise revol_bal*/
select fin1.grade,fin1.sub_grade,sum(fin2.revol_bal) Total_revol_balance
from finance_1 fin1 , finance_2 fin2
where fin1.id = fin2.id 
group by fin1.grade,fin1.sub_grade
order by fin1.grade,fin1.sub_grade;

/*Total Payment for Verified Status Vs Total Payment for Non Verified Status*/
select verification_status,round(sum(total_pymnt),2) Total_payment
from finance_1 fin1, finance_2 fin2
where fin1.id = fin2.id
and verification_status in ('Verified','Not Verified')
group by fin1.verification_status
order by fin1.verification_status desc;

/*State wise and month wise loan status*/
select addr_state,monthname(str_to_date(issue_d, "%d-%b-%yy")) Month_wise,loan_status, sum(loan_amnt)
from finance_1
group by addr_state,monthname(str_to_date(issue_d, "%d-%b-%yy")) ,loan_status
order by addr_state,monthname(str_to_date(issue_d, "%d-%b-%yy")) ,loan_status;

/*Home ownership Vs last payment date stats*/
select  year(str_to_date(last_pymnt_d, "%d-%b-%yy")) Year_last_payment,home_ownership,round(sum(last_pymnt_amnt)) Total_last_payment
from finance_1 fin1, finance_2 fin2
where fin1.id = fin2.id
group by home_ownership , year(str_to_date(last_pymnt_d, "%d-%b-%yy")) 
having round(sum(last_pymnt_amnt)) <> 0
order by  year(str_to_date(last_pymnt_d, "%d-%b-%yy")) ,home_ownership;




