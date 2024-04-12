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
go

create table OLTP.TicketsH(
	ticket int primary key not null,
	fecha date not null,
	estado int not null,
	ciudad int not null,
	tienda int not null,
	empleado int not null
)
go

create table OLTP.TicketsD(
	ticket int not null foreign key references OLTP.TicketsH(ticket),
	producto int not null,
	unidades int not null,
	precio decimal(16, 2) not null
	primary key(ticket, producto)
)
go
--------------------------------- DIMENSIONES USADAS EN LAS VM
create schema Dimension
go
create table Dimension.PaisDeOrigen(
  nombre nvarchar(40) not null primary key,
  continente nvarchar(40) not null, -- [Asia, Europa, America, Africa, Oceania]
  divisa nvarchar(40) not null, --
  densidadDePoblacion nvarchar(40) not null, -- [Pais muy poblado] [Pais con poblacion normal] [Pais poco poblado]
  cultura nvarchar(40) not null, -- [Pais cristiano] [Pais catolico] [Pais judio] [Pais adventista] u cualquier otro
  clima nvarchar(40) not null,
  costoDeVida nvarchar(40) not null -- [Costo de vida alto] [Costo de vida normal] [Costo de vida bajo]
)
go
create table Dimension.MedioDeTransporte(
  nombre nvarchar(40) not null primary key, -- [Carretera, Ferroviario, Avion, Barco]
  tipo nvarchar(40) not null, -- [Transporte terrestre] [Transporte aereo] [Transporte naval]
  seguridad nvarchar(40) not null, -- [Trasporte seguro] [Transporte con seguridad promedio] [Transporte poco seguro]
  costo nvarchar(40) not null, -- [Costo de transporte caro] [Costo de transporte normal] [Costo de transporte economico]
  duracionTraslado nvarchar(40) not null, -- [Transporte muy lento] [Traslado lento] [Traslado normal] [Traslado rapido]
  impactoAmbiental nvarchar(40) not null, -- [Traslado con impacto ambiental] [Transporte sin impacto ambiental]
  capacidadCarga nvarchar(40) not null, -- [Mucha capacidad de carga] [Capacidad de carga normal] [Poca capacidad de carga]
  tipoCombustible nvarchar(40) not null, -- [Gasolina] [Diesel] [Gas natural] [Electricidad] [Combustible de aviacion]
  seguimientoEnvios nvarchar(40) not null -- [Seguimiento alto] [Seguimiento limitado] [Sin seguimiento]
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

create table Dimension.PorDefinir1(

)
go

create table Dimension.PorDefinir2(
)
go

--------------------------------- TABLA AUXILIAR
create schema Auxiliar
go
create table Auxiliar.Cuenta2022(
  numero int
)
go
insert Auxiliar.Cuenta2022 values(0)