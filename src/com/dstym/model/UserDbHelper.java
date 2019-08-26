package com.dstym.model;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

public class UserDbHelper {
    public List<User> getUsers() throws Exception {
        List<User> users = new ArrayList<>();

        Connection conn = null;
        Statement st = null;
        ResultSet rs = null;

        try {
            conn = DbHelper.getConnection();

            if (conn != null) {
                String sql = "select * from users";

                st = conn.createStatement();
                rs = st.executeQuery(sql);

                while (rs.next()) {
                    // retrieve data from result set row
                    int id = rs.getInt("uid");
                    String username = rs.getString("username");
                    String password = rs.getString("password");
                    String type = rs.getString("type");

                    // create new user object
                    User user = new User(id, username, password, type);

                    // add it to the list of users
                    users.add(user);
                }

                return users;
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
