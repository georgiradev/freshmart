<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!doctype html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <script>(function(){var t=localStorage.getItem('freshmart-theme')||'light';document.documentElement.setAttribute('data-theme',t);})();</script>
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="icon" href="data:image/svg+xml,<svg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 100 100'><rect width='100' height='100' rx='20' fill='%231b4332'/><text y='.9em' font-size='80'>🌿</text></svg>">
  <title>Admin Login — FreshMart</title>
  <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.7.0/css/all.css"
        integrity="sha384-lZN37f5QGtY3VHgisS14W3ExzMWZxybE1SJSEsQp9S+oqd12jhcu+A56Ebc1zFSJ" crossorigin="anonymous">
  <link rel="stylesheet" href="/css/admin.css">
</head>
<body class="login-page">
<button class="theme-toggle-float" aria-label="Toggle theme"><i class="fas fa-moon"></i></button>

<div class="login-card">
  <div class="login-logo">
    <div class="logo-emoji">🌿</div>
    <div class="logo-name">FreshMart</div>
    <div class="logo-sub">Admin Portal</div>
  </div>

  <h2>Sign in to continue</h2>

  <form action="/admin/loginvalidate" method="post">
    <div class="adm-form-group">
      <label for="username">Username</label>
      <div class="login-input-wrap">
        <i class="fas fa-user input-icon"></i>
        <input type="text" id="username" name="username" class="adm-input"
               placeholder="Admin username" required autofocus>
      </div>
    </div>
    <div class="adm-form-group">
      <label for="password">Password</label>
      <div class="login-input-wrap">
        <i class="fas fa-lock input-icon"></i>
        <input type="password" id="password" name="password" class="adm-input"
               placeholder="Admin password" required>
      </div>
    </div>
    <button type="submit" class="btn-login">
      <i class="fas fa-sign-in-alt"></i>&nbsp; Sign In
    </button>
    <div class="login-error">${msg}</div>
  </form>
</div>

<script src="/js/theme.js"></script>
</body>
</html>
