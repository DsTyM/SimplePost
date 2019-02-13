<%@ page contentType="text/html;charset=UTF-8" %>
<%@page import="java.sql.*" %>

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

        String eTitle = "";
        String eText = "";

        request.setCharacterEncoding("UTF-8");

        String tEdit = request.getParameter("edit");
        int edit = 0;

        if (tEdit == null || tEdit.equals("")) {
            // do nothing
        } else {
            try {
                Class.forName("com.mysql.jdbc.Driver");
                Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/SimplePostDB",
                        "root", "7896");

                Statement st = conn.createStatement();

                edit = Integer.parseInt(tEdit);

                ResultSet rs = st.executeQuery("SELECT * FROM Announcements WHERE aid = " + edit);

                if (rs.next()) {
                    eTitle = rs.getString(3);
                    eText = rs.getString(4);
                }

                st.close();
            } catch (Exception e) {
                System.out.println(e.getMessage());
            }
        }
%>
<h1 style="text-align: center; margin: auto; color: #218527;"> Επεξεργασία Ανακοίνωσης</h1>
<br>

<div class='newanounc'>
    <form action="editAnnouncement.jsp">
        Τίτλος:
        <br>
        <input type='text' name='title' value="<%=eTitle%>">

        <br><br>

        Περιεχόμενο:
        <textarea cols='65' rows='10' name='text'><%=eText%></textarea>

        <br><br>

        <input type="hidden" name="edit2" value="<%=edit%>">

        <button type="submit"> Επεξεργασία</button>
    </form>
</div>
<%
        try {
            Class.forName("com.mysql.jdbc.Driver");
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/SimplePostDB",
                    "root", "7896");

            Statement st = conn.createStatement();

            request.setCharacterEncoding("UTF-8");

            String title = request.getParameter("title");
            String text = request.getParameter("text");

            tEdit = request.getParameter("edit2");

            if (title == null || text == null || tEdit == null) {
                // do nothing
            } else if (title.length() == 0 || text.length() == 0 || tEdit.length() == 0) {
                // do nothing
            } else {
                text += "\n";

                st.executeUpdate("insert into Announcements(username, title, textbox) values('admin', '"
                        + title + "', '" + text + "')");

                edit = Integer.parseInt(tEdit);

                st.executeUpdate("delete from announcements where aid = " + edit);

                st.close();

                response.sendRedirect("Announcements.jsp");
            }
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }
    }
%>

</body>
</html>
