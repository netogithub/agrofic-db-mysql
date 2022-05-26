delimiter //
create procedure sp_removePlantaciones(
	in v_id_plantacion int
) begin
	declare error int default 0;
    declare continue handler for sqlexception set error = 1;

	if not exists (select 1 from plantaciones where id_plantacion = v_id_plantacion) then
		select "elemento no encontrado" as mensaje;
	elseif exists (select 1 from sitios where id_plantacion = v_id_plantacion) then
		select "elemento relacionado" as mensaje;
	else
		delete from plantaciones
		where id_plantacion = v_id_plantacion;
		if error = 1 then
			rollback;
		else
			commit;
			select "elemento eliminado" as mensaje;
		end if;
	end if;

end //
delimiter ;