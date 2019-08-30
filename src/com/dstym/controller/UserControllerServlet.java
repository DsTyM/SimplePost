package com.dstym.controller;

import com.dstym.model.UserDbHelper;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/UserControllerServlet")
public class UserControllerServlet extends HttpServlet {
    private UserDbHelper userDbHelper;

    @Override
    public void init() throws ServletException {
        super.init();

        try {
            userDbHelper = new UserDbHelper();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
