delimiter //
create procedure sp_removeRiegos(
	in v_id_riego int
) begin
	declare error int default 0;
    declare continue handler for sqlexception set error = 1;

	if not exists (select 1 from riegos where id_riego = v_id_riego) then
		select "elemento no encontrado" as mensaje;
	elseif exists (select 1 from sitios where id_riego = v_id_riego) then
		select "elemento relacionado" as mensaje;
	else
		delete from riegos
		where id_riego = v_id_riego;
		if error = 1 then
			rollback;
		else
			commit;
			select "elemento eliminado" as mensaje;
		end if;
	end if;

end //
delimiter ;