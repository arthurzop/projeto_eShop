-- CHECAR OS ATRIBUTOS DA TABELA (NAO ESQUECER!!!)

CREATE DATABASE E_SHOP_CONNECT;

USE E_SHOP_CONNECT;

CREATE TABLE User (
	userID					CHAR(10) UNIQUE NOT NULL,
    userName				VARCHAR(40) NOT NULL,
    phoneNum				CHAR(9) NOT NULL UNIQUE,
    
    PRIMARY KEY (userID)
);

CREATE TABLE Buyer (
	userID					CHAR(10) UNIQUE NOT NULL,
    
    FOREIGN KEY (userID) REFERENCES User(userID)
);

CREATE TABLE Seller (
	userID					CHAR(10) UNIQUE NOT NULL,
    
    FOREIGN KEY (userID) REFERENCES User(userID)
);

CREATE TABLE BankCard (
	cardNumber				VARCHAR(16) UNIQUE NOT NULL,
    bank					VARCHAR(20) NOT NULL,
    expiryDate				DATE 		NOT NULL,
    
    PRIMARY KEY (cardNumber),
    CHECK(cardNumber>= 14)  
);

CREATE TABLE CreditCard (
	cardNumber				CHAR(16) UNIQUE NOT NULL,	
	userId 					CHAR(10) UNIQUE NOT NULL,
	organization			VARCHAR(20) NOT NULL,

	PRIMARY KEY (cardNumber),
    FOREIGN KEY (userId) REFERENCES User(userId),
    CHECK(cardNumber>= 14 AND cardNumber<= 16)  
);

CREATE TABLE DebitCard (
	cardNumber				CHAR(16) UNIQUE NOT NULL,	
	userId 					CHAR(10) UNIQUE NOT NULL,
	organization			VARCHAR(20) NOT NULL,

	PRIMARY KEY (cardNumber),
    FOREIGN KEY (userId) REFERENCES User(userId),
    CHECK(cardNumber>= 14 AND cardNumber<= 16)  
);

CREATE TABLE Store (
	sid						CHAR(2) UNIQUE NOT NULL,
    name					VARCHAR(40) UNIQUE NOT NULL,
    startTime				TIME NOT NULL,
    customerGrade			INT,
    streetAddr				VARCHAR(100) NOT NULL,
    city					VARCHAR(30) NOT NULL,
    province				VARCHAR(30) NOT NULL,
    
    PRIMARY KEY (sid),
    CHECK(customerGrade >= 1 AND customerGrade<= 5)
);

CREATE TABLE Product (
	pid						CHAR(5) UNIQUE NOT NULL, 
    sid						CHAR(2) UNIQUE NOT NULL, 
    name					VARCHAR(100) NOT NULL, 
    brand					VARCHAR(20) NOT NULL, 
    type					VARCHAR(30) NOT NULL,
    amount					INT, 
    price					CHAR(10) NOT NULL, 
    color					VARCHAR(15) NOT NULL, 
    modelNumber				VARCHAR(10) NOT NULL,
    
    PRIMARY KEY (pid),
    FOREIGN KEY (sid) REFERENCES Store(sid)
);


CREATE TABLE OrderItem (
	itemid					CHAR(5) UNIQUE NOT NULL, 
    pid						CHAR(5) UNIQUE NOT NULL, 
    price					FLOAT NOT NULL, 
    creationTime			TIME NOT NULL,
    
    PRIMARY KEY (itemid),
    FOREIGN KEY (pid) REFERENCES Product(pid)
);

CREATE TABLE ToOrder (
	orderNumber				CHAR(5) UNIQUE NOT NULL, 
    creationTime			TIME NOT NULL,  
    paymentStatus			VARCHAR(30) NOT NULL,
    totalAmount				INT NOT NULL,
    
    PRIMARY KEY (orderNumber)
);

CREATE TABLE Address (
	addrID					CHAR(7) UNIQUE NOT NULL, 
    userID					CHAR(10) UNIQUE NOT NULL,
    name					VARCHAR(50) NOT NULL, 
    city					VARCHAR(30) NOT NULL, 
    postalCode				CHAR(8) UNIQUE NOT NULL, 
    streetAddr				VARCHAR(30) NOT NULL, 
    province				VARCHAR(30) NOT NULL,
    contactPhoneNumber		CHAR(9) UNIQUE NOT NULL,
    
    PRIMARY KEY (addrID),
    FOREIGN KEY (userID) REFERENCES User(userID)
);

CREATE TABLE Brand (
	brandName				CHAR(4) UNIQUE NOT NULL,
    
    PRIMARY KEY (brandName)
);

CREATE TABLE Comments(
	creationTime			DATETIME NOT NULL,
	userID					CHAR(10) UNIQUE NOT NULL,
    pid						CHAR(5) UNIQUE NOT NULL, 
    grade					FLOAT,
    content 				VARCHAR(500),
    
    FOREIGN KEY (userID) REFERENCES Buyer(userID),
	FOREIGN KEY (pid) REFERENCES Product(pid)
);

CREATE TABLE ServicePoint(
	spid				INT 		NOT NULL,
    streetaddr			VARCHAR(30) NOT NULL,
    city  				VARCHAR(30) NOT NULL,
    province			VARCHAR(20) NOT NULL,
    startTime			VARCHAR(20) NOT NULL,
    endTime				VARCHAR(20) NOT NULL,
    
    PRIMARY KEY (spid)
);

CREATE TABLE Save_to_Shopping_Cart(
	userID					CHAR(10) UNIQUE NOT NULL,
    pid						CHAR(5)  UNIQUE NOT NULL,
    addTime					TIME	 NOT NULL,
    quantity				INT		 NOT NULL,
    
    PRIMARY KEY (userID, pid),
    FOREIGN KEY(userID) REFERENCES user(userID),
    FOREIGN KEY(pid) REFERENCES product(pid),
    CHECK(quantity > 0)
);

CREATE TABLE Contain(
	orderNumber		CHAR(5) UNIQUE NOT NULL,
    itemId			CHAR(5) UNIQUE NOT NULL, 
    quantity		INT 	NOT NULL,
    
    PRIMARY KEY (orderNumber, itemId),
    FOREIGN KEY (orderNumber) REFERENCES ToOrder(orderNumber),
    FOREIGN KEY (itemId) REFERENCES OrderItem(itemid)
);

CREATE TABLE Payment(
	orderNumber			CHAR(5) UNIQUE NOT NULL,
    cardNumber			VARCHAR(25) NOT NULL,
    payTime				DATE,
    
    PRIMARY KEY(orderNumber, cardNumber),
    FOREIGN KEY(orderNumber) REFERENCES ToOrder(orderNumber),
    FOREIGN KEY(cardNumber)  REFERENCES BankCard(cardNumber)
);

CREATE TABLE DeliverTo(
	addrId			CHAR(7) UNIQUE NOT NULL,
    orderNumber		CHAR(5) UNIQUE NOT NULL,
    timeDelivered	DATE,
    
    PRIMARY KEY(addrId, orderNumber),
    FOREIGN KEY(orderNumber) REFERENCES ToOrder(orderNumber),
    FOREIGN KEY(addrId) REFERENCES Address(addrID)
);

CREATE TABLE Manage(
	userId		CHAR(10) UNIQUE NOT NULL,
    sid			CHAR(2)  UNIQUE NOT NULL,
    setUpTime	DATE,
    
    PRIMARY KEY(userId, sid),
    FOREIGN KEY(userId) REFERENCES User(userID),
    FOREIGN KEY(sid) REFERENCES Store(sid)
);

CREATE TABLE AfterSalesServiceAt(
	brandName		VARCHAR(20) NOT NULL,
    spid			INT NOT NULL,
    
    PRIMARY KEY(brandName, spid),
    FOREIGN KEY(spid) REFERENCES ServicePoint(spid)
);