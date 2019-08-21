<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>About SimplePost</title>
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

<h1 style="margin-left: 23%;">
    SimplePost
</h1>
<hr style="width: 700px; margin-left: 18%;">
<h2 style="width: 600px; font-weight: normal; margin-left: 23%;">
    Το SimplePost είναι ένα σύστημα διαχείρισης ανακοινώσεων.
    Οι ήδη εγγεγραμμένοι χρήστες μπορούν να συνδεθούν και να επεξεργαστούν μια ανακοίνωση ή να ανεβάσουν μια καινούρια.
    Οι μη συνδεδεμένοι χρήστες μπορούν να δουν τις ανακοινώσεις που ήδη υπάρχουν.

</h2>

<h2 style="width: 600px; font-weight: normal; margin-left: 23%;">
    Το SimplePost χρησιμοποιεί στο back end: Java EE (γνωστή πλέον ως Jakarta EE) μαζί με MySQL, και στο front end: HTML, CSS και JavaScript.
</h2>
</body>
</html>
