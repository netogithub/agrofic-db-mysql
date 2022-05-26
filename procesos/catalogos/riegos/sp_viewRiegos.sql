delimiter //
create procedure sp_viewRiegos(
	in v_id_riego int
) begin
	if v_id_riego = 0 then
		select id_riego, descripcion, consumo, hora_riego, eficiencia_min, eficiencia_max, diferencial_altura
        from riegos;
	elseif not exists (select 1 from riegos where id_riego = v_id_riego) then
		select "elemento no encontrado" as mensaje;
	else
		select id_riego, descripcion, consumo, hora_riego, eficiencia_min, eficiencia_max, diferencial_altura
		from riegos where id_riego = v_id_riego;
	end if;
end //
delimiter ;