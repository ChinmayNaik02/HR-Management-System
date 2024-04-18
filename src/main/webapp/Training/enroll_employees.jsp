<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>HR Enrollment</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            margin: 0;
            padding: 0;
        }

        .container {
            max-width: 500px;
            margin: 20px auto;
            background-color: #fff;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }

        h2 {
            color: #007700;
            margin-bottom: 20px;
            text-align: center;
        }

        label {
            display: block;
            margin-bottom: 10px;
            color: #333;
        }

        input[type="text"],
        select {
            width: 100%;
            padding: 10px;
            margin-bottom: 20px;
            border: 1px solid #ccc;
            border-radius: 4px;
            box-sizing: border-box;
        }

        input[type="submit"] {
            width: 100%;
            padding: 10px;
            background-color: #007700;
            color: #fff;
            border: none;
            border-radius: 4px;
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
        <h2>Training Enrollment</h2>
        <form action="save_enrollment.jsp" method="post">
            <label for="employeeName">Select Employee:</label>
            <select id="employeeName" name="employeeName" required>
                <option value="">Select an Employee</option>
                <% 
                // Database connection parameters
                String DB_URL = "jdbc:mysql://localhost:3306/emp_management_sys?useSSL=false";
                String DB_USER = "root";
                String DB_PASSWORD = "Justin@040804";

                Connection conn = null;
                PreparedStatement pstmt = null;
                ResultSet rs = null;

                try {
                    // Create a database connection
                    Class.forName("com.mysql.jdbc.Driver");
                    conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);

                    // Retrieve employee names from the database
                    String query = "SELECT username FROM employees";
                    pstmt = conn.prepareStatement(query);
                    rs = pstmt.executeQuery();

                    // Iterate through the employee names and populate the dropdown menu
                    while (rs.next()) {
                        String employeeName = rs.getString("username");
                %>
                <option value="<%=employeeName %>"><%=employeeName %></option>
                <% 
                    }
                } catch (SQLException | ClassNotFoundException e) {
                    e.printStackTrace();
                    // Handle database connection or query errors
                } finally {
                    // Close resources
                    try {
                        if (rs != null) rs.close();
                        if (pstmt != null) pstmt.close();
                        if (conn != null) conn.close();
                    } catch (SQLException e) {
                        e.printStackTrace();
                    }
                }
                %>
            </select>
            
            <label for="eventId">Select Event:</label>
            <select id="eventId" name="eventId" required>
                <option value="">Select an Event</option>
                <% 
                // Database connection parameters
                try {
                    // Create a database connection
                    Class.forName("com.mysql.jdbc.Driver");
                    conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);

                    // Retrieve available training events from the database
                    String query = "SELECT * FROM training_events WHERE event_date >= CURDATE()";
                    pstmt = conn.prepareStatement(query);
                    rs = pstmt.executeQuery();

                    // Iterate through the training events and populate the dropdown menu
                    while (rs.next()) {
                        String eventId = rs.getString("event_id");
                        String eventName = rs.getString("event_name");
                %>
                <option value="<%=eventId %>"><%=eventName %></option>
                <% 
                    }
                } catch (SQLException | ClassNotFoundException e) {
                    e.printStackTrace();
                    // Handle database connection or query errors
                } finally {
                    // Close resources
                    try {
                        if (rs != null) rs.close();
                        if (pstmt != null) pstmt.close();
                        if (conn != null) conn.close();
                    } catch (SQLException e) {
                        e.printStackTrace();
                    }
                }
                %>
            </select>
            
            <input type="submit" value="Enroll Employee">
        </form>
    </div>
</body>
</html>
