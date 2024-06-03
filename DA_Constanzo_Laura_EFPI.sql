 -- Posicionarme sobre la BD
USE FastFoodDB;

/* CONSULTA 1: Eficiencia de los mensajeros: ¿Cuál es el tiempo promedio desde el despacho hasta la entrega de los pedidos por los mensajeros? */

SELECT AVG(DATEDIFF(MINUTE, FechaDespacho, FechaEntrega)) AS Promedio -- Promedio total
FROM Ordenes;

/* CONSULTA 2: Análisis de Ventas por Origen de Orden: ¿Qué canal de ventas genera más ingresos? */

SELECT * FROM OrigenesOrden;

SELECT T2.Descripcion , SUM(TotalCompra) AS TotalVentas
FROM Ordenes AS T1
	JOIN OrigenesOrden AS T2
		ON T1.OrigenID = T2.OrigenID
GROUP BY T2.Descripcion -- Uso descripción para que se vea mejor, no el ID. Sólo para conectar los datos
ORDER BY TotalVentas DESC;


/* CONSULTA 3: Productividad de los Empleados: ¿Cuál es el volumen de ventas promedio gestionado por empleado? */

SELECT * FROM Empleados;

SELECT T2.Nombre, COUNT(OrdenID) AS PromedioVentas -- Cantidad de facturación es el volumen
FROM Ordenes AS T1
		JOIN Empleados AS T2
			ON T1.EmpleadoID = T2.EmpleadoID 
GROUP BY T2.Nombre;

/* CONSULTA 4: Análisis de Demanda por Horario y Día: ¿Cómo varía la demanda de productos a lo largo del día? 
NOTA: Esta consulta no puede ser implementada sin una definición clara del horario (mañana, tarde, noche) en la base de datos existente. 
Asumiremos que HorarioVenta refleja esta información correctamente. */

SELECT HorarioVenta, SUM(T2.Cantidad) AS DemandaProductos
FROM Ordenes AS T1
	INNER JOIN DetalleOrdenes AS T2 -- Trae sólo los registros que tienen relacion con la tabla ordenes (solo detalles de OrdenID = 1). Un LEFT JOIN trae los que no tienen tambien
		ON T1.OrdenID = T2.OrdenID
GROUP BY HorarioVenta; 

/* CONSULTA 5: Comparación de Ventas Mensuales: ¿Cómo se comparan las ventas mensuales de este año con el año anterior? */

SELECT YEAR(FechaOrdenTomada) AS Año, MONTH(FechaOrdenTomada) AS Mes, SUM(TotalCompra) AS TotalVentas -- Puede ser con FORMAT pero en este SQL no funciona como 'YYYY-MM'
FROM Ordenes
GROUP BY FechaOrdenTomada;

/* CONSULTA 6: Análisis de Fidelidad del Cliente: ¿Qué porcentaje de clientes son recurrentes versus nuevos clientes cada mes? 
NOTA: La consulta se enfocaría en la frecuencia de órdenes por cliente para inferir la fidelidad. */

SELECT ClienteID, COUNT(OrdenID) AS NumeroOrdenes
FROM Ordenes 
GROUP BY ClienteID; -- Hay un cliente por cada orden, no hay clientes recurrentes por lo que no hay fidelidad. Se puede hacer con una funcion Over Partition
