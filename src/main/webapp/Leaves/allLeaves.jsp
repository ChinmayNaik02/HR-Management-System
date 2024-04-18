<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.util.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>All Leave Records</title>
    <style>
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
<h1>All Leave Records</h1>

<table>
    <tr>
    	<th>Employee ID</th>
        <th>Employee Name</th>
        <th>Leave Type</th>
        <th>Start Date</th>
        <th>End Date</th>
        <th>Reason</th>
    </tr>

<%
    // JDBC connection details
    String jdbcUrl = "jdbc:mysql://localhost:3306/employee";
    String username = "root";
    String password = "@VKcentury100";

    try {
        // Establish connection to the database
        Class.forName("com.mysql.jdbc.Driver");
        Connection connection = DriverManager.getConnection(jdbcUrl, username, password);

        // Create SQL query to retrieve future leave records from the database
        String sql = "SELECT e.EmployeeID, l.employeeName, l.leaveType, l.startDate, l.endDate, l.reason FROM leave_request l INNER JOIN employee e ON l.employeeName = e.FullName";
        PreparedStatement statement = connection.prepareStatement(sql);

        // Execute the query
        ResultSet resultSet = statement.executeQuery();

        // Iterate through the result set and display leave records in the table
        while (resultSet.next()) {
            out.println("<tr>");
            out.println("<td>" + resultSet.getString("EmployeeID") + "</td>");
            out.println("<td>" + resultSet.getString("employeeName") + "</td>");
            out.println("<td>" + resultSet.getString("leaveType") + "</td>");
            out.println("<td>" + resultSet.getString("startDate") + "</td>");
            out.println("<td>" + resultSet.getString("endDate") + "</td>");
            out.println("<td>" + resultSet.getString("reason") + "</td>");
            out.println("</tr>");
        }

        // Close JDBC objects
        resultSet.close();
        statement.close();
        connection.close();
    } catch (Exception e) {
        out.println("Error: " + e.getMessage());
    }
%>

</table>
</div>
</body>
</html>