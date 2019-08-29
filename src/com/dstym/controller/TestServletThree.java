package com.dstym.controller;

import com.dstym.model.Post;
import com.dstym.model.PostDbHelper;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/TestServletThree")
public class TestServletThree extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        PostDbHelper postDbHelper = new PostDbHelper();

//        Post post1 = new Post("admin", "titloras1", "This is a text test!!");
//        postDbHelper.createPost(post1);

//        Post post2 = postDbHelper.getPost(12);
//        System.out.println(post2);

//        Post post3 = new Post(12, "titloras69", "This is a complete garbage test!!");
//        postDbHelper.updatePost(post3);

//        postDbHelper.deletePost(14);
    }
}
