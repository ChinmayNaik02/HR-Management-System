<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.util.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Yearly Report</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f4f4f4;
        }
        .container {
            max-width: 600px;
            margin: 20px auto;
            padding: 20px;
            background-color: #fff;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
            border-radius: 8px;
        }
        h1 {
            text-align: center;
            margin-bottom: 20px;
        }
        .attendance-item {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 15px;
            padding: 15px;
            background-color: #f2f2f2;
            border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }
        .attribute {
            color: #555;
            font-weight: bold;
        }
        .value {
            color: #333;
        }
        .total-hours {
            background-color: #ffe8e8;
        }
        .late-arrivals, .early-arrivals {
            background-color: #fff8e8;
        }
        .overtime-hours {
            background-color: #e8f8ff;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>Yearly Attendance Report</h1>

        <%
            // Retrieve the year from the request parameter
            String yearParam = request.getParameter("year");
    		String employeeName = request.getParameter("employeeName");
    		PreparedStatement statement = null;
    		String sql = null;

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

                // Creating SQL query to retrieve attendance records for the specified year


                if (request.getParameter("employeeName") != null)
                {
                	sql = "SELECT clockInTime, clockOutTime FROM attendance WHERE employeeName = ? AND YEAR(date) = ?";
                	statement = connection.prepareStatement(sql);
                	statement.setString(1, request.getParameter("employeeName"));
                    statement.setString(2, yearParam);
                }
                else
                {
                	sql = "SELECT clockInTime, clockOutTime FROM attendance WHERE YEAR(date) = ?";
                	statement = connection.prepareStatement(sql);
                    statement.setString(1, yearParam);
                }


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
            double overtimeHours = totalWorkingHours - (8 * 260); // Assuming 8 hours per day, 260 working days in a year
            if (overtimeHours < 0) {
                overtimeHours = 0;
            }
        %>
        
        <%
        if (request.getParameter("employeeName") != null)
        {
        	%><div class="attendance-item">
    			<div class="attribute">Employee Name:</div>
    			<div class="value"><%=request.getParameter("employeeName")%></div>
			  </div>
			<%
        }
        %>
        <div class="attendance-item">
            <div class="attribute">Year:</div>
            <div class="value"><%= yearParam %></div>
        </div>
        <div class="attendance-item total-hours">
            <div class="attribute">Total Working Hours:</div>
            <div class="value"><%= totalWorkingHours %> hours</div>
        </div>
        <div class="attendance-item late-arrivals">
            <div class="attribute">Late Arrivals:</div>
            <div class="value"><%= lateArrivals %></div>
        </div>
        <div class="attendance-item early-arrivals">
            <div class="attribute">Early Arrivals:</div>
            <div class="value"><%= earlyDepartures %></div>
        </div>
        <div class="attendance-item overtime-hours">
            <div class="attribute">Overtime Hours:</div>
            <div class="value"><%= overtimeHours %> hours</div>
        </div>
    </div>
</body>
</html>