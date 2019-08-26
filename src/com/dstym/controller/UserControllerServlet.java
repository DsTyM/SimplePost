package com.dstym.controller;

import com.dstym.model.User;
import com.dstym.model.UserDbHelper;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

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
        // list the users ... in mvc fashion
        try {
            listUsers(request, response);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    private void listUsers(HttpServletRequest request, HttpServletResponse response) throws Exception {

        List<User> users = userDbHelper.getUsers();

        // add users to the request
        request.setAttribute("USERS_LIST", users);

        // send to JSP page (view)
        RequestDispatcher dispatcher = request.getRequestDispatcher("/list-users.jsp");
        dispatcher.forward(request, response);
    }
}
