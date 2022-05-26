delimiter //
create procedure sp_listNodos(
	in v_id_sitio int
) begin
	if not exists (select 1 from sitios where id_sitio = v_id_sitio) then
		select "elemento no encontrado" as mensaje;
	else
		select id_nodo, descripcion, latitud, longitud, id_sitio from nodos where id_sitio = v_id_sitio;
	end if;
    
end //
delimiter ;