 -- Posicionarme sobre la BD
USE FastFoodDB;

-- CONSULTA 1: ¿Cuál es el total de ventas (TotalCompra) a nivel global?

SELECT * FROM Ordenes;

SELECT SUM(TotalCompra) AS [Ventas Globales] -- Si uso corchetes puedo poner espacio entre las palabras cuando renombro
FROM Ordenes;

-- CONSULTA 2: ¿Cuál es el precio promedio de los productos dentro de cada categoría?

SELECT * FROM Productos;

SELECT CategoriaID, 
	AVG(Precio) AS [Precio Promedio] -- Métrica precio promedio y dimensión es categoria
FROM Productos
GROUP BY CategoriaID;

-- CONSULTA 3: ¿Cuál es el valor de la orden mínima y máxima por cada sucursal?

SELECT * FROM Ordenes;

SELECT SucursalID, -- Métrica minima y maxima y dimensión es SucursalID
	MIN(TotalCompra) AS MinimaOrden,
	MAX(TotalCompra) AS MaximaOrden
FROM Ordenes
GROUP BY SucursalID; -- Por cada sucursal tengo una sóla orden, por eso se ve así la tabla

-- CONSULTA 4: ¿Cuál es el mayor número de kilómetros recorridos para una entrega?

SELECT * FROM Ordenes;

SELECT MAX(KilometrosRecorrer) AS MayorKM -- Sólo metrica, sin dimensión
FROM Ordenes;

-- CONSULTA 5: ¿Cuál es la cantidad promedio de productos por orden?

SELECT * FROM DetalleOrdenes;

SELECT OrdenID, -- Métrica es cantidad y dimensión es OrdenID
	AVG(Cantidad) AS CantidadPromedio 
FROM DetalleOrdenes
GROUP BY OrdenID; -- Una sola orden

-- CONSULTA 6: ¿Cuál es el total de ventas por cada tipo de pago?

SELECT * FROM Ordenes;

SELECT TipoPagoID, -- Métrica total de ventas y dimensión TipoPagoID
	SUM(TotalCompra) AS VentasTotales
FROM Ordenes
GROUP BY TipoPagoID;

-- CONSULTA 7: ¿Cuál sucursal tiene la venta promedio más alta?

SELECT * FROM Ordenes;

SELECT TOP 1 SucursalID, 
	AVG(TotalCompra) AS VentasPromedio
FROM Ordenes
GROUP BY SucursalID
ORDER BY VentasPromedio DESC; -- Criterio
	
-- CONSULTA 8: ¿Cuáles son las sucursales que han generado ventas por orden por encima de $100, y cómo se comparan en términos del total de ventas?

SELECT * FROM Ordenes;

SELECT SucursalID,
	SUM(TotalCompra) AS VentasTotales,
	COUNT(OrdenID) AS CantidadOrdenes
FROM Ordenes
GROUP BY SucursalID
HAVING SUM(TotalCompra) > 65 -- No hay VentasTotales mayor a 100, modifico el valor a 65 para que me traiga valor
ORDER BY VentasTotales DESC;

-- CONSULTA 9: ¿Cómo se comparan las ventas promedio antes y después del 1 de julio de 2023?

SELECT * FROM Ordenes;

SELECT AVG(TotalCompra) AS VentasPromedio,
	'Venta Promedio antes de Julio 2023' AS Comentario
FROM Ordenes
WHERE FechaOrdenTomada < '2023-07-01'
UNION -- junto las consultas individuales
SELECT AVG(TotalCompra) AS VentasPromedio,
	'Venta Promedio despues de Julio 2023' AS Comentario
FROM Ordenes
WHERE FechaOrdenTomada > '2023-07-01'
ORDER BY VentasPromedio DESC; -- Al final de toda la instrucción de código

/* CONSULTA 10: ¿Durante qué horario del día (mañana, tarde, noche) se registra la mayor cantidad de ventas, 
cuál es el valor promedio de estas ventas, y cuál ha sido la venta máxima alcanzada? */

SELECT * FROM Ordenes;

SELECT HorarioVenta, -- Dimensión HorarioVenta y 3 métricas
	COUNT(OrdenID) AS CantidadVentas,
	AVG(TotalCompra) AS VentasPromedio,
	MAX(TotalCompra) AS VentaMaxima
FROM Ordenes
GROUP BY HorarioVenta
ORDER BY VentaMaxima;