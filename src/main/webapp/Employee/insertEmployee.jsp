<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Insert Employee Data</title>
</head>
<body>
    <%
        // Database connection parameters
        String url = "jdbc:mysql://localhost:3306/employee";
        String username = "root";
        String password = "@VKcentury100";

        // Get form data
        String fullName = request.getParameter("fullName");
        String dateOfBirth = request.getParameter("dateOfBirth");
        String gender = request.getParameter("gender");
        String email = request.getParameter("email");
        String department = request.getParameter("department");
        String jobTitle = request.getParameter("jobTitle");
        String salary = request.getParameter("salary");

        // Database connection
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection(url, username, password);

            // SQL query to insert data into the database
            String sql = "INSERT INTO employee (FullName, DateOfBirth, Gender, Email, Department, JobTitle, Salary) "
                + "VALUES (?, ?, ?, ?, ?, ?, ?)";
            PreparedStatement pstmt = conn.prepareStatement(sql);

            // Set parameters for the PreparedStatement
            pstmt.setString(1, fullName);
            pstmt.setString(2, dateOfBirth);
            pstmt.setString(3, gender);
            pstmt.setString(4, email);
            pstmt.setString(5, department);
            pstmt.setString(6, jobTitle);
            pstmt.setString(7, salary);

            // Execute the query
            int rowsAffected = pstmt.executeUpdate();

            // Close resources
            pstmt.close();
            conn.close();

            // Check if data was successfully inserted
            if (rowsAffected > 0) {
                // Redirect to the HTML page with success message
                response.sendRedirect("addEmployee.jsp?success=true");
            } else {
                // Redirect to the HTML page with error message
                response.sendRedirect("addEmployee.jsp?error=true");
            }
        } catch (Exception e) {
            out.println("Error: " + e.getMessage());
        }
    %>
</body>
</html>