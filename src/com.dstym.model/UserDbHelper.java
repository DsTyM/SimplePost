package com.dstym.model;

import javax.sql.DataSource;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

public class UserDbHelper {
    private DataSource dataSource;

    public UserDbHelper(DataSource dataSource) {
        this.dataSource = dataSource;
    }

    public List<User> getStudents() throws Exception {
        List<User> students = new ArrayList<>();

        Connection conn = null;
        Statement st = null;
        ResultSet rs = null;

        try {
            // get a connection
            conn = dataSource.getConnection();

            // create sql statement
            String sql = "select * from users";

            st = conn.createStatement();

            // execute query
            rs = st.executeQuery(sql);

            // process result set
            while (rs.next()) {

                // retrieve data from result set row
                int id = rs.getInt("id");
                String firstName = rs.getString("first_name");
                String lastName = rs.getString("last_name");
                String email = rs.getString("email");

                // create new student object
                User tempStudent = new User(id, firstName, lastName, email);

                // add it to the list of students
                students.add(tempStudent);
            }

            return students;
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
                // return it to connection pool
                conn.close();
            }
        } catch (Exception exc) {
            exc.printStackTrace();
        }
    }
}
