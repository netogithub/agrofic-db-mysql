delimiter //
create procedure sp_removeSuelos(
	in v_id_suelo int
) begin
	declare error int default 0;
    declare continue handler for sqlexception set error = 1;

	if not exists (select 1 from suelos where id_suelo = v_id_suelo) then
		select "elemento no encontrado" as mensaje;
	elseif exists (select 1 from sitios where id_suelo = v_id_suelo) then
		select "elemento relacionado" as mensaje;
	else
		delete from suelos
		where id_suelo = v_id_suelo;
		if error = 1 then
			rollback;
		else
			commit;
			select "elemento eliminado" as mensaje;
		end if;
	end if;

end //
delimiter ;