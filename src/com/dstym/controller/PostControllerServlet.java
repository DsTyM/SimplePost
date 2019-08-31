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
    private String username;
    private int postId;
    private PostDbHelper postDbHelper;

    @Override
    public void init() throws ServletException {
        super.init();

        username = "";

        postId = 0;
        postDbHelper = new PostDbHelper();
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        if (request.getSession(false).getAttribute("username") != null) {
            username = (String) request.getSession(false).getAttribute("username");
        }

        String deleteRequest = request.getParameter("delete");
        String editRequest = request.getParameter("edit");
        String saveEditedRequest = request.getParameter("saveEdited");
        String createRequest = request.getParameter("create");
        String saveCreatedRequest = request.getParameter("saveCreated");

        if (deleteRequest != null && deleteRequest.length() != 0) {
            deletePost(postId, postDbHelper, deleteRequest);
        } else if (editRequest != null && editRequest.length() != 0) {
            serveEditPost(request, response, postId, postDbHelper, editRequest);
            return;
        } else if (saveEditedRequest != null && saveEditedRequest.length() != 0) {
            saveEditedPost(request, postId, postDbHelper, saveEditedRequest);
        } else if (createRequest != null && createRequest.length() != 0) {
            serveCreatePost(request, response);
            return;
        } else if (saveCreatedRequest != null && saveCreatedRequest.length() != 0) {
            saveCreatedPost(request, username, postDbHelper);
        }

        response.sendRedirect("/");
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }

    private void saveCreatedPost(HttpServletRequest request, String username, PostDbHelper postDbHelper) {
        Post post;
        String title = request.getParameter("title");
        String textBox = request.getParameter("text");

        post = new Post(username, title, textBox);
        postDbHelper.createPost(post);
    }

    private void serveCreatePost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/create-post.jsp");
        dispatcher.forward(request, response);
    }

    private void saveEditedPost(HttpServletRequest request, int postId, PostDbHelper postDbHelper, String saveEditedRequest) {
        Post post;
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

    private void serveEditPost(HttpServletRequest request, HttpServletResponse response, int postId, PostDbHelper postDbHelper, String editRequest) throws ServletException, IOException {
        Post post;
        if (StringUtils.isStrictlyNumeric(editRequest)) {
            postId = Integer.parseInt(editRequest);
        }

        if (postId != 0) {
            post = postDbHelper.getPost(postId);

            request.setAttribute("POST", post);

            RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/edit-post.jsp");
            dispatcher.forward(request, response);
        }
    }

    private void deletePost(int postId, PostDbHelper postDbHelper, String deleteRequest) {
        if (StringUtils.isStrictlyNumeric(deleteRequest)) {
            postId = Integer.parseInt(deleteRequest);
        }

        if (postId != 0) {
            postDbHelper.deletePost(postId);
        }
    }
}
