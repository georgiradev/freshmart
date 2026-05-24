<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!doctype html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <script>(function(){var t=localStorage.getItem('freshmart-theme')||'light';document.documentElement.setAttribute('data-theme',t);})();</script>
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="icon" href="data:image/svg+xml,<svg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 100 100'><rect width='100' height='100' rx='20' fill='%231b4332'/><text y='.9em' font-size='80'>🌿</text></svg>">
  <title>Customers — FreshMart Admin</title>
  <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.7.0/css/all.css"
        integrity="sha384-lZN37f5QGtY3VHgisS14W3ExzMWZxybE1SJSEsQp9S+oqd12jhcu+A56Ebc1zFSJ" crossorigin="anonymous">
  <link rel="stylesheet" href="/css/admin.css">
</head>
<body>
<div class="admin-wrapper">

  <!-- Sidebar -->
  <aside class="admin-sidebar" id="adminSidebar">
    <div class="sidebar-brand">
      <span class="brand-emoji">🌿</span>
      <div>
        <div class="brand-name">FreshMart</div>
        <div class="brand-sub">Admin Panel</div>
      </div>
    </div>
    <nav class="sidebar-nav">
      <div class="sidebar-section">Main</div>
      <a href="/admin/" class="sidebar-link">
        <i class="fas fa-tachometer-alt"></i> Dashboard
      </a>
      <div class="sidebar-section">Manage</div>
      <a href="/admin/products" class="sidebar-link">
        <i class="fas fa-box-open"></i> Products
      </a>
      <a href="/admin/categories" class="sidebar-link">
        <i class="fas fa-tags"></i> Categories
      </a>
      <a href="/admin/customers" class="sidebar-link active">
        <i class="fas fa-users"></i> Customers
      </a>
      <div class="sidebar-section">Account</div>
      <a href="/admin/profileDisplay" class="sidebar-link">
        <i class="fas fa-user-cog"></i> My Profile
      </a>
    </nav>
    <div class="sidebar-footer">FreshMart &copy; 2026</div>
  </aside>

  <!-- Main -->
  <div class="admin-main">
    <header class="admin-topbar">
      <div class="topbar-left">
        <button class="topbar-menu-btn" onclick="document.getElementById('adminSidebar').classList.toggle('open')" aria-label="Toggle menu">
          <i class="fas fa-bars"></i>
        </button>
        <div>
          <div class="topbar-title">Customers</div>
          <div class="topbar-sub">Registered customer accounts</div>
        </div>
      </div>
      <div class="topbar-right">
        <a href="/admin/profileDisplay" class="topbar-avatar" title="${username}">
          <img src="${not empty profileImage ? profileImage : '/images/default-avatar.svg'}" alt="${username}">
        </a>
        <span class="topbar-username">${username}</span>
        <button class="theme-toggle" aria-label="Toggle theme"><i class="fas fa-moon"></i></button>
        <a href="/admin/logout" class="btn-topbar-logout">
          <i class="fas fa-sign-out-alt"></i> Logout
        </a>
      </div>
    </header>

    <main class="admin-content">
      <div class="admin-card">
        <div class="admin-card-header">
          <h5><i class="fas fa-users adm-card-icon"></i>All Customers</h5>
        </div>
        <div class="admin-card-body">
          <c:choose>
            <c:when test="${empty customers}">
              <div class="adm-empty">
                <i class="fas fa-users"></i>
                No customers registered yet.
              </div>
            </c:when>
            <c:otherwise>
              <table class="admin-table">
                <thead>
                  <tr>
                    <th>Customer</th>
                    <th>Email</th>
                    <th>Address</th>
                  </tr>
                </thead>
                <tbody>
                  <c:forEach var="customer" items="${customers}">
                  <tr>
                    <td>
                      <div class="cust-cell">
                        <div class="cust-avatar"><i class="fas fa-user"></i></div>
                        <strong>${customer.username}</strong>
                      </div>
                    </td>
                    <td class="adm-muted">${customer.email}</td>
                    <td class="adm-muted">${customer.address}</td>
                  </tr>
                  </c:forEach>
                </tbody>
              </table>
            </c:otherwise>
          </c:choose>
        </div>
      </div>
    </main>
  </div>
</div>

<script>
  document.addEventListener('click', function(e) {
    var sidebar = document.getElementById('adminSidebar');
    if (sidebar.classList.contains('open') && !sidebar.contains(e.target)) {
      sidebar.classList.remove('open');
    }
  });
</script>
<script src="/js/theme.js"></script>
</body>
</html>
