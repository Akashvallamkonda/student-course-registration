package com.akash.scrs.dao;

import com.akash.scrs.model.Course;
import com.akash.scrs.util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class CourseDAO {

    // Get all available courses
    public List<Course> getAllCourses() throws SQLException {
        List<Course> courses = new ArrayList<>();
        String sql = "SELECT * FROM courses ORDER BY title";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Course course = mapCourse(rs);
                courses.add(course);
            }
        }
        return courses;
    }

    // Get course by ID
    public Course getCourseById(int id) throws SQLException {
        String sql = "SELECT * FROM courses WHERE id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) return mapCourse(rs);
            }
        }
        return null;
    }

    // Enroll student in a course
    public boolean enrollStudent(int studentId, int courseId) throws SQLException {
        if (isAlreadyEnrolled(studentId, courseId)) return false;

        String sql = "INSERT INTO enrollments (student_id, course_id, enrolled_on) VALUES (?, ?, NOW())";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, studentId);
            ps.setInt(2, courseId);
            return ps.executeUpdate() > 0;
        }
    }

    // Check if student already enrolled
    public boolean isAlreadyEnrolled(int studentId, int courseId) throws SQLException {
        String sql = "SELECT id FROM enrollments WHERE student_id = ? AND course_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, studentId);
            ps.setInt(2, courseId);
            try (ResultSet rs = ps.executeQuery()) {
                return rs.next();
            }
        }
    }

    // Get enrolled courses for a student
    public List<Course> getEnrolledCourses(int studentId) throws SQLException {
        List<Course> courses = new ArrayList<>();
        String sql = "SELECT c.* FROM courses c " +
                     "JOIN enrollments e ON c.id = e.course_id " +
                     "WHERE e.student_id = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, studentId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) courses.add(mapCourse(rs));
            }
        }
        return courses;
    }

    // Unenroll student from a course
    public boolean unenrollStudent(int studentId, int courseId) throws SQLException {
        String sql = "DELETE FROM enrollments WHERE student_id = ? AND course_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, studentId);
            ps.setInt(2, courseId);
            return ps.executeUpdate() > 0;
        }
    }

    private Course mapCourse(ResultSet rs) throws SQLException {
        Course course = new Course();
        course.setId(rs.getInt("id"));
        course.setTitle(rs.getString("title"));
        course.setDescription(rs.getString("description"));
        course.setInstructor(rs.getString("instructor"));
        course.setDuration(rs.getInt("duration"));
        course.setSeats(rs.getInt("seats"));
        return course;
    }
}
