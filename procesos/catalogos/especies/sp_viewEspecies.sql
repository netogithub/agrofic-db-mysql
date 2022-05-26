delimiter //
create procedure sp_viewEspecies(
	in v_id_especie int
) begin
	if v_id_especie = 0 then
		select id_especie, especies.descripcion, concat(generos.nombre_cientifico, ' ', especies.nombre_cientifico) as nombre_cientifico, generos.descripcion as genero
        from especies inner join generos on especies.id_genero = generos.id_genero;
	elseif not exists (select 1 from especies where id_especie = v_id_especie) then
		select "elemento no encontrado" as mensaje;
	else
		select id_especie, descripcion, nombre_cientifico, id_genero
		from especies where id_especie = v_id_especie;
	end if;
end //
delimiter ;