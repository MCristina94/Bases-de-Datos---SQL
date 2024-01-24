/*1. Mostrar el nombre de usuario y contar la cantidad de playlist que tiene.*/

select playlist.idusuario, usuario.nombreusuario, count(idplaylist)
from playlist
inner join usuario
on playlist.idusuario = usuario.idUsuario
group by usuario.nombreusuario;

/*solucion vero*/
select nombreusuario, usuario.idusuario, count(idPlaylist) as cantidad from playlist
join usuario
on usuario.idUsuario = playlist.idusuario
group by nombreusuario;


/*2. Generar un reporte, donde se muestre el método de pago , la cantidad
de operaciones que se realizaron con cada uno y el importe total .
*/
select tfp.TipoFormaPago, dpu.idusuario, dpu.idTipoFormaPago, count(dpu.idTipoFormaPago), sum(pagos.importe)
from tipoformapago tfp
inner join datospagoxusuario dpu
on tfp.idTipoFormaPago = dpu.idTipoFormaPago
inner join usuario
on dpu.idusuario = usuario.idUsuario
inner join suscripcion
on suscripcion.idusuario = usuario.idUsuario
inner join pagos
on suscripcion.idpagos = pagos.idpagos
group by dpu.idTipoFormaPago;

/*solucion vero*/
select t.tipoformapago, count(p.idPagos) as cantidad_operaciones, sum(importe) as importe_total  
 from tipoformapago t
 join datospagoxusuario dp on t.idTipoFormaPago = dp.idTipoFormaPago
 join usuario u on u.idUsuario = dp.idusuario
 join suscripcion s on s.idusuario = u.idUsuario
 join pagos p on p.idPagos = s.idpagos
 group by t.TipoFormaPago;
 
/*3. Listar las canciones que tienen los artistas cuyo nombre contiene la
letra “r” y el pertenecen al código de género 20.*/

select cancion.titulo, artista.nombre
from cancion
inner join album
on album.idAlbum = cancion.idAlbum
inner join artista
on album.idArtista = artista.idArtista
inner join generoxcancion
on cancion.idCancion = generoxcancion.idCancion
inner join genero
on generoxcancion.idGenero = genero.idGenero
where artista.nombre like '%r%' and generoxcancion.idGenero = 20;

/*solucion vero*/
select c.titulo from cancion c
join generoxcancion gc
on c.idCancion = gc.IdCancion
join album a
on a.idAlbum = c.IdAlbum
join artista ar
on a.idArtista = ar.idArtista
where ar.nombre like "%r%" and IdGenero = 20;


/*4. Listar todos los usuarios que pagaron con efectivo y la fecha de
pago sea del 2020*/

select usuario.nombreusuario
from tipoformapago tfp
inner join datospagoxusuario dpu
on tfp.idTipoFormaPago = dpu.idTipoFormaPago
inner join usuario
on dpu.idusuario = usuario.idUsuario
inner join suscripcion
on suscripcion.idusuario = usuario.idUsuario
inner join pagos
on suscripcion.idpagos = pagos.idpagos
where TipoFormaPago = "efectivo" and year(fechapago) = 2020
group by usuario.nombreusuario;

/*solucion vero*/
select distinct nombreusuario 
from tipoformapago t
join datospagoxusuario dp on t.idTipoFormaPago = dp.idTipoFormaPago
join usuario u on u.idUsuario = dp.idusuario
join suscripcion s on s.idusuario = u.idUsuario
join pagos p on p.idPagos = s.idpagos
where TipoFormaPago = "efectivo" and year(fechaPago) = 2020;

/*5. Generar un reporte de todas las canciones, cuyo álbum no posee
imagen de portada.
*/
/*duda*/
select idcancion, cancion.titulo, album.imagenportada
from cancion
inner join album
on cancion.idAlbum = album.idAlbum
where album.imagenportada is null;

/*solucion vero*/
select c.* from cancion c
join album a
on a.idAlbum = c.IdAlbum
where imagenportada is null;

/*6. Genera un reporte por género e informar la cantidad de canciones que
posee. Si una canción tiene más de un género, debe ser incluida en la
cuenta de cada uno de esos géneros.
*/

select genero.idGenero, genero.genero, count(cancion.titulo)
from cancion
inner join generoxcancion
on cancion.idCancion = generoxcancion.idCancion
inner join genero
on generoxcancion.idGenero = genero.idGenero
group by genero.idGenero;

/*solucion vero*/
select g.genero, count(c.idCancion) as cantidad from cancion c
join generoxcancion gc
on c.idCancion = gc.IdCancion
join genero g
on g.idGenero = gc.IdGenero
group by g.genero;

/*7. Listar todos las playlist que no están en estado activo y a que usuario
pertenecen , ordenado por la fecha de eliminación.
*/
/*duda*/

select playlist.titulo, usuario.idusuario, usuario.nombreusuario, playlist.idestado, playlist.fechaEliminada, estadoplaylist.descripcion
from usuario
inner join playlist
on playlist.idusuario = usuario.idUsuario
inner join estadoplaylist
on playlist.idestado = estadoplaylist.idEstadoPlaylist
group by playlist.titulo having playlist.idestado = 2
order by playlist.FechaEliminada asc;

/*solucion vero*/
select playlist.titulo, usuario.nombreusuario, descripcion,Fechaeliminada from playlist
join estadoplaylist
on playlist.idestado = estadoplaylist.idEstadoPlaylist
join usuario
on usuario.idUsuario = playlist.idusuario
where estadoplaylist.descripcion = "eliminada"
order by Fechaeliminada;

/*8. Generar un reporte que muestre por tipo de usuario, la cantidad de
usuarios que posee*/

select count(usuario.idUsuario), usuario.idTipoUsuario, tipousuario.tipoUsuario
from usuario
inner join tipousuario
on usuario.idTipousuario = tipousuario.idTipoUsuario
group by tipousuario.tipoUsuario;

/*solucion vero*/
select t.TipoUsuario, count(idUsuario) as cantidad from usuario u
join tipousuario t
on t.idTipoUsuario = u.IdTipoUsuario
group by t.TipoUsuario;

/*9. Listar la suma total obtenida por cada tipo de suscripción, en el periodo
del 01-01-2020 al 31-12-2020*/

/*MALA*/
select count(usuario.idTipoUsuario), tipousuario.TipoUsuario
from usuario
inner join tipousuario
on usuario.idTipoUsuario = tipousuario.idTipoUsuario
inner join suscripcion
on usuario.idUsuario = suscripcion.idusuario
where suscripcion.FechaInicio between "2020-01-01" and "2020-12-31"
group by usuario.idTipoUsuario;

/*solucion vero*/

select tu.TipoUsuario, sum(importe) as suma_total from suscripcion s
join pagos p
on s.idpagos = p.idPagos
join tipousuario tu
on tu.idTipoUsuario = s.IdTipoUsuario
where fechaPago between "2020-01-01" and "2020-12-31"
group by tu.TipoUsuario;

/*10.Listar el álbum y la discográfica que posea la canción con más
reproducciones*/

/*MALA*/
select a.titulo, d.nombre, c.cantreproduccion
from album a
join cancion c
on a.idAlbum = c.idAlbum
join discografica d
on d.idDiscografica = a.iddiscografica
order by c.cantreproduccion desc
limit 1;



/*solucion vero*/
select a.titulo, d.nombre from album a
join discografica d
on a.iddiscografica = d.idDiscografica
join cancion c
on c.IdAlbum = a.idAlbum
order by c.cantreproduccion desc
limit 1;

/*para visualizar*/
select album.titulo, discografica.nombre, cancion.cantreproduccion
from album
inner join cancion
on album.idAlbum = cancion.idAlbum
inner join discografica
on discografica.idDiscografica = album.iddiscografica
order by cantreproduccion desc;


select cantlikes, case when cantlikes > 7500 then cantlikes else 'No cumple' 
						end datos_like
from cancion;


