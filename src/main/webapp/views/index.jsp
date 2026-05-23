<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <title>FreshMart &mdash; Shop Fresh</title>
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
            color: white;
            font-size: 1.5rem;
            font-weight: 700;
            letter-spacing: -0.3px;
            text-decoration: none;
        }
        .navbar-brand-text span { color: var(--green-light); }
        .nav-actions { display: flex; align-items: center; gap: .75rem; }
        .nav-user { color: rgba(255,255,255,.75); font-size: .9rem; }
        .nav-user strong { color: white; }
        .btn-nav {
            background: rgba(255,255,255,.12);
            border: 1px solid rgba(255,255,255,.25);
            color: white;
            border-radius: 8px;
            padding: .4rem .85rem;
            font-size: .84rem;
            text-decoration: none;
            transition: background .2s;
            white-space: nowrap;
        }
        .btn-nav:hover { background: rgba(255,255,255,.22); color: white; text-decoration: none; }
        .btn-nav-accent { background: var(--orange); border-color: var(--orange); }
        .btn-nav-accent:hover { background: #d4920a; border-color: #d4920a; }

        /* ── Hero ── */
        .hero {
            background: linear-gradient(135deg, var(--green-dark) 0%, var(--green-mid) 60%, #52b788 100%);
            color: white;
            padding: 3.5rem 2rem;
            text-align: center;
        }
        .hero h1 { font-size: 2.4rem; font-weight: 800; margin-bottom: .5rem; }
        .hero p { font-size: 1.05rem; opacity: .85; max-width: 480px; margin: 0 auto; }

        /* ── Section header ── */
        .section-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 1.5rem;
        }
        .section-header h2 { font-size: 1.4rem; font-weight: 700; color: var(--green-dark); margin: 0; }
        .product-count {
            background: var(--green-light);
            color: var(--green-dark);
            border-radius: 20px;
            padding: .25rem .75rem;
            font-size: .8rem;
            font-weight: 600;
        }

        /* ── Product cards ── */
        .products-grid { padding: 2.5rem 2rem; }
        .product-card {
            background: white;
            border-radius: 16px;
            overflow: hidden;
            box-shadow: 0 2px 12px rgba(0,0,0,.07);
            transition: transform .2s, box-shadow .2s;
            height: 100%;
            display: flex;
            flex-direction: column;
            margin-bottom: 1.5rem;
        }
        @media (hover: hover) {
            .product-card:hover {
                transform: translateY(-4px);
                box-shadow: 0 8px 28px rgba(0,0,0,.13);
            }
        }
        .product-img-wrap {
            background: #f0f4f0;
            height: 160px;
            overflow: hidden;
        }
        .product-img-wrap img {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }
        .product-body {
            padding: 1rem 1.1rem;
            flex: 1;
            display: flex;
            flex-direction: column;
        }
        .product-category {
            font-size: .72rem;
            font-weight: 700;
            text-transform: uppercase;
            letter-spacing: .6px;
            color: var(--green-mid);
            margin-bottom: .3rem;
        }
        .product-name {
            font-size: 1rem;
            font-weight: 700;
            color: #1a1a2e;
            margin-bottom: .4rem;
            line-height: 1.3;
        }
        .product-desc {
            font-size: .8rem;
            color: #868e96;
            flex: 1;
            margin-bottom: .8rem;
            line-height: 1.4;
        }
        .product-footer {
            display: flex;
            align-items: center;
            justify-content: space-between;
            border-top: 1px solid #f0f0f0;
            padding-top: .8rem;
        }
        .product-price { font-size: 1.2rem; font-weight: 800; color: var(--green-dark); }
        .product-price span { font-size: .75rem; font-weight: 500; color: #adb5bd; }
        .btn-cart {
            background: var(--green-mid);
            border: none;
            color: white;
            border-radius: 8px;
            padding: .4rem .85rem;
            font-size: .82rem;
            font-weight: 600;
            cursor: pointer;
            transition: background .2s;
        }
        .btn-cart:hover { background: var(--green-dark); }

        /* ── In-cart quantity stepper ── */
        .cart-stepper-wrap {
            display: flex; flex-direction: column; align-items: flex-end;
        }
        .qty-stepper {
            display: flex; align-items: center;
            background: #f4f4f4; border-radius: 8px; overflow: hidden;
        }
        .qty-btn {
            display: flex; align-items: center; justify-content: center;
            width: 34px; height: 34px;
            background: none; border: none;
            color: var(--green-dark); font-size: .85rem; font-weight: 700;
            text-decoration: none; transition: background .15s; flex-shrink: 0;
            cursor: pointer;
        }
        @media (hover: hover) {
            .qty-btn:hover { background: #e0e0e0; color: var(--green-dark); }
        }
        .qty-value {
            min-width: 28px; text-align: center;
            font-size: .88rem; font-weight: 700; color: #1a1a2e;
        }
        .in-cart-badge {
            font-size: .68rem; font-weight: 700; text-transform: uppercase;
            letter-spacing: .4px; color: var(--green-mid); display: block;
            margin-bottom: .15rem;
        }
        @media (max-width: 575px) {
            .product-price { font-size: 1rem; }
            .product-footer { flex-wrap: wrap; gap: .4rem; }
        }

        /* ── Empty state ── */
        .empty-state { text-align: center; padding: 5rem 1rem; color: #adb5bd; }
        .empty-state i { font-size: 3rem; margin-bottom: 1rem; display: block; }

        /* ── Footer ── */
        footer {
            background: var(--green-dark);
            color: rgba(255,255,255,.6);
            text-align: center;
            padding: 1.5rem;
            font-size: .85rem;
            margin-top: 2rem;
        }
        footer strong { color: white; }
    </style>
</head>
<body>

<nav class="navbar-custom">
    <a class="navbar-brand-text" href="/">Fresh<span>Mart</span></a>
    <div class="nav-actions">
        <div class="user-greeting">
            <a href="/profileDisplay" class="nav-avatar" title="My Profile">
                <img src="${not empty profileImage ? profileImage : '/images/default-avatar.svg'}" alt="avatar">
            </a>
            <span class="nav-user-text d-none d-sm-inline">Hello, <strong>${username}</strong></span>
        </div>
        <a href="/cart" class="btn-nav"><i class="fas fa-shopping-cart mr-1"></i><span class="d-none d-sm-inline">Cart</span></a>
        <a href="/logout" class="btn-nav btn-nav-accent"><i class="fas fa-sign-out-alt mr-1"></i><span class="d-none d-sm-inline">Logout</span></a>
        <button class="theme-toggle" id="themeToggle" aria-label="Toggle theme"><i class="fas fa-moon"></i></button>
    </div>
</nav>

<div class="hero">
    <h1>&#127807; Fresh Groceries, Delivered</h1>
    <p>Browse our hand-picked selection of fresh fruits, vegetables, meats, dairy and more.</p>
</div>

<div class="products-grid">
    <c:choose>
        <c:when test="${not empty products}">
            <div class="section-header">
                <h2>Today's Selection</h2>
                <span class="product-count">${products.size()} items</span>
            </div>
            <div class="row" style="row-gap: 1rem;">
                <c:forEach var="product" items="${products}">
                    <div class="col-6 col-md-4 col-lg-3" style="padding: 0 .75rem 1.25rem;">
                        <div class="product-card">
                            <div class="product-img-wrap">
                                <img src="${product.image}" alt="${product.name}">
                            </div>
                            <div class="product-body">
                                <div class="product-category">${product.category.name}</div>
                                <div class="product-name">${product.name}</div>
                                <div class="product-desc">${product.description}</div>
                                <div class="product-footer">
                                    <div class="product-price">
                                        ${currencySymbol}${product.price}<span> / ${product.weight}g</span>
                                    </div>
                                    <c:choose>
                                        <c:when test="${not empty cartMap[product.id]}">
                                            <%-- Product is in cart: show stepper --%>
                                            <div class="cart-stepper-wrap">
                                                <span class="in-cart-badge"><i class="fas fa-check-circle"></i> In cart</span>
                                                <div class="qty-stepper"
                                                     data-item-id="${cartMap[product.id].id}"
                                                     data-product-id="${product.id}">
                                                    <button type="button" class="qty-btn qty-decrease" title="Remove one">
                                                        <i class="fas fa-minus" style="font-size:.6rem;"></i>
                                                    </button>
                                                    <span class="qty-value">${cartMap[product.id].quantity}</span>
                                                    <button type="button" class="qty-btn qty-increase" title="Add one">
                                                        <i class="fas fa-plus" style="font-size:.6rem;"></i>
                                                    </button>
                                                </div>
                                            </div>
                                        </c:when>
                                        <c:otherwise>
                                            <%-- Not in cart: show Add to Cart button --%>
                                            <form class="add-to-cart-form" style="margin:0;" data-product-id="${product.id}">
                                                <button type="submit" class="btn-cart">
                                                    <i class="fas fa-cart-plus"></i>
                                                </button>
                                            </form>
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </c:when>
        <c:otherwise>
            <div class="empty-state">
                <i class="fas fa-box-open"></i>
                <p>No products available right now. Check back soon!</p>
            </div>
        </c:otherwise>
    </c:choose>
</div>

<footer>
    &copy; 2025 <strong>FreshMart</strong> &mdash; Fresh produce, delivered daily.
</footer>

<script src="https://code.jquery.com/jquery-3.4.1.slim.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js"></script>
<script src="/js/theme.js"></script>
<script>
(function () {
    // Attach stepper listeners (called on page load and after dynamic insertion)
    function attachSteppers(root) {
        (root || document).querySelectorAll('.qty-stepper').forEach(function (stepper) {
            if (stepper.dataset.bound) return;
            stepper.dataset.bound = '1';
            var itemId = stepper.dataset.itemId;
            var productId = stepper.dataset.productId;
            stepper.querySelector('.qty-increase').addEventListener('click', function () {
                updateQty(itemId, 'increase', stepper, productId);
            });
            stepper.querySelector('.qty-decrease').addEventListener('click', function () {
                updateQty(itemId, 'decrease', stepper, productId);
            });
        });
    }

    function updateQty(itemId, action, stepper, productId) {
        fetch('/cart/update?itemId=' + itemId + '&action=' + action)
            .then(function (r) { return r.json(); })
            .then(function (data) {
                if (data.removed) {
                    var stepperWrap = stepper.parentElement; // .cart-stepper-wrap
                    var footer = stepperWrap.parentElement;  // .product-footer
                    var form = document.createElement('form');
                    form.className = 'add-to-cart-form';
                    form.style.margin = '0';
                    form.dataset.productId = productId;
                    form.innerHTML = '<button type="submit" class="btn-cart"><i class="fas fa-cart-plus"></i></button>';
                    footer.replaceChild(form, stepperWrap);
                    attachAddToCart(form);
                } else {
                    stepper.querySelector('.qty-value').textContent = data.quantity;
                }
            });
    }

    function attachAddToCart(form) {
        var btn = form.querySelector('button');
        btn.addEventListener('click', function (e) {
            e.preventDefault();
            if (btn.disabled) return;
            var productId = form.dataset.productId;
            btn.disabled = true;
            fetch('/cart/add/ajax?productId=' + productId, { method: 'POST' })
                .then(function (r) { return r.json(); })
                .then(function (data) {
                    var footer = form.parentElement; // .product-footer
                    var stepperWrap = document.createElement('div');
                    stepperWrap.className = 'cart-stepper-wrap';
                    stepperWrap.innerHTML =
                        '<span class="in-cart-badge"><i class="fas fa-check-circle"></i> In cart</span>' +
                        '<div class="qty-stepper" data-item-id="' + data.itemId + '" data-product-id="' + productId + '">' +
                        '<button type="button" class="qty-btn qty-decrease" title="Remove one"><i class="fas fa-minus" style="font-size:.6rem;"></i></button>' +
                        '<span class="qty-value">' + data.quantity + '</span>' +
                        '<button type="button" class="qty-btn qty-increase" title="Add one"><i class="fas fa-plus" style="font-size:.6rem;"></i></button>' +
                        '</div>';
                    footer.replaceChild(stepperWrap, form);
                    attachSteppers(stepperWrap);
                });
        });
    }

    // Init
    attachSteppers();
    document.querySelectorAll('.add-to-cart-form').forEach(attachAddToCart);
})();
</script>
</body>
</html>
