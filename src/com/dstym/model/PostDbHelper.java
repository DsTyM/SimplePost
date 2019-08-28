package com.dstym.model;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

public class PostDbHelper {
    public List<Post> getPosts() throws Exception {
        List<Post> posts = new ArrayList<>();

        Connection conn = null;
        Statement st = null;
        ResultSet rs = null;

        try {
            conn = DbHelper.getConnection();

            if (conn != null) {
                String sql = "select * from announcements order by date desc";

                st = conn.createStatement();
                rs = st.executeQuery(sql);

                while (rs.next()) {
                    // retrieve data from result set row
                    int id = rs.getInt("aid");
                    String username = rs.getString("username");
                    String title = rs.getString("title");
                    String textBox = rs.getString("textbox");
                    String stringDate = rs.getString("date");

                    // convert date from String to Date Object
                    SimpleDateFormat simpleDateFormatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
                    Date date = simpleDateFormatter.parse(stringDate);

                    // create new post object
                    //  Post(int id, String username, String title, String textBox, Date date)
                    Post post = new Post(id, username, title, textBox, date);

                    // add it to the list of posts
                    posts.add(post);
                }

                return posts;
            }

            return null;
        } catch (Exception e) {
            e.printStackTrace();

            return null;
        } finally {
            DbHelper.close(conn, st, rs);
        }
    }
}
