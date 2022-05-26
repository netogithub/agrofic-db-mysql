delimiter //
create procedure sp_viewGeneros(
	in v_id_genero int
) begin
	if v_id_genero = 0 then
		select id_genero, descripcion, nombre_cientifico
        from generos;
	elseif not exists (select 1 from generos where id_genero = v_id_genero) then
		select "elemento no encontrado" as mensaje;
	else
		select id_genero, descripcion, nombre_cientifico
		from generos where id_genero = v_id_genero;
	end if;
end //
delimiter ;