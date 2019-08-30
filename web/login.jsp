<%@ page contentType="text/html;charset=UTF-8" %>

<%
    if (session.getAttribute("username") != null) {
        response.sendRedirect("/");
    }
%>

<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Log In</title>
    <link rel="stylesheet" type="text/css" href="css/main-style.css"/>
</head>
<body>

<jsp:include page="header-bar.jsp"/>

<br><br>

<p class="big-text" style="text-align: center; margin: auto; color: #218527;">Log In</p>
<br>

<div class="loginbox">
    <form name="loginf" action="logged-in.jsp" method="POST">
        <h3>Username:
            <input type="text" name="username">
        </h3>
        <h3>Password:
            <input type="password" name="password">
        </h3>
        <button type="submit" value="submit">Σύνδεση</button>
        <%
            String isLogged = (String) session.getAttribute("isLogged");
            if (isLogged == null || isLogged.equals("yes")) {
                // do nothing
            } else if (isLogged.equals("no")) {
                out.print("<h4 style = 'color: yellow;'>Λάθος στοιχεία Προσπαθήστε ξανά</h4>");
                session.setAttribute("isLogged", "yes");
            }
        %>
    </form>
</div>

</body>
</html>
