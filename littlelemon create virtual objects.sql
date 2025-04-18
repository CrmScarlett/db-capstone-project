USE littlelemondb;

-- I. Create Virtual tables (views)
-- Task 1
-- In the first task, Little Lemon need you to create a virtual table called OrdersView that focuses on OrderID, Quantity and Cost columns within the Orders table for all orders with a quantity greater than 2. 
DROP VIEW IF EXISTS OrdersView;
CREATE VIEW OrdersView AS
SELECT O.OrderID
,O.Quantity
,O.Quantity * I.Cost AS Cost 
FROM Orders AS O
INNER JOIN Menu I ON O.MenuID = I.MenuID
WHERE O.Quantity>2;

-- Task 2: Little Lemon need information from four tables on all customers with orders that cost more han $150
-- Modify data to have qualified orders returned in this view
-- set sql_safe_updates = 0;
-- UPDATE MENU SET COST = COST +30, PRICE = PRICE + 30;
-- set sql_safe_updates = 1;
DROP VIEW IF EXISTS OrdersCostOver150;
CREATE VIEW OrdersCostOver150
AS 
SELECT C.CustomerID
,CONCAT(C.FirstName, ' ', C.LastName) AS FullName
,O.OrderID
,O.Quantity * M.Cost AS Cost 
,M.Category AS MenuName
,M.Name AS CourseName
FROM Orders AS O
INNER JOIN Menu M ON O.MenuID = M.MenuID
INNER JOIN Customers C ON C.CustomerID = o.CustomerID
WHERE O.Quantity * M.Cost  > 150;

-- Task3:  find all menu items for which more than 2 orders have been placed
DROP VIEW IF EXISTS MenuOrderedMoreThan2;
CREATE VIEW MenuOrderedMoreThan2
AS 
SELECT M.Name AS MenuName
FROM Menu M
WHERE MenuID = ANY(SELECT MenuID FROM Orders WHERE Quantity >2);


-- II. Create query optimization with Stroed Procedures and prepared statements:
DELIMITER //
CREATE PROCEDURE ProcedureName()
	BEGIN
	SELECT statements;

	END //
DELIMITER ;
CALL ProcedureName;


PREPARE statement_Name FROM 'INSERT INTO table1 VALUES (?, ?, ?, ?)';
EXECUTE statement_name USING @variable;

-- Task 1: create a procedure that displays the maximum ordered quantity in the Orders table. 
DROP PROCEDURE IF EXISTS GetMaxQuantity; 
DELIMITER //
CREATE PROCEDURE GetMaxQuantity ()
	BEGIN
	SELECT MAX(Quantity) AS 'Max Quantity in Order' FROM Orders;
	END //
DELIMITER ;
CALL GetMaxQuantity;

-- Task 2: prepared statement called GetOrderDetail. 
-- The prepared statement should accept one input argument, the CustomerID value, from a variable. 
-- The statement should return the order id, the quantity and the order cost from the Orders table. 
PREPARE GetOrderDetail FROM
'SELECT O.OrderID 
,O.Quantity
,O.Quantity * I.Cost AS Cost 
FROM Orders AS O
INNER JOIN Menu I ON O.MenuID = I.MenuID
WHERE O.CustomerID = ?';

SET @ID = 1;
EXECUTE GetOrderDetail USING @id;

-- Task 3: create a stored procedure called CancelOrder
-- ALTER TABLE Orders
-- ADD COLUMN IsCanceled bit DEFAULT 0


DROP PROCEDURE IF EXISTS CancelOrder; 
DELIMITER //
CREATE PROCEDURE CancelOrder(IN inp_OrderID INT)
	BEGIN
	UPDATE Orders
    SET IsCanceled = 1
	WHERE OrderID = inp_OrderID;
    SELECT CONCAT('Order ',inp_OrderID,' is cancelled') AS Confirmation;

	END //
DELIMITER ;
CALL CancelOrder(5);

