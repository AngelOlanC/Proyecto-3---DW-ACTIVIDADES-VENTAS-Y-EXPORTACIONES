-- ESTRUCTURA GENERAL, MEJORAR
create database Importaciones

use Importaciones

create schema OLTP

-- ESTADO,CIUDAD,MARCA,MODELO,AÑO,FECHA,PRECIO
create table OLTP.Importaciones(
  ID int identity primary key not null,
  Estado nvarchar(20) not null,
  Ciudad nvarchar(20) not null,
  Marca nvarchar(20) not null,
  Modelo nvarchar(20) not null,
  Año int not null,
  Fecha date not null,
  Precio decimal(10, 2) not null,
  MedioDeTransporte nvarchar(20) not null,
  PaisDeOrigen nvarchar(20) not null
)

create table OLTP.TicketsH(

)

create table OLTP.TicketsD(

)

--------------------------------- DIMENSIONES USADAS EN LAS VM

create schema Dimension

create table Dimension.PaisDeOrigen(

)

create table Dimension.MedioDeTransporte(

)

create table Dimension.Fecha(
  fecha date primary key not null,
  año int not null,
  mes nvarchar('20') not null,
  dia int not null,
  semana int not null,
  diaSemana nvarchar('20') not null,
  bimestre nvarchar('20') not null,
  trimestre nvarchar('20') not null,
  cuatrimestre nvarchar('20') not null,
  semestre nvarchar('20') not null,
  esDiaFestivo boolean not null
)


create table Dimension.Importe(

)

create table Dimension.Unidades(

)

create table Dimension.MayorCantidadUnidadesVendidas(

)

create table Dimension.PorDefinir1(

)

create table Dimension.PorDefinir2(

)

----------------------------- VISTAS MATERIALIZADAS

create schema VistasMaterializadas

create table VistasMaterializadas.Importaciones(

)

create table VistasMaterializadas.Ventas(

)

----------------------------- TRIGGERS Y PROCEDIMIENTOS ALMACENADOS

create trigger TR_Importaciones
after insert, update 
on OLTP.Importaciones as
begin
  -- llamar a los SP de las dimensiones de Importaciones
end

create trigger TR_TicketsD
after insert, update 
on OLTP.TicketsD as
begin
  -- llamar a los SP de las dimensiones de Ventas
end

create proc sp_GetNombreMes @mes int, @nombreMes nvarchar('20') output
as begin
  set @nombreMes = case 
                        when mes = 1 then "Enero"
                        when mes = 2 then "Febrero"
                        when mes = 3 then "Marzo"
                        when mes = 4 then "Abril"
                        when mes = 5 then "Mayo"
                        when mes = 6 then "Junio"
                        when mes = 7 then "Julio"
                        when mes = 8 then "Agosto"
                        when mes = 9 then "Septiembre"
                        when mes = 10 then "Octubre"
                        when mes = 11 then "Noviembre"
                        when mes = 12 then "Diciembre"
                        else '?'
                    end
end

create proc sp_GetNombreDiaSemana @dia int, @nombre nvarchar('20') output
as begin
  set @nombre = case 
                        when dia = 1 then "Lunes"
                        when dia = 2 then "Martes"
                        when dia = 3 then "Miercoles"
                        when dia = 4 then "Jueves"
                        when dia = 5 then "Viernes"
                        when dia = 6 then "Sabado"
                        when dia = 7 then "Domingo"
                        else '?'
                    end
end

create proc sp_AgregarFecha @fecha date
as begin

end

create proc sp_AgregarTodasLasFechas
as
begin
  declare @fecha as date = '2020-01-01'
  declare @fechaFueraDeRango as date = '2023-01-01'
  
  while @fecha < @fechaFueraDeRango
  begin
    exec sp_AgregarFecha @fecha
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