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