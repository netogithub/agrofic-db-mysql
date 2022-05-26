delimiter //
create procedure sp_addSuelos(
	in v_id_suelo int,
    in v_descripcion varchar(45),
	in v_capacidad_campo double,
	in v_punto_marchites double,
	in v_agua_disponible double
) begin
	declare variable int default 0;
	declare error int default 0;
    declare continue handler for sqlexception set error = 1;
	
	if v_id_suelo = 0 and exists (select 1 from suelos where descripcion = v_descripcion) then
		set variable = 1;
	elseif v_id_suelo = 0 then
		insert into suelos (descripcion, capacidad_campo, punto_marchites, agua_disponible)
        values (v_descripcion, v_capacidad_campo, v_punto_marchites, v_agua_disponible);
        set v_id_suelo = last_insert_id();
	elseif not exists (select 1 from suelos where id_suelo = v_id_suelo) then
		set variable = 2;
	elseif exists (select 1 from suelos where not id_suelo = v_id_suelo and descripcion = v_descripcion) then
		set variable = 1;
	else
		update suelos
		set descripcion = v_descripcion,
		capacidad_campo = v_capacidad_campo,
		punto_marchites = v_punto_marchites,
		agua_disponible = v_agua_disponible
		where id_suelo = v_id_suelo;
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
		select id_suelo, descripcion, capacidad_campo, punto_marchites, agua_disponible
		from suelos where id_suelo = v_id_suelo;
	end if;
    
end //
delimiter ;