<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Delete Employee - HR Management System</title>
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
        
        .message {
            color: red;
            font-size: 18px;
            text-align: center;
        }
        .button {
            padding: 10px 20px;
            background-color: #4CAF50;
            color: #fff;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 16px;
            margin-right: 10px;
            transition: background-color 0.3s;
        }

        .button:hover {
            background-color: #45a049;
        }
        
        .form-buttons{
            display: flex;     
        	flex-direction: row;
        }        
    </style>
</head>
<body>
    <div class="container">
        <% 
        try {
            // Database connection parameters
            String url = "jdbc:mysql://localhost:3306/employee";
            String username = "root";
            String password = "@VKcentury100";

            // Get the employee ID from the request parameter
            String idParam = request.getParameter("employeeID");
            int employeeID = Integer.parseInt(idParam);

            // Database connection
            Class.forName("com.mysql.jdbc.Driver");
            Connection conn = DriverManager.getConnection(url, username, password);

            // SQL query to delete the employee record
            String sql = "DELETE FROM employee WHERE EmployeeID = ?";
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, employeeID);

            // Execute the SQL query
            int rowsAffected = pstmt.executeUpdate();

            // Display message upon successful deletion
            if (rowsAffected > 0) {
                out.println("<p class='message'>Employee record deleted successfully.</p>");
            } else {
                out.println("<p class='message'>Failed to delete employee record.</p>");
            }

            // Close resources
            pstmt.close();
            conn.close();
        } catch (Exception e) {
            out.println("Error: " + e.getMessage());
        }
        %>
        <div class = "form-buttons">
        <form action="../login.html">
            <button type="submit" class="button">Back to Dashboard</button>
        </form>
        <form action="employee.html">
            <button type="submit" class="button">Back to Employee Management</button>
        </form>
        </div>
    </div>
</body>
</html>
