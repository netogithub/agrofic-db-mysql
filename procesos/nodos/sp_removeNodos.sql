delimiter //
create procedure sp_removeNodos(
	in v_id_nodo int
) begin
	declare error int default 0;
    declare continue handler for sqlexception set error = 1;

	if not exists (select 1 from nodos where id_nodo = v_id_nodo) then
		select "elemento no encontrado" as mensaje;
	elseif exists (select 1 from nodo_sensor where id_nodo = v_id_nodo) then
		select "elemento relacionado" as mensaje;
	else
		delete from nodos
		where id_nodo = v_id_nodo;
		if error = 1 then
			rollback;
		else
			commit;
			select "elemento eliminado" as mensaje;
		end if;
	end if;

end //
delimiter ;