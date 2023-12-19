drop trigger if exists in_film_payment;
delimiter $
create trigger in_film_payment
before insert on film_payment
for each row 
begin
declare email varchar(50);

select username
into email
from user
where user_id=1;

insert into log values (null,email,CURRENT_TIMESTAMP,'Successful','Insert','Film_Payment');
end$
delimiter ;