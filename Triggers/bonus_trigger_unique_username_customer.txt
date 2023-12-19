drop trigger if exists unique_username_customer_insert;
delimiter $
create trigger unique_username_customer_insert
before insert on customer
for each row
begin
declare temp smallint;
select count(*) into temp from customer,employee, administrator where customer.email like new.email or employee.email like new.email or administrator.email like new.email;
if(temp>0) then
signal sqlstate '45000'
set message_text = 'There is already a user with this username!';
end if;
end$
delimiter ;

