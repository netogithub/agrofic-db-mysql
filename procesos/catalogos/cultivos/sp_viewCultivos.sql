delimiter //
create procedure sp_viewCultivos(
	in v_id_cultivo int
) begin
	if v_id_cultivo = 0 then
		select id_cultivo, concat(especies.descripcion, ' ', cultivos.descripcion) as descripcion, concat(generos.nombre_cientifico, ' ', especies.nombre_cientifico) as nombre_cientifico, deficit_min, deficit_max, p_raiz_min, p_raiz_max, tension_min, tension_max, cultivos.id_especie
        from cultivos inner join (especies inner join generos on especies.id_genero = generos.id_genero) on cultivos.id_especie = especies.id_especie;
	elseif not exists (select 1 from cultivos where id_cultivo = v_id_cultivo) then
		select "elemento no encontrado" as mensaje;
	else
		select id_cultivo, descripcion, deficit_min, deficit_max, p_raiz_min, p_raiz_max, tension_min, tension_max, id_especie
		from cultivos where id_cultivo = v_id_cultivo;
	end if;
end //
delimiter ;