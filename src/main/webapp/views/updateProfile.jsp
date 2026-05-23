<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <title>FreshMart &mdash; My Profile</title>
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
            --orange:      #f0a500;
        }
        body {
            font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, sans-serif;
            background: var(--cream);
            margin: 0;
        }

        /* ── Navbar ── */
        .navbar-custom {
            background: var(--green-dark);
            padding: .8rem 2rem;
            position: sticky;
            top: 0;
            z-index: 100;
            box-shadow: 0 2px 12px rgba(0,0,0,.25);
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        .navbar-brand-text {
            color: white; font-size: 1.5rem; font-weight: 700;
            letter-spacing: -0.3px; text-decoration: none;
        }
        .navbar-brand-text span { color: var(--green-light); }
        .nav-actions { display: flex; align-items: center; gap: .75rem; }
        .btn-nav {
            background: rgba(255,255,255,.12);
            border: 1px solid rgba(255,255,255,.25);
            color: white; border-radius: 8px;
            padding: .4rem .85rem; font-size: .84rem;
            text-decoration: none; transition: background .2s;
        }
        .btn-nav:hover { background: rgba(255,255,255,.22); color: white; text-decoration: none; }
        .btn-nav-accent { background: var(--orange); border-color: var(--orange); }
        .btn-nav-accent:hover { background: #d4920a; border-color: #d4920a; }

        /* ── Page layout ── */
        .page-wrap {
            max-width: 560px;
            margin: 3rem auto;
            padding: 0 1.5rem;
        }

        /* ── Avatar ── */
        .avatar-wrap {
            text-align: center;
            margin-bottom: 2rem;
        }
        .avatar-circle {
            width: 90px; height: 90px;
            background: linear-gradient(135deg, var(--green-mid), var(--green-dark));
            border-radius: 50%;
            display: inline-flex; align-items: center; justify-content: center;
            font-size: 2.4rem; color: white;
            box-shadow: 0 4px 16px rgba(27,67,50,.3);
            margin-bottom: .75rem;
            overflow: hidden; cursor: pointer;
            position: relative;
        }
        .avatar-circle img { width: 100%; height: 100%; object-fit: cover; }
        .avatar-circle .avatar-overlay {
            position: absolute; inset: 0;
            background: rgba(0,0,0,.35);
            display: flex; align-items: center; justify-content: center;
            opacity: 0; transition: opacity .2s;
            font-size: 1rem;
        }
        .avatar-circle:hover .avatar-overlay { opacity: 1; }
        #photoInput { display: none; }
        .avatar-wrap h2 {
            font-size: 1.4rem; font-weight: 700; color: var(--green-dark); margin: 0;
        }
        .avatar-wrap p {
            font-size: .85rem; color: #868e96; margin: .2rem 0 0;
        }

        /* ── Card ── */
        .profile-card {
            background: white;
            border-radius: 20px;
            box-shadow: 0 4px 24px rgba(0,0,0,.08);
            padding: 2rem;
        }

        /* ── Form fields ── */
        .field-group {
            margin-bottom: 1.25rem;
        }
        .field-group label {
            font-size: .78rem; font-weight: 700; text-transform: uppercase;
            letter-spacing: .5px; color: #6c757d; margin-bottom: .4rem; display: block;
        }
        .input-icon-wrap {
            position: relative;
        }
        .input-icon-wrap i {
            position: absolute; left: .9rem; top: 50%; transform: translateY(-50%);
            color: #adb5bd; font-size: .9rem; pointer-events: none;
        }
        .input-icon-wrap.textarea-wrap i {
            top: .75rem; transform: none;
        }
        .input-icon-wrap input,
        .input-icon-wrap textarea {
            width: 100%; padding: .7rem .9rem .7rem 2.5rem;
            border: 1.5px solid #e9ecef; border-radius: 10px;
            font-size: .95rem; color: #212529;
            transition: border-color .2s, box-shadow .2s;
            background: #fafafa;
            outline: none;
            box-sizing: border-box;
        }
        .input-icon-wrap input:focus,
        .input-icon-wrap textarea:focus {
            border-color: var(--green-mid);
            box-shadow: 0 0 0 3px rgba(64,145,108,.12);
            background: white;
        }
        .input-icon-wrap textarea {
            resize: vertical; min-height: 90px;
            padding-top: .7rem;
        }

        /* ── Alert ── */
        .alert-success-custom {
            background: #d8f5e9; border: 1px solid #b2e8ce;
            color: #1b4332; border-radius: 10px;
            padding: .75rem 1rem; font-size: .88rem;
            margin-bottom: 1.25rem; display: flex; align-items: center; gap: .5rem;
        }
        .alert-error-custom {
            background: #fff3f3; border: 1px solid #ffc9c9;
            color: #c92a2a; border-radius: 10px;
            padding: .75rem 1rem; font-size: .88rem;
            margin-bottom: 1.25rem; display: flex; align-items: center; gap: .5rem;
        }

        /* ── Divider ── */
        .section-divider {
            border: none; border-top: 1.5px solid #f0f0f0;
            margin: 1.5rem 0;
        }
        .section-label {
            font-size: .78rem; font-weight: 700; text-transform: uppercase;
            letter-spacing: .5px; color: #adb5bd; margin-bottom: 1rem;
        }

        /* ── Button ── */
        .btn-save {
            background: linear-gradient(135deg, var(--green-mid), var(--green-dark));
            border: none; border-radius: 10px; height: 50px;
            font-size: 1rem; font-weight: 600; color: white;
            width: 100%; margin-top: .5rem;
            transition: opacity .2s, transform .1s; cursor: pointer;
        }
        .btn-save:hover { opacity: .9; transform: translateY(-1px); }

        footer {
            background: var(--green-dark); color: rgba(255,255,255,.6);
            text-align: center; padding: 1.5rem;
            font-size: .85rem; margin-top: 3rem;
        }
        footer strong { color: white; }
    </style>
</head>
<body>

<nav class="navbar-custom">
    <a class="navbar-brand-text" href="/">Fresh<span>Mart</span></a>
    <div class="nav-actions">
        <a href="/" class="btn-nav"><i class="fas fa-home mr-1"></i><span class="d-none d-sm-inline">Home</span></a>
        <a href="/cart" class="btn-nav"><i class="fas fa-shopping-cart mr-1"></i><span class="d-none d-sm-inline">Cart</span></a>
        <a href="/logout" class="btn-nav btn-nav-accent"><i class="fas fa-sign-out-alt mr-1"></i><span class="d-none d-sm-inline">Logout</span></a>
        <button class="theme-toggle" id="themeToggle" aria-label="Toggle theme"><i class="fas fa-moon"></i></button>
    </div>
</nav>

<div class="page-wrap">

    <div class="avatar-wrap">
        <div class="avatar-circle" onclick="document.getElementById('photoInput').click()" title="Click to change photo">
            <img src="${not empty profileImage ? profileImage : '/images/default-avatar.svg'}"
                 alt="Profile photo" id="avatarPreview">
            <div class="avatar-overlay"><i class="fas fa-camera"></i></div>
        </div>
        <h2>${username}</h2>
        <p>${email}</p>
        <small style="color:#adb5bd; font-size:.75rem;">Click photo to change</small>
    </div>

    <div class="profile-card">

        <c:if test="${not empty msg}">
            <c:choose>
                <c:when test="${msg == 'saved'}">
                    <div class="alert-success-custom">
                        <i class="fas fa-check-circle"></i> Profile updated successfully.
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="alert-error-custom">
                        <i class="fas fa-exclamation-circle"></i> ${msg}
                    </div>
                </c:otherwise>
            </c:choose>
        </c:if>

        <input type="file" id="photoInput" name="profilePhoto" accept="image/*" form="profileForm">
        <form id="profileForm" action="/updateProfile" method="post" enctype="multipart/form-data">
            <input type="hidden" name="userid" value="${userid}">

            <p class="section-label">Account Details</p>

            <div class="field-group">
                <label for="username">Username</label>
                <div class="input-icon-wrap">
                    <i class="fas fa-user"></i>
                    <input type="text" id="username" name="username" value="${username}" required placeholder="Your username">
                </div>
            </div>

            <div class="field-group">
                <label for="email">Email</label>
                <div class="input-icon-wrap">
                    <i class="fas fa-envelope"></i>
                    <input type="email" id="email" name="email" value="${email}" required placeholder="you@example.com">
                </div>
            </div>

            <div class="field-group">
                <label for="address">Delivery Address</label>
                <div class="input-icon-wrap textarea-wrap">
                    <i class="fas fa-map-marker-alt"></i>
                    <textarea id="address" name="address" placeholder="Enter your delivery address">${address}</textarea>
                </div>
            </div>

            <hr class="section-divider">
            <p class="section-label">Change Password</p>

            <div class="field-group">
                <label for="password">New Password</label>
                <div class="input-icon-wrap">
                    <i class="fas fa-lock"></i>
                    <input type="password" id="password" name="password" placeholder="Leave blank to keep current">
                </div>
            </div>

            <button type="submit" class="btn-save">
                <i class="fas fa-save mr-2"></i>Save Changes
            </button>
        </form>
    </div>
</div>

<footer>
    &copy; 2025 <strong>FreshMart</strong> &mdash; Fresh produce, delivered daily.
</footer>

<script src="https://code.jquery.com/jquery-3.4.1.slim.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js"></script>
<script src="/js/theme.js"></script>
<script>
document.getElementById('photoInput').addEventListener('change', function () {
    var file = this.files[0];
    if (!file) return;
    var reader = new FileReader();
    reader.onload = function (e) {
        document.getElementById('avatarPreview').src = e.target.result;
    };
    reader.readAsDataURL(file);
});
</script>
</body>
</html>
