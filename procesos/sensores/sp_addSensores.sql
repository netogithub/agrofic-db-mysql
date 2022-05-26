delimiter //
create procedure sp_addSensores(
	in v_id_sensor int,
    in v_descripcion varchar(25),
	in v_marca varchar(25),
	in v_modelo varchar(25)
) begin
	declare variable int default 0;
	declare error int default 0;
    declare continue handler for sqlexception set error = 1;
	
	if v_id_sensor = 0 and exists (select 1 from sensores where descripcion = v_descripcion or modelo = v_modelo) then
		set variable = 1;
	elseif v_id_sensor = 0 then
		insert into sensores (descripcion, marca, modelo)
        values (v_descripcion, v_marca, v_modelo);
        set v_id_sensor = last_insert_id();
	elseif not exists (select 1 from sensores where id_sensor = v_id_sensor) then
		set variable = 2;
	elseif exists (select 1 from sensores where not id_sensor = v_id_sensor and (descripcion = v_descripcion or modelo = v_modelo)) then
		set variable = 1;
	else
		update sensores
		set descripcion = v_descripcion,
		marca = v_marca,
		modelo = v_modelo
		where id_sensor = v_id_sensor;
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
		select id_sensor, descripcion, marca, modelo
		from sensores where id_sensor = v_id_sensor;
	end if;
    
end //
delimiter ;