<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.io.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Add Leave Request</title>
</head>
<body>

<%
    String employeeName = request.getParameter("employee-name");
    String leaveType = request.getParameter("leave-type");
    String startDate = request.getParameter("start-date");
    String endDate = request.getParameter("end-date");
    String reason = request.getParameter("reason");

    String jdbcUrl = "jdbc:mysql://localhost:3306/employee";
    String username = "root";
    String password = "@VKcentury100";

    try {
        Class.forName("com.mysql.jdbc.Driver");
        Connection connection = DriverManager.getConnection(jdbcUrl, username, password);

        String sql = "INSERT INTO leave_request (employeeName, leaveType, startDate, endDate, reason) VALUES (?, ?, ?, ?, ?)";
        PreparedStatement statement = connection.prepareStatement(sql);
        statement.setString(1, employeeName);
        statement.setString(2, leaveType);
        statement.setString(3, startDate);
        statement.setString(4, endDate);
        statement.setString(5, reason);

        int rowsAffected = statement.executeUpdate();

        // Close JDBC objects
        statement.close();
        connection.close();

        // Check if the leave request was successfully added to the database
        if (rowsAffected > 0) {
                // Redirect to the HTML page with success message
                response.sendRedirect("addLeave.jsp?success=true");
            } else {
                // Redirect to the HTML page with error message
                response.sendRedirect("addLeave.jsp?error=true");
            }
    } catch (Exception e) {
        out.println("Error: " + e.getMessage());
    }
%>

</body>
</html>