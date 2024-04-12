create database Importaciones
go

use Importaciones
go

create schema OLTP
go

create table OLTP.Importaciones(
  ID int identity primary key not null,
  Estado nvarchar(40) not null,
  Ciudad nvarchar(40) not null,
  Marca nvarchar(40) not null,
  Modelo nvarchar(40) not null,
  Año int not null,
  Fecha date not null,
  Precio numeric(16, 2) not null,
  MedioDeTransporte nvarchar(40) not null,
  PaisDeOrigen nvarchar(40) not null
)
go
select * from OLTP.Importaciones
create table OLTP.TicketsH(

)
go
create table OLTP.TicketsD(

)
go
--------------------------------- DIMENSIONES USADAS EN LAS VM
create schema Dimension
go
create table Dimension.PaisDeOrigen(
  nombre nvarchar(40) not null primary key,
  continente nvarchar(40) not null,
  poblacion nvarchar(40) not null, -- [MUY POBLADO] [POBLADO NORMAL] [POCO POBLADO]
  cultura nvarchar(40) not null -- [CRISTIANISMO] [CATOLICISMO] [JUDISMO] [ADVENTISMO] [ETC]
)
go
create table Dimension.MedioDeTransporte(
  nombre nvarchar(40) not null primary key,
  tipo nvarchar(40) not null, -- AEREO, MARITIMO, TERRESTRE
  seguridad nvarchar(40) not null, -- ALTA MEDIA BAJA
  costo nvarchar(40) not null, -- COSTOSO NORMAL ECONOMICO
  duracionTraslado nvarchar(40) not null -- LARGO MEDIO CHICO
  impactoAmbiental nvarchar(40) not null -- [SIN IMPACTO AMBIENTAL] [CON IMPACTO AMBIENTAL]
)
go

create table Dimension.Fecha (
  fecha date primary key not null,
  año int not null,
  nombreMes nvarchar(40) not null,
  diaMes int not null,
  diaAño int not null,
  semanaAño int not null,
  semanaMes int not null,
  nombreDiaSemana nvarchar(40) not null,
  mesesBimestre nvarchar(40) not null,
  mesesTrimestre nvarchar(40) not null,
  mesesCuatrimestre nvarchar(40) not null,
  mesesSemestre nvarchar(40) not null,
  nombreTemporada nvarchar(40) not null,
  esFinDeSemana nvarchar(20) not null,
  estaEnAñoBisiesto nvarchar(20) not null
)
go
create table Dimension.Importe(

)
go
create table Dimension.Unidades(

)
go
create table Dimension.MayorCantidadUnidadesVendidas(

)
go
create table Dimension.PorDefinir1(

)
go
create table Dimension.PorDefinir2(

)
go
----------------------------- VISTAS MATERIALIZADAS

create schema VistasMaterializadas
go
create table VistasMaterializadas.Importaciones(

)
go
create table VistasMaterializadas.Ventas(

)
go
-- TABLA AUXILIAR

create schema Auxiliar
go
create table Auxiliar.Cuenta2022(
  numero int
)
go
insert Auxiliar.Cuenta2022 values(0)