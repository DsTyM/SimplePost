package com.dstym.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

public class PostDbHelper {
    private Connection conn = null;
    private Statement st = null;
    PreparedStatement pst = null;
    private ResultSet rs = null;

    public List<Post> getPosts() throws Exception {
        List<Post> posts = new ArrayList<>();

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

    public void createPost(Post post) {
        try {
            conn = DbHelper.getConnection();

            String sql = "insert into announcements(username, title, textbox) values (?, ?, ?)";
            if (conn != null) {
                pst = conn.prepareStatement(sql);
            }
            pst.setString(1, post.getUsername());
            pst.setString(2, post.getTitle());
            pst.setString(3, post.getTextBox());
            pst.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            DbHelper.close(conn, st, rs);
            DbHelper.closePreparedStatement(pst);
        }
    }

    public Post getPost(int postId) {
        try {
            conn = DbHelper.getConnection();

            if (conn != null) {
                String sql = "select * from announcements where aid = " + postId;

                st = conn.createStatement();
                rs = st.executeQuery(sql);

                rs.next();
                String username = rs.getString("username");
                String title = rs.getString("title");
                String textBox = rs.getString("textbox");
                String stringDate = rs.getString("date");

                // convert date from String to Date Object
                SimpleDateFormat simpleDateFormatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
                Date date = simpleDateFormatter.parse(stringDate);

                // create new post object

                return new Post(postId, username, title, textBox, date);
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
