create function GetNombreMes(@mes int)
returns nvarchar(20)
as begin
  return (select dateName(month, dateAdd(month, @mes, -1)))
end
go

create function GetNmestre(@N int, @mes int)
returns nvarchar(40)
as begin
  declare @numero int = (@mes - 1) / @N
  declare @mesInicio nvarchar(20) = dbo.GetNombreMes(@numero * @N + 1) 
  declare @mesFin nvarchar(20) = dbo.GetNombreMes((@numero + 1) * @N)
  return @mesInicio + '-' + @mesFin  
end
go

create function GetNombreTemporada(@mes int, @dia int)
returns nvarchar(40)
as begin
	if (@mes in (1, 2) or (@mes = 12 and @dia >= 21) or (@mes = 3 and @dia < 20))
		return 'Invierno'
	if (@mes in (4, 5) or (@mes = 3 and @dia >= 21) or (@mes = 6 and @dia < 21))
		return 'Primavera'
	if (@mes in (7, 8) or (@mes = 6 and @dia >= 21) or (@mes = 9 and @dia < 23))
		return 'Verano'
	return 'Otoño'
end
go

create function dbo.EsFinDeSemana(@fecha date)
returns nvarchar(40)
as begin
	if (datepart(weekday, @fecha) in (1, 7))
		return 'Es fin de semana'
	return 'No es fin de semana'
end
go

alter function dbo.EsAñoBisiesto(@año int)
returns nvarchar(40)
as begin
	if ((@año % 4 = 0 and @año % 100 != 0) or
		(@año % 100 = 0 and @año % 400 = 0))
		return 'Es año bisiesto'
	return 'No es año bisiesto'
end
go

create procedure sp_limpiarTodo
as begin
	drop table Proyecto.VistaMaterializada.Importaciones
	drop table Proyecto.VistaMaterializada.Ventas
	drop table Proyecto.Dimension.Estado
	drop table Proyecto.Dimension.MedioDeTransporte
	drop table Proyecto.Dimension.PaisDeOrigen
	drop table Proyecto.Dimension.fecha
end