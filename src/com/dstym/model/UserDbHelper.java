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
            // get a connection
            conn = DbHelper.getConnection();

            if(conn != null) {
                // create sql statement
                String sql = "select * from users";

                st = conn.createStatement();

                // execute query
                rs = st.executeQuery(sql);

                // process result set
                while (rs.next()) {

                    // retrieve data from result set row
                    int id = rs.getInt("uid");
                    String username = rs.getString("username");
                    String password = rs.getString("password");
                    String type = rs.getString("type");

                    // create new student object
                    User user = new User(id, username, password, type);

                    // add it to the list of users
                    users.add(user);
                }

                return users;
            }

            return null;
        } catch(Exception e) {
            e.printStackTrace();

            return null;
        } finally {
            close(conn, st, rs);
        }
    }

    private void close(Connection conn, Statement st, ResultSet rs) {
        try {
            if (rs != null) {
                rs.close();
            }

            if (st != null) {
                st.close();
            }

            if (conn != null) {
                conn.close();
            }
        } catch (Exception exc) {
            exc.printStackTrace();
        }
    }
}
