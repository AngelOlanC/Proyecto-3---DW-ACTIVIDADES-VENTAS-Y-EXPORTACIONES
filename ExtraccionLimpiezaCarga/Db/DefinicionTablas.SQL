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
  ambiente nvarchar(40) not null,
  costoDeVida nvarchar(40) not null, -- [Costo de vida alto] [Costo de vida normal] [Costo de vida bajo]
  sistemaPolitico nvarchar(40) not null,
  TLC nvarchar(40) not null,
  idiomaOficial nvarchar(40) not null,
  zonaHoraria nvarchar(40) not null
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
create table Dimension.Producto(
  id int primary key not null, -- 1-1000
  nombre nvarchar(80) not null,
  tipo nvarchar(80) not null,
  marca nvarchar(80) not null,
  proveedor nvarchar(80) not null,
  esPerecedero nvarchar(80) not null, -- [Es un producto perecedero] [Es un producto no perecedero]
  edadObjetivo nvarchar(80) not null, -- [Producto para bebes] [Producto para infantes] [Producto para adolescentes] [Producto para jovenes] [Producto para adultos] [Producto para personas mayores]
  esNacional nvarchar(80) not null, -- [Es un producto nacional] [Es un producto extranjero]
  añoIngreso nvarchar(80) not null, -- [Producto ingresado en 2020] [Producto ingresado en 2021] [Producto ingresado en 2022] [Ingresado en 2023]
  peso nvarchar(80) not null, -- [Producto de menos de 1kg] [Producto de 1-5 kg] [Producto de 10-20 kg] [Producto de 20-50 kg] [Producto de mas de 50 kg]
  esFragil nvarchar(80) not null -- [Es un producto fragil] [No es un producto fragil]
)
go

create table Dimension.Estado(
  id int primary key not null, -- [1] [2] ...
  nombre nvarchar(40) not null,
  zona nvarchar(40) not null, -- [Zona norte] [Zona centro] [Zona sur]
  clima nvarchar(40) not null, -- []
  ambiente nvarchar(40) not null, -- []
  giroPrincipal nvarchar(40) not null, -- [Ganaderia, ]
  culturaDominante nvarchar(40) not null, -- [Cultura cristiana dominante] ...
  musicaDominante nvarchar(40) not null, -- [Se escucha banda] [Se escuchan corridos] ...
  criminalidad nvarchar(40) not null, -- [Estado con criminalidad baja] [Estado con criminalidad alta]
)
go