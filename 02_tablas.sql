USE RutaDelDato;
GO
IF OBJECT_ID('dbo.DetalleVentas') IS NOT NULL DROP TABLE dbo.DetalleVentas;
IF OBJECT_ID('dbo.Ventas') IS NOT NULL DROP TABLE dbo.Ventas;
IF OBJECT_ID('dbo.Inventario') IS NOT NULL DROP TABLE dbo.Inventario;
IF OBJECT_ID('dbo.Productos') IS NOT NULL DROP TABLE dbo.Productos;
IF OBJECT_ID('dbo.Categorias') IS NOT NULL DROP TABLE dbo.Categorias;
IF OBJECT_ID('dbo.Clientes') IS NOT NULL DROP TABLE dbo.Clientes;
GO
CREATE TABLE dbo.Clientes (
    ClienteID     INT           NOT NULL CONSTRAINT PK_Clientes PRIMARY KEY,
    Nombre        NVARCHAR(50)  NOT NULL,
    Apellido      NVARCHAR(50)  NOT NULL,
    Email         NVARCHAR(120) NOT NULL CONSTRAINT UQ_Clientes_Email UNIQUE,
    Ciudad        NVARCHAR(50)  NOT NULL,
    FechaRegistro DATE          NOT NULL,
    Segmento      NVARCHAR(20)  NOT NULL CONSTRAINT CK_Clientes_Segmento CHECK (Segmento IN (N'Particular', N'Empresa'))
);
CREATE TABLE dbo.Categorias (
    CategoriaID INT          NOT NULL CONSTRAINT PK_Categorias PRIMARY KEY,
    Nombre      NVARCHAR(50) NOT NULL CONSTRAINT UQ_Categorias_Nombre UNIQUE
);
CREATE TABLE dbo.Productos (
    ProductoID  INT           NOT NULL CONSTRAINT PK_Productos PRIMARY KEY,
    Nombre      NVARCHAR(80)  NOT NULL,
    CategoriaID INT           NOT NULL CONSTRAINT FK_Productos_Categorias REFERENCES dbo.Categorias(CategoriaID),
    Precio      DECIMAL(12,2) NOT NULL CONSTRAINT CK_Productos_Precio CHECK (Precio > 0),
    Costo       DECIMAL(12,2) NOT NULL CONSTRAINT CK_Productos_Costo CHECK (Costo > 0)
);
CREATE TABLE dbo.Inventario (
    ProductoID    INT  NOT NULL CONSTRAINT PK_Inventario PRIMARY KEY CONSTRAINT FK_Inventario_Productos REFERENCES dbo.Productos(ProductoID),
    Stock         INT  NOT NULL CONSTRAINT CK_Inventario_Stock CHECK (Stock >= 0),
    StockMinimo   INT  NOT NULL,
    FechaCorte    DATE NOT NULL
);
CREATE TABLE dbo.Ventas (
    VentaID   INT          NOT NULL CONSTRAINT PK_Ventas PRIMARY KEY,
    ClienteID INT          NOT NULL CONSTRAINT FK_Ventas_Clientes REFERENCES dbo.Clientes(ClienteID),
    Fecha     DATE         NOT NULL,
    Canal     NVARCHAR(20) NOT NULL CONSTRAINT CK_Ventas_Canal CHECK (Canal IN (N'Tienda', N'Web', N'WhatsApp')),
    Estado    NVARCHAR(20) NOT NULL CONSTRAINT CK_Ventas_Estado CHECK (Estado IN (N'Completada', N'Cancelada', N'Devuelta'))
);
CREATE TABLE dbo.DetalleVentas (
    DetalleID      INT           NOT NULL CONSTRAINT PK_DetalleVentas PRIMARY KEY,
    VentaID        INT           NOT NULL CONSTRAINT FK_Detalle_Ventas REFERENCES dbo.Ventas(VentaID),
    ProductoID     INT           NOT NULL CONSTRAINT FK_Detalle_Productos REFERENCES dbo.Productos(ProductoID),
    Cantidad       INT           NOT NULL CONSTRAINT CK_Detalle_Cantidad CHECK (Cantidad > 0),
    PrecioUnitario DECIMAL(12,2) NOT NULL CONSTRAINT CK_Detalle_Precio CHECK (PrecioUnitario > 0)
);
CREATE INDEX IX_Ventas_Cliente ON dbo.Ventas(ClienteID);
CREATE INDEX IX_Ventas_Fecha   ON dbo.Ventas(Fecha);
CREATE INDEX IX_Detalle_Venta  ON dbo.DetalleVentas(VentaID);
GO
