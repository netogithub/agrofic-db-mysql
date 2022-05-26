delimiter //
create procedure sp_addSitio_Usuario(
	in v_id_sitio_usuario int,
    in v_id_sitio int,
	in v_id_usuario int
) begin
	declare variable int default 0;
	declare error int default 0;
    declare continue handler for sqlexception set error = 1;
	
	if v_id_sitio_usuario = 0 and exists (select 1 from sitio_usuario where id_sitio = v_id_sitio and v_id_usuario = id_usuario) then
		set variable = 1;
	elseif v_id_sitio_usuario = 0 then
		insert into sitio_usuario (id_sitio, id_usuario)
        values (v_id_sitio, v_id_usuario);
        set v_id_sitio_usuario = last_insert_id();
	elseif not exists (select 1 from sitio_usuario where id_sitio_usuario = v_id_sitio_usuario) then
		set variable = 2;
	elseif exists (select 1 from sitio_usuario where not id_sitio_usuario = v_id_sitio_usuario and (id_sitio = v_id_sitio and v_id_usuario = id_usuario)) then
		set variable = 1;
	else
		update sitio_usuario
		set id_sitio = v_id_sitio,
		id_usuario = v_id_usuario
		where id_sitio_usuario = v_id_sitio_usuario;
    end if;

	if error = 1 then
		rollback;
	else
		commit;
	end if;
		
	if variable = 1 then
		select "elemento ya ingresado" as mensaje;
	elseif variable = 2 then
		select "elemento no encontrado" as mensaje;
	else
		select id_sitio_usuario, id_sitio, id_usuario
		from sitio_usuario where id_sitio_usuario = v_id_sitio_usuario;
	end if;
    
end //
delimiter ;