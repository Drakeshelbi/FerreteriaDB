
-- �NDICES OPTIMIZADOS PARA PERFORMANCE

CREATE NONCLUSTERED INDEX IX_Productos_Nombre_Activo 
ON Productos (Nombre, Activo) 
ON FG_Indices;

CREATE NONCLUSTERED INDEX IX_Productos_CodigoBarras 
ON Productos (CodigoBarras) 
WHERE CodigoBarras IS NOT NULL
ON FG_Indices;

CREATE NONCLUSTERED INDEX IX_Inventario_ProductoExistencia 
ON Inventario (ProductoID, Existencia) 
ON FG_Indices;

USE FerreteriaDB;
GO

--________________________________________________________________________________________________________________________________________________________
-- INDICES CLUSTERED Y NO CLUSTERED AVANZADOS


-- �NDICES PARA TABLA PRODUCTOS (M�s consultada)

-- �ndice compuesto para b�squedas frecuentes por categor�a y estado
CREATE NONCLUSTERED INDEX IX_Productos_Categoria_Activo_Includes
ON Productos (CategoriaID, Activo)
INCLUDE (ProductoID, CodigoSKU, Nombre, PrecioVentaBase, MarcaID);

-- �ndice para b�squedas por c�digo de barras y SKU
CREATE NONCLUSTERED INDEX IX_Productos_CodigoBarras_SKU
ON Productos (CodigoBarras, CodigoSKU);

-- �ndice para control de inventarios (productos con stock bajo)
CREATE NONCLUSTERED INDEX IX_Productos_StockControl
ON Productos (StockMinimo, PuntoReorden, Activo)
INCLUDE (ProductoID, Nombre, CategoriaID);

-- �NDICES PARA INVENTARIO (Cr�tico para performance)

-- �ndice para consultas de inventario por almac�n
CREATE NONCLUSTERED INDEX IX_Inventario_Almacen_Producto
ON Inventario (AlmacenID, ProductoID)
INCLUDE (Existencia, ExistenciaMinima, UbicacionEspecifica);

-- �ndice para productos con stock bajo por almac�n
CREATE NONCLUSTERED INDEX IX_Inventario_StockBajo
ON Inventario (AlmacenID, Existencia, ExistenciaMinima)
INCLUDE (ProductoID);

-- �NDICES PARA VENTAS
-- �ndice por fecha para reportes de ventas
CREATE NONCLUSTERED INDEX IX_Ventas_Fecha_Estado
ON Ventas (FechaVenta DESC, EstadoID)
INCLUDE (VentaID, ClienteID, EmpleadoID, Total);

-- �ndice para ventas por cliente
CREATE NONCLUSTERED INDEX IX_Ventas_Cliente_Fecha
ON Ventas (ClienteID, FechaVenta DESC)
INCLUDE (VentaID, Total, EstadoID);

-- �ndice para ventas por empleado (comisiones/performance)
CREATE NONCLUSTERED INDEX IX_Ventas_Empleado_Fecha
ON Ventas (EmpleadoID, FechaVenta DESC)
INCLUDE (VentaID, Total, ClienteID);

-- �NDICES PARA DETALLE VENTA
-- �ndice para an�lisis de productos m�s vendidos
CREATE NONCLUSTERED INDEX IX_DetalleVenta_Producto_Fecha
ON DetalleVenta (ProductoID)
INCLUDE (VentaID, Cantidad, PrecioUnitario, TotalLinea);

-- �NDICES PARA COMPRAS
-- �ndice para �rdenes de compra por proveedor y fecha
CREATE NONCLUSTERED INDEX IX_OrdenesCompra_Proveedor_Fecha
ON OrdenesCompra (ProveedorID, FechEmision DESC)
INCLUDE (OrdenCompraID, EstadoID, Total);

-- �NDICES PARA MOVIMIENTOS DE INVENTARIO
-- �ndice cr�tico para auditor�a de inventario
CREATE NONCLUSTERED INDEX IX_MovimientosInventario_Producto_Fecha
ON MovimientosInventario (ProductoID, FechaMovimiento DESC)
INCLUDE (TipoMovimientoID, Cantidad, AlmacenOrigenID, AlmacenDestinoID);

-- �ndice por almac�n para movimientos
CREATE NONCLUSTERED INDEX IX_MovimientosInventario_Almacen_Fecha
ON MovimientosInventario (AlmacenOrigenID, FechaMovimiento DESC)
INCLUDE (ProductoID, TipoMovimientoID, Cantidad);

-- �NDICES PARA PERSONAS/CLIENTES/PROVEEDORES
-- �ndice para b�squeda de personas por documento
CREATE NONCLUSTERED INDEX IX_Personas_Documento
ON Personas (TipoDocumentoID, NumeroDocumento, Activo);

-- �ndice para b�squeda por nombre
CREATE NONCLUSTERED INDEX IX_Personas_Nombre
ON Personas (P_Nombre, S_Nombre)
INCLUDE (PersonaID, NumeroDocumento, Email);

--________________________________________________________________________________________________________________________________________________________
-- �NDICES COLUMNSTORE PARA AN�LISIS (SQL Server Enterprise)


-- �ndice columnstore para an�lisis de ventas (gran volumen de datos)
CREATE NONCLUSTERED COLUMNSTORE INDEX IX_Ventas_Columnstore
ON Ventas (VentaID, FechaVenta, ClienteID, EmpleadoID, Total, SubtotalSinImpuesto, TotalImpuestos);

-- �ndice columnstore para an�lisis de detalles de venta
CREATE NONCLUSTERED COLUMNSTORE INDEX IX_DetalleVenta_Columnstore
ON DetalleVenta (ProductoID, Cantidad, PrecioUnitario, TotalLinea);


--________________________________________________________________________________________________________________________________________________________
--  �NDICES FILTRADOS PARA DATOS ACTIVOS

-- �ndice filtrado solo para productos activos (mejora rendimiento)
CREATE NONCLUSTERED INDEX IX_Productos_Activos_Categoria
ON Productos (CategoriaID, MarcaID)
INCLUDE (ProductoID, Nombre, PrecioVentaBase)
WHERE Activo = 1;

-- �ndice filtrado para clientes activos
CREATE NONCLUSTERED INDEX IX_Personas_Activas
ON Personas (P_Nombre, S_Nombre)
INCLUDE (PersonaID, Email, Telefono_P)
WHERE Activo = 1;



--________________________________________________________________________________________________________________________________________________________
-- . ESTAD�STICAS PERSONALIZADAS

-- Estad�sticas para mejorar estimaciones del optimizador
CREATE STATISTICS Stats_Productos_Precio_Categoria
ON Productos (PrecioVentaBase, CategoriaID);

CREATE STATISTICS Stats_Inventario_Existencia_Producto
ON Inventario (Existencia, ProductoID);

CREATE STATISTICS Stats_Ventas_Total_Fecha
ON Ventas (Total, FechaVenta);

--________________________________________________________________________________________________________________________________________________________
-- 5. PARTICIONAMIENTO DE TABLAS (Para grandes vol�menes)

-- Funci�n de partici�n por mes para tabla de ventas
CREATE PARTITION FUNCTION PF_VentasPorMes (DATETIME)
AS RANGE RIGHT FOR VALUES 
('2024-01-01', '2024-02-01', '2024-03-01', '2024-04-01', 
 '2024-05-01', '2024-06-01', '2024-07-01', '2024-08-01',
 '2024-09-01', '2024-10-01', '2024-11-01', '2024-12-01',
 '2025-01-01', '2025-02-01', '2025-03-01', '2025-04-01',
 '2025-05-01', '2025-06-01');

-- Esquema de partici�n
CREATE PARTITION SCHEME PS_VentasPorMes
AS PARTITION PF_VentasPorMes
ALL TO ([PRIMARY]);



-- Configuraci�n de memoria para mejor cache
ALTER DATABASE FerreteriaDB SET DELAYED_DURABILITY = ALLOWED;

--________________________________________________________________________________________________________________________________________________________
-- VISTAS INDEXADAS PARA CONSULTAS FRECUENTES


-- Vista indexada para inventario total por producto
CREATE VIEW VW_InventarioTotal
WITH SCHEMABINDING
AS
SELECT 
    p.ProductoID,
    p.CodigoSKU,
    p.Nombre,
    SUM(i.Existencia) AS ExistenciaTotal,
    COUNT_BIG(*) AS NumAlmacenes
FROM dbo.Productos p
INNER JOIN dbo.Inventario i ON p.ProductoID = i.ProductoID
WHERE p.Activo = 1
GROUP BY p.ProductoID, p.CodigoSKU, p.Nombre;

-- �ndice �nico en la vista
CREATE UNIQUE CLUSTERED INDEX IX_VW_InventarioTotal
ON VW_InventarioTotal (ProductoID);

-- Vista indexada para ventas por mes
CREATE VIEW VW_VentasPorMes
WITH SCHEMABINDING
AS
SELECT 
    YEAR(FechaVenta) AS A�o,
    MONTH(FechaVenta) AS Mes,
    COUNT_BIG(*) AS NumeroVentas,
    SUM(Total) AS TotalVentas,
    AVG(Total) AS PromedioVenta
FROM dbo.Ventas
WHERE EstadoID = 'COMPLETADA'
GROUP BY YEAR(FechaVenta), MONTH(FechaVenta);

CREATE UNIQUE CLUSTERED INDEX IX_VW_VentasPorMes
ON VW_VentasPorMes (A�o, Mes);

--________________________________________________________________________________________________________________________________________________________
-- 8. TRIGGERS PARA MANTENIMIENTO AUTOM�TICO


-- Trigger para actualizar inventario en ventas
CREATE TRIGGER TR_ActualizarInventario_Venta
ON DetalleVenta
AFTER INSERT
AS
BEGIN
    SET NOCOUNT ON;
    
    UPDATE i
    SET Existencia = i.Existencia - CAST(d.Cantidad AS INT),
        FechaUltimaSalida = GETDATE()
    FROM Inventario i
    INNER JOIN inserted d ON i.ProductoID = d.ProductoID
    INNER JOIN Ventas v ON d.VentaID = v.VentaID
    WHERE i.AlmacenID = v.AlmacenID;
    
    -- Insertar movimiento de inventario
    INSERT INTO MovimientosInventario 
    (MovimientoID, FechaMovimiento, TipoMovimientoID, ProductoID, 
     AlmacenOrigenID, Cantidad, DocumentoReferenciaID, 
     TipoDocumentoReferencia, EmpleadoID, Observaciones)
    SELECT 
        'MOV' + CAST(NEXT VALUE FOR SEQ_MovimientoID AS VARCHAR(17)),
        GETDATE(),
        'VENTA',
        d.ProductoID,
        v.AlmacenID,
        d.Cantidad,
        d.VentaID,
        'Venta',
        v.EmpleadoID,
        'Movimiento autom�tico por venta'
    FROM inserted d
    INNER JOIN Ventas v ON d.VentaID = v.VentaID;
END;

--________________________________________________________________________________________________________________________________________________________
-- 10. PROCEDIMIENTOS ALMACENADOS OPTIMIZADOS

-- Procedimiento optimizado para consulta de inventario
CREATE PROCEDURE SP_ConsultarInventarioPorAlmacen
    @AlmacenID VARCHAR(20),
    @SoloStockBajo BIT = 0
AS
BEGIN
    SET NOCOUNT ON;
    
    SELECT 
        p.ProductoID,
        p.CodigoSKU,
        p.Nombre,
        p.Descripcion,
        m.Nombre AS Marca,
        i.Existencia,
        i.ExistenciaMinima,
        i.UbicacionEspecifica,
        CASE 
            WHEN i.Existencia <= i.ExistenciaMinima THEN 'CR�TICO'
            WHEN i.Existencia <= (i.ExistenciaMinima * 1.5) THEN 'BAJO'
            ELSE 'NORMAL'
        END AS EstadoStock
    FROM Inventario i WITH (NOLOCK)
    INNER JOIN Productos p WITH (NOLOCK) ON i.ProductoID = p.ProductoID
    LEFT JOIN Marcas m WITH (NOLOCK) ON p.MarcaID = m.MarcaID
    WHERE i.AlmacenID = @AlmacenID
        AND p.Activo = 1
        AND (@SoloStockBajo = 0 OR i.Existencia <= i.ExistenciaMinima)
    ORDER BY 
        CASE 
            WHEN i.Existencia <= i.ExistenciaMinima THEN 1
            WHEN i.Existencia <= (i.ExistenciaMinima * 1.5) THEN 2
            ELSE 3
        END,
        p.Nombre;
END;

-- Procedimiento para reporte de ventas optimizado
CREATE PROCEDURE SP_ReporteVentasPorPeriodo
    @FechaInicio DATE,
    @FechaFin DATE,
    @EmpleadoID VARCHAR(20) = NULL
AS
BEGIN
    SET NOCOUNT ON;
    
    SELECT 
        v.FechaVenta,
        v.NumeroFactura,
        p.P_Nombre + ' ' + ISNULL(p.S_Nombre, '') AS Cliente,
        e.P_Nombre + ' ' + ISNULL(e.S_Nombre, '') AS Vendedor,
        v.SubtotalSinImpuesto,
        v.TotalImpuestos,
        v.Total,
        COUNT(dv.DetalleVentaID) AS NumeroItems
    FROM Ventas v WITH (NOLOCK)
    INNER JOIN Clientes c WITH (NOLOCK) ON v.ClienteID = c.ClienteID
    INNER JOIN Personas p WITH (NOLOCK) ON c.PersonaID = p.PersonaID
    INNER JOIN Empleados emp WITH (NOLOCK) ON v.EmpleadoID = emp.EmpleadoID
    INNER JOIN Personas e WITH (NOLOCK) ON emp.PersonaID = e.PersonaID
    LEFT JOIN DetalleVenta dv WITH (NOLOCK) ON v.VentaID = dv.VentaID
    WHERE v.FechaVenta >= @FechaInicio 
        AND v.FechaVenta < DATEADD(DAY, 1, @FechaFin)
        AND (@EmpleadoID IS NULL OR v.EmpleadoID = @EmpleadoID)
        AND v.EstadoID = 'COMPLETADA'
    GROUP BY 
        v.FechaVenta, v.NumeroFactura, p.P_Nombre, p.S_Nombre,
        e.P_Nombre, e.S_Nombre, v.SubtotalSinImpuesto, 
        v.TotalImpuestos, v.Total
    ORDER BY v.FechaVenta DESC;
END;

--________________________________________________________________________________________________________________________________________________________
-- MANTENIMIENTO AUTOM�TICO

-- (configurar en SQL Server Agent)

-- Script para reorganizar �ndices fragmentados
CREATE PROCEDURE SP_MantenimientoIndices
AS
BEGIN
    SET NOCOUNT ON;
    
    -- Reorganizar �ndices con fragmentaci�n entre 5% y 30%
    DECLARE @sql NVARCHAR(MAX);
    
    SELECT @sql = COALESCE(@sql + CHAR(13), '') + 
        'ALTER INDEX ' + i.name + ' ON ' + OBJECT_NAME(i.object_id) + ' REORGANIZE;'
    FROM sys.dm_db_index_physical_stats(DB_ID(), NULL, NULL, NULL, 'LIMITED') ps
    INNER JOIN sys.indexes i ON ps.object_id = i.object_id AND ps.index_id = i.index_id
    WHERE ps.avg_fragmentation_in_percent BETWEEN 5 AND 30
        AND i.name IS NOT NULL;
    
    IF @sql IS NOT NULL
        EXEC sp_executesql @sql;
        
    -- Reconstruir �ndices con fragmentaci�n > 30%
    SET @sql = NULL;
    
    SELECT @sql = COALESCE(@sql + CHAR(13), '') + 
        'ALTER INDEX ' + i.name + ' ON ' + OBJECT_NAME(i.object_id) + ' REBUILD;'
    FROM sys.dm_db_index_physical_stats(DB_ID(), NULL, NULL, NULL, 'LIMITED') ps
    INNER JOIN sys.indexes i ON ps.object_id = i.object_id AND ps.index_id = i.index_id
    WHERE ps.avg_fragmentation_in_percent > 30
        AND i.name IS NOT NULL;
    
    IF @sql IS NOT NULL
        EXEC sp_executesql @sql;
        
    -- Actualizar estad�sticas
    EXEC sp_updatestats;
END;

--________________________________________________________________________________________________________________________________________________________
-- MONITOREO DE PERFORMANCE


-- Vista para monitorear uso de �ndices
CREATE VIEW VW_UsoIndices
AS
SELECT 
    OBJECT_NAME(i.object_id) AS NombreTabla,
    i.name AS NombreIndice,
    ius.user_seeks AS B�squedas,
    ius.user_scans AS Escaneos,
    ius.user_lookups AS B�squedas_Clave,
    ius.user_updates AS Actualizaciones,
    ius.last_user_seek AS UltimaBusqueda,
    ius.last_user_scan AS UltimoEscaneo
FROM sys.indexes i
LEFT JOIN sys.dm_db_index_usage_stats ius 
    ON i.object_id = ius.object_id AND i.index_id = ius.index_id
WHERE ius.database_id = DB_ID()
    AND OBJECT_NAME(i.object_id) NOT LIKE 'sys%';

