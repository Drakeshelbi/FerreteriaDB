
-- ÍNDICES OPTIMIZADOS PARA PERFORMANCE

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


-- ÍNDICES PARA TABLA PRODUCTOS (Más consultada)

-- Índice compuesto para búsquedas frecuentes por categoría y estado
CREATE NONCLUSTERED INDEX IX_Productos_Categoria_Activo_Includes
ON Productos (CategoriaID, Activo)
INCLUDE (ProductoID, CodigoSKU, Nombre, PrecioVentaBase, MarcaID);

-- Índice para búsquedas por código de barras y SKU
CREATE NONCLUSTERED INDEX IX_Productos_CodigoBarras_SKU
ON Productos (CodigoBarras, CodigoSKU);

-- Índice para control de inventarios (productos con stock bajo)
CREATE NONCLUSTERED INDEX IX_Productos_StockControl
ON Productos (StockMinimo, PuntoReorden, Activo)
INCLUDE (ProductoID, Nombre, CategoriaID);

-- ÍNDICES PARA INVENTARIO (Crítico para performance)

-- Índice para consultas de inventario por almacén
CREATE NONCLUSTERED INDEX IX_Inventario_Almacen_Producto
ON Inventario (AlmacenID, ProductoID)
INCLUDE (Existencia, ExistenciaMinima, UbicacionEspecifica);

-- Índice para productos con stock bajo por almacén
CREATE NONCLUSTERED INDEX IX_Inventario_StockBajo
ON Inventario (AlmacenID, Existencia, ExistenciaMinima)
INCLUDE (ProductoID);

-- ÍNDICES PARA VENTAS
-- Índice por fecha para reportes de ventas
CREATE NONCLUSTERED INDEX IX_Ventas_Fecha_Estado
ON Ventas (FechaVenta DESC, EstadoID)
INCLUDE (VentaID, ClienteID, EmpleadoID, Total);

-- Índice para ventas por cliente
CREATE NONCLUSTERED INDEX IX_Ventas_Cliente_Fecha
ON Ventas (ClienteID, FechaVenta DESC)
INCLUDE (VentaID, Total, EstadoID);

-- Índice para ventas por empleado (comisiones/performance)
CREATE NONCLUSTERED INDEX IX_Ventas_Empleado_Fecha
ON Ventas (EmpleadoID, FechaVenta DESC)
INCLUDE (VentaID, Total, ClienteID);

-- ÍNDICES PARA DETALLE VENTA
-- Índice para análisis de productos más vendidos
CREATE NONCLUSTERED INDEX IX_DetalleVenta_Producto_Fecha
ON DetalleVenta (ProductoID)
INCLUDE (VentaID, Cantidad, PrecioUnitario, TotalLinea);

-- ÍNDICES PARA COMPRAS
-- Índice para órdenes de compra por proveedor y fecha
CREATE NONCLUSTERED INDEX IX_OrdenesCompra_Proveedor_Fecha
ON OrdenesCompra (ProveedorID, FechEmision DESC)
INCLUDE (OrdenCompraID, EstadoID, Total);

-- ÍNDICES PARA MOVIMIENTOS DE INVENTARIO
-- Índice crítico para auditoría de inventario
CREATE NONCLUSTERED INDEX IX_MovimientosInventario_Producto_Fecha
ON MovimientosInventario (ProductoID, FechaMovimiento DESC)
INCLUDE (TipoMovimientoID, Cantidad, AlmacenOrigenID, AlmacenDestinoID);

-- Índice por almacén para movimientos
CREATE NONCLUSTERED INDEX IX_MovimientosInventario_Almacen_Fecha
ON MovimientosInventario (AlmacenOrigenID, FechaMovimiento DESC)
INCLUDE (ProductoID, TipoMovimientoID, Cantidad);

-- ÍNDICES PARA PERSONAS/CLIENTES/PROVEEDORES
-- Índice para búsqueda de personas por documento
CREATE NONCLUSTERED INDEX IX_Personas_Documento
ON Personas (TipoDocumentoID, NumeroDocumento, Activo);

-- Índice para búsqueda por nombre
CREATE NONCLUSTERED INDEX IX_Personas_Nombre
ON Personas (P_Nombre, S_Nombre)
INCLUDE (PersonaID, NumeroDocumento, Email);

--________________________________________________________________________________________________________________________________________________________
-- ÍNDICES COLUMNSTORE PARA ANÁLISIS (SQL Server Enterprise)


-- Índice columnstore para análisis de ventas (gran volumen de datos)
CREATE NONCLUSTERED COLUMNSTORE INDEX IX_Ventas_Columnstore
ON Ventas (VentaID, FechaVenta, ClienteID, EmpleadoID, Total, SubtotalSinImpuesto, TotalImpuestos);

-- Índice columnstore para análisis de detalles de venta
CREATE NONCLUSTERED COLUMNSTORE INDEX IX_DetalleVenta_Columnstore
ON DetalleVenta (ProductoID, Cantidad, PrecioUnitario, TotalLinea);


--________________________________________________________________________________________________________________________________________________________
--  ÍNDICES FILTRADOS PARA DATOS ACTIVOS

-- Índice filtrado solo para productos activos (mejora rendimiento)
CREATE NONCLUSTERED INDEX IX_Productos_Activos_Categoria
ON Productos (CategoriaID, MarcaID)
INCLUDE (ProductoID, Nombre, PrecioVentaBase)
WHERE Activo = 1;

-- Índice filtrado para clientes activos
CREATE NONCLUSTERED INDEX IX_Personas_Activas
ON Personas (P_Nombre, S_Nombre)
INCLUDE (PersonaID, Email, Telefono_P)
WHERE Activo = 1;



--________________________________________________________________________________________________________________________________________________________
-- . ESTADÍSTICAS PERSONALIZADAS

-- Estadísticas para mejorar estimaciones del optimizador
CREATE STATISTICS Stats_Productos_Precio_Categoria
ON Productos (PrecioVentaBase, CategoriaID);

CREATE STATISTICS Stats_Inventario_Existencia_Producto
ON Inventario (Existencia, ProductoID);

CREATE STATISTICS Stats_Ventas_Total_Fecha
ON Ventas (Total, FechaVenta);

--________________________________________________________________________________________________________________________________________________________
-- 5. PARTICIONAMIENTO DE TABLAS (Para grandes volúmenes)

-- Función de partición por mes para tabla de ventas
CREATE PARTITION FUNCTION PF_VentasPorMes (DATETIME)
AS RANGE RIGHT FOR VALUES 
('2024-01-01', '2024-02-01', '2024-03-01', '2024-04-01', 
 '2024-05-01', '2024-06-01', '2024-07-01', '2024-08-01',
 '2024-09-01', '2024-10-01', '2024-11-01', '2024-12-01',
 '2025-01-01', '2025-02-01', '2025-03-01', '2025-04-01',
 '2025-05-01', '2025-06-01');

-- Esquema de partición
CREATE PARTITION SCHEME PS_VentasPorMes
AS PARTITION PF_VentasPorMes
ALL TO ([PRIMARY]);



-- Configuración de memoria para mejor cache
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

-- Índice único en la vista
CREATE UNIQUE CLUSTERED INDEX IX_VW_InventarioTotal
ON VW_InventarioTotal (ProductoID);

-- Vista indexada para ventas por mes
CREATE VIEW VW_VentasPorMes
WITH SCHEMABINDING
AS
SELECT 
    YEAR(FechaVenta) AS Año,
    MONTH(FechaVenta) AS Mes,
    COUNT_BIG(*) AS NumeroVentas,
    SUM(Total) AS TotalVentas,
    AVG(Total) AS PromedioVenta
FROM dbo.Ventas
WHERE EstadoID = 'COMPLETADA'
GROUP BY YEAR(FechaVenta), MONTH(FechaVenta);

CREATE UNIQUE CLUSTERED INDEX IX_VW_VentasPorMes
ON VW_VentasPorMes (Año, Mes);

--________________________________________________________________________________________________________________________________________________________
-- 8. TRIGGERS PARA MANTENIMIENTO AUTOMÁTICO


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
        'Movimiento automático por venta'
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
            WHEN i.Existencia <= i.ExistenciaMinima THEN 'CRÍTICO'
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
-- MANTENIMIENTO AUTOMÁTICO

-- (configurar en SQL Server Agent)

-- Script para reorganizar índices fragmentados
CREATE PROCEDURE SP_MantenimientoIndices
AS
BEGIN
    SET NOCOUNT ON;
    
    -- Reorganizar índices con fragmentación entre 5% y 30%
    DECLARE @sql NVARCHAR(MAX);
    
    SELECT @sql = COALESCE(@sql + CHAR(13), '') + 
        'ALTER INDEX ' + i.name + ' ON ' + OBJECT_NAME(i.object_id) + ' REORGANIZE;'
    FROM sys.dm_db_index_physical_stats(DB_ID(), NULL, NULL, NULL, 'LIMITED') ps
    INNER JOIN sys.indexes i ON ps.object_id = i.object_id AND ps.index_id = i.index_id
    WHERE ps.avg_fragmentation_in_percent BETWEEN 5 AND 30
        AND i.name IS NOT NULL;
    
    IF @sql IS NOT NULL
        EXEC sp_executesql @sql;
        
    -- Reconstruir índices con fragmentación > 30%
    SET @sql = NULL;
    
    SELECT @sql = COALESCE(@sql + CHAR(13), '') + 
        'ALTER INDEX ' + i.name + ' ON ' + OBJECT_NAME(i.object_id) + ' REBUILD;'
    FROM sys.dm_db_index_physical_stats(DB_ID(), NULL, NULL, NULL, 'LIMITED') ps
    INNER JOIN sys.indexes i ON ps.object_id = i.object_id AND ps.index_id = i.index_id
    WHERE ps.avg_fragmentation_in_percent > 30
        AND i.name IS NOT NULL;
    
    IF @sql IS NOT NULL
        EXEC sp_executesql @sql;
        
    -- Actualizar estadísticas
    EXEC sp_updatestats;
END;

--________________________________________________________________________________________________________________________________________________________
-- MONITOREO DE PERFORMANCE


-- Vista para monitorear uso de índices
CREATE VIEW VW_UsoIndices
AS
SELECT 
    OBJECT_NAME(i.object_id) AS NombreTabla,
    i.name AS NombreIndice,
    ius.user_seeks AS Búsquedas,
    ius.user_scans AS Escaneos,
    ius.user_lookups AS Búsquedas_Clave,
    ius.user_updates AS Actualizaciones,
    ius.last_user_seek AS UltimaBusqueda,
    ius.last_user_scan AS UltimoEscaneo
FROM sys.indexes i
LEFT JOIN sys.dm_db_index_usage_stats ius 
    ON i.object_id = ius.object_id AND i.index_id = ius.index_id
WHERE ius.database_id = DB_ID()
    AND OBJECT_NAME(i.object_id) NOT LIKE 'sys%';

