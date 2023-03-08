CREATE SCHEMA Good_Driver;
USE Good_Driver;

CREATE TABLE sponsor (
   Sponsor_ID INTEGER PRIMARY KEY AUTO_INCREMENT,
   Point_Value DECIMAL(10,2) NOT NULL,
   Name VARCHAR(40) NOT NULL
);

CREATE TABLE users (
   User_ID INTEGER PRIMARY KEY AUTO_INCREMENT,
   First_Name VARCHAR(20) NOT NULL, 
   Last_Name VARCHAR(20) NOT NULL,
   Street_Address VARCHAR(80),
   Street_Address_2 VARCHAR(80),
   City VARCHAR(30),
   ZIP_Code INTEGER,
   Phone_Number VARCHAR(15),
   Email VARCHAR(100) NOT NULL UNIQUE,
   "Password" VARCHAR(100) NOT NULL,
   User_Type VARCHAR(15) NOT NULL,
   last_login DATETIME
);

/*User Subtypes*/
CREATE TABLE admin_user (
   User_ID INTEGER PRIMARY KEY,
   FOREIGN KEY  (User_ID) REFERENCES users(User_ID)
);
CREATE TABLE driver_user (
   User_ID INTEGER PRIMARY KEY,
   FOREIGN KEY  (User_ID) REFERENCES users(User_ID)
);
CREATE TABLE sponsor_user (
   User_ID INTEGER PRIMARY KEY,
   Sponsor_ID INTEGER NOT NULL,
   FOREIGN KEY  (User_ID) REFERENCES users(User_ID),
   FOREIGN KEY  (Sponsor_ID) REFERENCES sponsor(Sponsor_ID)
);

CREATE TABLE driver_application (
   Application_ID INTEGER PRIMARY KEY AUTO_INCREMENT,
   Driver_ID INTEGER NOT NULL,
   Sponsor_ID INTEGER NOT NULL,
   Date_Time DATETIME NOT NULL,
   Status VARCHAR(15) NOT NULL,
   Reason VARCHAR(30),
   FOREIGN KEY  (Driver_ID) REFERENCES users(User_ID),
   FOREIGN KEY  (Sponsor_ID) REFERENCES sponsor(Sponsor_ID)
);

CREATE TABLE driver_sponsor (
   User_ID INTEGER NOT NULL,
   Sponsor_ID INTEGER NOT NULL,
   PRIMARY KEY(User_ID, Sponsor_ID),
   FOREIGN KEY (User_ID) REFERENCES users(User_ID),
   FOREIGN KEY (Sponsor_ID) REFERENCES sponsor(Sponsor_ID)
);

CREATE TABLE login_attempt (
   Attempt_ID INTEGER PRIMARY KEY AUTO_INCREMENT,
   User_ID INTEGER NOT NULL,
   Date_Time DATETIME NOT NULL,
   Was_Accepted BIT NOT NULL,
   FOREIGN KEY  (User_ID) REFERENCES users(User_ID)
);

CREATE TABLE purchase (
   Purchase_ID INTEGER PRIMARY KEY AUTO_INCREMENT,
   Total_Price DECIMAL(10,2) NOT NULL
);

CREATE TABLE item (
   Item_ID INTEGER PRIMARY KEY AUTO_INCREMENT,
   Item_Desc VARCHAR(400) NOT NULL,
   Item_Price Decimal(10,2) NOT NULL
);

CREATE TABLE purchase_item (
   Purchase_ID INTEGER NOT NULL,
   Item_ID INTEGER NOT NULL,
   Quantity INTEGER NOT NULL,
   PRIMARY KEY(Purchase_ID, Item_ID),
   FOREIGN KEY (Purchase_ID) REFERENCES purchase(Purchase_ID),
   FOREIGN KEY (Item_ID) REFERENCES item(Item_ID)
);

CREATE TABLE points (
   Transaction_ID INTEGER PRIMARY KEY AUTO_INCREMENT,
   User_ID INTEGER NOT NULL,
   Point_Total INTEGER NOT NULL,
   Points_Added_Or_Deducted INTEGER NOT NULL,
   Date_Time DATETIME NOT NULL,
   Reason VARCHAR(30) NOT NULL,
   Purchase_ID INTEGER,
   FOREIGN KEY  (User_ID) REFERENCES driver_user(User_ID),
   FOREIGN KEY  (Purchase_ID) REFERENCES purchase(Purchase_ID)
);

CREATE TABLE application_state_change (
	State_Change_ID INTEGER PRIMARY KEY AUTO_INCREMENT,
	Application_ID INT NOT NULL,
	Date_Time DATETIME NOT NULL,
	New_Status VARCHAR(15) NOT NULL,
	New_Reason VARCHAR(30),
	FOREIGN KEY (Application_ID) REFERENCES driver_application(Application_ID)
);

CREATE TABLE password_changes (
	Change_ID INT PRIMARY KEY AUTO_INCREMENT,
	Date_Time datetime NOT NULL,
	User_ID int NOT NULL,
	Type_Of_Change VARCHAR(10),
	FOREIGN KEY (User_ID) REFERENCES users(User_ID)
);