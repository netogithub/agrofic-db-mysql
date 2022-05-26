delimiter //
create procedure sp_addCultivos(
	in v_id_cultivo int,
    in v_descripcion varchar(30),
	in v_deficit_min int,
	in v_deficit_max int,
	in v_p_raiz_min double,
	in v_p_raiz_max double,
	in v_tension_min int,
	in v_tension_max int,
	in v_id_especie int
) begin
	declare variable int default 0;
	declare error int default 0;
    declare continue handler for sqlexception set error = 1;
	
	if v_id_cultivo = 0 and exists (select 1 from cultivos where descripcion = v_descripcion) then
		set variable = 1;
	elseif v_id_cultivo = 0 then
		insert into cultivos (descripcion, deficit_min, deficit_max, p_raiz_min, p_raiz_max, tension_min, tension_max, id_especie)
        values (v_descripcion, v_deficit_min, v_deficit_max, v_p_raiz_min, v_p_raiz_max, v_tension_min, v_tension_max, v_id_especie);
        set v_id_cultivo = last_insert_id();
	elseif not exists (select 1 from cultivos where id_cultivo = v_id_cultivo) then
		set variable = 2;
	elseif exists (select 1 from cultivos where not id_cultivo = v_id_cultivo and descripcion = v_descripcion) then
		set variable = 1;
	else
		update cultivos
		set descripcion = v_descripcion,
		deficit_min = v_deficit_min,
		deficit_max = v_deficit_max,
		p_raiz_min = v_p_raiz_min,
		p_raiz_max = v_p_raiz_max,
		tension_min = v_tension_min,
		tension_max = v_tension_max,
		id_especie = v_id_especie
		where id_cultivo = v_id_cultivo;
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
		select id_cultivo, descripcion, deficit_min, deficit_max, p_raiz_min, p_raiz_max, tension_min, tension_max, id_especie
		from cultivos where id_cultivo = v_id_cultivo;
	end if;
    
end //
delimiter ;