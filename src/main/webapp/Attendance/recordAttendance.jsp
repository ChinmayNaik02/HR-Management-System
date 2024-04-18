<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Record Attendance</title>
</head>
<body>
    <%
        // Retrieve form data
        String employeeName = request.getParameter("employeeName");
        String date = request.getParameter("date");
        String clockInTime = request.getParameter("clockInTime");
        String clockOutTime = request.getParameter("clockOutTime");

        // JDBC connection details
        String jdbcUrl = "jdbc:mysql://localhost:3306/employee";
        String username = "root";
        String password = "@VKcentury100"; // Change this to your database password

        try {
            // Establishing a connection to the database
            Class.forName("com.mysql.jdbc.Driver");
            Connection connection = DriverManager.getConnection(jdbcUrl, username, password);
            
            // Creating SQL query to insert attendance data into the table
            String sql = "INSERT INTO attendance (employeeName, date, clockInTime, clockOutTime) VALUES (?, ?, ?, ?)";
            PreparedStatement statement = connection.prepareStatement(sql);
            statement.setString(1, employeeName);
            statement.setString(2, date);
            statement.setString(3, clockInTime);
            statement.setString(4, clockOutTime);
            
            // Executing the SQL query
            int rowsAffected = statement.executeUpdate();
            
            // Checking if the data was inserted successfully
            if (rowsAffected > 0) {
    %>
                <p>Attendance recorded successfully.</p>
    <%
            } else {
    %>
                <p>Failed to record attendance.</p>
    <%
            }
            
            // Closing JDBC objects
            statement.close();
            connection.close();
        } catch (Exception e) {
            out.println("Error: " + e.getMessage());
        }
    %>
</body>
</html>