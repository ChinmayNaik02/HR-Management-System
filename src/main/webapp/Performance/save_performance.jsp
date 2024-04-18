<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    // Retrieve form parameters
    int employeeId = Integer.parseInt(request.getParameter("employeeId"));
    int qualityOfWork = Integer.parseInt(request.getParameter("qualityOfWork"));
    int punctuality = Integer.parseInt(request.getParameter("punctuality"));
    int reliability = Integer.parseInt(request.getParameter("reliability"));
    int communication = Integer.parseInt(request.getParameter("communication"));
    double performance = (qualityOfWork + punctuality + reliability + communication) / 4.0;

    // Database connection parameters
    String DB_URL = "jdbc:mysql://localhost:3306/emp_management_sys?useSSL=false";
    String DB_USER = "root";
    String DB_PASSWORD = "Justin@040804";

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);

        // Insert performance details into the database
        String query = "INSERT INTO employee_performance (employee_id, quality_of_work, punctuality, reliability, communication, performance) VALUES (?, ?, ?, ?, ?, ?)";
        PreparedStatement pstmt = conn.prepareStatement(query);
        pstmt.setInt(1, employeeId);
        pstmt.setInt(2, qualityOfWork);
        pstmt.setInt(3, punctuality);
        pstmt.setInt(4, reliability);
        pstmt.setInt(5, communication);
        pstmt.setDouble(6, performance);
        pstmt.executeUpdate();

        pstmt.close();
        conn.close();

        // Redirect to Performance Management page to display performance details
        response.sendRedirect("performance.html");
    } catch (SQLException e) {
        e.printStackTrace();
        // Redirect back to Add Performance page with error message
        response.sendRedirect("error.jsp?message=Failed to save performance details. Please try again.");
    }
%>
