# Online Student Course Registration System

A web-based application for student course registration and management built using **Java Servlets**, **JSP**, **JDBC**, and **PostgreSQL**.

---

## Tech Stack

| Layer | Technology |
|-------|-----------|
| Backend | Java Servlets (Jakarta EE) |
| Frontend | JSP (JavaServer Pages) + JSTL |
| Database | PostgreSQL 15 |
| DB Connectivity | JDBC |
| Build Tool | Maven |
| Server | Apache Tomcat 10 |
| Language | Java 11 |

---

## Project Structure

```
student-course-registration/
├── src/main/
│   ├── java/com/akash/scrs/
│   │   ├── model/
│   │   │   ├── Student.java            # Student POJO
│   │   │   └── Course.java             # Course POJO
│   │   ├── dao/
│   │   │   ├── StudentDAO.java         # DB operations for Student (JDBC)
│   │   │   └── CourseDAO.java          # DB operations for Course (JDBC)
│   │   ├── servlet/
│   │   │   ├── LoginServlet.java       # Handles login (GET + POST)
│   │   │   ├── RegisterServlet.java    # Handles registration
│   │   │   ├── DashboardServlet.java   # Shows enrolled courses
│   │   │   └── CourseServlet.java      # Enroll / Unenroll courses
│   │   └── util/
│   │       └── DBConnection.java       # JDBC connection utility
│   └── webapp/
│       ├── WEB-INF/web.xml
│       └── views/
│           ├── login.jsp
│           ├── register.jsp
│           ├── dashboard.jsp
│           └── courses.jsp
├── schema.sql                          # Database setup script
└── pom.xml
```

---

## Features

- Student registration with form validation
- Secure login with session management
- View all available courses
- Enroll and unenroll from courses
- Dashboard showing enrolled courses
- Duplicate enrollment prevention
- Centralised JDBC connection utility (DAO pattern)
- SQL injection prevention using PreparedStatement

---

## How to Run

### Prerequisites
- Java 11+
- PostgreSQL 15+
- Apache Tomcat 10+
- Maven 3.8+

### Steps

1. **Clone the repository**
   ```bash
   git clone https://github.com/akashvallamkonda/student-course-registration.git
   cd student-course-registration
   ```

2. **Set up the database**
   ```bash
   psql -U postgres -f schema.sql
   ```

3. **Update DB credentials in `DBConnection.java`**
   ```java
   private static final String USERNAME = "postgres";
   private static final String PASSWORD = "your_password";
   ```

4. **Build the project**
   ```bash
   mvn clean package
   ```

5. **Deploy to Tomcat**
   - Copy `target/student-course-registration-1.0.0.war` to Tomcat's `webapps/` folder
   - Start Tomcat: `./bin/startup.sh`

6. **Access the app**
   - Open: `http://localhost:8080/student-course-registration/login`

---

## Application Flow

```
Register → Login → Dashboard → Browse Courses → Enroll → Dashboard (updated)
```

---

## Database Schema

```sql
students      (id, name, email, password, phone, branch)
courses       (id, title, description, instructor, duration, seats)
enrollments   (id, student_id, course_id, enrolled_on)
```

---

## Author

**Akash Vallamkonda**
- GitHub: [github.com/akashvallamkonda](https://github.com/akashvallamkonda)
- LinkedIn: [linkedin.com/in/akashvallamkonda](https://linkedin.com/in/akashvallamkonda)
