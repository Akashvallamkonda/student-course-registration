<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Register – Student Course Registration</title>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body {
            font-family: 'Segoe UI', sans-serif;
            background: #f0f4f8;
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 2rem 1rem;
        }
        .card {
            background: #fff;
            border-radius: 12px;
            box-shadow: 0 4px 24px rgba(0,0,0,0.08);
            padding: 2.5rem 2rem;
            width: 100%;
            max-width: 420px;
        }
        .logo { text-align: center; margin-bottom: 1.75rem; }
        .logo h1 { font-size: 22px; font-weight: 600; color: #1a1a2e; }
        .logo p  { font-size: 13px; color: #6b7280; margin-top: 4px; }
        .form-row { display: grid; grid-template-columns: 1fr 1fr; gap: 12px; }
        .form-group { margin-bottom: 1rem; }
        label { display: block; font-size: 13px; font-weight: 500; color: #374151; margin-bottom: 5px; }
        input[type="text"], input[type="email"],
        input[type="password"], input[type="tel"], select {
            width: 100%; padding: 10px 12px;
            border: 1px solid #d1d5db; border-radius: 8px;
            font-size: 14px; color: #1f2937;
            transition: border-color .2s; outline: none;
            background: #fff;
        }
        input:focus, select:focus {
            border-color: #3b82f6;
            box-shadow: 0 0 0 3px rgba(59,130,246,0.1);
        }
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
            font-size: 13px; color: #dc2626; margin-bottom: 1rem;
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
        <p>Create your student account</p>
    </div>

    <% if (request.getAttribute("error") != null) { %>
        <div class="error"><%= request.getAttribute("error") %></div>
    <% } %>

    <form action="${pageContext.request.contextPath}/register" method="post">
        <div class="form-row">
            <div class="form-group">
                <label for="name">Full name</label>
                <input type="text" id="name" name="name"
                       placeholder="Akash Kumar" required />
            </div>
            <div class="form-group">
                <label for="phone">Phone</label>
                <input type="tel" id="phone" name="phone"
                       placeholder="9876543210" required />
            </div>
        </div>
        <div class="form-group">
            <label for="email">Email address</label>
            <input type="email" id="email" name="email"
                   placeholder="you@example.com" required />
        </div>
        <div class="form-group">
            <label for="branch">Branch / Department</label>
            <select id="branch" name="branch" required>
                <option value="" disabled selected>Select your branch</option>
                <option>Computer Science Engineering</option>
                <option>Electronics and Communication Engineering</option>
                <option>Electrical Engineering</option>
                <option>Mechanical Engineering</option>
                <option>Civil Engineering</option>
                <option>Information Technology</option>
                <option>Other</option>
            </select>
        </div>
        <div class="form-row">
            <div class="form-group">
                <label for="password">Password</label>
                <input type="password" id="password" name="password"
                       placeholder="Min 6 characters" required />
            </div>
            <div class="form-group">
                <label for="confirmPassword">Confirm</label>
                <input type="password" id="confirmPassword" name="confirmPassword"
                       placeholder="Re-enter" required />
            </div>
        </div>
        <button type="submit" class="btn">Create account</button>
    </form>

    <hr class="divider">
    <div class="footer">
        Already have an account? <a href="${pageContext.request.contextPath}/login">Sign in</a>
    </div>
</div>
</body>
</html>
