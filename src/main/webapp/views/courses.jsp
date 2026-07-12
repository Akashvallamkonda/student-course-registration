<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.akash.scrs.model.Student" %>
<%@ page import="com.akash.scrs.model.Course" %>
<%@ page import="java.util.List" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Browse Courses – CourseReg</title>
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
        }

        /* Main */
        .main { max-width: 960px; margin: 0 auto; padding: 2rem 1.5rem; }
        .page-header { margin-bottom: 1.5rem; }
        .page-header h2 { font-size: 20px; font-weight: 600; color: #1a1a2e; }
        .page-header p  { font-size: 14px; color: #6b7280; margin-top: 4px; }

        /* Search */
        .search-bar {
            display: flex; gap: 10px; margin-bottom: 1.5rem;
        }
        .search-bar input {
            flex: 1; padding: 10px 14px; border: 1px solid #d1d5db;
            border-radius: 8px; font-size: 14px; outline: none;
            transition: border-color .2s;
        }
        .search-bar input:focus {
            border-color: #3b82f6;
            box-shadow: 0 0 0 3px rgba(59,130,246,0.1);
        }

        /* Course grid */
        .course-grid { display: grid; grid-template-columns: repeat(auto-fill, minmax(270px,1fr)); gap: 16px; }
        .course-card {
            background: #fff; border-radius: 12px;
            border: 1px solid #e5e7eb; padding: 1.5rem;
            transition: box-shadow .2s, transform .2s;
        }
        .course-card:hover { box-shadow: 0 6px 20px rgba(0,0,0,0.08); transform: translateY(-2px); }
        .course-header { display: flex; align-items: flex-start; justify-content: space-between; margin-bottom: 10px; }
        .course-icon {
            width: 42px; height: 42px; border-radius: 10px;
            background: #eff6ff; display: flex; align-items: center;
            justify-content: center; font-size: 20px; flex-shrink: 0;
        }
        .seats-badge {
            font-size: 11px; background: #f0fdf4; color: #16a34a;
            border: 1px solid #bbf7d0; border-radius: 20px;
            padding: 3px 8px; font-weight: 500;
        }
        .course-title { font-size: 15px; font-weight: 600; color: #1a1a2e; margin-bottom: 6px; }
        .course-desc  { font-size: 13px; color: #6b7280; line-height: 1.6; margin-bottom: 12px; min-height: 40px; }
        .course-meta  {
            display: flex; gap: 12px; font-size: 12px; color: #9ca3af;
            margin-bottom: 14px; padding-top: 10px;
            border-top: 1px solid #f3f4f6;
        }
        .meta-item { display: flex; align-items: center; gap: 4px; }
        .btn-enroll {
            width: 100%; padding: 9px;
            background: #2563eb; color: #fff;
            border: none; border-radius: 8px;
            font-size: 13px; font-weight: 500;
            cursor: pointer; transition: background .2s;
        }
        .btn-enroll:hover { background: #1d4ed8; }
        .btn-enrolled {
            width: 100%; padding: 9px;
            background: #f0fdf4; color: #16a34a;
            border: 1px solid #bbf7d0; border-radius: 8px;
            font-size: 13px; font-weight: 500; cursor: default;
        }

        /* Alert */
        .alert { border-radius: 8px; padding: 10px 14px; font-size: 13px; margin-bottom: 1.25rem; }
        .alert-success { background: #f0fdf4; border: 1px solid #bbf7d0; color: #16a34a; }
        .alert-error   { background: #fef2f2; border: 1px solid #fecaca; color: #dc2626; }

        /* Empty */
        .empty { text-align: center; padding: 3rem; color: #6b7280; }
    </style>
</head>
<body>

<%
    Student student = (Student) session.getAttribute("student");
    if (student == null) { response.sendRedirect(request.getContextPath() + "/login"); return; }
    List<Course> courses = (List<Course>) request.getAttribute("courses");
    String err = (String) request.getAttribute("error");
%>

<!-- Navbar -->
<nav class="navbar">
    <div class="navbar-brand">&#127979; Course<span>Reg</span></div>
    <div class="navbar-right">
        <a href="${pageContext.request.contextPath}/dashboard" class="nav-link">Dashboard</a>
        <a href="${pageContext.request.contextPath}/courses"   class="nav-link active">Browse Courses</a>
        <a href="${pageContext.request.contextPath}/logout"    class="btn-logout">Sign out</a>
    </div>
</nav>

<!-- Main -->
<div class="main">

    <% if (err != null) { %><div class="alert alert-error"><%= err %></div><% } %>

    <div class="page-header">
        <h2>Available Courses</h2>
        <p>Browse and enrol in courses to start learning</p>
    </div>

    <!-- Search -->
    <div class="search-bar">
        <input type="text" id="searchInput" placeholder="Search courses by title or instructor..." oninput="filterCourses()" />
    </div>

    <!-- Courses -->
    <% if (courses == null || courses.isEmpty()) { %>
        <div class="empty">
            <p style="font-size:36px; margin-bottom:12px">&#128218;</p>
            <p>No courses available at the moment.</p>
        </div>
    <% } else { %>
        <div class="course-grid" id="courseGrid">
            <% String[] icons = {"&#128187;","&#9881;","&#128190;","&#127760;","&#128279;"}; int idx=0;
               for (Course course : courses) { %>
            <div class="course-card" data-title="<%= course.getTitle().toLowerCase() %>" data-instructor="<%= course.getInstructor().toLowerCase() %>">
                <div class="course-header">
                    <div class="course-icon"><%= icons[idx % icons.length] %></div>
                    <span class="seats-badge"><%= course.getSeats() %> seats</span>
                </div>
                <div class="course-title"><%= course.getTitle() %></div>
                <div class="course-desc"><%= course.getDescription() %></div>
                <div class="course-meta">
                    <span class="meta-item">&#128100; <%= course.getInstructor() %></span>
                    <span class="meta-item">&#128336; <%= course.getDuration() %> weeks</span>
                </div>
                <form action="${pageContext.request.contextPath}/courses" method="post">
                    <input type="hidden" name="action"   value="enroll" />
                    <input type="hidden" name="courseId" value="<%= course.getId() %>" />
                    <button type="submit" class="btn-enroll">Enrol now</button>
                </form>
            </div>
            <% idx++; } %>
        </div>
    <% } %>
</div>

<script>
function filterCourses() {
    const q = document.getElementById('searchInput').value.toLowerCase();
    document.querySelectorAll('.course-card').forEach(card => {
        const match = card.dataset.title.includes(q) || card.dataset.instructor.includes(q);
        card.style.display = match ? '' : 'none';
    });
}
</script>
</body>
</html>
