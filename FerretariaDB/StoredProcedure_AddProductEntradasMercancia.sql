
-- Procedimiento para Agregar Producto a Entrada de Mercancía

CREATE PROCEDURE sp_AgregarProductoEntradaMercancia
    @EntradaID INT,
    @ProductoID INT,
    @CantidadRecibida INT,
    @PrecioUnitario DECIMAL(12,2),
    @ImpuestoID INT,
    @ZonaID INT = NULL,
    @DetalleOrdenCompraID INT = NULL
AS
BEGIN
    SET NOCOUNT ON;
    
    DECLARE @SubtotalSinImpuesto DECIMAL(12,2);
    DECLARE @TotalImpuesto DECIMAL(12,2);
    DECLARE @TotalLinea DECIMAL(12,2);
    DECLARE @PorcentajeImpuesto DECIMAL(5,2);
    
    -- OBTENER PORCENTAJE DE IMPUESTO
    SELECT @PorcentajeImpuesto = Porcentaje FROM Impuestos WHERE ImpuestoID = @ImpuestoID;
    
    SET @SubtotalSinImpuesto = @CantidadRecibida * @PrecioUnitario;
    SET @TotalImpuesto = @SubtotalSinImpuesto * (@PorcentajeImpuesto / 100);
    SET @TotalLinea = @SubtotalSinImpuesto + @TotalImpuesto;
    
    INSERT INTO DetalleEntradaMercancia (
        EntradaID, ProductoID, CantidadRecibida, PrecioUnitario, ImpuestoID,
        SubtotalSinImpuesto, TotalImpuesto, TotalLinea, DetalleOrdenCompraID, ZonaID
    )
    VALUES (
        @EntradaID, @ProductoID, @CantidadRecibida, @PrecioUnitario, @ImpuestoID,
        @SubtotalSinImpuesto, @TotalImpuesto, @TotalLinea, @DetalleOrdenCompraID, @ZonaID
    );
    
    -- Actualizar totales en EntradasMercancia
    UPDATE EntradasMercancia
    SET 
        SubtotalSinImpuesto = SubtotalSinImpuesto + @SubtotalSinImpuesto,
        TotalImpuestos = TotalImpuestos + @TotalImpuesto,
        Total = Total + @TotalLinea
    WHERE EntradaID = @EntradaID;
    
    RETURN 0;
END;
GO
