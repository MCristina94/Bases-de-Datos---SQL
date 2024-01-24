/*1. Listar todos los usuarios que no hayan generado una playlist*/

select nombreusuario, titulo nombre_playlist 
from usuario u
left join playlist p
on u.idUsuario = p.idusuario
where p.titulo is null;

/*2. Listar todas las canciones hayan o no recibido likes (cuántos) y
aclarar si han sido reproducidas o no. Listar las 15 primeras ordenadas
como si fueran un Ranking*/

select titulo, cantlikes, cantreproduccion,
case
	when cantreproduccion > 1 then 	"Cancion Reproducida"  else "Cancion NO Reproducida"
    end as CancionReproducida,
case
	when cantlikes > 1 then "tuvo likes" else "NO tuvo likes"
    end as Likes_canciones
from cancion
order by cantreproduccion desc
limit 15;

/*3. Generar un reporte con el nombre del artista y el nombre de la canción
que no pertenecen a ninguna lista.*/
 
 select artista.Nombre Nombre_Artista, cancion.titulo Titulo_Cancion, playlistxcancion.IdPlaylist
 from cancion
 join album
 on album.idalbum = cancion.idAlbum
 join artista
 on album.idArtista = artista.idartista
 left join playlistxcancion
 on playlistxcancion.idcancion = cancion.idcancion
 where playlistxcancion.IdPlaylist is null;
 

/*4. Listar todas las canciones, el nombre del artista, la razón social de la
discográfica y la cantidad de veces que fue reproducida.*/

 select c.titulo titulo_cancion, ar.nombre Nombre_artista, dis.nombre Nombre_discografica, c.cantreproduccion
 from cancion c 
 join album a
 on c.IdAlbum = a.idAlbum
 join artista ar
 on ar.idArtista = a.idArtista
 join discografica dis;

/*5. Listar todas las discográficas, que pertenezcan a Inglaterra y la
cantidad de álbumes que hayan editado.*/

 select dis.nombre nombre_discografica, pais.Pais, count(album.idAlbum)
 from discografica dis
 join pais
 on dis.idPais = pais.idPais
 join album
 on dis.idDiscografica = album.iddiscografica
group by dis.nombre having Pais = "Inglaterra";

/*6. Listar a todos los artistas que no poseen ningún álbum.*/

select artista.nombre, album.titulo
from artista
left join album
on artista.idArtista = album.idArtista
where album.titulo is null;

/*7. Listar todos los álbumes que tengan alguna canción que posea más de
un género*/

select album.titulo, cancion.idAlbum, count(generoxcancion.idGeneroxCancion) as cant_genero
from album
join cancion
on album.idAlbum =cancion.IdAlbum
join generoxcancion
on cancion.idCancion = generoxcancion.idCancion
join genero
on genero.idGenero = generoxcancion.IdGenero
group by album.titulo having cant_genero > 1;

/*8. Generar un reporte por usuario , listando las suscripciones que tiene o
tuvo, el importe que abonó y los datos de las formas de pago con que
lo realizó.*/

select usuario.nombreusuario, count(suscripcion.idSuscripcion), sum(pagos.importe), tfp.TipoFormaPago
from usuario
join suscripcion
on usuario.idusuario = suscripcion.idusuario
join pagos
on pagos.idpagos = suscripcion.idpagos
join datospagoxusuario dpu
on usuario.idusuario = dpu.idusuario
join tipoformapago tfp
on dpu.idTipoFormaPago = tfp.idTipoFormaPago
group by usuario.nombreusuario, tfp.TipoFormaPago



