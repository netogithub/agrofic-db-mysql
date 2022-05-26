delimiter //
create procedure sp_viewNodo_Sensor(
	in v_id_nodo_sensor int
) begin
	if v_id_nodo_sensor = 0 then
		select id_nodo_sensor, nodos.id_nodo, sensores.id_sensor, sitios.id_sitio, concat(sitios.descripcion, ' (', sitios.clave, ')') as sitio, nodos.descripcion as nodo, nodo_sensor.descripcion as profundidad, sensores.descripcion as sensor
		from nodo_sensor inner join (nodos
		inner join sitios on nodos.id_sitio = sitios.id_sitio) on nodo_sensor.id_nodo = nodos.id_nodo
		inner join sensores on nodo_sensor.id_sensor = sensores.id_sensor;
	elseif not exists (select 1 from nodo_sensor where id_nodo_sensor = v_id_nodo_sensor) then
		select "elemento no encontrado" as mensaje;
	else
		select id_nodo_sensor, descripcion, id_nodo, id_sensor
		from nodo_sensor where id_nodo_sensor = v_id_nodo_sensor;
	end if;
end //
delimiter ;