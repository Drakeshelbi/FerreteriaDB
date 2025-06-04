USE FerreteriaDB;
GO
-- Insertar registros en tabla TiposDocumento
INSERT INTO TiposDocumento (Nombre, Abreviatura, Activo)
VALUES 
('Cédula de Ciudadanía', 'CC', 1),
('Tarjeta de Identidad', 'TI', 1),
('Pasaporte', 'PAS', 1),
('NIT', 'NIT', 1),
('Cédula de Extranjería', 'CE', 1);

-- Insertar registros en tabla Categorias
INSERT INTO Categorias (Nombre, Descripcion, Activa)
VALUES 
('Herramientas Manuales', 'Herramientas que no requieren electricidad', 1),
('Herramientas Eléctricas', 'Herramientas que funcionan con electricidad', 1),
('Materiales de Construcción', 'Materiales para construcción y reformas', 1),
('Plomería', 'Artículos para instalaciones de agua', 1),
('Electricidad', 'Artículos para instalaciones eléctricas', 1),
('Pinturas', 'Pinturas y accesorios', 1),
('Jardinería', 'Herramientas y productos para jardín', 1),
('Cerrajería', 'Cerraduras, llaves y accesorios', 1);

-- Insertar registros en tabla UnidadesMedida
INSERT INTO UnidadesMedida (Nombre, Abreviatura, Activa)
VALUES 
('Unidad', 'UN', 1),
('Metro', 'M', 1),
('Kilogramo', 'KG', 1),
('Litro', 'L', 1),
('Metro Cuadrado', 'M2', 1),
('Metro Cúbico', 'M3', 1),
('Pulgada', 'IN', 1),
('Paquete', 'PAQ', 1),
('Galón', 'GAL', 1);

-- Insertar registros en tabla Impuestos
INSERT INTO Impuestos (Nombre, Porcentaje, FechaInicio, FechaFin, Activo)
VALUES 
('IVA General', 16.00, '2023-01-01', NULL, 1),
('IVA Reducido', 8.00, '2023-01-01', NULL, 1),
('Exento', 0.00, '2023-01-01', NULL, 1);

-- Insertar registros en tabla Marcas
INSERT INTO Marcas (Nombre, Descripcion, Activa)
VALUES 
('DeWalt', 'Fabricante de herramientas de alta calidad', 1),
('Stanley', 'Herramientas manuales profesionales', 1),
('Bosch', 'Herramientas eléctricas y accesorios', 1),
('Truper', 'Fabricante de herramientas económicas', 1),
('3M', 'Productos para construcción y seguridad', 1),
('Loctite', 'Adhesivos industriales y selladores', 1),
('Sherwin Williams', 'Pinturas y recubrimientos', 1),
('Sika', 'Productos químicos para construcción', 1);

-- Insertar registros en tabla Cargos
INSERT INTO Cargos (Nombre, Descripcion, Activo)
VALUES 
('Gerente General', 'Responsable de la gestión global de la ferretería', 1),
('Supervisor de Ventas', 'Supervisa al equipo de vendedores', 1),
('Vendedor', 'Atiende a los clientes y realiza ventas', 1),
('Encargado de Almacén', 'Responsable del inventario y organización del almacén', 1),
('Contador', 'Responsable de la contabilidad y finanzas', 1),
('Auxiliar de Bodega', 'Apoyo en actividades de almacén', 1);

-- Insertar registros en tabla Personas (empleados)
INSERT INTO Personas (TipoDocumentoID, NumeroDocumento, P_Nombre, S_Nombre, FechaNacimiento, Direccion, Ciudad, Departamento, Pais, Telefono_P, Email, Activo)
VALUES 
(1, '1234567890', 'Juan', 'Carlos', '1980-05-15', 'Calle 123 #45-67', 'Toluca', 'Estado de México', 'México', '7221234567', 'juan.carlos@ferreteria.com', 1),
(1, '2345678901', 'María', 'Fernanda', '1985-10-20', 'Av. Principal 234', 'Toluca', 'Estado de México', 'México', '7222345678', 'maria.fernanda@ferreteria.com', 1),
(1, '3456789012', 'Roberto', 'Alejandro', '1990-03-25', 'Calle Central 45', 'Metepec', 'Estado de México', 'México', '7223456789', 'roberto.alejandro@ferreteria.com', 1),
(1, '4567890123', 'Ana', 'Lucía', '1988-07-12', 'Av. Reforma 67', 'Toluca', 'Estado de México', 'México', '7224567890', 'ana.lucia@ferreteria.com', 1),
(1, '5678901234', 'Pedro', 'Pablo', '1983-12-03', 'Calle 5 de Mayo #12', 'Lerma', 'Estado de México', 'México', '7225678901', 'pedro.pablo@ferreteria.com', 1);

-- Insertar registros en tabla Empleados
INSERT INTO Empleados (PersonaID, CargoID, FechaContratacion, JefeDirectoID, Salario)
VALUES 
(1, 1, '2018-01-15', NULL, 45000.00), -- Juan Carlos (Gerente)
(2, 2, '2019-03-20', 1, 28000.00),    -- María Fernanda (Supervisor)
(3, 3, '2020-05-10', 2, 18000.00),    -- Roberto (Vendedor)
(4, 4, '2019-08-05', 1, 25000.00),    -- Ana (Encargado Almacén)
(5, 6, '2021-02-18', 4, 16000.00);    -- Pedro (Auxiliar Bodega)

-- Insertar registros en tabla Almacenes
INSERT INTO Almacenes (Nombre, Direccion, Telefono, ResponsableID, Activo)
VALUES 
('Almacén Principal', 'Carretera Toluca-México Km 5', '7229876543', 4, 1),
('Bodega Materiales', 'Av. Industrial #123', '7228765432', 4, 1);

-- Insertar registros en tabla ZonasAlmacen
INSERT INTO ZonasAlmacen (AlmacenID, Nombre, Descripcion)
VALUES 
(1, 'Zona A', 'Herramientas manuales y eléctricas'),
(1, 'Zona B', 'Materiales de construcción'),
(1, 'Zona C', 'Plomería y electricidad'),
(1, 'Zona D', 'Pinturas y acabados'),
(2, 'Zona A', 'Materiales pesados'),
(2, 'Zona B', 'Materiales para exteriores');

-- Insertar registros en tabla FormasPago
INSERT INTO FormasPago (Nombre, RequiereVerificacion, RequiereAprobacion, PlazosDias, Activa)
VALUES 
('Efectivo', 0, 0, 0, 1),
('Tarjeta de Débito', 1, 0, 0, 1),
('Tarjeta de Crédito', 1, 0, 0, 1),
('Transferencia Bancaria', 1, 1, 1, 1),
('Crédito 30 días', 0, 1, 30, 1);

-- Insertar registros en tabla EstadosDocumento
INSERT INTO EstadosDocumento (Nombre, Descripcion, Activo)
VALUES 
('Pendiente', 'Documento en proceso de creación', 1),
('Aprobado', 'Documento verificado y aprobado', 1),
('En Proceso', 'En etapa de ejecución', 1),
('Completado', 'Proceso finalizado correctamente', 1),
('Cancelado', 'Documento cancelado', 1),
('Devuelto', 'Mercancía devuelta', 1);

-- Insertar registros en tabla TiposMovimientoInventario
INSERT INTO TiposMovimientoInventario (Nombre, Descripcion, AfectaStock, RequiereAprobacion, Activo)
VALUES 
('Entrada por Compra', 'Ingreso de productos por compra a proveedor', 1, 0, 1),
('Salida por Venta', 'Salida de productos por venta', -1, 0, 1),
('Ajuste de Inventario +', 'Incremento manual de inventario', 1, 1, 1),
('Ajuste de Inventario -', 'Reducción manual de inventario', -1, 1, 1),
('Traslado Entre Almacenes', 'Movimiento entre almacenes o zonas', 0, 0, 1),
('Devolución de Cliente', 'Reingreso por devolución de cliente', 1, 0, 1);

-- Insertar registros en tabla Productos
INSERT INTO Productos (CodigoSKU, CodigoBarras, Nombre, Descripcion, CategoriaID, MarcaID, UnidadMedidaID, ImpuestoID, PrecioCompraPromedio, PrecioVentaBase, PuntoReorden, StockMinimo, StockMaximo, Peso, Activo)
VALUES 
('HM001', '7501234567890', 'Martillo de carpintero', 'Martillo con mango ergonómico', 1, 2, 1, 1, 85.00, 149.00, 5, 3, 50, 0.5, 1),
('HM002', '7501234567891', 'Juego de destornilladores', 'Set de 6 destornilladores', 1, 2, 8, 1, 120.00, 199.00, 3, 2, 30, 0.8, 1),
('HE001', '7501234567892', 'Taladro percutor 1/2"', 'Taladro eléctrico 750W', 2, 1, 1, 1, 850.00, 1499.00, 2, 1, 20, 2.5, 1),
('MC001', '7501234567893', 'Cemento gris 50kg', 'Cemento para construcción', 3, 8, 3, 1, 120.00, 189.00, 10, 5, 100, 50.0, 1),
('PL001', '7501234567894', 'Tubo PVC 4" x 3m', 'Tubería para drenaje', 4, 4, 1, 1, 95.00, 159.00, 5, 3, 50, 1.2, 1),
('EL001', '7501234567895', 'Cable THW cal. 12', 'Cable para instalaciones', 5, 3, 2, 1, 8.50, 15.90, 100, 50, 500, 0.1, 1),
('PI001', '7501234567896', 'Pintura vinílica blanca 19L', 'Pintura para interiores', 6, 7, 9, 1, 650.00, 999.00, 3, 2, 30, 20.0, 1),
('JA001', '7501234567897', 'Pala punta redonda', 'Pala para jardín con mango de madera', 7, 4, 1, 1, 110.00, 189.00, 4, 2, 40, 1.5, 1),
('CE001', '7501234567898', 'Cerradura para puerta principal', 'Cerradura de seguridad', 8, 3, 1, 1, 350.00, 599.00, 3, 2, 25, 0.8, 1),
('HE002', '7501234567899', 'Amoladora angular 4 1/2"', 'Esmeril angular 850W', 2, 1, 1, 1, 780.00, 1299.00, 2, 1, 15, 2.0, 1);

-- Insertar registros en tabla Inventario
INSERT INTO Inventario (ProductoID, AlmacenID, ZonaID, Existencia, ExistenciaMinima, UbicacionEspecifica, UltimoPrecioCompra, FechaUltimaEntrada)
VALUES 
(1, 1, 1, 20, 3, 'Estante A-1', 85.00, '2023-05-10'),
(2, 1, 1, 15, 2, 'Estante A-2', 120.00, '2023-05-10'),
(3, 1, 1, 8, 1, 'Estante A-3', 850.00, '2023-04-15'),
(4, 2, 5, 45, 5, 'Pallet B-1', 120.00, '2023-05-05'),
(5, 1, 3, 12, 3, 'Estante C-1', 95.00, '2023-04-20'),
(6, 1, 3, 200, 50, 'Estante C-2', 8.50, '2023-05-15'),
(7, 1, 4, 10, 2, 'Estante D-1', 650.00, '2023-04-10'),
(8, 2, 6, 8, 2, 'Pallet B-2', 110.00, '2023-05-02'),
(9, 1, 1, 6, 2, 'Estante A-4', 350.00, '2023-04-25'),
(10, 1, 1, 5, 1, 'Estante A-5', 780.00, '2023-04-18');

-- Insertar registros en tabla Personas (clientes)
INSERT INTO Personas (TipoDocumentoID, NumeroDocumento, P_Nombre, S_Nombre, RazonSocial, Direccion, Ciudad, Departamento, Pais, Telefono_P, Email, Activo)
VALUES 
(1, '1111111111', 'Luis', 'Méndez', NULL, 'Calle Benito Juárez #45', 'Toluca', 'Estado de México', 'México', '7227777771', 'luis.mendez@gmail.com', 1),
(1, '2222222222', 'Carmen', 'Rodríguez', NULL, 'Av. Hidalgo #123', 'Metepec', 'Estado de México', 'México', '7227777772', 'carmen.rodriguez@hotmail.com', 1),
(4, '3333333333', NULL, NULL, 'Constructora Azteca SA de CV', 'Blvd. Aeropuerto #500', 'Toluca', 'Estado de México', 'México', '7227777773', 'compras@constructoraazteca.com', 1),
(1, '4444444444', 'Jorge', 'Sánchez', NULL, 'Calle Morelos #67', 'Lerma', 'Estado de México', 'México', '7227777774', 'jorge.sanchez@gmail.com', 1),
(4, '5555555555', NULL, NULL, 'Plomería y Electricidad Express', 'Av. Las Torres #890', 'Toluca', 'Estado de México', 'México', '7227777775', 'contacto@plomeriaexpress.com', 1);

-- Insertar registros en tabla Clientes
INSERT INTO Clientes (PersonaID, CategoriaCliente, DiasCredito, ClasificacionCrediticia, Observaciones)
VALUES 
(6, 'Regular', 0, 'A', 'Cliente frecuente, compra materiales para su casa'),
(7, 'Regular', 0, 'A', 'Cliente ocasional'),
(8, 'Mayorista', 30, 'A', 'Empresa constructora, volúmenes grandes'),
(9, 'VIP', 15, 'B', 'Cliente antiguo, compras frecuentes'),
(10, 'Mayorista', 15, 'A', 'Empresa de servicios, compras regulares');

-- Insertar registros en tabla Personas (proveedores)
INSERT INTO Personas (TipoDocumentoID, NumeroDocumento, P_Nombre, S_Nombre, RazonSocial, Direccion, Ciudad, Departamento, Pais, Telefono_P, Email, Activo)
VALUES 
(4, '6666666666', NULL, NULL, 'Distribuidora de Materiales SA', 'Carretera México-Toluca Km 50', 'Lerma', 'Estado de México', 'México', '7226666661', 'ventas@distribuidoramateriales.com', 1),
(4, '7777777777', NULL, NULL, 'Herramientas Industriales de México', 'Av. Industrial #789', 'Toluca', 'Estado de México', 'México', '7226666662', 'contacto@herramientasindustriales.com', 1),
(4, '8888888888', NULL, NULL, 'Pinturas y Acabados SA de CV', 'Blvd. Isidro Fabela #123', 'Toluca', 'Estado de México', 'México', '7226666663', 'ventas@pinturasyacabados.com', 1);

-- Insertar registros en tabla Proveedores
INSERT INTO Proveedores (PersonaID, TipoProveedor, SitioWeb, DiasEntrega, DiasCredito, Calificacion, Observaciones)
VALUES 
(11, 'Material para construcción', 'www.distribuidoramateriales.com', 3, 30, 5, 'Proveedor principal de cemento y materiales'),
(12, 'Herramientas', 'www.herramientasindustriales.com', 2, 15, 4, 'Distribuidor oficial de DeWalt y Stanley'),
(13, 'Pinturas', 'www.pinturasyacabados.com', 2, 30, 4, 'Buen proveedor, precios competitivos');

-- Insertar registros en tabla SecuenciasDocumentos
INSERT INTO SecuenciasDocumentos (TipoDocumento, Serie, UltimoNumero, FormatoNumero, Activa)
VALUES 
('Factura', 'A', 0, 'FAC-{SERIE}{NUMERO:6}', 1),
('Orden de Compra', 'OC', 0, 'OC-{NUMERO:6}', 1),
('Remisión', 'R', 0, 'REM-{NUMERO:6}', 1),
('Cotización', 'COT', 0, 'COT-{NUMERO:6}', 1),
('Nota de Crédito', 'NC', 0, 'NC-{NUMERO:6}', 1);

-- Insertar registros en tabla OrdenesCompra
INSERT INTO OrdenesCompra (NumeroOrden, ProveedorID, FechEmision, FechaEntregaEsperada, EmpleadoID, EstadoID, SubtotalSinImpuesto, TotalImpuestos, Total, Observaciones)
VALUES 
('OC-000001', 1, '2023-05-01', '2023-05-08', 1, 4, 9000.00, 1440.00, 10440.00, 'Pedido regular de materiales'),
('OC-000002', 2, '2023-05-05', '2023-05-10', 1, 3, 12500.00, 2000.00, 14500.00, 'Pedido de herramientas eléctricas');

-- Insertar registros en tabla DetalleCompra
INSERT INTO DetalleCompra (OrdenCompraID, ProductoID, Cantidad, PrecioUnitario, PorcentajeDescuento, ImpuestoID, SubtotalImpuesto, TotalImpuesto, TotalLinea)
VALUES 
(1, 4, 50, 120.00, 0, 1, 6000.00, 960.00, 6960.00),
(1, 5, 30, 95.00, 0, 1, 2850.00, 456.00, 3306.00),
(1, 8, 10, 110.00, 0, 1, 1100.00, 176.00, 1276.00),
(2, 3, 5, 850.00, 0, 1, 4250.00, 680.00, 4930.00),
(2, 10, 10, 780.00, 0, 1, 7800.00, 1248.00, 9048.00);

-- Insertar registros en tabla EntradasMercancia
INSERT INTO EntradasMercancia (NumeroEntrada, OrdenCompraID, ProveedorID, NumeroFacturaProveedor, FechaRecepcion, AlmacenID, EmpleadoRecibeID, EstadoID, SubtotalSinImpuesto, TotalImpuestos, Total, Observaciones)
VALUES 
('ENT-000001', 1, 1, 'FAC-12345', '2023-05-10', 2, 5, 4, 9000.00, 1440.00, 10440.00, 'Recepción completa del pedido'),
('ENT-000002', 2, 2, 'FAC-54321', '2023-05-15', 1, 5, 4, 12500.00, 2000.00, 14500.00, 'Recepción completa del pedido');

-- Insertar registros en tabla DetalleEntradaMercancia
INSERT INTO DetalleEntradaMercancia (EntradaID, ProductoID, CantidadRecibida, PrecioUnitario, ImpuestoID, SubtotalSinImpuesto, TotalImpuesto, TotalLinea, DetalleOrdenCompraID, ZonaID)
VALUES 
(1, 4, 50, 120.00, 1, 6000.00, 960.00, 6960.00, 1, 5),
(1, 5, 30, 95.00, 1, 2850.00, 456.00, 3306.00, 2, 5),
(1, 8, 10, 110.00, 1, 1100.00, 176.00, 1276.00, 3, 6),
(2, 3, 5, 850.00, 1, 4250.00, 680.00, 4930.00, 4, 1),
(2, 10, 10, 780.00, 1, 7800.00, 1248.00, 9048.00, 5, 1);

-- Insertar registros en tabla Ventas
INSERT INTO Ventas (NumeroFactura, SerieFactura, ClienteID, EmpleadoID, FechaVenta, FormaPagoID, EstadoID, AlmacenID, SubtotalSinImpuesto, DescuentoTotal, TotalImpuestos, Total, Observaciones)
VALUES 
('000001', 'A', 3, 3, '2023-05-20', 1, 4, 1, 3000.00, 0.00, 480.00, 3480.00, 'Venta para proyecto de construcción'),
('000002', 'A', 1, 3, '2023-05-21', 3, 4, 1, 1499.00, 0.00, 239.84, 1738.84, 'Venta de herramienta eléctrica');

-- Insertar registros en tabla DetalleVenta
INSERT INTO DetalleVenta (VentaID, ProductoID, Cantidad, PrecioUnitario, PorcentajeDescuento, ImpuestoID, SubtotalSinImpuesto, TotalDescuento, TotalImpuesto, TotalLinea)
VALUES 
(1, 4, 10, 189.00, 0, 1, 1890.00, 0.00, 302.40, 2192.40),
(1, 5, 7, 159.00, 0, 1, 1113.00, 0.00, 178.08, 1291.08),
(2, 3, 1, 1499.00, 0, 1, 1499.00, 0.00, 239.84, 1738.84);

-- Insertar registros en tabla MovimientosInventario (para las ventas)
INSERT INTO MovimientosInventario (FechaMovimiento, TipoMovimientoID, ProductoID, AlmacenOrigenID, Cantidad, DocumentoReferenciaID, TipoDocumentoReferencia, EmpleadoID, Observaciones)
VALUES 
('2023-05-20', 2, 4, 2, 10, 1, 'Venta', 3, 'Salida por venta #000001-A'),
('2023-05-20', 2, 5, 1, 7, 1, 'Venta', 3, 'Salida por venta #000001-A'),
('2023-05-21', 2, 3, 1, 1, 2, 'Venta', 3, 'Salida por venta #000002-A');

-- Insertar registros en tabla Cotizaciones
INSERT INTO Cotizaciones (NumeroCotizacion, ClienteID, EmpleadoID, FechaCotizacion, ValidaHasta, EstadoID, SubtotalSinImpuesto, TotalImpuestos, Total, VentaGeneradaID, Observaciones)
VALUES 
('COT-000001', 3, 3, '2023-05-18', '2023-06-18', 4, 3000.00, 480.00, 3480.00, 1, 'Cotización para proyecto de construcción'),
('COT-000002', 5, 3, '2023-05-22', '2023-06-22', 2, 5000.00, 800.00, 5800.00, NULL, 'Cotización para renovación de plomería');

-- Insertar registros en tabla DetalleCotizacion
INSERT INTO DetalleCotizacion (CotizacionID, ProductoID, Cantidad, PrecioUnitario, PorcentajeDescuento, ImpuestoID, SubtotalSinImpuesto, TotalDescuento, TotalImpuesto, TotalLinea)
VALUES 
(1, 4, 10, 189.00, 0, 1, 1890.00, 0.00, 302.40, 2192.40),
(1, 5, 7, 159.00, 0, 1, 1113.00, 0.00, 178.08, 1291.08),
(2, 5, 15, 159.00, 0, 1, 2385.00, 0.00, 381.60, 2766.60),
(2, 6, 200, 15.90, 5, 1, 3180.00, 159.00, 512.40, 3533.40);

-- Insertar registros en tabla PagosVenta
INSERT INTO PagosVenta (VentaID, FormaPagoID, Monto, FechaPago, NumeroReferencia, EmpleadoRegistraID, Observaciones)
VALUES 
(1, 1, 3480.00, '2023-05-20', NULL, 3, 'Pago en efectivo'),
(2, 3, 1738.84, '2023-05-21', 'TC-1234567', 3, 'Pago con tarjeta de crédito');

-- Insertar registros en tabla ConfiguracionSistema
INSERT INTO ConfiguracionSistema (Clave, Valor, Descripcion, TipoDato, ModificablePorUsuario, EmpleadoModificaID)
VALUES 
('EMPRESA_NOMBRE', 'Ferretería El Constructor', 'Nombre de la empresa', 'String', 0, 1),
('EMPRESA_DIRECCION', 'Av. Principal #123, Col. Centro, Toluca, Estado de México', 'Dirección fiscal', 'String', 0, 1),
('EMPRESA_TELEFONO', '7221234567', 'Teléfono principal', 'String', 1, 1),
('EMPRESA_EMAIL', 'contacto@ferreteriaelconstructor.com', 'Email de contacto', 'String', 1, 1),
('IMPUESTO_DEFECTO', '1', 'ID del impuesto por defecto', 'Integer', 1, 1),
('DIAS_COTIZACION', '30', 'Días de validez para cotizaciones', 'Integer', 1, 1);

-- Insertar registros en tabla PeriodosReporte
INSERT INTO PeriodosReporte (Nombre, FechaInicio, FechaFin, Tipo, Cerrado)
VALUES 
('Enero 2023', '2023-01-01', '2023-01-31', 'Mensual', 1),
('Febrero 2023', '2023-02-01', '2023-02-28', 'Mensual', 1),
('Marzo 2023', '2023-03-01', '2023-03-31', 'Mensual', 1),
('Abril 2023', '2023-04-01', '2023-04-30', 'Mensual', 1),
('Mayo 2023', '2023-05-01', '2023-05-31', 'Mensual', 0),
('Q1 2023', '2023-01-01', '2023-03-31', 'Trimestral', 1),
('Q2 2023', '2023-04-01', '2023-06-30', 'Trimestral', 0),
('Primer Semestre 2023', '2023-01-01', '2023-06-30', 'Semestral', 0);

-- Insertar registros en tabla MetasVenta
INSERT INTO MetasVenta (PeriodoID, EmpleadoID, CategoriaID, MontoMeta, Descripcion)
VALUES 
(5, NULL, NULL, 150000.00, 'Meta global para Mayo 2023'),
(5, 3, NULL, 50000.00, 'Meta personal para vendedor Roberto en Mayo'),
(5, NULL, 2, 30000.00, 'Meta para categoría Herramientas Eléctricas en Mayo'),
(5, NULL, 3, 40000.00, 'Meta para categoría Materiales de Construcción en Mayo'),
(7, NULL, NULL, 800000.00, 'Meta global para Q2 2023'),
(8, NULL, NULL, 1500000.00, 'Meta global para primer semestre 2023');

-- Insertar registros en tabla Remisiones
INSERT INTO Remisiones (NumeroRemision, VentaID, FechaRemision, EmpleadoEntregaID, DireccionEntrega, EstadoID, Observaciones)
VALUES 
('REM-000001', 1, '2023-05-20', 5, 'Obra en construcción, Blvd. Aeropuerto #500, Toluca', 4, 'Entrega realizada correctamente'),
('REM-000002', 2, '2023-05-21', 5, 'Calle Benito Juárez #45, Toluca', 4, 'Entrega a domicilio');

-- Insertar registros en tabla DetalleRemision
INSERT INTO DetalleRemision (RemisionID, DetalleVentaID, CantidadEntregada)
VALUES 
(1, 1, 10),
(1, 2, 7),
(2, 3, 1);

-- Insertar registros en tabla AjustesInventario
INSERT INTO AjustesInventario (NumeroAjuste, FechaAjuste, EmpleadoRegistraID, EmpleadoApruebID, FechaAprobacion, EstadoID, Motivo, Observaciones)
VALUES 
('AJ-000001', '2023-05-25', 4, 1, '2023-05-26', 2, 'Inventario físico', 'Ajuste por diferencias encontradas en inventario físico'),
('AJ-000002', '2023-05-27', 4, 1, '2023-05-27', 2, 'Deterioro de producto', 'Producto dañado durante manipulación');

-- Insertar registros en tabla DetalleAjusteInventario
INSERT INTO DetalleAjusteInventario (AjusteID, ProductoID, AlmacenID, CantidadAnterior, CantidadNueva, TipoAjuste)
VALUES 
(1, 2, 1, 15, 13, 'D'),
(1, 7, 1, 10, 12, 'A'),
(2, 8, 2, 8, 7, 'D');

-- Insertar registros en tabla MovimientosInventario (para los ajustes)
INSERT INTO MovimientosInventario (FechaMovimiento, TipoMovimientoID, ProductoID, AlmacenOrigenID, Cantidad, DocumentoReferenciaID, TipoDocumentoReferencia, EmpleadoID, Observaciones)
VALUES 
('2023-05-26', 4, 2, 1, 2, 1, 'Ajuste', 4, 'Ajuste negativo por inventario físico'),
('2023-05-26', 3, 7, 1, 2, 1, 'Ajuste', 4, 'Ajuste positivo por inventario físico'),
('2023-05-27', 4, 8, 2, 1, 2, 'Ajuste', 4, 'Ajuste por deterioro');

-- Actualizar Inventario después de ajustes
UPDATE Inventario SET Existencia = 13 WHERE ProductoID = 2 AND AlmacenID = 1;
UPDATE Inventario SET Existencia = 12 WHERE ProductoID = 7 AND AlmacenID = 1;
UPDATE Inventario SET Existencia = 7 WHERE ProductoID = 8 AND AlmacenID = 2;

-- Insertar registros en tabla DevolucionesClientes
INSERT INTO DevolucionesClientes (NumeroDevolucion, VentaID, ClienteID, FechaDevolucion, MotivoDevolucion, EmpleadoRegistraID, EstadoID, Total, Observaciones)
VALUES 
('DEV-000001', 1, 3, '2023-05-22', 'Producto incorrecto', 3, 4, 159.00, 'Cliente solicitó otro modelo');

-- Insertar registros en tabla DetalleDevolucionCliente
INSERT INTO DetalleDevolucionCliente (DevolucionID, DetalleVentaID, ProductoID, CantidadDevuelta, PrecioUnitario, SubtotalSinImpuesto, TotalImpuesto, TotalLinea)
VALUES 
(1, 2, 5, 1, 159.00, 159.00, 25.44, 184.44);

-- Insertar registros en tabla MovimientosInventario (para la devolución)
INSERT INTO MovimientosInventario (FechaMovimiento, TipoMovimientoID, ProductoID, AlmacenOrigenID, Cantidad, DocumentoReferenciaID, TipoDocumentoReferencia, EmpleadoID, Observaciones)
VALUES 
('2023-05-22', 6, 5, 1, 1, 1, 'Devolución', 3, 'Devolución de cliente');

-- Actualizar Inventario después de devolución
UPDATE Inventario SET Existencia = 13 WHERE ProductoID = 5 AND AlmacenID = 1;

-- Insertar registros en tabla NotasCredito
INSERT INTO NotasCredito (NumeroNota, DevolucionID, VentaID, ClienteID, FechaEmision, EmpleadoRegistraID, Monto, Observaciones)
VALUES 
('NC-000001', 1, 1, 3, '2023-05-22', 3, 184.44, 'Nota de crédito por devolución de producto');

-- Insertar registros en tabla HistorialPreciosProductos
INSERT INTO HistorialPreciosProductos (ProductoID, PrecioAnterior, PrecioNuevo, FechaCambio, EmpleadoID, Motivo)
VALUES 
(1, 149.00, 159.00, '2023-05-15', 1, 'Incremento por aumento de costo'),
(3, 1499.00, 1599.00, '2023-05-15', 1, 'Incremento por aumento de costo'),
(4, 189.00, 199.00, '2023-05-15', 1, 'Incremento por aumento de costo');

-- Actualizar precios de productos
UPDATE Productos SET PrecioVentaBase = 159.00, FechaModificacion = '2023-05-15' WHERE ProductoID = 1;
UPDATE Productos SET PrecioVentaBase = 1599.00, FechaModificacion = '2023-05-15' WHERE ProductoID = 3;
UPDATE Productos SET PrecioVentaBase = 199.00, FechaModificacion = '2023-05-15' WHERE ProductoID = 4;

-- Insertar registros en tabla LogAccionesUsuario
INSERT INTO LogAccionesUsuario (EmpleadoID, FechaHora, Accion, TablaAfectada, RegistroID, Detalles, DireccionIP)
VALUES 
(1, '2023-05-15 10:30:00', 'Actualización', 'Productos', 1, 'Actualización de precio de producto', '192.168.1.10'),
(1, '2023-05-15 10:31:00', 'Actualización', 'Productos', 3, 'Actualización de precio de producto', '192.168.1.10'),
(1, '2023-05-15 10:32:00', 'Actualización', 'Productos', 4, 'Actualización de precio de producto', '192.168.1.10'),
(3, '2023-05-20 11:15:00', 'Inserción', 'Ventas', 1, 'Registro de nueva venta', '192.168.1.15'),
(3, '2023-05-21 09:45:00', 'Inserción', 'Ventas', 2, 'Registro de nueva venta', '192.168.1.15'),
(4, '2023-05-25 14:20:00', 'Inserción', 'AjustesInventario', 1, 'Registro de ajuste de inventario', '192.168.1.12'),
(3, '2023-05-22 13:10:00', 'Inserción', 'DevolucionesClientes', 1, 'Registro de devolución de cliente', '192.168.1.15');

-- Insertar más proveedores
INSERT INTO Personas (TipoDocumentoID, NumeroDocumento, P_Nombre, S_Nombre, RazonSocial, Direccion, Ciudad, Departamento, Pais, Telefono_P, Email, Activo)
VALUES 
(4, '9999999999', NULL, NULL, 'Materiales Eléctricos del Valle', 'Av. Electricistas #456', 'Toluca', 'Estado de México', 'México', '7226666664', 'contacto@materialeselectricos.com', 1),
(4, '1010101010', NULL, NULL, 'Plomería y Accesorios SA', 'Calle Hidalgo #789', 'Metepec', 'Estado de México', 'México', '7226666665', 'ventas@plomeriayaccesorios.com', 1);

INSERT INTO Proveedores (PersonaID, TipoProveedor, SitioWeb, DiasEntrega, DiasCredito, Calificacion, Observaciones)
VALUES 
(14, 'Electricidad', 'www.materialeselectricos.com', 2, 30, 4, 'Proveedor especializado en material eléctrico'),
(15, 'Plomería', 'www.plomeriayaccesorios.com', 3, 15, 3, 'Precios competitivos en materiales de plomería');

-- Insertar más clientes
INSERT INTO Personas (TipoDocumentoID, NumeroDocumento, P_Nombre, S_Nombre, RazonSocial, Direccion, Ciudad, Departamento, Pais, Telefono_P, Email, Activo)
VALUES 
(1, '6767676767', 'Arturo', 'González', NULL, 'Calle Pino Suárez #34', 'Toluca', 'Estado de México', 'México', '7227777776', 'arturo.gonzalez@gmail.com', 1),
(4, '7878787878', NULL, NULL, 'Acabados Residenciales SA de CV', 'Blvd. Tollocan #567', 'Metepec', 'Estado de México', 'México', '7227777777', 'compras@acabadosresidenciales.com', 1);

INSERT INTO Clientes (PersonaID, CategoriaCliente, DiasCredito, ClasificacionCrediticia, Observaciones)
VALUES 
(16, 'Regular', 0, 'A', 'Cliente nuevo'),
(17, 'Mayorista', 30, 'A', 'Empresa de acabados para construcción');

-- Insertar más productos
INSERT INTO Productos (CodigoSKU, CodigoBarras, Nombre, Descripcion, CategoriaID, MarcaID, UnidadMedidaID, ImpuestoID, PrecioCompraPromedio, PrecioVentaBase, PuntoReorden, StockMinimo, StockMaximo, Peso, Activo)
VALUES 
('PL002', '7501234567900', 'Llave mezcl. para lavabo', 'Llave monomando para baño', 4, 4, 1, 1, 320.00, 549.00, 3, 2, 25, 1.0, 1),
('EL002', '7501234567901', 'Clavija polarizada', 'Clavija de uso rudo', 5, 3, 1, 1, 12.00, 25.90, 10, 5, 100, 0.1, 1),
('PI002', '7501234567902', 'Rodillo 9"', 'Rodillo para pintar', 6, 7, 1, 1, 35.00, 59.90, 5, 3, 50, 0.3, 1),
('MC002', '7501234567903', 'Varilla 3/8" x 12m', 'Varilla corrugada para construcción', 3, 8, 1, 1, 110.00, 189.00, 10, 5, 100, 4.5, 1),
('HM003', '7501234567904', 'Nivel de burbuja 24"', 'Nivel profesional', 1, 2, 1, 1, 95.00, 169.00, 3, 2, 30, 0.6, 1);

-- Insertar inventario para nuevos productos
INSERT INTO Inventario (ProductoID, AlmacenID, ZonaID, Existencia, ExistenciaMinima, UbicacionEspecifica, UltimoPrecioCompra, FechaUltimaEntrada)
VALUES 
(11, 1, 3, 6, 2, 'Estante C-3', 320.00, '2023-05-05'),
(12, 1, 3, 25, 5, 'Estante C-4', 12.00, '2023-05-05'),
(13, 1, 4, 12, 3, 'Estante D-2', 35.00, '2023-05-05'),
(14, 2, 5, 30, 5, 'Pallet B-3', 110.00, '2023-05-05'),
(15, 1, 1, 8, 2, 'Estante A-6', 95.00, '2023-05-05');

-- Insertar más ventas
INSERT INTO Ventas (NumeroFactura, SerieFactura, ClienteID, EmpleadoID, FechaVenta, FormaPagoID, EstadoID, AlmacenID, SubtotalSinImpuesto, DescuentoTotal, TotalImpuestos, Total, Observaciones)
VALUES 
('000003', 'A', 6, 3, '2023-05-23', 1, 4, 1, 1099.90, 0.00, 175.98, 1275.88, 'Venta de materiales para remodelación'),
('000004', 'A', 5, 3, '2023-05-24', 5, 4, 1, 3500.00, 175.00, 532.00, 3857.00, 'Venta a crédito para empresa');

-- Insertar detalles de ventas
INSERT INTO DetalleVenta (VentaID, ProductoID, Cantidad, PrecioUnitario, PorcentajeDescuento, ImpuestoID, SubtotalSinImpuesto, TotalDescuento, TotalImpuesto, TotalLinea)
VALUES 
(3, 11, 1, 549.00, 0, 1, 549.00, 0.00, 87.84, 636.84),
(3, 13, 2, 59.90, 0, 1, 119.80, 0.00, 19.17, 138.97),
(3, 15, 2, 169.00, 0, 1, 338.00, 0.00, 54.08, 392.08),
(4, 14, 10, 189.00, 5, 1, 1890.00, 94.50, 287.28, 2082.78),
(4, 6, 100, 15.90, 5, 1, 1590.00, 79.50, 241.92, 1752.42);

-- Insertar movimientos de inventario para nuevas ventas
INSERT INTO MovimientosInventario (FechaMovimiento, TipoMovimientoID, ProductoID, AlmacenOrigenID, Cantidad, DocumentoReferenciaID, TipoDocumentoReferencia, EmpleadoID, Observaciones)
VALUES 
('2023-05-23', 2, 11, 1, 1, 3, 'Venta', 3, 'Salida por venta #000003-A'),
('2023-05-23', 2, 13, 1, 2, 3, 'Venta', 3, 'Salida por venta #000003-A'),
('2023-05-23', 2, 15, 1, 2, 3, 'Venta', 3, 'Salida por venta #000003-A'),
('2023-05-24', 2, 14, 2, 10, 4, 'Venta', 3, 'Salida por venta #000004-A'),
('2023-05-24', 2, 6, 1, 100, 4, 'Venta', 3, 'Salida por venta #000004-A');

-- Actualizar inventario después de ventas
UPDATE Inventario SET Existencia = 5 WHERE ProductoID = 11 AND AlmacenID = 1;
UPDATE Inventario SET Existencia = 10 WHERE ProductoID = 13 AND AlmacenID = 1;
UPDATE Inventario SET Existencia = 6 WHERE ProductoID = 15 AND AlmacenID = 1;
UPDATE Inventario SET Existencia = 20 WHERE ProductoID = 14 AND AlmacenID = 2;
UPDATE Inventario SET Existencia = 100 WHERE ProductoID = 6 AND AlmacenID = 1;

-- Insertar pagos para nuevas ventas
INSERT INTO PagosVenta (VentaID, FormaPagoID, Monto, FechaPago, NumeroReferencia, EmpleadoRegistraID, Observaciones)
VALUES 
(3, 1, 1275.88, '2023-05-23', NULL, 3, 'Pago en efectivo'),
(4, 5, 3857.00, '2023-05-24', 'CRED-001', 3, 'Pago a crédito 30 días');

-- Insertar remisiones para nuevas ventas
INSERT INTO Remisiones (NumeroRemision, VentaID, FechaRemision, EmpleadoEntregaID, DireccionEntrega, EstadoID, Observaciones)
VALUES 
('REM-000003', 3, '2023-05-23', 5, 'Calle Pino Suárez #34, Toluca', 4, 'Entrega a domicilio'),
('REM-000004', 4, '2023-05-24', 5, 'Av. Las Torres #890, Toluca', 4, 'Entrega en oficinas del cliente');

-- Insertar detalles de remisiones para nuevas ventas
INSERT INTO DetalleRemision (RemisionID, DetalleVentaID, CantidadEntregada)
VALUES 
(3, 4, 1),
(3, 5, 2),
(3, 6, 2),
(4, 7, 10),
(4, 8, 100);

-- Insertar más cotizaciones
INSERT INTO Cotizaciones (NumeroCotizacion, ClienteID, EmpleadoID, FechaCotizacion, ValidaHasta, EstadoID, SubtotalSinImpuesto, TotalImpuestos, Total, VentaGeneradaID, Observaciones)
VALUES 
('COT-000003', 7, 3, '2023-05-23', '2023-06-23', 4, 1099.90, 175.98, 1275.88, 3, 'Cotización para remodelación'),
('COT-000004', 6, 3, '2023-05-26', '2023-06-26', 2, 8500.00, 1360.00, 9860.00, NULL, 'Cotización proyecto residencial');

-- Insertar detalles de cotizaciones
INSERT INTO DetalleCotizacion (CotizacionID, ProductoID, Cantidad, PrecioUnitario, PorcentajeDescuento, ImpuestoID, SubtotalSinImpuesto, TotalDescuento, TotalImpuesto, TotalLinea)
VALUES 
(3, 11, 1, 549.00, 0, 1, 549.00, 0.00, 87.84, 636.84),
(3, 13, 2, 59.90, 0, 1, 119.80, 0.00, 19.17, 138.97),
(3, 15, 2, 169.00, 0, 1, 338.00, 0.00, 54.08, 392.08),
(4, 3, 3, 1599.00, 0, 1, 4797.00, 0.00, 767.52, 5564.52),
(4, 9, 5, 599.00, 0, 1, 2995.00, 0.00, 479.20, 3474.20),
(4, 11, 2, 549.00, 0, 1, 1098.00, 0.00, 175.68, 1273.68);

-- Insertar más registros en LogAccionesUsuario
INSERT INTO LogAccionesUsuario (EmpleadoID, FechaHora, Accion, TablaAfectada, RegistroID, Detalles, DireccionIP)
VALUES 
(3, '2023-05-23 10:15:00', 'Inserción', 'Ventas', 3, 'Registro de nueva venta', '192.168.1.15'),
(3, '2023-05-24 13:30:00', 'Inserción', 'Ventas', 4, 'Registro de nueva venta', '192.168.1.15'),
(3, '2023-05-26 09:45:00', 'Inserción', 'Cotizaciones', 4, 'Registro de nueva cotización', '192.168.1.15');

-- Insertar más órdenes de compra
INSERT INTO OrdenesCompra (NumeroOrden, ProveedorID, FechEmision, FechaEntregaEsperada, EmpleadoID, EstadoID, SubtotalSinImpuesto, TotalImpuestos, Total, Observaciones)
VALUES 
('OC-000003', 3, '2023-05-25', '2023-05-30', 1, 3, 10000.00, 1600.00, 11600.00, 'Pedido de pinturas y accesorios'),
('OC-000004', 4, '2023-05-27', '2023-06-01', 1, 2, 8000.00, 1280.00, 9280.00, 'Pedido de materiales eléctricos');

-- Insertar detalles de órdenes de compra
INSERT INTO DetalleCompra (OrdenCompraID, ProductoID, Cantidad, PrecioUnitario, PorcentajeDescuento, ImpuestoID, SubtotalImpuesto, TotalImpuesto, TotalLinea)
VALUES 
(3, 7, 10, 650.00, 0, 1, 6500.00, 1040.00, 7540.00),
(3, 13, 100, 35.00, 0, 1, 3500.00, 560.00, 4060.00),
(4, 6, 500, 8.50, 0, 1, 4250.00, 680.00, 4930.00),
(4, 12, 250, 12.00, 0, 1, 3000.00, 480.00, 3480.00);

-- Insertar registros en tabla MetasVenta
INSERT INTO MetasVenta (PeriodoID, EmpleadoID, CategoriaID, MontoMeta, Descripcion)
VALUES 
(5, NULL, NULL, 150000.00, 'Meta global para Mayo 2023'),
(5, 3, NULL, 50000.00, 'Meta personal para vendedor Roberto en Mayo'),
(5, NULL, 2, 30000.00, 'Meta para categoría Herramientas Eléctricas en Mayo'),
(5, NULL, 3, 40000.00, 'Meta para categoría Materiales de Construcción en Mayo'),
(7, NULL, NULL, 800000.00, 'Meta global para Q2 2023'),
(8, NULL, NULL, 1500000.00, 'Meta global para primer semestre 2023');

-- Insertar registros en tabla Remisiones
INSERT INTO Remisiones (NumeroRemision, VentaID, FechaRemision, EmpleadoEntregaID, DireccionEntrega, EstadoID, Observaciones)
VALUES 
('REM-000001', 1, '2023-05-20', 5, 'Obra en construcción, Blvd. Aeropuerto #500, Toluca', 4, 'Entrega realizada correctamente'),
('REM-000002', 2, '2023-05-21', 5, 'Calle Benito Juárez #45, Toluca', 4, 'Entrega a domicilio');

-- Insertar registros en tabla DetalleRemision
INSERT INTO DetalleRemision (RemisionID, DetalleVentaID, CantidadEntregada)
VALUES 
(1, 1, 10),
(1, 2, 7),
(2, 3, 1);

-- Insertar registros en tabla AjustesInventario
INSERT INTO AjustesInventario (NumeroAjuste, FechaAjuste, EmpleadoRegistraID, EmpleadoApruebID, FechaAprobacion, EstadoID, Motivo, Observaciones)
VALUES 
('AJ-000001', '2023-05-25', 4, 1, '2023-05-26', 2, 'Inventario físico', 'Ajuste por diferencias encontradas en inventario físico'),
('AJ-000002', '2023-05-27', 4, 1, '2023-05-27', 2, 'Deterioro de producto', 'Producto dañado durante manipulación');

-- Insertar registros en tabla DetalleAjusteInventario
INSERT INTO DetalleAjusteInventario (AjusteID, ProductoID, AlmacenID, CantidadAnterior, CantidadNueva, TipoAjuste)
VALUES 
(1, 2, 1, 15, 13, 'D'),
(1, 7, 1, 10, 12, 'A'),
(2, 8, 2, 8, 7, 'D');

-- Insertar registros en tabla MovimientosInventario (para los ajustes)
INSERT INTO MovimientosInventario (FechaMovimiento, TipoMovimientoID, ProductoID, AlmacenOrigenID, Cantidad, DocumentoReferenciaID, TipoDocumentoReferencia, EmpleadoID, Observaciones)
VALUES 
('2023-05-26', 4, 2, 1, 2, 1, 'Ajuste', 4, 'Ajuste negativo por inventario físico'),
('2023-05-26', 3, 7, 1, 2, 1, 'Ajuste', 4, 'Ajuste positivo por inventario físico'),
('2023-05-27', 4, 8, 2, 1, 2, 'Ajuste', 4, 'Ajuste por deterioro');

-- Actualizar Inventario después de ajustes
UPDATE Inventario SET Existencia = 13 WHERE ProductoID = 2 AND AlmacenID = 1;
UPDATE Inventario SET Existencia = 12 WHERE ProductoID = 7 AND AlmacenID = 1;
UPDATE Inventario SET Existencia = 7 WHERE ProductoID = 8 AND AlmacenID = 2;

-- Insertar registros en tabla DevolucionesClientes
INSERT INTO DevolucionesClientes (NumeroDevolucion, VentaID, ClienteID, FechaDevolucion, MotivoDevolucion, EmpleadoRegistraID, EstadoID, Total, Observaciones)
VALUES 
('DEV-000001', 1, 3, '2023-05-22', 'Producto incorrecto', 3, 4, 159.00, 'Cliente solicitó otro modelo');

-- Insertar registros en tabla DetalleDevolucionCliente
INSERT INTO DetalleDevolucionCliente (DevolucionID, DetalleVentaID, ProductoID, CantidadDevuelta, PrecioUnitario, SubtotalSinImpuesto, TotalImpuesto, TotalLinea)
VALUES 
(1, 2, 5, 1, 159.00, 159.00, 25.44, 184.44);

-- Insertar registros en tabla MovimientosInventario (para la devolución)
INSERT INTO MovimientosInventario (FechaMovimiento, TipoMovimientoID, ProductoID, AlmacenOrigenID, Cantidad, DocumentoReferenciaID, TipoDocumentoReferencia, EmpleadoID, Observaciones)
VALUES 
('2023-05-22', 6, 5, 1, 1, 1, 'Devolución', 3, 'Devolución de cliente');

-- Actualizar Inventario después de devolución
UPDATE Inventario SET Existencia = 13 WHERE ProductoID = 5 AND AlmacenID = 1;

-- Insertar registros en tabla NotasCredito
INSERT INTO NotasCredito (NumeroNota, DevolucionID, VentaID, ClienteID, FechaEmision, EmpleadoRegistraID, Monto, Observaciones)
VALUES 
('NC-000001', 1, 1, 3, '2023-05-22', 3, 184.44, 'Nota de crédito por devolución de producto');

-- Insertar registros en tabla HistorialPreciosProductos
INSERT INTO HistorialPreciosProductos (ProductoID, PrecioAnterior, PrecioNuevo, FechaCambio, EmpleadoID, Motivo)
VALUES 
(1, 149.00, 159.00, '2023-05-15', 1, 'Incremento por aumento de costo'),
(3, 1499.00, 1599.00, '2023-05-15', 1, 'Incremento por aumento de costo'),
(4, 189.00, 199.00, '2023-05-15', 1, 'Incremento por aumento de costo');

-- Actualizar precios de productos
UPDATE Productos SET PrecioVentaBase = 159.00, FechaModificacion = '2023-05-15' WHERE ProductoID = 1;
UPDATE Productos SET PrecioVentaBase = 1599.00, FechaModificacion = '2023-05-15' WHERE ProductoID = 3;
UPDATE Productos SET PrecioVentaBase = 199.00, FechaModificacion = '2023-05-15' WHERE ProductoID = 4;

-- Insertar registros en tabla LogAccionesUsuario
INSERT INTO LogAccionesUsuario (EmpleadoID, FechaHora, Accion, TablaAfectada, RegistroID, Detalles, DireccionIP)
VALUES 
(1, '2023-05-15 10:30:00', 'Actualización', 'Productos', 1, 'Actualización de precio de producto', '192.168.1.10'),
(1, '2023-05-15 10:31:00', 'Actualización', 'Productos', 3, 'Actualización de precio de producto', '192.168.1.10'),
(1, '2023-05-15 10:32:00', 'Actualización', 'Productos', 4, 'Actualización de precio de producto', '192.168.1.10'),
(3, '2023-05-20 11:15:00', 'Inserción', 'Ventas', 1, 'Registro de nueva venta', '192.168.1.15'),
(3, '2023-05-21 09:45:00', 'Inserción', 'Ventas', 2, 'Registro de nueva venta', '192.168.1.15'),
(4, '2023-05-25 14:20:00', 'Inserción', 'AjustesInventario', 1, 'Registro de ajuste de inventario', '192.168.1.12'),
(3, '2023-05-22 13:10:00', 'Inserción', 'DevolucionesClientes', 1, 'Registro de devolución de cliente', '192.168.1.15');

-- Insertar más proveedores
INSERT INTO Personas (TipoDocumentoID, NumeroDocumento, P_Nombre, S_Nombre, RazonSocial, Direccion, Ciudad, Departamento, Pais, Telefono_P, Email, Activo)
VALUES 
(4, '9999999999', NULL, NULL, 'Materiales Eléctricos del Valle', 'Av. Electricistas #456', 'Toluca', 'Estado de México', 'México', '7226666664', 'contacto@materialeselectricos.com', 1),
(4, '1010101010', NULL, NULL, 'Plomería y Accesorios SA', 'Calle Hidalgo #789', 'Metepec', 'Estado de México', 'México', '7226666665', 'ventas@plomeriayaccesorios.com', 1);

INSERT INTO Proveedores (PersonaID, TipoProveedor, SitioWeb, DiasEntrega, DiasCredito, Calificacion, Observaciones)
VALUES 
(14, 'Electricidad', 'www.materialeselectricos.com', 2, 30, 4, 'Proveedor especializado en material eléctrico'),
(15, 'Plomería', 'www.plomeriayaccesorios.com', 3, 15, 3, 'Precios competitivos en materiales de plomería');

-- Insertar más clientes
INSERT INTO Personas (TipoDocumentoID, NumeroDocumento, P_Nombre, S_Nombre, RazonSocial, Direccion, Ciudad, Departamento, Pais, Telefono_P, Email, Activo)
VALUES 
(1, '6767676767', 'Arturo', 'González', NULL, 'Calle Pino Suárez #34', 'Toluca', 'Estado de México', 'México', '7227777776', 'arturo.gonzalez@gmail.com', 1),
(4, '7878787878', NULL, NULL, 'Acabados Residenciales SA de CV', 'Blvd. Tollocan #567', 'Metepec', 'Estado de México', 'México', '7227777777', 'compras@acabadosresidenciales.com', 1);

INSERT INTO Clientes (PersonaID, CategoriaCliente, DiasCredito, ClasificacionCrediticia, Observaciones)
VALUES 
(16, 'Regular', 0, 'A', 'Cliente nuevo'),
(17, 'Mayorista', 30, 'A', 'Empresa de acabados para construcción');

-- Insertar más productos
INSERT INTO Productos (CodigoSKU, CodigoBarras, Nombre, Descripcion, CategoriaID, MarcaID, UnidadMedidaID, ImpuestoID, PrecioCompraPromedio, PrecioVentaBase, PuntoReorden, StockMinimo, StockMaximo, Peso, Activo)
VALUES 
('PL002', '7501234567900', 'Llave mezcl. para lavabo', 'Llave monomando para baño', 4, 4, 1, 1, 320.00, 549.00, 3, 2, 25, 1.0, 1),
('EL002', '7501234567901', 'Clavija polarizada', 'Clavija de uso rudo', 5, 3, 1, 1, 12.00, 25.90, 10, 5, 100, 0.1, 1),
('PI002', '7501234567902', 'Rodillo 9"', 'Rodillo para pintar', 6, 7, 1, 1, 35.00, 59.90, 5, 3, 50, 0.3, 1),
('MC002', '7501234567903', 'Varilla 3/8" x 12m', 'Varilla corrugada para construcción', 3, 8, 1, 1, 110.00, 189.00, 10, 5, 100, 4.5, 1),
('HM003', '7501234567904', 'Nivel de burbuja 24"', 'Nivel profesional', 1, 2, 1, 1, 95.00, 169.00, 3, 2, 30, 0.6, 1);

-- Insertar inventario para nuevos productos
INSERT INTO Inventario (ProductoID, AlmacenID, ZonaID, Existencia, ExistenciaMinima, UbicacionEspecifica, UltimoPrecioCompra, FechaUltimaEntrada)
VALUES 
(11, 1, 3, 6, 2, 'Estante C-3', 320.00, '2023-05-05'),
(12, 1, 3, 25, 5, 'Estante C-4', 12.00, '2023-05-05'),
(13, 1, 4, 12, 3, 'Estante D-2', 35.00, '2023-05-05'),
(14, 2, 5, 30, 5, 'Pallet B-3', 110.00, '2023-05-05'),
(15, 1, 1, 8, 2, 'Estante A-6', 95.00, '2023-05-05');

-- Insertar más ventas
INSERT INTO Ventas (NumeroFactura, SerieFactura, ClienteID, EmpleadoID, FechaVenta, FormaPagoID, EstadoID, AlmacenID, SubtotalSinImpuesto, DescuentoTotal, TotalImpuestos, Total, Observaciones)
VALUES 
('000003', 'A', 6, 3, '2023-05-23', 1, 4, 1, 1099.90, 0.00, 175.98, 1275.88, 'Venta de materiales para remodelación'),
('000004', 'A', 5, 3, '2023-05-24', 5, 4, 1, 3500.00, 175.00, 532.00, 3857.00, 'Venta a crédito para empresa');

-- Insertar detalles de ventas
INSERT INTO DetalleVenta (VentaID, ProductoID, Cantidad, PrecioUnitario, PorcentajeDescuento, ImpuestoID, SubtotalSinImpuesto, TotalDescuento, TotalImpuesto, TotalLinea)
VALUES 
(3, 11, 1, 549.00, 0, 1, 549.00, 0.00, 87.84, 636.84),
(3, 13, 2, 59.90, 0, 1, 119.80, 0.00, 19.17, 138.97),
(3, 15, 2, 169.00, 0, 1, 338.00, 0.00, 54.08, 392.08),
(4, 14, 10, 189.00, 5, 1, 1890.00, 94.50, 287.28, 2082.78),
(4, 6, 100, 15.90, 5, 1, 1590.00, 79.50, 241.92, 1752.42);

-- Insertar movimientos de inventario para nuevas ventas
INSERT INTO MovimientosInventario (FechaMovimiento, TipoMovimientoID, ProductoID, AlmacenOrigenID, Cantidad, DocumentoReferenciaID, TipoDocumentoReferencia, EmpleadoID, Observaciones)
VALUES 
('2023-05-23', 2, 11, 1, 1, 3, 'Venta', 3, 'Salida por venta #000003-A'),
('2023-05-23', 2, 13, 1, 2, 3, 'Venta', 3, 'Salida por venta #000003-A'),
('2023-05-23', 2, 15, 1, 2, 3, 'Venta', 3, 'Salida por venta #000003-A'),
('2023-05-24', 2, 14, 2, 10, 4, 'Venta', 3, 'Salida por venta #000004-A'),
('2023-05-24', 2, 6, 1, 100, 4, 'Venta', 3, 'Salida por venta #000004-A');

-- Actualizar inventario después de ventas
UPDATE Inventario SET Existencia = 5 WHERE ProductoID = 11 AND AlmacenID = 1;
UPDATE Inventario SET Existencia = 10 WHERE ProductoID = 13 AND AlmacenID = 1;
UPDATE Inventario SET Existencia = 6 WHERE ProductoID = 15 AND AlmacenID = 1;
UPDATE Inventario SET Existencia = 20 WHERE ProductoID = 14 AND AlmacenID = 2;
UPDATE Inventario SET Existencia = 100 WHERE ProductoID = 6 AND AlmacenID = 1;

-- Insertar pagos para nuevas ventas
INSERT INTO PagosVenta (VentaID, FormaPagoID, Monto, FechaPago, NumeroReferencia, EmpleadoRegistraID, Observaciones)
VALUES 
(3, 1, 1275.88, '2023-05-23', NULL, 3, 'Pago en efectivo'),
(4, 5, 3857.00, '2023-05-24', 'CRED-001', 3, 'Pago a crédito 30 días');

-- Insertar remisiones para nuevas ventas
INSERT INTO Remisiones (NumeroRemision, VentaID, FechaRemision, EmpleadoEntregaID, DireccionEntrega, EstadoID, Observaciones)
VALUES 
('REM-000003', 3, '2023-05-23', 5, 'Calle Pino Suárez #34, Toluca', 4, 'Entrega a domicilio'),
('REM-000004', 4, '2023-05-24', 5, 'Av. Las Torres #890, Toluca', 4, 'Entrega en oficinas del cliente');

-- Insertar detalles de remisiones para nuevas ventas
INSERT INTO DetalleRemision (RemisionID, DetalleVentaID, CantidadEntregada)
VALUES 
(3, 4, 1),
(3, 5, 2),
(3, 6, 2),
(4, 7, 10),
(4, 8, 100);

-- Insertar más cotizaciones
INSERT INTO Cotizaciones (NumeroCotizacion, ClienteID, EmpleadoID, FechaCotizacion, ValidaHasta, EstadoID, SubtotalSinImpuesto, TotalImpuestos, Total, VentaGeneradaID, Observaciones)
VALUES 
('COT-000003', 7, 3, '2023-05-23', '2023-06-23', 4, 1099.90, 175.98, 1275.88, 3, 'Cotización para remodelación'),
('COT-000004', 6, 3, '2023-05-26', '2023-06-26', 2, 8500.00, 1360.00, 9860.00, NULL, 'Cotización proyecto residencial');

-- Insertar detalles de cotizaciones
INSERT INTO DetalleCotizacion (CotizacionID, ProductoID, Cantidad, PrecioUnitario, PorcentajeDescuento, ImpuestoID, SubtotalSinImpuesto, TotalDescuento, TotalImpuesto, TotalLinea)
VALUES 
(3, 11, 1, 549.00, 0, 1, 549.00, 0.00, 87.84, 636.84),
(3, 13, 2, 59.90, 0, 1, 119.80, 0.00, 19.17, 138.97),
(3, 15, 2, 169.00, 0, 1, 338.00, 0.00, 54.08, 392.08),
(4, 3, 3, 1599.00, 0, 1, 4797.00, 0.00, 767.52, 5564.52),
(4, 9, 5, 599.00, 0, 1, 2995.00, 0.00, 479.20, 3474.20),
(4, 11, 2, 549.00, 0, 1, 1098.00, 0.00, 175.68, 1273.68);

-- Insertar más registros en LogAccionesUsuario
INSERT INTO LogAccionesUsuario (EmpleadoID, FechaHora, Accion, TablaAfectada, RegistroID, Detalles, DireccionIP)
VALUES 
(3, '2023-05-23 10:15:00', 'Inserción', 'Ventas', 3, 'Registro de nueva venta', '192.168.1.15'),
(3, '2023-05-24 13:30:00', 'Inserción', 'Ventas', 4, 'Registro de nueva venta', '192.168.1.15'),
(3, '2023-05-26 09:45:00', 'Inserción', 'Cotizaciones', 4, 'Registro de nueva cotización', '192.168.1.15');

-- Insertar más órdenes de compra
INSERT INTO OrdenesCompra (NumeroOrden, ProveedorID, FechEmision, FechaEntregaEsperada, EmpleadoID, EstadoID, SubtotalSinImpuesto, TotalImpuestos, Total, Observaciones)
VALUES 
('OC-000003', 3, '2023-05-25', '2023-05-30', 1, 3, 10000.00, 1600.00, 11600.00, 'Pedido de pinturas y accesorios'),
('OC-000004', 4, '2023-05-27', '2023-06-01', 1, 2, 8000.00, 1280.00, 9280.00, 'Pedido de materiales eléctricos');

-- Insertar detalles de órdenes de compra
INSERT INTO DetalleCompra (OrdenCompraID, ProductoID, Cantidad, PrecioUnitario, PorcentajeDescuento, ImpuestoID, SubtotalImpuesto, TotalImpuesto, TotalLinea)
VALUES 
(3, 7, 10, 650.00, 0, 1, 6500.00, 1040.00, 7540.00),
(3, 13, 100, 35.00, 0, 1, 3500.00, 560.00, 4060.00),
(4, 6, 500, 8.50, 0, 1, 4250.00, 680.00, 4930.00),
(4, 12, 250, 12.00, 0, 1, 3000.00, 480.00, 3480.00);