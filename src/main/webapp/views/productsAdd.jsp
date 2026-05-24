<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!doctype html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <script>(function(){var t=localStorage.getItem('freshmart-theme')||'light';document.documentElement.setAttribute('data-theme',t);})();</script>
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="icon" href="data:image/svg+xml,<svg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 100 100'><rect width='100' height='100' rx='20' fill='%231b4332'/><text y='.9em' font-size='80'>🌿</text></svg>">
  <title>Add Product — FreshMart Admin</title>
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
      <a href="/admin/products" class="sidebar-link active">
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
          <div class="topbar-title">Add Product</div>
          <div class="topbar-sub">Create a new product listing</div>
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
      <div class="admin-card adm-form-card">
        <div class="admin-card-header">
          <h5><i class="fas fa-plus adm-card-icon"></i>New Product</h5>
          <a href="/admin/products" class="btn-adm btn-adm-secondary">
            <i class="fas fa-arrow-left"></i> Back
          </a>
        </div>
        <div class="admin-card-body adm-form-body">
          <form action="/admin/products/add" method="post">
            <div class="form-grid">
              <!-- Left column -->
              <div>
                <div class="adm-form-group">
                  <label for="pName">Product Name</label>
                  <input type="text" id="pName" name="name" class="adm-input"
                         placeholder="e.g. Organic Apples" required>
                </div>
                <div class="adm-form-group">
                  <label for="pCategory">Category</label>
                  <select id="pCategory" name="categoryid" class="adm-input" required>
                    <option value="" disabled selected>Select a category</option>
                    <c:forEach var="category" items="${categories}">
                      <option value="${category.id}">${category.name}</option>
                    </c:forEach>
                  </select>
                </div>
                <div class="adm-form-group">
                  <label for="pPrice">Price (${currencySymbol})</label>
                  <input type="number" id="pPrice" name="price" class="adm-input"
                         placeholder="0" min="1" required>
                </div>
                <div class="adm-form-group">
                  <label for="pWeight">Weight (grams)</label>
                  <input type="number" id="pWeight" name="weight" class="adm-input"
                         placeholder="0" min="1" required>
                </div>
                <div class="adm-form-group">
                  <label for="pQuantity">Available Quantity</label>
                  <input type="number" id="pQuantity" name="quantity" class="adm-input"
                         placeholder="0" min="1" required>
                </div>
              </div>
              <!-- Right column -->
              <div>
                <div class="adm-form-group">
                  <label for="pDescription">Description</label>
                  <textarea id="pDescription" name="description" class="adm-input"
                            rows="4" placeholder="Describe this product..."></textarea>
                </div>
                <div class="adm-form-group">
                  <label for="pImage">Image URL</label>
                  <input type="text" id="pImage" name="productImage" class="adm-input"
                         placeholder="/images/products/apple.svg" required
                         oninput="var p=document.getElementById('imgPreview'); p.style.display='block'; p.src=this.value||''">
                </div>
                <div class="adm-img-preview">
                  <img id="imgPreview" src="" alt="Preview"
                       onerror="this.style.display='none'">
                </div>
              </div>
            </div>

            <div class="adm-form-footer">
              <button type="submit" class="btn-adm btn-adm-primary">
                <i class="fas fa-save"></i> Save Product
              </button>
              <a href="/admin/products" class="btn-adm btn-adm-secondary">
                Cancel
              </a>
            </div>
          </form>
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
