delimiter //
create procedure sp_viewNodos(
	in v_id_nodo int
) begin
	if v_id_nodo = 0 then
		select id_nodo, nodos.descripcion as descripcion, concat(sitios.descripcion, '(', sitios.clave, ')') as sitio, id_sitio
        from nodos inner join sitios on nodos.id_sitio = sitios.id_sitio;
	elseif not exists (select 1 from nodos where id_nodo = v_id_nodo) then
		select "elemento no encontrado" as mensaje;
	else
		select id_nodo, descripcion, latitud, longitud, id_sitio
		from nodos where id_nodo = v_id_nodo;
	end if;
end //
delimiter ;