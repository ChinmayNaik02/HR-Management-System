<%@ page import="java.sql.*" %>
<%
    // Get the form data
    String username = request.getParameter("username");
    String password = request.getParameter("password");

    // Database connection details
    String dbUrl = "jdbc:mysql://localhost:3306/user";
    String dbUser = "root";
    String dbPassword = "@VKcentury100";

    try {
        // Load the database driver
        Class.forName("com.mysql.jdbc.Driver");

        // Create a database connection
        Connection conn = DriverManager.getConnection(dbUrl, dbUser, dbPassword);

        // Prepare the SQL statement
        String sql = "INSERT INTO users (username, password) VALUES (?, ?)";
        PreparedStatement statement = conn.prepareStatement(sql);
        statement.setString(1, username);
        statement.setString(2, password);

        // Execute the SQL statement
        int rowsInserted = statement.executeUpdate();
        if (rowsInserted > 0) {
            // User registered successfully
            response.sendRedirect("signUp.jsp?success=Registration Successful");
        } else {
            // Failed to register user
            response.sendRedirect("signUp.jsp?success=Registration Failed");
        }

        // Close the database resources
        statement.close();
        conn.close();
    } catch (Exception e) {
        // Handle any exceptions
        response.sendRedirect("signUp.jsp?success=Error: " + e.getMessage());
    }
%>