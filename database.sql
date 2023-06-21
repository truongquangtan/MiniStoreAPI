USE [master]
GO
/****** Object:  Database [MiniStore1]    Script Date: 6/19/2023 10:07:43 PM ******/
CREATE DATABASE [MiniStore1]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'MiniStore1', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\MiniStore1.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'MiniStore1_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\MiniStore1_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT, LEDGER = OFF
GO
ALTER DATABASE [MiniStore1] SET COMPATIBILITY_LEVEL = 160
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [MiniStore1].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [MiniStore1] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [MiniStore1] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [MiniStore1] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [MiniStore1] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [MiniStore1] SET ARITHABORT OFF 
GO
ALTER DATABASE [MiniStore1] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [MiniStore1] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [MiniStore1] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [MiniStore1] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [MiniStore1] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [MiniStore1] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [MiniStore1] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [MiniStore1] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [MiniStore1] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [MiniStore1] SET  ENABLE_BROKER 
GO
ALTER DATABASE [MiniStore1] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [MiniStore1] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [MiniStore1] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [MiniStore1] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [MiniStore1] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [MiniStore1] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [MiniStore1] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [MiniStore1] SET RECOVERY FULL 
GO
ALTER DATABASE [MiniStore1] SET  MULTI_USER 
GO
ALTER DATABASE [MiniStore1] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [MiniStore1] SET DB_CHAINING OFF 
GO
ALTER DATABASE [MiniStore1] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [MiniStore1] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [MiniStore1] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [MiniStore1] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'MiniStore1', N'ON'
GO
ALTER DATABASE [MiniStore1] SET QUERY_STORE = ON
GO
ALTER DATABASE [MiniStore1] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 1000, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
GO
USE [MiniStore1]
GO
/****** Object:  Table [dbo].[Category]    Script Date: 6/19/2023 10:07:43 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Category](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[name] [nvarchar](200) NOT NULL,
	[is_deleted] [bit] NOT NULL,
 CONSTRAINT [PK_Category] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Order]    Script Date: 6/19/2023 10:07:43 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Order](
	[id] [varchar](50) NOT NULL,
	[user_id] [varchar](50) NOT NULL,
	[amount] [money] NOT NULL,
	[created_at] [datetime] NOT NULL,
	[status] [nvarchar](50) NOT NULL,
	[payment] [varchar](50) NOT NULL,
 CONSTRAINT [PK_Order] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[OrderDetail]    Script Date: 6/19/2023 10:07:43 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OrderDetail](
	[id] [varchar](50) NOT NULL,
	[order_id] [varchar](50) NOT NULL,
	[product_id] [int] NOT NULL,
	[quantity] [int] NOT NULL,
	[price] [money] NOT NULL,
 CONSTRAINT [PK_OrderDetail] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Product]    Script Date: 6/19/2023 10:07:43 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Product](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[name] [nvarchar](200) NOT NULL,
	[price] [money] NOT NULL,
	[quantity] [int] NOT NULL,
	[created_at] [datetime] NOT NULL,
	[last_updated_at] [datetime] NOT NULL,
	[source] [nvarchar](200) NULL,
	[categoryId] [int] NOT NULL,
	[is_active] [bit] NOT NULL,
	[is_deleted] [bit] NOT NULL,
	[description] [text] NULL,
 CONSTRAINT [PK_Product] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ProductImage]    Script Date: 6/19/2023 10:07:43 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ProductImage](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[product_id] [int] NOT NULL,
	[image] [varchar](max) NOT NULL,
 CONSTRAINT [PK_ProductImage] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Role]    Script Date: 6/19/2023 10:07:43 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Role](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[name] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_Role] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TimeSheet]    Script Date: 6/19/2023 10:07:43 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TimeSheet](
	[id] [varchar](50) NOT NULL,
	[role_id] [int] NOT NULL,
	[time_range] [varchar](50) NOT NULL,
	[is_active] [bit] NOT NULL,
	[name] [nvarchar](50) NULL,
 CONSTRAINT [PK_TimeSheet] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TimeSheetCheck]    Script Date: 6/19/2023 10:07:43 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TimeSheetCheck](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[time_sheet_registration_id] [varchar](50) NOT NULL,
	[user_id] [varchar](50) NOT NULL,
	[checked_at] [datetime] NOT NULL,
	[coefficient_amount] [decimal](2, 1) NOT NULL,
	[note] [text] NULL,
 CONSTRAINT [PK_TimeSheetCheck] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TimeSheetRegistration]    Script Date: 6/19/2023 10:07:43 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TimeSheetRegistration](
	[id] [varchar](50) NOT NULL,
	[user_id] [varchar](50) NOT NULL,
	[time_sheet_id] [varchar](50) NOT NULL,
	[created_at] [datetime] NOT NULL,
	[date] [date] NULL,
 CONSTRAINT [PK_TimeSheetRegistration] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TimeSheetRegistrationReference]    Script Date: 6/19/2023 10:07:43 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TimeSheetRegistrationReference](
	[id] [varchar](50) NOT NULL,
	[user_id] [varchar](50) NOT NULL,
	[date] [date] NOT NULL,
	[created_at] [datetime] NOT NULL,
	[time_sheet_id] [varchar](50) NOT NULL,
 CONSTRAINT [PK_TimeSheetRegistrationReference] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[User]    Script Date: 6/19/2023 10:07:43 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[User](
	[id] [varchar](50) NOT NULL,
	[fullname] [varchar](200) NOT NULL,
	[email] [varchar](200) NOT NULL,
	[password] [varchar](max) NOT NULL,
	[phone] [varchar](15) NOT NULL,
	[avatar] [varchar](max) NULL,
	[address] [varchar](200) NULL,
	[DOB] [date] NULL,
	[created_at] [datetime] NOT NULL,
	[amount_selled] [money] NULL,
	[is_active] [bit] NOT NULL,
	[is_deleted] [bit] NOT NULL,
	[is_confirmed] [bit] NOT NULL,
	[token] [varchar](max) NULL,
	[is_logout] [bit] NOT NULL,
	[role_id] [int] NULL,
	[salary] [money] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[email] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE [dbo].[User] ADD  DEFAULT ((1)) FOR [is_logout]
GO
ALTER TABLE [dbo].[Order]  WITH CHECK ADD  CONSTRAINT [FK_Order_User] FOREIGN KEY([user_id])
REFERENCES [dbo].[User] ([id])
GO
ALTER TABLE [dbo].[Order] CHECK CONSTRAINT [FK_Order_User]
GO
ALTER TABLE [dbo].[OrderDetail]  WITH CHECK ADD  CONSTRAINT [FK_OrderDetail_Order] FOREIGN KEY([order_id])
REFERENCES [dbo].[Order] ([id])
GO
ALTER TABLE [dbo].[OrderDetail] CHECK CONSTRAINT [FK_OrderDetail_Order]
GO
ALTER TABLE [dbo].[OrderDetail]  WITH CHECK ADD  CONSTRAINT [FK_OrderDetail_Product] FOREIGN KEY([product_id])
REFERENCES [dbo].[Product] ([id])
GO
ALTER TABLE [dbo].[OrderDetail] CHECK CONSTRAINT [FK_OrderDetail_Product]
GO
ALTER TABLE [dbo].[Product]  WITH CHECK ADD  CONSTRAINT [FK_Product_Category] FOREIGN KEY([categoryId])
REFERENCES [dbo].[Category] ([id])
GO
ALTER TABLE [dbo].[Product] CHECK CONSTRAINT [FK_Product_Category]
GO
ALTER TABLE [dbo].[ProductImage]  WITH CHECK ADD  CONSTRAINT [FK_ProductImage_Product] FOREIGN KEY([product_id])
REFERENCES [dbo].[Product] ([id])
GO
ALTER TABLE [dbo].[ProductImage] CHECK CONSTRAINT [FK_ProductImage_Product]
GO
ALTER TABLE [dbo].[TimeSheet]  WITH CHECK ADD  CONSTRAINT [FK_TimeSheet_Role] FOREIGN KEY([role_id])
REFERENCES [dbo].[Role] ([id])
GO
ALTER TABLE [dbo].[TimeSheet] CHECK CONSTRAINT [FK_TimeSheet_Role]
GO
ALTER TABLE [dbo].[TimeSheetCheck]  WITH CHECK ADD  CONSTRAINT [FK_TimeSheetCheck_TimeSheetRegistration] FOREIGN KEY([time_sheet_registration_id])
REFERENCES [dbo].[TimeSheetRegistration] ([id])
GO
ALTER TABLE [dbo].[TimeSheetCheck] CHECK CONSTRAINT [FK_TimeSheetCheck_TimeSheetRegistration]
GO
ALTER TABLE [dbo].[TimeSheetRegistration]  WITH CHECK ADD  CONSTRAINT [FK_TimeSheetRegistration_TimeSheet] FOREIGN KEY([time_sheet_id])
REFERENCES [dbo].[TimeSheet] ([id])
GO
ALTER TABLE [dbo].[TimeSheetRegistration] CHECK CONSTRAINT [FK_TimeSheetRegistration_TimeSheet]
GO
ALTER TABLE [dbo].[TimeSheetRegistration]  WITH CHECK ADD  CONSTRAINT [FK_TimeSheetRegistration_User] FOREIGN KEY([user_id])
REFERENCES [dbo].[User] ([id])
GO
ALTER TABLE [dbo].[TimeSheetRegistration] CHECK CONSTRAINT [FK_TimeSheetRegistration_User]
GO
ALTER TABLE [dbo].[TimeSheetRegistrationReference]  WITH CHECK ADD  CONSTRAINT [FK_TimeSheetRegistrationReference_TimeSheet] FOREIGN KEY([time_sheet_id])
REFERENCES [dbo].[TimeSheet] ([id])
GO
ALTER TABLE [dbo].[TimeSheetRegistrationReference] CHECK CONSTRAINT [FK_TimeSheetRegistrationReference_TimeSheet]
GO
ALTER TABLE [dbo].[TimeSheetRegistrationReference]  WITH CHECK ADD  CONSTRAINT [FK_TimeSheetRegistrationReference_User] FOREIGN KEY([user_id])
REFERENCES [dbo].[User] ([id])
GO
ALTER TABLE [dbo].[TimeSheetRegistrationReference] CHECK CONSTRAINT [FK_TimeSheetRegistrationReference_User]
GO
ALTER TABLE [dbo].[User]  WITH CHECK ADD FOREIGN KEY([role_id])
REFERENCES [dbo].[Role] ([id])
GO
USE [master]
GO
ALTER DATABASE [MiniStore1] SET  READ_WRITE 
GO
