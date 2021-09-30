create table Pais(
  id_pais serial PRIMARY KEY,
  pais varchar(65) 
);

create table Ciudad(
  id_direccion serial PRIMARY KEY,
  nombre varchar(65) ,
  codigo_postal varchar(5) ,
  id_pais int ,
  CONSTRAINT fk_Direccion_Pais FOREIGN KEY (id_pais) REFERENCES Pais (id_pais)
);

create table Tienda(
  id_tienda serial PRIMARY KEY,
  gerente varchar(65),
  direccion varchar(100),
  nombre varchar(65)
);

create table Cliente(
  id_cliente serial PRIMARY KEY,
  nombre varchar(20) ,
  apellido varchar(20) ,
  direccion varchar(100) ,
  email varchar(65) ,
  activo varchar(3) ,
  fecha_creacion timestamp ,
  id_direccion int ,
  id_tienda int ,
  CONSTRAINT fk_Direccion_Cliente FOREIGN KEY (id_direccion) REFERENCES Ciudad (id_direccion),
  CONSTRAINT fk_Tienda_Cliente FOREIGN KEY (id_tienda) REFERENCES Tienda (id_tienda)
);

create table Empleado(
  id_empleado serial PRIMARY KEY,
  nombre varchar(20) ,
  apellido varchar(20) ,
  direccion varchar(100) ,
  email varchar(65) ,
  activo varchar(3) ,
  usuario varchar(65) ,
  contrasena varchar(65) ,
  id_tienda int,
  CONSTRAINT fk_Tienda_Empleado FOREIGN KEY (id_tienda) REFERENCES Tienda (id_tienda)
);

create table Pelicula(
  id_pelicula serial PRIMARY KEY,
  titulo varchar(65) ,
  descripcion varchar(200) ,
  lanzamiento varchar(4) ,
  duracion smallint ,
  duracion_renta smallint ,
  costo_renta float ,
  costo_dano float ,
  clasificacion varchar(4) 
);

create table Stock(
  id_stock serial PRIMARY KEY,
  cantidad int,
  id_tienda int,
  id_pelicula int,
  CONSTRAINT fk_Tienda_Stock FOREIGN KEY (id_tienda) REFERENCES Tienda (id_tienda),
  CONSTRAINT fk_Pelicula_Stock FOREIGN KEY (id_pelicula) REFERENCES Pelicula (id_pelicula)
);

create table Alquiler(
  id_alquiler serial PRIMARY KEY,
  fecha_renta timestamp ,
  fecha_devolucion timestamp ,
  fecha_pago timestamp ,
  monto float ,
  id_cliente int,
  id_empleado int,
  id_pelicula int,
  CONSTRAINT fk_Cliente_Alquiler FOREIGN KEY (id_cliente) REFERENCES Cliente (id_cliente),
  CONSTRAINT fk_Empleado_Alquiler FOREIGN KEY (id_empleado) REFERENCES Empleado (id_empleado),
  CONSTRAINT fk_Pelicula_Alquiler FOREIGN KEY (id_pelicula) REFERENCES Pelicula (id_pelicula)
);

create table Actor(
  id_actor serial PRIMARY KEY,
  nombre varchar(20) ,
  apellido varchar(20) 
);

create table Categoria(
  id_categoria serial PRIMARY KEY,
  categoria varchar(65) 
);

create table Idioma(
  id_idioma serial PRIMARY KEY,
  idioma varchar(65) 
);

create table Reparto(
  id_reparto serial PRIMARY KEY,
  id_actor int,
  id_pelicula int,
  CONSTRAINT fk_Actor_Stock FOREIGN KEY (id_actor) REFERENCES Actor (id_actor),
  CONSTRAINT fk_Pelicula_Stock FOREIGN KEY (id_pelicula) REFERENCES Pelicula (id_pelicula)
);

create table Genero(
  id_genero serial PRIMARY KEY,
  id_categoria int,
  id_pelicula int,
  CONSTRAINT fk_Categoria_Stock FOREIGN KEY (id_categoria) REFERENCES Categoria (id_categoria),
  CONSTRAINT fk_Pelicula_Stock FOREIGN KEY (id_pelicula) REFERENCES Pelicula (id_pelicula)
);

create table Traduccion(
  id_traduccion serial PRIMARY KEY,
  id_idioma int,
  id_pelicula int,
  CONSTRAINT fk_Idioma_Stock FOREIGN KEY (id_idioma) REFERENCES Idioma (id_idioma),
  CONSTRAINT fk_Pelicula_Stock FOREIGN KEY (id_pelicula) REFERENCES Pelicula (id_pelicula)
);

------------------------------ TABLA PAIS -----------------------------------
insert  into Pais (pais)
select distinct pais from
    (select distinct PAIS_CLIENTE as pais from
        Tmp union
     select distinct PAIS_EMPLEADO as pais from
        Tmp union
     select distinct PAIS_TIENDA as pais
     from Tmp
    ) as foo
where pais is not null and pais not in (select pais from Pais);

------------------------------ TABLA CIUDAD -----------------------------------------
insert into CIUDAD (NOMBRE, CODIGO_POSTAL, ID_PAIS)
select NOMBREC, CODIGO_POSTAL, ID_PAIS from
(select distinct CIUDAD_EMPLEADO as NOMBREC, CODIGO_POSTAL_EMPLEADO as CODIGO_POSTAL, ID_PAIS from Tmp
inner join PAIS on PAIS_EMPLEADO = pais) foo
where NOMBREC is not NULL;

------------------------------ TABLA TIENDA -----------------------------------------
insert into Tienda (gerente, direccion, nombre)
select distinct ENCARGADO_TIENDA, DIRECCION_TIENDA, NOMBRE_TIENDA
from Tmp
where NOMBRE_TIENDA is not null and ENCARGADO_TIENDA is not null and DIRECCION_EMPLEADO is not null
order by NOMBRE_TIENDA ASC;

------------------------------ TABLA CLIENTE -----------------------------------------
insert into Cliente (nombre, apellido, direccion, email, activo, fecha_creacion, id_direccion, id_tienda)
select * from 
(select distinct
    (select SPLIT_PART(NOMBRE_CLIENTE, ' ', 1)) as NOMBRE,
    (select SPLIT_PART(NOMBRE_CLIENTE, ' ', 2)) as APELLIDO,
    DIRECCION_CLIENTE, CORREO_CLIENTE, CLIENTE_ACTIVO, FECHA_CREACION, Ciudad.id_direccion, Tienda.id_tienda
from Tmp
    inner join Ciudad on CIUDAD_CLIENTE = Ciudad.nombre and CODIGO_POSTAL_CLIENTE = Ciudad.codigo_postal
    inner join Tienda on TIENDA_PREFERIDA = Tienda.nombre
    inner join Pais on Pais.pais = PAIS_CLIENTE and Ciudad.id_pais = Pais.id_pais
where FECHA_CREACION is not null and NOMBRE_CLIENTE is not null order by NOMBRE ASC
) foo;

------------------------------ TABLA EMPLEADO -----------------------------------------
insert into Empleado (nombre, apellido, direccion, email, activo, usuario, contrasena, id_tienda)
select * from 
(select distinct
    (select SPLIT_PART(NOMBRE_EMPLEADO, ' ', 1)) as NOMBRE,
    (select SPLIT_PART(NOMBRE_EMPLEADO, ' ', 2)) as APELLIDO,
    DIRECCION_EMPLEADO, CORREO_EMPLEADO, EMPLEADO_ACTIVO, USUARIO_EMPLEADO, CONTRASENA_EMPLEADO, Tienda.id_tienda
from Tmp inner join Tienda on TIENDA_EMPLEADO = Tienda.nombre
WHERE NOMBRE_EMPLEADO is not null order by NOMBRE ASC
) foo;

------------------------------ TABLA PELICULA -----------------------------------------
insert into Pelicula (titulo, descripcion, lanzamiento, duracion, duracion_renta, costo_renta, costo_dano, clasificacion)
select distinct NOMBRE_PELICULA, DESCRIPCION_PELICULA, ANO_LANZAMIENTO, DURACION, DIAS_RENTA, COSTO_RENTA, COSTO_POR_DANO, CLASIFICACION
from Tmp
WHERE NOMBRE_PELICULA IS NOT NULL;

------------------------------ TABLA STOCK -----------------------------------------
insert into Stock (cantidad, id_tienda, id_pelicula)
select distinct  count(*), id_tienda, id_pelicula
from Tmp
inner join Tienda on TIENDA_PELICULA = Tienda.nombre
inner join Pelicula on NOMBRE_PELICULA = titulo
GROUP BY id_tienda, id_pelicula;

------------------------------ TABLA ALQUILER -----------------------------------------
insert into Alquiler (fecha_renta, fecha_devolucion, fecha_pago, monto, id_cliente, id_empleado, id_pelicula)
select distinct  FECHA_RENTA, FECHA_RETORNO, FECHA_PAGO, MONTO_A_PAGAR, id_cliente, id_empleado, id_pelicula
from Tmp
inner join Cliente on NOMBRE_CLIENTE = Cliente.nombre || ' ' || Cliente.apellido
inner join Empleado on NOMBRE_EMPLEADO = Empleado.nombre || ' ' || Empleado.apellido
inner join Pelicula on NOMBRE_PELICULA = titulo
where FECHA_RENTA is not null and (FECHA_RENTA, FECHA_RETORNO, FECHA_PAGO, MONTO_A_PAGAR, id_cliente, id_empleado, id_pelicula) 
not in (select fecha_renta, fecha_devolucion, fecha_pago, monto, id_cliente, id_empleado, id_pelicula from Alquiler);

------------------------------- TABLA ACTOR ---------------------------------
insert into Actor (nombre, apellido)
select distinct
    (select SPLIT_PART(ACTOR_PELICULA, ' ', 1)) as NOMBRE,
    (select SPLIT_PART(ACTOR_PELICULA, ' ', 2)) as APELLIDO
from tmp
where ACTOR_PELICULA is not null;

------------------------------- TABLA CATEGORIA ---------------------------------
insert into Categoria (categoria)
Select distinct CATEGORIA_PELICULA
from Tmp where CATEGORIA_PELICULA
is not null and CATEGORIA_PELICULA not in (select categoria from Categoria);

------------------------------- TABLA IDIOMA ---------------------------------     
insert into Idioma (idioma)
select distinct LENGUAJE_PELICULA
from Tmp
where LENGUAJE_PELICULA is not null and (LENGUAJE_PELICULA) not in (select idioma from Idioma);

------------------------------- TABLA REPARTO --------------------------------- 
insert into Reparto (id_actor, id_pelicula)
select distinct id_actor, id_pelicula from Tmp
inner join Actor on ACTOR_PELICULA = Actor.nombre || ' ' || Actor.apellido
inner join Pelicula on NOMBRE_PELICULA = titulo;

------------------------------- TABLA GENERO --------------------------------- 
insert into Genero (id_categoria, id_pelicula)
select distinct id_categoria, id_pelicula from Tmp
inner join Categoria on CATEGORIA_PELICULA = Categoria.categoria
inner join Pelicula on NOMBRE_PELICULA = Pelicula.titulo
where (id_categoria, id_pelicula) not in (select id_categoria, id_pelicula FROM Genero);

------------------------------- TABLA TRADUCCION ---------------------------------
insert into Traduccion (id_idioma, id_pelicula)
select distinct id_idioma, id_pelicula from Tmp
inner join Idioma on LENGUAJE_PELICULA = Idioma.idioma
inner join Pelicula on NOMBRE_PELICULA = titulo
where (id_idioma, id_pelicula) not in (select id_idioma, id_pelicula from  Traduccion);

commit;