<%@ page contentType="text/html;charset=UTF-8" %>

<!DOCTYPE html >
<html lang="en" style="text-indent: 40px; background-color: white">
<head>
    <meta charset="UTF-8">
    <title>SimplePost</title>

    <link rel="stylesheet" type="text/css" href="TStyleOrd1.css"/>

    <style type="text/css">

        h1 {
            color: black;
        }

        h2 {
            color: black;
        }

        ul {
            list-style-type: none;
            margin: 0;
            padding: 0;
            overflow: hidden;
            background-color: #e0e0e0;
        }

        li {
            float: left;
        }

        ul, li {
            text-align: center;
            vertical-align: middle;
            height: 90px;
            line-height: 90px;
        }

    </style>
</head>
<body>

<!-- "font-size: 2em; font-weight: bold;" ειναι το <h1> -->

<ul>
    <li style="margin-left: 100px; color: #218f28; font-size: 2em; font-weight: bold;">
        SimplePost
    </li>
    <li style="margin-left: 7%; font-size: 27px; font-weight: bold;">
        <a style="color: dimgray;" href="Announcements.jsp">Ανακοινώσεις</a>
    </li>
    <li style="font-size: 27px; font-weight: bold;">
        <a style="color: dimgray;" href="About.html">About</a>
    </li>
    <li style="float: right; margin-right: 15%; font-size: 20px; font-weight: bold;">
        <%
            if (session.getAttribute("username") == null) {
                out.print("<a style='color: #218527;' href='Login.jsp'>Log In</a>");
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

<h1>Σύστημα Διαχείρισης Ανακοινώσεων</h1>

</body>
</html>
