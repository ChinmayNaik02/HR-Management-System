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
    String DB_URL = "jdbc:mysql://localhost:3306/employee?useSSL=false";
    String DB_USER = "root";
    String DB_PASSWORD = "@VKcentury100";

    try {

        Class.forName("com.mysql.jdbc.Driver");
        Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);

        String query = "UPDATE payroll SET base_salary = ?, overtime_pay = ?, bonus = ?, total_salary = ? WHERE employee_id = ?";
        PreparedStatement pstmt = conn.prepareStatement(query);
        pstmt.setDouble(1, baseSalary);
        pstmt.setDouble(2, overtimePay);
        pstmt.setDouble(3, bonus);
        pstmt.setDouble(4, totalSalary);
        pstmt.setInt(5, employeeId);
        pstmt.executeUpdate();
        pstmt.close();

        Connection conn2 = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
        query = "UPDATE employee SET Salary = ? WHERE EmployeeID = ?";
        pstmt = conn2.prepareStatement(query);
        pstmt.setDouble(1, baseSalary);
        pstmt.setInt(2, employeeId);
        pstmt.executeUpdate();
        conn2.commit();
        pstmt.close();
        conn.close();
        conn2.close();
        
        response.sendRedirect("payroll.html");
    } catch (SQLException e) {
        e.printStackTrace();
    }
%>
