-- create dimension table

CREATE  TABLE  DM_ProductType(
productTypeID		INT NOT NULL,
productTypeName		VARCHAR2(50)   ,
CONSTRAINT	DM_productTypeID_Pk		PRIMARY	KEY(productTypeID));

CREATE  TABLE  DM_CustomerType(
customerTypeID		INT NOT NULL   ,
customerTypeName	VARCHAR2(30)  ,
CONSTRAINT	DM_customerTypeID_Pk  PRIMARY KEY(customerTypeID));

CREATE  TABLE  DM_Product(
productID		INT NOT NULL,
productName		VARCHAR2(50)   ,
productTypeID		INT NOT NULL   ,
CONSTRAINT	DM_productID_Pk		PRIMARY	KEY(productID),
CONSTRAINT DM_productTypeID_Fk FOREIGN KEY (productTypeID) REFERENCES DM_ProductType(productTypeID));

CREATE  TABLE  DM_Customer(
customerID		INT NOT NULL,
customerTypeID		INT NOT NULL   ,
CONSTRAINT	DM_customerID_Pk  PRIMARY KEY(customerID),
CONSTRAINT DM_customerTypeID_Fk FOREIGN KEY (customerTypeID) REFERENCES DM_CustomerType(customerTypeID));

CREATE TABLE DM_Time (
    timeID DATE PRIMARY KEY,
    week INT,
    month INT,
    quarter INT,
    year INT,
    holiday INT
CONSTRAINT	DM_timeID_Pk  PRIMARY KEY(timeID),

);

-- create fact table

CREATE TABLE FT_Order (
    timeID DATE ,
    productID INT ,
    customerID INT ,
    Quatity INT ,
   revenue DECIMAL(10,2),
CONSTRAINT        Fact_Order_Pk     PRIMARY  KEY(timeID, productID,customerID),
CONSTRAINT Order_timeID_Fk FOREIGN KEY (timeID) REFERENCES DM_Time(timeID),
CONSTRAINT Order_productID_Fk FOREIGN KEY (productID) REFERENCES DM_Product(productID),
CONSTRAINT Order_customerID_Fk FOREIGN KEY (customerID) REFERENCES DM_Customer(customerID)
);

CREATE TABLE FT_Rating (
    timeID DATE,
    customerID INT,
    Score NUMBER(10,2),
    CONSTRAINT FT_Rating_Pk PRIMARY KEY(timeID, customerID) ,
    CONSTRAINT customerID_Rating_FK foreign key (customerID) references DM_Customer (customerID) ,
    CONSTRAINT timeID_Rating_FK foreign key (timeID) references DM_Time (timeID)
);
