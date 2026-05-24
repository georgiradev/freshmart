<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!doctype html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="icon" href="data:image/svg+xml,<svg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 100 100'><rect width='100' height='100' rx='20' fill='%231b4332'/><text y='.9em' font-size='80'>🌿</text></svg>">
  <title>403 — Access Denied</title>
  <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.7.0/css/all.css"
        integrity="sha384-lZN37f5QGtY3VHgisS14W3ExzMWZxybE1SJSEsQp9S+oqd12jhcu+A56Ebc1zFSJ" crossorigin="anonymous">
  <style>
    * { box-sizing: border-box; margin: 0; padding: 0; }
    body {
      font-family: 'Segoe UI', system-ui, sans-serif;
      background: #f8f5f0;
      min-height: 100vh;
      display: flex;
      align-items: center;
      justify-content: center;
      padding: 1.5rem;
    }
    .card {
      background: #fff;
      border-radius: 14px;
      box-shadow: 0 4px 20px rgba(0,0,0,.08);
      padding: 3rem 2.5rem;
      text-align: center;
      max-width: 460px;
      width: 100%;
    }
    .icon-wrap {
      width: 72px; height: 72px;
      background: #fff5f5; border-radius: 50%;
      display: flex; align-items: center; justify-content: center;
      margin: 0 auto 1.5rem;
      font-size: 2rem; color: #dc3545;
    }
    .code { font-size: 5rem; font-weight: 800; color: #1b4332; line-height: 1; }
    h1 { font-size: 1.25rem; font-weight: 600; margin: .75rem 0 .5rem; }
    p { color: #6c757d; font-size: .9rem; margin-bottom: 1.75rem; line-height: 1.6; }
    .btn-home {
      display: inline-flex; align-items: center; gap: .4rem;
      padding: .6rem 1.5rem;
      background: #1b4332; color: #fff;
      border-radius: 8px; text-decoration: none;
      font-size: .9rem; font-weight: 500;
      transition: background .15s;
    }
    .btn-home:hover { background: #2d6a4f; color: #fff; text-decoration: none; }
    .btn-back {
      display: inline-flex; align-items: center; gap: .4rem;
      padding: .6rem 1.5rem;
      background: transparent; color: #6c757d;
      border: 1px solid #dee2e6;
      border-radius: 8px; text-decoration: none;
      font-size: .9rem; font-weight: 500;
      margin-left: .75rem;
      transition: all .15s;
    }
    .btn-back:hover { background: #f8f9fa; color: #495057; text-decoration: none; }
  </style>
</head>
<body>
  <div class="card">
    <div class="icon-wrap"><i class="fas fa-lock"></i></div>
    <div class="code">403</div>
    <h1>Access Denied</h1>
    <p>You don't have permission to view this page.<br>Please contact an administrator if you think this is a mistake.</p>
    <a href="/" class="btn-home"><i class="fas fa-home"></i> Go to Home</a>
    <a href="javascript:history.back()" class="btn-back"><i class="fas fa-arrow-left"></i> Go Back</a>
  </div>
</body>
</html>
