<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    // Retrieve form data
    int employeeId = Integer.parseInt(request.getParameter("employeeId"));
    int qualityOfWork = Integer.parseInt(request.getParameter("qualityOfWork"));
    int punctuality = Integer.parseInt(request.getParameter("punctuality"));
    int reliability = Integer.parseInt(request.getParameter("reliability"));
    int communication = Integer.parseInt(request.getParameter("communication"));

    // Database connection parameters
    String DB_URL = "jdbc:mysql://localhost:3306/emp_management_sys?useSSL=false";
    String DB_USER = "root";
    String DB_PASSWORD = "Justin@040804";

    try {
        // Create a database connection
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);

        // Update employee performance data in the database
        String query = "UPDATE employee_performance SET quality_of_work=?, punctuality=?, reliability=?, communication=? WHERE employee_id=?";
        PreparedStatement pstmt = conn.prepareStatement(query);
        pstmt.setInt(1, qualityOfWork);
        pstmt.setInt(2, punctuality);
        pstmt.setInt(3, reliability);
        pstmt.setInt(4, communication);
        pstmt.setInt(5, employeeId);
        int rowsAffected = pstmt.executeUpdate();

        // Close resources
        pstmt.close();
        conn.close();

        // Redirect to performance.html
        response.sendRedirect("performance.html");
    } catch (SQLException e) {
        e.printStackTrace();
        // Handle database connection or query errors
    }
%>
