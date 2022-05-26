delimiter //
create procedure sp_removeGeneros(
	in v_id_genero int
) begin
	declare error int default 0;
    declare continue handler for sqlexception set error = 1;

	if not exists (select 1 from generos where id_genero = v_id_genero) then
		select "elemento no encontrado" as mensaje;
	elseif exists (select 1 from especies where id_genero = v_id_genero) then
		select "elemento relacionado" as mensaje;
	else
		delete from generos
		where id_genero = v_id_genero;
		if error = 1 then
			rollback;
		else
			commit;
			select "elemento eliminado" as mensaje;
		end if;
	end if;

end //
delimiter ;