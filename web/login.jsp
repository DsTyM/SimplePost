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
    <link rel="stylesheet" type="text/css" href="css/main-style.css"/>
</head>
<body>

<ul class="top_bar">
    <li class="top_bar" style="margin-left: 100px; color: #218f28; font-size: 2em; font-weight: bold;">
        SimplePost
    </li>
    <li class="top_bar" style="margin-left: 7%; font-size: 27px; font-weight: bold;">
        <a style="color: dimgray;" href="index.jsp">Ανακοινώσεις</a>
    </li>
    <li class="top_bar" style="margin-left: 4%; font-size: 27px; font-weight: bold;">
        <a style="color: dimgray;" href="about.jsp">About</a>
    </li>
    <li class="top_bar" style="float: right; margin-right: 15%; font-size: 20px; font-weight: bold;">
        <%
            if (session.getAttribute("username") == null) {
                out.print("<a style='color: #218527;' href='login.jsp'>Log In</a>");
            } else {
                String username = (String) session.getAttribute("username");
        %>
        <form action="index.jsp">
            <p style="color: #218527; margin: 0 0 0 0;">Welcome <%= username%>
                &nbsp

                <button type="submit" name="logout" value="yes" style="background-color: #218527;
            padding: 0.25em 1em; color: white; font-size: 16px;">Logout
                </button>
            </p>
        </form>

        <%
                String logout = request.getParameter("logout");

                if (logout == null || logout.equals("")) {
                    // do nothing
                } else if (logout.equals("yes")) {
                    session.invalidate();

                    response.sendRedirect("index.jsp");
                }
            }
        %>
    </li>
</ul>

<br><br>

<h1 style="text-align: center; margin: auto; color: #218527;">Log In</h1>
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
