<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!doctype html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <script>(function(){var t=localStorage.getItem('freshmart-theme')||'light';document.documentElement.setAttribute('data-theme',t);})();</script>
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="icon" href="data:image/svg+xml,<svg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 100 100'><rect width='100' height='100' rx='20' fill='%231b4332'/><text y='.9em' font-size='80'>🌿</text></svg>">
  <title>Categories — FreshMart Admin</title>
  <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css"
        integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous">
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
      <a href="/admin/categories" class="sidebar-link active">
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
          <div class="topbar-title">Categories</div>
          <div class="topbar-sub">Manage product categories</div>
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
          <h5><i class="fas fa-tags adm-card-icon"></i>All Categories</h5>
          <button type="button" class="btn-adm btn-adm-primary" data-toggle="modal" data-target="#addCategoryModal">
            <i class="fas fa-plus"></i> Add Category
          </button>
        </div>
        <div class="admin-card-body">
          <c:choose>
            <c:when test="${empty categories}">
              <div class="adm-empty">
                <i class="fas fa-tags"></i>
                No categories yet. Add one to get started.
              </div>
            </c:when>
            <c:otherwise>
          <table class="admin-table">
            <thead>
              <tr>
                <th>ID</th>
                <th>Category Name</th>
                <th style="width:100px;">Actions</th>
              </tr>
            </thead>
            <tbody>
              <c:forEach var="category" items="${categories}">
              <tr>
                <td class="adm-id-cell">${category.id}</td>
                <td><strong>${category.name}</strong></td>
                <td>
                  <div class="adm-actions">
                    <button type="button" class="btn-adm btn-adm-warning btn-adm-sm"
                            data-toggle="modal" data-target="#updateCategoryModal"
                            data-cat-id="${category.id}" data-cat-name="${category.name}"
                            onclick="populateUpdate(this.dataset.catId, this.dataset.catName)">
                      <i class="fas fa-edit"></i> Edit
                    </button>
                    <form action="categories/delete" method="get"
                          onsubmit="return confirm('Delete this category?')">
                      <input type="hidden" name="id" value="${category.id}">
                      <button type="submit" class="btn-adm btn-adm-danger btn-adm-sm">
                        <i class="fas fa-trash"></i> Delete
                      </button>
                    </form>
                  </div>
                </td>
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

<!-- Add Category Modal -->
<div class="modal fade" id="addCategoryModal" tabindex="-1" role="dialog" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered" role="document">
    <div class="modal-content">
      <form action="categories" method="post">
        <div class="modal-header">
          <h5 class="modal-title"><i class="fas fa-plus adm-card-icon"></i>Add New Category</h5>
          <button type="button" class="close" data-dismiss="modal" aria-label="Close">
            <span aria-hidden="true">&times;</span>
          </button>
        </div>
        <div class="modal-body adm-form-body">
          <div class="adm-form-group">
            <label for="newCategoryName">Category Name</label>
            <input type="text" id="newCategoryName" name="categoryname" class="adm-input"
                   placeholder="e.g. Vegetables" required autofocus>
          </div>
        </div>
        <div class="modal-footer">
          <button type="button" class="btn-adm btn-adm-secondary" data-dismiss="modal">Cancel</button>
          <button type="submit" class="btn-adm btn-adm-primary">
            <i class="fas fa-save"></i> Save
          </button>
        </div>
      </form>
    </div>
  </div>
</div>

<!-- Update Category Modal -->
<div class="modal fade" id="updateCategoryModal" tabindex="-1" role="dialog" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered" role="document">
    <div class="modal-content">
      <form action="categories/update" method="get">
        <div class="modal-header">
          <h5 class="modal-title"><i class="fas fa-edit adm-card-icon"></i>Update Category</h5>
          <button type="button" class="close" data-dismiss="modal" aria-label="Close">
            <span aria-hidden="true">&times;</span>
          </button>
        </div>
        <div class="modal-body adm-form-body">
          <div class="adm-form-group">
            <label>ID</label>
            <input type="number" name="categoryid" id="updateCategoryId" class="adm-input" readonly>
          </div>
          <div class="adm-form-group">
            <label for="updateCategoryName">Category Name</label>
            <input type="text" id="updateCategoryName" name="categoryname" class="adm-input" required>
          </div>
        </div>
        <div class="modal-footer">
          <button type="button" class="btn-adm btn-adm-secondary" data-dismiss="modal">Cancel</button>
          <button type="submit" class="btn-adm btn-adm-primary">
            <i class="fas fa-save"></i> Update
          </button>
        </div>
      </form>
    </div>
  </div>
</div>

<script src="https://code.jquery.com/jquery-3.4.1.slim.min.js"
        integrity="sha384-J6qa4849blE2+poT4WnyKhv5vZF5SrPo0iEjwBvKU7imGFAV0wwj1yYfoRSJoZ+n" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js"
        integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js"
        integrity="sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6" crossorigin="anonymous"></script>
<script>
  function populateUpdate(id, name) {
    document.getElementById('updateCategoryId').value = id;
    document.getElementById('updateCategoryName').value = name;
  }
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
