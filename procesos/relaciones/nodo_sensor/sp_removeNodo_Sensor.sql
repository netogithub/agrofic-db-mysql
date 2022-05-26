delimiter //
create procedure sp_removeNodo_Sensor(
	in v_id_nodo_sensor int
) begin
	declare error int default 0;
    declare continue handler for sqlexception set error = 1;

	if not exists (select 1 from nodo_sensor where id_nodo_sensor = v_id_nodo_sensor) then
		select "elemento no encontrado" as mensaje;
	elseif exists (select 1 from monitoreo where id_nodo_sensor = v_id_nodo_sensor) then
		select "elemento relacionado" as mensaje;
	else
		delete from nodo_sensor
		where id_nodo_sensor = v_id_nodo_sensor;
		if error = 1 then
			rollback;
		else
			commit;
			select "elemento eliminado" as mensaje;
		end if;
	end if;

end //
delimiter ;