delimiter //
create procedure sp_listMonitoreo(
	in v_id_nodo_sensor int,
	in v_fecha date
) begin
	if not exists (select 1 from nodo_sensor where id_nodo_sensor = v_id_nodo_sensor) then
		select "elemento no encontrado" as mensaje;
	else
		select id_monitoreo, temp_hambiente, hum_relativa, temp_suelo, profundidad, resistencia, tension, fecha, hora, id_sitio, id_nodo_sensor
		from monitoreo where id_nodo_sensor = v_id_nodo_sensor and fecha = v_fecha;
	end if;
end //
delimiter ;