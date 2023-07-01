USE [master]
GO
/****** Object:  Database [MiniStore1]    Script Date: 7/1/2023 8:16:32 AM ******/
CREATE DATABASE [MiniStore]
GO

USE [MiniStore]
GO
/****** Object:  Table [dbo].[Category]    Script Date: 7/1/2023 8:25:48 AM ******/
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
/****** Object:  Table [dbo].[Order]    Script Date: 7/1/2023 8:25:48 AM ******/
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
/****** Object:  Table [dbo].[OrderDetail]    Script Date: 7/1/2023 8:25:48 AM ******/
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
/****** Object:  Table [dbo].[Product]    Script Date: 7/1/2023 8:25:48 AM ******/
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
/****** Object:  Table [dbo].[ProductImage]    Script Date: 7/1/2023 8:25:48 AM ******/
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
/****** Object:  Table [dbo].[Role]    Script Date: 7/1/2023 8:25:48 AM ******/
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
/****** Object:  Table [dbo].[TimeSheet]    Script Date: 7/1/2023 8:25:48 AM ******/
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
	[coefficient_amount] [decimal](2, 1) NULL,
 CONSTRAINT [PK_TimeSheet] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TimeSheetCheck]    Script Date: 7/1/2023 8:25:48 AM ******/
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
/****** Object:  Table [dbo].[TimeSheetRegistration]    Script Date: 7/1/2023 8:25:48 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TimeSheetRegistration](
	[id] [varchar](50) NOT NULL,
	[user_id] [varchar](50) NOT NULL,
	[time_sheet_id] [varchar](50) NOT NULL,
	[created_at] [datetime] NOT NULL,
	[salary] [money] NOT NULL,
	[date] [datetime] NULL,
 CONSTRAINT [PK_TimeSheetRegistration] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TimeSheetRegistrationReference]    Script Date: 7/1/2023 8:25:48 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TimeSheetRegistrationReference](
	[id] [varchar](50) NOT NULL,
	[user_id] [varchar](50) NOT NULL,
	[created_at] [datetime] NOT NULL,
	[time_sheet_id] [varchar](50) NOT NULL,
	[date] [datetime] NULL,
 CONSTRAINT [PK_TimeSheetRegistrationReference] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[User]    Script Date: 7/1/2023 8:25:48 AM ******/
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
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Category] ON 

INSERT [dbo].[Category] ([id], [name], [is_deleted]) VALUES (1, N'milk', 0)
INSERT [dbo].[Category] ([id], [name], [is_deleted]) VALUES (2, N'Candies', 1)
INSERT [dbo].[Category] ([id], [name], [is_deleted]) VALUES (3, N'drink', 0)
INSERT [dbo].[Category] ([id], [name], [is_deleted]) VALUES (4, N'food', 0)
SET IDENTITY_INSERT [dbo].[Category] OFF
GO
INSERT [dbo].[Order] ([id], [user_id], [amount], [created_at], [status], [payment]) VALUES (N'0e5497e3-ffe7-4dd1-80ad-5ed5c1c2940a', N'9672d446-ee4e-4287-893c-0da04dbd1bec', 150000.0000, CAST(N'2023-06-09T16:46:49.290' AS DateTime), N'CREATED', N'CREDIT')
INSERT [dbo].[Order] ([id], [user_id], [amount], [created_at], [status], [payment]) VALUES (N'34ca1dc8-7c52-4ccb-9cb6-95681a72afde', N'9672d446-ee4e-4287-893c-0da04dbd1bec', 150000.0000, CAST(N'2023-06-09T16:45:35.193' AS DateTime), N'CREATED', N'CREDIT')
GO
INSERT [dbo].[OrderDetail] ([id], [order_id], [product_id], [quantity], [price]) VALUES (N'0b652fdb-3707-4c66-901c-09b7a1535506', N'34ca1dc8-7c52-4ccb-9cb6-95681a72afde', 5, 10, 50000.0000)
INSERT [dbo].[OrderDetail] ([id], [order_id], [product_id], [quantity], [price]) VALUES (N'5d81fe85-f906-41d1-a329-c513730d4309', N'0e5497e3-ffe7-4dd1-80ad-5ed5c1c2940a', 5, 10, 50000.0000)
GO
SET IDENTITY_INSERT [dbo].[Product] ON 

INSERT [dbo].[Product] ([id], [name], [price], [quantity], [created_at], [last_updated_at], [source], [categoryId], [is_active], [is_deleted], [description]) VALUES (1, N'string', 30000.0000, 90, CAST(N'2023-06-08T15:14:12.677' AS DateTime), CAST(N'2023-06-08T15:14:12.677' AS DateTime), N'string1', 1, 1, 1, N'string')
INSERT [dbo].[Product] ([id], [name], [price], [quantity], [created_at], [last_updated_at], [source], [categoryId], [is_active], [is_deleted], [description]) VALUES (2, N'Product 0002', 70000.0000, 70, CAST(N'2023-06-08T15:21:19.883' AS DateTime), CAST(N'2023-06-08T15:21:19.883' AS DateTime), N'FLC', 1, 1, 0, N'This is special product')
INSERT [dbo].[Product] ([id], [name], [price], [quantity], [created_at], [last_updated_at], [source], [categoryId], [is_active], [is_deleted], [description]) VALUES (3, N'Drink 001', 20000.0000, 10, CAST(N'2023-06-09T15:54:09.433' AS DateTime), CAST(N'2023-06-09T15:54:09.433' AS DateTime), N'Vietnam', 3, 1, 0, N'The description')
INSERT [dbo].[Product] ([id], [name], [price], [quantity], [created_at], [last_updated_at], [source], [categoryId], [is_active], [is_deleted], [description]) VALUES (4, N'Drink 002', 30000.0000, 20, CAST(N'2023-06-09T15:54:30.927' AS DateTime), CAST(N'2023-06-09T15:54:30.927' AS DateTime), N'Vietnam', 3, 1, 0, N'The description')
INSERT [dbo].[Product] ([id], [name], [price], [quantity], [created_at], [last_updated_at], [source], [categoryId], [is_active], [is_deleted], [description]) VALUES (5, N'Food 001', 30000.0000, 0, CAST(N'2023-06-09T15:54:44.073' AS DateTime), CAST(N'2023-06-09T15:54:44.073' AS DateTime), N'Vietnam', 4, 1, 0, N'The description')
INSERT [dbo].[Product] ([id], [name], [price], [quantity], [created_at], [last_updated_at], [source], [categoryId], [is_active], [is_deleted], [description]) VALUES (1002, N'NewPrd11', 50.0000, 500, CAST(N'2023-06-22T22:49:22.450' AS DateTime), CAST(N'2023-06-22T22:49:22.450' AS DateTime), N's', 1, 1, 0, N'd')
SET IDENTITY_INSERT [dbo].[Product] OFF
GO
SET IDENTITY_INSERT [dbo].[ProductImage] ON 

INSERT [dbo].[ProductImage] ([id], [product_id], [image]) VALUES (1, 1, N'string')
INSERT [dbo].[ProductImage] ([id], [product_id], [image]) VALUES (2, 1, N'https://firebasestorage.googleapis.com/v0/b/ministoregrprjprn231.appspot.com/o/default-avatar.jpg?alt=media&token=2802e58e-14c1-4dc6-9b0e-39bf9b00ed28&_gl=1*kbn4ak*_ga*MTE4OTYyNDIwMC4xNjg1MjgzNjU3*_ga_CW55HF8NVT*MTY4NjIzNzM2Ni41LjEuMTY4NjIzNzM4Mi4wLjAuMA..')
INSERT [dbo].[ProductImage] ([id], [product_id], [image]) VALUES (5, 2, N'https://firebasestorage.googleapis.com/v0/b/ministoregrprjprn231.appspot.com/o/Truong%20Quang%20T%C3%A2n-14e614af-5f60-415c-8397-a6dc8f028e8b?alt=media&token=d96dd647-3a8d-4cdf-9622-fcfbaa685cdb&_gl=1*tgdwmv*_ga*MTE4OTYyNDIwMC4xNjg1MjgzNjU3*_ga_CW55HF8NVT*MTY4NjIzNzM2Ni41LjEuMTY4NjIzNzc2MC4wLjAuMA..')
INSERT [dbo].[ProductImage] ([id], [product_id], [image]) VALUES (6, 3, N'https://firebasestorage.googleapis.com/v0/b/ministoregrprjprn231.appspot.com/o/Truong%20Quang%20T%C3%A2n-14e614af-5f60-415c-8397-a6dc8f028e8b?alt=media&token=d96dd647-3a8d-4cdf-9622-fcfbaa685cdb&_gl=1*tgdwmv*_ga*MTE4OTYyNDIwMC4xNjg1MjgzNjU3*_ga_CW55HF8NVT*MTY4NjIzNzM2Ni41LjEuMTY4NjIzNzc2MC4wLjAuMA..')
INSERT [dbo].[ProductImage] ([id], [product_id], [image]) VALUES (7, 4, N'https://firebasestorage.googleapis.com/v0/b/ministoregrprjprn231.appspot.com/o/Truong%20Quang%20T%C3%A2n-14e614af-5f60-415c-8397-a6dc8f028e8b?alt=media&token=d96dd647-3a8d-4cdf-9622-fcfbaa685cdb&_gl=1*tgdwmv*_ga*MTE4OTYyNDIwMC4xNjg1MjgzNjU3*_ga_CW55HF8NVT*MTY4NjIzNzM2Ni41LjEuMTY4NjIzNzc2MC4wLjAuMA..')
INSERT [dbo].[ProductImage] ([id], [product_id], [image]) VALUES (8, 5, N'https://firebasestorage.googleapis.com/v0/b/ministoregrprjprn231.appspot.com/o/Truong%20Quang%20T%C3%A2n-14e614af-5f60-415c-8397-a6dc8f028e8b?alt=media&token=d96dd647-3a8d-4cdf-9622-fcfbaa685cdb&_gl=1*tgdwmv*_ga*MTE4OTYyNDIwMC4xNjg1MjgzNjU3*_ga_CW55HF8NVT*MTY4NjIzNzM2Ni41LjEuMTY4NjIzNzc2MC4wLjAuMA..')
INSERT [dbo].[ProductImage] ([id], [product_id], [image]) VALUES (1013, 1002, N'https://firebasestorage.googleapis.com/v0/b/ministoregrprjprn231.appspot.com/o/NewPrd11%20cbeaebc8-fded-4041-a4ea-2d466ba6e036?alt=media&token=9fd09abb-3c3e-4fb2-b985-036bf9d4fa1e')
SET IDENTITY_INSERT [dbo].[ProductImage] OFF
GO
SET IDENTITY_INSERT [dbo].[Role] ON 

INSERT [dbo].[Role] ([id], [name]) VALUES (1, N'Manager')
INSERT [dbo].[Role] ([id], [name]) VALUES (2, N'Sales')
INSERT [dbo].[Role] ([id], [name]) VALUES (3, N'Guard')
SET IDENTITY_INSERT [dbo].[Role] OFF
GO
INSERT [dbo].[TimeSheet] ([id], [role_id], [time_range], [is_active], [name], [coefficient_amount]) VALUES (N'4c44b4ba-c746-42b7-bd73-b3b17a9377c8', 3, N'00:00-12:00', 0, N'Ca sáng', CAST(1.0 AS Decimal(2, 1)))
INSERT [dbo].[TimeSheet] ([id], [role_id], [time_range], [is_active], [name], [coefficient_amount]) VALUES (N'627bca55-7e3c-461c-b685-3fa82d7b730a', 3, N'06:00-12:00', 1, N'Ca trưa', CAST(1.0 AS Decimal(2, 1)))
INSERT [dbo].[TimeSheet] ([id], [role_id], [time_range], [is_active], [name], [coefficient_amount]) VALUES (N'688f1fbb-2f08-4ce9-8f1d-b9bb4124f598', 2, N'00:00-06:00', 0, N'Ca sáng', CAST(1.0 AS Decimal(2, 1)))
INSERT [dbo].[TimeSheet] ([id], [role_id], [time_range], [is_active], [name], [coefficient_amount]) VALUES (N'690f7940-6c9c-413d-a27d-afc1cd70fd4a', 3, N'06:00-00:00', 1, N'Ca chiều', CAST(1.0 AS Decimal(2, 1)))
INSERT [dbo].[TimeSheet] ([id], [role_id], [time_range], [is_active], [name], [coefficient_amount]) VALUES (N'9106fecf-1b0f-4916-8404-ea235fec961a', 3, N'06:00-00:00', 0, N'Ca trưa', CAST(1.0 AS Decimal(2, 1)))
INSERT [dbo].[TimeSheet] ([id], [role_id], [time_range], [is_active], [name], [coefficient_amount]) VALUES (N'98a1ee44-2d1d-466f-8539-e6a7738bf237', 2, N'02:00-08:00', 1, N'Ca hybrid', CAST(1.0 AS Decimal(2, 1)))
INSERT [dbo].[TimeSheet] ([id], [role_id], [time_range], [is_active], [name], [coefficient_amount]) VALUES (N'a9a4ab45-0ef3-4d4c-96e7-f28adda26fc6', 3, N'12:00-00:00', 1, N'Ca tối', CAST(1.0 AS Decimal(2, 1)))
INSERT [dbo].[TimeSheet] ([id], [role_id], [time_range], [is_active], [name], [coefficient_amount]) VALUES (N'abff4e43-5c5c-43b6-a656-890b3c27e6be', 2, N'12:00-15:00', 1, N'Ca chiều', CAST(1.0 AS Decimal(2, 1)))
INSERT [dbo].[TimeSheet] ([id], [role_id], [time_range], [is_active], [name], [coefficient_amount]) VALUES (N'af827ca3-0ebe-45e0-af5f-db0fe371fc2b', 2, N'20:00-02:00', 1, N'Ca khuya', CAST(1.0 AS Decimal(2, 1)))
INSERT [dbo].[TimeSheet] ([id], [role_id], [time_range], [is_active], [name], [coefficient_amount]) VALUES (N'b3029d67-c5eb-4b60-a7f2-1c046ddde8e8', 3, N'00:00-06:00', 0, N'Ca sáng', CAST(1.0 AS Decimal(2, 1)))
INSERT [dbo].[TimeSheet] ([id], [role_id], [time_range], [is_active], [name], [coefficient_amount]) VALUES (N'c209c06d-f610-4756-bb38-6cd97a3df42f', 2, N'01:01-14:01', 0, N'aaaa', CAST(1.0 AS Decimal(2, 1)))
INSERT [dbo].[TimeSheet] ([id], [role_id], [time_range], [is_active], [name], [coefficient_amount]) VALUES (N'c84ef420-ae31-415b-a169-fcc5b0c1ad7f', 2, N'16:00-22:00', 1, N'Ca tối', CAST(1.0 AS Decimal(2, 1)))
INSERT [dbo].[TimeSheet] ([id], [role_id], [time_range], [is_active], [name], [coefficient_amount]) VALUES (N'fd68b9e3-91df-43da-b045-d40807a2c7d4', 2, N'00:00-06:00', 1, N'Ca sáng', CAST(1.0 AS Decimal(2, 1)))
GO
INSERT [dbo].[TimeSheetRegistration] ([id], [user_id], [time_sheet_id], [created_at], [salary], [date]) VALUES (N'3a9240c2-ba7d-4b19-93ff-55867262169e', N'65908cb9-890a-47f0-b9a2-4ebf12aad132', N'abff4e43-5c5c-43b6-a656-890b3c27e6be', CAST(N'2023-06-29T18:39:16.263' AS DateTime), 25000.0000, CAST(N'2023-07-04T00:00:00.000' AS DateTime))
INSERT [dbo].[TimeSheetRegistration] ([id], [user_id], [time_sheet_id], [created_at], [salary], [date]) VALUES (N'446c17a6-e42b-4590-be72-94bd485d2505', N'9672d446-ee4e-4287-893c-0da04dbd1bec', N'690f7940-6c9c-413d-a27d-afc1cd70fd4a', CAST(N'2023-06-29T16:21:42.533' AS DateTime), 25000.0000, CAST(N'2023-07-01T00:00:00.000' AS DateTime))
INSERT [dbo].[TimeSheetRegistration] ([id], [user_id], [time_sheet_id], [created_at], [salary], [date]) VALUES (N'61f9212b-445c-451f-9b1c-2f6e17d89493', N'520e3b7a-0efc-4ec0-b38c-5fcb1825d7e4', N'690f7940-6c9c-413d-a27d-afc1cd70fd4a', CAST(N'2023-07-01T08:04:50.033' AS DateTime), 25000.0000, CAST(N'2023-07-02T00:00:00.000' AS DateTime))
INSERT [dbo].[TimeSheetRegistration] ([id], [user_id], [time_sheet_id], [created_at], [salary], [date]) VALUES (N'883fae02-696a-4d4e-834d-26f3c4c55adc', N'520e3b7a-0efc-4ec0-b38c-5fcb1825d7e4', N'690f7940-6c9c-413d-a27d-afc1cd70fd4a', CAST(N'2023-06-29T16:21:42.533' AS DateTime), 25000.0000, CAST(N'2023-07-01T00:00:00.000' AS DateTime))
INSERT [dbo].[TimeSheetRegistration] ([id], [user_id], [time_sheet_id], [created_at], [salary], [date]) VALUES (N'a0f80e74-b8c8-4562-8dba-d86b8cb946b8', N'520e3b7a-0efc-4ec0-b38c-5fcb1825d7e4', N'690f7940-6c9c-413d-a27d-afc1cd70fd4a', CAST(N'2023-07-01T08:05:06.773' AS DateTime), 25000.0000, CAST(N'2023-07-03T00:00:00.000' AS DateTime))
INSERT [dbo].[TimeSheetRegistration] ([id], [user_id], [time_sheet_id], [created_at], [salary], [date]) VALUES (N'd887a7db-8ff7-4a9f-889e-d166c98d8ec2', N'c74b7811-1771-466c-a777-39b01129a211', N'abff4e43-5c5c-43b6-a656-890b3c27e6be', CAST(N'2023-06-29T18:39:16.263' AS DateTime), 25000.0000, CAST(N'2023-07-04T00:00:00.000' AS DateTime))
INSERT [dbo].[TimeSheetRegistration] ([id], [user_id], [time_sheet_id], [created_at], [salary], [date]) VALUES (N'ec2f659e-ef1a-4d74-827d-1bc4f7928002', N'65908cb9-890a-47f0-b9a2-4ebf12aad132', N'98a1ee44-2d1d-466f-8539-e6a7738bf237', CAST(N'2023-06-30T16:14:36.283' AS DateTime), 25000.0000, CAST(N'2023-07-04T00:00:00.000' AS DateTime))
INSERT [dbo].[TimeSheetRegistration] ([id], [user_id], [time_sheet_id], [created_at], [salary], [date]) VALUES (N'fbb9acd3-733d-450b-987d-51eb95fa83cc', N'f88c8736-cd4a-4664-bb73-7acb00c20822', N'98a1ee44-2d1d-466f-8539-e6a7738bf237', CAST(N'2023-06-29T15:45:38.763' AS DateTime), 25000.0000, CAST(N'2023-07-04T00:00:00.000' AS DateTime))
INSERT [dbo].[TimeSheetRegistration] ([id], [user_id], [time_sheet_id], [created_at], [salary], [date]) VALUES (N'fedc9c05-a331-4fd5-90fa-3b01822ca8ca', N'9672d446-ee4e-4287-893c-0da04dbd1bec', N'690f7940-6c9c-413d-a27d-afc1cd70fd4a', CAST(N'2023-07-01T08:05:06.773' AS DateTime), 25000.0000, CAST(N'2023-07-03T00:00:00.000' AS DateTime))
GO
INSERT [dbo].[TimeSheetRegistrationReference] ([id], [user_id], [created_at], [time_sheet_id], [date]) VALUES (N'00d89e54-661f-4dbc-949a-3c1ec34a7e62', N'520e3b7a-0efc-4ec0-b38c-5fcb1825d7e4', CAST(N'2023-06-29T02:47:46.277' AS DateTime), N'690f7940-6c9c-413d-a27d-afc1cd70fd4a', CAST(N'2023-07-01T00:00:00.000' AS DateTime))
INSERT [dbo].[TimeSheetRegistrationReference] ([id], [user_id], [created_at], [time_sheet_id], [date]) VALUES (N'0bccc9c2-cb69-46c6-a69f-f454199a75b3', N'f88c8736-cd4a-4664-bb73-7acb00c20822', CAST(N'2023-06-27T20:45:49.597' AS DateTime), N'98a1ee44-2d1d-466f-8539-e6a7738bf237', CAST(N'2023-06-30T00:00:00.000' AS DateTime))
INSERT [dbo].[TimeSheetRegistrationReference] ([id], [user_id], [created_at], [time_sheet_id], [date]) VALUES (N'0cdf1a19-22dd-463d-826c-1edb223c4aa4', N'9672d446-ee4e-4287-893c-0da04dbd1bec', CAST(N'2023-06-28T00:54:24.820' AS DateTime), N'627bca55-7e3c-461c-b685-3fa82d7b730a', CAST(N'2023-06-29T00:00:00.000' AS DateTime))
INSERT [dbo].[TimeSheetRegistrationReference] ([id], [user_id], [created_at], [time_sheet_id], [date]) VALUES (N'17fe1773-9bbd-481b-b43d-fee5ab088e39', N'520e3b7a-0efc-4ec0-b38c-5fcb1825d7e4', CAST(N'2023-06-29T02:49:42.550' AS DateTime), N'690f7940-6c9c-413d-a27d-afc1cd70fd4a', CAST(N'2023-07-11T00:00:00.000' AS DateTime))
INSERT [dbo].[TimeSheetRegistrationReference] ([id], [user_id], [created_at], [time_sheet_id], [date]) VALUES (N'2de1b820-fd2e-4b48-bd9a-ad1d8fd5b7f0', N'520e3b7a-0efc-4ec0-b38c-5fcb1825d7e4', CAST(N'2023-06-29T02:50:19.727' AS DateTime), N'627bca55-7e3c-461c-b685-3fa82d7b730a', CAST(N'2023-07-07T00:00:00.000' AS DateTime))
INSERT [dbo].[TimeSheetRegistrationReference] ([id], [user_id], [created_at], [time_sheet_id], [date]) VALUES (N'3df96011-3e30-4b10-9f3d-92b1d8d457ee', N'f88c8736-cd4a-4664-bb73-7acb00c20822', CAST(N'2023-06-27T20:49:56.067' AS DateTime), N'abff4e43-5c5c-43b6-a656-890b3c27e6be', CAST(N'2023-07-04T00:00:00.000' AS DateTime))
INSERT [dbo].[TimeSheetRegistrationReference] ([id], [user_id], [created_at], [time_sheet_id], [date]) VALUES (N'42f4573f-9299-40eb-960e-ec5253e765b6', N'f88c8736-cd4a-4664-bb73-7acb00c20822', CAST(N'2023-06-27T20:45:49.597' AS DateTime), N'abff4e43-5c5c-43b6-a656-890b3c27e6be', CAST(N'2023-06-29T00:00:00.000' AS DateTime))
INSERT [dbo].[TimeSheetRegistrationReference] ([id], [user_id], [created_at], [time_sheet_id], [date]) VALUES (N'4370b04f-aaaf-4d10-9c3e-dd1ba1d16862', N'f88c8736-cd4a-4664-bb73-7acb00c20822', CAST(N'2023-06-27T20:48:20.260' AS DateTime), N'c84ef420-ae31-415b-a169-fcc5b0c1ad7f', CAST(N'2023-06-30T00:00:00.000' AS DateTime))
INSERT [dbo].[TimeSheetRegistrationReference] ([id], [user_id], [created_at], [time_sheet_id], [date]) VALUES (N'45e1cac8-2cc3-4aea-a52c-3ca1cdc428cf', N'9672d446-ee4e-4287-893c-0da04dbd1bec', CAST(N'2023-06-28T00:54:29.667' AS DateTime), N'627bca55-7e3c-461c-b685-3fa82d7b730a', CAST(N'2023-07-02T00:00:00.000' AS DateTime))
INSERT [dbo].[TimeSheetRegistrationReference] ([id], [user_id], [created_at], [time_sheet_id], [date]) VALUES (N'46a65021-603c-418d-9fc0-a64f0024e435', N'520e3b7a-0efc-4ec0-b38c-5fcb1825d7e4', CAST(N'2023-06-29T02:49:42.550' AS DateTime), N'627bca55-7e3c-461c-b685-3fa82d7b730a', CAST(N'2023-07-01T00:00:00.000' AS DateTime))
INSERT [dbo].[TimeSheetRegistrationReference] ([id], [user_id], [created_at], [time_sheet_id], [date]) VALUES (N'48b0cfee-b1c0-47fd-bd2a-8bcafbd51a7a', N'520e3b7a-0efc-4ec0-b38c-5fcb1825d7e4', CAST(N'2023-06-29T11:17:53.447' AS DateTime), N'690f7940-6c9c-413d-a27d-afc1cd70fd4a', CAST(N'2023-07-08T00:00:00.000' AS DateTime))
INSERT [dbo].[TimeSheetRegistrationReference] ([id], [user_id], [created_at], [time_sheet_id], [date]) VALUES (N'4b6de8e5-df46-4a44-816c-3342d4c697f7', N'520e3b7a-0efc-4ec0-b38c-5fcb1825d7e4', CAST(N'2023-06-29T11:17:53.447' AS DateTime), N'627bca55-7e3c-461c-b685-3fa82d7b730a', CAST(N'2023-07-08T00:00:00.000' AS DateTime))
INSERT [dbo].[TimeSheetRegistrationReference] ([id], [user_id], [created_at], [time_sheet_id], [date]) VALUES (N'5e7f5d4f-0337-432b-ab42-1c8c2014b41d', N'f88c8736-cd4a-4664-bb73-7acb00c20822', CAST(N'2023-06-28T00:20:58.410' AS DateTime), N'98a1ee44-2d1d-466f-8539-e6a7738bf237', CAST(N'2023-06-29T00:00:00.000' AS DateTime))
INSERT [dbo].[TimeSheetRegistrationReference] ([id], [user_id], [created_at], [time_sheet_id], [date]) VALUES (N'64e4ed1d-9f0c-486d-bd22-bdf4114e99e8', N'f88c8736-cd4a-4664-bb73-7acb00c20822', CAST(N'2023-06-28T00:07:03.017' AS DateTime), N'fd68b9e3-91df-43da-b045-d40807a2c7d4', CAST(N'2023-06-28T00:00:00.000' AS DateTime))
INSERT [dbo].[TimeSheetRegistrationReference] ([id], [user_id], [created_at], [time_sheet_id], [date]) VALUES (N'75374f6d-e9c1-422b-bd3c-86e49df415f2', N'f88c8736-cd4a-4664-bb73-7acb00c20822', CAST(N'2023-06-27T20:49:56.067' AS DateTime), N'98a1ee44-2d1d-466f-8539-e6a7738bf237', CAST(N'2023-07-04T00:00:00.000' AS DateTime))
INSERT [dbo].[TimeSheetRegistrationReference] ([id], [user_id], [created_at], [time_sheet_id], [date]) VALUES (N'764b1ecb-a8cd-49ea-bf7f-4f873a30e2d0', N'f88c8736-cd4a-4664-bb73-7acb00c20822', CAST(N'2023-06-28T00:21:53.307' AS DateTime), N'abff4e43-5c5c-43b6-a656-890b3c27e6be', CAST(N'2023-06-30T00:00:00.000' AS DateTime))
INSERT [dbo].[TimeSheetRegistrationReference] ([id], [user_id], [created_at], [time_sheet_id], [date]) VALUES (N'77bd8c32-cb58-4b54-a31e-3c71130d7909', N'520e3b7a-0efc-4ec0-b38c-5fcb1825d7e4', CAST(N'2023-07-01T08:03:24.510' AS DateTime), N'690f7940-6c9c-413d-a27d-afc1cd70fd4a', CAST(N'2023-07-02T00:00:00.000' AS DateTime))
INSERT [dbo].[TimeSheetRegistrationReference] ([id], [user_id], [created_at], [time_sheet_id], [date]) VALUES (N'792f5962-0cf7-4734-85e7-ab906e6df2b7', N'520e3b7a-0efc-4ec0-b38c-5fcb1825d7e4', CAST(N'2023-06-29T02:47:46.277' AS DateTime), N'690f7940-6c9c-413d-a27d-afc1cd70fd4a', CAST(N'2023-06-30T00:00:00.000' AS DateTime))
INSERT [dbo].[TimeSheetRegistrationReference] ([id], [user_id], [created_at], [time_sheet_id], [date]) VALUES (N'81f7f75a-d2a1-4035-86f5-cbb850f85991', N'520e3b7a-0efc-4ec0-b38c-5fcb1825d7e4', CAST(N'2023-06-29T11:28:18.333' AS DateTime), N'627bca55-7e3c-461c-b685-3fa82d7b730a', CAST(N'2023-07-11T00:00:00.000' AS DateTime))
INSERT [dbo].[TimeSheetRegistrationReference] ([id], [user_id], [created_at], [time_sheet_id], [date]) VALUES (N'82cb594e-db78-45d4-b7c4-2ba0bccf0518', N'520e3b7a-0efc-4ec0-b38c-5fcb1825d7e4', CAST(N'2023-06-29T02:49:42.550' AS DateTime), N'a9a4ab45-0ef3-4d4c-96e7-f28adda26fc6', CAST(N'2023-07-10T00:00:00.000' AS DateTime))
INSERT [dbo].[TimeSheetRegistrationReference] ([id], [user_id], [created_at], [time_sheet_id], [date]) VALUES (N'835f6a7a-5118-40c2-84a2-2953b1ad098a', N'9672d446-ee4e-4287-893c-0da04dbd1bec', CAST(N'2023-06-28T00:54:29.667' AS DateTime), N'690f7940-6c9c-413d-a27d-afc1cd70fd4a', CAST(N'2023-07-01T00:00:00.000' AS DateTime))
INSERT [dbo].[TimeSheetRegistrationReference] ([id], [user_id], [created_at], [time_sheet_id], [date]) VALUES (N'89bd78b1-f839-4447-b8fb-40f09461e0cf', N'520e3b7a-0efc-4ec0-b38c-5fcb1825d7e4', CAST(N'2023-07-01T08:03:24.510' AS DateTime), N'a9a4ab45-0ef3-4d4c-96e7-f28adda26fc6', CAST(N'2023-07-02T00:00:00.000' AS DateTime))
INSERT [dbo].[TimeSheetRegistrationReference] ([id], [user_id], [created_at], [time_sheet_id], [date]) VALUES (N'8b716bb4-d3d2-49d2-9966-cdf24888117d', N'f88c8736-cd4a-4664-bb73-7acb00c20822', CAST(N'2023-06-27T20:49:56.067' AS DateTime), N'af827ca3-0ebe-45e0-af5f-db0fe371fc2b', CAST(N'2023-07-04T00:00:00.000' AS DateTime))
INSERT [dbo].[TimeSheetRegistrationReference] ([id], [user_id], [created_at], [time_sheet_id], [date]) VALUES (N'923b5ab4-e2a7-45f3-9c73-ef54f2f1b3c0', N'9672d446-ee4e-4287-893c-0da04dbd1bec', CAST(N'2023-06-28T00:54:29.667' AS DateTime), N'627bca55-7e3c-461c-b685-3fa82d7b730a', CAST(N'2023-07-01T00:00:00.000' AS DateTime))
INSERT [dbo].[TimeSheetRegistrationReference] ([id], [user_id], [created_at], [time_sheet_id], [date]) VALUES (N'95db5858-393e-46ea-b463-8d189a342e23', N'520e3b7a-0efc-4ec0-b38c-5fcb1825d7e4', CAST(N'2023-06-29T11:28:28.443' AS DateTime), N'627bca55-7e3c-461c-b685-3fa82d7b730a', CAST(N'2023-07-18T00:00:00.000' AS DateTime))
INSERT [dbo].[TimeSheetRegistrationReference] ([id], [user_id], [created_at], [time_sheet_id], [date]) VALUES (N'a3461b4d-3254-4f2e-a531-785936c40d6c', N'f88c8736-cd4a-4664-bb73-7acb00c20822', CAST(N'2023-06-27T20:37:19.187' AS DateTime), N'fd68b9e3-91df-43da-b045-d40807a2c7d4', CAST(N'2023-06-27T00:00:00.000' AS DateTime))
INSERT [dbo].[TimeSheetRegistrationReference] ([id], [user_id], [created_at], [time_sheet_id], [date]) VALUES (N'a5d1bc81-c6e7-4d40-bb49-7da546cde85e', N'f88c8736-cd4a-4664-bb73-7acb00c20822', CAST(N'2023-06-27T20:48:09.857' AS DateTime), N'c84ef420-ae31-415b-a169-fcc5b0c1ad7f', CAST(N'2023-07-02T00:00:00.000' AS DateTime))
INSERT [dbo].[TimeSheetRegistrationReference] ([id], [user_id], [created_at], [time_sheet_id], [date]) VALUES (N'aabe233d-41d6-4dd8-847f-a7fbcac731d2', N'520e3b7a-0efc-4ec0-b38c-5fcb1825d7e4', CAST(N'2023-06-29T11:17:53.447' AS DateTime), N'a9a4ab45-0ef3-4d4c-96e7-f28adda26fc6', CAST(N'2023-07-08T00:00:00.000' AS DateTime))
INSERT [dbo].[TimeSheetRegistrationReference] ([id], [user_id], [created_at], [time_sheet_id], [date]) VALUES (N'be6e84d7-7a69-405a-864e-72f87361fcc5', N'9672d446-ee4e-4287-893c-0da04dbd1bec', CAST(N'2023-06-28T00:54:24.820' AS DateTime), N'a9a4ab45-0ef3-4d4c-96e7-f28adda26fc6', CAST(N'2023-06-28T00:00:00.000' AS DateTime))
INSERT [dbo].[TimeSheetRegistrationReference] ([id], [user_id], [created_at], [time_sheet_id], [date]) VALUES (N'c3ad6ed5-9b2b-4bc7-96b3-a4cdd590fd1f', N'f88c8736-cd4a-4664-bb73-7acb00c20822', CAST(N'2023-06-27T20:49:56.067' AS DateTime), N'fd68b9e3-91df-43da-b045-d40807a2c7d4', CAST(N'2023-07-04T00:00:00.000' AS DateTime))
INSERT [dbo].[TimeSheetRegistrationReference] ([id], [user_id], [created_at], [time_sheet_id], [date]) VALUES (N'c93c311b-7f6b-4d2e-ba3a-419705513084', N'f88c8736-cd4a-4664-bb73-7acb00c20822', CAST(N'2023-06-27T20:49:56.067' AS DateTime), N'c84ef420-ae31-415b-a169-fcc5b0c1ad7f', CAST(N'2023-07-04T00:00:00.000' AS DateTime))
INSERT [dbo].[TimeSheetRegistrationReference] ([id], [user_id], [created_at], [time_sheet_id], [date]) VALUES (N'd1f3a8b8-40d0-4f8e-bd9f-03d804bf19fc', N'f88c8736-cd4a-4664-bb73-7acb00c20822', CAST(N'2023-06-27T20:37:19.187' AS DateTime), N'fd68b9e3-91df-43da-b045-d40807a2c7d4', CAST(N'2023-06-29T00:00:00.000' AS DateTime))
INSERT [dbo].[TimeSheetRegistrationReference] ([id], [user_id], [created_at], [time_sheet_id], [date]) VALUES (N'd2763ac1-4e68-4425-8b12-d1a714767805', N'f88c8736-cd4a-4664-bb73-7acb00c20822', CAST(N'2023-06-28T00:07:27.467' AS DateTime), N'abff4e43-5c5c-43b6-a656-890b3c27e6be', CAST(N'2023-06-28T00:00:00.000' AS DateTime))
INSERT [dbo].[TimeSheetRegistrationReference] ([id], [user_id], [created_at], [time_sheet_id], [date]) VALUES (N'd53f1410-cc99-445c-bead-e4d2e81954c3', N'9672d446-ee4e-4287-893c-0da04dbd1bec', CAST(N'2023-06-28T00:54:24.820' AS DateTime), N'a9a4ab45-0ef3-4d4c-96e7-f28adda26fc6', CAST(N'2023-06-29T00:00:00.000' AS DateTime))
INSERT [dbo].[TimeSheetRegistrationReference] ([id], [user_id], [created_at], [time_sheet_id], [date]) VALUES (N'da63b942-e540-4f8d-8548-0a781fd8a530', N'f88c8736-cd4a-4664-bb73-7acb00c20822', CAST(N'2023-06-27T20:48:20.260' AS DateTime), N'c84ef420-ae31-415b-a169-fcc5b0c1ad7f', CAST(N'2023-06-29T00:00:00.000' AS DateTime))
INSERT [dbo].[TimeSheetRegistrationReference] ([id], [user_id], [created_at], [time_sheet_id], [date]) VALUES (N'dc7e0139-f773-43c0-9962-dcef20d44c45', N'9672d446-ee4e-4287-893c-0da04dbd1bec', CAST(N'2023-06-28T00:54:24.820' AS DateTime), N'690f7940-6c9c-413d-a27d-afc1cd70fd4a', CAST(N'2023-06-29T00:00:00.000' AS DateTime))
INSERT [dbo].[TimeSheetRegistrationReference] ([id], [user_id], [created_at], [time_sheet_id], [date]) VALUES (N'e228a4e7-8869-46be-9ace-5ddd2b40157a', N'9672d446-ee4e-4287-893c-0da04dbd1bec', CAST(N'2023-06-28T00:54:24.820' AS DateTime), N'627bca55-7e3c-461c-b685-3fa82d7b730a', CAST(N'2023-06-28T00:00:00.000' AS DateTime))
INSERT [dbo].[TimeSheetRegistrationReference] ([id], [user_id], [created_at], [time_sheet_id], [date]) VALUES (N'e88f4c85-e25c-4968-b741-8687b61180eb', N'9672d446-ee4e-4287-893c-0da04dbd1bec', CAST(N'2023-06-28T00:54:24.820' AS DateTime), N'690f7940-6c9c-413d-a27d-afc1cd70fd4a', CAST(N'2023-06-28T00:00:00.000' AS DateTime))
INSERT [dbo].[TimeSheetRegistrationReference] ([id], [user_id], [created_at], [time_sheet_id], [date]) VALUES (N'f097e191-462d-4b8c-a78d-aae1128aece7', N'520e3b7a-0efc-4ec0-b38c-5fcb1825d7e4', CAST(N'2023-07-01T08:03:24.510' AS DateTime), N'627bca55-7e3c-461c-b685-3fa82d7b730a', CAST(N'2023-07-02T00:00:00.000' AS DateTime))
INSERT [dbo].[TimeSheetRegistrationReference] ([id], [user_id], [created_at], [time_sheet_id], [date]) VALUES (N'f0ad44d2-912f-46a0-966f-dc3eda80f221', N'520e3b7a-0efc-4ec0-b38c-5fcb1825d7e4', CAST(N'2023-06-29T11:28:28.443' AS DateTime), N'690f7940-6c9c-413d-a27d-afc1cd70fd4a', CAST(N'2023-07-18T00:00:00.000' AS DateTime))
INSERT [dbo].[TimeSheetRegistrationReference] ([id], [user_id], [created_at], [time_sheet_id], [date]) VALUES (N'f158a97b-800a-424b-900c-e219224355ed', N'520e3b7a-0efc-4ec0-b38c-5fcb1825d7e4', CAST(N'2023-06-28T15:15:43.643' AS DateTime), N'690f7940-6c9c-413d-a27d-afc1cd70fd4a', CAST(N'2023-06-28T00:00:00.000' AS DateTime))
INSERT [dbo].[TimeSheetRegistrationReference] ([id], [user_id], [created_at], [time_sheet_id], [date]) VALUES (N'f6cd5c26-f05a-488e-8ab4-c2d4f882d04c', N'9672d446-ee4e-4287-893c-0da04dbd1bec', CAST(N'2023-06-28T00:54:29.667' AS DateTime), N'690f7940-6c9c-413d-a27d-afc1cd70fd4a', CAST(N'2023-06-30T00:00:00.000' AS DateTime))
GO
INSERT [dbo].[User] ([id], [fullname], [email], [password], [phone], [avatar], [address], [DOB], [created_at], [amount_selled], [is_active], [is_deleted], [is_confirmed], [token], [is_logout], [role_id], [salary]) VALUES (N'520e3b7a-0efc-4ec0-b38c-5fcb1825d7e4', N'Guard', N'guard@gmail.com', N'123456', N'0844111006', N'https://firebasestorage.googleapis.com/v0/b/ministoregrprjprn231.appspot.com/o/Guard-d522c23e-f8eb-4bc8-b518-0463cd32dd3c?alt=media&token=207a06d0-c209-4d09-b11e-edb2a261ee16', N'KTX Khu B ÐHQG', CAST(N'2001-11-04' AS Date), CAST(N'2023-06-27T00:38:57.130' AS DateTime), NULL, 1, 0, 1, N'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjUyMGUzYjdhLTBlZmMtNGVjMC1iMzhjLTVmY2IxODI1ZDdlNCIsIm5iZiI6MTY4NzgwNTY1NSwiZXhwIjoxNjg3ODA5MjU1LCJpYXQiOjE2ODc4MDU2NTV9.QCY3iXko2TkeNnUq45SEYqiwaoh_hO15bQyFH9exDuw', 0, 3, NULL)
INSERT [dbo].[User] ([id], [fullname], [email], [password], [phone], [avatar], [address], [DOB], [created_at], [amount_selled], [is_active], [is_deleted], [is_confirmed], [token], [is_logout], [role_id], [salary]) VALUES (N'65908cb9-890a-47f0-b9a2-4ebf12aad132', N'Truong Quang Tân', N'admin3@gmail.com', N'123456', N'0844111006', N'https://firebasestorage.googleapis.com/v0/b/ministoregrprjprn231.appspot.com/o/default-avatar.jpg?alt=media&token=2802e58e-14c1-4dc6-9b0e-39bf9b00ed28&_gl=1*1m7jcd7*_ga*MTE4OTYyNDIwMC4xNjg1MjgzNjU3*_ga_CW55HF8NVT*MTY4NTQzODAwMi4zLjEuMTY4NTQzODEyNy4wLjAuMA..', N'KTX Khu B ÐHQG VietNam', CAST(N'2000-01-01' AS Date), CAST(N'2023-05-30T17:02:31.503' AS DateTime), NULL, 1, 0, 1, NULL, 1, 2, NULL)
INSERT [dbo].[User] ([id], [fullname], [email], [password], [phone], [avatar], [address], [DOB], [created_at], [amount_selled], [is_active], [is_deleted], [is_confirmed], [token], [is_logout], [role_id], [salary]) VALUES (N'9672d446-ee4e-4287-893c-0da04dbd1bec', N'Truong Quang Tân', N'admin@gmail.com', N'admin123456', N'0844111006', N'https://firebasestorage.googleapis.com/v0/b/ministoregrprjprn231.appspot.com/o/Truong%20Quang%20T%C3%A2n-14e614af-5f60-415c-8397-a6dc8f028e8b?alt=media&token=d96dd647-3a8d-4cdf-9622-fcfbaa685cdb', N'KTX Khu B ÐHQG', CAST(N'2000-01-01' AS Date), CAST(N'2023-05-30T01:15:17.383' AS DateTime), NULL, 1, 0, 1, N'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6Ijk2NzJkNDQ2LWVlNGUtNDI4Ny04OTNjLTBkYTA0ZGJkMWJlYyIsIm5iZiI6MTY4NjMwMTgwMSwiZXhwIjoxNjg2MzA1NDAxLCJpYXQiOjE2ODYzMDE4MDF9.LgAnkF0jDSHSMC3T90s6IFJfC-3mYKhu7AofnNXb_Sc', 0, 3, NULL)
INSERT [dbo].[User] ([id], [fullname], [email], [password], [phone], [avatar], [address], [DOB], [created_at], [amount_selled], [is_active], [is_deleted], [is_confirmed], [token], [is_logout], [role_id], [salary]) VALUES (N'bf67abd0-014d-4b53-998a-8597d3cf4af8', N'Truong Quang Tân', N'truongquangtan@gmail.com', N'123456', N'0844111006', N'https://firebasestorage.googleapis.com/v0/b/ministoregrprjprn231.appspot.com/o/default-avatar.jpg?alt=media&token=2802e58e-14c1-4dc6-9b0e-39bf9b00ed28&_gl=1*1m7jcd7*_ga*MTE4OTYyNDIwMC4xNjg1MjgzNjU3*_ga_CW55HF8NVT*MTY4NTQzODAwMi4zLjEuMTY4NTQzODEyNy4wLjAuMA..', N'KTX Khu B ÐHQG', CAST(N'2000-11-04' AS Date), CAST(N'2023-05-30T16:22:06.187' AS DateTime), NULL, 1, 0, 1, N'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6ImJmNjdhYmQwLTAxNGQtNGI1My05OThhLTg1OTdkM2NmNGFmOCIsIm5iZiI6MTY4Nzc5NDA0NiwiZXhwIjoxNjg3Nzk3NjQ2LCJpYXQiOjE2ODc3OTQwNDZ9.VLWvHuJOpnMqZBA7EsYpMmvEeuYGajIPZLYBkxqST8E', 0, 1, NULL)
INSERT [dbo].[User] ([id], [fullname], [email], [password], [phone], [avatar], [address], [DOB], [created_at], [amount_selled], [is_active], [is_deleted], [is_confirmed], [token], [is_logout], [role_id], [salary]) VALUES (N'c74b7811-1771-466c-a777-39b01129a211', N'Truong Quang Tân', N'admin12@gmail.com', N'123456', N'0844111006', N'https://firebasestorage.googleapis.com/v0/b/ministoregrprjprn231.appspot.com/o/Tr%C6%B0%C6%A1ng%20Quang%20T%C3%A2n-4827e75a-1dc1-48c2-82c3-e47d273f275a?alt=media&token=94737d1f-e604-4a4e-9c04-88cc6166b914', N'KTX Khu B ÐHQG', CAST(N'2001-11-04' AS Date), CAST(N'2023-06-26T22:53:58.543' AS DateTime), NULL, 1, 0, 1, N'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6ImM3NGI3ODExLTE3NzEtNDY2Yy1hNzc3LTM5YjAxMTI5YTIxMSIsIm5iZiI6MTY4Nzc5NDg2NCwiZXhwIjoxNjg3Nzk4NDY0LCJpYXQiOjE2ODc3OTQ4NjR9.8ZK00Rr2fAuretf5ucwwCCtd652sHnO9PaXrqGRFIag', 0, 2, NULL)
INSERT [dbo].[User] ([id], [fullname], [email], [password], [phone], [avatar], [address], [DOB], [created_at], [amount_selled], [is_active], [is_deleted], [is_confirmed], [token], [is_logout], [role_id], [salary]) VALUES (N'dcaf9299-7945-4862-8c72-d59063eb9b97', N'Truong Quang Tân', N'admin2@gmail.com', N'123456789', N'0844111006', N'https://firebasestorage.googleapis.com/v0/b/ministoregrprjprn231.appspot.com/o/default-avatar.jpg?alt=media&token=2802e58e-14c1-4dc6-9b0e-39bf9b00ed28&_gl=1*1m7jcd7*_ga*MTE4OTYyNDIwMC4xNjg1MjgzNjU3*_ga_CW55HF8NVT*MTY4NTQzODAwMi4zLjEuMTY4NTQzODEyNy4wLjAuMA..', N'KTX Khu B ÐHQG', CAST(N'2000-01-01' AS Date), CAST(N'2023-05-30T16:59:54.003' AS DateTime), NULL, 1, 0, 1, NULL, 1, 2, NULL)
INSERT [dbo].[User] ([id], [fullname], [email], [password], [phone], [avatar], [address], [DOB], [created_at], [amount_selled], [is_active], [is_deleted], [is_confirmed], [token], [is_logout], [role_id], [salary]) VALUES (N'f88c8736-cd4a-4664-bb73-7acb00c20822', N'Sales', N'sales@gmail.com', N'123456', N'0844111006', N'https://firebasestorage.googleapis.com/v0/b/ministoregrprjprn231.appspot.com/o/Sales-2ec7cc32-8aa8-4500-83d5-26c7381dccb6?alt=media&token=f25fc038-ffb8-4e98-a646-afebee139dca', N'KTX Khu B ÐHQG', CAST(N'2001-11-04' AS Date), CAST(N'2023-06-27T00:38:19.803' AS DateTime), NULL, 1, 0, 1, N'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6ImY4OGM4NzM2LWNkNGEtNDY2NC1iYjczLTdhY2IwMGMyMDgyMiIsIm5iZiI6MTY4Nzg0MjA5MCwiZXhwIjoxNjg3ODQ1NjkwLCJpYXQiOjE2ODc4NDIwOTB9.DTAOGodOxs9unTglv1UuqkHhOQs3_DFvh2EVhR0sIU4', 0, 2, NULL)
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__User__AB6E6164E1A2D952]    Script Date: 7/1/2023 8:25:49 AM ******/
ALTER TABLE [dbo].[User] ADD UNIQUE NONCLUSTERED 
(
	[email] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
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
