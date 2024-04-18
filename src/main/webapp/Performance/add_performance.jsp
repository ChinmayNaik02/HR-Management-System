<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    // Retrieve employee name from the form
    String employeeName = request.getParameter("employeeName");

    // Database connection parameters
    String DB_URL = "jdbc:mysql://localhost:3306/emp_management_sys?useSSL=false";
    String DB_USER = "root";
    String DB_PASSWORD = "Justin@040804";

    int employeeId = -1;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);

        // Search for employee ID using employee name
        String query = "SELECT id FROM employees WHERE username = ?";
        PreparedStatement pstmt = conn.prepareStatement(query);
        pstmt.setString(1, employeeName);
        ResultSet rs = pstmt.executeQuery();

        if (rs.next()) {
            // Employee found, get the employee ID
            employeeId = rs.getInt("id");
        }

        pstmt.close();
        conn.close();
    } catch (SQLException e) {
        e.printStackTrace();
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Add Performance</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f0f0f0;
            color: #000; /* Black text */
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }

        .container {
            max-width: 400px;
            padding: 20px;
            background-color: #fff;
            border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
            text-align: center;
        }

        h1 {
            color: #000; /* Black text */
        }

        form {
            margin-top: 20px;
        }

        label {
            display: block;
            margin-bottom: 5px;
            color: #000; /* Black text */
        }

        input[type="number"],
        input[type="submit"] {
            width: 100%;
            padding: 10px;
            margin-top: 5px;
            margin-bottom: 10px;
            border: 1px solid #ccc;
            border-radius: 4px;
            box-sizing: border-box;
        }

        input[type="submit"] {
            background-color: #007700;
            color: #fff;
            cursor: pointer;
            transition: background-color 0.3s;
        }

        input[type="submit"]:hover {
            background-color: #005500;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>Add Performance</h1>
        <form action="save_performance.jsp" method="post">
            <input type="hidden" name="employeeId" value="<%= employeeId %>">
            <label for="qualityOfWork">Quality of Work:</label>
            <input type="number" id="qualityOfWork" name="qualityOfWork" min="1" max="10" required><br>
            <label for="punctuality">Punctuality:</label>
            <input type="number" id="punctuality" name="punctuality" min="1" max="10" required><br>
            <label for="reliability">Reliability:</label>
            <input type="number" id="reliability" name="reliability" min="1" max="10" required><br>
            <label for="communication">Communication:</label>
            <input type="number" id="communication" name="communication" min="1" max="10" required><br>
            <input type="submit" value="Submit">
        </form>
    </div>
</body>
</html>
