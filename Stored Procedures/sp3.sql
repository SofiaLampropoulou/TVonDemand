drop procedure if exists monthly_income;
delimiter $
create procedure monthly_income()
begin
declare temp decimal(5,2);
declare i smallint;
set i=1;
while(i<13) do
select sum(amount)
into temp
from film_payment 
where month(payment_date)=i;
if(temp is null) then
select replace('The total income from films for month noz is: 0.00 euros.','z',i) as Monthly_Income_From_Films;
else
select replace(replace('The total income from films for month noz is: y euros.','z',i),'y',temp) as Monthly_Income_From_Films;
end if;
select sum(amount)
into temp
from series_payment 
where month(payment_date)=i;
if(temp is null) then
select replace('The total income from series for month noz is: 0.00 euros.','z',i) as Monthly_Income_From_Series;
else
select replace(replace('The total income from series for month noz is: y euros.','z',i),'y',temp) as Monthly_Income_From_Series;
end if;
set i=i+1;
end while;
end$
delimiter ;

call monthly_income();