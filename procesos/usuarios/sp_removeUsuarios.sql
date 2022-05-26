delimiter //
create procedure sp_removeUsuarios(
	in v_id_usuario int
) begin
	declare error int default 0;
    declare continue handler for sqlexception set error = 1;

	if not exists (select 1 from usuarios where id_usuario = v_id_usuario) then
		select "elemento no encontrado" as mensaje;
	elseif exists (select 1 from sitio_usuario where id_usuario = v_id_usuario) then
		select "elemento relacionado" as mensaje;
	else
		delete from usuarios
		where id_usuario = v_id_usuario;
		if error = 1 then
			rollback;
		else
			commit;
			select "elemento eliminado" as mensaje;
		end if;
	end if;

end //
delimiter ;