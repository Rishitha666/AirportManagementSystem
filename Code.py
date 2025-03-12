import mysql.connector  # Import MySQL connector module

# Try to connect to the MySQL database
try:
    db_connection = mysql.connector.connect(
        host="localhost",      # Database server
        user="root",           # Username
        password="hello@123",  # Password
        database="airportmanagement"  # Database name
    )

    # Check if the connection is successful
    if db_connection.is_connected():
        print("Database connection successful.")

    # Create a cursor to execute queries
    db_cursor = db_connection.cursor()

    # Query to get flight details along with airline name
    sql_query = """
    SELECT f.Flight_Number, f.Destination, f.Departure_Time, a.Airline_Name
    FROM Flights f
    INNER JOIN Airlines a ON f.Airline_Code = a.Airline_Code
    ORDER BY f.Departure_Time;
    """

    # Run the query
    db_cursor.execute(sql_query)

    # Get all records from the result
    flight_data = db_cursor.fetchall()

    # Define the file name for saving the report
    report_filename = "Flight_Report.txt"

    # Open a file to save the report
    with open(report_filename, "w") as report_file:
        # Write header
        report_file.write("Flight Report - Airport Management System\n")
        report_file.write("=" * 50 + "\n")
        report_file.write(f"{'Flight Number':<15}{'Destination':<20}{'Departure Time':<25}{'Airline Name'}\n")
        report_file.write("-" * 50 + "\n")

        # Print header on screen
        print("\nFlight Report:")
        print("=" * 50)
        print(f"{'Flight Number':<15}{'Destination':<20}{'Departure Time':<25}{'Airline Name'}")
        print("-" * 50)

        # Loop through the results and write them to the file and print on screen
        for record in flight_data:
            flight_no, destination, dep_time, airline = record
            row_output = f"{flight_no:<15}{destination:<20}{dep_time:<25}{airline}"
            print(row_output)  # Display on screen
            report_file.write(row_output + "\n")  # Save to file

    print(f"\nReport saved as '{report_filename}'.")

# Handle database errors
except mysql.connector.Error as error:
    print(f"Database error: {error}")

# Ensure database connection is closed properly
finally:
    if 'db_cursor' in locals():  # Check if cursor exists
        db_cursor.close()  # Close cursor
    if 'db_connection' in locals() and db_connection.is_connected():  # Check if connection exists and is open
        db_connection.close()  # Close connection
        print("Database connection closed.")
