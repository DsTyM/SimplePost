<%@ page contentType="text/html;charset=UTF-8" %>
<%@page import="com.mysql.cj.util.StringUtils" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.Statement" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Ανακοινώσεις</title>
    <link rel="stylesheet" type="text/css" href="css/main-style.css"/>

    <style type="text/css">
        button {
            padding: 0.25em 1em;
            margin: 0.25em;
        }

        form {
            display: inline-block;
        }
    </style>
</head>
<body>

<jsp:include page="header-bar.jsp"/>

<%
    session = request.getSession(true);

    String logout = request.getParameter("logout");

    if (logout != null && !logout.equals("")) {
        session.invalidate();

        session = request.getSession(true);
        response.sendRedirect("index.jsp");
    }

    if (session.getAttribute("username") == null) {
%>

<br><br><br><br>

<h1 style="text-align: center; margin: auto; color: #218527;">Ανακοινώσεις</h1>
<br>

<%
} else {
%>
<br><br>
<div class="newbox">
    <a href="new-announcement.jsp">Νέα Ανακοίνωση</a>
</div>

<br><br>

<h1 style="text-align: center; margin: auto; color: #218527;">Ανακοινώσεις (Admin Mode)</h1>
<br>

<%
    }
%>

<ul style="width: 50%; margin: auto; background-color: #e0e0e0;">
    <br>
    <%
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            String dbUrl = "jdbc:mysql://localhost:3306/simplepostdb?useUnicode=true&useJDBCCompliantTimezoneShift=true" +
                    "&useLegacyDatetimeCode=false&serverTimezone=UTC&allowPublicKeyRetrieval=true&useSSL=false";
            String dbUsername = "root";
            String dbPassword = "7896";
            Connection conn = DriverManager.getConnection(dbUrl, dbUsername, dbPassword);

            Statement st = conn.createStatement();

            ResultSet rs = st.executeQuery("SELECT * FROM announcements ORDER BY date DESC");

            while (rs.next()) {
                out.print("<li><h3>" + rs.getString(3) + "</h3><p>" + rs.getString(4) +
                        "</p><p style='font-weight: bold;'>" + rs.getString(2) +
                        ", " + rs.getString(5).substring(0, 16) + "</p>");

                if (session.getAttribute("username") != null) {
    %>
    <p style="font-weight: bold; display: inline;">Edit:</p>

    <form action="edit-announcement.jsp">
        <button type="submit" name="edit" value="<%=rs.getString(1)%>">Επεξεργασία Ανακοίνωσης</button>
    </form>
    <form action="index.jsp">
        <button type="submit" name="delete" value="<%=rs.getString(1)%>">Διαγραφή Ανακοίνωσης</button>
    </form>
    <br>
    <%
                }

                out.print("<br></li>");
            }

            request.setCharacterEncoding("UTF-8");

            int delete = 0;

            String delete_request = request.getParameter("delete");

            if (StringUtils.isStrictlyNumeric(delete_request)) {
                delete = Integer.parseInt(delete_request);
            }

            if (delete != 0) {
                st.executeUpdate("delete from announcements where aid = " + delete);

                st.close();

                response.sendRedirect("index.jsp");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    %>
</ul>

</body>
</html>
