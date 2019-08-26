package com.dstym.controller;

import com.dstym.model.Post;
import com.dstym.model.PostDbHelper;
import com.dstym.model.User;
import com.dstym.model.UserDbHelper;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

@WebServlet("/TestServlet")
public class TestServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        //Set up the printwriter
        PrintWriter out = response.getWriter();
        response.setContentType("text/plain");

        try {
//            UserDbHelper userDbHelper = new UserDbHelper();
//
//            List<User> users = userDbHelper.getUsers();
//
//            // Process the result set
//            for (User user : users) {
//                out.println(user.getUsername());
//            }

            PostDbHelper postDbHelper = new PostDbHelper();

            List<Post> posts = postDbHelper.getPosts();

            for (Post post : posts) {
                System.out.println(post.getTextBox());
                System.out.println();
            }
        } catch (Exception exc) {
            exc.printStackTrace();
        }
    }
}
