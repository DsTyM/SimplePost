<%@ page contentType="text/html;charset=UTF-8" %>

<%
    if (session.getAttribute("username") != null) {
        response.sendRedirect("index.jsp");
    }
%>

<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Log In</title>
    <link rel="stylesheet" type="text/css" href="Style201.css"/>
</head>
<body>

<div class="box">
    <a href="index.jsp">
        Αρχική
    </a>
</div>

<br><br>

<h1 style="text-align: center; margin: auto; color: #218527;">Log In</h1>
<br>

<div class="loginbox">
    <form name="loginf" action="LoggedIn.jsp" method="GET">
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
