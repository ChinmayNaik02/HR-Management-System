<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Login</title>
</head>
<body>

<%
    String username = request.getParameter("username");
    String password = request.getParameter("password");

    // Database credentials
    String JDBC_DRIVER = "com.mysql.jdbc.Driver";
    String DB_URL = "jdbc:mysql://localhost:3306/user";
    String DB_USER = "root";
    String DB_PASSWORD = "@VKcentury100";

    Connection conn = null;
    Statement stmt = null;

    try {
        // Register JDBC driver
        Class.forName(JDBC_DRIVER);

        // Open a connection
        conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);

        // Execute SQL query
        stmt = conn.createStatement();
        String sql = "SELECT * FROM users WHERE username='" + username + "' AND password='" + password + "'";
        ResultSet rs = stmt.executeQuery(sql);

        // Check if user exists
        if (rs.next()) {
            // User exists, login successful
            // Redirect user to the dashboard HTML page
            response.sendRedirect("login.html");
        } else {
            // User does not exist or incorrect credentials
            // Redirect user back to login page with error message
            response.sendRedirect("index.jsp?error=true");
        }

        // Clean-up environment
        rs.close();
        stmt.close();
        conn.close();
    } catch (SQLException se) {
        // Handle errors for JDBC
        se.printStackTrace();
    } catch (Exception e) {
        // Handle errors for Class.forName
        e.printStackTrace();
    } finally {
        // Close resources
        try {
            if (stmt != null)
                stmt.close();
        } catch (SQLException se2) {
        } // nothing we can do
        try {
            if (conn != null)
                conn.close();
        } catch (SQLException se) {
            se.printStackTrace();
        } // end finally try
    } // end try
%>

</body>
</html>