delimiter //
create procedure sp_addNodos(
	in v_id_nodo int,
    in v_descripcion varchar(20),
	in v_latitud double,
	in v_longitud double,
	in v_id_sitio int
) begin
	declare variable int default 0;
	declare error int default 0;
    declare continue handler for sqlexception set error = 1;
	
	if v_id_nodo = 0 and exists (select 1 from nodos where descripcion = v_descripcion and id_sitio = v_id_sitio) then
		set variable = 1;
	elseif v_id_nodo = 0 then
		insert into nodos (descripcion, latitud, longitud, id_sitio)
        values (v_descripcion, v_latitud, v_longitud, v_id_sitio);
        set v_id_nodo = last_insert_id();
	elseif not exists (select 1 from nodos where id_nodo = v_id_nodo) then
		set variable = 2;
	elseif exists (select 1 from nodos where not id_nodo = v_id_nodo and descripcion = v_descripcion and id_sitio = v_id_sitio) then
		set variable = 1;
	else
		update nodos
		set descripcion = v_descripcion,
		id_sitio = v_id_sitio
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
	else
		select id_nodo, descripcion, latitud, longitud, id_sitio
		from nodos where id_nodo = v_id_nodo;
	end if;
    
end //
delimiter ;