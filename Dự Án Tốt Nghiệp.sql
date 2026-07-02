-- ==========================================
-- 1. KHỞI TẠO CƠ SỞ DỮ LIỆU
-- ==========================================
CREATE DATABASE ComputerStoreEnterpriseDB;
GO

USE ComputerStoreEnterpriseDB;
GO

-- ==========================================
-- 2. TẠO CÁC BẢNG ĐỘC LẬP (BẢNG CHA / KHÔNG PHỤ THUỘC KHÓA NGOẠI)
-- ==========================================

CREATE TABLE Roles (
    RoleID INT IDENTITY(1,1) PRIMARY KEY,
    RoleName NVARCHAR(50) NOT NULL UNIQUE,
    Description NVARCHAR(255)
);

CREATE TABLE Categories (
    CategoryID INT IDENTITY(1,1) PRIMARY KEY,
    CategoryName NVARCHAR(100) NOT NULL UNIQUE,
    ParentCategoryID INT NULL,
    Description NVARCHAR(255),
    Slug VARCHAR(150) UNIQUE,
    CONSTRAINT FK_Categories_Parent FOREIGN KEY (ParentCategoryID) REFERENCES Categories(CategoryID)
);

CREATE TABLE Brands (
    BrandID INT IDENTITY(1,1) PRIMARY KEY,
    BrandName NVARCHAR(100) NOT NULL UNIQUE,
    LogoURL VARCHAR(255),
    Country NVARCHAR(100)
);

CREATE TABLE Vouchers (
    VoucherID INT IDENTITY(1,1) PRIMARY KEY,
    VoucherCode VARCHAR(50) NOT NULL UNIQUE, 
    Description NVARCHAR(255),
    DiscountType VARCHAR(20) NOT NULL,
    DiscountValue DECIMAL(18,2) NOT NULL CHECK (DiscountValue > 0),
    MaxDiscountAmount DECIMAL(18,2) NULL,
    MinOrderValue DECIMAL(18,2) DEFAULT 0,
    StartDate DATETIME NOT NULL,
    EndDate DATETIME NOT NULL,
    UsageLimit INT NOT NULL,
    UsedCount INT DEFAULT 0,
    Status BIT DEFAULT 1
);

CREATE TABLE Banners (
    BannerID INT IDENTITY(1,1) PRIMARY KEY,
    Title NVARCHAR(150) NOT NULL, 
    ImageURL VARCHAR(255) NOT NULL, 
    Position VARCHAR(20) NOT NULL CHECK (Position IN ('LEFT', 'RIGHT')), 
    TargetLink VARCHAR(255) NULL, 
    StartDate DATETIME NOT NULL,
    EndDate DATETIME NOT NULL,
    IsActive BIT DEFAULT 1, 
    CreatedAt DATETIME DEFAULT GETDATE()
);

-- ==========================================
-- 3. TẠO CÁC BẢNG CẤP 1 (PHỤ THUỘC TRỰC TIẾP VÀO BẢNG CHA)
-- ==========================================

CREATE TABLE Users (
    UserID INT IDENTITY(1,1) PRIMARY KEY,
    Username VARCHAR(50) NOT NULL UNIQUE,
    PasswordHash VARCHAR(255) NOT NULL,
    FullName NVARCHAR(100) NOT NULL,
    Email VARCHAR(100) UNIQUE,
    Phone VARCHAR(15) UNIQUE,
    CoverUrl NVARCHAR(500) NULL, -- ĐÃ THÊM ĐỂ KHỚP VỚI ENTITY VÀ FIX LỖI PROFILE
    RoleID INT NOT NULL,
    IsActive BIT DEFAULT 1,
    CreatedAt DATETIME DEFAULT GETDATE(),
    UpdatedAt DATETIME DEFAULT GETDATE(),
    CONSTRAINT FK_Users_Roles FOREIGN KEY (RoleID) REFERENCES Roles(RoleID)
);

CREATE TABLE Products (
    ProductID INT IDENTITY(1,1) PRIMARY KEY,
    ProductName NVARCHAR(200) NOT NULL,
    CategoryID INT NOT NULL,
    BrandID INT NOT NULL,
    OriginalPrice DECIMAL(18,2) NOT NULL CHECK (OriginalPrice >= 0),
    SellPrice DECIMAL(18,2) NOT NULL CHECK (SellPrice >= 0),
    DiscountPrice DECIMAL(18,2) NULL CHECK (DiscountPrice >= 0),
    MainImageURL VARCHAR(255) NOT NULL,
    DescriptionText NVARCHAR(MAX),
    WarrantyMonths INT NOT NULL DEFAULT 12,
    StockQuantity INT NOT NULL DEFAULT 0, 
    Status INT DEFAULT 1,
    CreatedAt DATETIME DEFAULT GETDATE(),
    CONSTRAINT FK_Products_Categories FOREIGN KEY (CategoryID) REFERENCES Categories(CategoryID),
    CONSTRAINT FK_Products_Brands FOREIGN KEY (BrandID) REFERENCES Brands(BrandID)
);

CREATE TABLE SystemLogs (
    LogID INT IDENTITY(1,1) PRIMARY KEY,
    UserID INT NULL, 
    LogLevel VARCHAR(20) DEFAULT 'INFO', 
    LogMessage NVARCHAR(500) NOT NULL,
    CreatedAt DATETIME DEFAULT GETDATE(),
    CONSTRAINT FK_SystemLogs_Users FOREIGN KEY (UserID) REFERENCES Users(UserID) ON DELETE SET NULL
);

-- ==========================================
-- 4. TẠO CÁC BẢNG CẤP 2 (PHỤ THUỘC NHIỀU KHÓA NGOẠI / BẢNG CON)
-- ==========================================

CREATE TABLE UserAddresses (
    AddressID INT IDENTITY(1,1) PRIMARY KEY,
    UserID INT NOT NULL,
    RecipientName NVARCHAR(100) NOT NULL,
    Phone VARCHAR(15) NOT NULL,
    ProvinceName NVARCHAR(100) NOT NULL,
    DistrictName NVARCHAR(100) NOT NULL,
    WardName NVARCHAR(100) NOT NULL,
    AddressText NVARCHAR(255) NOT NULL, -- ĐÃ ĐỔI TỪ DetailedAddress THÀNH AddressText CHO KHỚP DAO
    IsDefault BIT DEFAULT 0,
    CONSTRAINT FK_UserAddresses_Users FOREIGN KEY (UserID) REFERENCES Users(UserID) ON DELETE CASCADE
);

CREATE TABLE ProductImages (
    ImageID INT IDENTITY(1,1) PRIMARY KEY,
    ProductID INT NOT NULL,
    ImageURL NVARCHAR(MAX) NOT NULL,
    DisplayOrder INT DEFAULT 1,
    CONSTRAINT FK_ProductImages_Products FOREIGN KEY (ProductID) REFERENCES Products(ProductID) ON DELETE CASCADE
);

CREATE TABLE Cart (
    CartID INT IDENTITY(1,1) PRIMARY KEY,
    UserID INT NOT NULL UNIQUE,
    CreatedAt DATETIME DEFAULT GETDATE(),
    UpdatedAt DATETIME DEFAULT GETDATE(),
    CONSTRAINT FK_Cart_Users FOREIGN KEY (UserID) REFERENCES Users(UserID) ON DELETE CASCADE
);

CREATE TABLE Bills (
    BillID INT IDENTITY(1,1) PRIMARY KEY,
    UserID INT NOT NULL,
    OrderDate DATETIME DEFAULT GETDATE(),
    ShippingRecipientName NVARCHAR(100) NOT NULL,
    ShippingPhone VARCHAR(15) NOT NULL,
    ShippingAddressText NVARCHAR(500) NOT NULL,
    TotalAmount DECIMAL(18,2) NOT NULL, 
    VoucherCode VARCHAR(50) NULL,        
    OrderStatus NVARCHAR(50) DEFAULT N'Pending',
    Notes NVARCHAR(255),
    CONSTRAINT FK_Bills_Users FOREIGN KEY (UserID) REFERENCES Users(UserID),
    CONSTRAINT FK_Bills_Vouchers FOREIGN KEY (VoucherCode) REFERENCES Vouchers(VoucherCode) 
);

CREATE TABLE Reviews (
    ReviewID INT IDENTITY(1,1) PRIMARY KEY,
    UserID INT NOT NULL,
    ProductID INT NOT NULL,
    Rating INT NOT NULL CHECK (Rating BETWEEN 1 AND 5),
    Comment NVARCHAR(MAX),
    CreatedAt DATETIME DEFAULT GETDATE(),
    CONSTRAINT FK_Reviews_Users FOREIGN KEY (UserID) REFERENCES Users(UserID),
    CONSTRAINT FK_Reviews_Products FOREIGN KEY (ProductID) REFERENCES Products(ProductID) ON DELETE CASCADE
);

-- ==========================================
-- 5. TẠO CÁC BẢNG CHI TIẾT (BẢNG TRUNG GIAN / NHÁNH CUỐI)
-- ==========================================

CREATE TABLE CartDetails (
    CartDetailID INT IDENTITY(1,1) PRIMARY KEY,
    CartID INT NOT NULL,
    ProductID INT NOT NULL,
    Quantity INT NOT NULL CHECK (Quantity > 0),
    CONSTRAINT FK_CartDetails_Cart FOREIGN KEY (CartID) REFERENCES Cart(CartID) ON DELETE CASCADE,
    CONSTRAINT FK_CartDetails_Products FOREIGN KEY (ProductID) REFERENCES Products(ProductID) ON DELETE CASCADE,
    CONSTRAINT UC_Cart_Product UNIQUE (CartID, ProductID)
);

CREATE TABLE BillDetails (
    BillDetailID INT IDENTITY(1,1) PRIMARY KEY,
    BillID INT NOT NULL,
    ProductID INT NOT NULL,
    Quantity INT NOT NULL CHECK (Quantity > 0),
    PriceAtSale DECIMAL(18,2) NOT NULL,
    CONSTRAINT FK_BillDetails_Bills FOREIGN KEY (BillID) REFERENCES Bills(BillID) ON DELETE CASCADE,
    CONSTRAINT FK_BillDetails_Products FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);

CREATE TABLE Payments (
    PaymentID INT IDENTITY(1,1) PRIMARY KEY,
    BillID INT NOT NULL,
    PaymentMethod NVARCHAR(50) NOT NULL,
    PaymentStatus NVARCHAR(50) DEFAULT N'Pending',
    Amount DECIMAL(18,2) NOT NULL, 
    TransactionCode NVARCHAR(100) NULL,
    PaymentDate DATETIME NULL,
    CreatedAt DATETIME DEFAULT GETDATE(),
    CONSTRAINT FK_Payments_Bills FOREIGN KEY (BillID) REFERENCES Bills(BillID) 
);
GO

-- ==========================================
-- 6. TẠO INDEX TỐI ƯU TRUY VẤN
-- ==========================================
CREATE INDEX IX_Products_Category_Brand ON Products(CategoryID, BrandID);
CREATE INDEX IX_Vouchers_Code_Dates ON Vouchers(VoucherCode, StartDate, EndDate) WHERE Status = 1;
GO

-- ==========================================
-- 7. THÊM DỮ LIỆU MẪU (SEED DATA)
-- ==========================================

-- Chèn dữ liệu bảng Roles
INSERT INTO Roles(RoleName, Description) VALUES
(N'Owner', N'Chủ sở hữu hệ thống'),
(N'Admin', N'Quản trị viên'),
(N'Customer', N'Khách hàng'),
(N'Guest', N'Khách viếng thăm');

-- Chèn dữ liệu bảng Users
INSERT INTO Users (Username, PasswordHash, FullName, Email, Phone, RoleID) VALUES
('owner02','123456','Vo Hoang Long','Hoanglong@gmail.com','0901234122',1),
('admin03','123456','Tran Tuan Phat','Phat@gmail.com','0900000022',2),
('admin04','123456','Bui Minh Quang','Quang@gmail.com','0900000011',2),
('user08','123456','Tran Huynh Gia Bao','Bao@gmail.com','09000000344',3),
('user09','123456','Huynh Chau','Chau@gmail.com','0900000013',3),
('user10','123456','Le Van An','An@gmail.com','0900000054',3),
('user11','123456','Pham Thi Hong','Hong@gmail.com','0900000023',3),
('user12','123456','Hoang Van Tai','Tai@gmail.com','0900000014',3),
('user13','123456','Do Thi Hoa','Hoa@gmail.com','0900000059',3),
('user14','123456','Vo Van Kien','Kien@gmail.com','0900000310',3);

-- Chèn dữ liệu bảng Categories
INSERT INTO Categories (CategoryName, Description, Slug) VALUES
(N'CPU', N'Bộ xử lý trung tâm', 'cpu'),
(N'RAM', N'Bộ nhớ trong máy tính', 'ram'),
(N'VGA', N'Card đồ họa', 'vga'),
(N'SSD', N'Ổ cứng thể rắn', 'ssd'),
(N'Mainboard', N'Bo mạch chủ', 'mainboard');

-- Chèn dữ liệu bảng Brands
INSERT INTO Brands (BrandName, Country) VALUES
('Intel', N'USA'), ('AMD', N'USA'), ('ASUS', N'Taiwan'),
('MSI', N'Taiwan'), ('Kingston', N'USA');

-- Chèn dữ liệu bảng Vouchers
INSERT INTO Vouchers (VoucherCode, Description, DiscountType, DiscountValue, MinOrderValue, StartDate, EndDate, UsageLimit, UsedCount, Status) VALUES
('CYBERMIND', N'Giảm trực tiếp tiền mặt 200k', 'FIXED', 200000.00, 500000.00, '2026-01-01', '2026-12-31', 100, 0, 1),
('HELLOSUMMER', N'Giảm 100k cho mọi đơn hàng', 'FIXED', 100000.00, 200000.00, '2026-01-01', '2026-12-31', 50, 0, 1);

-- Chèn dữ liệu bảng Products
INSERT INTO Products (ProductName, CategoryID, BrandID, OriginalPrice, SellPrice, MainImageURL, DescriptionText, StockQuantity) VALUES
-- CPU
(N'Intel Core i3-12100F',1,1,2200000,2590000,'cpu1.jpg',N'CPU Intel Gen 12', 10),
(N'Intel Core i5-12400F',1,1,3500000,3990000,'cpu2.jpg',N'CPU Intel Gen 12', 15),
(N'Intel Core i5-14400F',1,1,4800000,5490000,'cpu3.jpg',N'CPU Intel Gen 14', 20),
(N'Intel Core i7-14700K',1,1,9800000,10990000,'cpu4.jpg',N'CPU Intel i7', 5),
(N'AMD Ryzen 5 5600',1,2,2800000,3290000,'cpu5.jpg',N'AMD Ryzen 5', 12),
(N'AMD Ryzen 7 5700X',1,2,4500000,5190000,'cpu6.jpg',N'AMD Ryzen 7', 8),
-- RAM
(N'Kingston Fury 8GB DDR4',2,5,650000,790000,'ram1.jpg',N'RAM DDR4 8GB', 30),
(N'Kingston Fury 16GB DDR4',2,5,1200000,1390000,'ram2.jpg',N'RAM DDR4 16GB', 25),
(N'Kingston Fury 16GB DDR5',2,5,1800000,2090000,'ram3.jpg',N'RAM DDR5 16GB', 20),
(N'Kingston Fury 32GB DDR5',2,5,3500000,3990000,'ram4.jpg',N'RAM DDR5 32GB', 10),
(N'Kingston Beast RGB 16GB',2,5,1900000,2290000,'ram5.jpg',N'RAM RGB', 15),
(N'Kingston Beast RGB 32GB',2,5,3800000,4390000,'ram6.jpg',N'RAM RGB 32GB', 10),
-- VGA
(N'ASUS RTX 3050 8GB',3,3,5200000,5990000,'vga1.jpg',N'Card đồ họa RTX 3050', 5),
(N'ASUS RTX 4060 8GB',3,3,7600000,8590000,'vga2.jpg',N'Card đồ họa RTX 4060', 10),
(N'ASUS RTX 4060Ti 8GB',3,3,10500000,11990000,'vga3.jpg',N'Card đồ họa RTX 4060Ti', 8),
(N'MSI RTX 4060 8GB',3,4,7500000,8490000,'vga4.jpg',N'Card đồ họa MSI', 12),
(N'MSI RTX 4070 12GB',3,4,14500000,15990000,'vga5.jpg',N'Card đồ họa RTX 4070', 4),
(N'ASUS RTX 5070 12GB',3,3,19900000,21990000,'vga6.jpg',N'Card đồ họa RTX 5070', 2),
-- SSD
(N'Kingston NV2 500GB',4,5,850000,990000,'ssd1.jpg',N'SSD NVMe 500GB', 50),
(N'Kingston NV2 1TB',4,5,1450000,1690000,'ssd2.jpg',N'SSD NVMe 1TB', 40),
(N'Kingston KC3000 1TB',4,5,2100000,2490000,'ssd3.jpg',N'SSD PCIe Gen4', 20),
(N'Kingston KC3000 2TB',4,5,3900000,4390000,'ssd4.jpg',N'SSD PCIe Gen4 2TB', 10),
(N'Kingston A400 480GB',4,5,650000,790000,'ssd5.jpg',N'SSD SATA 480GB', 30),
(N'Kingston A400 960GB',4,5,1300000,1490000,'ssd6.jpg',N'SSD SATA 960GB', 25),
-- Mainboard
(N'ASUS Prime H610M-K',5,3,1700000,1990000,'mb1.jpg',N'Mainboard Intel', 20),
(N'ASUS B760M-A',5,3,2900000,3390000,'mb2.jpg',N'Mainboard Intel B760', 15),
(N'MSI PRO H610M-G',5,4,1600000,1890000,'mb3.jpg',N'Mainboard MSI', 18),
(N'MSI B760M Mortar',5,4,3900000,4490000,'mb4.jpg',N'Mainboard Gaming', 10),
(N'ASUS TUF B760M Plus',5,3,4200000,4890000,'mb5.jpg',N'Mainboard TUF', 12),
(N'MSI MAG B650 Tomahawk',5,4,5200000,5990000,'mb6.jpg',N'Mainboard AMD', 8);

-- Chèn dữ liệu bảng SystemLogs
INSERT INTO SystemLogs (LogLevel, LogMessage) VALUES 
('INFO', N'Hệ thống CyberCore Application Server khởi động thành công.'),
('INFO', N'Kết nối cơ sở dữ liệu SQL Server: SUCCESS.'),
('WARN', N'Cảnh báo: CPU Intel Core i9-14900K tồn kho dưới mức an toàn.');

-- Chèn dữ liệu bảng Banners
INSERT INTO Banners (Title, ImageURL, Position, TargetLink, StartDate, EndDate, IsActive) VALUES 
(N'Siêu Sale 1/7 - Bên Trái', 'banner_left_0107.jpg', 'LEFT', '/CyberCore/voucher', '2026-06-30', '2026-07-05', 1),
(N'Siêu Sale 1/7 - Bên Phải', 'banner_right_0107.jpg', 'RIGHT', '/CyberCore/product', '2026-06-30', '2026-07-05', 1);
GO
