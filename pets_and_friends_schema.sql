-- Fictional Client Pets&Friends Database Schema

-- Employee information, subclass of Person
CREATE TABLE Employee (
    EmployeeID INTEGER PRIMARY KEY,
    FName TEXT NOT NULL,
    MI TEXT CHECK (LENGTH(MI) <= 1), -- Middle Initial, limited to 1 character
    LName TEXT,
    DOB DATE CHECK (DOB < DATE('now')), -- Must be in the past
    Gender TEXT CHECK (Gender IN ('M', 'F', 'O')), -- Male, Female, Other
    Email TEXT UNIQUE NOT NULL,
    Phone TEXT NOT NULL CHECK (LENGTH(Phone) >= 10), -- Assumes standard phone number length
    Passkey TEXT NOT NULL, -- Storing as hash recommended
    StreetAddress TEXT,
    Apartment TEXT,
    City TEXT,
    State TEXT CHECK (LENGTH(State) = 2), -- Standard 2-character US state code
    ZIP TEXT NOT NULL CHECK (LENGTH(ZIP) = 5), -- Standard 5-digit ZIP code
    JoinDate DATE NOT NULL CHECK (JoinDate <= DATE('now'))
    Dept TEXT NOT NULL,
    Salary REAL CHECK (Salary > 0),
    EmployeeType TEXT CHECK (EmployeeType IN ('Manager', 'Staff', 'Contractor')), -- Example employee types
    FullTime BOOLEAN NOT NULL
);

-- Customer information, subclass of Person
CREATE TABLE Customer (
    CustomerID INTEGER PRIMARY KEY,
    FName TEXT NOT NULL,
    MI TEXT CHECK (LENGTH(MI) <= 1), -- Middle Initial, limited to 1 character
    LName TEXT,
    DOB DATE CHECK (DOB < DATE('now')), -- Must be in the past
    Gender TEXT CHECK (Gender IN ('M', 'F', 'O')), -- Male, Female, Other
    Email TEXT UNIQUE NOT NULL,
    Phone TEXT NOT NULL CHECK (LENGTH(Phone) >= 10), -- Assumes standard phone number length
    Passkey TEXT NOT NULL, -- Storing as hash recommended
    StreetAddress TEXT,
    Apartment TEXT,
    City TEXT,
    State TEXT CHECK (LENGTH(State) = 2), -- Standard 2-character US state code
    ZIP TEXT NOT NULL CHECK (LENGTH(ZIP) = 5), -- Standard 5-digit ZIP code
    JoinDate DATE NOT NULL CHECK (JoinDate <= DATE('now'))
    LoyaltyPoints INTEGER DEFAULT 0 CHECK (LoyaltyPoints >= 0)
);

-- Orders placed by customers, associated with employees
CREATE TABLE Order (
    OrderID INTEGER PRIMARY KEY,
    CustomerID INTEGER NOT NULL,
    EmployeeID INTEGER,
    OrderDate DATE NOT NULL,
    OrderStatus TEXT CHECK (OrderStatus IN ('Pending', 'Shipped', 'Delivered', 'Canceled')),
    FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID),
    FOREIGN KEY (EmployeeID) REFERENCES Employee(EmployeeID)
);

-- Subscription orders that renew periodically
CREATE TABLE SubscriptionBox (
    OrderID INTEGER PRIMARY KEY,
    StartDate DATE NOT NULL,
    EndDate DATE,
    Frequency TEXT CHECK (Frequency IN ('Weekly', 'Monthly', 'Yearly')),
    FOREIGN KEY (OrderID) REFERENCES Order(OrderID)
);

-- Orders that are not subscription-based
CREATE TABLE RegularOrder (
    OrderID INTEGER PRIMARY KEY,
    FOREIGN KEY (OrderID) REFERENCES Order(OrderID)
);

-- Pets associated with customers
CREATE TABLE Pet (
    PetID INTEGER PRIMARY KEY,
    CustomerID INTEGER NOT NULL,
    PetDOB DATE  CHECK (PetDOB < DATE('now')), -- Birthdate must be in the past
    PetGender TEXT CHECK (PetGender IN ('M', 'F', 'O')),
    FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID)
);

-- Shopping cart for each customer
CREATE TABLE Shopping_Cart (
    ShoppingCartID INTEGER PRIMARY KEY,
    CustomerID INTEGER NOT NULL,
    FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID)
);

-- Products available in the store
CREATE TABLE Product (
    ProductID INTEGER PRIMARY KEY,
    ProductName TEXT NOT NULL,
    Brand TEXT,
    ProductDescription TEXT,
    UnitPrice REAL NOT NULL CHECK (UnitPrice > 0)
);

-- Inventory information for products
CREATE TABLE Inventory (
    InventoryID INTEGER PRIMARY KEY,
    ProductID INTEGER NOT NULL,
    MaxCapacity INTEGER CHECK (MaxCapacity BETWEEN 0 AND 200),
    UnitCost REAL NOT NULL CHECK (UnitCost > 0),
    CurrInventory INTEGER CHECK (CurrInventory BETWEEN 0 AND 200),
    FOREIGN KEY (ProductID) REFERENCES Product(ProductID)
);

-- Supplier information for products
CREATE TABLE Supplier (
    SupplierID INTEGER PRIMARY KEY,
    SupplierName TEXT NOT NULL,
    SupplierEmail TEXT UNIQUE NOT NULL,
    SupplierPhone TEXT CHECK (LENGTH(SupplierPhone) >= 10),
    ProductID INTEGER,
    FOREIGN KEY (ProductID) REFERENCES Product(ProductID)
);

-- Product reviews from customers
CREATE TABLE Review (
    ReviewID INTEGER PRIMARY KEY,
    ProductID INTEGER NOT NULL,
    ReviewDate DATE NOT NULL,
    Rating INTEGER CHECK (Rating BETWEEN 1 AND 5), -- Rating scale from 1 to 5
    ReviewContent TEXT,
    FOREIGN KEY (ProductID) REFERENCES Product(ProductID)
);

-- Shipment details for each order
CREATE TABLE Shipment (
    ShipmentID INTEGER PRIMARY KEY,
    TrackingNum TEXT UNIQUE,
    Carrier TEXT,
    OrderID INTEGER NOT NULL,
    FOREIGN KEY (OrderID) REFERENCES Order(OrderID)
);

-- Transactions recording payment information
CREATE TABLE Transaction (
    TransactionID INTEGER PRIMARY KEY,
    PaymentMethod TEXT CHECK (PaymentMethod IN ('Credit Card', 'PayPal', 'Bank Transfer', 'Cash')),
    TransactionDatetime DATETIME DEFAULT CURRENT_TIMESTAMP,
    Amount REAL NOT NULL CHECK (Amount >= 0),
    TransactionStatus TEXT CHECK (Status IN ('Completed', 'Pending', 'Failed')),
    CustomerID INTEGER NOT NULL,
    FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID)
);

-- Junction tables for many-to-many relationships
CREATE TABLE Shopping_Cart_Product (
    ShoppingCartID INTEGER NOT NULL,
    ProductID INTEGER NOT NULL,
    FOREIGN KEY (ShoppingCartID) REFERENCES Shopping_Cart(ShoppingCartID),
    FOREIGN KEY (ProductID) REFERENCES Product(ProductID),
    PRIMARY KEY (ShoppingCartID, ProductID)
);

CREATE TABLE Product_Order (
    OrderID INTEGER NOT NULL,
    ProductID INTEGER NOT NULL,
    FOREIGN KEY (OrderID) REFERENCES Order(OrderID),
    FOREIGN KEY (ProductID) REFERENCES Product(ProductID),
    PRIMARY KEY (OrderID, ProductID)
);

CREATE TABLE Order_Employee (
    EmployeeID INTEGER NOT NULL,
    OrderID INTEGER NOT NULL,
    FOREIGN KEY (EmployeeID) REFERENCES Employee(EmployeeID),
    FOREIGN KEY (OrderID) REFERENCES Order(OrderID),
    PRIMARY KEY (EmployeeID, OrderID)
);
