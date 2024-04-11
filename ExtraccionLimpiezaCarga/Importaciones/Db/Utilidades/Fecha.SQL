create function GetNombreMes(@mes int)
returns nvarchar(20)
as begin
  return select dateName(month, dateAdd(month, @mes, -1))
end

create function GetN-Mestre(@N int, @mes int)
returns nvarchar(40)
as begin
  declare @numero int = (@mes - 1) / N
  declare @mesInicio nvarchar(20) = GetNombreMes(@numero * @N + 1) 
  declare @mesFin nvarchar(20) = GetNombreMes(@numero * (@N + 1))
  return @mesInicio + '-' + @mesFin  
end

create proc sp_AgregarFecha @fecha date
as begin
  insert into 
    Fecha (fecha, año, mes, dia, semana, diaSemana, bimestre, trimestre, cuatrimestre, semestre) 
    values(@fecha, year(@fecha), datename(month, @fecha), day(@fecha), week(@fecha), 
          weekday(@fecha), GetN-Mestre(2, month(@fecha)), GetN-Mestre(3, month(@fecha)), 
          GetN-Mestre(4, month(@fecha)), GetN-Mestre(6, month(@fecha)))  
end

create proc sp_AgregarRangoDeFechas @fechaInicio date, @fechaFin date
as
begin
  while @fechaInicio < @fechaFin
  begin
    exec sp_AgregarFecha @fechaInicio
    @fechaInicio = dateAdd(day, 1, @fechaInicio)
  end
end

create proc sp_AgregarMedioDeTransporte 
as
begin
end --??

create proc sp_AgregarMedioDeTransporte 
as
begin
end --??

create proc sp_PrepararDW
as
begin
end