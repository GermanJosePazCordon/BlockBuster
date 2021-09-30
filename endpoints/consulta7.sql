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