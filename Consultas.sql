------------------------------ CONSULTA 1 -----------------------------------
select sum(cantidad) as numero_copias from 
(select Tienda.nombre, cantidad 
from Stock
inner join Tienda on Tienda.id_tienda = Stock.id_tienda
inner join Pelicula on Pelicula.id_pelicula = Stock.id_pelicula
where upper(Pelicula.titulo) = 'SUGAR WONKA')foo;

------------------------------ CONSULTA 2 -----------------------------------
select Cliente.nombre, Cliente.apellido, trunc(sum(Alquiler.monto)::decimal,2) as monto
from Alquiler
inner join Cliente on Cliente.id_cliente = Alquiler.id_cliente
Group by Cliente.nombre, Cliente.apellido having count(*) >= 40 order by Cliente.nombre asc;

------------------------------ CONSULTA 3 -----------------------------------
select concat(nombre,' ', apellido) as Nombre_completo
from Actor
where upper(apellido) like '%SON%' order by nombre asc;

------------------------------ CONSULTA 4 -----------------------------------
select distinct nombre, apellido, lanzamiento
from Reparto
inner join Actor ON Reparto.id_actor = Actor.id_actor
inner join Pelicula ON Reparto.id_pelicula = Pelicula.id_pelicula
where upper(descripcion) like '%CROCODILE%' and upper(descripcion) like '%SHARK%' order by apellido asc;

------------------------------ CONSULTA 5 -----------------------------------
with rentador as (select Cliente.nombre, Cliente.apellido,
Pais.pais, count(*)
from Alquiler, Cliente, Pais, Ciudad
where Alquiler.id_cliente = Cliente.id_cliente and Ciudad.id_direccion = Cliente.id_direccion
and Ciudad.id_pais = Pais.id_pais
group by Cliente.nombre, Cliente.apellido, Pais.pais),
maximo_rentador as (select * from rentador where count = (select max(count) from rentador)),
total as (select sum(rentador.count) 
from rentador, maximo_rentador WHERE rentador.pais = maximo_rentador.pais)
select rentador.nombre, rentador.apellido, rentador.pais, 
concat(((maximo_rentador.count/total.sum)*100)::integer,'%') as Porcentaje
from total, maximo_rentador, rentador 
where rentador.nombre = maximo_rentador.nombre;

------------------------------ CONSULTA 6 -----------------------------------
with residente as (select Pais.pais, Ciudad.nombre, Cliente.nombre
from Pais, Cliente, Ciudad
where Cliente.id_direccion = Ciudad.id_direccion
and Pais.id_pais = Ciudad.id_pais),
clientes_pais as (select Pais.pais, count(*)::decimal 
from residente, Pais
where Pais.pais = residente.pais 
group by Pais.pais),
clientes_ciudad as (select Pais.pais,Ciudad.nombre, count(*)
from Ciudad, Cliente, Pais
where Cliente.id_direccion = Ciudad.id_direccion and Ciudad.id_pais = Pais.id_pais
group by Ciudad.nombre, Cliente.id_direccion, Pais.pais order by Pais.pais asc)
select clientes_ciudad.pais, clientes_pais.count as cliente_pais, clientes_ciudad.nombre as Ciudad, 
clientes_ciudad.count as cliente_ciudad,
concat(trunc((clientes_ciudad.count/clientes_pais.count)*100,4),'%') as Porcentaje
from clientes_pais, clientes_ciudad
where clientes_pais.pais = clientes_ciudad.pais;

------------------------------ CONSULTA 7 -----------------------------------
with rentas as (select Pais.pais, Ciudad.nombre as Ciudad, count(*)
from Pais, Alquiler, Ciudad, Cliente
where Cliente.id_direccion = Ciudad.id_direccion and Pais.id_pais = Ciudad.id_pais
and Alquiler.id_cliente = Cliente.id_cliente
group by Pais.id_pais, Ciudad),
ciudades_pais as (select Pais.pais, count(*)
from Pais, Ciudad
where Pais.id_pais = Ciudad.id_pais
GROUP BY Pais.id_pais)
select rentas.pais, rentas.ciudad, trunc(((sum(rentas.count)/ciudades_pais.count)),4) as Promedio
from rentas, ciudades_pais, Pais
where rentas.pais = Pais.pais and ciudades_pais.pais = pais.pais
group by rentas.pais, rentas.ciudad, ciudades_pais.count order by rentas.pais;

------------------------------ CONSULTA 8 -----------------------------------
with rentas_pais as (select Pais.pais, count(*)
from Pais, Alquiler, Ciudad, Cliente
where Cliente.id_cliente = Alquiler.id_cliente and Cliente.id_direccion = Ciudad.id_direccion 
and Pais.id_pais = Ciudad.id_pais
group by Pais.id_pais),
rentas_sport as (select Pais.pais, count(*)
from Pais, Alquiler, Ciudad, Cliente, Pelicula, Categoria, Genero
where Cliente.id_cliente = Alquiler.id_cliente and Cliente.id_direccion = Ciudad.id_direccion 
and Pais.id_pais = Ciudad.id_pais and Alquiler.id_pelicula = Pelicula.id_pelicula
and Genero.id_pelicula = Pelicula.id_pelicula and Genero.id_categoria = Categoria.id_categoria
and upper(categoria.categoria) = 'SPORTS'
group by Pais.id_pais)
select rentas_pais.pais, concat(trunc(((sum(rentas_sport.count)/rentas_pais.count)*100),4),'%') as Porcentaje
from rentas_pais, rentas_sport, Pais
where rentas_pais.pais = Pais.pais and rentas_sport.pais = pais.pais
group by rentas_pais.pais, rentas_sport.pais, rentas_pais.count, rentas_sport.count 
order by rentas_pais.pais asc;

------------------------------ CONSULTA 9 -----------------------------------
with city as (select Ciudad.nombre, count(*) 
from Alquiler, Cliente, Ciudad, Pais 
where upper(Ciudad.nombre) <> 'DAYTON' and upper(Pais.pais) = 'UNITED STATES' 
and Alquiler.id_cliente = Cliente.id_cliente and Ciudad.id_direccion = Cliente.id_direccion
and Ciudad.id_pais = Pais.id_pais group by Ciudad.nombre),
daytons as (select count(*) 
from Alquiler, Cliente, Ciudad, Pais 
where upper(Ciudad.nombre) = 'DAYTON' and upper(Pais.pais) = 'UNITED STATES'
and Alquiler.id_cliente = Cliente.id_cliente and Ciudad.id_direccion = Cliente.id_direccion
and Ciudad.id_pais = Pais.id_pais)
select city.nombre as Ciudad, city.count as renta
from city, daytons
group by city.nombre,city.count, daytons.count having city.count>daytons.count
order by Ciudad asc;

------------------------------ CONSULTA 10 -----------------------------------
with rentas_horror as (select Pais.pais, Ciudad.nombre as Ciudad, count(*)
from Pais, Alquiler, Ciudad, Cliente, Pelicula, Categoria, Genero
where Cliente.id_cliente = Alquiler.id_cliente and Cliente.id_direccion = Ciudad.id_direccion 
and Pais.id_pais = Ciudad.id_pais and Alquiler.id_pelicula = Pelicula.id_pelicula
and Genero.id_pelicula = Pelicula.id_pelicula and Genero.id_categoria = Categoria.id_categoria
and upper(categoria.categoria) = 'HORROR'
group by Pais.id_pais, Ciudad),
rentas_otros as (select Pais.pais, Ciudad.nombre as Ciudad, count(*)
from Pais, Alquiler, Ciudad, Cliente, Pelicula, Categoria, Genero
where Cliente.id_cliente = Alquiler.id_cliente and Cliente.id_direccion = Ciudad.id_direccion 
and Pais.id_pais = Ciudad.id_pais and Alquiler.id_pelicula = Pelicula.id_pelicula
and Genero.id_pelicula = Pelicula.id_pelicula and Genero.id_categoria = Categoria.id_categoria
and upper(categoria.categoria) <> 'HORROR'
group by Pais.id_pais, Ciudad, Categoria.categoria),
comparador as (select rentas_otros.ciudad, max(rentas_otros.count) 
from rentas_otros
group by rentas_otros.ciudad)
select rentas_horror.pais, rentas_horror.ciudad
from comparador, rentas_horror
where comparador.ciudad = rentas_horror.ciudad and rentas_horror.count >= comparador.max 
order by rentas_horror.pais asc;