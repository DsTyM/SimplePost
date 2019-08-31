<%@ page contentType="text/html;charset=UTF-8" %>

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
%>
<p class="big-text" style="text-align:center; margin: auto; color: #218527;"> Νέα Ανακοίνωση</p>
<br>

<div class='newanounc'>
    <form action="PostControllerServlet" method="post">
        Τίτλος:
        <br>
        <input type='text' name='title' value="">

        <br><br>

        Περιεχόμενο:
        <textarea cols='65' rows='10' name='text'></textarea>

        <br><br>

        <button type="submit" name="saveCreated" value="yes"> Δημοσίευση</button>
    </form>
</div>
<%
    }
%>

</body>
</html>
