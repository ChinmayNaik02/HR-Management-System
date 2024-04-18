<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    // Retrieve form data
    String eventName = request.getParameter("eventName");
    String eventDate = request.getParameter("eventDate");
    String eventDescription = request.getParameter("eventDescription");

    // Database connection parameters
    String DB_URL = "jdbc:mysql://localhost:3306/emp_management_sys?useSSL=false";
    String DB_USER = "root";
    String DB_PASSWORD = "Justin@040804";

    try {
        // Create a database connection
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);

        // Insert event details into the database
        String query = "INSERT INTO training_events (event_name, event_date, event_description) VALUES (?, ?, ?)";
        PreparedStatement pstmt = conn.prepareStatement(query);
        pstmt.setString(1, eventName);
        pstmt.setString(2, eventDate);
        pstmt.setString(3, eventDescription);
        pstmt.executeUpdate();

        // Close resources
        pstmt.close();
        conn.close();

        // Redirect to training.html after saving event
        response.sendRedirect("training.html");
    } catch (SQLException e) {
        e.printStackTrace();
        // Handle database connection or query errors
    }
%>
