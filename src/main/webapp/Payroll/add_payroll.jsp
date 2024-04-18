<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Add Payroll Information</title>
    <style>
        body {
    font-family: Arial, sans-serif;
    background-color: #f4f4f4;
    margin: 0;
    padding: 0;
    display: flex;
    justify-content: center;
    align-items: center;
    height: 100vh;
}

.container {
    text-align: center;
    padding: 20px;
    border: 2px solid #007700;
    border-radius: 8px;
    background-color: #fff;
}

.form-group {
    margin-bottom: 20px;
    text-align: left;
}

label {
    display: block;
    font-weight: bold;
    margin-bottom: 5px;
}

input[type="number"] {
    width: 100%;
    padding: 10px;
    border: 1px solid #ccc;
    border-radius: 4px;
    box-sizing: border-box;
}

input[type="submit"] {
    background-color: #007700;
    color: #fff;
    border: none;
    border-radius: 4px;
    padding: 10px 20px;
    cursor: pointer;
    font-size: 16px;
}

input[type="submit"]:hover {
    background-color: #005500;
}

    </style>
</head>
<body>
    <div class="container">
        <h2>Add Payroll Information</h2>
        <%
            // Database connection parameters
            String DB_URL = "jdbc:mysql://localhost:3306/emp_management_sys?useSSL=false";
            String DB_USER = "root";
            String DB_PASSWORD = "Justin@040804";

            // Initialize variable
            int employeeId = -1;

            try {
                // Create a database connection
                Class.forName("com.mysql.cj.jdbc.Driver");
                Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);

                // Query to retrieve employee ID based on name
                String query = "SELECT id FROM employees WHERE username = ?";
                PreparedStatement pstmt = conn.prepareStatement(query);
                pstmt.setString(1, request.getParameter("employeeName"));
                ResultSet rs = pstmt.executeQuery();

                // Retrieve employee ID if found
                if (rs.next()) {
                    employeeId = rs.getInt("id");
                }

                // Close resources
                rs.close();
                pstmt.close();
                conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
                // Handle database connection or query errors
            }
        %>
        <form action="save_payroll.jsp" method="post">
            <input type="hidden" name="employeeId" value="<%= employeeId %>">
            <div class="form-group">
                <label for="baseSalary">Base Salary:</label>
                <input type="number" id="baseSalary" name="baseSalary" required>
            </div>
            <div class="form-group">
                <label for="overtimePay">Overtime Pay:</label>
                <input type="number" id="overtimePay" name="overtimePay" required>
            </div>
            <div class="form-group">
                <label for="bonus">Bonus:</label>
                <input type="number" id="bonus" name="bonus" required>
            </div>
            <input type="submit" value="Submit">
        </form>
    </div>
</body>
</html>
