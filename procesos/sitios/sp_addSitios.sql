delimiter //
create procedure sp_addSitios(
	in v_id_sitio int,
	in v_estatus int,
	in v_clave varchar(10),
	in v_descripcion varchar(35),
	in v_latitud double,
	in v_longitud double,
	in v_id_cultivo int,
	in v_id_suelo int,
	in v_id_riego int,
	in v_id_plantacion int
) begin
	declare variable int default 0;
	declare error int default 0;
    declare continue handler for sqlexception set error = 1;
	
	if v_id_sitio = 0 and exists (select 1 from sitios where clave = v_clave or descripcion = v_descripcion) then
		set variable = 1;
	elseif v_id_sitio = 0 then
		insert into sitios (estatus, clave, descripcion, latitud, longitud, id_cultivo, id_suelo, id_riego, id_plantacion)
        values (v_estatus, v_clave, v_descripcion, v_latitud, v_longitud, v_id_cultivo, v_id_suelo, v_id_riego, v_id_plantacion);
        set v_id_sitio = last_insert_id();
	elseif not exists (select 1 from sitios where id_sitio = v_id_sitio) then
		set variable = 2;
	elseif exists (select 1 from sitios where not id_sitio = v_id_sitio and (clave = v_clave or descripcion = v_descripcion)) then
		set variable = 1;
	else
		update sitios
		set clave = v_clave,
		descripcion = v_descripcion,
		id_cultivo = v_id_cultivo,
		id_suelo = v_id_suelo,
		id_riego = v_id_riego,
		id_plantacion = v_id_plantacion
		where id_sitio = v_id_sitio;
    end if;

	if error = 1 then
		rollback;
	else
		commit;
	end if;
		
	if variable = 1 then
		select "elemento ya ingresado" as mensaje;
	elseif variable = 2 then
		select "elemento no encontrado" as mensaje;
	else
		select id_sitio, estatus, clave, descripcion, latitud, longitud, id_cultivo, id_suelo, id_riego, id_plantacion
		from sitios where id_sitio = v_id_sitio;
	end if;
    
end //
delimiter ;