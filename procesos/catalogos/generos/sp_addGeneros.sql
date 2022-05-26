delimiter //
create procedure sp_addGeneros(
	in v_id_genero int,
    in v_descripcion varchar(15),
	in v_nombre_cientifico varchar(15)
) begin
	declare variable int default 0;
	declare error int default 0;
    declare continue handler for sqlexception set error = 1;
	
	if v_id_genero = 0 and exists (select 1 from generos where descripcion = v_descripcion or nombre_cientifico = v_nombre_cientifico) then
		set variable = 1;
	elseif v_id_genero = 0 then
		insert into generos (descripcion, nombre_cientifico)
        values (v_descripcion, v_nombre_cientifico);
        set v_id_genero = last_insert_id();
	elseif not exists (select 1 from generos where id_genero = v_id_genero) then
		set variable = 2;
	elseif exists (select 1 from generos where not id_genero = v_id_genero and (descripcion = v_descripcion or nombre_cientifico = v_nombre_cientifico)) then
		set variable = 1;
	else
		update generos
		set descripcion = v_descripcion,
		nombre_cientifico = v_nombre_cientifico
		where id_genero = v_id_genero;
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
		select id_genero, descripcion, nombre_cientifico
		from generos where id_genero = v_id_genero;
	end if;
    
end //
delimiter ;