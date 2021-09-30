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