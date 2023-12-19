drop trigger if exists in_series_payment;
delimiter $
create trigger in_series_payment
before insert on series_payment
for each row 
begin
declare email varchar(50);

select username
into email
from user
where user_id=1;

insert into log values (null,email,CURRENT_TIMESTAMP,'Successful','Insert','Series_Payment');
end$
delimiter ;