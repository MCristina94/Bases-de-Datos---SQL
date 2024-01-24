select facturas.facturaID, facturadetalle.facturaID, facturas.FechaFactura, correos.compania, 
clientes.compania As nombreCliente, categorias.CategoriaNombre, productos.ProductoNombre, facturadetalle.PrecioUnitario, facturadetalle.cantidad
from facturas
inner join facturadetalle
on facturas.FacturaID = facturadetalle.FacturaID
inner join correos
on facturas.EnvioVia = correos.CorreoID
inner join clientes
on facturas.clienteID = clientes.ClienteID
inner join productos
on productos.ProductoID = facturadetalle.ProductoID
inner join categorias
on categorias.CategoriaID = productos.CategoriaID;

/*1. Listar todas las categorías junto con información de sus productos. Incluir todas
las categorías aunque no tengan productos.*/

select * 
from categorias
left join productos
on categorias.CategoriaID = productos.CategoriaID;

/*Listar la información de contacto de los clientes que no hayan comprado nunca
en emarket.*/
select *
from clientes
left join facturas
on facturas.ClienteID = clientes.ClienteID
where facturas.clienteID is null;

/*Realizar un listado de productos. Para cada uno indicar su nombre, categoría, y
la información de contacto de su proveedor. Tener en cuenta que puede haber
productos para los cuales no se indicó quién es el proveedor.*/

select productos.ProductoNombre, productos.CategoriaID, proveedores.Contacto, proveedores.Telefono
from productos
right join proveedores
on productos.ProveedorID = proveedores.ProveedorID;

/*Para cada categoría listar el promedio del precio unitario de sus productos.*/

select categorias.CategoriaID, categorias.CategoriaNombre, PrecioUnitario, AVG(PrecioUnitario)
from categorias
inner join productos
on categorias.CategoriaID = productos.CategoriaID
group by CategoriaNombre;

/*Para cada cliente, indicar la última factura de compra. Incluir a los clientes que
nunca hayan comprado en e-market.*/

select clientes.ClienteID, clientes.compania, MAX(facturas.FechaFactura)
from clientes
left join facturas
on facturas.ClienteID = clientes.ClienteID
group by clientes.ClienteID;

/*Todas las facturas tienen una empresa de correo asociada (enviovia). Generar un
listado con todas las empresas de correo, y la cantidad de facturas
correspondientes. Realizar la consulta utilizando RIGHT JOIN.*/

select correos.compania, count(FacturaID)
from correos
right join facturas
on facturas.EnvioVia = correos.CorreoID
group by correos.compania

 

