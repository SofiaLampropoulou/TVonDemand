drop procedure if exists actor_last_name;
delimiter $
create procedure actor_last_name(in actor varchar(50))
begin
declare temp smallint;
select first_name, last_name
from actor
where last_name like actor;
select count(*) 
into temp
from actor
where last_name like actor;
if(temp>1) then
select temp as Actor_Count;
end if;
end$
delimiter ;

call actor_last_name('chase');