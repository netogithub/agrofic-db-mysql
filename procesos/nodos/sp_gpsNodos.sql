delimiter //
create procedure sp_gpsNodos(
	in v_id_nodo int,
	in v_latitud double,
	in v_longitud double
) begin
	declare variable int default 0;
	declare error int default 0;
    declare continue handler for sqlexception set error = 1;
	
	if v_id_nodo = 0 then
		set variable = 3;
	elseif not exists (select 1 from nodos where id_nodo = v_id_nodo) then
		set variable = 2;
	elseif exists (select 1 from nodos where not id_nodo = v_id_nodo and (latitud = v_latitud and longitud = v_longitud)) then
		set variable = 1;
	else
		update nodos
		set latitud = v_latitud,
		longitud = v_longitud
		where id_nodo = v_id_nodo;
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
		select id_nodo, descripcion, latitud, longitud, id_sitio
		from nodos where latitud = 0 and longitud = 0;
	else
		select id_nodo, descripcion, latitud, longitud, id_sitio
		from nodos where id_nodo = v_id_nodo;
	end if;
    
end //
delimiter ;