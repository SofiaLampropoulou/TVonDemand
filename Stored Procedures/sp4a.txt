drop procedure if exists actors_between;
delimiter $
create procedure actors_between(in actor1 varchar(50),in actor2 varchar(50))
begin
select first_name, last_name
from actor
where last_name between actor1 and actor2
order by last_name asc;
select count(*) as Actor_Count
from actor
where last_name between actor1 and actor2;
end$
delimiter ;

call actors_between('chase','mostel');