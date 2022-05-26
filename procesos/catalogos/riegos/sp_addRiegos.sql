delimiter //
create procedure sp_addRiegos(
	in v_id_riego int,
    in v_descripcion varchar(25),
	in v_consumo int,
	in v_hora_riego int,
	in v_eficiencia_min int,
	in v_eficiencia_max int,
	in v_diferencial_altura int
) begin
	declare variable int default 0;
	declare error int default 0;
    declare continue handler for sqlexception set error = 1;
	
	if v_id_riego = 0 and exists (select 1 from riegos where descripcion = v_descripcion) then
		set variable = 1;
	elseif v_id_riego = 0 then
		insert into riegos (descripcion, consumo, hora_riego, eficiencia_min, eficiencia_max, diferencial_altura)
        values (v_descripcion, v_consumo, v_hora_riego, v_eficiencia_min, v_eficiencia_max, v_diferencial_altura);
        set v_id_riego = last_insert_id();
	elseif not exists (select 1 from riegos where id_riego = v_id_riego) then
		set variable = 2;
	elseif exists (select 1 from riegos where not id_riego = v_id_riego and descripcion = v_descripcion) then
		set variable = 1;
	else
		update riegos
		set descripcion = v_descripcion,
		consumo = v_consumo,
		hora_riego = v_hora_riego,
		eficiencia_min = v_eficiencia_min,
		eficiencia_max = v_eficiencia_max,
		diferencial_altura = v_diferencial_altura
		where id_riego = v_id_riego;
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
		select id_riego, descripcion, consumo, hora_riego, eficiencia_min, eficiencia_max, diferencial_altura
		from riegos where id_riego = v_id_riego;
	end if;
    
end //
delimiter ;