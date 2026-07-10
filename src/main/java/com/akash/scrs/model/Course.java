package com.akash.scrs.model;

public class Course {

    private int id;
    private String title;
    private String description;
    private String instructor;
    private int duration;  // in weeks
    private int seats;

    public Course() {}

    public Course(String title, String description, String instructor, int duration, int seats) {
        this.title = title;
        this.description = description;
        this.instructor = instructor;
        this.duration = duration;
        this.seats = seats;
    }

    // Getters and Setters
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getTitle() { return title; }
    public void setTitle(String title) { this.title = title; }

    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }

    public String getInstructor() { return instructor; }
    public void setInstructor(String instructor) { this.instructor = instructor; }

    public int getDuration() { return duration; }
    public void setDuration(int duration) { this.duration = duration; }

    public int getSeats() { return seats; }
    public void setSeats(int seats) { this.seats = seats; }
}
