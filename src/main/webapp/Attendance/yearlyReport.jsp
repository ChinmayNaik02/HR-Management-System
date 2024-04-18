<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.util.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Yearly Report</title>
</head>
<body>
    <h1>Yearly Report</h1>

    <%
        // Retrieve the year from the request parameter
        String year = request.getParameter("year");

        // JDBC connection details
        String jdbcUrl = "jdbc:mysql://localhost:3306/employee";
        String username = "root";
        String password = "@VKcentury100";

        // Initialize total working hours
        double totalWorkingHours = 0;

        try {
            // Establishing a connection to the database
            Class.forName("com.mysql.jdbc.Driver");
            Connection connection = DriverManager.getConnection(jdbcUrl, username, password);

            // Creating SQL query to retrieve attendance records for the specified year
            String sql = "SELECT clockInTime, clockOutTime FROM attendance WHERE YEAR(date) = ?";
            PreparedStatement statement = connection.prepareStatement(sql);
            statement.setString(1, year);

            // Executing the SQL query
            ResultSet resultSet = statement.executeQuery();

            // Iterate through the resultSet to calculate total working hours
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
            }

            // Closing JDBC objects
            resultSet.close();
            statement.close();
            connection.close();
        } catch (Exception e) {
            out.println("Error: " + e.getMessage());
        }

        // Display the total working hours for the year
        out.println("<p>Total Working Hours for " + year + ": " + totalWorkingHours + " hours</p>");
    %>
</body>
</html>
