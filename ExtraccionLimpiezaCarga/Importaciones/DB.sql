-- ESTRUCTURA GENERAL, MEJORAR
create database Importaciones

use Importaciones

create schema OLTP

-- ESTADO,CIUDAD,MARCA,MODELO,AÑO,FECHA,PRECIO
create table OLTP.Importaciones(
  ID int identity,
  Estado nvarchar(20),
  Ciudad nvarchar(20),
  Marca nvarchar(20),
  Modelo nvarchar(20),
  Año int,
  Fecha date,
  Precio decimal(10, 2),
  MedioDeTransporte nvarchar(20),
  PaisDeOrigen nvarchar(20)
)

create table OLTP.TicketsH(

)

create table OLTP.TicketsD(

)

---------------------------------

create schema Dimension

create table Dimension.PaisDeOrigen(

)

create table Dimension.MedioDeTransporte(

)

create table Dimension.Fecha(

)


create table Dimension.Importe(

)

create table Dimension.Unidades(

)

create table Dimension.MayorCantidadUnidadesVendidas(

)

create table Dimension.PorDefinir2(

)

create table Dimension.PorDefinir2(

)

-----------------------------
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

create proc sp_AgregarFecha @fecha date
as 
begin
end

create proc sp_AgregarMedioDeTransporte 
as
begin
end --??

create proc sp_AgregarMedioDeTransporte 
as
begin
end --??

---------------------------------

create schema Actividades

create table Actividades.Importaciones(

)

create table Actividades.Ventas(

)