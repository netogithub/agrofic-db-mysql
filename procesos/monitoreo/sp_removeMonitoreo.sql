delimiter //
create procedure sp_removeMonitoreo(
	in v_id_monitoreo int
) begin
	declare error int default 0;
    declare continue handler for sqlexception set error = 1;

	if not exists (select 1 from monitoreo where id_monitoreo = v_id_monitoreo) then
		select "elemento no encontrado" as mensaje;
	else
		delete from monitoreo
		where id_monitoreo = v_id_monitoreo;
		if error = 1 then
			rollback;
		else
			commit;
			select "elemento eliminado" as mensaje;
		end if;
	end if;

end //
delimiter ;