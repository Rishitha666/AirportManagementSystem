INSERT INTO Passengers (Passenger_Name, Contact_Details, Ticket_Number, Class, Seat_Number)
VALUES ('Rajesh Kumar', 'rajesh.kumar@gmail.com', 'TK2025', 'Economy', '12B');

INSERT INTO Flights (Flight_Number, Route, Destination, Departure_Time, Arrival_Time, Gate_Assignment, Delay_Status, Airline_Code)
VALUES ('AI351', 'Mumbai - Delhi', 'Delhi', '2025-03-01 10:30:00', '2025-03-01 12:45:00', 'A15', 'On-Time', 'AI35');

UPDATE Passengers 
SET Seat_Number = '14A' 
WHERE Passenger_Name = 'Rajesh Kumar';

UPDATE Flights 
SET Delay_Status = 'Delayed' 
WHERE Flight_Number = 'AI305';

DELETE FROM Passengers
WHERE Passenger_Name = 'Rajesh Kumar';

SELECT Flight_Number, Route, Departure_Time, Arrival_Time, Delay_Status 
FROM Flights 
WHERE Destination = 'Delhi';

SELECT P.Passenger_Name, S.Screening_Status, S.Customs_Check
FROM Passengers P
JOIN Security S ON P.Passenger_ID = S.Passenger_ID;

SELECT M.Maintenance_ID, A.Aircraft_Model, F.Flight_Number, M.Maintenance_Status, M.Fueling_Status
FROM Maintenance M
JOIN Aircraft_Types A ON M.Aircraft_ID = A.Aircraft_Type_ID
JOIN Flights F ON M.Flight_ID = F.Flight_ID;

SELECT Destination, COUNT(*) AS Total_Flights
FROM Flights
GROUP BY Destination;

SELECT AVG(Delay_Duration) AS Average_Delay
FROM Flight_Delays;

SELECT P.Passenger_Name, P.Ticket_Number, F.Flight_Number, F.Destination, 
       B.Baggage_ID, B.Scanned_Location, B.Lost_Status
FROM Passengers P
JOIN Baggage B ON P.Passenger_ID = B.Passenger_ID
JOIN Flights F ON B.Flight_ID = F.Flight_ID;

SELECT F.Flight_Number, F.Route, FD.Delay_Duration, FD.Delay_Reason
FROM Flights F
JOIN Flight_Delays FD ON F.Flight_ID = FD.Flight_ID
ORDER BY FD.Delay_Duration DESC
LIMIT 1;
