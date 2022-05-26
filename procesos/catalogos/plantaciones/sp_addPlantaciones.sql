delimiter //
create procedure sp_addPlantaciones(
	in v_id_plantacion int,
    in v_descripcion varchar(25)
) begin
	declare variable int default 0;
	declare error int default 0;
    declare continue handler for sqlexception set error = 1;
	
	if v_id_plantacion = 0 and exists (select 1 from plantaciones where descripcion = v_descripcion) then
		set variable = 1;
	elseif v_id_plantacion = 0 then
		insert into plantaciones (descripcion)
        values (v_descripcion);
        set v_id_plantacion = last_insert_id();
	elseif not exists (select 1 from plantaciones where id_plantacion = v_id_plantacion) then
		set variable = 2;
	elseif exists (select 1 from plantaciones where not id_plantacion = v_id_plantacion and descripcion = v_descripcion) then
		set variable = 1;
	else
		update plantaciones
		set descripcion = v_descripcion
		where id_plantacion = v_id_plantacion;
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
		select id_plantacion, descripcion
		from plantaciones where id_plantacion = v_id_plantacion;
	end if;
    
end //
delimiter ;