USE DSS2g3;
GO

CREATE SCHEMA Shiokee;
GO

CREATE TABLE Shiokee.Product(
    PName VARCHAR(50) NOT NULL,
    Maker VARCHAR(50),
    Category VARCHAR(50) NOT NULL,

    PRIMARY KEY(PName)
);
GO

CREATE TABLE Shiokee.[User](
    UserID INT IDENTITY(1, 1),
    UName VARCHAR(50),

    PRIMARY KEY(UserID)
);
GO

CREATE TABLE Shiokee.Shop(
    SName VARCHAR(50) NOT NULL,

    PRIMARY KEY(SName)
);
GO

CREATE TABLE Shiokee.Employee(
    EID INT IDENTITY(1, 1),
    EName VARCHAR(50) NOT NULL,
    Salary INT NOT NULL CHECK(Salary >= 0),

    PRIMARY KEY(EID)
);

CREATE TABLE Shiokee.[Order](
    OrderID INT IDENTITY(1, 1),
    UserID INT NOT NULL,
    OrderDateTime DATETIME NOT NULL,
    ShippingAddress VARCHAR(150) NOT NULL,

    PRIMARY KEY(OrderID),
    FOREIGN KEY(UserID) REFERENCES Shiokee.[User](UserID)
        ON DELETE NO ACTION /* No need ON UPDATE because
                            IDENTITY cannot be updated */
);
GO

CREATE TABLE Shiokee.Complaint(
    CID INT IDENTITY(1, 1),
    FiledDateTime DATETIME NOT NULL,
    ComplaintStatus VARCHAR(20) NOT NULL,
    ComplaintText VARCHAR(500),
    UserID INT NOT NULL,
    EID INT,
    HandledDateTime DATETIME,

    PRIMARY KEY(CID),
    FOREIGN KEY(UserID) REFERENCES Shiokee.[User](UserID)
        ON DELETE NO ACTION,
    FOREIGN KEY(EID) REFERENCES Shiokee.Employee(EID)
        ON DELETE SET NULL
);
GO

CREATE TABLE Shiokee.Product_in_shop(
    PName VARCHAR(50) NOT NULL,
    SName VARCHAR(50) NOT NULL,
    SPID INT,
    SPrice INT NOT NULL CHECK(SPrice >= 0),
    SQuantity INT NOT NULL,

    PRIMARY KEY(SName, PName),
    FOREIGN KEY(SName) REFERENCES Shiokee.Shop(SName)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    FOREIGN KEY(PName) REFERENCES Shiokee.Product(PName)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
);
GO

CREATE TABLE Shiokee.Product_in_order(
    PName VARCHAR(50) NOT NULL,
    OPID INT NOT NULL,
    OPrice INT NOT NULL CHECK(OPrice >= 0),
    OQuantity INT NOT NULL CHECK(OQuantity > 0),
    OStatus VARCHAR(20) NOT NULL DEFAULT '“being processed',
    DeliveryDate DATETIME,
    OrderID INT NOT NULL,
    SName VARCHAR(50) NOT NULL,

    PRIMARY KEY(OrderID, OPID),
    FOREIGN KEY(OrderID) REFERENCES Shiokee.[Order](OrderID)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    FOREIGN KEY(SName) REFERENCES Shiokee.Shop(SName)
        ON DELETE NO ACTION
        ON UPDATE CASCADE,
);
GO









