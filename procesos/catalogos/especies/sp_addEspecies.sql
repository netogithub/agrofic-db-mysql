delimiter //
create procedure sp_addEspecies(
	in v_id_especie int,
    in v_descripcion varchar(25),
	in v_nombre_cientifico varchar(25),
	in v_id_genero int
) begin
	declare variable int default 0;
	declare error int default 0;
    declare continue handler for sqlexception set error = 1;
	
	if v_id_especie = 0 and exists (select 1 from especies where descripcion = v_descripcion or nombre_cientifico = v_nombre_cientifico) then
		set variable = 1;
	elseif v_id_especie = 0 then
		insert into especies (descripcion, nombre_cientifico, id_genero)
        values (v_descripcion, v_nombre_cientifico, v_id_genero);
        set v_id_especie = last_insert_id();
	elseif not exists (select 1 from especies where id_especie = v_id_especie) then
		set variable = 2;
	elseif exists (select 1 from especies where not id_especie = v_id_especie and (descripcion = v_descripcion or nombre_cientifico = v_nombre_cientifico)) then
		set variable = 1;
	else
		update especies
		set descripcion = v_descripcion,
		nombre_cientifico = v_nombre_cientifico,
		id_genero = v_id_genero
		where id_especie = v_id_especie;
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
		select id_especie, descripcion, nombre_cientifico, id_genero
		from especies where id_especie = v_id_especie;
	end if;
    
end //
delimiter ;