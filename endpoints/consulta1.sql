select sum(cantidad) as numero_copias from 
(select Tienda.nombre, cantidad 
from Stock
inner join Tienda on Tienda.id_tienda = Stock.id_tienda
inner join Pelicula on Pelicula.id_pelicula = Stock.id_pelicula
where upper(Pelicula.titulo) = 'SUGAR WONKA')foo;