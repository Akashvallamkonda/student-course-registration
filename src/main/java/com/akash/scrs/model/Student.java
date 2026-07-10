package com.akash.scrs.model;

public class Student {

    private int id;
    private String name;
    private String email;
    private String password;
    private String phone;
    private String branch;

    public Student() {}

    public Student(String name, String email, String password, String phone, String branch) {
        this.name = name;
        this.email = email;
        this.password = password;
        this.phone = phone;
        this.branch = branch;
    }

    // Getters and Setters
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getName() { return name; }
    public void setName(String name) { this.name = name; }

    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }

    public String getPassword() { return password; }
    public void setPassword(String password) { this.password = password; }

    public String getPhone() { return phone; }
    public void setPhone(String phone) { this.phone = phone; }

    public String getBranch() { return branch; }
    public void setBranch(String branch) { this.branch = branch; }

    @Override
    public String toString() {
        return "Student{id=" + id + ", name='" + name + "', email='" + email + "'}";
    }
}
