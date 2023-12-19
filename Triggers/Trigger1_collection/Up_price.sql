drop trigger if exists up_price;
delimiter $
create trigger up_price
before update on price
for each row 
begin
declare email varchar(50);

select username
into email
from user
where user_id=1;

if(new.amount<0) then 
 set new.amount=old.amount;
 insert into log values (null,email,CURRENT_TIMESTAMP,'Unsuccessful','Update','Price');
else
  insert into log values (null,email,CURRENT_TIMESTAMP,'Successful','Update','Price');
end if;
end$
delimiter ;