select * from
(select count(*) as PAIS from Pais) as a,
(select count(*) as Ciudad from Ciudad) as b,
(select count(*) as Cliente from Cliente) as c,
(select count(*) as Empleado from Empleado) as d,
(select count(*) as Tienda from Tienda) as e,
(select count(*) as Stock from Stock) as f,
(select count(*) as Alquiler from Alquiler) as g,
(select count(*) as Pelicula from Pelicula) as h,
(select count(*) as Reparto from Reparto) as i,
(select count(*) as Genero from Genero) as j,
(select count(*) as Traduccion from Traduccion) as k,
(select count(*) as Actor from Actor) as l,
(select count(*) as Idioma from Idioma) as m,
(select count(*) as Categoria from Categoria) as n;
