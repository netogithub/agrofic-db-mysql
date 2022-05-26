delimiter //
create procedure sp_removeCultivos(
	in v_id_cultivo int
) begin
	declare error int default 0;
    declare continue handler for sqlexception set error = 1;

	if not exists (select 1 from cultivos where id_cultivo = v_id_cultivo) then
		select "elemento no encontrado" as mensaje;
	elseif exists (select 1 from sitios where id_cultivo = v_id_cultivo) then
		select "elemento relacionado" as mensaje;
	else
		delete from cultivos
		where id_cultivo = v_id_cultivo;
		if error = 1 then
			rollback;
		else
			commit;
			select "elemento eliminado" as mensaje;
		end if;
	end if;

end //
delimiter ;