<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!doctype html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <script>(function(){var t=localStorage.getItem('freshmart-theme')||'light';document.documentElement.setAttribute('data-theme',t);})();</script>
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="icon" href="data:image/svg+xml,<svg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 100 100'><rect width='100' height='100' rx='20' fill='%231b4332'/><text y='.9em' font-size='80'>🌿</text></svg>">
  <title>Dashboard — FreshMart Admin</title>
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
      <a href="/admin/" class="sidebar-link active">
        <i class="fas fa-tachometer-alt"></i> Dashboard
      </a>
      <div class="sidebar-section">Manage</div>
      <a href="/admin/products" class="sidebar-link">
        <i class="fas fa-box-open"></i> Products
      </a>
      <a href="/admin/categories" class="sidebar-link">
        <i class="fas fa-tags"></i> Categories
      </a>
      <a href="/admin/customers" class="sidebar-link">
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
          <div class="topbar-title">Dashboard</div>
          <div class="topbar-sub">Welcome back, ${username}</div>
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

      <!-- Stats -->
      <div class="stat-grid">
        <div class="stat-card">
          <div class="stat-icon stat-icon-green"><i class="fas fa-box-open"></i></div>
          <div>
            <div class="stat-num">${productCount}</div>
            <div class="stat-label">Products</div>
          </div>
        </div>
        <div class="stat-card">
          <div class="stat-icon stat-icon-blue"><i class="fas fa-tags"></i></div>
          <div>
            <div class="stat-num">${categoryCount}</div>
            <div class="stat-label">Categories</div>
          </div>
        </div>
        <div class="stat-card">
          <div class="stat-icon stat-icon-orange"><i class="fas fa-users"></i></div>
          <div>
            <div class="stat-num">${customerCount}</div>
            <div class="stat-label">Customers</div>
          </div>
        </div>
      </div>

      <!-- Quick actions -->
      <div style="margin-bottom:.75rem">
        <span style="font-size:.8rem;font-weight:700;text-transform:uppercase;letter-spacing:.07em;color:#6c757d;">Quick Actions</span>
      </div>
      <div class="qa-grid">
        <a href="/admin/products" class="qa-card">
          <div class="qa-icon" style="background:#d8f3dc;color:#1b4332;"><i class="fas fa-seedling"></i></div>
          <h6>Products</h6>
          <p>Add, edit or remove products</p>
        </a>
        <a href="/admin/products/add" class="qa-card">
          <div class="qa-icon" style="background:#dbeafe;color:#1e40af;"><i class="fas fa-plus-circle"></i></div>
          <h6>Add Product</h6>
          <p>List a new product for sale</p>
        </a>
        <a href="/admin/categories" class="qa-card">
          <div class="qa-icon" style="background:#fef9c3;color:#92400e;"><i class="fas fa-layer-group"></i></div>
          <h6>Categories</h6>
          <p>Manage product categories</p>
        </a>
        <a href="/admin/customers" class="qa-card">
          <div class="qa-icon" style="background:#ffe8d6;color:#9c4a1a;"><i class="fas fa-user-friends"></i></div>
          <h6>Customers</h6>
          <p>View registered customers</p>
        </a>
        <a href="/" class="qa-card">
          <div class="qa-icon" style="background:#ede9fe;color:#5b21b6;"><i class="fas fa-external-link-alt"></i></div>
          <h6>View Store</h6>
          <p>Go to the customer-facing site</p>
        </a>
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
