<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login – Student Course Registration</title>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body {
            font-family: 'Segoe UI', sans-serif;
            background: #f0f4f8;
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
        }
        .card {
            background: #fff;
            border-radius: 12px;
            box-shadow: 0 4px 24px rgba(0,0,0,0.08);
            padding: 2.5rem 2rem;
            width: 100%;
            max-width: 400px;
        }
        .logo {
            text-align: center;
            margin-bottom: 1.75rem;
        }
        .logo h1 { font-size: 22px; font-weight: 600; color: #1a1a2e; }
        .logo p  { font-size: 13px; color: #6b7280; margin-top: 4px; }
        .form-group { margin-bottom: 1rem; }
        label { display: block; font-size: 13px; font-weight: 500; color: #374151; margin-bottom: 5px; }
        input[type="email"], input[type="password"] {
            width: 100%; padding: 10px 12px;
            border: 1px solid #d1d5db; border-radius: 8px;
            font-size: 14px; color: #1f2937;
            transition: border-color .2s;
            outline: none;
        }
        input:focus { border-color: #3b82f6; box-shadow: 0 0 0 3px rgba(59,130,246,0.1); }
        .btn {
            width: 100%; padding: 11px;
            background: #2563eb; color: #fff;
            border: none; border-radius: 8px;
            font-size: 14px; font-weight: 500;
            cursor: pointer; margin-top: 0.5rem;
            transition: background .2s;
        }
        .btn:hover { background: #1d4ed8; }
        .error {
            background: #fef2f2; border: 1px solid #fecaca;
            border-radius: 8px; padding: 10px 12px;
            font-size: 13px; color: #dc2626;
            margin-bottom: 1rem;
        }
        .success {
            background: #f0fdf4; border: 1px solid #bbf7d0;
            border-radius: 8px; padding: 10px 12px;
            font-size: 13px; color: #16a34a;
            margin-bottom: 1rem;
        }
        .footer { text-align: center; margin-top: 1.25rem; font-size: 13px; color: #6b7280; }
        .footer a { color: #2563eb; text-decoration: none; font-weight: 500; }
        .footer a:hover { text-decoration: underline; }
        .divider { border: none; border-top: 1px solid #f3f4f6; margin: 1.5rem 0; }
    </style>
</head>
<body>
<div class="card">
    <div class="logo">
        <h1>&#127979; CourseReg</h1>
        <p>Student Course Registration System</p>
    </div>

    <% if (request.getParameter("success") != null) { %>
        <div class="success">Registration successful! Please login.</div>
    <% } %>

    <% if (request.getAttribute("error") != null) { %>
        <div class="error"><%= request.getAttribute("error") %></div>
    <% } %>

    <form action="${pageContext.request.contextPath}/login" method="post">
        <div class="form-group">
            <label for="email">Email address</label>
            <input type="email" id="email" name="email"
                   placeholder="you@example.com" required autofocus />
        </div>
        <div class="form-group">
            <label for="password">Password</label>
            <input type="password" id="password" name="password"
                   placeholder="Enter your password" required />
        </div>
        <button type="submit" class="btn">Sign in</button>
    </form>

    <hr class="divider">
    <div class="footer">
        Don't have an account? <a href="${pageContext.request.contextPath}/register">Register here</a>
    </div>
</div>
</body>
</html>
