------------------------------ CONSULTA 1 -----------------------------------
select sum(cantidad) as numero_copias from 
(select Tienda.nombre, cantidad 
from Stock
inner join Tienda on Tienda.id_tienda = Stock.id_tienda
inner join Pelicula on Pelicula.id_pelicula = Stock.id_pelicula
where Pelicula.titulo = 'SUGAR WONKA'
) foo;

------------------------------ CONSULTA 2 -----------------------------------
select Cliente.nombre, Cliente.apellido, SUM(Alquiler.monto) as monto
from Alquiler
inner join Cliente on Cliente.id_cliente = Alquiler.id_cliente
Group by Cliente.nombre, Cliente.apellido having count(*) >= 40;

------------------------------ CONSULTA 3 -----------------------------------
select concat(nombre,' ', apellido) as Nombre_completo
from Actor
where upper(apellido) like '%SON%' order by nombre ASC;

------------------------------ CONSULTA 4 -----------------------------------
select distinct nombre, apellido, lanzamiento
from Reparto
inner join Actor ON Reparto.id_actor = Actor.id_actor
inner join Pelicula ON Reparto.id_pelicula = Pelicula.id_pelicula
where upper(descripcion) like '%CROCODILE%' and upper(descripcion) like '%SHARK%' order by apellido ASC;

------------------------------ CONSULTA 4 -----------------------------------