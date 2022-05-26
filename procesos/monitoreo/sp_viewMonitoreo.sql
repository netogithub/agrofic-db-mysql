delimiter //
create procedure sp_viewMonitoreo(
	in v_id_monitoreo int
) begin
	if v_id_monitoreo = 0 then
		select id_monitoreo, temp_hambiente, hum_relativa, temp_suelo, profundidad, resistencia, tension, fecha, hora, id_sitio, id_nodo_sensor
        from monitoreo;
	elseif not exists (select 1 from monitoreo where id_monitoreo = v_id_monitoreo) then
		select "elemento no encontrado" as mensaje;
	else
		select id_monitoreo, temp_hambiente, hum_relativa, temp_suelo, profundidad, resistencia, tension, fecha, hora, id_sitio, id_nodo_sensor
		from monitoreo where id_monitoreo = v_id_monitoreo;
	end if;
end //
delimiter ;