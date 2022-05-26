delimiter //
create procedure sp_viewSitios(
	in v_id_sitio int
) begin
	if v_id_sitio = 0 then
		select id_sitio, clave, sitios.descripcion as descripcion, concat(especies.descripcion, ' ', cultivos.descripcion) as cultivo, suelos.descripcion as suelo, riegos.descripcion as riego, plantaciones.descripcion as plantacion, id_cultivo, id_suelo, id_riego, id_plantacion
		from sitios inner join (cultivos
		inner join especies on cultivos.id_especie = especies.id_especie) on sitios.id_cultivo = cultivos.id_cultivo
		inner join suelos on sitios.id_suelo = suelos.id_suelo
		inner join riegos on sitios.id_riego = riegos.id_riego
		inner join plantaciones on sitios.id_plantacion = plantaciones.id_plantacion;
	elseif not exists (select 1 from sitios where id_sitio = v_id_sitio) then
		select "elemento no encontrado" as mensaje;
	else
		select id_sitio, estatus, clave, descripcion, latitud, longitud, id_cultivo, id_suelo, id_riego, id_plantacion
		from sitios where id_sitio = v_id_sitio;
	end if;
end //
delimiter ;