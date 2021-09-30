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