
-- Vista de Compras por Proveedor
CREATE VIEW vw_ComprasPorProveedor AS
SELECT 
    pr.ProveedorID,
    p.RazonSocial AS NombreProveedor,
    COUNT(DISTINCT oc.OrdenCompraID) AS CantidadOrdenes,
    SUM(oc.Total) AS TotalCompras,
    MIN(oc.FechaEmision) AS PrimeraCompra,
    MAX(oc.FechaEmision) AS UltimaCompra,
    COUNT(DISTINCT doc.ProductoID) AS CantidadProductosDiferentes
FROM 
    Proveedores pr
    INNER JOIN Personas p ON pr.PersonaID = p.PersonaID
    INNER JOIN OrdenesCompra oc ON pr.ProveedorID = oc.ProveedorID
    INNER JOIN DetalleOrdenCompra doc ON oc.OrdenCompraID = doc.OrdenCompraID
GROUP BY 
    pr.ProveedorID, p.RazonSocial;
GO
