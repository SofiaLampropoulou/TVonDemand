drop procedure if exists max_rental;
delimiter $
create procedure max_rental(in type varchar(25),in num smallint, in date1 date, in date2 date)
begin 
if(type like 'M') then
select film.film_id,title
from film_rental 
inner join film_inventory 
on film_inventory.inventory_id=film_rental.inventory_id
inner join film
on film.film_id= film_inventory.film_id
where date(rental_date)>=date1 and date(rental_date)<=date2    
group by film_rental.inventory_id order by count(film_rental.inventory_id) desc limit num;
elseif(type like 'S') then 
select series.series_id,title
from series_rental 
inner join series_inventory 
on series_inventory.inventory_id=series_rental.inventory_id
inner join series
on series.series_id= series_inventory.series_id
where date(rental_date)>=date1 and date(rental_date)<=date2    
group by series_rental.inventory_id order by sum(series_rental.episode_count) desc limit num;
end if; 
end$
delimiter ;

call max_rental('m',4,'2005-01-03','2006-02-03'); 

