delimiter //
create procedure sp_addNodo_Sensor(
	in v_id_nodo_sensor int,
    in v_descripcion varchar(5),
	in v_id_nodo int,
	in v_id_sensor int
) begin
	declare variable int default 0;
	declare error int default 0;
    declare continue handler for sqlexception set error = 1;
	
	if v_id_nodo_sensor = 0 and exists (select 1 from nodo_sensor where descripcion = v_descripcion and id_nodo = v_id_nodo) then
		set variable = 1;
	elseif v_id_nodo_sensor = 0 then
		insert into nodo_sensor (descripcion, id_nodo, id_sensor)
        values (v_descripcion, v_id_nodo, v_id_sensor);
        set v_id_nodo_sensor = last_insert_id();
	elseif not exists (select 1 from nodo_sensor where id_nodo_sensor = v_id_nodo_sensor) then
		set variable = 2;
	elseif exists (select 1 from nodo_sensor where not id_nodo_sensor = v_id_nodo_sensor and descripcion = v_descripcion and id_nodo = v_id_nodo) then
		set variable = 1;
	else
		update nodo_sensor
		set descripcion = v_descripcion,
		id_nodo = v_id_nodo,
		id_sensor = v_id_sensor
		where id_nodo_sensor = v_id_nodo_sensor;
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
		select id_nodo_sensor, descripcion, id_nodo, id_sensor
		from nodo_sensor where id_nodo_sensor = v_id_nodo_sensor;
	end if;
    
end //
delimiter ;