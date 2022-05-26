delimiter //
create procedure sp_addMonitoreo(
	in v_id_monitoreo int,
    in v_temp_ambiente float,
    in v_hum_relativa float,
    in v_temp_suelo int,
    in v_profundidad int,
    in v_resistencia int,
    in v_tension int,
    in v_fecha date,
    in v_hora time,
    in v_id_sitio int,
    in v_id_nodo_sensor int
) begin
	declare variable int default 0;
	declare error int default 0;
    declare continue handler for sqlexception set error = 1;
	
	if v_id_monitoreo = 0 and exists (select 1 from monitoreo where id_sitio = v_id_sitio and id_nodo_sensor = v_id_nodo_sensor and fecha = v_fecha and hora = v_hora) then
		set variable = 1;
	elseif v_id_monitoreo = 0 then
		insert into monitoreo (temp_ambiente, hum_relativa, temp_suelo, profundidad, resistencia, tension, fecha, hora, id_sitio, id_nodo_sensor)
        values (v_temp_ambiente, v_hum_relativa, v_temp_suelo, v_profundidad, v_resistencia, v_tension, v_fecha, v_hora, v_id_sitio, v_id_nodo_sensor);
        set v_id_monitoreo = last_insert_id();
	elseif not exists (select 1 from monitoreo where id_monitoreo = v_id_monitoreo) then
		set variable = 2;
	elseif exists (select 1 from monitoreo where not id_monitoreo = v_id_monitoreo and id_sitio = v_id_sitio and id_nodo_sensor = v_id_nodo_sensor and fecha = v_fecha and hora = v_hora) then
		set variable = 1;
	else
		update monitoreo
		set temp_ambiente = v_temp_ambiente,
        hum_relativa = v_hum_relativa,
        temp_suelo = v_temp_suelo,
        profundidad = v_profundidad,
        resistencia = v_resistencia,
        tension = v_tension,
        fecha = v_fecha,
        hora = v_hora,
		id_sitio= v_id_sitio,
        id_nodo_sensor = v_id_nodo_sensor
		where id_monitoreo = v_id_monitoreo;
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
		select id_monitoreo, temp_ambiente, hum_relativa, temp_suelo, profundidad, resistencia, tension, fecha, hora, id_sitio, id_nodo_sensor
		from monitoreo where id_monitoreo = v_id_monitoreo;
	end if;
    
end //
delimiter ;