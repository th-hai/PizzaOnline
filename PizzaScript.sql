USE [master]
GO
/****** Object:  Database [Pizza]    Script Date: 12/21/2019 7:39:28 PM ******/
CREATE DATABASE [Pizza]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'Pizza', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.SQLEXPRESS\MSSQL\DATA\Pizza.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'Pizza_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.SQLEXPRESS\MSSQL\DATA\Pizza_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
GO
ALTER DATABASE [Pizza] SET COMPATIBILITY_LEVEL = 140
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [Pizza].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [Pizza] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [Pizza] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [Pizza] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [Pizza] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [Pizza] SET ARITHABORT OFF 
GO
ALTER DATABASE [Pizza] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [Pizza] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [Pizza] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [Pizza] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [Pizza] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [Pizza] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [Pizza] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [Pizza] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [Pizza] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [Pizza] SET  DISABLE_BROKER 
GO
ALTER DATABASE [Pizza] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [Pizza] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [Pizza] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [Pizza] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [Pizza] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [Pizza] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [Pizza] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [Pizza] SET RECOVERY FULL 
GO
ALTER DATABASE [Pizza] SET  MULTI_USER 
GO
ALTER DATABASE [Pizza] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [Pizza] SET DB_CHAINING OFF 
GO
ALTER DATABASE [Pizza] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [Pizza] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [Pizza] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [Pizza] SET QUERY_STORE = OFF
GO
USE [Pizza]
GO
/****** Object:  Table [dbo].[Admin]    Script Date: 12/21/2019 7:39:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Admin](
	[AdminID] [int] IDENTITY(1,1) NOT NULL,
	[AdminName] [varchar](50) NOT NULL,
	[Password] [varchar](50) NOT NULL,
	[FullName] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_User] PRIMARY KEY CLUSTERED 
(
	[AdminID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Category]    Script Date: 12/21/2019 7:39:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Category](
	[CategoryID] [int] IDENTITY(1,1) NOT NULL,
	[CategoryName] [nvarchar](100) NOT NULL,
 CONSTRAINT [PK_Category] PRIMARY KEY CLUSTERED 
(
	[CategoryID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Customer]    Script Date: 12/21/2019 7:39:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Customer](
	[CustomerID] [int] IDENTITY(1,1) NOT NULL,
	[CustomerName] [varchar](50) NOT NULL,
	[Password] [varchar](50) NOT NULL,
	[FullName] [nvarchar](50) NOT NULL,
	[Address] [nvarchar](80) NOT NULL,
	[PhoneNumber] [varchar](12) NOT NULL,
 CONSTRAINT [PK_Customer] PRIMARY KEY CLUSTERED 
(
	[CustomerID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Order]    Script Date: 12/21/2019 7:39:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Order](
	[OrderID] [int] IDENTITY(1,1) NOT NULL,
	[CustomerID] [int] NOT NULL,
	[Total] [int] NOT NULL,
 CONSTRAINT [PK_Bill] PRIMARY KEY CLUSTERED 
(
	[OrderID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[OrderDetail]    Script Date: 12/21/2019 7:39:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OrderDetail](
	[OrderDetailID] [int] IDENTITY(1,1) NOT NULL,
	[OrderID] [int] NOT NULL,
	[ProductID] [int] NOT NULL,
	[Quantity] [int] NOT NULL,
	[Price] [int] NOT NULL,
 CONSTRAINT [PK_OrderDetail] PRIMARY KEY CLUSTERED 
(
	[OrderDetailID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Product]    Script Date: 12/21/2019 7:39:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Product](
	[ProductID] [int] IDENTITY(1,1) NOT NULL,
	[ProductName] [nvarchar](100) NOT NULL,
	[Description] [nvarchar](800) NULL,
	[CategoryID] [int] NOT NULL,
	[Price] [int] NOT NULL,
	[ImageURL] [nvarchar](300) NULL,
 CONSTRAINT [PK_pizza] PRIMARY KEY CLUSTERED 
(
	[ProductID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Admin] ON 

INSERT [dbo].[Admin] ([AdminID], [AdminName], [Password], [FullName]) VALUES (1, N'admin', N'admin', N'Thanh Hai')
SET IDENTITY_INSERT [dbo].[Admin] OFF
SET IDENTITY_INSERT [dbo].[Category] ON 

INSERT [dbo].[Category] ([CategoryID], [CategoryName]) VALUES (1, N'Pizza')
INSERT [dbo].[Category] ([CategoryID], [CategoryName]) VALUES (2, N'Drink')
SET IDENTITY_INSERT [dbo].[Category] OFF
SET IDENTITY_INSERT [dbo].[Customer] ON 

INSERT [dbo].[Customer] ([CustomerID], [CustomerName], [Password], [FullName], [Address], [PhoneNumber]) VALUES (1, N'customer1', N'customer1', N'Son', N'Thu Duc', N'123456')
INSERT [dbo].[Customer] ([CustomerID], [CustomerName], [Password], [FullName], [Address], [PhoneNumber]) VALUES (2, N'customer2', N'customer2', N'Customer 2', N'Linh Trung', N'0947434666')
INSERT [dbo].[Customer] ([CustomerID], [CustomerName], [Password], [FullName], [Address], [PhoneNumber]) VALUES (1002, N'customer3', N'customer3', N'Nguyễn Thanh Hải', N'Ho Chi Minh City', N'0987654321')
INSERT [dbo].[Customer] ([CustomerID], [CustomerName], [Password], [FullName], [Address], [PhoneNumber]) VALUES (2003, N'thanhhai', N'22121999', N'Nguyễn Thanh Hải', N'Dak Lak', N'0947434666')
SET IDENTITY_INSERT [dbo].[Customer] OFF
SET IDENTITY_INSERT [dbo].[Order] ON 

INSERT [dbo].[Order] ([OrderID], [CustomerID], [Total]) VALUES (2, 2, 338000)
INSERT [dbo].[Order] ([OrderID], [CustomerID], [Total]) VALUES (3, 2, 300000)
INSERT [dbo].[Order] ([OrderID], [CustomerID], [Total]) VALUES (4, 2003, 219000)
INSERT [dbo].[Order] ([OrderID], [CustomerID], [Total]) VALUES (5, 1, 310000)
INSERT [dbo].[Order] ([OrderID], [CustomerID], [Total]) VALUES (6, 1, 738000)
SET IDENTITY_INSERT [dbo].[Order] OFF
SET IDENTITY_INSERT [dbo].[OrderDetail] ON 

INSERT [dbo].[OrderDetail] ([OrderDetailID], [OrderID], [ProductID], [Quantity], [Price]) VALUES (1, 3, 6, 2, 100000)
INSERT [dbo].[OrderDetail] ([OrderDetailID], [OrderID], [ProductID], [Quantity], [Price]) VALUES (2, 3, 8, 1, 100000)
INSERT [dbo].[OrderDetail] ([OrderDetailID], [OrderID], [ProductID], [Quantity], [Price]) VALUES (3, 4, 6, 1, 100000)
INSERT [dbo].[OrderDetail] ([OrderDetailID], [OrderID], [ProductID], [Quantity], [Price]) VALUES (4, 4, 7, 1, 119000)
INSERT [dbo].[OrderDetail] ([OrderDetailID], [OrderID], [ProductID], [Quantity], [Price]) VALUES (5, 5, 2, 2, 100000)
INSERT [dbo].[OrderDetail] ([OrderDetailID], [OrderID], [ProductID], [Quantity], [Price]) VALUES (6, 5, 8, 1, 100000)
INSERT [dbo].[OrderDetail] ([OrderDetailID], [OrderID], [ProductID], [Quantity], [Price]) VALUES (7, 5, 1009, 1, 10000)
INSERT [dbo].[OrderDetail] ([OrderDetailID], [OrderID], [ProductID], [Quantity], [Price]) VALUES (8, 6, 2, 1, 100000)
INSERT [dbo].[OrderDetail] ([OrderDetailID], [OrderID], [ProductID], [Quantity], [Price]) VALUES (9, 6, 4, 2, 319000)
SET IDENTITY_INSERT [dbo].[OrderDetail] OFF
SET IDENTITY_INSERT [dbo].[Product] ON 

INSERT [dbo].[Product] ([ProductID], [ProductName], [Description], [CategoryID], [Price], [ImageURL]) VALUES (1, N'Bread Pizza', N'Pizza Bánh Mì', 1, 100000, N'/ProductsImages/637122864376118328_bread-pizza.jpg')
INSERT [dbo].[Product] ([ProductID], [ProductName], [Description], [CategoryID], [Price], [ImageURL]) VALUES (2, N'Apple Pizza', N'Pizza Apple', 1, 100000, N'/ProductsImages/637122864545102266_apple-pie-pizza.jpg')
INSERT [dbo].[Product] ([ProductID], [ProductName], [Description], [CategoryID], [Price], [ImageURL]) VALUES (3, N'Seafood Pesto', N'Seafood Pesto pizza with our signature secret recipe Pesto sauce is boldly an "Italian-style connoisseur dish: Make you feel different at first sight, but once you "touch" you''ll fall in love immediately, as far as memorable.', 1, 169000, N'/ProductsImages/637122959564169523_ms-pesto.jpg')
INSERT [dbo].[Product] ([ProductID], [ProductName], [Description], [CategoryID], [Price], [ImageURL]) VALUES (4, N'Pizza Monthong Durian', N'The new and unique combination between Monthong Durian''s yellow-rice meat, fatty aroma,&nbsp; sweet taste. and Mozzarella cheese filled.', 1, 319000, N'/ProductsImages/637123010294912540_monthong-durian-pizza.jpg')
INSERT [dbo].[Product] ([ProductID], [ProductName], [Description], [CategoryID], [Price], [ImageURL]) VALUES (5, N'Pizza Aloha', N'Another one of our most delicious pizza recipes that surely tickle your taste buds with ham, pepperoni, pork sausage and juicy pineapple with Thousand Island sauce.', 1, 119000, N'/ProductsImages/637123447917402338_hawaii.jpg')
INSERT [dbo].[Product] ([ProductID], [ProductName], [Description], [CategoryID], [Price], [ImageURL]) VALUES (6, N'Hawaiian', N'A yummy combination of the sweet and sour flavor of juicy pineapples with loads of ham and bacon. It''s truly Hawaiian pizza!', 1, 100000, N'/ProductsImages/637123447335906815_hawaiian.jpg')
INSERT [dbo].[Product] ([ProductID], [ProductName], [Description], [CategoryID], [Price], [ImageURL]) VALUES (7, N'Chicken Trio', N'If you are mad for chicken, don''t miss this one! Topped with golden grilled chicken seasoned to perfection to go with pineapple, red and green capsicum one is never enough.', 1, 119000, N'/ProductsImages/637123448639796237_chicken trio.jpg')
INSERT [dbo].[Product] ([ProductID], [ProductName], [Description], [CategoryID], [Price], [ImageURL]) VALUES (8, N'Ham & Mushroom', N'A simple pleasure in every bite with Pizza Ham and Mushroom', 1, 100000, N'/ProductsImages/637123449890782833_hamandmushroom.jpg')
INSERT [dbo].[Product] ([ProductID], [ProductName], [Description], [CategoryID], [Price], [ImageURL]) VALUES (9, N'Chicken Caldo', N'If you are mad for chicken, don''t miss this one! Topped with golden grilled chicken seasoned to perfection to go with pineapple, red and green capsicum one is never enough. ', 1, 100000, N'/ProductsImages/637123450921458217_chicken-caldo.jpg')
INSERT [dbo].[Product] ([ProductID], [ProductName], [Description], [CategoryID], [Price], [ImageURL]) VALUES (10, N'Double Pepperoni', N'For Pepperoni lover, so many spicy Pepperoni and cheese combined with Tomato sauce', 1, 100000, N'/ProductsImages/637123451908353103_double-pepperoni.jpg')
INSERT [dbo].[Product] ([ProductID], [ProductName], [Description], [CategoryID], [Price], [ImageURL]) VALUES (11, N'Veggie', N'For vegetable fans! The healthy choice is full of fresh onions, green capsicums, mushrooms, pineapples, tomatoes, and corns.', 1, 100000, N'/ProductsImages/637123454411846938_veggie.jpg')
INSERT [dbo].[Product] ([ProductID], [ProductName], [Description], [CategoryID], [Price], [ImageURL]) VALUES (12, N'Canadian Bacon', N'A Canadian style pizza that comes with lots of ham, bacon bits, and corns. Very satisfying.', 1, 120000, N'/ProductsImages/637123459953667373_canadian-bacon.jpg')
INSERT [dbo].[Product] ([ProductID], [ProductName], [Description], [CategoryID], [Price], [ImageURL]) VALUES (13, N'Super Deluxe', N'We pick the tastiest ingredients and create this sensational menu! Everything from pork sausages, Italian sausages, pepperoni, ham, bacon, onions, green capsicums, mushrooms, and pineapples. That why our team calls it "Super Deluxe".', 1, 120000, N'/ProductsImages/637123462230642439_super-deluxe.jpg')
INSERT [dbo].[Product] ([ProductID], [ProductName], [Description], [CategoryID], [Price], [ImageURL]) VALUES (14, N'Meat Deluxe', N'For all meat lovers! You''ll love our chunky pork and Italian sausages, pepperoni, ham, bacon and bacon bits. Satisfaction guaranteed in every bite.
&nbsp;', 1, 120000, N'/ProductsImages/637123463121900861_meat-deluxe.jpg')
INSERT [dbo].[Product] ([ProductID], [ProductName], [Description], [CategoryID], [Price], [ImageURL]) VALUES (1006, N'Bacon Super Delight', N'Italian sausages, bacon, ham, green capsicums and tomatoes. Delightful until the very last piece.
&nbsp;', 1, 120000, N'/ProductsImages/637123993385406913_bacon-super-delight.jpg')
INSERT [dbo].[Product] ([ProductID], [ProductName], [Description], [CategoryID], [Price], [ImageURL]) VALUES (1007, N'Seafood Deluxe', N'Topped with lots of fresh Prawn, crab sticks and calamari with Mariana sauce. It''s a real seafood parade!
&nbsp;', 1, 150000, N'/ProductsImages/637123994617443303_seafood-deluxe.jpg')
INSERT [dbo].[Product] ([ProductID], [ProductName], [Description], [CategoryID], [Price], [ImageURL]) VALUES (1008, N'Coca Cola', N'You all know about me so that I don''t need to introduce myself right?
&nbsp;', 2, 10000, N'/ProductsImages/637124004808832209_coca-cola.png')
INSERT [dbo].[Product] ([ProductID], [ProductName], [Description], [CategoryID], [Price], [ImageURL]) VALUES (1009, N'Pepsi', N'Pepsi
&nbsp;', 2, 10000, N'/ProductsImages/637124340126500003_pepsi.png')
INSERT [dbo].[Product] ([ProductID], [ProductName], [Description], [CategoryID], [Price], [ImageURL]) VALUES (1010, N'Wake Up 24/7', N'Wake Up 24/7.
&nbsp;', 2, 11000, N'/ProductsImages/637125291832448946_wakeup247.png')
SET IDENTITY_INSERT [dbo].[Product] OFF
ALTER TABLE [dbo].[Order]  WITH CHECK ADD  CONSTRAINT [FK_Order_Customer] FOREIGN KEY([CustomerID])
REFERENCES [dbo].[Customer] ([CustomerID])
GO
ALTER TABLE [dbo].[Order] CHECK CONSTRAINT [FK_Order_Customer]
GO
ALTER TABLE [dbo].[OrderDetail]  WITH CHECK ADD  CONSTRAINT [FK_OrderDetail_Order] FOREIGN KEY([OrderID])
REFERENCES [dbo].[Order] ([OrderID])
GO
ALTER TABLE [dbo].[OrderDetail] CHECK CONSTRAINT [FK_OrderDetail_Order]
GO
ALTER TABLE [dbo].[OrderDetail]  WITH CHECK ADD  CONSTRAINT [FK_OrderDetail_Product] FOREIGN KEY([ProductID])
REFERENCES [dbo].[Product] ([ProductID])
GO
ALTER TABLE [dbo].[OrderDetail] CHECK CONSTRAINT [FK_OrderDetail_Product]
GO
ALTER TABLE [dbo].[Product]  WITH CHECK ADD  CONSTRAINT [FK_Product_Category] FOREIGN KEY([CategoryID])
REFERENCES [dbo].[Category] ([CategoryID])
GO
ALTER TABLE [dbo].[Product] CHECK CONSTRAINT [FK_Product_Category]
GO
USE [master]
GO
ALTER DATABASE [Pizza] SET  READ_WRITE 
GO
