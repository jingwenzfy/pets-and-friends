-- Insert sample data for Employee table
DELETE FROM Employee;
INSERT INTO Employee (EmployeeID, FName, MI, LName, DOB, Gender, Email, Phone, Passkey, StreetAddress, Apartment, City, State, ZIP, JoinDate, Dept, Salary, EmployeeType, FullTime) VALUES
(1, 'Yunhao', NULL, 'Lin', '1980-06-15', 'M', 'john.smith@example.com', '1234567890', 'hashedpass', '123 Elm St', NULL, 'San Jose', 'CA', '95112', '2022-01-10', 'Sales', 70000, 'Manager', 1),
(2, 'XinWei', NULL, 'Cao', '1985-08-25', 'M', 'alice.brown@example.com', '1234567891', 'hashedpass', '456 Oak St', NULL, 'San Francisco', 'CA', '94107', '2023-02-14', 'Support', 55000, 'Staff', 1),
(3, 'Qilian', NULL, 'Wu', '1992-09-30', 'M', 'michael.johnson@example.com', '1234567892', 'hashedpass', '789 Pine St', 'Apt 2B', 'Oakland', 'CA', '94607', '2022-05-20', 'IT', 60000, 'Contractor', 0),
(4, 'Derek', NULL, 'Shih', '1995-12-10', 'M', 'sophia.williams@example.com', '1234567893', 'hashedpass', '101 Maple St', NULL, 'Sacramento', 'CA', '95814', '2023-06-18', 'HR', 75000, 'Manager', 1),
(5, 'Pratham', NULL, 'Gupta', '1998-03-05', 'M', 'david.jones@example.com', '1234567894', 'hashedpass', '202 Cedar St', NULL, 'San Diego', 'CA', '92101', '2024-02-01', 'Finance', 65000, 'Staff', 1),
(6, 'Jingwen', NULL, 'Zhang', '2000-05-22', 'F', 'jingwen.zhang@example.com', '9496649129', 'hashedpass', '202 Cedar St', NULL, 'Irvine', 'CA', '92617', '2024-02-01', 'Support', 65000, 'Staff', 1);


-- Insert sample data for Customer table
DELETE FROM Customer;
INSERT INTO Customer (CustomerID, FName, MI, LName, DOB, Gender, Email, Phone, Passkey, StreetAddress, Apartment, City, State, ZIP, JoinDate, LoyaltyPoints) VALUES
(1, 'Emma', NULL, 'Martinez', '2000-04-12', 'F', 'emma.martinez@example.com', '2234567890', 'hashedpass', '303 Birch St', NULL, 'Los Angeles', 'CA', '90001', '2023-01-25', 100),
(2, 'Noah', 'G', 'Garcia', '1999-02-19', 'M', 'noah.garcia@example.com', '2234567891', 'hashedpass', '404 Redwood St', 'Unit 3', 'Long Beach', 'CA', '90802', '2022-03-15', 200),
(3, 'Olivia', NULL, 'Miller', '1988-05-22', 'F', 'olivia.miller@example.com', '2234567892', 'hashedpass', '505 Oakwood Dr', NULL, 'Fresno', 'CA', '93710', '2023-05-05', 0),
(4, 'Liam', 'J', 'Davis', '1992-07-18', 'M', 'liam.davis@example.com', '2234567893', 'hashedpass', '606 Pine St', 'Apt 7', 'Anaheim', 'CA', '92801', '2023-07-11', 50),
(5, 'Sophia', 'L', 'Taylor', '1990-09-09', 'F', 'sophia.taylor@example.com', '2234567894', 'hashedpass', '707 Maple Ave', NULL, 'Riverside', 'CA', '92501', '2024-01-01', 30),
(6, 'William', NULL, 'Anderson', '1996-12-25', 'M', 'william.anderson@example.com', '2234567895', 'hashedpass', '808 Oak Ave', NULL, 'Bakersfield', 'CA', '93301', '2023-02-28', 150),
(7, 'Ava', 'M', 'Thomas', '1994-10-11', 'F', 'ava.thomas@example.com', '2234567896', 'hashedpass', '909 Cedar St', NULL, 'Stockton', 'CA', '95202', '2023-06-15', 20),
(8, 'James', 'N', 'Jackson', '1989-03-20', 'M', 'james.jackson@example.com', '2234567897', 'hashedpass', '1010 Willow Dr', NULL, 'Irvine', 'CA', '92602', '2023-08-22', 0),
(9, 'Isabella', 'O', 'Harris', '1993-11-30', 'F', 'isabella.harris@example.com', '2234567898', 'hashedpass', '1111 Ash St', 'Apt 4D', 'Modesto', 'CA', '95350', '2022-09-30', 80),
(10, 'Lucas', NULL, 'Lopez', '1991-10-02', 'M', 'lucas.lopez@example.com', '2234567899', 'hashedpass', '707 Cypress St', NULL, 'Santa Clara', 'CA', '95050', '2023-10-22', 20);


-- Insert sample data for Order table
DELETE FROM OrderPlaced;
INSERT INTO OrderPlaced (OrderID, CustomerID, EmployeeID, OrderDate, OrderStatus) VALUES
(1, 1, 1, '2024-01-15', 'Shipped'),
(2, 2, 2, '2024-02-18', 'Delivered'),
(3, 3, 3, '2024-03-10', 'Pending'),
(4, 4, NULL, '2024-04-12', 'Shipped'),
(5, 5, 1, '2024-05-20', 'Delivered'),
(6, 6, 2, '2024-06-15', 'Canceled'),
(7, 7, NULL, '2024-07-25', 'Pending'),
(8, 8, 3, '2024-08-01', 'Shipped'),
(9, 9, 4, '2024-08-20', 'Delivered'),
(10, 10, NULL, '2024-09-10', 'Pending'),
(11, 1, 2, '2024-09-22', 'Shipped'),
(12, 2, 3, '2024-09-30', 'Delivered'),
(13, 3, 1, '2024-10-05', 'Canceled'),
(14, 4, NULL, '2024-10-12', 'Pending'),
(15, 5, 5, '2024-10-20', 'Shipped'),
(16, 6, 2, '2024-10-30', 'Delivered'),
(17, 7, 4, '2024-11-02', 'Pending'),
(18, 8, 1, '2024-11-05', 'Shipped'),
(19, 9, NULL, '2024-11-08', 'Pending'),
(20, 10, 3, '2024-11-10', 'Delivered');

