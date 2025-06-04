-- Procedimiento para Agregar Producto a Venta

CREATE PROCEDURE sp_AgregarProductoVenta
    @VentaID INT,
    @ProductoID INT,
    @Cantidad INT,
    @PrecioUnitario DECIMAL(12,2),
    @PorcentajeDescuento DECIMAL(5,2) = 0
AS
BEGIN
    SET NOCOUNT ON;
    
    DECLARE @SubtotalSinImpuesto DECIMAL(12,2);
    DECLARE @TotalDescuento DECIMAL(12,2);
    DECLARE @TotalImpuesto DECIMAL(12,2);
    DECLARE @TotalLinea DECIMAL(12,2);
    DECLARE @PorcentajeImpuesto DECIMAL(5,2);
    DECLARE @ImpuestoID INT;
    DECLARE @AlmacenID INT;
    DECLARE @ExistenciaActual INT;
    
    -- OBTENER LOS DATOS DE PRODUCTO Y ALMACEN
    SELECT @ImpuestoID = p.ImpuestoID
    FROM Productos p
    WHERE p.ProductoID = @ProductoID;
    
    SELECT @AlmacenID = AlmacenID FROM Ventas WHERE VentaID = @VentaID;
    
    -- VERIFICAMOS EXISTENCIAS
    SELECT @ExistenciaActual = ISNULL(Existencia, 0)
    FROM Inventario
    WHERE ProductoID = @ProductoID AND AlmacenID = @AlmacenID;
    
    IF @ExistenciaActual < @Cantidad
    BEGIN
        RAISERROR('No hay suficiente existencia del producto seleccionado', 16, 1);
        RETURN -1;
    END
    
    -- OBTENER PORCENTAJE DE IMPUESTO
    SELECT @PorcentajeImpuesto = Porcentaje FROM Impuestos WHERE ImpuestoID = @ImpuestoID;
    
    -- CALCULAMOS VALORES
    SET @SubtotalSinImpuesto = @Cantidad * @PrecioUnitario;
    SET @TotalDescuento = @SubtotalSinImpuesto * (@PorcentajeDescuento / 100);
    SET @SubtotalSinImpuesto = @SubtotalSinImpuesto - @TotalDescuento;
    SET @TotalImpuesto = @SubtotalSinImpuesto * (@PorcentajeImpuesto / 100);
    SET @TotalLinea = @SubtotalSinImpuesto + @TotalImpuesto;
    
    -- INSERTAR DETALLE
    INSERT INTO DetalleVenta (
        VentaID, ProductoID, Cantidad, PrecioUnitario, PorcentajeDescuento, ImpuestoID,
        SubtotalSinImpuesto, TotalDescuento, TotalImpuesto, TotalLinea
    )
    VALUES (
        @VentaID, @ProductoID, @Cantidad, @PrecioUnitario, @PorcentajeDescuento, @ImpuestoID,
        @SubtotalSinImpuesto, @TotalDescuento, @TotalImpuesto, @TotalLinea
    );
    
    -- ACTUALIZAR TOTALES
    UPDATE Ventas
    SET 
        SubtotalSinImpuesto = SubtotalSinImpuesto + @SubtotalSinImpuesto,
        DescuentoTotal = DescuentoTotal + @TotalDescuento,
        TotalImpuestos = TotalImpuestos + @TotalImpuesto,
        Total = Total + @TotalLinea
    WHERE VentaID = @VentaID;
    
    RETURN 0;
END;
GO
