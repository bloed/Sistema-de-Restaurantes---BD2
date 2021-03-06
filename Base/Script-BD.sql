USE [master]
GO
/****** Object:  Database [RESTAURANTES]    Script Date: 11/16/2015 11:25:18 PM ******/
CREATE DATABASE [RESTAURANTES]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'Sistemas de Restaurantes', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL12.MSSQLSERVER\MSSQL\DATA\Sistemas de Restaurantes.mdf' , SIZE = 7168KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'Sistemas de Restaurantes_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL12.MSSQLSERVER\MSSQL\DATA\Sistemas de Restaurantes_log.ldf' , SIZE = 8384KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [RESTAURANTES] SET COMPATIBILITY_LEVEL = 120
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [RESTAURANTES].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [RESTAURANTES] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [RESTAURANTES] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [RESTAURANTES] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [RESTAURANTES] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [RESTAURANTES] SET ARITHABORT OFF 
GO
ALTER DATABASE [RESTAURANTES] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [RESTAURANTES] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [RESTAURANTES] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [RESTAURANTES] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [RESTAURANTES] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [RESTAURANTES] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [RESTAURANTES] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [RESTAURANTES] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [RESTAURANTES] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [RESTAURANTES] SET  DISABLE_BROKER 
GO
ALTER DATABASE [RESTAURANTES] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [RESTAURANTES] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [RESTAURANTES] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [RESTAURANTES] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [RESTAURANTES] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [RESTAURANTES] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [RESTAURANTES] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [RESTAURANTES] SET RECOVERY FULL 
GO
ALTER DATABASE [RESTAURANTES] SET  MULTI_USER 
GO
ALTER DATABASE [RESTAURANTES] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [RESTAURANTES] SET DB_CHAINING OFF 
GO
ALTER DATABASE [RESTAURANTES] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [RESTAURANTES] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
ALTER DATABASE [RESTAURANTES] SET DELAYED_DURABILITY = DISABLED 
GO
USE [RESTAURANTES]
GO
/****** Object:  DatabaseRole [rolCliente]    Script Date: 11/16/2015 11:25:18 PM ******/
CREATE ROLE [rolCliente]
GO
/****** Object:  DatabaseRole [rolAdministrador]    Script Date: 11/16/2015 11:25:18 PM ******/
CREATE ROLE [rolAdministrador]
GO
/****** Object:  UserDefinedFunction [dbo].[verifyPlatillo]    Script Date: 11/16/2015 11:25:18 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[verifyPlatillo]
(@platillo VARCHAR(25), @categoria VARCHAR(25))
RETURNS INT
	--verifica que de un platillo tenga todos sus ingredientes
	
AS
BEGIN
	
	

    DECLARE @ingredienteActual VARCHAR(25) = ''
	DECLARE cursorP CURSOR FOR Select nombreIngrediente FROM IngredientesPlatillos WHERE nombrePlatillo = @platillo
	DECLARE @cantidad INT = 0
	OPEN cursorP

	FETCH NEXT FROM cursorP INTO @ingredienteActual

	WHILE @@FETCH_STATUS = 0
		BEGIN
			IF EXISTS(SELECT 'True' 
							FROM Ingredientes i, IngredientesCategorias ic,IngredientesPlatillos ip
								WHERE i.nombre = ic.nombreIngrediente	
								AND ic.cantidad >=1
								AND ic.nombreCategoria = @categoria
								AND ip.nombreIngrediente = i.nombre AND ip.nombrePlatillo =@platillo
								AND i.nombre = @ingredienteActual)
				
								BEGIN
									FETCH NEXT FROM cursorP INTO @ingredienteActual
								END
			ELSE
				BEGIN
					RETURN 0-- no es valido
				END
		END

	CLOSE cursorP
	DEALLOCATE cursorP
	RETURN 1--es valido
END

GO
/****** Object:  Table [dbo].[Administradores]    Script Date: 11/16/2015 11:25:18 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Administradores](
	[nombre] [varchar](25) NOT NULL,
	[password] [varchar](25) NULL,
 CONSTRAINT [PK_Administradores] PRIMARY KEY CLUSTERED 
(
	[nombre] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[apellidos]    Script Date: 11/16/2015 11:25:18 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[apellidos](
	[apellido] [varchar](25) NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Avenidas]    Script Date: 11/16/2015 11:25:18 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Avenidas](
	[nombre] [varchar](25) NOT NULL,
	[figura] [geometry] NOT NULL,
	[idBarrio] [int] NOT NULL,
 CONSTRAINT [PK_Avenidas] PRIMARY KEY CLUSTERED 
(
	[nombre] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Barrios]    Script Date: 11/16/2015 11:25:18 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Barrios](
	[id] [int] NOT NULL,
	[nombre] [varchar](50) NULL,
 CONSTRAINT [PK_Barrios] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[BitacoraAdministradores]    Script Date: 11/16/2015 11:25:18 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[BitacoraAdministradores](
	[id] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[nombreAdministrador] [varchar](25) NOT NULL,
	[descripcion] [varchar](100) NOT NULL,
	[fecha] [datetime] NOT NULL,
	[restaurante] [varchar](25) NOT NULL,
 CONSTRAINT [PK_BitacoraAdministradores] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[CallesAvenidas]    Script Date: 11/16/2015 11:25:18 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[CallesAvenidas](
	[nombre] [varchar](25) NOT NULL,
	[figura] [geometry] NOT NULL,
	[idBarrio] [int] NOT NULL,
 CONSTRAINT [PK_Calles] PRIMARY KEY CLUSTERED 
(
	[nombre] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[CategoriasIngredientes]    Script Date: 11/16/2015 11:25:18 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[CategoriasIngredientes](
	[nombre] [varchar](25) NOT NULL,
 CONSTRAINT [PK_CategoriasIngredientes] PRIMARY KEY CLUSTERED 
(
	[nombre] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[CategoriasRestaurantes]    Script Date: 11/16/2015 11:25:18 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[CategoriasRestaurantes](
	[nombre] [varchar](25) NOT NULL,
 CONSTRAINT [PK_CategoriasRestaurantes] PRIMARY KEY CLUSTERED 
(
	[nombre] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Clientes]    Script Date: 11/16/2015 11:25:18 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Clientes](
	[cedula] [int] NOT NULL,
	[nombre] [varchar](50) NOT NULL,
	[numeroTelefonico] [int] NOT NULL,
	[correoElectronico] [varchar](100) NOT NULL,
	[password] [varchar](25) NOT NULL,
	[descuentoActual] [datetime] NULL,
 CONSTRAINT [PK_Clientes_1] PRIMARY KEY CLUSTERED 
(
	[correoElectronico] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Compras]    Script Date: 11/16/2015 11:25:18 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Compras](
	[id] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[correoCliente] [varchar](100) NOT NULL,
	[fecha] [datetime] NOT NULL,
	[montoBase] [int] NOT NULL,
	[formaDePago] [varchar](25) NOT NULL,
	[montoTotal] [int] NOT NULL,
	[restaurante] [varchar](25) NOT NULL,
 CONSTRAINT [PK_Compras] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Cuadras]    Script Date: 11/16/2015 11:25:18 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Cuadras](
	[nombre] [varchar](25) NOT NULL,
	[figura] [geometry] NOT NULL,
	[restaurante] [varchar](25) NULL,
	[idBarrio] [int] NOT NULL,
 CONSTRAINT [PK_Cuadras] PRIMARY KEY CLUSTERED 
(
	[nombre] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[DescuentoClientes]    Script Date: 11/16/2015 11:25:18 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[DescuentoClientes](
	[id] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[correoCliente] [varchar](100) NOT NULL,
	[fecha] [datetime] NOT NULL,
 CONSTRAINT [PK_DescuentoClientes] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Ingredientes]    Script Date: 11/16/2015 11:25:18 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Ingredientes](
	[nombre] [varchar](25) NOT NULL,
	[precio] [int] NOT NULL,
	[categoriaIngrediente] [varchar](25) NOT NULL,
	[imagen] [varchar](100) NOT NULL,
 CONSTRAINT [PK_Ingredientes_1] PRIMARY KEY CLUSTERED 
(
	[nombre] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[IngredientesCategorias]    Script Date: 11/16/2015 11:25:18 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[IngredientesCategorias](
	[nombreIngrediente] [varchar](25) NOT NULL,
	[nombreCategoria] [varchar](25) NOT NULL,
	[cantidad] [int] NOT NULL,
 CONSTRAINT [PK_IngredientesCategorias] PRIMARY KEY CLUSTERED 
(
	[nombreIngrediente] ASC,
	[nombreCategoria] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[IngredientesPlatillos]    Script Date: 11/16/2015 11:25:18 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[IngredientesPlatillos](
	[nombreIngrediente] [varchar](25) NOT NULL,
	[nombrePlatillo] [varchar](25) NOT NULL,
 CONSTRAINT [PK_IngredientesPlatillos] PRIMARY KEY CLUSTERED 
(
	[nombreIngrediente] ASC,
	[nombrePlatillo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[LineasCompras]    Script Date: 11/16/2015 11:25:18 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[LineasCompras](
	[idCompra] [int] NOT NULL,
	[nombrePlatillo] [varchar](25) NOT NULL,
	[id] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
 CONSTRAINT [PK_LineasCompras_1] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[nombres]    Script Date: 11/16/2015 11:25:18 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[nombres](
	[nombre] [varchar](25) NOT NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Platillos]    Script Date: 11/16/2015 11:25:18 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Platillos](
	[nombre] [varchar](25) NOT NULL,
	[nombreCategoria] [varchar](25) NOT NULL,
	[precio] [int] NOT NULL,
	[contador] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[activo] [bit] NOT NULL,
 CONSTRAINT [PK_Platillos] PRIMARY KEY CLUSTERED 
(
	[nombre] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Restaurantes]    Script Date: 11/16/2015 11:25:18 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Restaurantes](
	[nombre] [varchar](25) NOT NULL,
	[horarioAtencion] [varchar](100) NOT NULL,
	[numeroTelefonico] [int] NOT NULL,
	[direccion] [varchar](100) NOT NULL,
	[categoria] [varchar](25) NOT NULL,
 CONSTRAINT [PK_Restaurantes] PRIMARY KEY CLUSTERED 
(
	[nombre] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
ALTER TABLE [dbo].[Avenidas]  WITH CHECK ADD  CONSTRAINT [FK_Avenidas_Barrios] FOREIGN KEY([idBarrio])
REFERENCES [dbo].[Barrios] ([id])
GO
ALTER TABLE [dbo].[Avenidas] CHECK CONSTRAINT [FK_Avenidas_Barrios]
GO
ALTER TABLE [dbo].[BitacoraAdministradores]  WITH CHECK ADD  CONSTRAINT [FK_BitacoraAdministradores_Administradores] FOREIGN KEY([nombreAdministrador])
REFERENCES [dbo].[Administradores] ([nombre])
GO
ALTER TABLE [dbo].[BitacoraAdministradores] CHECK CONSTRAINT [FK_BitacoraAdministradores_Administradores]
GO
ALTER TABLE [dbo].[BitacoraAdministradores]  WITH CHECK ADD  CONSTRAINT [FK_BitacoraAdministradores_Restaurantes] FOREIGN KEY([restaurante])
REFERENCES [dbo].[Restaurantes] ([nombre])
GO
ALTER TABLE [dbo].[BitacoraAdministradores] CHECK CONSTRAINT [FK_BitacoraAdministradores_Restaurantes]
GO
ALTER TABLE [dbo].[CallesAvenidas]  WITH CHECK ADD  CONSTRAINT [FK_Calles_Barrios] FOREIGN KEY([idBarrio])
REFERENCES [dbo].[Barrios] ([id])
GO
ALTER TABLE [dbo].[CallesAvenidas] CHECK CONSTRAINT [FK_Calles_Barrios]
GO
ALTER TABLE [dbo].[Compras]  WITH CHECK ADD  CONSTRAINT [FK_Compras_Clientes1] FOREIGN KEY([correoCliente])
REFERENCES [dbo].[Clientes] ([correoElectronico])
GO
ALTER TABLE [dbo].[Compras] CHECK CONSTRAINT [FK_Compras_Clientes1]
GO
ALTER TABLE [dbo].[Compras]  WITH CHECK ADD  CONSTRAINT [FK_Compras_Restaurantes] FOREIGN KEY([restaurante])
REFERENCES [dbo].[Restaurantes] ([nombre])
GO
ALTER TABLE [dbo].[Compras] CHECK CONSTRAINT [FK_Compras_Restaurantes]
GO
ALTER TABLE [dbo].[Cuadras]  WITH CHECK ADD  CONSTRAINT [FK_Cuadras_Barrios] FOREIGN KEY([idBarrio])
REFERENCES [dbo].[Barrios] ([id])
GO
ALTER TABLE [dbo].[Cuadras] CHECK CONSTRAINT [FK_Cuadras_Barrios]
GO
ALTER TABLE [dbo].[Cuadras]  WITH CHECK ADD  CONSTRAINT [FK_Cuadras_Restaurantes] FOREIGN KEY([restaurante])
REFERENCES [dbo].[Restaurantes] ([nombre])
GO
ALTER TABLE [dbo].[Cuadras] CHECK CONSTRAINT [FK_Cuadras_Restaurantes]
GO
ALTER TABLE [dbo].[DescuentoClientes]  WITH CHECK ADD  CONSTRAINT [FK_DescuentoClientes_Clientes1] FOREIGN KEY([correoCliente])
REFERENCES [dbo].[Clientes] ([correoElectronico])
GO
ALTER TABLE [dbo].[DescuentoClientes] CHECK CONSTRAINT [FK_DescuentoClientes_Clientes1]
GO
ALTER TABLE [dbo].[Ingredientes]  WITH CHECK ADD  CONSTRAINT [FK_Ingredientes_CategoriasIngredientes] FOREIGN KEY([categoriaIngrediente])
REFERENCES [dbo].[CategoriasIngredientes] ([nombre])
GO
ALTER TABLE [dbo].[Ingredientes] CHECK CONSTRAINT [FK_Ingredientes_CategoriasIngredientes]
GO
ALTER TABLE [dbo].[IngredientesCategorias]  WITH CHECK ADD  CONSTRAINT [FK_IngredientesCategorias_CategoriasRestaurantes] FOREIGN KEY([nombreCategoria])
REFERENCES [dbo].[CategoriasRestaurantes] ([nombre])
GO
ALTER TABLE [dbo].[IngredientesCategorias] CHECK CONSTRAINT [FK_IngredientesCategorias_CategoriasRestaurantes]
GO
ALTER TABLE [dbo].[IngredientesCategorias]  WITH CHECK ADD  CONSTRAINT [FK_IngredientesCategorias_Ingredientes] FOREIGN KEY([nombreIngrediente])
REFERENCES [dbo].[Ingredientes] ([nombre])
GO
ALTER TABLE [dbo].[IngredientesCategorias] CHECK CONSTRAINT [FK_IngredientesCategorias_Ingredientes]
GO
ALTER TABLE [dbo].[IngredientesPlatillos]  WITH CHECK ADD  CONSTRAINT [FK_IngredientesPlatillos_Ingredientes1] FOREIGN KEY([nombreIngrediente])
REFERENCES [dbo].[Ingredientes] ([nombre])
GO
ALTER TABLE [dbo].[IngredientesPlatillos] CHECK CONSTRAINT [FK_IngredientesPlatillos_Ingredientes1]
GO
ALTER TABLE [dbo].[IngredientesPlatillos]  WITH CHECK ADD  CONSTRAINT [FK_IngredientesPlatillos_Platillos] FOREIGN KEY([nombrePlatillo])
REFERENCES [dbo].[Platillos] ([nombre])
GO
ALTER TABLE [dbo].[IngredientesPlatillos] CHECK CONSTRAINT [FK_IngredientesPlatillos_Platillos]
GO
ALTER TABLE [dbo].[LineasCompras]  WITH CHECK ADD  CONSTRAINT [FK_LineasCompras_Compras] FOREIGN KEY([idCompra])
REFERENCES [dbo].[Compras] ([id])
GO
ALTER TABLE [dbo].[LineasCompras] CHECK CONSTRAINT [FK_LineasCompras_Compras]
GO
ALTER TABLE [dbo].[LineasCompras]  WITH CHECK ADD  CONSTRAINT [FK_LineasCompras_Platillos] FOREIGN KEY([nombrePlatillo])
REFERENCES [dbo].[Platillos] ([nombre])
GO
ALTER TABLE [dbo].[LineasCompras] CHECK CONSTRAINT [FK_LineasCompras_Platillos]
GO
ALTER TABLE [dbo].[Platillos]  WITH CHECK ADD  CONSTRAINT [FK_Platillos_CategoriasRestaurantes] FOREIGN KEY([nombreCategoria])
REFERENCES [dbo].[CategoriasRestaurantes] ([nombre])
GO
ALTER TABLE [dbo].[Platillos] CHECK CONSTRAINT [FK_Platillos_CategoriasRestaurantes]
GO
ALTER TABLE [dbo].[Restaurantes]  WITH CHECK ADD  CONSTRAINT [FK_Restaurantes_CategoriasRestaurantes] FOREIGN KEY([categoria])
REFERENCES [dbo].[CategoriasRestaurantes] ([nombre])
GO
ALTER TABLE [dbo].[Restaurantes] CHECK CONSTRAINT [FK_Restaurantes_CategoriasRestaurantes]
GO
/****** Object:  StoredProcedure [dbo].[createAdministrador]    Script Date: 11/16/2015 11:25:18 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[createAdministrador] 
	--crea administradores. Administradores no podrán crear otros administradores.
	@username VARCHAR(25),
	@password VARCHAR(25)

AS
BEGIN
	
	SET NOCOUNT ON;

	DECLARE @error INT
	EXEC  @error = [dbo].[findAdministrador] @username;
	IF (@error = 1) BEGIN RAISERROR(50007,16,1);RETURN END

	BEGIN TRAN
	BEGIN TRY
		INSERT INTO Administradores(nombre,password)
			VALUES(@username,@password)

		 

		COMMIT TRAN
	END TRY
	BEGIN CATCH
		 ROLLBACK TRAN
		 SELECT ERROR_NUMBER() AS ErrorNumber
		 ,ERROR_SEVERITY() AS ErrorSeverity
		 ,ERROR_STATE() AS ErrorState
		 ,ERROR_PROCEDURE() AS ErrorProcedure
		 ,ERROR_LINE() AS ErrorLine
		 ,ERROR_MESSAGE() AS ErrorMessage;
	END CATCH
END



GO
/****** Object:  StoredProcedure [dbo].[createBitacora]    Script Date: 11/16/2015 11:25:18 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[createBitacora] 
	@administrador VARCHAR(25),
	@descripcion VARCHAR(100),--¿Qué fue lo que ocurrió?
	@restaurante VARCHAR(25)
AS
BEGIN

	SET NOCOUNT ON;

	BEGIN TRAN
		INSERT INTO BitacoraAdministradores(nombreAdministrador,descripcion,fecha,restaurante)
			VALUES(@administrador,@descripcion,GETDATE(),@restaurante)
	COMMIT TRAN
END


GO
/****** Object:  StoredProcedure [dbo].[createCliente]    Script Date: 11/16/2015 11:25:18 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[createCliente] 
	-- Add the parameters for the stored procedure here
	@correoElectronico VARCHAR(100),
	@nombre VARCHAR(50),
	@numeroTel INT,
	@cedula INT,
	@password VARCHAR(25)
AS
BEGIN
	SET NOCOUNT ON;

    
	DECLARE @error INT
	EXEC  @error = [dbo].[findCliente] @correoElectronico;
	IF (@error = 1) BEGIN RAISERROR(50009,16,1);RETURN END

	BEGIN TRAN
	BEGIN TRY
		INSERT INTO Clientes(cedula,nombre,numeroTelefonico,correoElectronico,password)
			VALUES(@cedula,@nombre,@numeroTel,@correoElectronico,@password)

		COMMIT TRAN
	END TRY
	BEGIN CATCH
		 ROLLBACK TRAN
		 SELECT ERROR_NUMBER() AS ErrorNumber
		 ,ERROR_SEVERITY() AS ErrorSeverity
		 ,ERROR_STATE() AS ErrorState
		 ,ERROR_PROCEDURE() AS ErrorProcedure
		 ,ERROR_LINE() AS ErrorLine
		 ,ERROR_MESSAGE() AS ErrorMessage;
	END CATCH
END

GO
/****** Object:  StoredProcedure [dbo].[createIngrediente]    Script Date: 11/16/2015 11:25:18 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[createIngrediente]
	@nombre VARCHAR(25),
	@precio INT,
	@categoria VARCHAR(25),
	@imagen VARCHAR(100)
	
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @error int;
	EXEC  @error = [dbo].[findIngrediente] @nombre;
	IF (@error = 1) BEGIN RAISERROR(50004,16,1);RETURN END
	EXEC  @error = [dbo].[findCategoriaIngrediente] @categoria;
	IF (@error = 0) BEGIN RAISERROR(50005,16,1);RETURN END

    BEGIN TRAN
	BEGIN TRY
		INSERT INTO Ingredientes(nombre,precio,categoriaIngrediente,imagen)
			VALUES(@nombre,@precio,@categoria,@imagen)
		COMMIT TRAN
	END TRY

	BEGIN CATCH
		ROLLBACK TRAN
		SELECT ERROR_NUMBER() AS ErrorNumber
		 ,ERROR_SEVERITY() AS ErrorSeverity
		 ,ERROR_STATE() AS ErrorState
		 ,ERROR_PROCEDURE() AS ErrorProcedure
		 ,ERROR_LINE() AS ErrorLine
		 ,ERROR_MESSAGE() AS ErrorMessage;
	END CATCH
END



GO
/****** Object:  StoredProcedure [dbo].[createRestaurante]    Script Date: 11/16/2015 11:25:18 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[createRestaurante] 
	@nombre VARCHAR(25),
	@horarioAtencion VARCHAR(100),
	@numeroTelefonico INT,
	@direccion VARCHAR(25),--debe ser el nombre de la cuadra. Ej: Cuadra1
	@categoria VARCHAR(25)
AS
BEGIN
	SET NOCOUNT ON;

	DECLARE @error int;
	EXEC  @error = [dbo].[findRestaurante] @nombre;
	IF (@error = 1) BEGIN RAISERROR(50001,16,1);RETURN END
	EXEC  @error = [dbo].[findCuadra] @direccion;
	IF (@error = 0) BEGIN RAISERROR(50003,16,1);RETURN END
	EXEC  @error = [dbo].[findCategoriaRestaurante] @categoria;
	IF (@error = 0) BEGIN RAISERROR(50002,16,1);RETURN END

	BEGIN TRAN

	BEGIN TRY
		INSERT INTO Restaurantes(nombre,horarioAtencion,numeroTelefonico,direccion,categoria)
			VALUES(@nombre,@horarioAtencion,@numeroTelefonico,@direccion,@categoria)
		COMMIT TRAN 
	END TRY

	BEGIN CATCH
		ROLLBACK TRAN
		SELECT ERROR_NUMBER() AS ErrorNumber
		 ,ERROR_SEVERITY() AS ErrorSeverity
		 ,ERROR_STATE() AS ErrorState
		 ,ERROR_PROCEDURE() AS ErrorProcedure
		 ,ERROR_LINE() AS ErrorLine
		 ,ERROR_MESSAGE() AS ErrorMessage;
	END CATCH
END



GO
/****** Object:  StoredProcedure [dbo].[deleteAdministrador]    Script Date: 11/16/2015 11:25:18 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[deleteAdministrador] 
	@username VARCHAR(25)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @error INT
    EXEC  @error = [dbo].[findAdministrador] @username;
	IF (@error = 0) BEGIN RAISERROR(50008,16,1);RETURN END

	BEGIN TRAN
	BEGIN TRY
	    DELETE FROM Administradores WHERE nombre = @username --borramos en la tabla
		
		/*DECLARE @command NVARCHAR(500)
		SET @command = N'DROP USER ' + @username;
		EXECUTE sp_executesql @command;--borramos el usuario de la base de datos

		SET @command = N'DROP LOGIN ' + @username;
		EXECUTE sp_executesql @command;--borramos el login de este*/

		COMMIT TRAN
	END TRY
	BEGIN CATCH
		 ROLLBACK TRAN
		 SELECT ERROR_NUMBER() AS ErrorNumber
		 ,ERROR_SEVERITY() AS ErrorSeverity
		 ,ERROR_STATE() AS ErrorState
		 ,ERROR_PROCEDURE() AS ErrorProcedure
		 ,ERROR_LINE() AS ErrorLine
		 ,ERROR_MESSAGE() AS ErrorMessage;
	END CATCH
END



GO
/****** Object:  StoredProcedure [dbo].[deleteCliente]    Script Date: 11/16/2015 11:25:18 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[deleteCliente]
	@correo VARCHAR(25)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @error INT
    EXEC  @error = [dbo].[findCliente] @correo;
	IF (@error = 0) BEGIN RAISERROR(50010,16,1);RETURN END

	BEGIN TRAN
	BEGIN TRY
	    DELETE FROM Clientes WHERE correoElectronico = @correo --borramos en la tabla
		
		/*DECLARE @command NVARCHAR(500)
		SET @command = N'DROP USER ' + @correo;
		EXECUTE sp_executesql @command;--borramos el usuario de la base de datos

		SET @command = N'DROP LOGIN ' + @correo;
		EXECUTE sp_executesql @command;--borramos el login de este*/

		COMMIT TRAN
	END TRY
	BEGIN CATCH
		 ROLLBACK TRAN
		 SELECT ERROR_NUMBER() AS ErrorNumber
		 ,ERROR_SEVERITY() AS ErrorSeverity
		 ,ERROR_STATE() AS ErrorState
		 ,ERROR_PROCEDURE() AS ErrorProcedure
		 ,ERROR_LINE() AS ErrorLine
		 ,ERROR_MESSAGE() AS ErrorMessage;
	END CATCH
END


GO
/****** Object:  StoredProcedure [dbo].[deleteIngrediente]    Script Date: 11/16/2015 11:25:18 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[deleteIngrediente] 
	@nombreIngrediente VARCHAR(25)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @error int;
	EXEC  @error = [dbo].[findIngrediente] @nombreIngrediente;
	IF (@error = 0) BEGIN RAISERROR(50006,16,1);RETURN END

	BEGIN TRAN
		DELETE FROM Ingredientes
			WHERE nombre = @nombreIngrediente
	COMMIT TRAN
END



GO
/****** Object:  StoredProcedure [dbo].[findAdministrador]    Script Date: 11/16/2015 11:25:18 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[findAdministrador]
	@nombre VARCHAR(25)
	--retorna 1 si lo encuentra, ' si no 0
AS
BEGIN
	
	SET NOCOUNT ON;

    
	IF EXISTS (SELECT 'TRUE' FROM Administradores WHERE nombre = @nombre)
		BEGIN
			RETURN 1 
		END

	RETURN 0

END



GO
/****** Object:  StoredProcedure [dbo].[findCategoriaIngrediente]    Script Date: 11/16/2015 11:25:18 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[findCategoriaIngrediente]
	@nombre VARCHAR(25)
	--retorna 1 si lo encuentra, ' si no 0
AS
BEGIN
	
	SET NOCOUNT ON;

    
	IF EXISTS (SELECT 'TRUE' FROM CategoriasIngredientes WHERE nombre = @nombre)
		BEGIN
			RETURN 1 
		END

	RETURN 0

END



GO
/****** Object:  StoredProcedure [dbo].[findCategoriaRestaurante]    Script Date: 11/16/2015 11:25:18 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[findCategoriaRestaurante]
	@nombre VARCHAR(25)
	--retorna 1 si lo encuentra, ' si no 0
AS
BEGIN
	
	SET NOCOUNT ON;

    
	IF EXISTS (SELECT 'TRUE' FROM CategoriasRestaurantes WHERE nombre = @nombre)
		BEGIN
			RETURN 1 
		END

	RETURN 0

END



GO
/****** Object:  StoredProcedure [dbo].[findCliente]    Script Date: 11/16/2015 11:25:18 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[findCliente] 

	@correo VARCHAR(100)
	--retorna 1 si lo encuentra, ' si no 0
AS
BEGIN
	
	SET NOCOUNT ON;

    
	IF EXISTS (SELECT 'TRUE' FROM Clientes WHERE correoElectronico = @correo)
		BEGIN
			RETURN 1 
		END

	RETURN 0

END



GO
/****** Object:  StoredProcedure [dbo].[findCuadra]    Script Date: 11/16/2015 11:25:18 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[findCuadra] 
	@nombre VARCHAR(25)
	--retorna 1 si lo encuentra, ' si no 0
AS
BEGIN
	
	SET NOCOUNT ON;

    
	IF EXISTS (SELECT 'TRUE' FROM Cuadras WHERE nombre = @nombre)
		BEGIN
			RETURN 1 
		END

	RETURN 0

END



GO
/****** Object:  StoredProcedure [dbo].[findIngrediente]    Script Date: 11/16/2015 11:25:18 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[findIngrediente]
	@nombre VARCHAR(25)
	--retorna 1 si lo encuentra, ' si no 0
AS
BEGIN
	
	SET NOCOUNT ON;

    
	IF EXISTS (SELECT 'TRUE' FROM Ingredientes WHERE nombre = @nombre)
		BEGIN
			RETURN 1 
		END

	RETURN 0

END



GO
/****** Object:  StoredProcedure [dbo].[findRestaurante]    Script Date: 11/16/2015 11:25:18 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[findRestaurante]
	@nombre VARCHAR(25)
	--retorna 1 si lo encuentra, ' si no 0
AS
BEGIN
	
	SET NOCOUNT ON;

    
	IF EXISTS (SELECT 'TRUE' FROM Restaurantes WHERE nombre = @nombre)
		BEGIN
			RETURN 1 
		END

	RETURN 0

END



GO
/****** Object:  StoredProcedure [dbo].[generarClientes]    Script Date: 11/16/2015 11:25:18 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[generarClientes] 
	--genera 7 clientes a lo random, no borra los pasados
AS
BEGIN

	SET NOCOUNT ON;
	BEGIN TRAN
    DECLARE @contador INT = 0
	DECLARE @nombre VARCHAR(15) = ''
	DECLARE @apellido2 VARCHAR(15) = ''
	DECLARE @apellido1 VARCHAR(15) = ''
	DECLARE @cedula INT = 0
	DECLARE @numeroTelefonico INT = 0
	DECLARE @nombreCompleto VARCHAR(50) = ''
	DECLARE @correo VARCHAR(100)


	WHILE (@contador < 7)
		BEGIN
			SET @nombre =(SELECT TOP 1 nombre FROM nombres ORDER BY NEWID())
			SET @apellido2 =(SELECT TOP 1 apellido FROM apellidos ORDER BY NEWID())
			SET @apellido1 =(SELECT TOP 1 apellido FROM apellidos ORDER BY NEWID())
			--agarramos un nombre completo random
			SET @nombreCompleto = @nombre + ' ' + @apellido1 + ' ' + @apellido2
			SET @cedula = FLOOR(RAND()*1000000000)
			SET @numeroTelefonico = FLOOR(RAND()*1000000000)
			SET @correo = @nombre + CONVERT(varchar(20), @cedula) + '@gmail.com'
		
			EXEC [dbo].createCliente @correo,@nombreCompleto,@numeroTelefonico,@cedula,'pass'--les puse la misma contraseña a todos
			SET @contador = @contador + 1
		END
	COMMIT TRAN
END


GO
/****** Object:  StoredProcedure [dbo].[generarPlatillos]    Script Date: 11/16/2015 11:25:18 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- Batch submitted through debugger: SQLQuery1.sql|4|0|C:\Users\Josue\AppData\Local\Temp\~vsD46D.sql

CREATE PROCEDURE [dbo].[generarPlatillos]
	--genera platillos para una categoria de restaurante en especifico
	@restaurante VARCHAR(25)
AS
BEGIN

	SET NOCOUNT ON;
	BEGIN TRAN
	DECLARE @ERROR INT

	EXEC  @error = [dbo].[findCategoriaRestaurante] @restaurante;
	IF (@error = 0) BEGIN RAISERROR(50002,16,1);RETURN END

	DECLARE @contador INT = 0--intentaremos generar 7 platillos. Si hay uno repetido, este se descarta.
	DECLARE @numeroIngredientes INT
	DECLARE @listaIngredientes VARCHAR(200) = ''--ira de la forma: ingrediente1,ingrediente2,etc.
	DECLARE @listaIngredientesCopia VARCHAR(200) = ''--ira de la forma: ingrediente1,ingrediente2,etc.
	DECLARE @listaIngredientes2 VARCHAR(200) = ''--sera para compararla con listaIngredientes
	DECLARE @ingredienteActual VARCHAR(25)


	UPDATE Platillos
		SET activo = 0
			WHERE nombreCategoria = @restaurante --ponemos los platillos anteriores en inactivos
	
	DECLARE @numeroPlatillo INT = (SELECT TOP 1 contador From Platillos ORDER BY contador DESC)
	IF (@numeroPlatillo IS NULL)BEGIN SET @numeroPlatillo = 0 END--conseguimos el numero mayor de platillo.
	
	DECLARE @indice INT --indice para cortar string
	DECLARE @control BIT = 1 --nos dira si un platillo es repetido. Comenzamos asumiendo que si esta repetido

	DECLARE @platillos TABLE (string VARCHAR(100))--tabla temporal de platillos
	DECLARE @nombrePlatillo VARCHAR(25) = ''
	DECLARE @precioPlatillo INT

	WHILE(@contador <7)--
		BEGIN
			SET @numeroIngredientes = ABS(Checksum(NewID()) % 4) + 2--generamos un valor random entre 2 y 5
			SET @listaIngredientes = ''
			WHILE(@numeroIngredientes >0)
				BEGIN
					SET @ingredienteActual =(
						SELECT TOP 1 i.nombre 
							FROM Ingredientes i , IngredientesCategorias c
								WHERE i.nombre = c.nombreIngrediente AND c.nombreCategoria = @restaurante
									ORDER BY NEWID())
					
					if NOT (@listaIngredientes like ('%'+@ingredienteActual+'%')) --no queremos agregar ingredientes repetidos en el mismo platillo
						BEGIN
							SET @numeroIngredientes = @numeroIngredientes - 1
							SET @listaIngredientes = @listaIngredientes + @ingredienteActual + ','
						END
				END
			SET @listaIngredientesCopia = @listaIngredientes
			IF EXISTS (SELECT * FROM @platillos)--la primera vez se insertarán de un solo
				BEGIN
					DECLARE cursorPlatillos CURSOR
						FOR SELECT * FROM @platillos
					OPEN cursorPlatillos
					FETCH NEXT FROM cursorPlatillos INTO @listaIngredientes2;

					WHILE @@FETCH_STATUS = 0
					BEGIN
						SET @control = 1
						FETCH NEXT FROM cursorPlatillos INTO @listaIngredientes2;
						SET @listaIngredientes = @listaIngredientesCopia
						WHILE(LEN(@listaIngredientes) > 3)--hast que la string sea muy pequeña
							BEGIN
							    SET @indice = CHARINDEX(',', @listaIngredientes, CHARINDEX('_', @listaIngredientes, 1) + 1)
								SET @ingredienteActual = SUBSTRING(@listaIngredientes, 0, @indice)
								SET @listaIngredientes = SUBSTRING(@listaIngredientes, @indice+1, LEN(@listaIngredientes))
								if NOT (@listaIngredientes2 like ('%'+@ingredienteActual+'%')) --con tan solo uno que no este contenido
									BEGIN
										SET @control = 0
										BREAK;
									END
							END
							IF(@control <> 0)
								BEGIN
									SET @control = 1--eseta repetido
									BREAK--no ocupamos seguir revisando
								END

					END
					CLOSE cursorPlatillos
					DEALLOCATE cursorPlatillos

				END
			ELSE BEGIN SET @control = 0 END 

			IF (@control = 0)
			BEGIN
				INSERT INTO @platillos VALUES(@listaIngredientesCopia)
				SET @nombrePlatillo = 'Platillo'+CONVERT(varchar(5),@numeroPlatillo)
				INSERT INTO Platillos(nombre, nombreCategoria,precio,activo)
					VALUES(@nombrePlatillo,@restaurante,0,1)
				SET @precioPlatillo = 0
				SET @listaIngredientes = @listaIngredientesCopia
					WHILE(LEN(@listaIngredientes) > 3)--hast que la string sea muy pequeña
						BEGIN
							SET @indice = CHARINDEX(',', @listaIngredientes, CHARINDEX('_', @listaIngredientes, 1) + 1)
							SET @ingredienteActual = SUBSTRING(@listaIngredientes, 0, @indice)
							SET @listaIngredientes = SUBSTRING(@listaIngredientes, @indice+1, LEN(@listaIngredientes))
							--finalmente insertamos en la tabla
							INSERT INTO IngredientesPlatillos(nombreIngrediente,nombrePlatillo)
								VALUES(@ingredienteActual,@nombrePlatillo)
							
							SET @precioPlatillo = @precioPlatillo + (
													SELECT sum(i.precio)
														FROM Ingredientes i, IngredientesCategorias c
															WHERE i.nombre = @ingredienteActual AND c.nombreCategoria = @restaurante
																AND c.nombreIngrediente = i.nombre)
						END
				UPDATE Platillos
						SET precio = @precioPlatillo
							WHERE nombre = @nombrePlatillo
				SET @contador = @contador + 1
				SET @numeroPlatillo = @numeroPlatillo +1
			END
		END
	COMMIT TRAN

END




GO
/****** Object:  StoredProcedure [dbo].[generarTodosPlatillos]    Script Date: 11/16/2015 11:25:18 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[generarTodosPlatillos] 
	
AS
BEGIN
	--genera todos los platillos para todos los restaurantes
	SET NOCOUNT ON;
	DECLARE @categoriaActual VARCHAR(25) = ''
    DECLARE cursorCategorias CURSOR FOR SELECT categoria FROM Restaurantes

	OPEN cursorCategorias
	FETCH NEXT FROM cursorCategorias INTO @categoriaActual

	WHILE @@FETCH_STATUS = 0
		BEGIN
			EXEC [dbo].[generarPlatillos] @categoriaActual
			FETCH NEXT FROM cursorCategorias INTO @categoriaActual
		END
	CLOSE cursorCategorias
	DEALLOCATE cursorCategorias
	
END


GO
/****** Object:  StoredProcedure [dbo].[getCategoriasIngredientes]    Script Date: 11/16/2015 11:25:18 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[getCategoriasIngredientes] 

AS
BEGIN

	SET NOCOUNT ON;

	SELECT nombre
		FROM CategoriasIngredientes
END


GO
/****** Object:  StoredProcedure [dbo].[getCategoriasRestaurantes]    Script Date: 11/16/2015 11:25:18 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[getCategoriasRestaurantes]
	
AS
BEGIN

	SET NOCOUNT ON;

    SELECT nombre
		FROM CategoriasRestaurantes
END


GO
/****** Object:  StoredProcedure [dbo].[getCliente]    Script Date: 11/16/2015 11:25:18 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[getCliente] 
	@correoElectronico VARCHAR(100)
AS
BEGIN

	SET NOCOUNT ON;

    SELECT nombre,correoElectronico,cedula,numeroTelefonico,password
		FROM Clientes
			WHERE correoElectronico = @correoElectronico
END


GO
/****** Object:  StoredProcedure [dbo].[getCompraCliente]    Script Date: 11/16/2015 11:25:18 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[getCompraCliente]
	@cliente VARCHAR(100),--el correo de un cliente
	@monto INT OUTPUT
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @mesActual DATETIME = MONTH(GETDATE()) - 30

	SELECT @monto = (sum(montoTotal))
		FROM Compras
			WHERE correoCliente = @cliente AND fecha >= @mesActual--agarra todas las fechas mayores de hoy hace 30 dias
				  --AND formaDePago = 'efectivo'
			GROUP BY correoCliente
    
	
END


GO
/****** Object:  StoredProcedure [dbo].[getDistanciasRestaurantes]    Script Date: 11/16/2015 11:25:18 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[getDistanciasRestaurantes] 
	-- recibe 2 parametros y nos dice la distancia entre estos 2
	@restaurante1 VARCHAR(25),
	@restaurante2 VARCHAR(25)
	
AS
BEGIN


	SELECT c1.nombre as restaurante1, c2.nombre as restaurante2, c11.figura.STDistance(c22.figura) as distancia, c11.figura, c22.figura
		FROM Restaurantes c1, Restaurantes c2, Cuadras c11, Cuadras c22
			WHERE c1.nombre = @restaurante1 AND
				  c2.nombre = @restaurante2 AND
				  c1.direccion = c11.nombre  AND
				  c2.direccion = c22.nombre
	--restaurantes vecinos tendran una distancia de 0
END



GO
/****** Object:  StoredProcedure [dbo].[getIngredientes]    Script Date: 11/16/2015 11:25:18 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[getIngredientes]
	
AS
BEGIN

	SET NOCOUNT ON;

	SELECT nombre,precio,categoriaIngrediente,imagen
		FROM Ingredientes
END


GO
/****** Object:  StoredProcedure [dbo].[getIngredientesPorPlato]    Script Date: 11/16/2015 11:25:18 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[getIngredientesPorPlato] 
	@nombrePlatillo VARCHAR(25)
AS
BEGIN

	SET NOCOUNT ON;

    SELECT i.nombre,i.precio,i.categoriaIngrediente,i.imagen
		FROM Ingredientes i,  IngredientesPlatillos ip
			WHERE i.nombre = ip.nombreIngrediente AND ip.nombrePlatillo = @nombrePlatillo
END


GO
/****** Object:  StoredProcedure [dbo].[getIngredientesRestaurante]    Script Date: 11/16/2015 11:25:18 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[getIngredientesRestaurante] 
	@caegoriaRest VARCHAR(25)
AS
BEGIN

	SET NOCOUNT ON;
	DECLARE @error INT
	EXEC  @error = [dbo].[findCategoriaRestaurante] @caegoriaRest;
	IF (@error = 0) BEGIN RAISERROR(50002,16,1);RETURN END


    SELECT i.nombre,i.precio,i.imagen,i.categoriaIngrediente,c.cantidad
		FROM Ingredientes i, IngredientesCategorias c
			WHERE i.nombre = c.nombreIngrediente AND
				  c.nombreCategoria = @caegoriaRest AND
				  c.cantidad >=1
END


GO
/****** Object:  StoredProcedure [dbo].[getPlatillosRestaurante]    Script Date: 11/16/2015 11:25:18 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[getPlatillosRestaurante] 
	@restaurante VARCHAR(25)
AS
BEGIN

	SET NOCOUNT ON;
	DECLARE @categoriaRestaurante VARCHAR(25) = (SELECT categoria FROM Restaurantes WHERE nombre = @restaurante)
    
	
	SELECT p.nombre,p.precio,
	(SELECT TOP 1 Imagen from Ingredientes i,IngredientesPlatillos ip WHERE i.nombre = ip.nombreIngrediente AND ip.nombrePlatillo = p.nombre ORDER BY NEWID()) as imagen
		FROM Platillos p
			WHERE P.nombreCategoria = @categoriaRestaurante AND p.activo = 1
			AND dbo.verifyPlatillo(p.nombre,@categoriaRestaurante) = 1
END


GO
/****** Object:  StoredProcedure [dbo].[getRestaurantes]    Script Date: 11/16/2015 11:25:18 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[getRestaurantes]
AS
BEGIN
	
	SET NOCOUNT ON;

	SELECT nombre, horarioAtencion, numeroTelefonico, direccion, categoria 
		FROM Restaurantes
    
END



GO
/****** Object:  StoredProcedure [dbo].[getUbicacionRestaurante]    Script Date: 11/16/2015 11:25:18 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[getUbicacionRestaurante]
	@nombreRestaurante VARCHAR(25) --nombre del restaurante a consultar
AS
BEGIN

	SET NOCOUNT ON;

	SELECT r.nombre, c.nombre , c.figura
		FROM Restaurantes r
		INNER JOIN Cuadras c
			ON c.nombre = r.direccion
				WHERE r.nombre = @nombreRestaurante
END



GO
/****** Object:  StoredProcedure [dbo].[getVecinosRestaurante]    Script Date: 11/16/2015 11:25:18 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[getVecinosRestaurante] 
	-- Add the parameters for the stored procedure here
	@restaurante VARCHAR(25)
AS
BEGIN

	SET NOCOUNT ON;

    SELECT r.nombre, ca.nombre as vecino, cua.figura, ca.figura
		FROM Restaurantes r, Cuadras cua, CallesAvenidas ca
			WHERE r.direccion = cua.nombre AND
				  r.nombre = @restaurante AND
				  cua.figura.STTouches(ca.figura) = 1--buscamos las vecinas
END



GO
/****** Object:  StoredProcedure [dbo].[getVentas7dias]    Script Date: 11/16/2015 11:25:18 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[getVentas7dias] 
	@restaurante VARCHAR(25) = NULL,
	@fInicio DATE = NULL,
	@fFinal DATE = NULL
AS
BEGIN

	SET NOCOUNT ON;
	/*Generar una consulta en donde se ingrese como parámetros (opcionales) un rango de fechas, 
	y un restaurante (también opcional, si no se envía se realiza a todos los restaurantes) y 
	esta retorne un análisis en donde compare en los 7 días de la semana qué ingrediente se vendió más, 
	cual fue la ganancia (suma de todos los platillos que incluyen dicho ingrediente) obtenida por esas ventas. */

	DECLARE @resultado TABLE (diaSemana VARCHAR(25),
								restaurante VARCHAR(25),
								ingrediente VARCHAR(500),
								ganancia INT)

    
	DECLARE @copiaRestaurante VARCHAR(25)= @restaurante
	IF(@copiaRestaurante IS NULL)
		BEGIN SET @copiaRestaurante = 'todos' END
	INSERT INTO @resultado VALUES('Sunday',@copiaRestaurante,NULL,0)
	INSERT INTO @resultado VALUES('Monday',@copiaRestaurante,NULL,0)
	INSERT INTO @resultado VALUES('Tuesday',@copiaRestaurante,NULL,0)
	INSERT INTO @resultado VALUES('Wednesday',@copiaRestaurante,NULL,0)
	INSERT INTO @resultado VALUES('Thursday',@copiaRestaurante,NULL,0)
	INSERT INTO @resultado VALUES('Friday',@copiaRestaurante,NULL,0)
	INSERT INTO @resultado VALUES('Saturday',@copiaRestaurante,NULL,0)
	--llamaremos para cada dia, se vera la ganancia para ese restaurante

	DECLARE @gananciaDia INT = 0
	DECLARE @ingredienteDia VARCHAR(500) = 'No contemplado'

	EXEC [dbo].[getVentas7diasAUX] @restaurante,@fInicio,@fFinal,'Monday',
			@ingrediente = @ingredienteDia OUTPUT, @ganancia = @gananciaDia OUTPUT
	UPDATE @resultado SET ingrediente = @ingredienteDia, ganancia = @gananciaDia WHERE diaSemana = 'Monday'

	SET @gananciaDia = 0
	SET @ingredienteDia = 'No contemplado'

	EXEC [dbo].[getVentas7diasAUX] @restaurante,@fInicio,@fFinal,'Tuesday',
			@ingrediente = @ingredienteDia OUTPUT, @ganancia = @gananciaDia OUTPUT
	UPDATE @resultado SET ingrediente = @ingredienteDia, ganancia = @gananciaDia WHERE diaSemana = 'Tuesday'

	SET @gananciaDia = 0
	SET @ingredienteDia = 'No contemplado'

	EXEC [dbo].[getVentas7diasAUX] @restaurante,@fInicio,@fFinal,'Wednesday',
			@ingrediente = @ingredienteDia OUTPUT, @ganancia = @gananciaDia OUTPUT
	UPDATE @resultado SET ingrediente = @ingredienteDia, ganancia = @gananciaDia WHERE diaSemana = 'Wednesday'

	SET @gananciaDia = 0
	SET @ingredienteDia = 'No contemplado'

	EXEC [dbo].[getVentas7diasAUX] @restaurante,@fInicio,@fFinal,'Thursday',
			@ingrediente = @ingredienteDia OUTPUT, @ganancia = @gananciaDia OUTPUT
	UPDATE @resultado SET ingrediente = @ingredienteDia, ganancia = @gananciaDia WHERE diaSemana = 'Thursday'

	SET @gananciaDia = 0
	SET @ingredienteDia = 'No contemplado'

	EXEC [dbo].[getVentas7diasAUX] @restaurante,@fInicio,@fFinal,'Friday',
			@ingrediente = @ingredienteDia OUTPUT, @ganancia = @gananciaDia OUTPUT
	UPDATE @resultado SET ingrediente = @ingredienteDia, ganancia = @gananciaDia WHERE diaSemana = 'Friday'

	SET @gananciaDia = 0
	SET @ingredienteDia = 'No contemplado'

	EXEC [dbo].[getVentas7diasAUX] @restaurante,@fInicio,@fFinal,'Saturday',
			@ingrediente = @ingredienteDia OUTPUT, @ganancia = @gananciaDia OUTPUT
	UPDATE @resultado SET ingrediente = @ingredienteDia, ganancia = @gananciaDia WHERE diaSemana = 'Saturday'
	
	SET @gananciaDia = 0
	SET @ingredienteDia = 'No contemplado'

	EXEC [dbo].[getVentas7diasAUX] @restaurante,@fInicio,@fFinal,'Sunday',
			@ingrediente = @ingredienteDia OUTPUT, @ganancia = @gananciaDia OUTPUT
	UPDATE @resultado SET ingrediente = @ingredienteDia, ganancia = @gananciaDia WHERE diaSemana = 'Sunday'


    SELECT * FROM @resultado
    
END


GO
/****** Object:  StoredProcedure [dbo].[getVentas7diasAUX]    Script Date: 11/16/2015 11:25:18 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[getVentas7diasAUX] 
--consigue en un rango de fechas y para un restaurante opcional(es), 
--el ingrediente más vendido y su ganancia, para un día dado
	@restaurante VARCHAR(25) = NULL,
	@fInicio DATE = NULL,
	@fFinal DATE = NULL,
	@dia VARCHAR(25), --MONDAY, TUESDAY, ETC.
	@ingrediente VARCHAR(500) = NULL OUTPUT,
	@ganancia INT = NULL OUTPUT
AS
BEGIN
	
	SET NOCOUNT ON;

	SET @ingrediente = ''
	SELECT @ganancia = SUM(p.precio) --agarramos la mayor ganancia
		FROM Ingredientes i, Compras c, LineasCompras lc, Platillos p, IngredientesPlatillos ip
			WHERE c.restaurante = ISNULL(@restaurante,c.restaurante) AND
				  CONVERT(DATE,c.fecha) <= ISNULL(@fFinal, CONVERT(DATE,c.fecha)) AND
				  CONVERT(DATE,c.fecha) >= ISNULL(@fInicio, CONVERT(DATE,c.fecha)) AND
				  DATENAME(dw,c.fecha) = @dia AND
				  i.nombre = ip.nombreIngrediente AND
				  ip.nombrePlatillo = p.nombre AND
				  lc.nombrePlatillo = p.nombre AND
				  lc.idCompra = c.id 
				  GROUP BY (i.nombre)
				  ORDER BY (SUM(p.precio)) 
	--ahora buscamos los ingredientes que poseean esa ganancia
	SELECT @ingrediente = COALESCE(@ingrediente + '- ', '') + i.nombre
			FROM Ingredientes i, Compras c, LineasCompras lc, Platillos p, IngredientesPlatillos ip
			WHERE c.restaurante = ISNULL(@restaurante,c.restaurante) AND
				  CONVERT(DATE,c.fecha) <= ISNULL(@fFinal, CONVERT(DATE,c.fecha)) AND
				  CONVERT(DATE,c.fecha) >= ISNULL(@fInicio, CONVERT(DATE,c.fecha)) AND
				  DATENAME(dw,c.fecha) = @dia AND
				  i.nombre = ip.nombreIngrediente AND
				  ip.nombrePlatillo = p.nombre AND
				  lc.nombrePlatillo = p.nombre AND
				  lc.idCompra = c.id 
				  
				  GROUP BY (i.nombre)
				  HAVING (SUM(p.precio) >= @ganancia)

	
		
END


GO
/****** Object:  StoredProcedure [dbo].[getVentasIngrediente]    Script Date: 11/16/2015 11:25:18 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[getVentasIngrediente]
	@ingrediente VARCHAR(25), --unico parámetro no opcional
	@restaurante VARCHAR(25) = NULL,
	@fFinal DATE = NULL,
	@fInicio DATE = NULL
AS
BEGIN
	/*Generar una consulta en donde se ingrese un ingrediente en específico y 
	muestre todas las ventas realizadas de platillos en donde se encuentre ese ingrediente, 
	a esta consulta se le puede enviar como parámetro el restaurante o un rango de fechas. 
	Estos parámetros pueden ser opcionales. */
	SET NOCOUNT ON;

	SELECT i.nombre,p.nombre,c.id,c.correoCliente,c.formaDePago,c.montoBase,c.montoTotal,c.fecha,c.restaurante
		FROM Ingredientes i, Compras c, Platillos p, IngredientesPlatillos ip, LineasCompras l
			WHERE c.restaurante = ISNULL(@restaurante,c.restaurante) AND
				  CONVERT(DATE,c.fecha) >= ISNULL(@fInicio, CONVERT(DATE,c.fecha)) AND
				  CONVERT(DATE,c.fecha) <= ISNULL(@fFinal, CONVERT(DATE,c.fecha)) AND
				  l.idCompra = c.id AND l.nombrePlatillo = p.nombre 
				  AND p.nombre = ip.nombrePlatillo AND i.nombre = ip.nombreIngrediente AND
				  i.nombre = @ingrediente
				  
    
END


GO
/****** Object:  StoredProcedure [dbo].[getVentasRestaurante]    Script Date: 11/16/2015 11:25:18 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[getVentasRestaurante]
	@restaurante VARCHAR(25),--es un restaurante
	@dia DATE
AS
BEGIN

	SET NOCOUNT ON;

    DECLARE @error int;
	EXEC  @error = [dbo].[findRestaurante] @restaurante;
	IF (@error = 0) BEGIN RAISERROR(50011,16,1);RETURN END

	DECLARE @categoriaRestaurante VARCHAR(25) = (SELECT categoria FROM Restaurantes WHERE nombre = @restaurante)
	
	DECLARE @gananciaTotal INT = 
				(SELECT SUM(montoTotal)
					FROM Compras
						WHERE restaurante = @restaurante AND
				              CONVERT(date,fecha) = @dia) --en un dia dado
	
	SELECT correoCliente,fecha,formaDePago,montoBase,montoTotal, @gananciaTotal AS gananciaTotal
		FROM Compras
			WHERE restaurante = @restaurante AND
				  CONVERT(date,fecha) = @dia --en un dia dado

END


GO
/****** Object:  StoredProcedure [dbo].[getVentasRestaurantes]    Script Date: 11/16/2015 11:25:18 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[getVentasRestaurantes] 
	
	@fInicio DATE,
	@fFinal DATE --ojo que no son opcionales
AS
BEGIN

	SET NOCOUNT ON;
	/*Generar consulta en donde se pueda ver una comparación del total de ventas de cada restaurante en un período en específico. */

    (SELECT r.nombre, SUM(c.montoBase) as montoBase, SUM(c.montoTotal) as montoTotal
		FROM Restaurantes r JOIN Compras c
			ON r.nombre = c.restaurante --de esta manera salen los nulos, o que no tienen ni una venta
		WHERE     CONVERT(DATE,c.fecha) >= ISNULL(@fInicio, CONVERT(DATE,c.fecha)) AND
				  CONVERT(DATE,c.fecha) <= ISNULL(@fFinal, CONVERT(DATE,c.fecha))
		GROUP BY r.nombre)--conseguimos los que tienen ventas en esas fechas
	UNION
	(SELECT r.nombre,0 as montoBase, 0 as montoTotal
			FROM Restaurantes r LEFT JOIN Compras c
			ON r.nombre = c.restaurante
			WHERE c.restaurante IS NULL) --mas los que no tienen ventas, con 0 de ganancia
END


GO
/****** Object:  StoredProcedure [dbo].[init]    Script Date: 11/16/2015 11:25:18 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[init]
	--inicia la base de datos espacial
AS
BEGIN
	
	SET NOCOUNT ON
	

		DELETE FROM CallesAvenidas
		DELETE FROM Cuadras
		DELETE FROM Barrios


		INSERT INTO Barrios(id, nombre)
			VALUES(1,'Sistema de Restaurantes')
		INSERT INTO CallesAvenidas(idBarrio,nombre,figura)
			VALUES(1,'Avenida1', geometry::STGeomFromText('POLYGON ((0 10, 0 11, 11 11, 11 10, 0 10))', 0))
		INSERT INTO CallesAvenidas(idBarrio,nombre,figura)
			VALUES(1,'Avenida2', geometry::STGeomFromText('POLYGON ((0 8, 0 9, 11 9, 11 8, 0 8))', 0))
		INSERT INTO CallesAvenidas(idBarrio,nombre,figura)
			VALUES(1,'Avenida3', geometry::STGeomFromText('POLYGON ((0 6, 0 7, 11 7, 11 6, 0 6))', 0))
		INSERT INTO CallesAvenidas(idBarrio,nombre,figura)
			VALUES(1,'Avenida4', geometry::STGeomFromText('POLYGON ((0 4, 0 5, 11 5, 11 4, 0 4))', 0))
		INSERT INTO CallesAvenidas(idBarrio,nombre,figura)
			VALUES(1,'Avenida5', geometry::STGeomFromText('POLYGON ((0 2, 0 3, 11 3, 11 2, 0 2))', 0))
		INSERT INTO CallesAvenidas(idBarrio,nombre,figura)
			VALUES(1,'Avenida6', geometry::STGeomFromText('POLYGON ((0 0, 0 1, 11 1, 11 0, 0 0))', 0))

		INSERT INTO CallesAvenidas(idBarrio,nombre,figura)
			VALUES(1,'Calle1', geometry::STGeomFromText('POLYGON ((0 0, 0 11, 1 11, 1 0, 0 0))', 0))
		INSERT INTO CallesAvenidas(idBarrio,nombre,figura)
			VALUES(1,'Calle2', geometry::STGeomFromText('POLYGON ((2 0, 2 11, 3 11, 3 0, 2 0))', 0))
		INSERT INTO CallesAvenidas(idBarrio,nombre,figura)
			VALUES(1,'Calle3', geometry::STGeomFromText('POLYGON ((4 0, 4 11, 5 11, 5 0, 4 0))', 0))
		INSERT INTO CallesAvenidas(idBarrio,nombre,figura)
			VALUES(1,'Calle4', geometry::STGeomFromText('POLYGON ((6 0, 6 11, 7 11, 7 0, 6 0))', 0))
		INSERT INTO CallesAvenidas(idBarrio,nombre,figura)
			VALUES(1,'Calle5', geometry::STGeomFromText('POLYGON ((8 0, 8 11, 9 11, 9 0, 8 0))', 0))
		INSERT INTO CallesAvenidas(idBarrio,nombre,figura)
			VALUES(1,'Calle6', geometry::STGeomFromText('POLYGON ((10 0, 10 11, 11 11, 11 0, 10 0))', 0))

		INSERT INTO Cuadras(idBarrio,nombre,figura,restaurante)
			VALUES(1,'Cuadra1', geometry::STGeomFromText('POLYGON ((1 9, 1 10, 2 10, 2 9, 1 9))', 0),null)
		INSERT INTO Cuadras(idBarrio,nombre,figura,restaurante)
			VALUES(1,'Cuadra2', geometry::STGeomFromText('POLYGON ((3 9, 3 10, 4 10, 4 9, 3 9))', 0),null)
		INSERT INTO Cuadras(idBarrio,nombre,figura,restaurante)
			VALUES(1,'Cuadra3', geometry::STGeomFromText('POLYGON ((5 9, 5 10, 6 10, 6 9, 5 9))', 0),null)
		INSERT INTO Cuadras(idBarrio,nombre,figura,restaurante)
			VALUES(1,'Cuadra4', geometry::STGeomFromText('POLYGON ((7 9, 7 10, 8 10, 8 9, 7 9))', 0),null)
		INSERT INTO Cuadras(idBarrio,nombre,figura,restaurante)
			VALUES(1,'Cuadra5', geometry::STGeomFromText('POLYGON ((9 9, 9 10, 10 10, 10 9, 9 9))', 0),null)

		INSERT INTO Cuadras(idBarrio,nombre,figura,restaurante)
			VALUES(1,'Cuadra6', geometry::STGeomFromText('POLYGON ((1 7, 1 8, 2 8, 2 7, 1 7))', 0),null)
		INSERT INTO Cuadras(idBarrio,nombre,figura,restaurante)
			VALUES(1,'Cuadra7', geometry::STGeomFromText('POLYGON ((3 7, 3 8, 4 8, 4 7, 3 7))', 0),null)
		INSERT INTO Cuadras(idBarrio,nombre,figura,restaurante)
			VALUES(1,'Cuadra8', geometry::STGeomFromText('POLYGON ((5 7, 5 8, 6 8, 6 7, 5 7))', 0),null)
		INSERT INTO Cuadras(idBarrio,nombre,figura,restaurante)
			VALUES(1,'Cuadra9', geometry::STGeomFromText('POLYGON ((7 7, 7 8, 8 8, 8 7, 7 7))', 0),null)
		INSERT INTO Cuadras(idBarrio,nombre,figura,restaurante)
			VALUES(1,'Cuadra10', geometry::STGeomFromText('POLYGON ((9 7, 9 8, 10 8, 10 7, 9 7))', 0),null)

		INSERT INTO Cuadras(idBarrio,nombre,figura,restaurante)
			VALUES(1,'Cuadra11', geometry::STGeomFromText('POLYGON ((1 5, 1 6, 2 6, 2 5, 1 5))', 0),null)
		INSERT INTO Cuadras(idBarrio,nombre,figura,restaurante)
			VALUES(1,'Cuadra12', geometry::STGeomFromText('POLYGON ((3 5, 3 6, 4 6, 4 5, 3 5))', 0),null)
		INSERT INTO Cuadras(idBarrio,nombre,figura,restaurante)
			VALUES(1,'Cuadra13', geometry::STGeomFromText('POLYGON ((5 5, 5 6, 6 6, 6 5, 5 5))', 0),null)
		INSERT INTO Cuadras(idBarrio,nombre,figura,restaurante)
			VALUES(1,'Cuadra14', geometry::STGeomFromText('POLYGON ((7 5, 7 6, 8 6, 8 5, 7 5))', 0),null)
		INSERT INTO Cuadras(idBarrio,nombre,figura,restaurante)
			VALUES(1,'Cuadra15', geometry::STGeomFromText('POLYGON ((9 5, 9 6, 10 6, 10 5, 9 5))', 0),null)

		INSERT INTO Cuadras(idBarrio,nombre,figura,restaurante)
			VALUES(1,'Cuadra16', geometry::STGeomFromText('POLYGON ((1 3, 1 4, 2 4, 2 3, 1 3))', 0),null)
		INSERT INTO Cuadras(idBarrio,nombre,figura,restaurante)
			VALUES(1,'Cuadra17', geometry::STGeomFromText('POLYGON ((3 3, 3 4, 4 4, 4 3, 3 3))', 0),null)
		INSERT INTO Cuadras(idBarrio,nombre,figura,restaurante)
			VALUES(1,'Cuadra18', geometry::STGeomFromText('POLYGON ((5 3, 5 4, 6 4, 6 3, 5 3))', 0),null)
		INSERT INTO Cuadras(idBarrio,nombre,figura,restaurante)
			VALUES(1,'Cuadra19', geometry::STGeomFromText('POLYGON ((7 3, 7 4, 8 4, 8 3, 7 3))', 0),null)
		INSERT INTO Cuadras(idBarrio,nombre,figura,restaurante)
			VALUES(1,'Cuadra20', geometry::STGeomFromText('POLYGON ((9 3, 9 4, 10 4, 10 3, 9 3))', 0),null)

		INSERT INTO Cuadras(idBarrio,nombre,figura,restaurante)
			VALUES(1,'Cuadra21', geometry::STGeomFromText('POLYGON ((1 1, 1 2, 2 2, 2 1, 1 1))', 0),null)
		INSERT INTO Cuadras(idBarrio,nombre,figura,restaurante)
			VALUES(1,'Cuadra22', geometry::STGeomFromText('POLYGON ((3 1, 3 2, 4 2, 4 1, 3 1))', 0),null)
		INSERT INTO Cuadras(idBarrio,nombre,figura,restaurante)
			VALUES(1,'Cuadra23', geometry::STGeomFromText('POLYGON ((5 1, 5 2, 6 2, 6 1, 5 1))', 0),null)
		INSERT INTO Cuadras(idBarrio,nombre,figura,restaurante)
			VALUES(1,'Cuadra24', geometry::STGeomFromText('POLYGON ((7 1, 7 2, 8 2, 8 1, 7 1))', 0),null)
		INSERT INTO Cuadras(idBarrio,nombre,figura,restaurante)
			VALUES(1,'Cuadra25', geometry::STGeomFromText('POLYGON ((9 1, 9 2, 10 2, 10 1, 9 1))', 0),null)

		DELETE FROM IngredientesCategorias
		DELETE FROM Restaurantes
		DELETE FROM CategoriasRestaurantes
		--Pondremos algunas categorías
		INSERT INTO CategoriasRestaurantes(nombre) VALUES('Mariscos')
		INSERT INTO CategoriasRestaurantes(nombre) VALUES('Omnivoros')
		INSERT INTO CategoriasRestaurantes(nombre) VALUES('Vegetarianos')
		INSERT INTO CategoriasRestaurantes(nombre) VALUES('Carnivoros')
		INSERT INTO CategoriasRestaurantes(nombre) VALUES('A lo Tico')
		INSERT INTO CategoriasRestaurantes(nombre) VALUES('Sopas')


		--Metemos los 6 restaurantes por default
		EXEC [dbo].[createRestaurante] 'R1','Lunes a Viernes 12pm - 10pm',83273913,'Cuadra1','Mariscos'
		EXEC [dbo].[createRestaurante] 'R2','Lunes a Sabado 12pm - 10pm',88630829,'Cuadra5','Omnivoros'
		EXEC [dbo].[createRestaurante] 'R3','Lunes a Viernes 8am - 8pm',87028484,'Cuadra8','Vegetarianos'
		EXEC [dbo].[createRestaurante] 'R4','Domingo a Viernes 8pm - 10pm',83245214,'Cuadra15','Carnivoros'
		EXEC [dbo].[createRestaurante] 'R5','Lunes a Sabado 12pm - 10pm',82401475,'Cuadra17','A lo Tico'
		EXEC [dbo].[createRestaurante] 'R6','Lunes a Sabado 12pm - 8pm',83249124,'Cuadra24','Sopas'

		DELETE FROM Ingredientes
		DELETE FROM CategoriasIngredientes
		--Metemos algunas categorias de ingredientes
		INSERT INTO CategoriasIngredientes(nombre) VALUES ('Vegetales')
		INSERT INTO CategoriasIngredientes(nombre) VALUES ('Animales Terrestres')
		INSERT INTO CategoriasIngredientes(nombre) VALUES ('Animales Marinos')
		INSERT INTO CategoriasIngredientes(nombre) VALUES ('Harinas')
		INSERT INTO CategoriasIngredientes(nombre) VALUES ('A lo Tico')

		--Metemos algunos ingredientes (ojo que la imagen todavía no se manda)
		exec [dbo].[createIngrediente] 'Carne mechada',1200,'Animales Terrestres','app/img/CarneMechada.jpg'
		exec [dbo].[createIngrediente] 'Pollo',1100,'Animales Terrestres','app/img/Pollo.jpg'
		exec [dbo].[createIngrediente] 'Cerdo',2100,'Animales Terrestres','app/img/Cerdo.jpg'
		exec [dbo].[createIngrediente] 'Corderito',2200,'Animales Terrestres','app/img/Corderito.jpg'


		exec [dbo].[createIngrediente] 'Pescado',1500,'Animales Marinos','app/img/Pescado.jpg'
		exec [dbo].[createIngrediente] 'Langosta',2500,'Animales Marinos','app/img/Langosta.jpg'
		exec [dbo].[createIngrediente] 'Camarones',1900,'Animales Marinos','app/img/Camarones.jpg'
		exec [dbo].[createIngrediente] 'Pulpo',2700,'Animales Marinos','app/img/Pulpo.jpg'

		exec [dbo].[createIngrediente] 'Brocoli',400,'Vegetales','app/img/Brocoli.jpg'
		exec [dbo].[createIngrediente] 'Coliflor',500,'Vegetales','app/img/Coliflor.jpg'
		exec [dbo].[createIngrediente] 'Zanahoria',300,'Vegetales','app/img/Zanahoria.jpg'
		exec [dbo].[createIngrediente] 'Lechuga',300,'Vegetales','app/img/Lechuga.jpg'
		exec [dbo].[createIngrediente] 'Tomate',400,'Vegetales','app/img/Tomate.jpg'
		exec [dbo].[createIngrediente] 'Repollo',400,'Vegetales','app/img/Repollo.jpg'
		exec [dbo].[createIngrediente] 'Papa',400,'Vegetales','app/img/Papa.jpg'

		exec [dbo].[createIngrediente] 'Pinto',1000,'A lo tico','app/img/Pinto.jpg'
		exec [dbo].[createIngrediente] 'Tamal',1000,'A lo tico','app/img/Tamal.jpg'
		exec [dbo].[createIngrediente] 'Arroz con Pollo',1600,'A lo tico','app/img/ArrozConPollo.jpg'
		exec [dbo].[createIngrediente] 'Picadillo de papa',1200,'A lo tico','app/img/PicadilloDePapa.jpg'
		

		--Ahora asociaremos categorias de restaurantes con ingredientes
		
		exec [dbo].[linkRestauranteIngrediente] 'Carne mechada','Carnivoros',3
		exec [dbo].[linkRestauranteIngrediente] 'Carne mechada','Omnivoros',3
		exec [dbo].[linkRestauranteIngrediente] 'Carne mechada','Sopas',3
		exec [dbo].[linkRestauranteIngrediente] 'Pollo','Carnivoros',3
		exec [dbo].[linkRestauranteIngrediente] 'Pollo','Omnivoros',3
		exec [dbo].[linkRestauranteIngrediente] 'Pollo','Sopas',3
		exec [dbo].[linkRestauranteIngrediente] 'Cerdo','Carnivoros',3
		exec [dbo].[linkRestauranteIngrediente] 'Cerdo','Omnivoros',3
		exec [dbo].[linkRestauranteIngrediente] 'Corderito','Carnivoros',3
		exec [dbo].[linkRestauranteIngrediente] 'Corderito','Omnivoros',3
		exec [dbo].[linkRestauranteIngrediente] 'Corderito','Sopas',3

		exec [dbo].[linkRestauranteIngrediente] 'Pescado','Carnivoros',3
		exec [dbo].[linkRestauranteIngrediente] 'Pescado','Omnivoros',3
		exec [dbo].[linkRestauranteIngrediente] 'Pescado','Sopas',3
		exec [dbo].[linkRestauranteIngrediente] 'Pescado','Mariscos',3
		exec [dbo].[linkRestauranteIngrediente] 'Langosta','Carnivoros',3
		exec [dbo].[linkRestauranteIngrediente] 'Langosta','Mariscos',3
		exec [dbo].[linkRestauranteIngrediente] 'Camarones','Carnivoros',3
		exec [dbo].[linkRestauranteIngrediente] 'Camarones','Mariscos',3
		exec [dbo].[linkRestauranteIngrediente] 'Pulpo','Carnivoros',3
		exec [dbo].[linkRestauranteIngrediente] 'Pulpo','Mariscos',3
		exec [dbo].[linkRestauranteIngrediente] 'Pulpo','Sopas',3

		exec [dbo].[linkRestauranteIngrediente] 'Pinto','A lo Tico',3
		exec [dbo].[linkRestauranteIngrediente] 'Pinto','Vegetarianos',3
		exec [dbo].[linkRestauranteIngrediente] 'Tamal','A lo Tico',3
		exec [dbo].[linkRestauranteIngrediente] 'Arroz con Pollo','A lo Tico',3
		exec [dbo].[linkRestauranteIngrediente] 'Picadillo de papa','A lo Tico',3

		exec [dbo].[linkRestauranteIngrediente] 'Brocoli','A lo Tico',3
		exec [dbo].[linkRestauranteIngrediente] 'Brocoli','Vegetarianos',3
		exec [dbo].[linkRestauranteIngrediente] 'Brocoli','Omnivoros',3
		exec [dbo].[linkRestauranteIngrediente] 'Brocoli','Mariscos',3

		exec [dbo].[linkRestauranteIngrediente] 'Coliflor','A lo Tico',3
		exec [dbo].[linkRestauranteIngrediente] 'Coliflor','Vegetarianos',3
		exec [dbo].[linkRestauranteIngrediente] 'Coliflor','Omnivoros',3
		exec [dbo].[linkRestauranteIngrediente] 'Coliflor','Mariscos',3

		exec [dbo].[linkRestauranteIngrediente] 'Zanahoria','A lo Tico',3
		exec [dbo].[linkRestauranteIngrediente] 'Zanahoria','Vegetarianos',3
		exec [dbo].[linkRestauranteIngrediente] 'Zanahoria','Omnivoros',3
		exec [dbo].[linkRestauranteIngrediente] 'Zanahoria','Sopas',3
		exec [dbo].[linkRestauranteIngrediente] 'Zanahoria','Mariscos',3

		exec [dbo].[linkRestauranteIngrediente] 'Lechuga','A lo Tico',3
		exec [dbo].[linkRestauranteIngrediente] 'Lechuga','Vegetarianos',3
		exec [dbo].[linkRestauranteIngrediente] 'Lechuga','Omnivoros',3
		exec [dbo].[linkRestauranteIngrediente] 'Lechuga','Mariscos',3

		exec [dbo].[linkRestauranteIngrediente] 'Tomate','A lo Tico',3
		exec [dbo].[linkRestauranteIngrediente] 'Tomate','Vegetarianos',3
		exec [dbo].[linkRestauranteIngrediente] 'Tomate','Omnivoros',3
		exec [dbo].[linkRestauranteIngrediente] 'Tomate','Mariscos',3

		exec [dbo].[linkRestauranteIngrediente] 'Repollo','A lo Tico',3
		exec [dbo].[linkRestauranteIngrediente] 'Repollo','Vegetarianos',3
		exec [dbo].[linkRestauranteIngrediente] 'Repollo','Omnivoros',3
		exec [dbo].[linkRestauranteIngrediente] 'Repollo','Mariscos',3

		exec [dbo].[linkRestauranteIngrediente] 'Papa','A lo Tico',3
		exec [dbo].[linkRestauranteIngrediente] 'Papa','Vegetarianos',3
		exec [dbo].[linkRestauranteIngrediente] 'Papa','Omnivoros',3
		exec [dbo].[linkRestauranteIngrediente] 'Papa','Mariscos',3
		exec [dbo].[linkRestauranteIngrediente] 'Papa','Sopas',3
	 
		--insertaremos nombres y apellidos para la genreacion random de clientes

		DELETE FROM nombres
		DELETE FROM apellidos

		INSERT INTO nombres(nombre) VALUES('Josue')
		INSERT INTO nombres(nombre) VALUES('Pedro')
		INSERT INTO nombres(nombre) VALUES('Mariana')
		INSERT INTO nombres(nombre) VALUES('Adrian')
		INSERT INTO nombres(nombre) VALUES('Kirstein')
		INSERT INTO nombres(nombre) VALUES('Edgar')
		INSERT INTO nombres(nombre) VALUES('Fabian')
		INSERT INTO nombres(nombre) VALUES('Valeria')
		INSERT INTO nombres(nombre) VALUES('Vivian')
		INSERT INTO nombres(nombre) VALUES('Chepito')
		INSERT INTO nombres(nombre) VALUES('Luciana')
		INSERT INTO nombres(nombre) VALUES('Luis')
		INSERT INTO nombres(nombre) VALUES('Alejandro')
		INSERT INTO nombres(nombre) VALUES('Paula')
		INSERT INTO nombres(nombre) VALUES('Maria')
		INSERT INTO nombres(nombre) VALUES('Fernando')
		INSERT INTO nombres(nombre) VALUES('Ericka')
		INSERT INTO nombres(nombre) VALUES('Vladimir')
		INSERT INTO nombres(nombre) VALUES('Daniela')
		INSERT INTO nombres(nombre) VALUES('Catalina')

		INSERT INTO apellidos(apellido) VALUES('Arrieta')
		INSERT INTO apellidos(apellido) VALUES('Salas')
		INSERT INTO apellidos(apellido) VALUES('Chaves')
		INSERT INTO apellidos(apellido) VALUES('Lopez')
		INSERT INTO apellidos(apellido) VALUES('Quesada')
		INSERT INTO apellidos(apellido) VALUES('Gamboa')
		INSERT INTO apellidos(apellido) VALUES('Arce')
		INSERT INTO apellidos(apellido) VALUES('Desanti')
		INSERT INTO apellidos(apellido) VALUES('Gatjens')
		INSERT INTO apellidos(apellido) VALUES('Soto')
		INSERT INTO apellidos(apellido) VALUES('Salazar')
		INSERT INTO apellidos(apellido) VALUES('Solano')
		INSERT INTO apellidos(apellido) VALUES('Quiros')
		INSERT INTO apellidos(apellido) VALUES('Quintero')
		INSERT INTO apellidos(apellido) VALUES('Villata')
		INSERT INTO apellidos(apellido) VALUES('Garcia')
		INSERT INTO apellidos(apellido) VALUES('Maroto')
		INSERT INTO apellidos(apellido) VALUES('Berkovics')
		INSERT INTO apellidos(apellido) VALUES('Torrealba')
		INSERT INTO apellidos(apellido) VALUES('Echeverria')
		INSERT INTO apellidos(apellido) VALUES('Rodriguez')
		INSERT INTO apellidos(apellido) VALUES('Botero')
		INSERT INTO apellidos(apellido) VALUES('Alfaro')
		INSERT INTO apellidos(apellido) VALUES('Kennedy')
		INSERT INTO apellidos(apellido) VALUES('Adams')
		INSERT INTO apellidos(apellido) VALUES('Wilson')
		INSERT INTO apellidos(apellido) VALUES('Cabada')
		INSERT INTO apellidos(apellido) VALUES('Wang')
		INSERT INTO apellidos(apellido) VALUES('Tang')

    
END



GO
/****** Object:  StoredProcedure [dbo].[linkRestauranteIngrediente]    Script Date: 11/16/2015 11:25:18 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[linkRestauranteIngrediente] 
	--asocia un ingrediente con una categoria de restaurante
	@nombreIngrediente VARCHAR(25),
	@nombreCategoria VARCHAR(25),
	@cantidad INT
AS
BEGIN
	
	SET NOCOUNT ON;

	DECLARE @error int;
	EXEC  @error = [dbo].[findIngrediente] @nombreIngrediente;
	IF (@error = 0) BEGIN RAISERROR(50006,16,1);RETURN END
	EXEC  @error = [dbo].[findCategoriaRestaurante] @nombreCategoria;
	IF (@error = 0) BEGIN RAISERROR(50002,16,1);RETURN END


    BEGIN TRAN

	BEGIN TRY
		INSERT INTO IngredientesCategorias(nombreCategoria,nombreIngrediente,cantidad)
			VALUES(@nombreCategoria,@nombreIngrediente,@cantidad)
		COMMIT TRAN 
	END TRY

	BEGIN CATCH
		ROLLBACK TRAN
		SELECT ERROR_NUMBER() AS ErrorNumber
		 ,ERROR_SEVERITY() AS ErrorSeverity
		 ,ERROR_STATE() AS ErrorState
		 ,ERROR_PROCEDURE() AS ErrorProcedure
		 ,ERROR_LINE() AS ErrorLine
		 ,ERROR_MESSAGE() AS ErrorMessage;
	END CATCH
END



GO
/****** Object:  StoredProcedure [dbo].[realizarCompra]    Script Date: 11/16/2015 11:25:18 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[realizarCompra]
	@correoCliente VARCHAR(100), --correo del cliente que a nombre se hace la factura
	@formaPago VARCHAR(25),--Tiene que ser: efectivo o credito
	@listaPlatillos VARCHAR(200),-- De la forma: Platillo1,Platillo2,Platillo3,Platillo4,
	@restaurante VARCHAR(25)--restaurante donde la compra es realizada
	--NOTA: se asumen todos los parámetros correctos, en caso de uno incorrecto, no se crea nada
AS
BEGIN
	SET NOCOUNT ON;

	BEGIN TRAN
	BEGIN TRY

			INSERT INTO Compras(correoCliente,fecha,montoBase,formaDePago,montoTotal,restaurante)
				VALUES(@correoCliente,GETDATE(),0,@formaPago,0,@restaurante)
			DECLARE @idCompra INT = (SELECT TOP 1 id FROM Compras ORDER BY id DESC)
			DECLARE @montoBase INT = 0

			DECLARE @categoria VARCHAR(25) =  (SELECT categoria FROM Restaurantes WHERE nombre = @restaurante)
			DECLARE @indice INT = 0
			DECLARE @platilloActual VARCHAR(25)

			WHILE(LEN(@listaPlatillos) > 3)--hast que la string sea muy pequeña
					BEGIN
						SET @indice = CHARINDEX(',', @listaPlatillos, CHARINDEX('_', @listaPlatillos, 1) + 1)
						SET @platilloActual = SUBSTRING(@listaPlatillos, 0, @indice)
						SET @listaPlatillos = SUBSTRING(@listaPlatillos, @indice+1, LEN(@listaPlatillos))
						INSERT INTO LineasCompras (idCompra,nombrePlatillo)
							VALUES(@idCompra,@platilloActual)
						SET @montoBase = @montoBase + (SELECT precio FROM Platillos WHERE nombre = @platilloActual)

						--ahora debemos bajar en 1 cada ingrediente comprado
						UPDATE IngredientesCategorias 
							SET cantidad =  cantidad - 1
								FROM Ingredientes i, IngredientesPlatillos ip, IngredientesCategorias ic
									WHERE i.nombre = ip.nombreIngrediente AND
										  ip.nombrePlatillo = @platilloActual AND
										  ic.nombreCategoria = @categoria AND 
										  ic.nombreIngrediente =  i.nombre


					END
			
			
			DECLARE @montoTotal INT = 0
			if (@formaPago = 'efectivo')--10%
				BEGIN
					SET @montoTotal = @montoBase + (@montoBase * 0.10)
					--Hay que chequear si le apliacamos descuento de un 35%
					DECLARE @ventasUltimoMes INT = 0
					EXEC [dbo].[getCompraCliente] @correoCliente,@monto = @ventasUltimoMes OUTPUT
					IF(@ventasUltimoMes >= 20000)
						BEGIN
							--ahora hay que revisar si no se le aplico descuento hoy hace un mes
							DECLARE @mesPasado DATETIME = GETDATE() - 30
							IF EXISTS(SELECT 'true' FROM Clientes WHERE ISNULL(descuentoActual,@mesPasado - 1) < @mesPasado
									AND correoElectronico = @correoCliente) --para el caso de la primera compra
								BEGIN
									SET @montoTotal = @montoTotal - (@montoTotal * 0.35)	
									UPDATE Clientes
										SET descuentoActual =  GETDATE()	
											WHERE correoElectronico = @correoCliente

									INSERT INTO DescuentoClientes(correoCliente,fecha)
										VALUES(@correoCliente,GETDATE())
								END
						END
				END
			ELSE
				BEGIN
					SET @montoTotal = @montoBase + (@montoBase * 0.15)--15%
				END

			UPDATE Compras
				SET montoBase = @montoBase, montoTotal = @montoTotal
					WHERE id = @idCompra

		COMMIT TRAN 
	END TRY

	BEGIN CATCH
		ROLLBACK TRAN
		SELECT ERROR_NUMBER() AS ErrorNumber
		 ,ERROR_SEVERITY() AS ErrorSeverity
		 ,ERROR_STATE() AS ErrorState
		 ,ERROR_PROCEDURE() AS ErrorProcedure
		 ,ERROR_LINE() AS ErrorLine
		 ,ERROR_MESSAGE() AS ErrorMessage;
	END CATCH
END




GO
/****** Object:  StoredProcedure [dbo].[updateCliente]    Script Date: 11/16/2015 11:25:18 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[updateCliente]
	@correoElectronico VARCHAR(100),
	@nuevoCorreo VARCHAR(100) = NULL,
	@nombre VARCHAR(25) = NULL,
	@numeroTel INT = NULL,
	@cedula INT = NULL,
	@password VARCHAR(25) = NULL
AS
BEGIN
	
	SET NOCOUNT ON;



	DECLARE @error INT
    EXEC  @error = [dbo].[findCliente] @correoElectronico;
	IF (@error = 0) BEGIN RAISERROR(50010,16,1);RETURN END
	BEGIN TRAN
	--DECLARE @oldPassword VARCHAR(25) = (SELECT password FROM Clientes WHERE correoElectronico = @correoElectronico)


	BEGIN TRY
		--primero modificaremos en la tabla
		UPDATE Clientes
			SET correoElectronico = ISNULL(@nuevoCorreo,correoElectronico),
				nombre = ISNULL(@nombre,nombre),
				numeroTelefonico = ISNULL(@numeroTel,numeroTelefonico),
				cedula = ISNULL(@cedula,cedula),
				password = ISNULL(@password,password)
			WHERE correoElectronico = @correoElectronico

		/*IF (@nuevoCorreo IS NOT NULL)
			BEGIN
				--se debe cambiar el login
				DECLARE @SQLString2 NVARCHAR(500)
				SET @SQLString2 = 'ALTER LOGIN ' + quotename(@correoElectronico) + ' WITH NAME = ' + quotename(@nuevoCorreo)
				EXEC(@SQLString2)
				-- se debe cambiar el user
				DECLARE @SQLString3 NVARCHAR(500)
				SET @SQLString3 = 'ALTER USER ' + quotename(@correoElectronico) + ' WITH NAME = ' + quotename(@nuevoCorreo)
				EXEC(@SQLString3)
				SET @correoElectronico = @nuevoCorreo --el correo viejo ya no nos sirve si se necesita cambiar la password
			END
		IF (@password IS NOT NULL)
			BEGIN
				DECLARE @SQLString NVARCHAR(500)
				SET @SQLString = 'ALTER LOGIN ' + quotename(@correoElectronico) + ' WITH PASSWORD= ' + quotename(@password, '''') + ' OLD_PASSWORD= ' + quotename(@oldPassword, '''')
				EXEC(@SQLString)
			END*/

		COMMIT TRAN
	END TRY
	BEGIN CATCH
		 ROLLBACK TRAN
		 SELECT ERROR_NUMBER() AS ErrorNumber
		 ,ERROR_SEVERITY() AS ErrorSeverity
		 ,ERROR_STATE() AS ErrorState
		 ,ERROR_PROCEDURE() AS ErrorProcedure
		 ,ERROR_LINE() AS ErrorLine
		 ,ERROR_MESSAGE() AS ErrorMessage;
	END CATCH

END


GO
/****** Object:  StoredProcedure [dbo].[updateIngrediente]    Script Date: 11/16/2015 11:25:18 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[updateIngrediente]
	@nombre VARCHAR(25),--con este buscaremos el cliente
	@nombreNuevo VARCHAR(25) = NULL,
	@precio INT = NULL,
	@categoria VARCHAR(25) = NULL,
	@imagen VARCHAR(100) = NULL
	
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @error int;
	EXEC  @error = [dbo].[findIngrediente] @nombre;
	IF (@error = 0) BEGIN RAISERROR(50006,16,1);RETURN END

	IF(@nombreNuevo IS NOT NULL)
		BEGIN
			EXEC  @error = [dbo].[findIngrediente] @nombreNuevo;
			IF (@error = 1) BEGIN RAISERROR(50004,16,1);RETURN END
		END
	IF(@categoria IS NOT NULL)
		BEGIN
			EXEC  @error = [dbo].[findCategoriaIngrediente] @categoria;
			IF (@error = 0) BEGIN RAISERROR(50005,16,1);RETURN END
		END

    BEGIN TRAN
	BEGIN TRY
		UPDATE Ingredientes
			SET nombre = ISNULL(@nombreNuevo, nombre),
			    precio = ISNULL(@precio, precio),
				categoriaIngrediente = ISNULL(@categoria, categoriaIngrediente),
				imagen = ISNULL(@imagen, imagen)
			WHERE
				nombre = @nombre
		COMMIT TRAN
	END TRY

	BEGIN CATCH
		ROLLBACK TRAN
		SELECT ERROR_NUMBER() AS ErrorNumber
		 ,ERROR_SEVERITY() AS ErrorSeverity
		 ,ERROR_STATE() AS ErrorState
		 ,ERROR_PROCEDURE() AS ErrorProcedure
		 ,ERROR_LINE() AS ErrorLine
		 ,ERROR_MESSAGE() AS ErrorMessage;
	END CATCH
END



GO
/****** Object:  StoredProcedure [dbo].[updateUnidadesIngrediente]    Script Date: 11/16/2015 11:25:18 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[updateUnidadesIngrediente]
	--cambia las unidades asociadas a un ingrediente de un restaurante en particular
	@nombreIngrediente VARCHAR(25),
	@nombreCategoria VARCHAR(25),
	@cantidad INT
AS
BEGIN
	
	SET NOCOUNT ON;

	DECLARE @error int;
	EXEC  @error = [dbo].[findIngrediente] @nombreIngrediente;
	IF (@error = 0) BEGIN RAISERROR(50006,16,1);RETURN END
	EXEC  @error = [dbo].[findCategoriaRestaurante] @nombreCategoria;
	IF (@error = 0) BEGIN RAISERROR(50002,16,1);RETURN END


    BEGIN TRAN

	BEGIN TRY
		UPDATE IngredientesCategorias
			SET cantidad = @cantidad
				WHERE NombreIngrediente = @nombreIngrediente AND @nombreCategoria = nombreCategoria
		COMMIT TRAN 
	END TRY

	BEGIN CATCH
		ROLLBACK TRAN
		SELECT ERROR_NUMBER() AS ErrorNumber
		 ,ERROR_SEVERITY() AS ErrorSeverity
		 ,ERROR_STATE() AS ErrorState
		 ,ERROR_PROCEDURE() AS ErrorProcedure
		 ,ERROR_LINE() AS ErrorLine
		 ,ERROR_MESSAGE() AS ErrorMessage;
	END CATCH
END



GO
/****** Object:  StoredProcedure [dbo].[validateAdministrador]    Script Date: 11/16/2015 11:25:18 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[validateAdministrador]
	@username VARCHAR(25),
	@password VARCHAR(25)
AS
BEGIN

	SET NOCOUNT ON;

	IF EXISTS (SELECT 'True' FROM Administradores WHERE nombre = @username AND 
												 password = @password)
		BEGIN
			RETURN 1
		END
	RETURN 0
END


GO
/****** Object:  StoredProcedure [dbo].[validateCliente]    Script Date: 11/16/2015 11:25:18 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[validateCliente]
	@correoElectronico VARCHAR(100),
	@password VARCHAR(25)
AS
BEGIN
	
	SET NOCOUNT ON;

    IF EXISTS (SELECT 'True' FROM Clientes WHERE correoElectronico = @correoElectronico AND 
												 password = @password)
		BEGIN
			RETURN 1
		END
	RETURN 0
END


GO
USE [master]
GO
ALTER DATABASE [RESTAURANTES] SET  READ_WRITE 
GO
