package com.dstym.controller;

import com.dstym.model.PostDbHelper;
import com.mysql.cj.util.StringUtils;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/PostControllerServlet")
public class PostControllerServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        String delete_request = request.getParameter("delete");

        if (delete_request != null && delete_request.length() != 0) {
            int postId = 0;

            if (StringUtils.isStrictlyNumeric(delete_request)) {
                postId = Integer.parseInt(delete_request);
            }

            if(postId != 0) {
                PostDbHelper postDbHelper = new PostDbHelper();
                postDbHelper.deletePost(postId);
            }

            response.sendRedirect("/");
        }
    }
}
