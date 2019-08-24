package com.dstym.controller;

import com.dstym.model.DbHelper;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;

@WebServlet("/TestServlet")
public class TestServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Step 1:  Set up the printwriter
        PrintWriter out = response.getWriter();
        response.setContentType("text/plain");

        // Step 2:  Get a connection to the database
        Connection myConn = null;
        Statement myStmt = null;
        ResultSet myRs = null;

        try {
            myConn = DbHelper.getConnection();

            if(myConn != null) {
                // Step 3:  Create a SQL statements
                String sql = "select * from users";
                myStmt = myConn.createStatement();

                // Step 4:  Execute SQL query
                myRs = myStmt.executeQuery(sql);

                // Step 5:  Process the result set
                while (myRs.next()) {
                    String username = myRs.getString("username");
                    out.println(username);
                }
            }
        } catch (Exception exc) {
            exc.printStackTrace();
        }
    }
}
