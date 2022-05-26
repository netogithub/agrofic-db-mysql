insert into generos
(id_genero, descripcion, nombre_cientifico)
values
(1, 'Citrico', 'Citrus'),
(2, 'Cereal Zea', 'Zea');

insert into especies
(id_especie, descripcion, nombre_cientifico, id_genero)
values
(1, 'Naranja', 'x Sinensis', 1),
(2, 'Toronja', 'x Paradisi', 1),
(3, 'Mandarina', 'Reticulata', 1),
(4, 'Limon', 'x Aurantifolia', 1);

insert into cultivos
(id_cultivo, descripcion, deficit_min, deficit_max, p_raiz_min, p_raiz_max, tension_min, tension_max, id_especie)
values
(1, 'Valencia', 50, 50, 4.5, 5, 50, 70, 1),
(2, 'Clementina', 50, 50, 4.5, 5, 50, 70, 3),
(3, 'Rubi', 50, 50, 4.5, 5, 50, 70, 2),
(4, 'Navel', 50, 50, 4.5, 5, 50, 70, 1),
(5, 'Italiano', 50, 50, 4.5, 5, 50, 70, 4),
(6, 'Duncan', 50, 50, 4.5, 5, 50, 70, 2);

insert into plantaciones
(id_plantacion, descripcion)
values
(1, 'Huerto'),
(2, 'Invernadero');

insert into riegos
(id_riego, descripcion, consumo, hora_riego, eficiencia_min, eficiencia_max, diferencial_altura)
values
(1, 'Goteo', 4, 20, 90, 95, 2),
(2, 'Aspercion', 4, 20, 80, 85, 4),
(3, 'Rodado', 4, 20, 90, 95, 2),
(4, 'Inundacion', 10, 10, 40, 65, 1);

insert into sensores
(id_sensor, descripcion, marca, modelo)
values
(1, 'Watermar', 'Irrometer', 'ss200'),
(2, 'ec-5', 'Decagon', 'ECH2O');

insert into suelos
(id_suelo, descripcion, capacidad_campo, punto_marchites, agua_disponible)
values
(1, 'Arena', 1.2, 0.5, 0.7),
(2, 'Arena, margosa', 1.9, 0.8, 1.1),
(3, 'Marga arenosa', 2.5, 1.1, 1.4),
(4, 'Marga', 3.2, 1.4, 1.8),
(5, 'Marga limosa', 3.6, 1.8, 1.8),
(6, 'Marga arcillo-arenosa', 4.3, 2.4, 1.9),
(7, 'Arcilla arenosa', 3.8, 2.2, 1.7),
(8, 'Marga arcillosa', 3.5, 2.2, 1.3),
(9, 'Marga arcillo-limosa', 3.4, 1.8, 1.6),
(10, 'Arcilla limosa', 4.8, 2.4, 2.4),
(11, 'Arcilla', 4.8, 2.6, 2.2);