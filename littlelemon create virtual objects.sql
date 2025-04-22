USE littlelemondb;

-- I. Create Virtual tables (views)
-- Task 1
-- In the first task, Little Lemon need you to create a virtual table called OrdersView that focuses on OrderID, Quantity and Cost columns within the Orders table for all orders with a quantity greater than 2. 
DROP VIEW IF EXISTS OrdersView;
CREATE VIEW OrdersView AS
SELECT O.OrderID
,O.Quantity
,O.Cost AS Cost 
FROM Orders AS O
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
,O.Cost AS Cost 
,M.Cuisine AS MenuName
,MI.CourseName AS CourseName 
FROM Orders AS O
INNER JOIN Menu M ON O.MenuID = M.MenuID
INNER JOIN MenuItem MI ON MI.MenuItemID = M.MenuItemID
INNER JOIN Customers C ON C.CustomerID = o.CustomerID
WHERE O.Cost  > 150;

-- Task3:  find all menu items for which more than 2 orders have been placed
DROP VIEW IF EXISTS MenuOrderedMoreThan2;
CREATE VIEW MenuOrderedMoreThan2
AS 
SELECT DISTINCT M.MenuName AS MenuName 
FROM Menu M
WHERE M.MenuID = ANY(SELECT MenuID FROM Orders WHERE Quantity >2);



-- II. Create query optimization with Stroed Procedures and prepared statements:
-- DELIMITER //
-- CREATE PROCEDURE ProcedureName()
-- 	BEGIN
-- 	SELECT statements;

-- 	END //
-- DELIMITER ;
-- CALL ProcedureName;


-- PREPARE statement_Name FROM 'INSERT INTO table1 VALUES (?, ?, ?, ?)';
-- EXECUTE statement_name USING @variable;
Update Orders set quantity = 5 where orderid = 1;
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
,O.Cost AS Cost 
FROM Orders AS O
INNER JOIN Menu I ON O.MenuID = I.MenuID
WHERE O.CustomerID = ?';

SET @ID = '843006499';
EXECUTE GetOrderDetail USING @id;
 
-- Task 3: create a stored procedure called CancelOrder
ALTER TABLE Orders
ADD COLUMN IsCanceled bit DEFAULT 0;


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
CALL CancelOrder("082707581");

-- select * from Orders where orderid = '082707581';

-- SELECT * FROM Customers; -- 1-9

-- SELECT * FROM Menu; -- 1-15
-- update menu set cost = 0, price  = 0 where menuid = 1
-- update orders set menuid = 5 where menuid = 1
-- set sql_safe_updates = 0;
-- SELECT * FROM Orders where menuid = 1;
-- UPDATE Menu set price = price + 30;
-- update Orders
-- update orders
-- set orderdate = date_add(orderdate,INTERVAL -1 year)
-- UPDATE Orders SET MENUID = CUSTOMERid + 7, ASSIGNEDTO = 7 WHERE MENUID IS NULL
-- INSERT INTO Orders(OrderDate, CustomerID, Quantity, BookingID, MenuID, AssignedTo)
-- SELECT date_add(orderdate,INTERVAL 2 year), CustomerID, Quantity, 1 , FLOOR(RAND()*(15-1+1))+1, AssignedTo
-- FROM Orders where orderid <= 24;

-- set sql_safe_updates = 1;

-- SELECT CUSTOMERID, COUNT(ORDERID) AS ORDERCOUNT, SUM(M.Price) as totalsales, sum((m.price - m.cost)*o.quantity) as totalprofit FROM ORDERS O
-- INNER JOIN MENU M ON O.MENUID = M.MENUID
--  GROUP BY CUSTOMERID ORDER BY 2 DESC;
--  
--  SELECT O.OrderID
-- ,O.Quantity * M.Price AS TotalCost
-- FROM Orders O
-- INNER JOIN Menu M ON O.MenuID = M.MenuID
-- INNER JOIN Customers C ON C.CustomerID = O.CustomerID
-- WHERE C.CustomerID <> 1
-- AND O.Quantity * M.Price > 60
--  
