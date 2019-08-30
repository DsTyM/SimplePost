<%@ page contentType="text/html;charset=UTF-8" %>
<%@page import="com.dstym.model.Post" %>
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
        response.sendRedirect("/");
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
        List<Post> posts = (List<Post>) request.getAttribute("POSTS");

        for (Post post : posts) {
            out.print("<li><h3>" + post.getTitle() + "</h3><p>" + post.getTextBox() +
                    "</p><p style='font-weight: bold;'>" + post.getUsername() +
                    ", " + post.getDateAsText() + "</p>");

            if (session.getAttribute("username") != null) {
    %>
    <p style="font-weight: bold; display: inline;">Edit:</p>

    <form action="PostControllerServlet" method="post">
        <button type="submit" name="edit" value="<%=post.getId()%>">Επεξεργασία Ανακοίνωσης</button>
        <button type="submit" name="delete" value="<%=post.getId()%>">Διαγραφή Ανακοίνωσης</button>
    </form>
    <br>
    <%
        }
    %>

    <br>
    </li>

    <%
        }
    %>
</ul>

</body>
</html>
