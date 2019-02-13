<%@ page contentType="text/html;charset=UTF-8" %>
<%@page import="java.sql.*" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Ανακοινώσεις</title>
    <link rel="stylesheet" type="text/css" href="Style201.css"/>

    <style type="text/css">
        button {
            padding: 0.25em 1em;
            font-size: 16px;
            margin: 0.25em;
        }

        p {
            word-break: break-all;
            width: 95%
        }

        form, button {
            display: inline-block;
        }
    </style>
</head>
<body>

<div class="box">
    <a href="index.jsp">
        Αρχική
    </a>
</div>

<%
    if (session.getAttribute("username") == null) {
%>

<br><br><br><br>

<h1 style="text-align: center; margin: auto; color: #218527;">Ανακοινώσεις</h1>
<br>

<%
} else {
%>
<div class="newbox">
    <a href="newAnnouncement.jsp">Νέα Ανακοίνωση</a>
</div>

<br><br><br><br>

<h1 style="text-align: center; margin: auto; color: #218527;">Ανακοινώσεις (Admin Mode)</h1>
<br>

<%
    }
%>

<!--To "list-style: none;" afairei tis telitses apo thn lista-->

<ul style="width: 50%; margin: auto; background-color: #e0e0e0;">
    <br>
    <%
        try {
            Class.forName("com.mysql.jdbc.Driver");
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/SimplePostDB",
                    "root", "7896");

            Statement st = conn.createStatement();

            ResultSet rs = st.executeQuery("SELECT * FROM Announcements ORDER BY date DESC");

            while (rs.next()) {
                out.print("<li><h3>" + rs.getString(3) + "</h3><p>" + rs.getString(4) +
                        "</p><p style='font-weight: bold;'>" + rs.getString(2) +
                        ", " + rs.getString(5).substring(0, 16) + "</p>");

                if (session.getAttribute("username") != null) {
    %>
    <p style="font-weight: bold; display: inline;">Edit:</p>

    <form action="editAnnouncement.jsp">
        <button type="submit" name="edit" value="<%=rs.getString(1)%>">Επεξεργασία Ανακοίνωσης</button>
    </form>
    <form action="Announcements.jsp">
        <button type="submit" name="delete" value="<%=rs.getString(1)%>">Διαγραφή Ανακοίνωσης</button>
    </form>
    <br>
    <%
                }

                out.print("<br></li>");
            }

            request.setCharacterEncoding("UTF-8");

            int delete = Integer.parseInt(request.getParameter("delete"));

            if (delete == 0) {
                // do nothing
            } else {

                st.executeUpdate("delete from announcements where aid = " + delete);

                st.close();

                response.sendRedirect("Announcements.jsp");
            }
        } catch (Exception e) {
            System.out.print(e.getMessage());
        }
    %>
</ul>

</body>
</html>
