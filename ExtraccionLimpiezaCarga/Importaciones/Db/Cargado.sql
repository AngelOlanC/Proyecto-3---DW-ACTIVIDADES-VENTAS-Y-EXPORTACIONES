create schema VistaMaterializada

select * from VistaMaterializada.Importaciones
drop table VistaMaterializada.Importaciones

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