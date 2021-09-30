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

commit;