delimiter //
create procedure sp_viewPlantaciones(
	in v_id_plantacion int
) begin
	if v_id_plantacion = 0 then
		select id_plantacion, descripcion
        from plantaciones;
	elseif not exists (select 1 from plantaciones where id_plantacion = v_id_plantacion) then
		select "elemento no encontrado" as mensaje;
	else
		select id_plantacion, descripcion
		from plantaciones where id_plantacion = v_id_plantacion;
	end if;
end //
delimiter ;