<%@ page contentType="text/html;charset=UTF-8" %>
<%@page import="com.mysql.cj.util.StringUtils" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.Statement" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Ανακοινώσεις</title>
    <link rel="stylesheet" type="text/css" href="Style201.css"/>

    <style type="text/css">
        button {
            padding: 0.25em 1em;
            font-size: 16px;
            margin: 0.25em;
        }

        p {
            word-break: break-all;
            width: 95%
        }

        form, button {
            display: inline-block;
        }
    </style>
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
        <a style="color: dimgray;" href="About.jsp">About</a>
    </li>
    <li class="top_bar" style="float: right; margin-right: 15%; font-size: 20px; font-weight: bold;">
        <%
            if (session.getAttribute("username") == null) {
                out.print("<a style='color: #218527;' href='Login.jsp'>Log In</a>");
            } else {
                String username = (String) session.getAttribute("username");
        %>
        <form action="index.jsp">
            <p style="color: #218527; margin: 0 0 0 0; word-break: normal; width: 100%">Welcome <%= username%>
                &nbsp

                <button type="submit" name="logout" value="yes" style="background-color: #218527;
            padding: 0.25em 1em; color: white; font-size: 16px;">Logout
                </button>
            </p>
        </form>

        <%
                String logout = request.getParameter("logout");

                if (logout != null && !logout.equals("")) {
                    session.invalidate();

                    session = request.getSession(true);
                    response.sendRedirect("index.jsp");
                }
            }
        %>
    </li>
</ul>

<%
    if (session.getAttribute("username") == null) {
%>

<br><br><br><br>

<h1 style="text-align: center; margin: auto; color: #218527;">Ανακοινώσεις</h1>
<br>

<%
} else {
%>
<br><br>
<div class="newbox">
    <a href="newAnnouncement.jsp">Νέα Ανακοίνωση</a>
</div>

<br><br>

<h1 style="text-align: center; margin: auto; color: #218527;">Ανακοινώσεις (Admin Mode)</h1>
<br>

<%
    }
%>

<ul style="width: 50%; margin: auto; background-color: #e0e0e0;">
    <br>
    <%
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            String dbUrl = "jdbc:mysql://localhost:3306/simplepostdb?useUnicode=true&useJDBCCompliantTimezoneShift=true" +
                    "&useLegacyDatetimeCode=false&serverTimezone=UTC&allowPublicKeyRetrieval=true&useSSL=false";
            String dbUsername = "root";
            String dbPassword = "7896";
            Connection conn = DriverManager.getConnection(dbUrl, dbUsername, dbPassword);

            Statement st = conn.createStatement();

            ResultSet rs = st.executeQuery("SELECT * FROM announcements ORDER BY date DESC");

            while (rs.next()) {
                out.print("<li><h3>" + rs.getString(3) + "</h3><p>" + rs.getString(4) +
                        "</p><p style='font-weight: bold;'>" + rs.getString(2) +
                        ", " + rs.getString(5).substring(0, 16) + "</p>");

                if (session.getAttribute("username") != null) {
    %>
    <p style="font-weight: bold; display: inline;">Edit:</p>

    <form action="editAnnouncement.jsp">
        <button type="submit" name="edit" value="<%=rs.getString(1)%>">Επεξεργασία Ανακοίνωσης</button>
    </form>
    <form action="index.jsp">
        <button type="submit" name="delete" value="<%=rs.getString(1)%>">Διαγραφή Ανακοίνωσης</button>
    </form>
    <br>
    <%
                }

                out.print("<br></li>");
            }

            request.setCharacterEncoding("UTF-8");

            int delete = 0;

            String delete_request = request.getParameter("delete");

            if (StringUtils.isStrictlyNumeric(delete_request)) {
                delete = Integer.parseInt(delete_request);
            }

            if (delete != 0) {
                st.executeUpdate("delete from announcements where aid = " + delete);

                st.close();

                response.sendRedirect("index.jsp");
            }
        } catch (Exception e) {
            System.out.println("\n============== Error starts here. ==============");
            e.printStackTrace();
            System.out.println("============== Error ends here. ==============\n");
        }
    %>
</ul>

</body>
</html>
