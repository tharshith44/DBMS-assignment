
CREATE TABLE `Users` (
  `UserID`        INTEGER      NOT NULL AUTO_INCREMENT,
  `FullName`      VARCHAR(50)  NOT NULL,
  `StreetAddress` VARCHAR(255) NOT NULL,
  `PostCode`      VARCHAR(10)   NOT NULL,
  `City`          VARCHAR(28)  NOT NULL,
  `Country`       VARCHAR(28)  NOT NULL,
  `Phone`         VARCHAR(12)  NOT NULL,
  `Email`         VARCHAR(50)  NOT NULL,
  `Username`      VARCHAR(28),
  `Password`      VARCHAR(158),
  `Admin`         BOOLEAN      NOT NULL DEFAULT 0,
  CONSTRAINT `PK_Users` PRIMARY KEY (`UserID`)
);

CREATE INDEX `Username` ON `Users` (`Username`);


CREATE TABLE `Addresses` (
  `AddressID`     INTEGER      NOT NULL AUTO_INCREMENT,
  `UserID`        INTEGER,
  `FullName`      VARCHAR(50)  NOT NULL,
  `StreetAddress` VARCHAR(255) NOT NULL,
  `PostCode`      VARCHAR(10)   NOT NULL,
  `City`          VARCHAR(28)  NOT NULL,
  `Country`       VARCHAR(28)  NOT NULL,
  `Phone`         VARCHAR(12)  NOT NULL,
  CONSTRAINT `PK_Addresses` PRIMARY KEY (`AddressID`),
  CONSTRAINT `FK_Users_UserID` FOREIGN KEY (`UserID`) REFERENCES `Users` (`UserID`) ON DELETE CASCADE
);



CREATE TABLE `Categories` (
  `CategoryID`   INTEGER     NOT NULL AUTO_INCREMENT,
  `CategoryName` VARCHAR(58) NOT NULL,
  `Description`  MEDIUMTEXT,
  `CategorySlug` VARCHAR(68) NOT NULL,
  `Image`        VARCHAR(58) NOT NULL,
  CONSTRAINT `PK_Categories` PRIMARY KEY (`CategoryID`)
);

CREATE INDEX `CategoryName` ON `Categories` (`CategoryName`);


CREATE TABLE `Products` (
  `ProductID`       INTEGER      NOT NULL AUTO_INCREMENT,
  `ProductName`     VARCHAR(40)  NOT NULL,
  `CategoryID`      INTEGER,
  `ProductPrice`    DECIMAL(10, 2)        DEFAULT 0,
  `UnitsInStock`    SMALLINT(5)           DEFAULT 0,
  `Description`     VARCHAR(255) NOT NULL,
  `ManufactureYear` SMALLINT(5)  NOT NULL,
  `Image`           VARCHAR(50)  NOT NULL,
  `ProductSlug`     VARCHAR(50)  NOT NULL,
  `Feature`         BOOLEAN      NOT NULL DEFAULT 0,
  CONSTRAINT `PK_Products` PRIMARY KEY (`ProductID`),
  CONSTRAINT `FK_Products_Categories` FOREIGN KEY (`CategoryID`) REFERENCES `Categories` (`CategoryID`) ON DELETE CASCADE
);

CREATE INDEX `ProductName` ON `Products` (`ProductName`);


CREATE TABLE `Orders` (
  `OrderID`   INTEGER NOT NULL AUTO_INCREMENT,
  `UserID`    INTEGER NOT NULL,
  `AddressID` INTEGER NOT NULL,
  `SubTotal`  DECIMAL(10,2),
  `Discount`  DECIMAL(10,2),
  `ShippingFee`  DECIMAL(10,2),
  `Total`  DECIMAL(10,2),
  `OrderDate` DATETIME,
  `Status`    VARCHAR(150) NOT NULL,
  CONSTRAINT `PK_Orders` PRIMARY KEY (`OrderID`),
  CONSTRAINT `FK_Orders_Users` FOREIGN KEY (`UserID`) REFERENCES `Users` (`UserID`) ON DELETE CASCADE
);

CREATE TABLE `Order Details` (
  `OrderID`   INTEGER     NOT NULL,
  `ProductID` INTEGER     NOT NULL,
  `Quantity`  SMALLINT(2) NOT NULL DEFAULT 1,
  `Total`     DECIMAL(10,2) NOT NULL,
  CONSTRAINT `PK_Order Details` PRIMARY KEY (`OrderID`, `ProductID`),
  CONSTRAINT `FK_Order_Details_Orders` FOREIGN KEY (`OrderID`) REFERENCES `Orders` (`OrderID`) ON DELETE CASCADE,
  CONSTRAINT `FK_Order_Details_Products` FOREIGN KEY (`ProductID`) REFERENCES `Products` (`ProductID`) ON DELETE CASCADE
);



CREATE TABLE `Messages` (
  `MessageID` INTEGER     NOT NULL AUTO_INCREMENT,
  `FullName`  VARCHAR(50) NOT NULL,
  `Email`     VARCHAR(50) NOT NULL,
  `Subject`   VARCHAR(128),
  `Content`   VARCHAR(158),
  CONSTRAINT `PK_Messages` PRIMARY KEY (`MessageID`)
);



CREATE TABLE `Subscribers` (
  `Email` VARCHAR(50)  NOT NULL
);



INSERT INTO `Categories` (`CategoryID`, `CategoryName`, `Description`, `CategorySlug`, `Image`) VALUES
(1, 'Smartphones', 'Latest Smartphones', 'smartphones', 'smartphone.png'),
(2, 'TVs', 'TVs', 'tvs', 'tv.png'),
(3, 'Laptops', 'Top Performing Laptops', 'laptops', 'laptops.png'),
(4, 'Gaming Consoles', 'PS5 available', 'gameconsoles', 'gameconsole.png'),
(5, 'Desktops', 'For the hardcore Gamers', 'computers', 'computers.png'),
(6, 'Headphones', 'Headphones for all purposes', 'headphones', 'headphones.png'),
(7, 'Cameras', 'Professional DSLR Cameras', 'cameras', 'cameras.png'),
(8, 'Powerbanks', 'Dont wait hours for your phone to charge', 'Powerbanks', 'powerbanks.png');


INSERT INTO `Products` (`ProductID`, `ProductName`, `CategoryID`, `ProductPrice`, `UnitsInStock`, `Description`, `ManufactureYear`, `Image`, `ProductSlug`, `Feature`) VALUES
(1, 'Iphone 12', 1, '79999.00', 8, 'Latest Iphone with magsafe Technology', 2020, 'Iphone-12.png', 'Iphone-12', 1),
(2, 'Samsung Galaxy S21', 1, '69999.00', 11, 'Latest Android Flagship', 2020, 'Samsung-Galaxy-S21.png', 'Samsung-Galaxy-S21', 0),
(3, 'Samsung QLED 8K Smart TV', 2, '134999.00', 5, 'Crisp Picture', 20201, 'Samsung-QLED-8K-Smart-TV.png', 'Samsung-QLED-8K-Smart-TV', 1),
(4, 'LG GX 77 (195.58CM) 4K Smart OLED TV', 2, '75999.00', 18, '4k LG Smart TV', 2020, 'LG-GX-77-19558CM-4K-Smart-OLED-TV.png', 'LG-GX-77-19558CM-4K-Smart-OLED-TV', 0),
(5, 'MacBook Pro M1', 3, '129999.00', 11, 'Best Notebook for students with new powerfull M1 chip', 2020, 'MacBook-Pro-M1.png', 'MacBook-Pro-M1', 1),
(6, 'Alienware Area-51M', 3, '345999.00', 5, 'Chonky Gaming Laptop. Best in Class!!', 2020, 'ALIENWARE-AREA-51M-R2-GAMING-LAPTOP.png', 'ALIENWARE-AREA-51M-R2-GAMING-LAPTOP', 0),
(7, 'PS5', 4, '35999.00', 25, 'Latest Playstation', 2020, 'PS5.png', 'PS5', 1),
(8, 'Xbox series X', 4, '35999.00', 25, 'Latest Xbox from Microsoft', 2020, 'Xbox-series-X.png', 'Xbox-series-X', 0),
(9, 'iMac M1 24-inch', 5, '11990.00', 15, 'Apple M1 chip with 8-core CPU with 4 performance cores and 4 efficiency cores, 7-core GPU and 16-core Neural Engine', 2021, 'iMac-M1-24-inch.png', 'iMac-M1-24-inch', 1),
(10, 'Ant-PC TH950X', 5, '533008.00', 2, 'AMD Threadripper 3960X (24Core, 48Threads, Upto 4.4 Ghz) with new Nvidia GTX 3090(inStock)', 2021, 'ANT-PC-METALLICA-TH950X.png', 'ANT-PC-METALLICA-TH950X', 0),
(11, 'Bose ANC', 6, '29363.00', 6, 'QuietComfort 35 wireless headphones II are engineered with renowned noise cancellation. With the Google Assistant and Amazon Alexa built-in, you have instant access to millions of songs, playlists and more—hands free. ', 2020, 'Bose-Noise-Cancellation-Headphones.png', 'Bose-Noise-Cancellation-Headphones', 1),
(12, 'FUJIFILIM X-T4', 7, '523697.00', 8, 'The X-T4 is our most powerful X Series camera to date with no compromises for stills or video', 2020, 'FUJIFILIM-X-T4.png', 'FUJIFILIM-X-T4', 1),
(13, 'Mi 3i Power Bank', 8, '1799.00', 15, 'Don’t let your devices run out of battery while you’re away with this Mi power bank. Thanks to its 18 W fast charge support, this power bank helps you charge your devices quickly and efficiently', 2020, 'Mi-3i-Power-Bank.png', 'Mi-3i-Power-Bank', 1);












