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
  nombre nvarchar(20) not null primary key,
  continente nvarchar(20) not null,
  poblacion nvarchar(20) not null, -- MUY_POBLADO POBLADO_NORMAL POCO_POBLADO
)

create table Dimension.MedioDeTransporte(
  nombre nvarchar(20) not null primary key,
  tipo nvarchar(20) not null, -- AEREO, MARITIMO, TERRESTRE
  seguridad nvarchar(20) not null, -- ALTA MEDIA BAJA
  costo nvarchar(20) not null, -- COSTOSO NORMAL ECONOMICO
  duracionTraslado nvarchar(20) not null -- LARGO MEDIO CHICO
)

create table Dimension.Fecha(
  fecha date primary key not null,
  año int not null,
  mes nvarchar(20) not null,
  dia int not null,
  semana int not null,
  diaSemana nvarchar(20) not null,
  bimestre nvarchar(20) not null,
  trimestre nvarchar(20) not null,
  cuatrimestre nvarchar(20) not null,
  semestre nvarchar(20) not null
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

-- TABLA AUXILIAR

create schema Auxiliar

create table Auxiliar.Cuenta2022(
  numero int
)
insert Auxiliar.Cuenta2022 values(0)