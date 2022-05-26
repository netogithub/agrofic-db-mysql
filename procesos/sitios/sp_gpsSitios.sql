delimiter //
create procedure sp_gpsSitios(
	in v_id_sitio int,
	in v_latitud double,
	in v_longitud double
) begin
	declare variable int default 0;
	declare error int default 0;
    declare continue handler for sqlexception set error = 1;
	
	if v_id_sitio = 0 then
		set variable = 3;
	elseif not exists (select 1 from sitios where id_sitio = v_id_sitio) then
		set variable = 2;
	elseif exists (select 1 from sitios where not id_sitio = v_id_sitio and (latitud = v_latitud and longitud = v_longitud)) then
		set variable = 1;
	else
		update sitios
		set latitud = v_latitud,
		longitud = v_longitud
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
	elseif variable = 3 then
		select id_sitio, estatus, clave, descripcion, latitud, longitud, id_cultivo, id_suelo, id_riego, id_plantacion
		from sitios where latitud = 0 and longitud = 0;
	else
		select id_sitio, estatus, clave, descripcion, latitud, longitud, id_cultivo, id_suelo, id_riego, id_plantacion
		from sitios where id_sitio = v_id_sitio;
	end if;
    
end //
delimiter ;