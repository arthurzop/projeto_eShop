-- Criação do Banco de Dados
CREATE DATABASE eshop_connect_turmaA;

-- Ativar o uso do BD
USE eshop_connect_turmaA;

-- Criando as Tabelas
CREATE TABLE users(
	pk_userid		INT 		NOT NULL UNIQUE,
    name			VARCHAR(50)	NOT NULL,
    phoneNum		CHAR(12)	NOT NULL,
    
    PRIMARY KEY(pk_userid)
);

CREATE TABLE buyer(
	pk_userid		INT 		NOT NULL UNIQUE,
    
    PRIMARY KEY(pk_userid),
    FOREIGN KEY (pk_userid) REFERENCES users(pk_userid)
);

CREATE TABLE seller(
	pk_userid		INT 		NOT NULL UNIQUE,
    
    PRIMARY KEY(pk_userid),
    FOREIGN KEY (pk_userid) REFERENCES users(pk_userid)
);

CREATE TABLE bank_card(
	pk_cardNumber	VARCHAR(25) NOT NULL,
    expiryDate		DATE,
    bank			VARCHAR(20),
    
    PRIMARY KEY(pk_cardNumber)
);

CREATE TABLE credit_card(
	pk_cardNumber	VARCHAR(25) NOT NULL,
    fk_userid		INT 		NOT NULL UNIQUE,
    organization	VARCHAR(20) NOT NULL,
    
    PRIMARY KEY(pk_cardNumber),
    FOREIGN KEY(pk_cardNumber) 	REFERENCES bank_card(pk_cardNumber),
    FOREIGN KEY(fk_userid) 		REFERENCES users(pk_userid)
);

CREATE TABLE debit_card(
	pk_cardNumber	VARCHAR(25) NOT NULL,
    fk_userid		INT 		NOT NULL UNIQUE,
    organization	VARCHAR(20) NOT NULL,
    
    PRIMARY KEY(pk_cardNumber),
    FOREIGN KEY(pk_cardNumber) 	REFERENCES bank_card(pk_cardNumber),
    FOREIGN KEY(fk_userid) 		REFERENCES users(pk_userid)
);

CREATE TABLE store(
	sid				INT 	NOT NULL,
	name			VARCHAR(20),
    province		VARCHAR(20),
    city			VARCHAR(20),
    streetAddr		VARCHAR(20),
    customerGrade	INT,
    startDate		DATE,
    
    PRIMARY KEY(sid)
);

CREATE TABLE brand(
	pk_brandName	VARCHAR(20) NOT NULL,
    
	PRIMARY KEY(pk_brandName)
);

CREATE TABLE product(
	pk_pid				INT 		NOT NULL,
    fk_sid				INT 		NOT NULL,
    fk_brand			VARCHAR(50) NOT NULL,
    name				VARCHAR(100),
    type				VARCHAR(50),
	modelNumber			VARCHAR(50),
    color				VARCHAR(50),
    amount				INT,
    price				INT,
    
    PRIMARY KEY(pk_pid),
    FOREIGN KEY(fk_sid) 	REFERENCES store(sid),
    FOREIGN KEY(fk_brand)	REFERENCES brand(pk_brandName)
);

CREATE TABLE orderItem(
	pk_itemid			INT NOT NULL,
    fk_pid				INT NOT NULL,
    price				DECIMAL(10,2),
    creationTime		DATE,
    
    PRIMARY KEY(pk_itemid),
    FOREIGN KEY(fk_pid) REFERENCES product(pk_pid)
);

CREATE TABLE orders(
	pk_orderNumber		INT NOT NULL,
    paymentState		VARCHAR(12),
    creationTime		DATE,
    totalAmount			DECIMAL(10,2),
    
    PRIMARY KEY(pk_orderNUmber)
);

CREATE TABLE comments(
	creationTime		TIME NOT NULL,
    fk_userid			INT  NOT NULL,
    fk_pid				INT  NOT NULL,
    grade				FLOAT,
    content				VARCHAR(100),
    
    PRIMARY KEY(creationTime, fk_userid, fk_pid),
    FOREIGN KEY(fk_userid) REFERENCES users(pk_userid),
    FOREIGN KEY(fk_pid)    REFERENCES product(pk_pid)
);

CREATE TABLE service_point(
	pk_spid				INT NOT NULL,
    streetAddr          VARCHAR(40),
    city				VARCHAR(30),
	province			VARCHAR(20),
    startTime			TIME,
    endTime				TIME,
    
    PRIMARY KEY(pk_spid)
);

CREATE TABLE save_to_shopping_cart(
	pk_userid		INT NOT NULL,
    pk_pid			INT NOT NULL,
	addTime			TIME,
    quantity 		INT,
    
    PRIMARY KEY(pk_userid, pk_pid),
    FOREIGN KEY(pk_userid) REFERENCES buyer(pk_userid),
    FOREIGN KEY(pk_pid)    REFERENCES product(pk_pid)
);

CREATE TABLE contain(
	pk_orderNumber	INT NOT NULL,
    fk_itemid		INT NOT NULL,
    quantity		INT,
    
    PRIMARY KEY(pk_orderNumber, fk_itemid),
    FOREIGN KEY(pk_orderNumber) REFERENCES orders(pk_orderNumber),
    FOREIGN KEY(fk_itemid) 		REFERENCES orderItem(pk_itemid)
);

CREATE TABLE payment(
	fk_orderNumber	INT 		NOT NULL,
    fk_cardNumber	VARCHAR(25) NOT NULL,
    payTime			DATETIME,
    
    PRIMARY KEY(fk_orderNumber, fk_cardNumber),
    FOREIGN KEY(fk_orderNumber) REFERENCES orders(pk_orderNumber),
    FOREIGN KEY(fk_cardNumber)  REFERENCES bank_card(pk_cardNumber)
);

CREATE TABLE address(
	pk_addrid			INT NOT NULL,
    fk_userid			INT NOT NULL,
    name				VARCHAR(50),
    contactPhoneNumber	VARCHAR(20),
    province			VARCHAR(100),
    city				VARCHAR(100),
    streetAddr			VARCHAR(100),
    postCode			VARCHAR(12),
    
    PRIMARY KEY(pk_addrid),
    FOREIGN KEY(fk_userid) REFERENCES users(pk_userid)
);

CREATE TABLE deliver_to(
	fk_addrid		INT NOT NULL,
    fk_orderNumber	INT NOT NULL,
    timeDelivered	DATE,
    
    PRIMARY KEY(fk_addrid, fk_orderNumber),
    FOREIGN KEY(fk_addrid) REFERENCES address(pk_addrid),
    FOREIGN KEY(fk_orderNumber) REFERENCES orders(pk_orderNumber)
);


CREATE TABLE manage(
	fk_userid		INT NOT NULL,
    fk_sid			INT NOT NULL,
    setUpTime		DATE,
    
    PRIMARY KEY(fk_userid, fk_sid),
    FOREIGN KEY(fk_userid) REFERENCES seller(pk_userid),
    FOREIGN KEY(fk_sid)    REFERENCES store(sid)
);

CREATE TABLE after_sales_service_at(
	fk_brandName	VARCHAR(20) NOT NULL,
    fk_spid			INT         NOT NULL,
    
    PRIMARY KEY(fk_brandName, fk_spid),
    FOREIGN KEY(fk_brandName) REFERENCES brand(pk_brandName),
    FOREIGN KEY(fk_spid)      REFERENCES service_point(pk_spid)
);