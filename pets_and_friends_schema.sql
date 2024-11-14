-- Fictional Client Pets&Friends Database Schema

-- Employee information, subclass of Person
CREATE TABLE IF NOT EXISTS Employee (
    EmployeeID INT PRIMARY KEY,
    FName VARCHAR(50) NOT NULL,
    MI CHAR(1),
    LName VARCHAR(50),
    DOB DATE,
    Gender CHAR,
    Phone VARCHAR(15),
    Passkey VARCHAR(100) NOT NULL,
    StreetAddress VARCHAR(100),
    Apartment VARCHAR(20),
    City VARCHAR(50),
    StateLive CHAR(2),
    ZIP CHAR(5),
    JoinDate DATE,
    Dept VARCHAR(50),
    Salary DECIMAL(10, 2),
    EmployeeType VARCHAR(50),
    FullTime BOOLEAN NOT NULL
);

-- Customer information, subclass of Person
CREATE TABLE IF NOT EXISTS Customer (
    CustomerID INT PRIMARY KEY,
    FName VARCHAR(50) NOT NULL,
    MI CHAR(1),
    LName VARCHAR(50),
    DOB DATE,
    Gender CHAR(1),
    Phone VARCHAR(15),
    Passkey VARCHAR(100) NOT NULL,
    StreetAddress VARCHAR(100),
    Apartment VARCHAR(20),
    City VARCHAR(50),
    StateLive CHAR(2),
    ZIP CHAR(5),
    JoinDate DATE,
    LoyaltyPoints INT
);

-- Orders placed by customers, associated with employees
CREATE TABLE IF NOT EXISTS OrderPlaced (
    OrderID INT,
    CustomerID INT NOT NULL,
    EmployeeID INT,
    OrderDate DATE NOT NULL,
    OrderStatus VARCHAR(20),
    PRIMARY KEY (OrderID, CustomerID),
    FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID),
    FOREIGN KEY (EmployeeID) REFERENCES Employee(EmployeeID)
);

-- Subscription orders that renew periodically
CREATE TABLE IF NOT EXISTS SubscriptionBox (
    OrderID INT PRIMARY KEY,
    StartDate DATE,
    EndDate DATE,
    Frequency VARCHAR(20),
    FOREIGN KEY (OrderID) REFERENCES OrderPlaced(OrderID)
);

-- Orders that are not subscription-based
CREATE TABLE IF NOT EXISTS RegularOrder (
    OrderID INT PRIMARY KEY,
    FOREIGN KEY (OrderID) REFERENCES OrderPlaced(OrderID)
);

-- Pets associated with customers
CREATE TABLE IF NOT EXISTS Pet (
    PetID INT,
    CustomerID INT NOT NULL,
    PetDOB DATE,
    PetGender CHAR(1),
    PRIMARY KEY (PetID, CustomerID),
    FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID)
);

-- Shopping cart for each customer
CREATE TABLE IF NOT EXISTS Shopping_Cart (
    ShoppingCartID INT PRIMARY KEY,
    CustomerID INT NOT NULL,
    FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID)
);

-- Products available in the store
CREATE TABLE IF NOT EXISTS Product (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(100) NOT NULL,
    Brand VARCHAR(50),
    Category VARCHAR(50),
    ProductDescription TEXT,
    UnitPrice DECIMAL(10, 2)
);

-- Inventory information for products
CREATE TABLE IF NOT EXISTS Inventory (
    InventoryID INT,
    ProductID INT NOT NULL,
    MaxCapacity INT,
    UnitCost DECIMAL(10, 2),
    CurrInventory INT,
    PRIMARY KEY (InventoryID, ProductID),
    FOREIGN KEY (ProductID) REFERENCES Product(ProductID)
);

-- Supplier information for products
CREATE TABLE IF NOT EXISTS Supplier (
    SupplierID INT PRIMARY KEY,
    SupplierName VARCHAR(100) NOT NULL,
    SupplierEmail VARCHAR(100),
    SupplierPhone VARCHAR(15),
    ProductID INT,
    FOREIGN KEY (ProductID) REFERENCES Product(ProductID)
);

-- Product reviews from customers
CREATE TABLE IF NOT EXISTS Review (
    ReviewID INT,
    ProductID INT NOT NULL,
    ReviewDate DATE,
    Rating INT CHECK (Rating BETWEEN 1 AND 5),
    ReviewDescription TEXT,
    PRIMARY KEY (ReviewID, ProductID),
    FOREIGN KEY (ProductID) REFERENCES Product(ProductID)
);

-- Shipment details for each order
CREATE TABLE IF NOT EXISTS Shipment (
    ShipmentID INT,
    TrackingNum VARCHAR(50) UNIQUE,
    Carrier VARCHAR(50),
    OrderID INT NOT NULL,
    PRIMARY KEY (ShipmentID, OrderID),
    FOREIGN KEY (OrderID) REFERENCES OrderPlaced(OrderID)
);

-- Transactions recording payment information
CREATE TABLE IF NOT EXISTS Transac (
    TransactionID INT,
    PaymentMethod VARCHAR(50),
    TransactionTime TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    Amount DECIMAL(10, 2) NOT NULL,
    TransactionStatus VARCHAR(20),
    CustomerID INT NOT NULL,
    PRIMARY KEY (TransactionID, CustomerID),
    FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID)
);

CREATE TABLE IF NOT EXISTS Email_Customer (
    CustomerID INT NOT NULL,
    Email VARCHAR(100) NOT NULL,
    PRIMARY KEY (CustomerID, Email),
    FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID)
);

CREATE TABLE IF NOT EXISTS Category_Product (
    ProductID INT NOT NULL,
    Category VARCHAR(50) NOT NULL,
    PRIMARY KEY (ProductID, Category),
    FOREIGN KEY (ProductID) REFERENCES Product(ProductID)
);

-- Junction tables for many-to-many relationships
CREATE TABLE IF NOT EXISTS Shopping_Cart_Product (
    ShoppingCartID INT NOT NULL,
    ProductID INT NOT NULL,
    PRIMARY KEY (ShoppingCartID, ProductID),
    FOREIGN KEY (ShoppingCartID) REFERENCES Shopping_Cart(ShoppingCartID),
    FOREIGN KEY (ProductID) REFERENCES Product(ProductID)
);

CREATE TABLE IF NOT EXISTS Product_Order (
    OrderID INT NOT NULL,
    ProductID INT NOT NULL,
    Product_quantity INT,
    PRIMARY KEY (OrderID, ProductID),
    FOREIGN KEY (OrderID) REFERENCES OrderPlaced(OrderID),
    FOREIGN KEY (ProductID) REFERENCES Product(ProductID)
);

CREATE TABLE IF NOT EXISTS Order_Employee (
    EmployeeID INT NOT NULL,
    OrderID INT NOT NULL,
    PRIMARY KEY (EmployeeID, OrderID),
    FOREIGN KEY (EmployeeID) REFERENCES Employee(EmployeeID),
    FOREIGN KEY (OrderID) REFERENCES OrderPlaced(OrderID)
);
