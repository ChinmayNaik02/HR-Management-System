<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Edit Payroll</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
        }

        .container {
            width: 50%;
            background-color: #fff;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }

        h2 {
            text-align: center;
            margin-bottom: 20px;
        }

        .form-group {
            margin-bottom: 20px;
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
        <h2>Edit Payroll</h2>
        <form action="save_edit_payroll.jsp" method="post">
            <div class="form-group">
                <label for="baseSalary">Base Salary:</label>
                <input type="number" id="baseSalary" name="baseSalary" value="<%= request.getParameter("baseSalary") %>" required>
            </div>
            <div class="form-group">
                <label for="overtimePay">Overtime Pay:</label>
                <input type="number" id="overtimePay" name="overtimePay" value="<%= request.getParameter("overtimePay") %>" required>
            </div>
            <div class="form-group">
                <label for="bonus">Bonus:</label>
                <input type="number" id="bonus" name="bonus" value="<%= request.getParameter("bonus") %>" required>
            </div>
            <input type="hidden" name="employeeId" value="<%= request.getParameter("employeeId") %>">
            <input type="submit" value="Save Changes" class="button">
        </form>
    </div>
</body>
</html>
