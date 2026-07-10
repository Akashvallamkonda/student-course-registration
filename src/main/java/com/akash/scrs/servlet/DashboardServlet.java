package com.akash.scrs.servlet;

import com.akash.scrs.dao.CourseDAO;
import com.akash.scrs.model.Course;
import com.akash.scrs.model.Student;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

@WebServlet("/dashboard")
public class DashboardServlet extends HttpServlet {

    private CourseDAO courseDAO = new CourseDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("student") == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        Student student = (Student) session.getAttribute("student");

        try {
            List<Course> enrolledCourses = courseDAO.getEnrolledCourses(student.getId());
            req.setAttribute("enrolledCourses", enrolledCourses);
            req.getRequestDispatcher("/views/dashboard.jsp").forward(req, resp);
        } catch (SQLException e) {
            req.setAttribute("error", "Could not load dashboard: " + e.getMessage());
            req.getRequestDispatcher("/views/dashboard.jsp").forward(req, resp);
        }
    }
}
