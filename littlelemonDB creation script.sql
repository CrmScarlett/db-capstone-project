-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema LittleLemonDB
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema LittleLemonDB
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `LittleLemonDB` DEFAULT CHARACTER SET utf8 ;
USE `LittleLemonDB` ;

-- -----------------------------------------------------
-- Table `LittleLemonDB`.`Customers`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `LittleLemonDB`.`Customers` ;

CREATE TABLE IF NOT EXISTS `LittleLemonDB`.`Customers` (
  `CustomerID` INT NOT NULL AUTO_INCREMENT,
  `FirstName` VARCHAR(45) NOT NULL,
  `LastName` VARCHAR(45) NOT NULL,
  `PhoneNumber` BIGINT NOT NULL,
  `Address` VARCHAR(255) NULL,
  `City` VARCHAR(50) NULL,
  `State` VARCHAR(50) NULL,
  PRIMARY KEY (`CustomerID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LittleLemonDB`.`Bookings`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `LittleLemonDB`.`Bookings` ;

CREATE TABLE IF NOT EXISTS `LittleLemonDB`.`Bookings` (
  `BookingID` INT NOT NULL AUTO_INCREMENT,
  `Date` DATE NOT NULL,
  `CustomerID` INT NULL,
  `TableNumber` INT NULL,
  PRIMARY KEY (`BookingID`),
  INDEX `fk_CustomerID_idx` (`CustomerID` ASC) VISIBLE,
  CONSTRAINT `fk_CustomerID`
    FOREIGN KEY (`CustomerID`)
    REFERENCES `LittleLemonDB`.`Customers` (`CustomerID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LittleLemonDB`.`Menu`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `LittleLemonDB`.`Menu` ;

CREATE TABLE IF NOT EXISTS `LittleLemonDB`.`Menu` (
  `MenuID` INT NOT NULL AUTO_INCREMENT,
  `Category` VARCHAR(150) NOT NULL,
  `Name` VARCHAR(150) NOT NULL,
  `Cost` DECIMAL(8,2) NULL,
  `Price` DECIMAL(8,2) NULL,
  `Description` VARCHAR(255) NULL,
  PRIMARY KEY (`MenuID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LittleLemonDB`.`Employees`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `LittleLemonDB`.`Employees` ;

CREATE TABLE IF NOT EXISTS `LittleLemonDB`.`Employees` (
  `EmployeeID` INT NOT NULL AUTO_INCREMENT,
  `Role` VARCHAR(150) NOT NULL,
  `Full Name` VARCHAR(45) NULL,
  `ManagerID` INT NOT NULL,
  `Salary` INT NOT NULL,
  `Address` VARCHAR(155) NULL,
  `ContactNumber` BIGINT NULL,
  PRIMARY KEY (`EmployeeID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LittleLemonDB`.`Orders`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `LittleLemonDB`.`Orders` ;

CREATE TABLE IF NOT EXISTS `LittleLemonDB`.`Orders` (
  `OrderID` INT NOT NULL AUTO_INCREMENT,
  `OrderDate` DATE NOT NULL,
  `CustomerID` INT NOT NULL,
  `Quantity` INT NOT NULL,
  `BookingID` INT NOT NULL DEFAULT 1,
  `MenuID` INT NULL,
  `AssignedTo` INT NULL,
  PRIMARY KEY (`OrderID`),
  INDEX `fk_Orders_CustomerID_idx` (`CustomerID` ASC) VISIBLE,
  INDEX `fk_Orders_MenuID_idx` (`MenuID` ASC) VISIBLE,
  INDEX `fk_Orders_AssignedtoEmployeeID_idx` (`AssignedTo` ASC) VISIBLE,
  INDEX `fk_Orders_BookingID_idx` (`BookingID` ASC) VISIBLE,
  CONSTRAINT `fk_Orders_CustomerID`
    FOREIGN KEY (`CustomerID`)
    REFERENCES `LittleLemonDB`.`Customers` (`CustomerID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Orders_MenuID`
    FOREIGN KEY (`MenuID`)
    REFERENCES `LittleLemonDB`.`Menu` (`MenuID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Orders_AssignedtoEmployeeID`
    FOREIGN KEY (`AssignedTo`)
    REFERENCES `LittleLemonDB`.`Employees` (`EmployeeID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Orders_BookingID`
    FOREIGN KEY (`BookingID`)
    REFERENCES `LittleLemonDB`.`Bookings` (`BookingID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LittleLemonDB`.`OrderDeliveryStatus`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `LittleLemonDB`.`OrderDeliveryStatus` ;

CREATE TABLE IF NOT EXISTS `LittleLemonDB`.`OrderDeliveryStatus` (
  `OrderDeliveryStatusID` INT NOT NULL AUTO_INCREMENT,
  `OrderID` INT NOT NULL,
  `DeliveryDate` DATE NULL,
  `Status` VARCHAR(45) NOT NULL,
  `UpdatedDate` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`OrderDeliveryStatusID`),
  INDEX `fk_OrderDeliveryStatus_OrderID_idx` (`OrderID` ASC) VISIBLE,
  CONSTRAINT `fk_OrderDeliveryStatus_OrderID`
    FOREIGN KEY (`OrderID`)
    REFERENCES `LittleLemonDB`.`Orders` (`OrderID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

-- -----------------------------------------------------
-- Data for table `LittleLemonDB`.`Customers`
-- -----------------------------------------------------
START TRANSACTION;
USE `LittleLemonDB`;
INSERT INTO `LittleLemonDB`.`Customers` (`CustomerID`, `FirstName`, `LastName`, `PhoneNumber`, `Address`, `City`, `State`) VALUES (1, 'WalkIn', 'Customer', 1111111111, '1 LittleLemon Street', 'Chicago', 'IL');
INSERT INTO `LittleLemonDB`.`Customers` (`CustomerID`, `FirstName`, `LastName`, `PhoneNumber`, `Address`, `City`, `State`) VALUES (2, 'Rick', 'Hansen', 7278394038, '2 Customer Rd', 'Chicago', 'IL');
INSERT INTO `LittleLemonDB`.`Customers` (`CustomerID`, `FirstName`, `LastName`, `PhoneNumber`, `Address`, `City`, `State`) VALUES (3, 'Justin', 'Ritter', 5419382938, '3 Customer Street', 'Portland', 'OR');
INSERT INTO `LittleLemonDB`.`Customers` (`CustomerID`, `FirstName`, `LastName`, `PhoneNumber`, `Address`, `City`, `State`) VALUES (4, 'Craig', 'Reiter', 5413827392, '4 Beaver Circle', 'Beaverton', 'OR');
INSERT INTO `LittleLemonDB`.`Customers` (`CustomerID`, `FirstName`, `LastName`, `PhoneNumber`, `Address`, `City`, `State`) VALUES (5, 'Katherine', 'Murray', 7274839285, '5 StPete Rd', 'Tampa', 'FL');
INSERT INTO `LittleLemonDB`.`Customers` (`CustomerID`, `FirstName`, `LastName`, `PhoneNumber`, `Address`, `City`, `State`) VALUES (6, 'Jim', 'Mitchun', 837282739, '6 Tampa Street', 'Tampa', 'FL');
INSERT INTO `LittleLemonDB`.`Customers` (`CustomerID`, `FirstName`, `LastName`, `PhoneNumber`, `Address`, `City`, `State`) VALUES (7, 'Jane', 'Waco', 7273874929, '7 Miami Street', 'Miami', 'FL');
INSERT INTO `LittleLemonDB`.`Customers` (`CustomerID`, `FirstName`, `LastName`, `PhoneNumber`, `Address`, `City`, `State`) VALUES (8, 'Joseph', 'Holt', 9263920382, '8 Honda Road', 'Miami', 'FL');
INSERT INTO `LittleLemonDB`.`Customers` (`CustomerID`, `FirstName`, `LastName`, `PhoneNumber`, `Address`, `City`, `State`) VALUES (9, 'Toby', 'Swindell', 9374930283, '9 Toyota Blvd', 'Miami', 'FL');

COMMIT;


-- -----------------------------------------------------
-- Data for table `LittleLemonDB`.`Bookings`
-- -----------------------------------------------------
START TRANSACTION;
USE `LittleLemonDB`;
INSERT INTO `LittleLemonDB`.`Bookings` (`BookingID`, `Date`, `CustomerID`, `TableNumber`) VALUES (1, '2025-03-25', 1,  1);
INSERT INTO `LittleLemonDB`.`Bookings` (`BookingID`, `Date`, `CustomerID`, `TableNumber`) VALUES (2, '2025-03-27', 2, 2);
INSERT INTO `LittleLemonDB`.`Bookings` (`BookingID`, `Date`, `CustomerID`, `TableNumber`) VALUES (3, '2025-03-27', 3, 3);
INSERT INTO `LittleLemonDB`.`Bookings` (`BookingID`, `Date`, `CustomerID`, `TableNumber`) VALUES (4, '2025-03-27', 4, 4);
INSERT INTO `LittleLemonDB`.`Bookings` (`BookingID`, `Date`, `CustomerID`, `TableNumber`) VALUES (5, '2025-03-27', 5, 5);
INSERT INTO `LittleLemonDB`.`Bookings` (`BookingID`, `Date`, `CustomerID`, `TableNumber`) VALUES (6, '2025-03-31', 1, 4);
INSERT INTO `LittleLemonDB`.`Bookings` (`BookingID`, `Date`, `CustomerID`, `TableNumber`) VALUES (7, '2025-03-31', 7, 2);
INSERT INTO `LittleLemonDB`.`Bookings` (`BookingID`, `Date`, `CustomerID`, `TableNumber`) VALUES (8, '2025-03-31', 2, 1);
INSERT INTO `LittleLemonDB`.`Bookings` (`BookingID`, `Date`, `CustomerID`, `TableNumber`) VALUES (9, '2025-03-31', 9, 3);
INSERT INTO `LittleLemonDB`.`Bookings` (`BookingID`, `Date`, `CustomerID`, `TableNumber`) VALUES (10, '2025-4-3', 8, 5);
INSERT INTO `LittleLemonDB`.`Bookings` (`BookingID`, `Date`, `CustomerID`, `TableNumber`) VALUES (11, '2025-4-3', 9, 2);
INSERT INTO `LittleLemonDB`.`Bookings` (`BookingID`, `Date`, `CustomerID`, `TableNumber`) VALUES (12, '2025-4-3', 3, 1);
INSERT INTO `LittleLemonDB`.`Bookings` (`BookingID`, `Date`, `CustomerID`, `TableNumber`) VALUES (13, '2025-4-3', 2, 3);
INSERT INTO `LittleLemonDB`.`Bookings` (`BookingID`, `Date`, `CustomerID`, `TableNumber`) VALUES (15, '2025-4-7', 1, 1);

COMMIT;


-- -----------------------------------------------------
-- Data for table `LittleLemonDB`.`Menu`
-- -----------------------------------------------------
START TRANSACTION;
USE `LittleLemonDB`;
INSERT INTO `LittleLemonDB`.`Menu` (`MenuID`, `Category`, `Name`, `Cost`, `Price`, `Description`) VALUES (1, 'System', 'Pending Ordering', 0, 0, 'Customer haven\'t ordered yet');
INSERT INTO `LittleLemonDB`.`Menu` (`MenuID`, `Category`, `Name`, `Cost`, `Price`, `Description`) VALUES (2, 'Starters', 'Spring Roll', 5, 8, 'Vietnam style fried spring rolls');
INSERT INTO `LittleLemonDB`.`Menu` (`MenuID`, `Category`, `Name`, `Cost`, `Price`, `Description`) VALUES (3, 'Starters', 'Empanadas', 7, 12, 'Cheese stuffed Empanadas');
INSERT INTO `LittleLemonDB`.`Menu` (`MenuID`, `Category`, `Name`, `Cost`, `Price`, `Description`) VALUES (4, 'Starters', 'Samosa', 2, 6, '1 piece of potato stuffed samosa, vegeterian safe');
INSERT INTO `LittleLemonDB`.`Menu` (`MenuID`, `Category`, `Name`, `Cost`, `Price`, `Description`) VALUES (5, 'Starters', 'Buffolo Wings', 10, 18, 'Fried buffolo wings');
INSERT INTO `LittleLemonDB`.`Menu` (`MenuID`, `Category`, `Name`, `Cost`, `Price`, `Description`) VALUES (6, 'Courses', 'Chicken Sanwitch', 12, 21, 'Made with free range chicken');
INSERT INTO `LittleLemonDB`.`Menu` (`MenuID`, `Category`, `Name`, `Cost`, `Price`, `Description`) VALUES (7, 'Courses', 'Wagyu Burger', 20, 32, 'fresh made burgur bun and imported australian wagyu');
INSERT INTO `LittleLemonDB`.`Menu` (`MenuID`, `Category`, `Name`, `Cost`, `Price`, `Description`) VALUES (8, 'Courses', 'Octopus Pasta', 16, 28, 'Pasta made of squid ink');
INSERT INTO `LittleLemonDB`.`Menu` (`MenuID`, `Category`, `Name`, `Cost`, `Price`, `Description`) VALUES (9, 'Courses', 'Grilled Salmon', 15, 30, 'Fresh Atlantic salmon');
INSERT INTO `LittleLemonDB`.`Menu` (`MenuID`, `Category`, `Name`, `Cost`, `Price`, `Description`) VALUES (10, 'Courses', 'Poke Bowl', 10, 24, 'Sushi grade tuna and endamame');
INSERT INTO `LittleLemonDB`.`Menu` (`MenuID`, `Category`, `Name`, `Cost`, `Price`, `Description`) VALUES (11, 'Drinks', 'Oolong Tea', 2, 5, 'Fresh brewed Chinese Oolong tea');
INSERT INTO `LittleLemonDB`.`Menu` (`MenuID`, `Category`, `Name`, `Cost`, `Price`, `Description`) VALUES (12, 'Drinks', 'Espresso', 3, 9, 'Fresh made Espresso made of Columbia imported beans');
INSERT INTO `LittleLemonDB`.`Menu` (`MenuID`, `Category`, `Name`, `Cost`, `Price`, `Description`) VALUES (13, 'Dessert', 'Tiramisu', 4, 12, 'Coffee flavor dessert');
INSERT INTO `LittleLemonDB`.`Menu` (`MenuID`, `Category`, `Name`, `Cost`, `Price`, `Description`) VALUES (14, 'Dessert', 'Cheese Cake', 4, 11, 'Chef\'s special cheese cake');
INSERT INTO `LittleLemonDB`.`Menu` (`MenuID`, `Category`, `Name`, `Cost`, `Price`, `Description`) VALUES (15, 'Dessert', 'Mochi Icecream', 3, 11.50, 'Made by Japanes imported green tea powder');

COMMIT;


-- -----------------------------------------------------
-- Data for table `LittleLemonDB`.`Employees`
-- -----------------------------------------------------
START TRANSACTION;
USE `LittleLemonDB`;
INSERT INTO `LittleLemonDB`.`Employees` (`EmployeeID`, `Role`, `Full Name`, `ManagerID`, `Salary`, `Address`, `ContactNumber`) VALUES (1, 'System', 'System', 1, 111111, '989 Thyme Square, EdgeWater, Chicago, IL', 313212332);
INSERT INTO `LittleLemonDB`.`Employees` (`EmployeeID`, `Role`, `Full Name`, `ManagerID`, `Salary`, `Address`, `ContactNumber`) VALUES (2, 'Manager', 'Adrian Gollini', 2, 100000, '879 Sage Street, West Loop, Chicago, IL', 313212153);
INSERT INTO `LittleLemonDB`.`Employees` (`EmployeeID`, `Role`, `Full Name`, `ManagerID`, `Salary`, `Address`, `ContactNumber`) VALUES (3, 'Associate Manager', 'Elena Salvai', 2, 80000, '724, Parsley Lane, Old Town, Chicago, IL', 313212643);
INSERT INTO `LittleLemonDB`.`Employees` (`EmployeeID`, `Role`, `Full Name`, `ManagerID`, `Salary`, `Address`, `ContactNumber`) VALUES (4, 'Receptionist', 'Fatma Kaya', 2, 60000, '334, Dill Square, Lincoln Park, Chicago, IL', 313212938);
INSERT INTO `LittleLemonDB`.`Employees` (`EmployeeID`, `Role`, `Full Name`, `ManagerID`, `Salary`, `Address`, `ContactNumber`) VALUES (5, 'Assistent Chef', 'Giorgos Dioudis', 4, 90000, '245 Dill Square, Lincoln Park, Chicago, IL', 313212142);
INSERT INTO `LittleLemonDB`.`Employees` (`EmployeeID`, `Role`, `Full Name`, `ManagerID`, `Salary`, `Address`, `ContactNumber`) VALUES (6, 'Head Chef', 'Mario Gollini', 2, 150000, '132  Bay Lane, Chicago, IL', 313212666);
INSERT INTO `LittleLemonDB`.`Employees` (`EmployeeID`, `Role`, `Full Name`, `ManagerID`, `Salary`, `Address`, `ContactNumber`) VALUES (7, 'Waiter', 'Adam Lee', 2, 65000, '888 Marian Rd, Chicago, IL', 313212777);

COMMIT;


-- -----------------------------------------------------
-- Data for table `LittleLemonDB`.`Orders`
-- -----------------------------------------------------
START TRANSACTION;
USE `LittleLemonDB`;
INSERT INTO `LittleLemonDB`.`Orders` (`OrderID`, `OrderDate`, `CustomerID`, `Quantity`, `BookingID`, `MenuID`, `AssignedTo`) VALUES (1, '2025-03-25', 1, 2, 1, 1, 7);
INSERT INTO `LittleLemonDB`.`Orders` (`OrderID`, `OrderDate`, `CustomerID`, `Quantity`, `BookingID`, `MenuID`, `AssignedTo`) VALUES (2, '2025-03-25', 2, 3, DEFAULT, 1, 7);
INSERT INTO `LittleLemonDB`.`Orders` (`OrderID`, `OrderDate`, `CustomerID`, `Quantity`, `BookingID`, `MenuID`, `AssignedTo`) VALUES (3, '2025-03-25', 3, 1, DEFAULT, 2, 7);
INSERT INTO `LittleLemonDB`.`Orders` (`OrderID`, `OrderDate`, `CustomerID`, `Quantity`, `BookingID`, `MenuID`, `AssignedTo`) VALUES (4, '2025-03-27', 2, 2, 2, 2, 7);
INSERT INTO `LittleLemonDB`.`Orders` (`OrderID`, `OrderDate`, `CustomerID`, `Quantity`, `BookingID`, `MenuID`, `AssignedTo`) VALUES (5, '2025-03-27', 3, 4, 3, 4, 7);
INSERT INTO `LittleLemonDB`.`Orders` (`OrderID`, `OrderDate`, `CustomerID`, `Quantity`, `BookingID`, `MenuID`, `AssignedTo`) VALUES (6, '2025-03-27', 4, 2, DEFAULT, 3, 7);
INSERT INTO `LittleLemonDB`.`Orders` (`OrderID`, `OrderDate`, `CustomerID`, `Quantity`, `BookingID`, `MenuID`, `AssignedTo`) VALUES (7, '2025-03-27', 5, 1, 5, 1, 7);
INSERT INTO `LittleLemonDB`.`Orders` (`OrderID`, `OrderDate`, `CustomerID`, `Quantity`, `BookingID`, `MenuID`, `AssignedTo`) VALUES (8, '2025-03-31', 1, 5, 4, 5, 7);
INSERT INTO `LittleLemonDB`.`Orders` (`OrderID`, `OrderDate`, `CustomerID`, `Quantity`, `BookingID`, `MenuID`, `AssignedTo`) VALUES (9, '2025-03-31', 7, 2, 2, 3, 7);
INSERT INTO `LittleLemonDB`.`Orders` (`OrderID`, `OrderDate`, `CustomerID`, `Quantity`, `BookingID`, `MenuID`, `AssignedTo`) VALUES (10, '2025-03-31', 2, 3, 1, 2, 7);
INSERT INTO `LittleLemonDB`.`Orders` (`OrderID`, `OrderDate`, `CustomerID`, `Quantity`, `BookingID`, `MenuID`, `AssignedTo`) VALUES (11, '2025-03-31', 9, 1, 3, 4, 7);
INSERT INTO `LittleLemonDB`.`Orders` (`OrderID`, `OrderDate`, `CustomerID`, `Quantity`, `BookingID`, `MenuID`, `AssignedTo`) VALUES (12, '2025-03-31', 3, 2, DEFAULT, 5, 7);
INSERT INTO `LittleLemonDB`.`Orders` (`OrderID`, `OrderDate`, `CustomerID`, `Quantity`, `BookingID`, `MenuID`, `AssignedTo`) VALUES (13, '2025-4-3', 8, 4, 5, 6, 7);
INSERT INTO `LittleLemonDB`.`Orders` (`OrderID`, `OrderDate`, `CustomerID`, `Quantity`, `BookingID`, `MenuID`, `AssignedTo`) VALUES (14, '2025-4-3', 9, 5, 2, 7, 7);
INSERT INTO `LittleLemonDB`.`Orders` (`OrderID`, `OrderDate`, `CustomerID`, `Quantity`, `BookingID`, `MenuID`, `AssignedTo`) VALUES (15, '2025-4-3', 3, 6, 1, 8, 7);
INSERT INTO `LittleLemonDB`.`Orders` (`OrderID`, `OrderDate`, `CustomerID`, `Quantity`, `BookingID`, `MenuID`, `AssignedTo`) VALUES (16, '2025-4-3', 2, 2, 3, 9, 7);
INSERT INTO `LittleLemonDB`.`Orders` (`OrderID`, `OrderDate`, `CustomerID`, `Quantity`, `BookingID`, `MenuID`, `AssignedTo`) VALUES (17, '2025-4-3', 5, 1, DEFAULT, 4, 7);
INSERT INTO `LittleLemonDB`.`Orders` (`OrderID`, `OrderDate`, `CustomerID`, `Quantity`, `BookingID`, `MenuID`, `AssignedTo`) VALUES (18, '2025-4-3', 4, 2, DEFAULT, 3, 7);
INSERT INTO `LittleLemonDB`.`Orders` (`OrderID`, `OrderDate`, `CustomerID`, `Quantity`, `BookingID`, `MenuID`, `AssignedTo`) VALUES (19, '2025-4-7', 1, 4, 1, 2, 7);
INSERT INTO `LittleLemonDB`.`Orders` (`OrderID`, `OrderDate`, `CustomerID`, `Quantity`, `BookingID`, `MenuID`, `AssignedTo`) VALUES (20, '2025-4-7', 6, 2, DEFAULT, 5, 7);
INSERT INTO `LittleLemonDB`.`Orders` (`OrderID`, `OrderDate`, `CustomerID`, `Quantity`, `BookingID`, `MenuID`, `AssignedTo`) VALUES (21, '2025-4-18', 7, 6, DEFAULT, NULL, NULL);
INSERT INTO `LittleLemonDB`.`Orders` (`OrderID`, `OrderDate`, `CustomerID`, `Quantity`, `BookingID`, `MenuID`, `AssignedTo`) VALUES (22, '2025-4-18', 8, 5, DEFAULT, NULL, NULL);
INSERT INTO `LittleLemonDB`.`Orders` (`OrderID`, `OrderDate`, `CustomerID`, `Quantity`, `BookingID`, `MenuID`, `AssignedTo`) VALUES (23, '2025-4-18', 3, 4, DEFAULT, NULL, NULL);
INSERT INTO `LittleLemonDB`.`Orders` (`OrderID`, `OrderDate`, `CustomerID`, `Quantity`, `BookingID`, `MenuID`, `AssignedTo`) VALUES (24, '2025-4-18', 2, 3, DEFAULT, NULL, NULL);

COMMIT;


-- -----------------------------------------------------
-- Data for table `LittleLemonDB`.`OrderDeliveryStatus`
-- -----------------------------------------------------
START TRANSACTION;
USE `LittleLemonDB`;
INSERT INTO `LittleLemonDB`.`OrderDeliveryStatus` (`OrderDeliveryStatusID`, `OrderID`, `DeliveryDate`, `Status`, `UpdatedDate`) VALUES (1, 1, '2025-4-1', 'Delivered', '2025-4-1');
INSERT INTO `LittleLemonDB`.`OrderDeliveryStatus` (`OrderDeliveryStatusID`, `OrderID`, `DeliveryDate`, `Status`, `UpdatedDate`) VALUES (2, 2, '2025-4-1', 'Delivered', '2025-4-1');
INSERT INTO `LittleLemonDB`.`OrderDeliveryStatus` (`OrderDeliveryStatusID`, `OrderID`, `DeliveryDate`, `Status`, `UpdatedDate`) VALUES (3, 3, '2025-4-1', 'Delivered', '2025-4-1');
INSERT INTO `LittleLemonDB`.`OrderDeliveryStatus` (`OrderDeliveryStatusID`, `OrderID`, `DeliveryDate`, `Status`, `UpdatedDate`) VALUES (4, 4, '2025-4-1', 'Delivered', '2025-4-1');
INSERT INTO `LittleLemonDB`.`OrderDeliveryStatus` (`OrderDeliveryStatusID`, `OrderID`, `DeliveryDate`, `Status`, `UpdatedDate`) VALUES (5, 5, '2025-4-1', 'Delivered', '2025-4-1');
INSERT INTO `LittleLemonDB`.`OrderDeliveryStatus` (`OrderDeliveryStatusID`, `OrderID`, `DeliveryDate`, `Status`, `UpdatedDate`) VALUES (6, 6, '2025-4-1', 'Delivered', '2025-4-1');
INSERT INTO `LittleLemonDB`.`OrderDeliveryStatus` (`OrderDeliveryStatusID`, `OrderID`, `DeliveryDate`, `Status`, `UpdatedDate`) VALUES (7, 7, '2025-4-7', 'Delivered', '2025-4-7');
INSERT INTO `LittleLemonDB`.`OrderDeliveryStatus` (`OrderDeliveryStatusID`, `OrderID`, `DeliveryDate`, `Status`, `UpdatedDate`) VALUES (8, 8, '2025-4-7', 'Delivered', '2025-4-7');
INSERT INTO `LittleLemonDB`.`OrderDeliveryStatus` (`OrderDeliveryStatusID`, `OrderID`, `DeliveryDate`, `Status`, `UpdatedDate`) VALUES (9, 9, '2025-4-7', 'Delivered', '2025-4-7');
INSERT INTO `LittleLemonDB`.`OrderDeliveryStatus` (`OrderDeliveryStatusID`, `OrderID`, `DeliveryDate`, `Status`, `UpdatedDate`) VALUES (10, 10, '2025-4-7', 'Delivered', '2025-4-7');
INSERT INTO `LittleLemonDB`.`OrderDeliveryStatus` (`OrderDeliveryStatusID`, `OrderID`, `DeliveryDate`, `Status`, `UpdatedDate`) VALUES (11, 11, '2025-4-12', 'Delivered', '2025-4-12');
INSERT INTO `LittleLemonDB`.`OrderDeliveryStatus` (`OrderDeliveryStatusID`, `OrderID`, `DeliveryDate`, `Status`, `UpdatedDate`) VALUES (12, 12, '2025-4-12', 'Delivered', '2025-4-12');
INSERT INTO `LittleLemonDB`.`OrderDeliveryStatus` (`OrderDeliveryStatusID`, `OrderID`, `DeliveryDate`, `Status`, `UpdatedDate`) VALUES (13, 13, '2025-4-12', 'Delivered', '2025-4-12');
INSERT INTO `LittleLemonDB`.`OrderDeliveryStatus` (`OrderDeliveryStatusID`, `OrderID`, `DeliveryDate`, `Status`, `UpdatedDate`) VALUES (14, 14, NULL, 'Shipping in progress', '2025-4-17');
INSERT INTO `LittleLemonDB`.`OrderDeliveryStatus` (`OrderDeliveryStatusID`, `OrderID`, `DeliveryDate`, `Status`, `UpdatedDate`) VALUES (15, 15, NULL, 'Shipping in progress', '2025-4-17');
INSERT INTO `LittleLemonDB`.`OrderDeliveryStatus` (`OrderDeliveryStatusID`, `OrderID`, `DeliveryDate`, `Status`, `UpdatedDate`) VALUES (16, 16, NULL, 'Shipping in progress', '2025-4-17');
INSERT INTO `LittleLemonDB`.`OrderDeliveryStatus` (`OrderDeliveryStatusID`, `OrderID`, `DeliveryDate`, `Status`, `UpdatedDate`) VALUES (17, 17, NULL, 'Shipping in progress', '2025-4-17');
INSERT INTO `LittleLemonDB`.`OrderDeliveryStatus` (`OrderDeliveryStatusID`, `OrderID`, `DeliveryDate`, `Status`, `UpdatedDate`) VALUES (18, 18, NULL, 'Shipping in progress', '2025-4-17');
INSERT INTO `LittleLemonDB`.`OrderDeliveryStatus` (`OrderDeliveryStatusID`, `OrderID`, `DeliveryDate`, `Status`, `UpdatedDate`) VALUES (19, 19, NULL, 'Shipping in progress', '2025-4-17');
INSERT INTO `LittleLemonDB`.`OrderDeliveryStatus` (`OrderDeliveryStatusID`, `OrderID`, `DeliveryDate`, `Status`, `UpdatedDate`) VALUES (20, 20, NULL, 'Ready to ship', '2025-4-17');
INSERT INTO `LittleLemonDB`.`OrderDeliveryStatus` (`OrderDeliveryStatusID`, `OrderID`, `DeliveryDate`, `Status`, `UpdatedDate`) VALUES (21, 21, NULL, 'Preparing package', '2025-4-18');
INSERT INTO `LittleLemonDB`.`OrderDeliveryStatus` (`OrderDeliveryStatusID`, `OrderID`, `DeliveryDate`, `Status`, `UpdatedDate`) VALUES (22, 22, NULL, 'Preparing package', '2025-4-18');
INSERT INTO `LittleLemonDB`.`OrderDeliveryStatus` (`OrderDeliveryStatusID`, `OrderID`, `DeliveryDate`, `Status`, `UpdatedDate`) VALUES (23, 23, NULL, 'Preparing package', '2025-4-18');
INSERT INTO `LittleLemonDB`.`OrderDeliveryStatus` (`OrderDeliveryStatusID`, `OrderID`, `DeliveryDate`, `Status`, `UpdatedDate`) VALUES (24, 24, NULL, 'Preparing package', '2025-4-18');

COMMIT;

