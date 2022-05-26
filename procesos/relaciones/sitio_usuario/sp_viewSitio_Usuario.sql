delimiter //
create procedure sp_viewSitio_Usuario(
	in v_id_sitio_usuario int
) begin
	if v_id_sitio_usuario = 0 then
		select id_sitio_usuario, sitios.id_sitio, usuarios.id_usuario, concat('(', sitios.clave, ') ', sitios.descripcion) as sitio, concat(usuarios.nombre, ' ', usuarios.a_paterno, ' ', usuarios.a_materno) as usuario, usuarios.descripcion
		from sitio_usuario
		inner join sitios on sitio_usuario.id_sitio = sitios.id_sitio
		inner join usuarios on sitio_usuario.id_usuario = usuarios.id_usuario;
	elseif not exists (select 1 from sitio_usuario where id_sitio_usuario = v_id_sitio_usuario) then
		select "elemento no encontrado" as mensaje;
	else
		select id_sitio_usuario, id_sitio, id_usuario
		from sitio_usuario where id_sitio_usuario = v_id_sitio_usuario;
	end if;
end //
delimiter ;