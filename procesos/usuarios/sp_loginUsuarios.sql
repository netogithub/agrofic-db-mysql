delimiter //
create procedure sp_loginUsuarios(
	in v_username varchar(15)
) begin
	if not exists (select 1 from usuarios where username = v_username) then
		select "elemento no encontrado" as mensaje;
	else
		select id_usuario, estatus, tipo_usuario, username, pass, nombre, a_paterno, a_materno, descripcion, email, telefono
		from usuarios where v_username = username;
	end if;
end //
delimiter ;