<%@ page contentType="text/html;charset=UTF-8" %>
<%@page import="com.mysql.cj.util.StringUtils" %>
<%@ page import="java.sql.*" %>
<%@ page import="com.dstym.model.Post" %>

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
        Post post = (Post) request.getAttribute("POST");
%>
<p class="big-text" style="text-align: center; margin: auto; color: #218527;"> Επεξεργασία Ανακοίνωσης</p>
<br>

<div class='newanounc'>
    <form action="edit-announcement.jsp">
        Τίτλος:
        <br>
        <input type='text' name='title' value="<%=post.getTitle()%>">

        <br><br>

        Περιεχόμενο:
        <textarea cols='65' rows='10' name='text'><%=post.getTextBox()%></textarea>

        <br><br>

        <input type="hidden" name="edit2" value="<%=post.getId()%>">

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

            if (title != null && title.length() != 0 && text != null && text.length() != 0 && tEdit != null && tEdit.length() != 0) {
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

                response.sendRedirect("/");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
%>

</body>
</html>
