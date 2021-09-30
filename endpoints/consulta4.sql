select distinct nombre, apellido, lanzamiento
from Reparto
inner join Actor ON Reparto.id_actor = Actor.id_actor
inner join Pelicula ON Reparto.id_pelicula = Pelicula.id_pelicula
where upper(descripcion) like '%CROCODILE%' and upper(descripcion) like '%SHARK%' order by apellido asc;