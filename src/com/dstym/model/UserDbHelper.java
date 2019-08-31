package com.dstym.model;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

public class UserDbHelper {
    Connection conn = null;
    Statement st = null;
    ResultSet rs = null;

    public List<User> getUsers() throws Exception {
        List<User> users = new ArrayList<>();

        try {
            conn = DbHelper.getConnection();

            if (conn != null) {
                String sql = "select * from users";

                st = conn.createStatement();
                rs = st.executeQuery(sql);

                while (rs.next()) {
                    // retrieve data from result set row
                    int id = rs.getInt("id");
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

    public Boolean validateUser(User user) {
        try {
            conn = DbHelper.getConnection();

            if (conn != null) {
                String sql = "select * from users where username = '" + user.getUsername() + "'";

                st = conn.createStatement();
                rs = st.executeQuery(sql);

                if (rs.next()) {
                    String password = rs.getString("password");

                    return password.equals(user.getPassword());
                }

                return false;
            }

            return false;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        } finally {
            DbHelper.close(conn, st, rs);
        }
    }
}
