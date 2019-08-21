<%@ page contentType="text/html;charset=UTF-8" %>
<%@page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.PreparedStatement" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Νέα Ανακοίνωση</title>
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
<%
    if (session.getAttribute("username") == null) {
        response.sendRedirect("index.jsp");
    } else {
%>
<h1 style="text-align:center; margin: auto; color: #218527;"> Νέα Ανακοίνωση</h1>
<br>

<div class='newanounc'>
    <form action="new-announcement.jsp">
        Τίτλος:
        <br>
        <input type='text' name='title' value="">

        <br><br>

        Περιεχόμενο:
        <textarea cols='65' rows='10' name='text'></textarea>

        <br><br>

        <button type="submit" value="submit"> Δημοσίευση</button>
    </form>
</div>
<%
    }
%>

<%
    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        String dbUrl = "jdbc:mysql://localhost:3306/simplepostdb?useUnicode=true&useJDBCCompliantTimezoneShift=true" +
                "&useLegacyDatetimeCode=false&serverTimezone=UTC&allowPublicKeyRetrieval=true&useSSL=false";
        String dbUsername = "root";
        String dbPassword = "7896";
        Connection conn = DriverManager.getConnection(dbUrl, dbUsername, dbPassword);

        PreparedStatement st;

        request.setCharacterEncoding("UTF-8");

        String title = request.getParameter("title");
        String text = request.getParameter("text");

        if (title == null || text == null) {
            // do nothing
        } else if (title.length() == 0 || text.length() == 0) {
            // do nothing
        } else {
            text += "\n";

            String sql_text = "insert into announcements(username, title, textbox) values ('admin', ?, ?)";
            st = conn.prepareStatement(sql_text);
            st.setString(1, title); // for the first unknown value (?)
            st.setString(2, text);
            st.executeUpdate();

            st.close();

            response.sendRedirect("index.jsp");
        }
    } catch (Exception e) {
        e.printStackTrace();
    }
%>

</body>
</html>
