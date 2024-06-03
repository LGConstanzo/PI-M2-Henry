 -- Posicionarme sobre la BD
USE FastFoodDB;

-- CONSULTA 1: ¿Cómo puedo obtener una lista de todos los productos junto con sus categorías?

SELECT * FROM Productos;
SELECT * FROM Categorias;

SELECT T1.Nombre AS Producto, T2.Nombre AS Categoria -- me quedo con estos dos campos y los renombro ya que ambos se llaman igual
FROM Productos AS T1
	INNER JOIN Categorias AS T2
		ON T1.CategoriaID = T2.CategoriaID; -- Uno las tablas productos con categorias según CategoriaID

-- CONSULTA 2: ¿Cómo puedo saber a qué sucursal está asignado cada empleado?
	
SELECT * FROM Sucursales;
SELECT * FROM Empleados;

SELECT T1.EmpleadoID, T1.Nombre, T1.Departamento, T2.Nombre AS Sucursal
FROM Empleados AS T1
	INNER JOIN Sucursales AS T2
		ON T1.SucursalID = T2.SucursalID; -- Todos los empleados están en sucursal central


-- CONSULTA 3: ¿Existen productos que no tienen una categoría asignada?
	
SELECT * FROM Productos;
SELECT * FROM Categorias;

SELECT * 
FROM Productos AS T1
	LEFT JOIN Categorias AS T2 -- Si queremos mapear los productos que no tienen categorias asociadas (sino es INNER JOIN)
		ON T1.CategoriaID = T2.CategoriaID
	WHERE T2.CategoriaID IS NULL; -- Todos tienen categoria asignada

-- CONSULTA 4: ¿Cómo puedo obtener un detalle completo de las órdenes, incluyendo cliente, empleado que tomó la orden, y el mensajero que la entregó?
	
SELECT T1.*, T2.Nombre AS Cliente, T3.Nombre AS Empleado, T4.Nombre AS Mensajero -- Traigo toda la tabla de Ordenes
FROM Ordenes AS T1
	INNER JOIN Clientes AS T2
		ON T1.ClienteID = T2.ClienteID 
	INNER JOIN Empleados AS T3
		ON T1.EmpleadoID = T3.EmpleadoID 
	INNER JOIN Mensajeros AS T4
		ON T1.MensajeroID = T4.MensajeroID; -- Ordenes que tengan todos esos campos, no los que no tengan (por eso es INNER JOIN). Misma cantidad de filas que tienen tabla de ordenes
		

-- CONSULTA 5: ¿Cuántos productos de cada tipo se han vendido en cada sucursal?

SELECT * FROM Ordenes;
SELECT * FROM DetalleOrdenes;
SELECT * FROM Categorias;

SELECT T5.Nombre AS Sucursal, T4.Nombre AS Catergoria, SUM(Cantidad) as CantidadArticulosVendidos
FROM Ordenes AS T1
	INNER JOIN DetalleOrdenes AS T2 -- Por INNER JOIN y no LEFT JOIN porque ya se que no tiene nulos
		ON T1.OrdenID = T2.OrdenID 
	INNER JOIN Productos AS T3
		ON T2.ProductoID = T3.ProductoID  
	INNER JOIN Categorias AS T4
		ON T3.CategoriaID = T4.CategoriaID 
	INNER JOIN Sucursales AS T5
		ON T1.SucursalID = T5.SucursalID
GROUP BY T5.Nombre, T4.Nombre;


