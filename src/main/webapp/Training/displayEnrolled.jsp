<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Enrolled Employees</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            margin: 0;
            padding: 0;
        }

        .container {
            max-width: 800px;
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

        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }

        th, td {
            padding: 10px;
            border-bottom: 1px solid #ddd;
        }

        th {
            background-color: #007700;
            color: #fff;
            text-align: left;
        }

        tr:hover {
            background-color: #f2f2f2;
        }
    </style>
</head>
<body>
    <div class="container">
        <h2>Enrolled Employees</h2>
        <table>
            <thead>
                <tr>
                    <th>Employee ID</th>
                    <th>Name</th>
                    <!-- Add more columns if needed -->
                </tr>
            </thead>
            <tbody>
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

                    // Retrieve the eventId from the request
                    String eventName = request.getParameter("eventName");

                    // Fetch the eventId corresponding to the eventName
                    String queryEventId = "SELECT event_id FROM training_events WHERE event_name = ?";
                    pstmt = conn.prepareStatement(queryEventId);
                    pstmt.setString(1, eventName);
                    rs = pstmt.executeQuery();
                    int eventId = 0;
                    if (rs.next()) {
                        eventId = rs.getInt("event_id");
                    }

                    // Fetch employees enrolled for the event
                    String queryEnrolledEmployees = "SELECT e.employee_id, u.username FROM employee_enrollment e INNER JOIN employees u ON e.employee_id = u.id WHERE e.event_id = ?";
                    pstmt = conn.prepareStatement(queryEnrolledEmployees);
                    pstmt.setInt(1, eventId);
                    rs = pstmt.executeQuery();

                    // Display enrolled employees in table rows
                    while (rs.next()) {
                        int employeeId = rs.getInt("employee_id");
                        String employeeName = rs.getString("username");
                %>
                <tr>
                    <td><%= employeeId %></td>
                    <td><%= employeeName %></td>
                    <!-- Add more columns if needed -->
                </tr>
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
            </tbody>
        </table>
    </div>
</body>
</html>
