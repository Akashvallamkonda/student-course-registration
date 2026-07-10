package com.akash.scrs.dao;

import com.akash.scrs.model.Student;
import com.akash.scrs.util.DBConnection;

import java.sql.*;

public class StudentDAO {

    // Register a new student
    public boolean registerStudent(Student student) throws SQLException {
        String sql = "INSERT INTO students (name, email, password, phone, branch) VALUES (?, ?, ?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, student.getName());
            ps.setString(2, student.getEmail());
            ps.setString(3, student.getPassword());
            ps.setString(4, student.getPhone());
            ps.setString(5, student.getBranch());

            return ps.executeUpdate() > 0;
        }
    }

    // Login validation
    public Student login(String email, String password) throws SQLException {
        String sql = "SELECT * FROM students WHERE email = ? AND password = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, email);
            ps.setString(2, password);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    Student student = new Student();
                    student.setId(rs.getInt("id"));
                    student.setName(rs.getString("name"));
                    student.setEmail(rs.getString("email"));
                    student.setPhone(rs.getString("phone"));
                    student.setBranch(rs.getString("branch"));
                    return student;
                }
            }
        }
        return null;
    }

    // Check if email already exists
    public boolean emailExists(String email) throws SQLException {
        String sql = "SELECT id FROM students WHERE email = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, email);
            try (ResultSet rs = ps.executeQuery()) {
                return rs.next();
            }
        }
    }
}
