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