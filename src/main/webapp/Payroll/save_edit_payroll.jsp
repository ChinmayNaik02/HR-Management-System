<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    // Retrieve form data
    int employeeId = Integer.parseInt(request.getParameter("employeeId"));
    double baseSalary = Double.parseDouble(request.getParameter("baseSalary"));
    double overtimePay = Double.parseDouble(request.getParameter("overtimePay"));
    double bonus = Double.parseDouble(request.getParameter("bonus"));
    
    // Calculate total salary
    double totalSalary = baseSalary + overtimePay + bonus;

    // Database connection parameters
    String DB_URL = "jdbc:mysql://localhost:3306/emp_management_sys?useSSL=false";
    String DB_USER = "root";
    String DB_PASSWORD = "Justin@040804";

    try {
        // Create a database connection
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);

        // Update payroll information in the database
        String query = "UPDATE payroll SET base_salary = ?, overtime_pay = ?, bonus = ?, total_salary = ? WHERE employee_id = ?";
        PreparedStatement pstmt = conn.prepareStatement(query);
        pstmt.setDouble(1, baseSalary);
        pstmt.setDouble(2, overtimePay);
        pstmt.setDouble(3, bonus);
        pstmt.setDouble(4, totalSalary);
        pstmt.setInt(5, employeeId);
        pstmt.executeUpdate();

        // Close resources
        pstmt.close();
        conn.close();

        // Redirect to payroll.html after saving data
        response.sendRedirect("payroll.html");
    } catch (SQLException e) {
        e.printStackTrace();
        // Handle database connection or query errors
    }
%>
