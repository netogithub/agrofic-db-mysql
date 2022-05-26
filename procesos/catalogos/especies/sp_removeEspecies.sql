delimiter //
create procedure sp_removeEspecies(
	in v_id_especie int
) begin
	declare error int default 0;
    declare continue handler for sqlexception set error = 1;

	if not exists (select 1 from especies where id_especie = v_id_especie) then
		select "elemento no encontrado" as mensaje;
	elseif exists (select 1 from cultivos where id_especie = v_id_especie) then
		select "elemento relacionado" as mensaje;
	else
		delete from especies
		where id_especie = v_id_especie;
		if error = 1 then
			rollback;
		else
			commit;
			select "elemento eliminado" as mensaje;
		end if;
	end if;

end //
delimiter ;