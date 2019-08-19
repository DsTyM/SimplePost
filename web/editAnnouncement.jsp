<%@ page contentType="text/html;charset=UTF-8" %>
<%@page import="com.mysql.cj.util.StringUtils" %>
<%@ page import="java.sql.*" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Νέα Ανακοίνωση</title>
    <link rel="stylesheet" type="text/css" href="Style201.css"/>
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

        String eTitle = "";
        String eText = "";

        request.setCharacterEncoding("UTF-8");

        String tEdit = request.getParameter("edit");
        int edit = 0;

        if (tEdit == null || tEdit.equals("")) {
            // do nothing
        } else {
            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                String dbUrl = "jdbc:mysql://localhost:3306/simplepostdb?useUnicode=true&useJDBCCompliantTimezoneShift=true" +
                        "&useLegacyDatetimeCode=false&serverTimezone=UTC&allowPublicKeyRetrieval=true&useSSL=false";
                String dbUsername = "root";
                String dbPassword = "7896";
                Connection conn = DriverManager.getConnection(dbUrl, dbUsername, dbPassword);

                Statement st = conn.createStatement();

                if (StringUtils.isStrictlyNumeric(tEdit)) {
                    edit = Integer.parseInt(tEdit);
                }

                ResultSet rs = st.executeQuery("SELECT * FROM announcements WHERE aid = " + edit);

                if (rs.next()) {
                    eTitle = rs.getString(3);
                    eText = rs.getString(4);
                }

                st.close();
            } catch (Exception e) {
                System.out.println("\n============== Error starts here. ==============");
                e.printStackTrace();
                System.out.println("============== Error ends here. ==============\n");
            }
        }
%>
<h1 style="text-align: center; margin: auto; color: #218527;"> Επεξεργασία Ανακοίνωσης</h1>
<br>

<div class='newanounc'>
    <form action="editAnnouncement.jsp">
        Τίτλος:
        <br>
        <input type='text' name='title' value="<%=eTitle%>">

        <br><br>

        Περιεχόμενο:
        <textarea cols='65' rows='10' name='text'><%=eText%></textarea>

        <br><br>

        <input type="hidden" name="edit2" value="<%=edit%>">

        <button type="submit"> Επεξεργασία</button>
    </form>
</div>
<%
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            String dbUrl = "jdbc:mysql://localhost:3306/simplepostdb?useUnicode=true&useJDBCCompliantTimezoneShift=true" +
                    "&useLegacyDatetimeCode=false&serverTimezone=UTC&allowPublicKeyRetrieval=true&useSSL=false";
            String dbUsername = "root";
            String dbPassword = "7896";
            Connection conn = DriverManager.getConnection(dbUrl, dbUsername, dbPassword);

            Statement st = conn.createStatement();
            PreparedStatement pst;

            request.setCharacterEncoding("UTF-8");

            String title = request.getParameter("title");
            String text = request.getParameter("text");

            tEdit = request.getParameter("edit2");

            if (title == null || text == null || tEdit == null) {
                // do nothing
            } else if (title.length() == 0 || text.length() == 0 || tEdit.length() == 0) {
                // do nothing
            } else {
                text += "\n";

                String sql_text = "insert into announcements(username, title, textbox) values ('admin', ?, ?)";
                pst = conn.prepareStatement(sql_text);
                pst.setString(1, title); // for the first unknown value (?)
                pst.setString(2, text);
                pst.executeUpdate();

                if (StringUtils.isStrictlyNumeric(tEdit)) {
                    edit = Integer.parseInt(tEdit);
                }

                st.executeUpdate("delete from announcements where aid = " + edit);

                st.close();

                response.sendRedirect("index.jsp");
            }
        } catch (Exception e) {
            System.out.println("\n============== Error starts here. ==============");
            e.printStackTrace();
            System.out.println("============== Error ends here. ==============\n");
        }
    }
%>

</body>
</html>
