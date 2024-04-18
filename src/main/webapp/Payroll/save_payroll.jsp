<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    // Retrieve form data
    int employeeId = Integer.parseInt(request.getParameter("employeeId"));
    int baseSalary = Integer.parseInt(request.getParameter("baseSalary"));
    int overtimePay = Integer.parseInt(request.getParameter("overtimePay"));
    int bonus = Integer.parseInt(request.getParameter("bonus"));
    
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

        // Insert payroll information into the database
        String query = "INSERT INTO payroll (employee_id, base_salary, overtime_pay, bonus, total_salary) VALUES (?, ?, ?, ?, ?)";
        PreparedStatement pstmt = conn.prepareStatement(query);
        pstmt.setInt(1, employeeId);
        pstmt.setInt(2, baseSalary);
        pstmt.setInt(3, overtimePay);
        pstmt.setInt(4, bonus);
        pstmt.setDouble(5, totalSalary);
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
