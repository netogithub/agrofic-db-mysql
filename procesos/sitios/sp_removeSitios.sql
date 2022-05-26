delimiter //
create procedure sp_removeSitios(
	in v_id_sitio int
) begin
	declare variable int default 0;
	declare error int default 0;
    declare continue handler for sqlexception set error = 1;

	if not exists (select 1 from sitios where id_sitio = v_id_sitio) then
		set variable = 1;
	elseif exists (select 1 from sitio_usuario where id_sitio = v_id_sitio) then
		set variable = 2;
	elseif exists (select 1 from nodos where id_sitio = v_id_sitio) then
		set variable = 2;
	elseif exists (select 1 from monitoreo where id_sitio = v_id_sitio) then
		set variable = 2;
	else
		delete from sitios
		where id_sitio = v_id_sitio;
		
	end if;

	if error = 1 then
		rollback;
	else
		commit;
	end if;

	if variable = 1 then
		select "elemento no encontrado" as mensaje;
	elseif variable = 2 then
		select "elemento relacionado" as mensaje;
	else
		select "elemento eliminado" as mensaje;
	end if;

end //
delimiter ;