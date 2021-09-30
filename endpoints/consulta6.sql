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