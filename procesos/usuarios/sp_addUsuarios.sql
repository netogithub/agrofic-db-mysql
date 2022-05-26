delimiter //
create procedure sp_addUsuarios(
	in v_id_usuario int,
    in v_estatus int,
	in v_tipo_usuario int,
	in v_username varchar(15),
	in v_pass varchar(64),
	in v_nombre varchar(35),
	in v_a_paterno varchar(25),
	in v_a_materno varchar(25),
	in v_descripcion varchar(35),
	in v_email varchar(45),
	in v_telefono varchar(15)
) begin
	declare variable int default 0;
	declare error int default 0;
    declare continue handler for sqlexception set error = 1;
	
	if v_id_usuario = 0 and exists (select 1 from usuarios where username = v_username or email = v_email
	or(nombre = v_nombre and a_paterno = v_a_paterno and a_materno = v_a_materno)) then
		set variable = 1;
	elseif v_id_usuario = 0 then
		insert into usuarios (estatus, tipo_usuario, username, pass, nombre, a_paterno, a_materno, descripcion, email, telefono)
        values (v_estatus, v_tipo_usuario, v_username, v_pass, v_nombre, v_a_paterno, v_a_materno, v_descripcion, v_email, v_telefono);
        set v_id_usuario = last_insert_id();
	elseif not exists (select 1 from usuarios where id_usuario = v_id_usuario) then
		set variable = 2;
	elseif exists (select 1 from usuarios where not id_usuario = v_id_usuario and (username = v_username or email = v_email
	or (nombre = v_nombre and a_paterno = v_a_paterno and a_materno = v_a_materno))) then
		set variable = 1;
	else
		update usuarios
		set nombre = v_nombre,
		a_paterno = v_a_paterno,
		a_materno = v_a_materno,
		descripcion = v_descripcion,
		email = v_email,
		telefono = v_telefono
		where id_usuario = v_id_usuario;
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
		select id_usuario, estatus, tipo_usuario, nombre, a_paterno, a_materno, descripcion, email, telefono
		from usuarios where id_usuario = v_id_usuario;
	end if;
    
end //
delimiter ;