<%@ page contentType="text/html;charset=UTF-8" %>
<%@page import="com.dstym.model.DbHelper" %>
<%@ page import="com.dstym.model.Post" %>
<%@ page import="com.mysql.cj.util.StringUtils" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="java.util.List" %>

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
        response.sendRedirect("homepage.jsp");
    }

    if (session.getAttribute("username") == null) {
%>

<br><br><br><br>

<p class="big-text" style="text-align: center; margin: auto; color: #218527;">Ανακοινώσεις</p>
<br>

<%
} else {
%>
<br><br>
<div class="newbox">
    <a href="new-announcement.jsp">Νέα Ανακοίνωση</a>
</div>

<br><br>

<p class="big-text" style="text-align: center; margin: auto; color: #218527;">Ανακοινώσεις (Admin Mode)</p>
<br>

<%
    }
%>

<ul style="width: 50%; margin: auto; background-color: #e0e0e0;">
    <br>
    <%
        try {
            Connection conn = DbHelper.getConnection();

            assert conn != null;
            Statement st = conn.createStatement();

            List<Post> posts = (List<Post>) request.getAttribute("POSTS");

            for (Post post : posts) {
                out.print("<li><h3>" + post.getTitle() + "</h3><p>" + post.getTextBox() +
                        "</p><p style='font-weight: bold;'>" + post.getUsername() +
                        ", " + post.getDateAsText() + "</p>");

                if (session.getAttribute("username") != null) {
    %>
    <p style="font-weight: bold; display: inline;">Edit:</p>

    <form action="edit-announcement.jsp">
        <button type="submit" name="edit" value="<%=post.getId()%>">Επεξεργασία Ανακοίνωσης</button>
    </form>
    <form action="index.jsp">
        <button type="submit" name="delete" value="<%=post.getId()%>">Διαγραφή Ανακοίνωσης</button>
    </form>
    <br>
    <%
                }

                out.print("<br></li>");
            }

            request.setCharacterEncoding("UTF-8");

            /*
                here i probably mean if delete_id is bugger than 0
                that means that I have pressed the delete button, so
                it has to delete the post
             */

            int delete = 0;

            String delete_request = request.getParameter("delete");

            if (StringUtils.isStrictlyNumeric(delete_request)) {
                delete = Integer.parseInt(delete_request);
            }

            if (delete != 0) {
                st.executeUpdate("delete from announcements where aid = " + delete);

                st.close();

                response.sendRedirect("homepage.jsp");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    %>
</ul>

</body>
</html>
