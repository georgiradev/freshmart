<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <title>FreshMart &mdash; Sign In</title>
    <script>(function(){var t=localStorage.getItem('freshmart-theme')||'light';document.documentElement.setAttribute('data-theme',t);})();</script>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.7.0/css/all.css">
    <link rel="stylesheet" href="/css/theme.css">
    <style>
        :root {
            --green-dark:  #1b4332;
            --green-mid:   #40916c;
            --green-light: #74c69d;
            --cream:       #f8f5f0;
        }
        * { box-sizing: border-box; }
        html, body { height: 100%; margin: 0; }
        body {
            display: flex;
            font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, sans-serif;
            background: var(--cream);
        }

        /* ── Left panel ── */
        .panel-left {
            width: 45%;
            background: linear-gradient(145deg, var(--green-dark) 0%, var(--green-mid) 100%);
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            padding: 3rem;
            color: white;
        }
        .panel-left .brand-icon {
            font-size: 4rem;
            margin-bottom: 1rem;
        }
        .panel-left h1 {
            font-size: 2.2rem;
            font-weight: 700;
            letter-spacing: -0.5px;
            margin-bottom: .5rem;
        }
        .panel-left p {
            font-size: 1rem;
            opacity: .8;
            text-align: center;
            max-width: 280px;
        }
        .tagline-badges {
            display: flex;
            gap: .6rem;
            margin-top: 2rem;
            flex-wrap: wrap;
            justify-content: center;
        }
        .tagline-badges span {
            background: rgba(255,255,255,.15);
            border: 1px solid rgba(255,255,255,.3);
            border-radius: 20px;
            padding: .3rem .9rem;
            font-size: .8rem;
        }

        /* ── Right panel ── */
        .panel-right {
            flex: 1;
            display: flex;
            justify-content: center;
            align-items: center;
            padding: 2rem;
        }
        .login-card {
            width: 100%;
            max-width: 420px;
        }
        .login-card h2 {
            font-size: 1.8rem;
            font-weight: 700;
            color: var(--green-dark);
            margin-bottom: .25rem;
        }
        .login-card .subtitle {
            color: #6c757d;
            margin-bottom: 2rem;
            font-size: .95rem;
        }
        .form-group label {
            font-weight: 600;
            font-size: .85rem;
            color: #495057;
            text-transform: uppercase;
            letter-spacing: .5px;
        }
        .input-icon-wrap {
            position: relative;
        }
        .input-icon-wrap .fa {
            position: absolute;
            left: 14px;
            top: 50%;
            transform: translateY(-50%);
            color: #adb5bd;
            font-size: .95rem;
        }
        .input-icon-wrap input {
            padding-left: 2.6rem;
            border-radius: 10px;
            border: 1.5px solid #dee2e6;
            height: 48px;
            font-size: .95rem;
            transition: border-color .2s;
        }
        .input-icon-wrap input:focus {
            border-color: var(--green-mid);
            box-shadow: 0 0 0 3px rgba(64,145,108,.12);
            outline: none;
        }
        .btn-signin {
            background: linear-gradient(135deg, var(--green-mid), var(--green-dark));
            border: none;
            border-radius: 10px;
            height: 50px;
            font-size: 1rem;
            font-weight: 600;
            letter-spacing: .3px;
            color: white;
            width: 100%;
            transition: opacity .2s, transform .1s;
        }
        .btn-signin:hover { opacity: .9; transform: translateY(-1px); }
        .btn-signin:active { transform: translateY(0); }
        .divider {
            display: flex;
            align-items: center;
            gap: 1rem;
            margin: 1.5rem 0;
            color: #adb5bd;
            font-size: .8rem;
        }
        .divider::before, .divider::after {
            content: '';
            flex: 1;
            height: 1px;
            background: #dee2e6;
        }
        .register-link {
            text-align: center;
            font-size: .9rem;
            color: #6c757d;
        }
        .register-link a {
            color: var(--green-mid);
            font-weight: 600;
            text-decoration: none;
        }
        .register-link a:hover { text-decoration: underline; }
        .alert-error {
            background: #fff5f5;
            border: 1px solid #fed7d7;
            color: #c53030;
            border-radius: 10px;
            padding: .75rem 1rem;
            font-size: .9rem;
            margin-bottom: 1rem;
        }

        @media (max-width: 768px) {
            .panel-left { display: none; }
        }
    </style>
</head>
<body>

<button class="theme-toggle-float" id="themeToggle" aria-label="Toggle theme"><i class="fas fa-moon"></i></button>

<!-- Left decorative panel -->
<div class="panel-left">
    <div class="brand-icon">&#127807;</div>
    <h1>FreshMart</h1>
    <p>Your neighbourhood's premium online grocery store, delivering freshness to your door.</p>
    <div class="tagline-badges">
        <span>&#10003; Fresh Daily</span>
        <span>&#10003; Fast Delivery</span>
        <span>&#10003; Best Prices</span>
    </div>
</div>

<!-- Right login panel -->
<div class="panel-right">
    <div class="login-card">
        <h2>Welcome back</h2>
        <p class="subtitle">Sign in to your account to continue shopping.</p>

        <% if (request.getParameter("error") != null) { %>
        <div class="alert-error">
            <i class="fas fa-exclamation-circle mr-2"></i>
            Incorrect username or password. Please try again.
        </div>
        <% } %>

        <form action="/userloginvalidate" method="post">
            <div class="form-group">
                <label for="username">Username</label>
                <div class="input-icon-wrap">
                    <i class="fas fa-user"></i>
                    <input type="text" name="username" id="username"
                           placeholder="Enter your username" required class="form-control">
                </div>
            </div>
            <div class="form-group">
                <label for="password">Password</label>
                <div class="input-icon-wrap">
                    <i class="fas fa-lock"></i>
                    <input type="password" name="password" id="password"
                           placeholder="Enter your password" required class="form-control">
                </div>
            </div>

            <button type="submit" class="btn-signin mt-2">Sign In</button>
        </form>

        <div class="divider">or</div>
        <p class="register-link">
            Don't have an account? <a href="/register">Create one free</a>
        </p>
    </div>
</div>

<script src="/js/theme.js"></script>
</body>
</html>
