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

@WebServlet("/UserControllerServlet")
public class UserControllerServlet extends HttpServlet {
    private UserDbHelper userDbHelper;

    @Override
    public void init() throws ServletException {
        super.init();

        userDbHelper = new UserDbHelper();
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        String loginRequest = request.getParameter("login");

        if (loginRequest != null && loginRequest.length() != 0) {
            loginUser(request, response);
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String loginFormRequest = request.getParameter("login-form");

        if (loginFormRequest != null) {
            RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/login.jsp");
            dispatcher.forward(request, response);
        }
    }

    private void loginUser(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        User user = new User(username, password);
        userDbHelper = new UserDbHelper();
        Boolean validatedUser = userDbHelper.validateUser(user);

        if (validatedUser) {
            resetSuccessfullyLoggedIn(request);
            request.getSession(false).setAttribute("username", username);
            response.sendRedirect("/");
        } else {
            request.getSession(false).setAttribute("print-could-not-login-message", "yes");
            RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/login.jsp");
            dispatcher.forward(request, response);
        }
    }

    private void resetSuccessfullyLoggedIn(HttpServletRequest request) {
        String printCouldNotLoginMessage;
        if (request.getSession(false).getAttribute("print-could-not-login-message") != null) {
            printCouldNotLoginMessage = (String) request.getSession(false).getAttribute("print-could-not-login-message");
            if (printCouldNotLoginMessage.equals("no")) {
                request.getSession(false).setAttribute("print-could-not-login-message", "no");
            }
        }
    }
}
