<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.akash.scrs.model.Student" %>
<%@ page import="com.akash.scrs.model.Course" %>
<%@ page import="java.util.List" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dashboard – CourseReg</title>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body { font-family: 'Segoe UI', sans-serif; background: #f0f4f8; min-height: 100vh; }

        /* Navbar */
        .navbar {
            background: #fff; border-bottom: 1px solid #e5e7eb;
            padding: 0 2rem; display: flex;
            align-items: center; justify-content: space-between;
            height: 60px; position: sticky; top: 0; z-index: 10;
        }
        .navbar-brand { font-size: 18px; font-weight: 600; color: #1a1a2e; }
        .navbar-brand span { color: #2563eb; }
        .navbar-right { display: flex; align-items: center; gap: 16px; }
        .nav-link {
            font-size: 13px; color: #6b7280; text-decoration: none;
            padding: 6px 12px; border-radius: 6px; transition: background .15s;
        }
        .nav-link:hover { background: #f3f4f6; color: #111827; }
        .nav-link.active { background: #eff6ff; color: #2563eb; font-weight: 500; }
        .btn-logout {
            font-size: 13px; color: #dc2626; background: #fef2f2;
            border: 1px solid #fecaca; border-radius: 6px;
            padding: 6px 12px; cursor: pointer; text-decoration: none;
            transition: background .15s;
        }
        .btn-logout:hover { background: #fee2e2; }

        /* Main */
        .main { max-width: 960px; margin: 0 auto; padding: 2rem 1.5rem; }

        /* Welcome */
        .welcome {
            background: linear-gradient(135deg, #2563eb 0%, #1d4ed8 100%);
            border-radius: 12px; padding: 1.75rem 2rem;
            color: #fff; margin-bottom: 2rem;
        }
        .welcome h2 { font-size: 20px; font-weight: 600; margin-bottom: 4px; }
        .welcome p  { font-size: 14px; opacity: 0.85; }

        /* Stats */
        .stats { display: grid; grid-template-columns: repeat(auto-fit, minmax(160px,1fr)); gap: 12px; margin-bottom: 2rem; }
        .stat-card {
            background: #fff; border-radius: 10px;
            border: 1px solid #e5e7eb; padding: 1.25rem;
        }
        .stat-label { font-size: 12px; color: #6b7280; margin-bottom: 6px; text-transform: uppercase; letter-spacing: .5px; }
        .stat-value { font-size: 28px; font-weight: 600; color: #1a1a2e; }

        /* Section */
        .section-header {
            display: flex; align-items: center; justify-content: space-between;
            margin-bottom: 1rem;
        }
        .section-header h3 { font-size: 16px; font-weight: 600; color: #1a1a2e; }
        .btn-browse {
            background: #2563eb; color: #fff; border: none;
            border-radius: 8px; padding: 8px 16px; font-size: 13px;
            font-weight: 500; cursor: pointer; text-decoration: none;
            transition: background .2s;
        }
        .btn-browse:hover { background: #1d4ed8; }

        /* Course cards */
        .course-grid { display: grid; grid-template-columns: repeat(auto-fill, minmax(260px,1fr)); gap: 14px; }
        .course-card {
            background: #fff; border-radius: 10px;
            border: 1px solid #e5e7eb; padding: 1.25rem;
            transition: box-shadow .2s;
        }
        .course-card:hover { box-shadow: 0 4px 16px rgba(0,0,0,0.08); }
        .course-tag {
            display: inline-block; background: #eff6ff; color: #2563eb;
            font-size: 11px; font-weight: 500; padding: 3px 8px;
            border-radius: 20px; margin-bottom: 10px;
        }
        .course-title { font-size: 14px; font-weight: 600; color: #1a1a2e; margin-bottom: 4px; }
        .course-meta { font-size: 12px; color: #6b7280; margin-bottom: 12px; line-height: 1.6; }
        .btn-unenroll {
            width: 100%; padding: 7px; border: 1px solid #fecaca;
            background: #fef2f2; color: #dc2626; border-radius: 6px;
            font-size: 12px; font-weight: 500; cursor: pointer;
            transition: background .15s;
        }
        .btn-unenroll:hover { background: #fee2e2; }

        /* Empty state */
        .empty {
            background: #fff; border-radius: 10px; border: 1px solid #e5e7eb;
            padding: 3rem; text-align: center; color: #6b7280;
        }
        .empty-icon { font-size: 40px; margin-bottom: 12px; }
        .empty h4 { font-size: 15px; font-weight: 600; color: #374151; margin-bottom: 6px; }
        .empty p  { font-size: 13px; margin-bottom: 1.25rem; }

        /* Alerts */
        .alert { border-radius: 8px; padding: 10px 14px; font-size: 13px; margin-bottom: 1.25rem; }
        .alert-success { background: #f0fdf4; border: 1px solid #bbf7d0; color: #16a34a; }
        .alert-error   { background: #fef2f2; border: 1px solid #fecaca; color: #dc2626; }
    </style>
</head>
<body>

<%
    Student student = (Student) session.getAttribute("student");
    if (student == null) { response.sendRedirect(request.getContextPath() + "/login"); return; }
    List<Course> enrolledCourses = (List<Course>) request.getAttribute("enrolledCourses");
    String msg = (String) session.getAttribute("message");
    String err = (String) session.getAttribute("error");
    session.removeAttribute("message");
    session.removeAttribute("error");
%>

<!-- Navbar -->
<nav class="navbar">
    <div class="navbar-brand">&#127979; Course<span>Reg</span></div>
    <div class="navbar-right">
        <a href="${pageContext.request.contextPath}/dashboard" class="nav-link active">Dashboard</a>
        <a href="${pageContext.request.contextPath}/courses"   class="nav-link">Browse Courses</a>
        <a href="${pageContext.request.contextPath}/logout"    class="btn-logout">Sign out</a>
    </div>
</nav>

<!-- Main -->
<div class="main">

    <% if (msg != null) { %><div class="alert alert-success"><%= msg %></div><% } %>
    <% if (err != null) { %><div class="alert alert-error"><%= err %></div><% } %>

    <!-- Welcome -->
    <div class="welcome">
        <h2>Welcome back, <%= student.getName() %>!</h2>
        <p><%= student.getEmail() %> &nbsp;·&nbsp; <%= student.getBranch() != null ? student.getBranch() : "Student" %></p>
    </div>

    <!-- Stats -->
    <div class="stats">
        <div class="stat-card">
            <div class="stat-label">Enrolled courses</div>
            <div class="stat-value"><%= enrolledCourses != null ? enrolledCourses.size() : 0 %></div>
        </div>
        <div class="stat-card">
            <div class="stat-label">Total weeks</div>
            <div class="stat-value">
                <%
                    int totalWeeks = 0;
                    if (enrolledCourses != null)
                        for (Course c : enrolledCourses) totalWeeks += c.getDuration();
                    out.print(totalWeeks);
                %>
            </div>
        </div>
    </div>

    <!-- Enrolled Courses -->
    <div class="section-header">
        <h3>My Enrolled Courses</h3>
        <a href="${pageContext.request.contextPath}/courses" class="btn-browse">+ Browse Courses</a>
    </div>

    <% if (enrolledCourses == null || enrolledCourses.isEmpty()) { %>
        <div class="empty">
            <div class="empty-icon">&#128218;</div>
            <h4>No courses yet</h4>
            <p>Browse available courses and enrol to get started.</p>
            <a href="${pageContext.request.contextPath}/courses" class="btn-browse">Browse Courses</a>
        </div>
    <% } else { %>
        <div class="course-grid">
            <% for (Course course : enrolledCourses) { %>
            <div class="course-card">
                <span class="course-tag">Enrolled</span>
                <div class="course-title"><%= course.getTitle() %></div>
                <div class="course-meta">
                    &#128100; <%= course.getInstructor() %><br>
                    &#128336; <%= course.getDuration() %> weeks
                </div>
                <form action="${pageContext.request.contextPath}/courses" method="post">
                    <input type="hidden" name="action"   value="unenroll" />
                    <input type="hidden" name="courseId" value="<%= course.getId() %>" />
                    <button type="submit" class="btn-unenroll">Unenrol</button>
                </form>
            </div>
            <% } %>
        </div>
    <% } %>

</div>
</body>
</html>
