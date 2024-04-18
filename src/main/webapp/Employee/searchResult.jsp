<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Employee Details - HR Management System</title>
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
        
        .employee-info {
            text-align: left;
            margin-bottom: 20px;
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
            margin-right: 10px;
            display: inline-block;
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
        <h1>Employee Details</h1>
        <% 
            try {
            	
                String url = "jdbc:mysql://localhost:3306/employee";
                String username = "root";
                String password = "@VKcentury100";

                String fullName = request.getParameter("fullName");

                Class.forName("com.mysql.cj.jdbc.Driver");
                Connection conn = DriverManager.getConnection(url, username, password);

                String sql = "SELECT * FROM employee WHERE FullName = ?";
                PreparedStatement pstmt = conn.prepareStatement(sql);
                pstmt.setString(1, fullName);
                ResultSet rs = pstmt.executeQuery();

                if (rs.next()) {
                	
                    out.println("<div class='employee-info'>");
                    out.println("<p><strong>Employee ID:</strong> " + rs.getInt("EmployeeID") + "</p>");
                    out.println("<p><strong>Full Name:</strong> " + rs.getString("FullName") + "</p>");
                    out.println("<p><strong>Date of Birth:</strong> " + rs.getString("DateOfBirth") + "</p>");
                    out.println("<p><strong>Gender:</strong> " + rs.getString("Gender") + "</p>");
                    out.println("<p><strong>Email:</strong> " + rs.getString("Email") + "</p>");
                    out.println("<p><strong>Department:</strong> " + rs.getString("Department") + "</p>");
                    out.println("<p><strong>Job Title:</strong> " + rs.getString("JobTitle") + "</p>");
                    out.println("<p><strong>Salary:</strong> " + rs.getDouble("Salary") + "</p>");
                    out.println("</div>");
                    
                    out.println("<div class ='form-buttons'>");
                    out.println("<form action='editEmployee.jsp' method='GET'>");
                    out.println("<input type='hidden' name='employeeID' value='" + rs.getInt("EmployeeID") + "'>");
                    out.println("<button type='submit' class='button'>Edit Employee</button>");
                    out.println("</form>");
                    
                    out.println("<form action='deleteEmployee.jsp' method='POST'>");
                    out.println("<input type='hidden' name='employeeID' value='" + rs.getInt("EmployeeID") + "'>");
                    out.println("<button type='submit' class='button'>Delete Employee</button>");
                    out.println("</form>");
                    out.println("</div>");

                } else {
                	
                    out.println("<p>Employee not found.</p>");
                }

                // Close resources
                rs.close();
                pstmt.close();
                conn.close();
            } catch (Exception e) {
                out.println("Error: " + e.getMessage());
            }
        %>
    </div>
</body>
</html>