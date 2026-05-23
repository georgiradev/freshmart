<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <link rel="icon" href="data:image/svg+xml,<svg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 100 100'><rect width='100' height='100' rx='20' fill='%231b4332'/><text y='.9em' font-size='80'>🌿</text></svg>">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <title>FreshMart &mdash; Create Account</title>
    <script>(function(){var t=localStorage.getItem('freshmart-theme')||'light';document.documentElement.setAttribute('data-theme',t);})();</script>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.7.0/css/all.css">
    <link rel="stylesheet" href="/css/theme.css">
    <style>
        :root {
            --green-dark:  #1b4332;
            --green-mid:   #40916c;
            --cream:       #f8f5f0;
        }
        body {
            font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, sans-serif;
            background: var(--cream);
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 2rem 1rem;
        }
        .register-card {
            background: white;
            border-radius: 20px;
            box-shadow: 0 8px 40px rgba(0,0,0,.1);
            padding: 2.5rem;
            width: 100%;
            max-width: 500px;
        }
        .brand-header {
            text-align: center;
            margin-bottom: 2rem;
        }
        .brand-header .icon {
            font-size: 2.5rem;
            display: block;
            margin-bottom: .5rem;
        }
        .brand-header h2 {
            font-size: 1.8rem;
            font-weight: 700;
            color: var(--green-dark);
            margin: 0;
        }
        .brand-header p {
            color: #6c757d;
            font-size: .9rem;
            margin: .25rem 0 0;
        }
        .form-group label {
            font-weight: 600;
            font-size: .82rem;
            color: #495057;
            text-transform: uppercase;
            letter-spacing: .5px;
            margin-bottom: .4rem;
        }
        .input-icon-wrap { position: relative; }
        .input-icon-wrap .fa {
            position: absolute;
            left: 13px;
            top: 50%;
            transform: translateY(-50%);
            color: #adb5bd;
            font-size: .9rem;
        }
        .input-icon-wrap textarea ~ .fa {
            top: 18px;
            transform: none;
        }
        .input-icon-wrap input,
        .input-icon-wrap textarea {
            padding-left: 2.5rem;
            border-radius: 10px;
            border: 1.5px solid #dee2e6;
            font-size: .95rem;
            transition: border-color .2s;
        }
        .input-icon-wrap input { height: 46px; }
        .input-icon-wrap input:focus,
        .input-icon-wrap textarea:focus {
            border-color: var(--green-mid);
            box-shadow: 0 0 0 3px rgba(64,145,108,.12);
            outline: none;
        }
        .btn-register {
            background: linear-gradient(135deg, var(--green-mid), var(--green-dark));
            border: none;
            border-radius: 10px;
            height: 50px;
            font-size: 1rem;
            font-weight: 600;
            color: white;
            width: 100%;
            transition: opacity .2s, transform .1s;
        }
        .btn-register:hover { opacity: .9; transform: translateY(-1px); color: white; }
        .login-link {
            text-align: center;
            font-size: .9rem;
            color: #6c757d;
            margin-top: 1.2rem;
        }
        .login-link a {
            color: var(--green-mid);
            font-weight: 600;
            text-decoration: none;
        }
        .login-link a:hover { text-decoration: underline; }
        .alert-error {
            background: #fff5f5;
            border: 1px solid #fed7d7;
            color: #c53030;
            border-radius: 10px;
            padding: .75rem 1rem;
            font-size: .9rem;
            margin-bottom: 1.2rem;
        }
        small.form-text { color: #868e96; font-size: .78rem; margin-top: .25rem; }
    </style>
</head>
<body>

<button class="theme-toggle-float" id="themeToggle" aria-label="Toggle theme"><i class="fas fa-moon"></i></button>

<div class="register-card">
    <div class="brand-header">
        <span class="icon">&#127807;</span>
        <h2>Create Account</h2>
        <p>Join FreshMart and start shopping fresh today.</p>
    </div>

    <c:if test="${not empty msg}">
        <div class="alert-error">
            <i class="fas fa-exclamation-circle mr-2"></i>${msg}
        </div>
    </c:if>

    <form action="/newuserregister" method="post">
        <div class="form-group">
            <label for="username">Username</label>
            <div class="input-icon-wrap">
                <i class="fas fa-user"></i>
                <input type="text" name="username" id="username"
                       placeholder="Choose a username" required class="form-control">
            </div>
        </div>
        <div class="form-group">
            <label for="email">Email Address</label>
            <div class="input-icon-wrap">
                <i class="fas fa-envelope"></i>
                <input type="email" name="email" id="email"
                       placeholder="you@example.com" required minlength="6" class="form-control">
            </div>
            <small class="form-text">We'll never share your email with anyone.</small>
        </div>
        <div class="form-group">
            <label for="password">Password</label>
            <div class="input-icon-wrap">
                <i class="fas fa-lock"></i>
                <input type="password" name="password" id="password"
                       placeholder="Create a password" required class="form-control">
            </div>
        </div>
        <div class="form-group">
            <label for="address">Delivery Address</label>
            <div class="input-icon-wrap">
                <i class="fas fa-map-marker-alt"></i>
                <textarea name="address" id="address" rows="2"
                          placeholder="Street, City, Postcode" class="form-control" style="padding-top:10px;"></textarea>
            </div>
        </div>

        <button type="submit" class="btn btn-register mt-1">Create Account</button>
    </form>

    <p class="login-link">Already have an account? <a href="/login">Sign in</a></p>
</div>

<script src="/js/theme.js"></script>
</body>
</html>
