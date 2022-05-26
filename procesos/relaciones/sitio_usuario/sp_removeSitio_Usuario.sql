delimiter //
create procedure sp_removeSitio_Usuario(
	in v_id_sitio_usuario int
) begin
	declare error int default 0;
    declare continue handler for sqlexception set error = 1;

	if not exists (select 1 from sitio_usuario where id_sitio_usuario = v_id_sitio_usuario) then
		select "elemento no encontrado" as mensaje;
	else
		delete from sitio_usuario
		where id_sitio_usuario = v_id_sitio_usuario;
		if error = 1 then
			rollback;
		else
			commit;
			select "elemento eliminado" as mensaje;
		end if;
	end if;

end //
delimiter ;