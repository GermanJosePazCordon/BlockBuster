with conteo_pais as (select Pais.id_pais,Pais.pais, count(*)::decimal  
from  Pais, Ciudad, Cliente
where Pais.id_pais = Ciudad.id_pais and Cliente.id_direccion = Ciudad.id_direccion
group by Pais.id_pais, Pais.pais),
conteo_ciudad as (select Ciudad.id_pais, Ciudad.nombre, count(*)::decimal
from Ciudad, Cliente,  Pais
where Cliente.id_direccion = Ciudad.id_direccion
and Pais.id_pais = Ciudad.id_pais
group by Ciudad.id_pais, Ciudad.nombre
order by Ciudad.id_pais, Ciudad.nombre asc)
select conteo_pais.pais, conteo_pais.count as cliente_pais, conteo_ciudad.nombre, conteo_ciudad.count as cliente_ciudad, 
concat(trunc((conteo_ciudad.count/conteo_pais.count)*100,4),'%') as Porcentaje
from conteo_pais, conteo_ciudad 
where conteo_pais.id_pais = conteo_ciudad.id_pais;