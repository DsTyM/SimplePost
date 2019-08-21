<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.sql.Connection" %>
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
        Class.forName("com.mysql.cj.jdbc.Driver");
        String dbUrl = "jdbc:mysql://localhost:3306/simplepostdb?useUnicode=true&useJDBCCompliantTimezoneShift=true" +
                "&useLegacyDatetimeCode=false&serverTimezone=UTC&allowPublicKeyRetrieval=true&useSSL=false";
        String dbUsername = "root";
        String dbPassword = "7896";
        Connection conn = DriverManager.getConnection(dbUrl, dbUsername, dbPassword);

        Statement st = conn.createStatement();

        ResultSet rs = st.executeQuery("select * from users where username = '" + username
                + "' AND password = '" + password + "'");

        // αν εχει δωσει σωστα στοιχεια..
        if (rs.next()) {
            session.setAttribute("username", username);
            System.out.println("Someone Logged In");
            st.close();
            response.sendRedirect("index.jsp");
        } else {
            System.out.println("Αποτυχής Σύνδεση.");
            st.close();
            session.setAttribute("isLogged", "no");
            response.sendRedirect("login.jsp");
        }
    } catch (Exception e) {
        System.out.println("\n============== Error starts here. ==============");
        e.printStackTrace();
        System.out.println("============== Error ends here. ==============\n");
    }
%>
</body>
</html>
