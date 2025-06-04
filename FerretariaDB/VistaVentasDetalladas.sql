
-- Vista de Ventas Detalladas
CREATE VIEW vw_VentasDetalladas AS
SELECT 
    v.VentaID,
    v.NumeroFactura,
    v.SerieFactura,
    v.FechaVenta,
    p.PersonaID,
    p.PrimerNombre + ' ' + p.PrimerApellido AS NombreCliente,
    p.RazonSocial,
    dv.ProductoID,
    pr.Nombre AS NombreProducto,
    dv.Cantidad,
    dv.PrecioUnitario,
    dv.SubtotalSinImpuesto,
    dv.TotalDescuento,
    dv.TotalImpuesto,
    dv.TotalLinea,
    v.Total AS TotalFactura,
    fp.Nombre AS FormaPago,
    emp.PersonaID AS EmpleadoID,
    empPersona.PrimerNombre + ' ' + empPersona.PrimerApellido AS NombreVendedor,
    a.Nombre AS Almacen,
    est.Nombre AS EstadoFactura
FROM 
    Ventas v
    INNER JOIN DetalleVenta dv ON v.VentaID = dv.VentaID
    INNER JOIN Clientes c ON v.ClienteID = c.ClienteID
    INNER JOIN Personas p ON c.PersonaID = p.PersonaID
    INNER JOIN Productos pr ON dv.ProductoID = pr.ProductoID
    INNER JOIN FormasPago fp ON v.FormaPagoID = fp.FormaPagoID
    INNER JOIN Empleados emp ON v.EmpleadoID = emp.EmpleadoID
    INNER JOIN Personas empPersona ON emp.PersonaID = empPersona.PersonaID
    INNER JOIN Almacenes a ON v.AlmacenID = a.AlmacenID
    INNER JOIN EstadosDocumento est ON v.EstadoID = est.EstadoID;
GO
