<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>View Performance</title>
    <style>
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }

        th, td {
            border: 1px solid #ddd;
            padding: 8px;
            text-align: left;
        }

        th {
            background-color: #f2f2f2;
        }
        
        .edit-btn {
    background-color: #007700;
    color: #fff;
    border: none;
    padding: 6px 12px;
    border-radius: 4px;
    cursor: pointer;
    transition: background-color 0.3s;
}

.edit-btn:hover {
    background-color: #005500;
}

        
    </style>
</head>
<body>
    <h1>Employee Performance Records</h1>
    <table>
        <thead>
            <tr>
                <th>Employee ID</th>
                <th>Quality of Work</th>
                <th>Punctuality</th>
                <th>Reliability</th>
                <th>Communication</th>
                <th>Performance</th>
            </tr>
        </thead>
        <tbody>
            <% 
                // Database connection parameters
                String DB_URL = "jdbc:mysql://localhost:3306/emp_management_sys?useSSL=false";
                String DB_USER = "root";
                String DB_PASSWORD = "Justin@040804";

                try {
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);

                    // Query to fetch employee performance records
                    String query = "SELECT * FROM employee_performance";
                    PreparedStatement pstmt = conn.prepareStatement(query);
                    ResultSet rs = pstmt.executeQuery();

                    // Iterate through the result set and display performance records
                    while (rs.next()) {
                        out.println("<tr>");
                        out.println("<td>" + rs.getInt("employee_id") + "</td>");
                        out.println("<td>" + rs.getInt("quality_of_work") + "</td>");
                        out.println("<td>" + rs.getInt("punctuality") + "</td>");
                        out.println("<td>" + rs.getInt("reliability") + "</td>");
                        out.println("<td>" + rs.getInt("communication") + "</td>");
                        out.println("<td>" + rs.getDouble("performance") + "</td>");
                        out.println("<td>");
                        out.println("<form action=\"edit_performance.jsp\" method=\"post\">");
                        out.println("<input type=\"hidden\" name=\"employeeId\" value=\"" + rs.getInt("employee_id") + "\">");
                        out.println("<input type=\"submit\" value=\"Edit\" class=\"edit-btn\">");
                        out.println("</form>");
                        out.println("</td>");
                        out.println("</tr>");
                    }

                    // Close resources
                    rs.close();
                    pstmt.close();
                    conn.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                    // Handle exceptions
                }
            %>
        </tbody>
    </table>
</body>
</html>
