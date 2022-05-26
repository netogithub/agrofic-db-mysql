delimiter //
create procedure sp_viewSensores(
	in v_id_sensor int
) begin
	if v_id_sensor = 0 then
		select id_sensor, descripcion, marca, modelo
        from sensores;
	elseif not exists (select 1 from sensores where id_sensor = v_id_sensor) then
		select "elemento no encontrado" as mensaje;
	else
		select id_sensor, descripcion, marca, modelo
		from sensores where id_sensor = v_id_sensor;
	end if;
end //
delimiter ;