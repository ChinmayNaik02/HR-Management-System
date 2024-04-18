<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.util.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Daily Report</title>
</head>
<body>
    <h1>Daily Report</h1>

    <%
        // Retrieve the date from the request parameter
        String dateParam = request.getParameter("date");

        // JDBC connection details
        String jdbcUrl = "jdbc:mysql://localhost:3306/employee";
        String username = "root";
        String password = "@VKcentury100";

        // Initialize variables for calculations
        int lateArrivals = 0;
        int earlyDepartures = 0;
        double totalWorkingHours = 0;

        try {
            // Establishing a connection to the database
            Class.forName("com.mysql.jdbc.Driver");
            Connection connection = DriverManager.getConnection(jdbcUrl, username, password);

            // Creating SQL query to retrieve attendance records for the specified date
            String sql = "SELECT clockInTime, clockOutTime FROM attendance WHERE date = ?";
            PreparedStatement statement = connection.prepareStatement(sql);
            statement.setString(1, dateParam);

            // Executing the SQL query
            ResultSet resultSet = statement.executeQuery();

            // Iterate through the resultSet to calculate total working hours, late arrivals, and early departures
            while (resultSet.next()) {
                // Retrieve clock in and clock out times from the resultSet
                Time clockInTime = resultSet.getTime("clockInTime");
                Time clockOutTime = resultSet.getTime("clockOutTime");

                // Calculate the duration between clock in and clock out times
                long durationMillis = clockOutTime.getTime() - clockInTime.getTime();

                // Convert duration to hours (assuming 1 hour = 3600000 milliseconds)
                double durationHours = durationMillis / 3600000.0;

                // Add the duration to total working hours
                totalWorkingHours += durationHours;

                // Check for late arrival (clock in after 9:00 AM)
                Calendar cal = Calendar.getInstance();
                cal.setTime(clockInTime);
                int hour = cal.get(Calendar.HOUR_OF_DAY);
                if (hour > 9) {
                    lateArrivals++;
                }

                // Check for early departure (clock out before 5:00 PM)
                cal.setTime(clockOutTime);
                hour = cal.get(Calendar.HOUR_OF_DAY);
                if (hour < 17) {
                    earlyDepartures++;
                }
            }

            // Closing JDBC objects
            resultSet.close();
            statement.close();
            connection.close();
        } catch (Exception e) {
            out.println("Error: " + e.getMessage());
        }

        // Calculate overtime hours (if totalWorkingHours exceeds 8 hours)
        double overtimeHours = totalWorkingHours - 8;

        // Display the report
        out.println("<p>Date: " + dateParam + "</p>");
        out.println("<p>Total Working Hours: " + totalWorkingHours + " hours</p>");
        out.println("<p>Late Arrivals: " + lateArrivals + "</p>");
        out.println("<p>Early Departures: " + earlyDepartures + "</p>");
        out.println("<p>Overtime Hours: " + overtimeHours + "</p>");
    %>
</body>
</html>
