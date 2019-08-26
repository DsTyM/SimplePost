package com.dstym.model;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;

public class DbHelper {
    public static Connection getConnection() {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            String dbUrl = "jdbc:mysql://localhost:3306/simplepostdb?useUnicode=true&useJDBCCompliantTimezoneShift=true" +
                    "&useLegacyDatetimeCode=false&serverTimezone=UTC&allowPublicKeyRetrieval=true&useSSL=false";
            String dbUsername = "root";
            String dbPassword = "7896";

            return DriverManager.getConnection(dbUrl, dbUsername, dbPassword);
        } catch (Exception e) {
            e.printStackTrace();

            return null;
        }
    }

    public static void close(Connection conn, Statement st, ResultSet rs) {
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
