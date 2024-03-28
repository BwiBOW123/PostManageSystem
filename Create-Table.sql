CREATE TABLE PM_ProductType_S (
    productTypeID INT NOT NULL,
    productTypeName VARCHAR2(50) NOT NULL,
    CONSTRAINT productTypeID_pk PRIMARY KEY (productTypeID)
);

CREATE TABLE PM_Product_M (
    productID INT NOT NULL,
    productName VARCHAR2(50) NOT NULL,
    sizeOfProduct VARCHAR2(10),
    costPrice NUMBER(10,2),
    unitPrice NUMBER(10,2),
    qtyRemain NUMBER(10),
    productTypeID INT,
 CONSTRAINT productID_pk PRIMARY KEY (productID),
    CONSTRAINT productTypeID_fk FOREIGN KEY (productTypeID) REFERENCES PM_ProductType_S (productTypeID)
);

CREATE TABLE PM_Postalcode_M (
    posID INT NOT NULL,
    posName VARCHAR2(50) NOT NULL,
    CONSTRAINT posID_pk PRIMARY KEY (posID));

CREATE TABLE PM_ShippingType_S (
	shippingTypeID int,
	shippingTypeName VARCHAR(10),
	shippingTypePrice Number(10,2),
 CONSTRAINT  shippingTypeID_pk PRIMARY KEY (shippingTypeID)
);

CREATE TABLE PM_Career_M (
careerID INT NOT NULL ,
careerName VARCHAR(30) ,
CONSTRAINT careerID_pk PRIMARY KEY (careerID)
);

CREATE TABLE PM_CustomerType_S (
customerTypeID INT NOT NULL,
customerTypeName VARCHAR(30) ,
CONSTRAINT customerType_pk PRIMARY KEY (customerTypeID)
);

CREATE TABLE PM_Customer_M (
customerID INT NOT NULL,
firstName VARCHAR(30),
lastName VARCHAR(30),
personalID VARCHAR(13),
sex VARCHAR(2),
birthday DATE,
address VARCHAR(50),
email VARCHAR(30),
phone VARCHAR(10),
customerTypeID INT,
careerID INT,
posID INT,
CONSTRAINT customerID_pk PRIMARY KEY (customerID),
CONSTRAINT careerID_fk FOREIGN KEY (careerID) REFERENCES PM_Career_M(careerID),
CONSTRAINT customerTypeID_fk FOREIGN KEY (customerTypeID) REFERENCES PM_CustomerType_S(customerTypeID),
CONSTRAINT posID_fk FOREIGN KEY (posID) REFERENCES PM_Postalcode_M(posID)
);

CREATE TABLE PM_Parcel_M (
    parcelID VARCHAR(13) NOT NULL,
    phoneReceiver VARCHAR(10),
    addressReceiver VARCHAR(50),
    posID INT,
    weight DECIMAL(4,2),
    price DECIMAL(5,2),
    shippingTypeID INT,
    customerID INT,
    CONSTRAINT parcelID_pk PRIMARY KEY (parcelID),
    CONSTRAINT shippingTypeID_fk FOREIGN KEY (shippingTypeID) REFERENCES PM_ShippingType_S(shippingTypeID),
    CONSTRAINT customerID_ShippingType_fk FOREIGN KEY (customerID) REFERENCES PM_Customer_M(customerID),
    CONSTRAINT posID_ShippingType_fk FOREIGN KEY (posID) REFERENCES PM_PostalCode_M(posID)
);


CREATE TABLE PM_Bills_M (
    billID INT NOT NULL,
    dateOfBill DATE NOT NULL,
    totalPrice NUMBER(10,2),
    customerID int,
     CONSTRAINT  billID_pk PRIMARY KEY (billID),
     CONSTRAINT customerID_fk  FOREIGN KEY (customerID) REFERENCES PM_Customer_M (customerID));


CREATE TABLE PM_ListOfProduct_T (
    seq INT NOT NULL,
    billID int,
    productID int,
    qty NUMBER(10),
    currentPrice NUMBER(10,2),
    CONSTRAINT  seq_ListOfProduct_comb PRIMARY KEY (seq,billID,productID),
    CONSTRAINT  productID_fk FOREIGN KEY (productID) REFERENCES PM_Product_M(productID),
    CONSTRAINT  billID_fk FOREIGN KEY (billID) REFERENCES PM_Bills_M (billID)
);

CREATE TABLE PM_ListOfParcel_T (
    seq INT NOT NULL,
    currentPrice DECIMAL(10,2),
    billID INT NOT NULL,
    parcelID VARCHAR(13) NOT NULL,
    CONSTRAINT billID_ListOfParcel_fk FOREIGN KEY (billID) REFERENCES PM_Bills_M (billID),
    CONSTRAINT parcelID_ListOfParcel_fk FOREIGN KEY (parcelID) REFERENCES PM_Parcel_M(parcelID),
    CONSTRAINT seq_ListOfParcel_comb PRIMARY KEY (seq,billID, parcelID)
);


