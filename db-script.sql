USE [master]
GO

DROP DATABASE [MiniStore2]
GO

CREATE DATABASE [MiniStore2]
GO

USE [MiniStore2]
GO

/****** Object:  Table [dbo].[Category]    Script Date: 7/6/2023 3:12:36 PM ******/
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

/****** Object:  Table [dbo].[Order]    Script Date: 7/6/2023 3:12:36 PM ******/
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

/****** Object:  Table [dbo].[OrderDetail]    Script Date: 7/6/2023 3:12:36 PM ******/
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

/****** Object:  Table [dbo].[Product]    Script Date: 7/6/2023 3:12:36 PM ******/
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

/****** Object:  Table [dbo].[ProductImage]    Script Date: 7/6/2023 3:12:36 PM ******/
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

/****** Object:  Table [dbo].[Role]    Script Date: 7/6/2023 3:12:36 PM ******/
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

/****** Object:  Table [dbo].[TimeSheet]    Script Date: 7/6/2023 3:12:36 PM ******/
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

/****** Object:  Table [dbo].[TimeSheetCheck]    Script Date: 7/6/2023 3:12:36 PM ******/
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

/****** Object:  Table [dbo].[TimeSheetRegistration]    Script Date: 7/6/2023 3:12:36 PM ******/
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

/****** Object:  Table [dbo].[TimeSheetRegistrationReference]    Script Date: 7/6/2023 3:12:36 PM ******/
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

/****** Object:  Table [dbo].[User]    Script Date: 7/6/2023 3:12:36 PM ******/
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
	[date_update_salary] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

/*Data of Category Table*/
SET IDENTITY_INSERT [dbo].[Category] ON 
GO
INSERT [dbo].[Category] ([id], [name], [is_deleted]) VALUES (1, N'Milk', 0)
GO
INSERT [dbo].[Category] ([id], [name], [is_deleted]) VALUES (2, N'Tea', 0)
GO
INSERT [dbo].[Category] ([id], [name], [is_deleted]) VALUES (3, N'Grocery', 0)
GO
INSERT [dbo].[Category] ([id], [name], [is_deleted]) VALUES (4, N'Other', 0)
GO
SET IDENTITY_INSERT [dbo].[Category] OFF


/*Data of order and order detail*/
GO
INSERT [dbo].[Order] ([id], [user_id], [amount], [created_at], [status], [payment]) VALUES (N'36f6300e-f18e-41b7-81f1-68f1d2a3e9e3', N'baa62046-d544-4fca-a144-1960d3e2db72', 70000.0000, CAST(N'2023-07-06T15:04:23.383' AS DateTime), N'CREATED', N'CREDIT')
GO
INSERT [dbo].[OrderDetail] ([id], [order_id], [product_id], [quantity], [price]) VALUES (N'854e1335-eec0-470e-9b14-119c53ccf285', N'36f6300e-f18e-41b7-81f1-68f1d2a3e9e3', 8, 2, 20000.0000)
GO
INSERT [dbo].[OrderDetail] ([id], [order_id], [product_id], [quantity], [price]) VALUES (N'88e04024-8e89-42bc-9a2e-496f35bc432d', N'36f6300e-f18e-41b7-81f1-68f1d2a3e9e3', 1, 1, 50000.0000)
GO

/*Data of product*/
SET IDENTITY_INSERT [dbo].[Product] ON 
GO
INSERT [dbo].[Product] ([id], [name], [price], [quantity], [created_at], [last_updated_at], [source], [categoryId], [is_active], [is_deleted], [description]) VALUES (1, N'Dalat Milk', 50000.0000, 99, CAST(N'2023-07-06T14:56:32.797' AS DateTime), CAST(N'2023-07-06T14:56:32.797' AS DateTime), N'Da Lat', 1, 1, 0, N'This is milk from src Dalat Vietnam')
GO
INSERT [dbo].[Product] ([id], [name], [price], [quantity], [created_at], [last_updated_at], [source], [categoryId], [is_active], [is_deleted], [description]) VALUES (2, N'Lactaid Milk', 40000.0000, 200, CAST(N'2023-07-06T14:57:39.347' AS DateTime), CAST(N'2023-07-06T14:57:39.347' AS DateTime), N'LACTAID® Lactose-Free Whole Milk', 1, 1, 1, N'Lactaid nh?p kh?u')
GO
INSERT [dbo].[Product] ([id], [name], [price], [quantity], [created_at], [last_updated_at], [source], [categoryId], [is_active], [is_deleted], [description]) VALUES (3, N'Lactaid Milk', 40000.0000, 400, CAST(N'2023-07-06T14:58:09.397' AS DateTime), CAST(N'2023-07-06T14:58:09.397' AS DateTime), N'LACTAID® Lactose-Free Whole Milk', 1, 1, 0, N'Lactaid import')
GO
INSERT [dbo].[Product] ([id], [name], [price], [quantity], [created_at], [last_updated_at], [source], [categoryId], [is_active], [is_deleted], [description]) VALUES (4, N'Phuc Long Tra Vai', 50000.0000, 20, CAST(N'2023-07-06T14:59:43.527' AS DateTime), CAST(N'2023-07-06T14:59:43.527' AS DateTime), N'Phuc Long VietNam', 2, 1, 0, N'Phuc Long Limited')
GO
INSERT [dbo].[Product] ([id], [name], [price], [quantity], [created_at], [last_updated_at], [source], [categoryId], [is_active], [is_deleted], [description]) VALUES (5, N'Phuc Long Tra Xanh', 40000.0000, 20, CAST(N'2023-07-06T15:00:35.320' AS DateTime), CAST(N'2023-07-06T15:00:35.320' AS DateTime), N'Phuc Long VietNam', 2, 1, 0, N'Phuc Long')
GO
INSERT [dbo].[Product] ([id], [name], [price], [quantity], [created_at], [last_updated_at], [source], [categoryId], [is_active], [is_deleted], [description]) VALUES (6, N'Ca phe Phuc Long', 20000.0000, 20, CAST(N'2023-07-06T15:01:10.177' AS DateTime), CAST(N'2023-07-06T15:01:10.177' AS DateTime), N'Phuc Long Vietnam', 2, 1, 0, N'Phuc Long Tea.')
GO
INSERT [dbo].[Product] ([id], [name], [price], [quantity], [created_at], [last_updated_at], [source], [categoryId], [is_active], [is_deleted], [description]) VALUES (7, N'Bật Lửa', 5000.0000, 500, CAST(N'2023-07-06T15:01:40.677' AS DateTime), CAST(N'2023-07-06T15:01:40.677' AS DateTime), N'Trung Quốc', 3, 1, 0, N'Cheap')
GO
INSERT [dbo].[Product] ([id], [name], [price], [quantity], [created_at], [last_updated_at], [source], [categoryId], [is_active], [is_deleted], [description]) VALUES (8, N'Súng đồ chơi', 10000.0000, 98, CAST(N'2023-07-06T15:02:43.387' AS DateTime), CAST(N'2023-07-06T15:02:43.387' AS DateTime), N'Trung Quốc', 3, 1, 0, N'Toy')
GO
INSERT [dbo].[Product] ([id], [name], [price], [quantity], [created_at], [last_updated_at], [source], [categoryId], [is_active], [is_deleted], [description]) VALUES (9, N'Súng nước', 12000.0000, 100, CAST(N'2023-07-06T15:03:21.617' AS DateTime), CAST(N'2023-07-06T15:03:21.617' AS DateTime), N'Vietnam', 3, 1, 0, N'Toys')
GO
INSERT [dbo].[Product] ([id], [name], [price], [quantity], [created_at], [last_updated_at], [source], [categoryId], [is_active], [is_deleted], [description]) VALUES (10, N'Gạo', 80000.0000, 50, CAST(N'2023-07-06T15:03:59.027' AS DateTime), CAST(N'2023-07-06T15:03:59.027' AS DateTime), N'Bến Tre', 3, 1, 0, N'G?o')
GO
SET IDENTITY_INSERT [dbo].[Product] OFF
GO

/*Data of product image*/
SET IDENTITY_INSERT [dbo].[ProductImage] ON 
GO
INSERT [dbo].[ProductImage] ([id], [product_id], [image]) VALUES (1, 1, N'https://firebasestorage.googleapis.com/v0/b/ministoregrprjprn231.appspot.com/o/Dalat%20Milk%20fb44752b-8d3e-45c5-8ed3-6c2c918e4215?alt=media&token=d068e49d-a08a-4970-8441-71549a974b05')
GO
INSERT [dbo].[ProductImage] ([id], [product_id], [image]) VALUES (2, 2, N'https://firebasestorage.googleapis.com/v0/b/ministoregrprjprn231.appspot.com/o/Lactaid%20Milk%2038cda88b-425d-4b42-bce8-f4412723f18f?alt=media&token=875a59f9-be97-4ae7-9b6b-71839f1f1c29')
GO
INSERT [dbo].[ProductImage] ([id], [product_id], [image]) VALUES (3, 3, N'https://firebasestorage.googleapis.com/v0/b/ministoregrprjprn231.appspot.com/o/Lactaid%20Milk%20874b1f82-6bfd-4d99-aa4e-3c1d11a40f1f?alt=media&token=424308eb-a474-403e-983e-f23351f82e9e')
GO
INSERT [dbo].[ProductImage] ([id], [product_id], [image]) VALUES (4, 4, N'https://firebasestorage.googleapis.com/v0/b/ministoregrprjprn231.appspot.com/o/Phuc%20Long%20Tra%20Vai%20c9c1802b-e680-4f78-b77a-442205bbc9b6?alt=media&token=8cf24017-b2ab-4b66-8746-c2846afd0adf')
GO
INSERT [dbo].[ProductImage] ([id], [product_id], [image]) VALUES (5, 5, N'https://firebasestorage.googleapis.com/v0/b/ministoregrprjprn231.appspot.com/o/Phuc%20Long%20Tra%20Xanh%20e5f4a248-465e-4a8a-b4b3-01ccc09abb9a?alt=media&token=19b8b7e7-99ba-4f37-92d7-39c476700287')
GO
INSERT [dbo].[ProductImage] ([id], [product_id], [image]) VALUES (6, 6, N'https://firebasestorage.googleapis.com/v0/b/ministoregrprjprn231.appspot.com/o/Ca%20phe%20Phuc%20Long%200517a4b4-be97-4345-a09d-4b52a0a6f4ec?alt=media&token=b92a2e54-ce10-4c27-a5c3-ea3139770ec0')
GO
INSERT [dbo].[ProductImage] ([id], [product_id], [image]) VALUES (7, 7, N'https://firebasestorage.googleapis.com/v0/b/ministoregrprjprn231.appspot.com/o/B%E1%BA%ADt%20L%E1%BB%ADa%20a6ba233b-b360-40d1-ab37-0719ade6ac6c?alt=media&token=d9b7c96c-3edf-43c1-816b-547cd22ca4fb')
GO
INSERT [dbo].[ProductImage] ([id], [product_id], [image]) VALUES (8, 8, N'https://firebasestorage.googleapis.com/v0/b/ministoregrprjprn231.appspot.com/o/S%C3%BAng%20%C4%91%E1%BB%93%20ch%C6%A1i%20d1cafd48-e47c-467f-8677-21d144a02495?alt=media&token=efd13520-5f08-4960-8bb2-ab37af66afd0')
GO
INSERT [dbo].[ProductImage] ([id], [product_id], [image]) VALUES (9, 9, N'https://firebasestorage.googleapis.com/v0/b/ministoregrprjprn231.appspot.com/o/S%C3%BAng%20n%C6%B0%E1%BB%9Bc%20a583c131-24c2-4aac-bede-ce8942555b19?alt=media&token=48a122cf-b4ef-42f8-a71a-7e402689b729')
GO
INSERT [dbo].[ProductImage] ([id], [product_id], [image]) VALUES (10, 10, N'https://firebasestorage.googleapis.com/v0/b/ministoregrprjprn231.appspot.com/o/G%E1%BA%A1o%20b956b807-54f9-4d7c-a236-fc5fe3bca664?alt=media&token=06fabcfd-df66-459e-abaf-c2822af4b9f4')
GO
SET IDENTITY_INSERT [dbo].[ProductImage] OFF

/*Data of Role*/
GO
SET IDENTITY_INSERT [dbo].[Role] ON 
GO
INSERT [dbo].[Role] ([id], [name]) VALUES (1, N'Manager')
GO
INSERT [dbo].[Role] ([id], [name]) VALUES (2, N'Sales')
GO
INSERT [dbo].[Role] ([id], [name]) VALUES (3, N'Guard')
GO
SET IDENTITY_INSERT [dbo].[Role] OFF

/*Data of Timesheet*/
GO
INSERT [dbo].[TimeSheet] ([id], [role_id], [time_range], [is_active], [name], [coefficient_amount]) VALUES (N'2acfe21d-c166-43fb-b8ff-f0bb68630159', 3, N'06:00-18:00', 1, N'Ca ngày', CAST(1.0 AS Decimal(2, 1)))
GO
INSERT [dbo].[TimeSheet] ([id], [role_id], [time_range], [is_active], [name], [coefficient_amount]) VALUES (N'84672732-dff7-4697-907d-749f79d52ccd', 2, N'06:00-12:00', 1, N'Ca sáng', CAST(1.0 AS Decimal(2, 1)))
GO
INSERT [dbo].[TimeSheet] ([id], [role_id], [time_range], [is_active], [name], [coefficient_amount]) VALUES (N'89901b27-ca4a-4411-af69-502cd954b764', 3, N'18:00-06:00', 1, N'Ca đêm', CAST(1.5 AS Decimal(2, 1)))
GO
INSERT [dbo].[TimeSheet] ([id], [role_id], [time_range], [is_active], [name], [coefficient_amount]) VALUES (N'a813d28d-db9c-438a-8a0a-a90b43f3274f', 2, N'12:00-18:00', 1, N'Ca chiều', CAST(1.0 AS Decimal(2, 1)))
GO
INSERT [dbo].[TimeSheet] ([id], [role_id], [time_range], [is_active], [name], [coefficient_amount]) VALUES (N'dd61fa65-1eb5-44b8-8177-9f682896a679', 2, N'18:00-06:00', 1, N'Ca khuya', CAST(1.5 AS Decimal(2, 1)))
GO
INSERT [dbo].[TimeSheetRegistration] ([id], [user_id], [time_sheet_id], [created_at], [salary], [date]) VALUES (N'02010fdb-8fa9-48a7-833a-bce1f95ec1a8', N'baa62046-d544-4fca-a144-1960d3e2db72', N'dd61fa65-1eb5-44b8-8177-9f682896a679', CAST(N'2023-07-06T15:07:13.150' AS DateTime), 37500.0000, CAST(N'2023-07-06T00:00:00.000' AS DateTime))
GO
INSERT [dbo].[TimeSheetRegistration] ([id], [user_id], [time_sheet_id], [created_at], [salary], [date]) VALUES (N'4175cbfe-a1ab-4a62-8898-a1e5c98fc44f', N'6ada3770-26f8-452c-9c5a-0b27d37d9705', N'2acfe21d-c166-43fb-b8ff-f0bb68630159', CAST(N'2023-07-06T15:10:05.230' AS DateTime), 25000.0000, CAST(N'2023-07-07T00:00:00.000' AS DateTime))
GO
INSERT [dbo].[TimeSheetRegistration] ([id], [user_id], [time_sheet_id], [created_at], [salary], [date]) VALUES (N'75644298-a566-4f53-bef0-ae499d0e7bd1', N'6ada3770-26f8-452c-9c5a-0b27d37d9705', N'89901b27-ca4a-4411-af69-502cd954b764', CAST(N'2023-07-06T15:10:02.497' AS DateTime), 37500.0000, CAST(N'2023-07-06T00:00:00.000' AS DateTime))
GO
INSERT [dbo].[TimeSheetRegistration] ([id], [user_id], [time_sheet_id], [created_at], [salary], [date]) VALUES (N'c97b9f4d-5bde-4962-be3b-482a1e5eb6d5', N'baa62046-d544-4fca-a144-1960d3e2db72', N'84672732-dff7-4697-907d-749f79d52ccd', CAST(N'2023-07-06T15:07:08.040' AS DateTime), 25000.0000, CAST(N'2023-07-07T00:00:00.000' AS DateTime))
GO
INSERT [dbo].[TimeSheetRegistration] ([id], [user_id], [time_sheet_id], [created_at], [salary], [date]) VALUES (N'df210f2c-1872-4412-8afb-b9d1ce835e8b', N'baa62046-d544-4fca-a144-1960d3e2db72', N'a813d28d-db9c-438a-8a0a-a90b43f3274f', CAST(N'2023-07-06T15:07:10.160' AS DateTime), 25000.0000, CAST(N'2023-07-07T00:00:00.000' AS DateTime))
GO
INSERT [dbo].[TimeSheetRegistrationReference] ([id], [user_id], [created_at], [time_sheet_id], [date]) VALUES (N'230992ce-0277-4179-be95-9277c7808741', N'baa62046-d544-4fca-a144-1960d3e2db72', CAST(N'2023-07-06T14:23:24.053' AS DateTime), N'a813d28d-db9c-438a-8a0a-a90b43f3274f', CAST(N'2023-07-07T00:00:00.000' AS DateTime))
GO
INSERT [dbo].[TimeSheetRegistrationReference] ([id], [user_id], [created_at], [time_sheet_id], [date]) VALUES (N'293c2da5-d8a5-4e66-b5a3-dbd856df8d44', N'6ada3770-26f8-452c-9c5a-0b27d37d9705', CAST(N'2023-07-06T15:09:37.447' AS DateTime), N'89901b27-ca4a-4411-af69-502cd954b764', CAST(N'2023-07-06T00:00:00.000' AS DateTime))
GO
INSERT [dbo].[TimeSheetRegistrationReference] ([id], [user_id], [created_at], [time_sheet_id], [date]) VALUES (N'6b6a527f-4997-4ce2-9234-f1ec77441416', N'baa62046-d544-4fca-a144-1960d3e2db72', CAST(N'2023-07-06T14:23:24.053' AS DateTime), N'84672732-dff7-4697-907d-749f79d52ccd', CAST(N'2023-07-07T00:00:00.000' AS DateTime))
GO
INSERT [dbo].[TimeSheetRegistrationReference] ([id], [user_id], [created_at], [time_sheet_id], [date]) VALUES (N'70e51e7e-0993-4e3c-95e6-055a8449fb8d', N'6ada3770-26f8-452c-9c5a-0b27d37d9705', CAST(N'2023-07-06T15:09:37.447' AS DateTime), N'2acfe21d-c166-43fb-b8ff-f0bb68630159', CAST(N'2023-07-07T00:00:00.000' AS DateTime))
GO
INSERT [dbo].[TimeSheetRegistrationReference] ([id], [user_id], [created_at], [time_sheet_id], [date]) VALUES (N'841a37b5-fb06-4f1c-8e7c-8db5c367568d', N'baa62046-d544-4fca-a144-1960d3e2db72', CAST(N'2023-07-06T14:23:24.053' AS DateTime), N'dd61fa65-1eb5-44b8-8177-9f682896a679', CAST(N'2023-07-08T00:00:00.000' AS DateTime))
GO
INSERT [dbo].[TimeSheetRegistrationReference] ([id], [user_id], [created_at], [time_sheet_id], [date]) VALUES (N'aea13164-a28c-4084-9073-5995aed5595b', N'baa62046-d544-4fca-a144-1960d3e2db72', CAST(N'2023-07-06T14:23:13.593' AS DateTime), N'dd61fa65-1eb5-44b8-8177-9f682896a679', CAST(N'2023-07-06T00:00:00.000' AS DateTime))
GO
INSERT [dbo].[TimeSheetRegistrationReference] ([id], [user_id], [created_at], [time_sheet_id], [date]) VALUES (N'bee56fa9-e6b9-4706-8d35-5fc719c764e5', N'6ada3770-26f8-452c-9c5a-0b27d37d9705', CAST(N'2023-07-06T15:09:37.447' AS DateTime), N'89901b27-ca4a-4411-af69-502cd954b764', CAST(N'2023-07-07T00:00:00.000' AS DateTime))
GO
INSERT [dbo].[User] ([id], [fullname], [email], [password], [phone], [avatar], [address], [DOB], [created_at], [amount_selled], [is_active], [is_deleted], [is_confirmed], [token], [is_logout], [role_id], [salary], [date_update_salary]) VALUES (N'48264fde-e0fa-4e28-ac66-30f33d647fe5', N'Sales-01', N'sale01@gmail.com', N'123456', N'0844111006', N'https://firebasestorage.googleapis.com/v0/b/ministoregrprjprn231.appspot.com/o/Sales-01-33e416bf-90af-4367-83fe-41fe9f5701ff?alt=media&token=0779981d-89fa-45d0-9e85-f19407931e45', N'KTX Khu B ÐHQG', CAST(N'2001-11-04' AS Date), CAST(N'2023-07-06T14:19:38.810' AS DateTime), NULL, 1, 0, 1, NULL, 1, 2, NULL, NULL)
GO
INSERT [dbo].[User] ([id], [fullname], [email], [password], [phone], [avatar], [address], [DOB], [created_at], [amount_selled], [is_active], [is_deleted], [is_confirmed], [token], [is_logout], [role_id], [salary], [date_update_salary]) VALUES (N'61a738f4-6cbf-4719-b2e2-6790428b7f70', N'Guard-01', N'guard01@gmail.com', N'123456', N'0844111006', N'https://firebasestorage.googleapis.com/v0/b/ministoregrprjprn231.appspot.com/o/Guard-01-ce1fef1b-bf9a-4fe1-ac08-46999d79cdcc?alt=media&token=6f2a81f9-2433-4df9-a0c2-674158e68d99', N'KTX Khu B ÐHQG', CAST(N'2001-11-04' AS Date), CAST(N'2023-07-06T14:20:06.627' AS DateTime), NULL, 1, 0, 1, NULL, 1, 3, NULL, NULL)
GO
INSERT [dbo].[User] ([id], [fullname], [email], [password], [phone], [avatar], [address], [DOB], [created_at], [amount_selled], [is_active], [is_deleted], [is_confirmed], [token], [is_logout], [role_id], [salary], [date_update_salary]) VALUES (N'6ada3770-26f8-452c-9c5a-0b27d37d9705', N'Guard', N'guard@gmail.com', N'123456', N'0844111006', N'https://firebasestorage.googleapis.com/v0/b/ministoregrprjprn231.appspot.com/o/Guard-2ff341e4-290d-44a3-857a-7d08d0628d6d?alt=media&token=14ef0062-2043-490b-ada7-36ed16d502f9', N'KTX Khu B ÐHQG', CAST(N'2001-11-04' AS Date), CAST(N'2023-07-06T14:19:05.633' AS DateTime), NULL, 1, 0, 1, N'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjZhZGEzNzcwLTI2ZjgtNDUyYy05YzVhLTBiMjdkMzdkOTcwNSIsIm5iZiI6MTY4ODYzMDg1MCwiZXhwIjoxNjg4NjM0NDUwLCJpYXQiOjE2ODg2MzA4NTB9.HdRQwi8EIEW-KWOWaL633slR7GA45U8PrVf_W36VSSs', 0, 3, NULL, NULL)
GO
INSERT [dbo].[User] ([id], [fullname], [email], [password], [phone], [avatar], [address], [DOB], [created_at], [amount_selled], [is_active], [is_deleted], [is_confirmed], [token], [is_logout], [role_id], [salary], [date_update_salary]) VALUES (N'baa62046-d544-4fca-a144-1960d3e2db72', N'Sales', N'sales@gmail.com', N'123456', N'0844111006', N'https://firebasestorage.googleapis.com/v0/b/ministoregrprjprn231.appspot.com/o/Sales-34620c29-9d73-4e68-83ee-4eb540780b6f?alt=media&token=6601d363-5362-4c5c-ad99-f0e6652439c6', N'KTX Khu B ÐHQG', CAST(N'2001-11-04' AS Date), CAST(N'2023-07-06T14:18:37.273' AS DateTime), NULL, 1, 0, 1, N'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6ImJhYTYyMDQ2LWQ1NDQtNGZjYS1hMTQ0LTE5NjBkM2UyZGI3MiIsIm5iZiI6MTY4ODYyODEzNiwiZXhwIjoxNjg4NjMxNzM2LCJpYXQiOjE2ODg2MjgxMzZ9.HK7FJIgDj_o8eOiI0mhQGbzJDKX4CnLZZKCQbWBdFnY', 0, 2, NULL, NULL)
GO
INSERT [dbo].[User] ([id], [fullname], [email], [password], [phone], [avatar], [address], [DOB], [created_at], [amount_selled], [is_active], [is_deleted], [is_confirmed], [token], [is_logout], [role_id], [salary], [date_update_salary]) VALUES (N'bf67abd0-014d-4b53-998a-8597d3cf4af8', N'Truong Quang Tân', N'truongquangtan@gmail.com', N'123456', N'0844111006', N'https://firebasestorage.googleapis.com/v0/b/ministoregrprjprn231.appspot.com/o/default-avatar.jpg?alt=media&token=2802e58e-14c1-4dc6-9b0e-39bf9b00ed28&_gl=1*1m7jcd7*_ga*MTE4OTYyNDIwMC4xNjg1MjgzNjU3*_ga_CW55HF8NVT*MTY4NTQzODAwMi4zLjEuMTY4NTQzODEyNy4wLjAuMA..', N'KTX Khu B ÐHQG', CAST(N'2000-11-04' AS Date), CAST(N'2023-05-30T16:22:06.187' AS DateTime), NULL, 1, 0, 1, N'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6ImJmNjdhYmQwLTAxNGQtNGI1My05OThhLTg1OTdkM2NmNGFmOCIsIm5iZiI6MTY4Nzc5NDA0NiwiZXhwIjoxNjg3Nzk3NjQ2LCJpYXQiOjE2ODc3OTQwNDZ9.VLWvHuJOpnMqZBA7EsYpMmvEeuYGajIPZLYBkxqST8E', 0, 1, NULL, NULL)
GO
INSERT [dbo].[User] ([id], [fullname], [email], [password], [phone], [avatar], [address], [DOB], [created_at], [amount_selled], [is_active], [is_deleted], [is_confirmed], [token], [is_logout], [role_id], [salary], [date_update_salary]) VALUES (N'c4aadce5-3e97-4958-b741-788430c91db4', N'Sale-02', N'sale02@gmail.com', N'123456', N'0844111006', N'https://firebasestorage.googleapis.com/v0/b/ministoregrprjprn231.appspot.com/o/Sale-02-19c6e77a-a794-44b4-9056-cd89df1bc187?alt=media&token=c41bdf3b-7242-4022-a173-c36146512c0c', N'KTX Khu B ÐHQG', CAST(N'2001-11-04' AS Date), CAST(N'2023-07-06T14:21:59.817' AS DateTime), NULL, 1, 0, 1, NULL, 1, 2, NULL, NULL)
GO
SET ANSI_PADDING ON
GO

/*CONSTRAINTS*/
/****** Object:  Index [UQ__User__AB6E6164A7153C8D]    Script Date: 7/6/2023 3:12:37 PM ******/
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
USE [master]
GO
ALTER DATABASE [MiniStore2] SET READ_WRITE 
GO
