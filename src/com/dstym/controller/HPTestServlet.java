package com.dstym.controller;

import com.dstym.model.Post;
import com.dstym.model.PostDbHelper;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/HPTestServlet")
public class HPTestServlet extends HttpServlet {
    private PostDbHelper postDbHelper;

    @Override
    public void init() throws ServletException {
        super.init();

        try {
            postDbHelper = new PostDbHelper();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            listPosts(request, response);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    private void listPosts(HttpServletRequest request, HttpServletResponse response) throws Exception {
        List<Post> posts = postDbHelper.getPosts();

        // add users to the request
        request.setAttribute("POSTS", posts);

        // send to JSP page (view)
        RequestDispatcher dispatcher = request.getRequestDispatcher("/homepage.jsp");
        dispatcher.forward(request, response);
    }
}
