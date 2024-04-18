<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>View/Edit Training Events</title>
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

        .button {
            background-color: #007700;
            color: white;
            padding: 6px 10px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            text-align: center;
            text-decoration: none;
        }

        .button:hover {
            background-color: #005500;
        }
    </style>
</head>
<body>
    <div class="container">
        <h2>View/Edit Training Events</h2>
        <table>
            <thead>
                <tr>
                    <th>Event Id</th>
                    <th>Event Name</th>
                    <th>Event Date</th>
                    <th>Event Description</th>
                    <th>Actions</th>
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

                    // Retrieve event data from the database
                    String query = "SELECT * FROM training_events";
                    pstmt = conn.prepareStatement(query);
                    rs = pstmt.executeQuery();

                    // Iterate through the event data and display it in the table
                    while (rs.next()) {
                        Integer eventId = rs.getInt("event_id");
                        String eventName = rs.getString("event_name");
                        String eventDate = rs.getString("event_date");
                        String eventDescription = rs.getString("event_description");
                %>
                <tr>
                    <td><%=eventId %></td>
                    <td><%=eventName %></td>
                    <td><%=eventDate %></td>
                    <td><%=eventDescription %></td>
                    <td>
                        <a href="displayEnrolled.jsp?eventName=<%=eventName %>" class="button">View Enrolled</a>
                    </td>
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
