<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Edit Employee - HR Management System</title>
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
        
        .form-group {
            margin-bottom: 20px;
        }
        
        input[type="text"], input[type="date"], select {
            width: 100%;
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 4px;
            box-sizing: border-box;
            font-size: 16px;
        }
        
        .button-container {
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
            transition: background-color 0.3s;
        }
        
        .button:hover {
            background-color: #45a049;
        }
    </style>
</head>
<body>
    <%
        // Retrieve book ID from query parameter
        String id = request.getParameter("employeeID");
        int employeeID = Integer.parseInt(id);
        
        // JDBC connection details
        String jdbcUrl = "jdbc:mysql://localhost:3306/employee";
        String username = "root";
        String password = "@VKcentury100";
        
        try {
            // Establishing a connection to the database
            Class.forName("com.mysql.jdbc.Driver");
            Connection connection = DriverManager.getConnection(jdbcUrl, username, password);
            
            // Creating SQL query to retrieve book record by ID
            String sql = "SELECT * FROM employee WHERE EmployeeID = ?";
            PreparedStatement statement = connection.prepareStatement(sql);
            statement.setInt(1, employeeID);
            
            // Executing the SQL query
            ResultSet resultSet = statement.executeQuery();
            
            // Displaying the book record form for editing
            if (resultSet.next()) {
    %>
    
    <div class="container">
        <h1>Edit Employee Details</h1>
        <form action="updateEmployee.jsp" method="POST">
        	<input type="hidden" name="id" value="<%= resultSet.getInt("EmployeeID") %>">
            <div class="form-group">
                <label for="fullName">Full Name:</label>
                <input type="text" id="fullName" name="fullName" value="<%= resultSet.getString("FullName") %>">
            </div>
            <div class="form-group">
                <label for="dateOfBirth">Date of Birth:</label>
                <input type="date" id="dateOfBirth" name="dateOfBirth" value="<%= resultSet.getString("DateOfBirth") %>">
            </div>
            <div class="form-group">
                <label for="gender">Gender:</label>
                <select id="gender" name="gender">
                    <option value="Male">Male</option>
                    <option value="Female">Female</option>
                    <option value="Other">Other</option>
                </select>
            </div>
            <div class="form-group">
                <label for="email">Email:</label>
                <input type="text" id="email" name="email" value="<%= resultSet.getString("Email") %>">
            </div>
            <div class="form-group">
                <label for="department">Department:</label>
                <input type="text" id="department" name="department" value="<%= resultSet.getString("Department") %>">
            </div>
            <div class="form-group">
                <label for="jobTitle">Job Title:</label>
                <input type="text" id="jobTitle" name="jobTitle" value="<%= resultSet.getString("JobTitle") %>">
            </div>
            <div class="form-group">
                <label for="salary">Salary:</label>
                <input type="text" id="salary" name="salary" value="<%= resultSet.getDouble("Salary") %>">
            </div>
            <div class="button-container">
                <button type="submit" class="button">Save Changes</button>
            </div>
        </form>
        <%
            } else {
                out.println("Employee record not found.");
            }
            
            // Closing JDBC objects
            resultSet.close();
            statement.close();
            connection.close();
        } catch (Exception e) {
            out.println("Error: " + e.getMessage());
        }
    %>
    </div>
</body>
</html>