drop trigger if exists series_discount;
delimiter $
create trigger series_discount
after insert on series_rental
for each row
begin
declare temp_count smallint;
declare temp_email varchar(50);
declare temp_type varchar(25);
declare cost decimal(5,2);
declare max_id int;

select email
into temp_email
from customer 
where customer.customer_id=new.customer_id;
select subscription_type
into temp_type
from customer
where customer.email like temp_email;

call rental_num(temp_email,new.rental_date,temp_count);
if(temp_type like 'S') then
select amount
into cost
from price
where price_id=2;
set cost=cost*new.episode_count;
elseif(temp_type like 'MS') then
select amount
into cost
from price
where price_id=4;
set cost=cost*new.episode_count;
end if;

if (temp_count mod 3 = 0) then                                                    
set cost= 0.5*cost;
end if;

if(new.rental_id IS NULL) then
   select max(rental_id)
   into max_id
   from series_rental;
   insert into series_payment values (null,new.customer_id,max_id,cost,new.rental_date);
else
   insert into series_payment values (null,new.customer_id,new.rental_id,cost,new.rental_date);
end if;
end$
delimiter ;

insert into series_rental values(null,'2050-07-07 23:05:05',12,10,477);
select * from series_payment;