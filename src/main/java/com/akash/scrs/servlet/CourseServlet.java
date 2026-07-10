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

@WebServlet("/courses")
public class CourseServlet extends HttpServlet {

    private CourseDAO courseDAO = new CourseDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("student") == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        try {
            List<Course> courses = courseDAO.getAllCourses();
            req.setAttribute("courses", courses);
            req.getRequestDispatcher("/views/courses.jsp").forward(req, resp);
        } catch (SQLException e) {
            req.setAttribute("error", "Could not load courses: " + e.getMessage());
            req.getRequestDispatcher("/views/courses.jsp").forward(req, resp);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("student") == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        Student student = (Student) session.getAttribute("student");
        String action   = req.getParameter("action");
        int courseId    = Integer.parseInt(req.getParameter("courseId"));

        try {
            if ("enroll".equals(action)) {
                boolean enrolled = courseDAO.enrollStudent(student.getId(), courseId);
                if (enrolled) {
                    session.setAttribute("message", "Successfully enrolled in the course!");
                } else {
                    session.setAttribute("message", "You are already enrolled in this course.");
                }
            } else if ("unenroll".equals(action)) {
                courseDAO.unenrollStudent(student.getId(), courseId);
                session.setAttribute("message", "You have been unenrolled from the course.");
            }
        } catch (SQLException e) {
            session.setAttribute("error", "Operation failed: " + e.getMessage());
        }

        resp.sendRedirect(req.getContextPath() + "/dashboard");
    }
}
