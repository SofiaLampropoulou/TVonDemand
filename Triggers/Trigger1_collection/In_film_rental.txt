drop trigger if exists in_film_rental;
delimiter $
create trigger in_film_rental
before insert on film_rental
for each row 
begin
declare email varchar(50);

select username
into email
from user
where user_id=1;

insert into log values (null,email,CURRENT_TIMESTAMP,'Successful','Insert','Film_Rental');
end$
delimiter ;