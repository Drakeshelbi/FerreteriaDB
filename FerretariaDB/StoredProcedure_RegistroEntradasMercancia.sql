-- Procedimiento para Registrar Entrada de Mercancía

CREATE PROCEDURE sp_RegistrarEntradaMercancia
    @OrdenCompraID INT = NULL,
    @ProveedorID INT,
    @NumeroFactura VARCHAR(30),
    @AlmacenID INT,
    @EmpleadoID INT,
    @Observaciones VARCHAR(500) = NULL,
    @EntradaID INT OUTPUT
AS
BEGIN
    SET NOCOUNT ON;
    
    DECLARE @NumeroEntrada VARCHAR(20);
    DECLARE @FechaActual DATETIME = GETDATE();
    DECLARE @EstadoPendienteID INT;
    
    -- Aquí debemos de obtener el estado pendiente
    SELECT @EstadoPendienteID = EstadoID FROM EstadosDocumento WHERE Nombre = 'Pendiente';
    
    -- Generar número de entrada
    SELECT @NumeroEntrada = 'ENT-' + RIGHT('0000' + CAST(
        ISNULL((SELECT MAX(CAST(SUBSTRING(NumeroEntrada, 5, 5) AS INT)) FROM EntradasMercancia), 0) + 1 
    AS VARCHAR), 5);
    
    -- Crear la cabecera de entrada
    INSERT INTO EntradasMercancia (
        NumeroEntrada, OrdenCompraID, ProveedorID, NumeroFacturaProveedor, 
        FechaRecepcion, AlmacenID, EmpleadoRecibeID, EstadoID, Observaciones
    )
    VALUES (
        @NumeroEntrada, @OrdenCompraID, @ProveedorID, @NumeroFactura,
        @FechaActual, @AlmacenID, @EmpleadoID, @EstadoPendienteID, @Observaciones
    );
    
    SET @EntradaID = SCOPE_IDENTITY();
    
    RETURN 0;
END;
GO