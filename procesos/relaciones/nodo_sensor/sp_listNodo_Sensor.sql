delimiter //
create procedure sp_listNodo_Sensor(
	in v_id_nodo int
) begin
	if not exists (select 1 from nodos where id_nodo = v_id_nodo) then
		select "elemento no encontrado" as mensaje;
	else
		select id_nodo_sensor, nodo_sensor.descripcion as profundidad, sensores.descripcion as descripcion, sensores.marca, sensores.modelo, nodo_sensor.id_nodo
		from nodo_sensor inner join (nodos
		inner join sitios on nodos.id_sitio = sitios.id_sitio) on nodo_sensor.id_nodo = nodos.id_nodo
		inner join sensores on nodo_sensor.id_sensor = sensores.id_sensor
		where nodo_sensor.id_nodo = v_id_nodo;
	end if;
end //
delimiter ;