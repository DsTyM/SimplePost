<%@ page contentType="text/html;charset=UTF-8" %>
<%@page import="com.mysql.cj.util.StringUtils" %>
<%@ page import="java.sql.*" %>

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
                e.printStackTrace();
            }
        }
%>
<h1 style="text-align: center; margin: auto; color: #218527;"> Επεξεργασία Ανακοίνωσης</h1>
<br>

<div class='newanounc'>
    <form action="edit-announcement.jsp">
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
            e.printStackTrace();
        }
    }
%>

</body>
</html>
