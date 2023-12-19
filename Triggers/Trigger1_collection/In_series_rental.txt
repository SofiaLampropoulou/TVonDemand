drop trigger if exists in_series_rental;
delimiter $
create trigger in_series_rental
before insert on series_rental
for each row 
begin
declare email varchar(50);

select username
into email
from user
where user_id=1;

insert into log values (null,email,CURRENT_TIMESTAMP,'Successful','Insert','Series_Rental');
end$
delimiter ;