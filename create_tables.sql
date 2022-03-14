USE master;
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

CREATE TABLE Shiokee.Users(
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
    Salary INT NOT NULL,

    PRIMARY KEY(EID)
);

CREATE TABLE Shiokee.Orders(
    OrderID INT IDENTITY(1, 1),
    UserID INT NOT NULL,
    OrderDateTime DATETIME NOT NULL,
    ShippingAddress VARCHAR(150) NOT NULL,

    PRIMARY KEY(OrderID),
    FOREIGN KEY(UserID) REFERENCES Shiokee.Users(UserID)
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
    FOREIGN KEY(UserID) REFERENCES Shiokee.Users(UserID)
        ON DELETE NO ACTION,
    FOREIGN KEY(EID) REFERENCES Shiokee.Employee(EID)
        ON DELETE SET NULL
);
GO









