-- Creación de Base de Datos - Nomenclatura Pascal Case
CREATE DATABASE FastFoodDB;

-- Creación de Tablas
CREATE TABLE Productos(
	ProductoID INT PRIMARY KEY IDENTITY,
	Nombre VARCHAR(255) NOT NULL,
	CategoriaID INT, -- Referencia a la PK de Categoria (FK). No hago mención aún ya que no esta creada la Tabla Categorias. Puedo empezar con lo más externo hacia adentro. 
	Precio DECIMAL(10,2) NOT NULL);

CREATE TABLE Categorias(
	CategoriaID INT PRIMARY KEY IDENTITY, -- Mismo tipo de dato que cuando funciona como FK
	Nombre VARCHAR(255) NOT NULL);   
	
CREATE TABLE Sucursales(
	SucursalID INT PRIMARY KEY IDENTITY,
	Nombre VARCHAR(255) NOT NULL,
	Direccion VARCHAR(255));
	
CREATE TABLE Empleados(
	EmpleadoID INT PRIMARY KEY IDENTITY,
	Nombre VARCHAR(255) NOT NULL,
	Posicion VARCHAR(255),
	Departamento VARCHAR(255),
	SucursalID INT);
	
-- Generar un campo llamado Rol en tabla Empleados
ALTER TABLE Empleados
ADD Rol VARCHAR(255);

CREATE TABLE Clientes (
	ClienteID INT PRIMARY KEY IDENTITY,
	Nombre VARCHAR(255) NOT NULL,
	Direccion VARCHAR(255));

CREATE TABLE OrigenesOrden (
	OrigenID INT PRIMARY KEY IDENTITY,
	Descripcion VARCHAR(255) NOT NULL);

CREATE TABLE TiposPago (
	TipoPago INT PRIMARY KEY IDENTITY,
	Descripcion VARCHAR(255) NOT NULL);

CREATE TABLE Mensajeros (
	MensajeroID INT PRIMARY KEY IDENTITY,
	Nombre VARCHAR(255) NOT NULL,
	EsExterno BIT); -- Genero en un ALTER el NOT NULL

-- Generar variaciones en las propiedades del campo
ALTER TABLE Mensajeros
ALTER COLUMN EsExterno BIT NOT NULL; 

CREATE TABLE Ordenes(
	OrdenID INT PRIMARY KEY IDENTITY,
	ClienteID INT,
	EmpleadoID INT, -- Vendedor que tomó la orden
	SucursalID INT,
	MensajeroID INT, -- Se asume que puede ser un empleado o un mensajero externo
	TipoPagoID INT,
	OrigenID INT, -- En línea, presencial, teléfono, drive thru
	HorarioVenta VARCHAR(50), -- Mañana, tarde, noche
	TotalCompra DECIMAL(10,2),
	KilometrosRecorrer DECIMAL(10,2),  -- En caso de entrega a domicilio
	FechaDespacho DATETIME, -- Hora y fecha de entrega al repartidor
	FechaEntrega DATETIME, -- Hora y fecga de la orden entregada
	FechaOrdenTomada DATETIME, -- En caso de drive thru o presencial
	FechaOrdenLista DATETIME, 
	Condicion VARCHAR(20)); -- Para probar eliminar un campo
	
-- Eliminar campo Condicion
ALTER TABLE Ordenes
DROP COLUMN Condicion;

CREATE TABLE DetalleOrdenes(
	OrdenID INT,
	ProductoID INT,
	Cantidad INT,
	Precio DECIMAL(10,2),
	PRIMARY KEY (OrdenID, ProductoID));

-------------------------------------- GENERAR RELACIONES -------------------------------------- 

ALTER TABLE Productos
ADD CONSTRAINT FK_Productos_Categorias
FOREIGN KEY(CategoriaID) REFERENCES Categorias(CategoriaID); -- No se puede crear tablas que tienen FK sin haberlas creado como PK en sus respectivas tablas primero

ALTER TABLE Ordenes
ADD CONSTRAINT FK_Ordenes_Sucursal
FOREIGN KEY(SucursalID) REFERENCES Sucursales(SucursalID);

ALTER TABLE Ordenes
ADD CONSTRAINT FK_Ordenes_Mensajero
FOREIGN KEY(MensajeroID) REFERENCES Mensajeros(MensajeroID);

ALTER TABLE Ordenes
ADD CONSTRAINT FK_Ordenes_Cliente
FOREIGN KEY(ClienteID) REFERENCES Clientes(ClienteID);

ALTER TABLE Ordenes
ADD CONSTRAINT FK_Ordenes_Empleado
FOREIGN KEY(EmpleadoID) REFERENCES Empleados(EmpleadoID);

ALTER TABLE Ordenes
ADD CONSTRAINT FK_Ordenes_Origen
FOREIGN KEY(OrigenID) REFERENCES OrigenesOrden(OrigenID);

ALTER TABLE Ordenes
ADD CONSTRAINT FK_Ordenes_TipoPago
FOREIGN KEY(TipoPagoID) REFERENCES TiposPago(TipoPago);

ALTER TABLE Empleados
ADD CONSTRAINT FK_Empleados_Sucursal
FOREIGN KEY(SucursalID) REFERENCES Sucursales(SucursalID);

ALTER TABLE DetalleOrdenes
ADD CONSTRAINT FK_Detalle_Ordenes
FOREIGN KEY(OrdenID) REFERENCES Ordenes(OrdenID);

ALTER TABLE DetalleOrdenes
ADD CONSTRAINT FK_Detalle_Productos
FOREIGN KEY(ProductoID) REFERENCES Productos(ProductoID);







	