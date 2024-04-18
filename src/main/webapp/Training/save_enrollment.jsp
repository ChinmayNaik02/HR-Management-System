<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Enroll Employee</title>
</head>
<body>
    <% 
    // Get parameters from the request
    String employeeName = request.getParameter("employeeName");
    String eventId = request.getParameter("eventId");

    // Database connection parameters
    String DB_URL = "jdbc:mysql://localhost:3306/emp_management_sys?useSSL=false";
    String DB_USER = "root";
    String DB_PASSWORD = "Justin@040804";

    Connection conn = null;
    PreparedStatement pstmt = null;

    try {
        // Create a database connection
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);

        // Retrieve the employee_id based on the employee_name
        String query = "SELECT id FROM employees WHERE username = ?";
        pstmt = conn.prepareStatement(query);
        pstmt.setString(1, employeeName);
        ResultSet rs = pstmt.executeQuery();

        // Check if the employee exists
        if (rs.next()) {
            int employeeId = rs.getInt("id");

            // Insert a record into the employee_enrollment table
            query = "INSERT INTO employee_enrollment (employee_id, event_id) VALUES (?, ?)";
            pstmt = conn.prepareStatement(query);
            pstmt.setInt(1, employeeId);
            pstmt.setString(2, eventId);
            int rowsAffected = pstmt.executeUpdate();

            if (rowsAffected > 0) {
                response.sendRedirect("training.html");
                return;
            } else {
                // Enrollment failed
                out.println("<h2>Failed to enroll employee.</h2>");
            }
        } else {
            // Employee not found
            out.println("<h2>Employee not found.</h2>");
        }
    } catch (SQLException | ClassNotFoundException e) {
        e.printStackTrace();
        // Handle database connection or query errors
    } finally {
        // Close resources
        try {
            if (pstmt != null) pstmt.close();
            if (conn != null) conn.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
    %>
</body>
</html>
