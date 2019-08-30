package com.dstym.controller;

import com.dstym.model.Post;
import com.dstym.model.PostDbHelper;
import com.mysql.cj.util.StringUtils;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/PostControllerServlet")
public class PostControllerServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        int postId = 0;

        PostDbHelper postDbHelper = new PostDbHelper();
        Post post = null;

        String deleteRequest = request.getParameter("delete");
        String editRequest = request.getParameter("edit");
        String saveEditedRequest = request.getParameter("saveEdited");

        if (deleteRequest != null && deleteRequest.length() != 0) {
            if (StringUtils.isStrictlyNumeric(deleteRequest)) {
                postId = Integer.parseInt(deleteRequest);
            }

            if (postId != 0) {
                postDbHelper.deletePost(postId);
            }
        } else if (editRequest != null && editRequest.length() != 0) {
            if (StringUtils.isStrictlyNumeric(editRequest)) {
                postId = Integer.parseInt(editRequest);
            }

            if (postId != 0) {
                post = postDbHelper.getPost(postId);

                request.setAttribute("POST", post);

                RequestDispatcher dispatcher = request.getRequestDispatcher("/edit-announcement.jsp");
                dispatcher.forward(request, response);
            }
        } else if (saveEditedRequest != null && saveEditedRequest.length() != 0) {
            if (StringUtils.isStrictlyNumeric(saveEditedRequest)) {
                postId = Integer.parseInt(saveEditedRequest);
            }

            if (postId != 0) {
                String title = request.getParameter("title");
                String textBox = request.getParameter("text");

                post = new Post(postId, title, textBox);
                postDbHelper.updatePost(post);
            }
        }

        response.sendRedirect("/");
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
