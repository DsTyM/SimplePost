﻿<%@ page contentType="text/html;charset=UTF-8" %>
<%@page import="com.dstym.model.Post" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Νέα Ανακοίνωση</title>
    <link rel="stylesheet" type="text/css" href="css/main-style.css"/>
</head>
<body>

<jsp:include page="header-bar.jsp"/>

<br><br>
<%
    if (session.getAttribute("username") == null) {
        response.sendRedirect("/");
    } else {
        Post post = (Post) request.getAttribute("POST");
%>
<p class="big-text" style="text-align: center; margin: auto; color: #218527;"> Επεξεργασία Ανακοίνωσης</p>
<br>

<div class='newanounc'>
    <form action="PostControllerServlet" method="post">
        Τίτλος:
        <br>
        <input type='text' name='title' value="<%=post.getTitle()%>">

        <br><br>

        Περιεχόμενο:
        <textarea cols='65' rows='10' name='text'><%=post.getTextBox()%></textarea>

        <br><br>

        <button type="submit" name="saveEdited" value="<%=post.getId()%>"> Επεξεργασία</button>
    </form>
</div>
<%
    }
%>

</body>
</html>
