<%@ page contentType="text/html;charset=UTF-8" %>
<%@page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.Statement" %>

<html>
<head>
    <title>Logged In</title>
</head>
<body>
<%
    request.setCharacterEncoding("UTF-8");

    String username = request.getParameter("username");
    String password = request.getParameter("password");

    try {
        Class.forName("com.mysql.jdbc.Driver");
        Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/SimplePostDB",
                "root", "");

        Statement st = conn.createStatement();

        ResultSet rs = st.executeQuery("select * from Users where username = '" + username
                + "' AND password = '" + password + "'");

        // αν εχει δωσει σωστα στοιχεια..
        if (rs.next()) {
            session.setAttribute("username", username);
            System.out.println("Επιτυχής Σύνδεση.");
            st.close();
            response.sendRedirect("index.jsp");
        } else {
            System.out.println("Αποτυχής Σύνδεση.");
            st.close();
            session.setAttribute("isLogged", "no");
            response.sendRedirect("Login.jsp");
        }
    } catch (Exception e) {
        System.out.println(e.getMessage());
    }
%>
</body>
</html>
