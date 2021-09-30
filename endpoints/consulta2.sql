select Cliente.nombre, Cliente.apellido, trunc(sum(Alquiler.monto)::decimal,2) as monto
from Alquiler
inner join Cliente on Cliente.id_cliente = Alquiler.id_cliente
Group by Cliente.nombre, Cliente.apellido having count(*) >= 40 order by Cliente.nombre asc;