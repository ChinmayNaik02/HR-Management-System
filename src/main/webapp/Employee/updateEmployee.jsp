<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Update Employee - HR Management System</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f0f0f0;
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }
        
        .container {
            max-width: 600px;
            padding: 20px;
            background-color: #fff;
            border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
            text-align: center;
        }
        
        h1 {
            margin-bottom: 20px;
        }
        
        .message {
            margin-bottom: 20px;
            color: #008000;
        }
        
        .button {
            padding: 10px 20px;
            background-color: #4CAF50;
            color: #fff;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 16px;
            transition: background-color 0.3s;
            text-decoration: none;
            display: inline-block;     
        }
        
        .button:hover {
            background-color: #45a049;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>Update Employee</h1>
        <% 
            try {
                // Database connection parameters
                String url = "jdbc:mysql://localhost:3306/employee";
                String username = "root";
                String password = "@VKcentury100";

                // Get parameters from the request
                String fullName = request.getParameter("fullName");
                String dateOfBirth = request.getParameter("dateOfBirth");
                String gender = request.getParameter("gender");
                String email = request.getParameter("email");
                String department = request.getParameter("department");
                String jobTitle = request.getParameter("jobTitle");
                double salary = Double.parseDouble(request.getParameter("salary"));
                int employeeID = Integer.parseInt(request.getParameter("id"));

                // Database connection
                Class.forName("com.mysql.cj.jdbc.Driver");
                Connection conn = DriverManager.getConnection(url, username, password);

                // SQL query to update employee record
                String sql = "UPDATE employee SET FullName=?, DateOfBirth=?, Gender=?, Email=?, Department=?, JobTitle=?, Salary=? WHERE EmployeeID=?";
                PreparedStatement pstmt = conn.prepareStatement(sql);
                pstmt.setString(1, fullName);
                pstmt.setString(2, dateOfBirth);
                pstmt.setString(3, gender);
                pstmt.setString(4, email);
                pstmt.setString(5, department);
                pstmt.setString(6, jobTitle);
                pstmt.setDouble(7, salary);
                pstmt.setInt(8, employeeID);
                
                // Execute the update query
                int rowsUpdated = pstmt.executeUpdate();

                // Display success message if update is successful
                if (rowsUpdated > 0) {
                    out.println("<p class='message'>Employee details updated successfully!</p>");
                } else {
                    out.println("<p class='message'>Failed to update employee details.</p>");
                }

                // Close resources
                pstmt.close();
                conn.close();
            } catch (Exception e) {
                out.println("Error: " + e.getMessage());
            }
        %>
        <a href="employee.html" class = "button">Back to Employee Management</a>
        <a href="../login.html" class="button">Go to Dashboard</a>
    </div>
</body>
</html>
