drop trigger if exists customer_control;
delimiter $
create trigger customer_control
before update on customer
for each row 
begin
declare email2 varchar(50);

select username
into email2
from user
where user_id=1;

if(exists (select * from customer where email like email2)) then 
set new.email=old.email;
set new.create_date=old.create_date;
set new.customer_id=old.customer_id;
end if;
end$
delimiter ;

update customer
set email= 'xaxaxaxa@.org',
create_date= '3023-00-64 22:22:22',
active=100,
customer_id=5
where customer_id=16;