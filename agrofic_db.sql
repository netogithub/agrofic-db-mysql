-- Creacionde base de datos agrofic_db
create database agrofic_db;
use agrofic_db;

create table generos(
    id_genero int not null auto_increment,
    descripcion varchar(15) not null,
    nombre_cientifico varchar(15) not null,
    primary key (id_genero)
);

create table especies(
    id_especie int not null auto_increment,
    descripcion varchar(25) not null,
    nombre_cientifico varchar(25) not null,
    id_genero int not null,
    primary key (id_especie),
    foreign key (id_genero) references generos (id_genero)
);

create table cultivos(
    id_cultivo int not null auto_increment,
    descripcion varchar(30) not null,
    deficit_min int not null,
    deficit_max int not null,
    p_raiz_min double not null,
    p_raiz_max double not null,
    tension_min int not null,
    tension_max int not null,
    id_especie int not null,
    primary key (id_cultivo),
    foreign key (id_especie) references especies (id_especie)
);

create table suelos(
    id_suelo int not null,
    descripcion varchar(45) not null,
    capacidad_campo double not null,
    punto_marchites double not null,
    agua_disponible double not null,
    primary key (id_suelo)
);

create table riegos(
    id_riego int not null,
    descripcion varchar(25) not null,
    consumo int not null,
    hora_riego int not null,
    eficiencia_min int not null,
    eficiencia_max int not null,
    diferencial_altura int not null,
    primary key (id_riego)
);

create table plantaciones(
    id_plantacion int not null auto_increment,
    descripcion varchar(25) not null,
    primary key (id_plantacion)
);

create table sitios(
    id_sitio int not null,
    estatus int not null,
    clave varchar(10) not null,
    descripcion varchar(35) not null,
    latitud double not null,
    longitud double not null,
    id_cultivo int not null,
    id_suelo int not null,
    id_riego int not null,
    id_plantacion int not null,
    primary key (id_sitio),
    foreign key (id_cultivo) references cultivos (id_cultivo),
    foreign key (id_suelo) references suelos (id_suelo),
    foreign key (id_riego) references riegos (id_riego),
    foreign key (id_plantacion) references plantaciones (id_plantacion)
);

create table nodos(
    id_nodo int not null auto_increment,
    descripcion varchar(20) not null,
    latitud double not null,
    longitud double not null,
    id_sitio int not null,
    primary key (id_nodo),
    foreign key (id_sitio) references sitios (id_sitio)
);

create table sensores(
    id_sensor int not null auto_increment,
    descripcion varchar(25) not null,
    marca varchar(25) not null,
    modelo varchar(25) not null,
    primary key (id_sensor)
);

create table nodo_sensor(
    id_nodo_sensor int not null auto_increment,
    descripcion varchar(5) not null,
    id_nodo int not null,
    id_sensor int not null,
    primary key (id_nodo_sensor),
    foreign key (id_nodo) references nodos (id_nodo),
    foreign key (id_sensor) references sensores (id_sensor)
);

create table usuarios(
    id_usuario int not null auto_increment,
    estatus int not null,
    tipo_usuario int not null,
    username varchar(15) not null,
    pass varchar(64) not null,
    nombre varchar(35) not null,
    a_paterno varchar(25) not null,
    a_materno varchar(25) not null,
    descripcion varchar(35) not null,
    email varchar(45) not null,
    telefono varchar(15) not null,
    primary key (id_usuario)
);

create table sitio_usuario(
    id_sitio_usuario int not null auto_increment,
    id_sitio  int not null,
    id_usuario int not null,
    primary key (id_sitio_usuario),
    foreign key (id_sitio) references sitios (id_sitio),
    foreign key (id_usuario) references usuarios (id_usuario)
);

create table monitoreo(
    id_monitoreo int not null auto_increment,
    temp_ambiente float not null,
    hum_relativa float not null,
    temp_suelo int not null,
    profundidad int not null,
    resistencia int not null,
    tension int not null,
    fecha date not null,
    hora time not null,
    id_sitio int not null,
    id_nodo_sensor int not null,
    primary key (id_monitoreo),
    foreign key (id_sitio) references sitios (id_sitio),
    foreign key (id_nodo_sensor) references nodo_sensor (id_nodo_sensor)
);