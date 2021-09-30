select concat(nombre,' ', apellido) as Nombre_completo
from Actor
where upper(apellido) like '%SON%' order by nombre asc;