-- PROCEDIMIENTO PARA CONFIFRMAR ENTRADA DE MERCANCIA

CREATE PROCEDURE sp_ConfirmarEntradaMercancia
    @EntradaID INT,
    @EmpleadoID INT
AS
BEGIN
    SET NOCOUNT ON;
    
    DECLARE @EstadoCompletadoID INT;
    DECLARE @TipoMovimientoEntradaID INT;
    DECLARE @ProductoID INT;
    DECLARE @CantidadRecibida INT;
    DECLARE @AlmacenID INT;
    DECLARE @ZonaID INT;
    DECLARE @MovimientoID INT;
    --CONSULTAMOS EL ESTADOO COMPLETO
    SELECT @EstadoCompletadoID = EstadoID FROM EstadosDocumento WHERE Nombre = 'Completado';
    
    -- Obtener tipo de movimiento para entrada
    SELECT @TipoMovimientoEntradaID = TipoMovimientoID FROM TiposMovimientoInventario WHERE Nombre = 'Entrada Compra';
    
    -- Obtener datos de la entrada
    SELECT @AlmacenID = AlmacenID FROM EntradasMercancia WHERE EntradaID = @EntradaID;
    
    -- Cambiar estado de la entrada
    UPDATE EntradasMercancia
    SET EstadoID = @EstadoCompletadoID
    WHERE EntradaID = @EntradaID;
    
    -- Crear cursor para procesar cada línea de detalle
    DECLARE cursorDetalles CURSOR FOR
    SELECT ProductoID, CantidadRecibida, ZonaID
    FROM DetalleEntradaMercancia
    WHERE EntradaID = @EntradaID;
    
    OPEN cursorDetalles;
    
    FETCH NEXT FROM cursorDetalles INTO @ProductoID, @CantidadRecibida, @ZonaID;
    
    WHILE @@FETCH_STATUS = 0
    BEGIN
        -- REGISTRO DE MOVIMIENTOS DE INVENTARIO
        INSERT INTO MovimientosInventario (
            FechaMovimiento, TipoMovimientoID, ProductoID, AlmacenDestinoID,
            Cantidad, DocumentoReferenciaID, TipoDocumentoReferencia, EmpleadoID
        )
        VALUES (
            GETDATE(), @TipoMovimientoEntradaID, @ProductoID, @AlmacenID,
            @CantidadRecibida, @EntradaID, 'Entrada', @EmpleadoID
        );
        
        SET @MovimientoID = SCOPE_IDENTITY();
        
        -- ACTUALIZAMOS INVENTARIO
        IF EXISTS (SELECT 1 FROM Inventario WHERE ProductoID = @ProductoID AND AlmacenID = @AlmacenID)
        BEGIN
            UPDATE Inventario
            SET 
                Existencia = Existencia + @CantidadRecibida,
                UltimoPrecioCompra = (SELECT PrecioUnitario FROM DetalleEntradaMercancia WHERE EntradaID = @EntradaID AND ProductoID = @ProductoID),
                FechaUltimaEntrada = GETDATE(),
                ZonaID = ISNULL(@ZonaID, ZonaID)
            WHERE ProductoID = @ProductoID AND AlmacenID = @AlmacenID;
        END
        ELSE
        BEGIN
            INSERT INTO Inventario (ProductoID, AlmacenID, ZonaID, Existencia, UltimoPrecioCompra, FechaUltimaEntrada)
            VALUES (@ProductoID, @AlmacenID, @ZonaID, @CantidadRecibida, 
                   (SELECT PrecioUnitario FROM DetalleEntradaMercancia WHERE EntradaID = @EntradaID AND ProductoID = @ProductoID),
                   GETDATE());
        END
        
		--ACTULIZAMOS COSTO PROMEDIO EN LA TABLA DE PRODUCTOS
        UPDATE Productos
        SET 
            PrecioCompraPromedio = (
                SELECT 
                    (PrecioCompraPromedio * (
                        SELECT SUM(Existencia) FROM Inventario WHERE ProductoID = @ProductoID AND AlmacenID != @AlmacenID
                    ) + 
                    (SELECT PrecioUnitario FROM DetalleEntradaMercancia WHERE EntradaID = @EntradaID AND ProductoID = @ProductoID) * @CantidadRecibida
                    ) / (
                        (SELECT SUM(Existencia) FROM Inventario WHERE ProductoID = @ProductoID AND AlmacenID != @AlmacenID) + @CantidadRecibida
                    )
            ),
            FechaModificacion = GETDATE()
        WHERE ProductoID = @ProductoID;
        
        FETCH NEXT FROM cursorDetalles INTO @ProductoID, @CantidadRecibida, @ZonaID;
    END
    
    CLOSE cursorDetalles;
    DEALLOCATE cursorDetalles;
    
    RETURN 0;
END;
GO
