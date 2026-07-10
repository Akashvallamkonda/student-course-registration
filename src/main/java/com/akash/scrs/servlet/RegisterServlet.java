package com.akash.scrs.servlet;

import com.akash.scrs.dao.StudentDAO;
import com.akash.scrs.model.Student;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/register")
public class RegisterServlet extends HttpServlet {

    private StudentDAO studentDAO = new StudentDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        req.getRequestDispatcher("/views/register.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String name     = req.getParameter("name").trim();
        String email    = req.getParameter("email").trim();
        String password = req.getParameter("password");
        String confirm  = req.getParameter("confirmPassword");
        String phone    = req.getParameter("phone").trim();
        String branch   = req.getParameter("branch").trim();

        // Validation
        if (name.isEmpty() || email.isEmpty() || password.isEmpty()) {
            req.setAttribute("error", "All fields are required.");
            req.getRequestDispatcher("/views/register.jsp").forward(req, resp);
            return;
        }

        if (!password.equals(confirm)) {
            req.setAttribute("error", "Passwords do not match.");
            req.getRequestDispatcher("/views/register.jsp").forward(req, resp);
            return;
        }

        try {
            if (studentDAO.emailExists(email)) {
                req.setAttribute("error", "This email is already registered. Please login.");
                req.getRequestDispatcher("/views/register.jsp").forward(req, resp);
                return;
            }

            Student student = new Student(name, email, password, phone, branch);
            boolean registered = studentDAO.registerStudent(student);

            if (registered) {
                resp.sendRedirect(req.getContextPath() + "/login?success=registered");
            } else {
                req.setAttribute("error", "Registration failed. Please try again.");
                req.getRequestDispatcher("/views/register.jsp").forward(req, resp);
            }

        } catch (SQLException e) {
            req.setAttribute("error", "Database error: " + e.getMessage());
            req.getRequestDispatcher("/views/register.jsp").forward(req, resp);
        }
    }
}
