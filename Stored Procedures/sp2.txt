drop procedure if exists rental_num;
delimiter $
create procedure rental_num(in email varchar(50), in date date, out rental_count smallint)
begin
declare type varchar(20);
declare temp smallint;
select subscription_type
into type
from customer
where customer.email like email;
if(type like 'M') then
select count(*) as rental_count into rental_count from film_rental inner join customer
where customer.email like email and customer.customer_id=film_rental.customer_id and date(rental_date) like date;
elseif(type like 'S') then
select sum(episode_count) as rental_count into rental_count from series_rental inner join customer
where customer.email like email and customer.customer_id=series_rental.customer_id and date(rental_date) like date;
else 
select count(*) into rental_count from film_rental inner join customer
where customer.email like email and customer.customer_id=film_rental.customer_id and date(rental_date) like date;
select sum(episode_count) into temp from series_rental inner join customer
where customer.email like email and customer.customer_id=series_rental.customer_id and date(rental_date) like date;
if(rental_count is not null and temp is not null) then
set rental_count=rental_count+temp;
elseif(rental_count is not null and temp is null) then
set rental_count=rental_count;
else
set rental_count=temp;
end if;
end if;
end$
delimiter ;

call rental_num('DAN.PAINE@sakilacustomer.org','2005-07-07',@res);
select @res;

