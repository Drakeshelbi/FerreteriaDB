-- Vista de Inventario Actual
GO
CREATE VIEW vw_InventarioActual AS
SELECT 
    p.ProductoID,
    p.CodigoSKU,
    p.Nombre AS NombreProducto,
    c.Nombre AS Categoria,
    m.Nombre AS Marca,
    a.Nombre AS Almacen,
    ISNULL(i.Existencia, 0) AS Existencia,
    p.StockMinimo,
    p.PrecioVentaBase,
    p.PrecioCompraPromedio,
    um.Abreviatura AS UnidadMedida,
    CASE 
        WHEN ISNULL(i.Existencia, 0) <= p.StockMinimo THEN 'Bajo Stock'
        WHEN ISNULL(i.Existencia, 0) <= p.StockMinimo * 2 THEN 'Stock Medio'
        ELSE 'Stock Normal'
    END AS EstadoStock
FROM 
    Productos p
    LEFT JOIN Inventario i ON p.ProductoID = i.ProductoID
    LEFT JOIN Categorias c ON p.CategoriaID = c.CategoriaID
    LEFT JOIN Marcas m ON p.MarcaID = m.MarcaID
    LEFT JOIN Almacenes a ON i.AlmacenID = a.AlmacenID
    LEFT JOIN UnidadesMedida um ON p.UnidadMedidaID = um.UnidadID
WHERE 
    p.Activo = 1;
GO
