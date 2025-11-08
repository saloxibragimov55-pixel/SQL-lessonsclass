IF DB_ID(N'TaxiCompanyDB') IS NULL
BEGIN
    CREATE DATABASE TaxiCompanyDB;
END
GO

USE TaxiCompanyDB;
GO

CREATE TABLE dbo.CarTypes
(
    CarTypeID INT IDENTITY(1,1) PRIMARY KEY, -- КодТипаАвто
    TypeName NVARCHAR(50) NOT NULL,          -- НазваниеТипа
    Capacity INT NOT NULL                    -- Вместимость
);
GO

CREATE TABLE dbo.Cars
(
    CarID INT IDENTITY(1,1) PRIMARY KEY,    -- КодАвто
    CarTypeID INT NULL,                     -- КодТипаАвто (FK)
    Model NVARCHAR(100) NOT NULL,           -- Модель
    PlateNumber NVARCHAR(20) NOT NULL,      -- ГосНомер
    Year INT NULL,                          -- ГодВыпуска
    Status NVARCHAR(20) NOT NULL DEFAULT('active') -- Статус (active, in_repair, retired, etc.)
);

ALTER TABLE dbo.Cars
    ADD CONSTRAINT UQ_Cars_PlateNumber UNIQUE(PlateNumber);
GO

CREATE TABLE dbo.Passengers
(
    PassengerID INT IDENTITY(1,1) PRIMARY KEY, -- КодПассажира
    Name NVARCHAR(100) NOT NULL,
    Phone NVARCHAR(20) NULL,
    Email NVARCHAR(100) NULL
);
GO

CREATE TABLE dbo.Drivers
(
    DriverID INT IDENTITY(1,1) PRIMARY KEY, -- КодВодителя
    Name NVARCHAR(100) NOT NULL,
    Phone NVARCHAR(20) NULL,
    LicenseNumber NVARCHAR(50) NULL,
    HireDate DATE NULL,
    Status NVARCHAR(20) NOT NULL DEFAULT('active'), -- active, fired, on_leave
    CarID INT NULL -- Автомобиль закрепленный за водителем (может быть NULL)
);
GO

CREATE TABLE dbo.Bookings
(
    BookingID INT IDENTITY(1,1) PRIMARY KEY,  -- КодЗаказа
    PassengerID INT NOT NULL,                 -- КодПассажира
    DriverID INT NULL,                        -- КодВодителя (назначенный)
    CarID INT NULL,                           -- КодАвто (использованный)
    PickupLocation NVARCHAR(200) NOT NULL,    -- МестоОтправления
    DropoffLocation NVARCHAR(200) NOT NULL,   -- МестоНазначения
    BookingTime DATETIME NOT NULL DEFAULT(GETDATE()), -- ВремяЗаказа
    Status NVARCHAR(20) NOT NULL DEFAULT('open')     -- Статус заказа (open, completed, cancelled)
);
GO

CREATE TABLE dbo.Routes
(
    RouteID INT IDENTITY(1,1) PRIMARY KEY, -- КодМаршрута
    BookingID INT NULL,                    -- КодЗаказа (FK)
    Distance_km DECIMAL(6,2) NULL,        -- Расстояние в км
    StartTime DATETIME NULL,
    EndTime DATETIME NULL,
    Fare DECIMAL(10,2) NULL
);
GO

CREATE TABLE dbo.Payments
(
    PaymentID INT IDENTITY(1,1) PRIMARY KEY, -- КодПлатежа
    RouteID INT NULL,                         -- КодМаршрута
    PaymentMethod NVARCHAR(30) NOT NULL,      -- СпособОплаты
    Amount DECIMAL(10,2) NOT NULL,            -- Сумма
    PaymentDate DATETIME NOT NULL DEFAULT(GETDATE())
);
-- Ограничение на положительную сумму
ALTER TABLE dbo.Payments
    ADD CONSTRAINT CHK_Payments_Amount_Positive CHECK (Amount >= 0);
GO

CREATE TABLE dbo.Feedbacks
(
    FeedbackID INT IDENTITY(1,1) PRIMARY KEY,
    PassengerID INT NULL,
    DriverID INT NULL,
    RouteID INT NULL,
    Rating INT NULL,             -- Оценка 1..5
    Comments NVARCHAR(200) NULL
);

ALTER TABLE dbo.Feedbacks
    ADD CONSTRAINT CHK_Feedbacks_Rating CHECK (Rating IS NULL OR (Rating >= 1 AND Rating <= 5));
GO

CREATE TABLE dbo.Maintenance
(
    MaintenanceID INT IDENTITY(1,1) PRIMARY KEY,
    CarID INT NOT NULL,
    ServiceDate DATE NOT NULL,
    Description NVARCHAR(200) NULL,
    Cost DECIMAL(10,2) NULL
);

ALTER TABLE dbo.Maintenance
    ADD CONSTRAINT CHK_Maintenance_Cost CHECK (Cost IS NULL OR Cost >= 0);
GO

ALTER TABLE dbo.Cars
    ADD CONSTRAINT FK_Cars_CarTypes FOREIGN KEY (CarTypeID)
    REFERENCES dbo.CarTypes(CarTypeID)
    ON DELETE SET NULL ON UPDATE NO ACTION;
GO

ALTER TABLE dbo.Drivers
    ADD CONSTRAINT FK_Drivers_Cars FOREIGN KEY (CarID)
    REFERENCES dbo.Cars(CarID)
    ON DELETE SET NULL ON UPDATE NO ACTION;
GO

ALTER TABLE dbo.Bookings
    ADD CONSTRAINT FK_Bookings_Passengers FOREIGN KEY (PassengerID)
    REFERENCES dbo.Passengers(PassengerID)
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

ALTER TABLE dbo.Bookings
    ADD CONSTRAINT FK_Bookings_Drivers FOREIGN KEY (DriverID)
    REFERENCES dbo.Drivers(DriverID)
    ON DELETE SET NULL ON UPDATE NO ACTION;
GO

ALTER TABLE dbo.Bookings
    ADD CONSTRAINT FK_Bookings_Cars FOREIGN KEY (CarID)
    REFERENCES dbo.Cars(CarID)
    ON DELETE SET NULL ON UPDATE NO ACTION;
GO

ALTER TABLE dbo.Routes
    ADD CONSTRAINT FK_Routes_Bookings FOREIGN KEY (BookingID)
    REFERENCES dbo.Bookings(BookingID)
    ON DELETE CASCADE ON UPDATE NO ACTION; 


    GO

    ALTER TABLE dbo.Payments
    ADD CONSTRAINT FK_Payments_Routes FOREIGN KEY (RouteID)
    REFERENCES dbo.Routes(RouteID)
    ON DELETE SET NULL ON UPDATE NO ACTION;
GO

ALTER TABLE dbo.Feedbacks
    ADD CONSTRAINT FK_Feedbacks_Passengers FOREIGN KEY (PassengerID)
    REFERENCES dbo.Passengers(PassengerID)
    ON DELETE SET NULL ON UPDATE NO ACTION;
GO

ALTER TABLE dbo.Feedbacks
    ADD CONSTRAINT FK_Feedbacks_Drivers FOREIGN KEY (DriverID)
    REFERENCES dbo.Drivers(DriverID)
    ON DELETE SET NULL ON UPDATE NO ACTION;
GO

ALTER TABLE dbo.Feedbacks
    ADD CONSTRAINT FK_Feedbacks_Routes FOREIGN KEY (RouteID)
    REFERENCES dbo.Routes(RouteID)
    ON DELETE SET NULL ON UPDATE NO ACTION;
GO

ALTER TABLE dbo.Maintenance
    ADD CONSTRAINT FK_Maintenance_Cars FOREIGN KEY (CarID)
    REFERENCES dbo.Cars(CarID)
    ON DELETE CASCADE ON UPDATE NO ACTION;

    GO

    CREATE INDEX IX_Bookings_BookingTime ON dbo.Bookings(BookingTime);
GO

CREATE INDEX IX_Cars_Status ON dbo.Cars(Status);
GO

ALTER TABLE dbo.Cars
    ADD CONSTRAINT CHK_Cars_StatusValues CHECK (Status IN ('active','in_repair','retired'));
GO


ALTER TABLE dbo.Drivers
    ADD CONSTRAINT CHK_Drivers_StatusValues CHECK (Status IN ('active','fired','on_leave'));
GO

ALTER TABLE dbo.Bookings
    ADD CONSTRAINT CHK_Bookings_StatusValues CHECK (Status IN ('open','completed','cancelled'));
GO

GO