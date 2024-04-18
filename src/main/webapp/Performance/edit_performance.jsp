<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    // Retrieve employee ID from the request parameter
    int employeeId = Integer.parseInt(request.getParameter("employeeId"));

    // Initialize variables to store existing performance data
    int qualityOfWork = -1, punctuality = -1, reliability = -1, communication = -1;
    
    // Database connection parameters
    String DB_URL = "jdbc:mysql://localhost:3306/emp_management_sys?useSSL=false";
    String DB_USER = "root";
    String DB_PASSWORD = "Justin@040804";

    try {
        // Create a database connection
        Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);

        // Query to fetch existing performance data for the employee
        String query = "SELECT * FROM employee_performance WHERE employee_id = ?";
        PreparedStatement pstmt = conn.prepareStatement(query);
        pstmt.setInt(1, employeeId);
        ResultSet rs = pstmt.executeQuery();

        // Retrieve existing performance data if available
        if (rs.next()) {
            qualityOfWork = rs.getInt("quality_of_work");
            punctuality = rs.getInt("punctuality");
            reliability = rs.getInt("reliability");
            communication = rs.getInt("communication");
        }

        // Close resources
        rs.close();
        pstmt.close();
        conn.close();
    } catch (SQLException e) {
        e.printStackTrace();
        // Handle database connection or query errors
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Edit Performance</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
        }

        .container {
            width: 400px;
            padding: 20px;
            background-color: #fff;
            border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
        }

        h1 {
            margin-top: 0;
            margin-bottom: 20px;
            text-align: center;
            color: #007700;
        }

        label {
            display: block;
            margin-bottom: 5px;
            font-weight: bold;
            color: #333;
        }

        input[type="number"],
        input[type="submit"] {
            width: 100%;
            padding: 10px;
            margin-top: 5px;
            margin-bottom: 15px;
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
        <h1>Edit Performance</h1>
        <form action="save_edited_performance.jsp" method="post">
            <input type="hidden" name="employeeId" value="<%= employeeId %>">
            <label for="qualityOfWork">Quality of Work:</label>
            <input type="number" id="qualityOfWork" name="qualityOfWork" min="1" max="10" value="<%= qualityOfWork %>" required><br>
            <label for="punctuality">Punctuality:</label>
            <input type="number" id="punctuality" name="punctuality" min="1" max="10" value="<%= punctuality %>" required><br>
            <label for="reliability">Reliability:</label>
            <input type="number" id="reliability" name="reliability" min="1" max="10" value="<%= reliability %>" required><br>
            <label for="communication">Communication:</label>
            <input type="number" id="communication" name="communication" min="1" max="10" value="<%= communication %>" required><br>
            <input type="submit" value="Save Changes">
        </form>
    </div>
</body>
</html>
