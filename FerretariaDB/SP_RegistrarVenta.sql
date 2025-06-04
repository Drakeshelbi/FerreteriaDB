-- PROCEDIMEINTO PARA REGISTRAR VENTA

CREATE PROCEDURE sp_RegistrarVenta
    @ClienteID INT,
    @EmpleadoID INT,
    @FormaPagoID INT,
    @AlmacenID INT,
    @Observaciones VARCHAR(500) = NULL,
    @VentaID INT OUTPUT
AS
BEGIN
    SET NOCOUNT ON;
    
    DECLARE @NumeroFactura VARCHAR(20);
    DECLARE @SerieFactura VARCHAR(10) = 'A';
    DECLARE @FechaActual DATETIME = GETDATE();
    DECLARE @EstadoProcesadoID INT;
    
    -- Obtener estado procesado
    SELECT @EstadoProcesadoID = EstadoID FROM EstadosDocumento WHERE Nombre = 'Procesado';
    
    -- Obtener siguiente número de factura
    UPDATE SecuenciasDocumentos
    SET @NumeroFactura = FormatoNumero + CAST(UltimoNumero + 1 AS VARCHAR),
        UltimoNumero = UltimoNumero + 1
    WHERE TipoDocumento = 'Factura' AND Serie = @SerieFactura;
    
    -- Si no existe la secuencia, crearla
    IF @NumeroFactura IS NULL
    BEGIN
        INSERT INTO SecuenciasDocumentos (TipoDocumento, Serie, UltimoNumero, FormatoNumero)
        VALUES ('Factura', @SerieFactura, 1, 'FAC-');
        
        SET @NumeroFactura = 'FAC-1';
    END
    
    INSERT INTO Ventas (
        NumeroFactura, SerieFactura, ClienteID, EmpleadoID, FechaVenta,
        FormaPagoID, EstadoID, AlmacenID, Observaciones
    )
    VALUES (
        @NumeroFactura, @SerieFactura, @ClienteID, @EmpleadoID, @FechaActual,
        @FormaPagoID, @EstadoProcesadoID, @AlmacenID, @Observaciones
    );
    
    SET @VentaID = SCOPE_IDENTITY();
    
    RETURN 0;
END;
GO
