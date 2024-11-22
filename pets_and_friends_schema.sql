-- Fictional Client Pets&Friends Database Schema

-- Person table, superclass
CREATE TABLE IF NOT EXISTS Person (
    PersonID PRIMARY KEY,
    FName VARCHAR(50),
    MI CHAR(1),
    LName VARCHAR(50),
    DOB DATE,
    Gender CHAR,
    Phone VARCHAR(15),
    Passkey VARCHAR(100),
    StreetAddress VARCHAR(100),
    Apartment VARCHAR(20),
    City VARCHAR(50),
    StateLive CHAR(2),
    ZIP CHAR(5),
    JoinDate DATE
);

-- Employee information, subclass of Person
CREATE TABLE IF NOT EXISTS Employee (
    EmployeeID,
    PersonID, 
    Dept VARCHAR(50),
    Salary DECIMAL(10, 2),
    EmployeeType VARCHAR(50),
    FullTime BOOLEAN, 
    PRIMARY KEY (PersonID, EmployeeID),
    FOREIGN KEY (PersonID) REFERENCES Person(PersonID)
);

-- Customer information, subclass of Person
CREATE TABLE IF NOT EXISTS Customer (
    CustomerID,
    PersonID, 
    LoyaltyPoints INT, 
    PRIMARY KEY (PersonID, CustomerID),
    FOREIGN KEY (PersonID) REFERENCES Person(PersonID)
);

-- Orders placed by customers, associated with employees
CREATE TABLE IF NOT EXISTS OrderPlaced (
    OrderID,
    CustomerID NOT NULL,
    EmployeeID,
    OrderDate DATE NOT NULL,
    OrderStatus VARCHAR(20),
    PRIMARY KEY (OrderID, CustomerID),
    FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID),
    FOREIGN KEY (EmployeeID) REFERENCES Employee(EmployeeID)
);

-- Subscription orders that renew periodically
CREATE TABLE IF NOT EXISTS SubscriptionBox (
    OrderID PRIMARY KEY,
    StartDate DATE,
    EndDate DATE,
    Frequency VARCHAR(20),
    FOREIGN KEY (OrderID) REFERENCES OrderPlaced(OrderID)
);

-- Orders that are not subscription-based
CREATE TABLE IF NOT EXISTS RegularOrder (
    OrderID PRIMARY KEY,
    FOREIGN KEY (OrderID) REFERENCES OrderPlaced(OrderID)
);

-- Pets associated with customers
CREATE TABLE IF NOT EXISTS Pet (
    PetID,
    CustomerID NOT NULL,
    PetDOB DATE,
    PetGender CHAR(1),
    PRIMARY KEY (PetID, CustomerID),
    FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID)
);

-- Shopping cart for each customer
CREATE TABLE IF NOT EXISTS Shopping_Cart (
    ShoppingCartID PRIMARY KEY,
    CustomerID NOT NULL,
    FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID)
);

-- Products available in the store
CREATE TABLE IF NOT EXISTS Product (
    ProductID PRIMARY KEY,
    ProductName VARCHAR(100) NOT NULL,
    Brand VARCHAR(50),
    Category VARCHAR(50),
    ProductDescription TEXT,
    UnitPrice DECIMAL(10, 2)
);

-- Inventory information for products
CREATE TABLE IF NOT EXISTS Inventory (
    InventoryID,
    ProductID NOT NULL,
    MaxCapacity INT,
    UnitCost DECIMAL(10, 2),
    CurrInventory INT,
    PRIMARY KEY (InventoryID, ProductID),
    FOREIGN KEY (ProductID) REFERENCES Product(ProductID)
);

-- Supplier information for products
CREATE TABLE IF NOT EXISTS Supplier (
    SupplierID PRIMARY KEY,
    SupplierName VARCHAR(100) NOT NULL,
    SupplierEmail VARCHAR(100),
    SupplierPhone VARCHAR(15),
    ProductID,
    FOREIGN KEY (ProductID) REFERENCES Product(ProductID)
);

-- Product reviews from customers
CREATE TABLE IF NOT EXISTS Review (
    ReviewID,
    ProductID NOT NULL,
    ReviewDate DATE,
    Rating INT CHECK (Rating BETWEEN 1 AND 5),
    ReviewDescription TEXT,
    PRIMARY KEY (ReviewID, ProductID),
    FOREIGN KEY (ProductID) REFERENCES Product(ProductID)
);

-- Shipment details for each order
CREATE TABLE IF NOT EXISTS Shipment (
    ShipmentID,
    TrackingNum VARCHAR(50) UNIQUE,
    Carrier VARCHAR(50),
    OrderID NOT NULL,
    PRIMARY KEY (ShipmentID, OrderID),
    FOREIGN KEY (OrderID) REFERENCES OrderPlaced(OrderID)
);

-- Transactions recording payment information
CREATE TABLE IF NOT EXISTS Transac (
    TransactionID,
    PaymentMethod VARCHAR(50),
    TransactionTime TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    Amount DECIMAL(10, 2) NOT NULL,
    TransactionStatus VARCHAR(20),
    CustomerID NOT NULL,
    PRIMARY KEY (TransactionID, CustomerID),
    FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID)
);

CREATE TABLE IF NOT EXISTS Email_Customer (
    CustomerID NOT NULL,
    Email VARCHAR(100) NOT NULL,
    PRIMARY KEY (CustomerID, Email),
    FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID)
);

CREATE TABLE IF NOT EXISTS Category_Product (
    ProductID NOT NULL,
    Category VARCHAR(50) NOT NULL,
    PRIMARY KEY (ProductID, Category),
    FOREIGN KEY (ProductID) REFERENCES Product(ProductID)
);

-- Junction tables for many-to-many relationships
CREATE TABLE IF NOT EXISTS Shopping_Cart_Product (
    ShoppingCartID NOT NULL,
    ProductID NOT NULL,
    PRIMARY KEY (ShoppingCartID, ProductID),
    FOREIGN KEY (ShoppingCartID) REFERENCES Shopping_Cart(ShoppingCartID),
    FOREIGN KEY (ProductID) REFERENCES Product(ProductID)
);

CREATE TABLE IF NOT EXISTS Product_Order (
    OrderID NOT NULL,
    ProductID NOT NULL,
    Product_quantity INT,
    PRIMARY KEY (OrderID, ProductID),
    FOREIGN KEY (OrderID) REFERENCES OrderPlaced(OrderID),
    FOREIGN KEY (ProductID) REFERENCES Product(ProductID)
);

CREATE TABLE IF NOT EXISTS Order_Employee (
    EmployeeID NOT NULL,
    OrderID NOT NULL,
    PRIMARY KEY (EmployeeID, OrderID),
    FOREIGN KEY (EmployeeID) REFERENCES Employee(EmployeeID),
    FOREIGN KEY (OrderID) REFERENCES OrderPlaced(OrderID)
);
