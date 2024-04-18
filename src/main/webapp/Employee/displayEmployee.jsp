<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Employee List - HR Management System</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f0f0f0;
            margin: 0;
            padding: 20px;
        }
        
        .container {
            max-width: 2000px;
            margin: 20px auto;
            padding: 20px;
            background-color: #fff;
            border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
            text-align: center;
        }
        
        h1 {
            margin-bottom: 20px;
            color: #333;
        }
        
        table {
    		max-width: 100%;
    		width: 100%;
    		border-collapse: collapse;
    		margin-bottom: 20px;
    		border-radius: 8px;
    		overflow: hidden;
		}		

		th, td {
    		padding: 10px;
    		border: 1px solid #ddd;
    		text-align: centre;
		}

		th {
   		 	background-color: #4CAF50;
  	  	 	color: #fff;
		}

tr:nth-child(even) {
    background-color: #f2f2f2;
}

    </style>
</head>
<body>
    <div class="container">
        <h1>Employee List</h1>
        <table>
            <thead>
                <tr>
                    <th>Employee ID</th>
                    <th>Full Name</th>
                    <th>Date of Birth</th>
                    <th>Gender</th>
                    <th>Email</th>
                    <th>Department</th>
                    <th>Job Title</th>
                    <th>Salary</th>
                </tr>
            </thead>
            <tbody>
                <% 
                    try {
                        // Database connection parameters
                        String url = "jdbc:mysql://localhost:3306/employee";
                        String username = "root";
                        String password = "@VKcentury100";

                        // Database connection
                        Class.forName("com.mysql.cj.jdbc.Driver");
                        Connection conn = DriverManager.getConnection(url, username, password);

                        // SQL query to retrieve employee data
                        String sql = "SELECT * FROM employee";
                        PreparedStatement pstmt = conn.prepareStatement(sql);
                        ResultSet rs = pstmt.executeQuery();

                        // Iterate over the result set and display employee data in the table
                        while (rs.next()) {
                            out.println("<tr>");
                            out.println("<td>" + rs.getInt("EmployeeID") + "</td>");
                            out.println("<td>" + rs.getString("FullName") + "</td>");
                            out.println("<td>" + rs.getString("DateOfBirth") + "</td>");
                            out.println("<td>" + rs.getString("Gender") + "</td>");
                            out.println("<td>" + rs.getString("Email") + "</td>");
                            out.println("<td>" + rs.getString("Department") + "</td>");
                            out.println("<td>" + rs.getString("JobTitle") + "</td>");
                            out.println("<td>" + rs.getDouble("Salary") + "</td>");
                            out.println("</tr>");
                        }

                        // Close resources
                        rs.close();
                        pstmt.close();
                        conn.close();
                    } catch (Exception e) {
                        out.println("Error: " + e.getMessage());
                    }
                %>
            </tbody>
        </table>
    </div>
</body>
</html>