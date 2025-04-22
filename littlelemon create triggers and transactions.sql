USE littlelemondb;

-- I. Triggers and transactions
-- DROP TRIGGER [IF EXISTS] [schema_name] trigger_name
-- CREATE TRIGGER trigger_name 
-- {BEFORE | AFTER} {INSERT | UPDATE| DELETE} 
-- ON table_name FOR EACH ROW 
-- trigger_body;

-- START TRANSACTION; littlelemonrawdata
-- SQL statements littlelemondata
-- COMMIT; 
-- /ROLLBACK; 

-- Task1: populate the Bookings table of their database with some records of data. Your first task is to replicate the list of records in the following table by adding them to the Little Lemon booking table. 
-- SELECT * FROM Customers order by 1

INSERT INTO Customers(CustomerID, FirstName, LastName, City, Country,PhoneNumber)
VALUES(2,'Anna','Belle','Springfield','United States',1233211234)
,(3,'John','Snow','Kansas City','United States',1233211235)
,(4,'Alex','June','Springfield','United States',1233215232);

INSERT INTO Bookings(Date, CustomerID, TableNumber)
VALUES('2022-10-10','1',1)
,('2022-11-12','3',3)
,('2022-10-11','2',2)
,('2022-10-13','2',1);

-- SELECT * FROM Bookings;


-- Task 2: create a stored procedure called CheckBooking to check whether a table in the restaurant is already booked. 
-- The procedure should have two input parameters in the form of booking date and table number. You can also create a variable in the procedure to check the status of each table.
DROP PROCEDURE IF EXISTS CheckBooking; 
DELIMITER //
CREATE PROCEDURE CheckBooking(IN p_date date, p_tableno INT)
	BEGIN
	DECLARE p_BookingID INT;
    SELECT BookingID INTO p_BookingID FROM Bookings
    WHERE Date = p_date AND TableNumber = p_tableno;

	SELECT CASE WHEN p_BookingID IS NULL THEN CONCAT('Table ',p_tableno,' is available at selected date')
    ELSE CONCAT('Table ',p_tableno,' is already booked')
    END AS 'Booking Status';
	END //
DELIMITER ;

CALL CheckBooking("2022-11-12",3);


-- Task 3:  verify a booking, and decline any reservations for tables that are already booked under another name. 
--  create a new procedure called AddValidBooking. This procedure must use a transaction statement to perform a rollback if a customer reserves a table that’s already booked under another name.  

DROP PROCEDURE IF EXISTS AddValidBooking; 
DELIMITER //
CREATE PROCEDURE AddValidBooking(IN p_date date, p_tableno INT,p_CustomerID INT)
	BEGIN
    DECLARE p_BookingID INT;
		START TRANSACTION;		
        
		SELECT BookingID INTO p_BookingID FROM Bookings
		WHERE Date = p_date AND TableNumber = p_tableno LIMIT 1;
-- 		SELECT 'check bookingID completion' as SPStatus;
		IF p_BookingID IS NULL
        THEN  
 
        INSERT INTO Bookings(Date, TableNumber,CustomerID)
        VALUES(p_date,p_tableno,p_CustomerID);
        
--         SELECT 'insert completion' as SPStatus;
        SELECT CONCAT(p_tableno,' is available at selected date - booking completed') AS 'Booking Status';
        COMMIT;
        ELSE
        SELECT CONCAT('Table ',p_tableno,' is already booked - booking canceled') AS 'Booking Status';
        ROLLBACK;
        END IF;
	END //
DELIMITER ;

CALL AddValidBooking("2022-12-17",6,2);
 

-- select * from bookings;


-- II. Add, Update and Delete bookings
-- Task1:  create a new procedure called AddBooking to add a new table booking record.
-- The procedure should include four input parameters in the form of the following bookings parameters:
-- booking id, 
-- customer id, 
-- booking date,
-- and table number.

DROP PROCEDURE IF EXISTS AddBooking; 
DELIMITER //
CREATE PROCEDURE AddBooking(IN p_bookingID INT, p_customerID INT, p_date DATE, p_tableno INT)
	BEGIN
    DECLARE ck_bookingid1 INT;
    DECLARE ck_bookingid2 INT;
		START TRANSACTION;		
        
        SELECT BookingID INTO ck_bookingid1 FROM Bookings WHERE BookingID = p_BookingID;
        IF ck_bookingid1 IS NOT NULL
			THEN SELECT MAX(BookingID)+1 INTO p_BookingID FROM Bookings;
		END IF;
        
		SELECT BookingID INTO ck_bookingid2 FROM Bookings
		WHERE Date = p_date AND TableNumber = p_tableno LIMIT 1;
 

		IF ck_bookingid2 IS NULL
        THEN  
 
        INSERT INTO Bookings(BookingID, Date, TableNumber,CustomerID)
        VALUES(p_bookingID, p_date,p_tableno,p_CustomerID);
        
        SELECT CONCAT('Table ',p_tableno,' is available at selected date - New booking added, Booking ID: ',p_bookingID) AS 'Booking Status';
        COMMIT;
        ELSE
        SELECT CONCAT('Table ',p_tableno,' is already booked - booking canceled') AS 'Booking Status';
        ROLLBACK;
        END IF;
	END //
DELIMITER ;

CALL AddBooking(99,4,"2025-04-22",11);

-- select * from bookings;
 
-- Task2: create a new procedure called UpdateBooking that they can use to update existing bookings in the booking table.
-- Input: BookingID, BookingDate

DROP PROCEDURE IF EXISTS UpdateBooking; 
DELIMITER //
CREATE PROCEDURE UpdateBooking(IN p_bookingID INT,p_date DATE)
	BEGIN
	DECLARE ck_bookingdate DATE;
   		START TRANSACTION;
        SELECT Date INTO ck_bookingdate FROM Bookings
		WHERE bookingID = p_bookingID LIMIT 1;
        
		UPDATE Bookings
		SET Date = p_date
		WHERE BookingID = p_bookingID;     

        IF cK_bookingdate IS NULL
        THEN SELECT "Booking does not exist, please check another bookingID" AS "Booking ID Not Exist!";
        ELSEIF ck_bookingdate <> p_date 
        THEN
			SELECT CONCAT('Booking ',p_bookingID, ' is updated') AS 'Confirmation';
		COMMIT;
		ELSEIF ck_bookingdate = p_date THEN
			SELECT CONCAT('Booking ',p_bookingID,' is already scheduled at ',p_date,'. Please enter a different date') AS 'Update Failed';
		ROLLBACK;
		END IF;
	END //
DELIMITER ;

CALL UpdateBooking(99,"2025-04-23");

-- SELECT * FROM Bookings;


-- Task 3: create a new procedure called CancelBooking that they can use to cancel or remove a booking.
-- Input: BookingID
DROP PROCEDURE IF EXISTS CancelBooking; 
DELIMITER //
CREATE PROCEDURE CancelBooking(IN p_bookingID INT)
	BEGIN
	DECLARE ck_bookingID INT;
   		START TRANSACTION;
        SELECT bookingID INTO ck_bookingID FROM Bookings
		WHERE bookingID = p_bookingID LIMIT 1;
        
		DELETE FROM Bookings
        WHERE BookingID = p_bookingID;
        
        IF ck_bookingID IS NOT NULL
        THEN
			SELECT CONCAT('Booking ',p_bookingID, ' is Deleted') AS 'Confirmation';
		COMMIT;
		ELSE
			SELECT CONCAT('Booking ',p_bookingID,' does not exist') AS 'Delete Failed';
		ROLLBACK;
		END IF;
	END //
DELIMITER ;

CALL CancelBooking(99);

-- SELECT * FROM Bookings;
