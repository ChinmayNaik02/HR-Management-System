<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.util.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Monthly Report</title>
    <style>
    	body {
    font-family: Arial, sans-serif;
    background-color: #f0f0f0;
    margin: 0;
    padding: 0;
}

.container {
    max-width: 800px;
    margin: 20px auto;
    padding: 20px;
    background-color: #fff;
    border-radius: 8px;
    box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
}

h1 {
    text-align: center;
    margin-top: 20px;
    color: #333;
}

.report {
    margin-top: 20px;
    padding: 20px;
    border: 1px solid #ddd;
    border-radius: 8px;
    background-color: #fff;
    box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
}

.report p {
    text-align: center;
    font-size: 16px;
    margin: 10px 0;
}

.report p.title {
    font-size: 20px;
    font-weight: bold;
    color: #333;
}

.report p.label {
    font-weight: bold;
    color: #555;
}

.report p.value {
    color: #777;
}
    	
    </style>
</head>
<body>
    <div class="container">
        <h1>Monthly Report</h1>

        <div class="report">
            <p class="title">Monthly Report - <%= request.getParameter("month") %></p>

            <%
                // Retrieve the month and year from the request parameter
                String monthYear = request.getParameter("month");

                // JDBC connection details
                String jdbcUrl = "jdbc:mysql://localhost:3306/employee";
                String username = "root";
                String password = "@VKcentury100";

                // Initialize total working hours
                int lateArrivals = 0;
                int earlyDepartures = 0;
                double totalWorkingHours = 0;

                try {
                    // Establishing a connection to the database
                    Class.forName("com.mysql.jdbc.Driver");
                    Connection connection = DriverManager.getConnection(jdbcUrl, username, password);

                    // Creating SQL query to retrieve attendance records for the specified month
                    String sql = "SELECT clockInTime, clockOutTime FROM attendance WHERE MONTH(date) = ? AND YEAR(date) = ?";
                    PreparedStatement statement = connection.prepareStatement(sql);

                    // Extract month and year from the input (assuming the input format is "YYYY-MM")
                    String[] parts = monthYear.split("-");
                    int month = Integer.parseInt(parts[1]);
                    int year = Integer.parseInt(parts[0]);

                    // Set the month and year parameters
                    statement.setInt(1, month);
                    statement.setInt(2, year);

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

                // Calculate overtime hours
                double overtimeHours = totalWorkingHours - 8;
                if (overtimeHours < 0) {
                    overtimeHours = 0;
                }

                // Display the report
                out.println("<p class='label'>Total Working Hours:</p>");
                out.println("<p class='value'>" + totalWorkingHours + " hours</p>");
                out.println("<p class='label'>Late Arrivals:</p>");
                out.println("<p class='value'>" + lateArrivals + "</p>");
                out.println("<p class='label'>Early Departures:</p>");
                out.println("<p class='value'>" + earlyDepartures + "</p>");
                out.println("<p class='label'>Overtime Hours:</p>");
                out.println("<p class='value'>" + overtimeHours + "</p>");
            %>
        </div>
    </div>
</body>
</html>
