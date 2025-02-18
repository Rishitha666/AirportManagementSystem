-- Drop database airportmanagement;

-- Create Database
CREATE DATABASE AirportManagement;
USE AirportManagement;

-- Create Passengers Table
CREATE TABLE Passengers (
    Passenger_ID INT PRIMARY KEY AUTO_INCREMENT,
    Passenger_Name VARCHAR(100) NOT NULL,
    Contact_Details VARCHAR(150),
    Ticket_Number VARCHAR(20) UNIQUE NOT NULL,
    Class ENUM('Economy', 'Business', 'First') NOT NULL,
    Seat_Number VARCHAR(10)
);

-- Create Flights Table
CREATE TABLE Flights (
    Flight_ID INT PRIMARY KEY AUTO_INCREMENT,
    Flight_Number VARCHAR(10) UNIQUE NOT NULL,
    Route VARCHAR(150) NOT NULL,
    Destination VARCHAR(100) NOT NULL,
    Departure_Time DATETIME NOT NULL,
    Arrival_Time DATETIME NOT NULL,
    Gate_Assignment VARCHAR(10),
    Delay_Status VARCHAR(50),
    Airline_Code VARCHAR(10) NOT NULL,
    FOREIGN KEY (Airline_Code) REFERENCES Airlines(Airline_Code) ON DELETE CASCADE
);

-- Create Airlines Table
CREATE TABLE Airlines (
    Airline_Code VARCHAR(10) PRIMARY KEY,
    Airline_Name VARCHAR(150) NOT NULL,
    Fleet_Size INT CHECK(Fleet_Size >= 1) NOT NULL
);

-- Create Employees Table
CREATE TABLE Employees (
    Employee_ID INT PRIMARY KEY AUTO_INCREMENT,
    Employee_Name VARCHAR(100) NOT NULL,
    Role VARCHAR(50) NOT NULL,
    Shift VARCHAR(20) NOT NULL,
    Security_Clearance_Level VARCHAR(20) NOT NULL
);

-- Create Baggage Table
CREATE TABLE Baggage (
    Baggage_ID INT PRIMARY KEY AUTO_INCREMENT,
    Passenger_ID INT NOT NULL,
    Flight_ID INT NOT NULL,
    Scanned_Location VARCHAR(100),
    Lost_Status BOOLEAN DEFAULT FALSE,
    FOREIGN KEY (Passenger_ID) REFERENCES Passengers(Passenger_ID) ON DELETE CASCADE,
    FOREIGN KEY (Flight_ID) REFERENCES Flights(Flight_ID) ON DELETE CASCADE
);

-- Create Security Table
CREATE TABLE Security (
    Security_ID INT PRIMARY KEY AUTO_INCREMENT,
    Passenger_ID INT NOT NULL,
    Screening_Status VARCHAR(50) NOT NULL,
    Customs_Check BOOLEAN DEFAULT FALSE,
    FOREIGN KEY (Passenger_ID) REFERENCES Passengers(Passenger_ID) ON DELETE CASCADE
);

-- Create Incident Reports Table
CREATE TABLE Incident_Reports (
    Incident_ID INT PRIMARY KEY AUTO_INCREMENT,
    Security_ID INT NOT NULL,
    Incident_Details TEXT NOT NULL,
    FOREIGN KEY (Security_ID) REFERENCES Security(Security_ID) ON DELETE CASCADE
);

-- Create Maintenance Table
CREATE TABLE Maintenance (
    Maintenance_ID INT PRIMARY KEY AUTO_INCREMENT,
    Aircraft_ID VARCHAR(20) NOT NULL,
    Flight_ID INT NOT NULL,
    Maintenance_Status VARCHAR(50) NOT NULL,
    Fueling_Status VARCHAR(50) NOT NULL,
    FOREIGN KEY (Aircraft_ID) REFERENCES Aircraft_Types(Aircraft_Type_ID) ON DELETE CASCADE,
    FOREIGN KEY (Flight_ID) REFERENCES Flights(Flight_ID) ON DELETE CASCADE
);

-- Create Weather Records Table
CREATE TABLE Weather_Records (
    Weather_ID INT PRIMARY KEY AUTO_INCREMENT,
    Maintenance_ID INT NOT NULL,
    Weather_Impact TEXT NOT NULL,
    FOREIGN KEY (Maintenance_ID) REFERENCES Maintenance(Maintenance_ID) ON DELETE CASCADE
);

-- Create Airport Facilities Table
CREATE TABLE Airport_Facilities (
    Facility_ID INT PRIMARY KEY AUTO_INCREMENT,
    Facility_Type VARCHAR(100) NOT NULL,
    Location VARCHAR(100) NOT NULL,
    Availability BOOLEAN DEFAULT TRUE
);

-- Create Flight_Facility_Usage (Junction Table)
CREATE TABLE Flight_Facility_Usage (
    Usage_ID INT PRIMARY KEY AUTO_INCREMENT,
    Flight_ID INT NOT NULL,
    Facility_ID INT NOT NULL,
    Usage_Type VARCHAR(50) NOT NULL,
    Usage_Time DATETIME NOT NULL,
    FOREIGN KEY (Flight_ID) REFERENCES Flights(Flight_ID) ON DELETE CASCADE,
    FOREIGN KEY (Facility_ID) REFERENCES Airport_Facilities(Facility_ID) ON DELETE CASCADE
);

-- Create Aircraft Types Table
CREATE TABLE Aircraft_Types (
    Aircraft_Type_ID VARCHAR(20) PRIMARY KEY,
    Airline_Code VARCHAR(10) NOT NULL,
    Aircraft_Model VARCHAR(50) NOT NULL,
    FOREIGN KEY (Airline_Code) REFERENCES Airlines(Airline_Code) ON DELETE CASCADE
);

-- Create Flight Delays Table
CREATE TABLE Flight_Delays (
    Delay_ID INT PRIMARY KEY AUTO_INCREMENT,
    Flight_ID INT NOT NULL,
    Delay_Reason VARCHAR(255) NOT NULL,
    Delay_Duration INT CHECK(Delay_Duration >= 0) NOT NULL,
    FOREIGN KEY (Flight_ID) REFERENCES Flights(Flight_ID) ON DELETE CASCADE
);
