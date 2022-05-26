delimiter //
create procedure sp_viewSuelos(
	in v_id_suelo int
) begin
	if v_id_suelo = 0 then
		select id_suelo, descripcion, capacidad_campo, punto_marchites, agua_disponible
        from suelos;
	elseif not exists (select 1 from suelos where id_suelo = v_id_suelo) then
		select "elemento no encontrado" as mensaje;
	else
		select id_suelo, descripcion, capacidad_campo, punto_marchites, agua_disponible
		from suelos where id_suelo = v_id_suelo;
	end if;
end //
delimiter ;