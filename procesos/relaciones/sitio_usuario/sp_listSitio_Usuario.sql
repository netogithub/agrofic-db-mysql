delimiter //
create procedure sp_listSitio_Usuario(
	in v_id_usuario int
) begin
	if not exists (select 1 from usuarios where id_usuario = v_id_usuario) then
		select "elemento no encontrado" as mensaje;
	else
		select id_sitio_usuario, sitios.id_sitio, clave, sitios.descripcion as descripcion, latitud, longitud, id_cultivo, id_suelo, id_riego, id_plantacion
		from sitio_usuario
		inner join sitios on sitio_usuario.id_sitio = sitios.id_sitio
		inner join usuarios on sitio_usuario.id_usuario = usuarios.id_usuario
		where sitio_usuario.id_usuario = v_id_usuario;
	end if;
end //
delimiter ;