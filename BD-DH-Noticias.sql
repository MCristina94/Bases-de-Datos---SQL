/*1. Listar todos los autores cuyo nombre comience con la letra "A". Se debe mostrar
id como "Número de Autor", apellido, nombre y su correo electrónico.*/
select id as 'Numero de autor', apellido, nombre, email from autores where nombre like 'A%';

/*2. Mostrar el nombre, apellido y el password del usuario con teléfono
"5492645661478".*/
select nombre, apellido, password from usuario where telefono_movil = '5492645661478';

/*3. Calcular la cantidad de artículos o posts que se encuentran inactivos (donde el
estado es igual a cero) en nuestro blog. El Reporte debe tener dos columnas
"Estado" y "Cantidad de Artículos".*/
select estadoart as Estado, count(*) as 'Cantidad Articulos' from articulos where estadoart = 0;

/*4. Listar los recursos utilizados con números 8, 16, 29, 35.*/
select * from articulos where id in (8,16,23,35);

/*5. Se requiere saber cuál es la fecha de publicación del primer artículo de
DH-Noticias, para este informe se requiere dos columnas con la fecha de
publicación y el título del artículo.*/
select min(fechapublicacion), titulo from articulos;

/*6. Listar los nombres y la ubicación de todos los recursos del tipo audio que se
utilizaron en los artículos publicados.*/
select nombre_recurso, ruta from recursos where tiposrecursos_id = 1;

/*7. Listar de manera ordenada y ascendente por fecha de nacimiento, los usuarios
que no sean oriundos de la ciudad "Las Condes-Santiago" y que la fecha de
nacimiento sea mayor que 3/9/1989 o igual a 7/11/1986.*/
select nombre, apellido, fecha_nacimiento from usuario where ciudad_id != 6 and fecha_nacimiento > 1989-9-3 or fecha_nacimiento = 1986-11-7;

/*8. Listar los artículos de Deportes, específicamente de la subcategoría futbol y que
la fecha de alta sea mayor que 5/09/21 o igual a 25/06/21. Ordenar por fecha de
alta.*/

select * from articulos where subcategorias_id = 1 and fechalta > 5/09/21 or fechalta = 25/06/21 order by fechalta;

/*9. Listar todos los comentarios del mes de octubre que contengan la palabra
"Gracias", para este reporte necesitamos mostrar la fecha de publicación y el
comentario. */

select Fecha, Cometario from comentarios where month(Fecha)=10 and Cometario like '%gracias%';

/*10. Mostrar el título y contenido del último artículo publicado por el autor
"Guillermina Lucia Martín". */
select autores_id, titulo, contenido, max(fechapublicacion) from articulos where autores_id=13;

/*11. Listar los comentarios registrados entre 14/07/21 al 15/08/21 y ordenarlas por
fecha teniendo en cuenta un orden de más antigua a reciente.*/
select cometario, Fecha from comentarios where Fecha >= 14/07/21 or Fecha <=15/08/21 order by fecha asc;

/*12. Listar todos los autores cuyo nombre termine con los caracteres "ia". Se debe
mostrar el apellido, nombre y teléfono móvil. */
select apellido, nombre, telefono_movil from autores where nombre like '%ia';

/*13. Calcular el total de artículos publicados en el año 2021 en DH-noticias.*/
select count(*) as 'total articulos' from articulos where year(fechapublicacion) = 2021; 

/*14. Mostrar el quinto artículo publicado más antiguo durante el año 2022. */
select * from articulos where year(fechapublicacion)=2022 order by fechapublicacion asc limit 1 offset 4 ;

/*15. La fecha de publicación del primer post que se realizó en DH-Noticias fue el
"2019-03-03" , lo que necesitamos calcular es cuantos días transcurrieron hasta
el día de hoy. */
select datediff(now(), '2019-03-03');

/*16. Mostrar todas las ciudades que contengan una palabra de cinco caracteres, pero
el tercer carácter debe ser igual a "n".*/
select nombre from ciudad where nombre like '__n__%' or '% __n__ %' or '%__n__';

/*17. Modificar el tipo de categoría "Cultura y Arte" a solo "Cultura".*/
UPDATE categorias set nombre_categoria = 'Cultura' where nombre_categoria= 'Cultura y Arte';

/*18. Listar el nombre de todas las categorías inactivas (el estado de la categoría es
igual a cero) en nuestro blog*/

select nombre_categoria from categorias where estado_categoria=0;

/*19. Agregar al usuario Aznar Ricardo Omar cuyo usuario es rica28, contraseña
az123, proveniente de la ciudad de 'Las Heras - Mendoza’, fecha de nacimiento
5/1/1980, teléfono móvil +542645667714 y el correo electrónico es
pal1980sj@gmail.com.*/
insert usuario (nombre, apellido, usuario, password, ciudad_id, fecha_nacimiento, telefono_movil, email) 
values ('Aznar Ricardo', 'Omar', 'rica28', 'az123', 6, '1980-01-05', '+542645667714', 'pal1980sj@gmail.com.');

