delimiter //
create procedure sp_viewUsuarios(
	in v_id_usuario int
) begin
	if v_id_usuario = 0 then
		select id_usuario, estatus, tipo_usuario, concat(nombre, ' ', a_paterno, ' ', a_materno) as nombre, descripcion, email, telefono
        from usuarios;
	elseif not exists (select 1 from usuarios where id_usuario = v_id_usuario) then
		select "elemento no encontrado" as mensaje;
	else
		select id_usuario, estatus, tipo_usuario, nombre, a_paterno, a_materno, descripcion, email, telefono
		from usuarios where id_usuario = v_id_usuario;
	end if;
end //
delimiter ;