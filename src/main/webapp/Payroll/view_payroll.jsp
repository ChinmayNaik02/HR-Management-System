<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>View/Edit Payroll</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: center;
            /*align-items: center;*/
            min-height: 100vh;
        }

        .container {
            width: 80%;
            background-color: #fff;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }

        h2 {
            text-align: center;
            margin-bottom: 20px;
        }

        table {
            width: 100%;
            border-collapse: collapse;
        }

        th, td {
            padding: 10px;
            border-bottom: 1px solid #ddd;
            text-align: left;
        }

        th {
            background-color: #f2f2f2;
        }

        td {
            background-color: #fff;
        }

        .button {
            display: inline-block;
            padding: 8px 16px;
            background-color: #007700;
            color: #fff;
            border: none;
            border-radius: 4px;
            text-decoration: none;
            font-size: 14px;
            cursor: pointer;
            transition: background-color 0.3s;
        }

        .button:hover {
            background-color: #005500;
        }
    </style>
</head>
<body>
    <div class="container">
        <h2>Payroll Details</h2>
        <table>
            <thead>
                <tr>
                    <th>Employee ID</th>
                    <th>Base Salary</th>
                    <th>Overtime Pay</th>
                    <th>Bonus</th>
                    <th>Total Salary</th>
                    <th>Edit</th>
                </tr>
            </thead>
            <tbody>
                <% 
                    // Database connection parameters
                    String DB_URL = "jdbc:mysql://localhost:3306/emp_management_sys?useSSL=false";
                    String DB_USER = "root";
                    String DB_PASSWORD = "Justin@040804";

                    try {
                        // Create a database connection
                        Class.forName("com.mysql.cj.jdbc.Driver");
                        Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);

                        // Query to retrieve payroll details
                        String query = "SELECT * FROM payroll";
                        PreparedStatement pstmt = conn.prepareStatement(query);
                        ResultSet rs = pstmt.executeQuery();

                        // Loop through each payroll record and display in table rows
                        while (rs.next()) {
                            int employeeId = rs.getInt("employee_id");
                            double baseSalary = rs.getDouble("base_salary");
                            double overtimePay = rs.getDouble("overtime_pay");
                            double bonus = rs.getDouble("bonus");
                            double totalSalary = rs.getDouble("total_salary");
                %>
                            <tr>
                                <td><%= employeeId %></td>
                                <td><%= baseSalary %></td>
                                <td><%= overtimePay %></td>
                                <td><%= bonus %></td>
                                <td><%= totalSalary %></td>
                                <td><a href="edit_payroll.jsp?employeeId=<%= employeeId %>" class="button">Edit</a></td>
                            </tr>
                <% 
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
            </tbody>
        </table>
    </div>
</body>
</html>
