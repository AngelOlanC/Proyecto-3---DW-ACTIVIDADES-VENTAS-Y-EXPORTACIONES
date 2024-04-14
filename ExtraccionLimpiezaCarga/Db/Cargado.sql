create schema VistaMaterializada

create proc sp_CargarVMImportaciones
as begin
	select paisDeOrigen, medioDeTransporte, fecha, importe = SUM(precio), unidades = COUNT(*) 
	into VistaMaterializada.Importaciones 
	from OLTP.Importaciones
	group by paisDeOrigen, medioDeTransporte, fecha

	alter table VistaMaterializada.Importaciones
	add constraint PK_VMImportaciones primary key(PaisDeOrigen, MedioDeTransporte, Fecha)
	
	alter table VistaMaterializada.Importaciones
	add constraint FK_VMImportaciones_PaisDeOrigen foreign key(paisDeOrigen) references Dimension.paisDeOrigen(nombre)
	alter table VistaMaterializada.Importaciones
	add constraint FK_VMImportaciones_MedioTransporte  foreign key(medioDeTransporte) references Dimension.medioDeTransporte(nombre)
	alter table VistaMaterializada.Importaciones
	add constraint FK_VMImportaciones_Fecha  foreign key(Fecha) references Dimension.fecha(fecha)
end
go
exec sp_CargarVMImportaciones
go

create proc sp_CargarVMVentas
as begin
	select TH.estado, TD.producto, fecha, importe = SUM(precio * unidades), mayorCantidadUnidadesVendidas = max(unidades) 
	into VistaMaterializada.Ventas 
	from OLTP.TicketsH TH
	inner join OLTP.TicketsD TD on TH.ticket = TD.ticket
	group by TH.estado, TD.producto, TH.fecha

	alter table VistaMaterializada.Ventas
	add constraint PK_VMVentas primary key(estado, producto, Fecha)
	
	alter table VistaMaterializada.Ventas
	add constraint FK_VMVentas_Estado foreign key(Estado) references Dimension.Estado(id)
	alter table VistaMaterializada.Ventas
	add constraint FK_VMVentas_Producto  foreign key(Producto) references Dimension.Producto(id)
	alter table VistaMaterializada.Ventas
	add constraint FK_VMVentas_Fecha  foreign key(Fecha) references Dimension.fecha(fecha)
end
go
exec sp_CargarVMVentas
go