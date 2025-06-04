
-- Vista de Rentabilidad de Productos
CREATE VIEW vw_RentabilidadProductos AS
SELECT 
    p.ProductoID,
    p.CodigoSKU,
    p.Nombre AS NombreProducto,
    c.Nombre AS Categoria,
    m.Nombre AS Marca,
    SUM(dv.Cantidad) AS CantidadVendida,
    SUM(dv.SubtotalSinImpuesto) AS VentasSinImpuesto,
    SUM(dv.TotalLinea) AS VentasConImpuesto,
    SUM(dv.Cantidad * p.PrecioCompraPromedio) AS CostoTotal,
    SUM(dv.SubtotalSinImpuesto) - SUM(dv.Cantidad * p.PrecioCompraPromedio) AS MargenBruto,
    CASE 
        WHEN SUM(dv.SubtotalSinImpuesto) = 0 THEN 0
        ELSE (SUM(dv.SubtotalSinImpuesto) - SUM(dv.Cantidad * p.PrecioCompraPromedio)) / SUM(dv.SubtotalSinImpuesto) * 100
    END AS PorcentajeMargenBruto
FROM 
    Productos p
    INNER JOIN DetalleVenta dv ON p.ProductoID = dv.ProductoID
    INNER JOIN Ventas v ON dv.VentaID = v.VentaID
    INNER JOIN Categorias c ON p.CategoriaID = c.CategoriaID
    LEFT JOIN Marcas m ON p.MarcaID = m.MarcaID
GROUP BY 
    p.ProductoID, p.CodigoSKU, p.Nombre, c.Nombre, m.Nombre;
GO
