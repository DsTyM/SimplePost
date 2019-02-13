<%@ page contentType="text/html;charset=UTF-8" %>
<%@page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.Statement" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Νέα Ανακοίνωση</title>
    <link rel="stylesheet" type="text/css" href="Style201.css"/>
</head>
<body>

<div class="box">
    <a href="index.jsp">
        Αρχική
    </a>
</div>

<br><br>
<%
    if (session.getAttribute("username") == null) {
        response.sendRedirect("index.jsp");
    } else {
%>
<h1 style="text-align:center; margin: auto; color: #218527;"> Νέα Ανακοίνωση</h1>
<br>

<div class='newanounc'>
    <form action="newAnnouncement.jsp">
        Τίτλος:
        <br>
        <input type='text' name='title' value="">

        <br><br>

        Περιεχόμενο:
        <textarea cols='65' rows='10' name='text'></textarea>

        <br><br>

        <button type="submit" value="submit"> Δημοσίευση</button>
    </form>
</div>
<%
    }
%>

<%
    try {
        Class.forName("com.mysql.jdbc.Driver");
        Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/SimplePostDB",
                "root", "7896");

        Statement st = conn.createStatement();

        request.setCharacterEncoding("UTF-8");

        String title = request.getParameter("title");
        String text = request.getParameter("text");

        if (title == null || text == null) {
            // do nothing
        } else if (title.length() == 0 || text.length() == 0) {
            // do nothing
        } else {
            text += "\n";

            st.executeUpdate("insert into Announcements(username, title, textbox) values('admin', '"
                    + title + "', '" + text + "')");

            st.close();

            response.sendRedirect("Announcements.jsp");
        }
    } catch (Exception e) {
        System.out.println(e.getMessage());
    }
%>

</body>
</html>
