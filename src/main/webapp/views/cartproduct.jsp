<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <title>FreshMart &mdash; Your Cart</title>
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
        .page-wrap { max-width: 1020px; margin: 2.5rem auto; padding: 0 1.5rem; }
        .page-title {
            font-size: 1.8rem; font-weight: 800;
            color: var(--green-dark); margin-bottom: 1.5rem;
        }
        .page-title span { color: #adb5bd; font-size: 1rem; font-weight: 400; margin-left: .5rem; }

        /* ── Cart item card ── */
        .cart-item {
            background: white;
            border-radius: 14px;
            box-shadow: 0 2px 10px rgba(0,0,0,.07);
            display: flex;
            align-items: center;
            gap: 1.2rem;
            padding: 1rem 1.2rem;
            margin-bottom: 1rem;
            transition: box-shadow .2s;
        }
        @media (hover: hover) {
            .cart-item:hover { box-shadow: 0 4px 18px rgba(0,0,0,.11); }
        }
        .cart-item-img {
            width: 80px; height: 80px; border-radius: 10px;
            overflow: hidden; flex-shrink: 0; background: #f0f4f0;
        }
        .cart-item-img img { width: 100%; height: 100%; object-fit: cover; }
        .cart-item-info { flex: 1; min-width: 0; }
        .cart-item-category {
            font-size: .7rem; font-weight: 700; text-transform: uppercase;
            letter-spacing: .6px; color: var(--green-mid); margin-bottom: .15rem;
        }
        .cart-item-name { font-size: 1rem; font-weight: 700; color: #1a1a2e; }
        .cart-item-unit-price { font-size: .8rem; color: #adb5bd; margin-top: .1rem; }

        /* ── Quantity stepper ── */
        .qty-stepper {
            display: flex;
            align-items: center;
            gap: 0;
            background: #f4f4f4;
            border-radius: 10px;
            overflow: hidden;
            flex-shrink: 0;
        }
        .qty-btn {
            display: flex; align-items: center; justify-content: center;
            width: 34px; height: 34px;
            background: none; border: none;
            color: var(--green-dark); font-size: 1rem; font-weight: 700;
            text-decoration: none;
            transition: background .15s;
            cursor: pointer;
        }
        @media (hover: hover) {
            .qty-btn:hover { background: #e8e8e8; color: var(--green-dark); text-decoration: none; }
        }
        .qty-value {
            min-width: 36px; text-align: center;
            font-size: .95rem; font-weight: 700; color: #1a1a2e;
            padding: 0 .2rem;
        }

        /* ── Item subtotal ── */
        .cart-item-subtotal {
            font-size: 1.15rem; font-weight: 800;
            color: var(--green-dark); white-space: nowrap;
            min-width: 70px; text-align: right;
        }

        /* ── Remove button ── */
        .btn-remove {
            background: #fff0f0; border: 1px solid #ffc9c9;
            color: #e03131; border-radius: 8px;
            padding: .4rem .6rem; font-size: .8rem;
            text-decoration: none; white-space: nowrap;
            transition: background .2s; flex-shrink: 0;
        }
        @media (hover: hover) {
            .btn-remove:hover { background: #ffe3e3; color: #c92a2a; text-decoration: none; }
        }

        /* ── Summary panel ── */
        .summary-card {
            background: white;
            border-radius: 16px;
            box-shadow: 0 2px 12px rgba(0,0,0,.08);
            padding: 1.5rem;
            position: sticky;
            top: 80px;
        }
        .summary-card h3 { font-size: 1.1rem; font-weight: 700; color: var(--green-dark); margin-bottom: 1.2rem; }
        .summary-row {
            display: flex; justify-content: space-between;
            font-size: .9rem; color: #6c757d; margin-bottom: .6rem;
        }
        .summary-row.total {
            font-size: 1.15rem; font-weight: 800;
            color: var(--green-dark); border-top: 2px solid #f0f0f0;
            padding-top: .8rem; margin-top: .5rem;
        }
        .btn-checkout {
            background: linear-gradient(135deg, var(--green-mid), var(--green-dark));
            border: none; border-radius: 10px; height: 50px;
            font-size: 1rem; font-weight: 600; color: white;
            width: 100%; margin-top: 1rem;
            transition: opacity .2s, transform .1s; cursor: pointer;
        }
        @media (hover: hover) {
            .btn-checkout:hover { opacity: .9; transform: translateY(-1px); }
        }
        .btn-clear {
            display: block; text-align: center; margin-top: .75rem;
            color: #adb5bd; font-size: .82rem; text-decoration: none;
        }
        @media (hover: hover) {
            .btn-clear:hover { color: #e03131; text-decoration: none; }
        }

        /* ── Empty cart ── */
        .empty-cart {
            background: white; border-radius: 16px;
            box-shadow: 0 2px 12px rgba(0,0,0,.07);
            text-align: center; padding: 4rem 2rem;
            color: #adb5bd;
        }
        .empty-cart i { font-size: 3.5rem; margin-bottom: 1rem; display: block; }
        .empty-cart h3 { font-size: 1.2rem; color: #495057; margin-bottom: .5rem; }
        .empty-cart p { font-size: .9rem; margin-bottom: 1.5rem; }
        .btn-shop {
            display: inline-block;
            background: var(--green-mid); color: white;
            border: none; border-radius: 10px; padding: .65rem 1.5rem;
            font-size: .95rem; font-weight: 600; text-decoration: none;
            transition: background .2s;
        }
        .btn-shop:hover { background: var(--green-dark); color: white; text-decoration: none; }

        /* ── Mobile cart layout ── */
        @media (max-width: 575px) {
            .page-wrap { padding: 0 1rem; margin: 1.5rem auto; }
            .page-title { font-size: 1.4rem; }
            .cart-item {
                flex-wrap: wrap;
                padding: .85rem 1rem;
                gap: .6rem .75rem;
                align-items: center;
            }
            .cart-item-img { width: 58px; height: 58px; }
            /* Image + info fill the first row */
            .cart-item-info { flex: 1; min-width: calc(100% - 80px); }
            /* Stepper, subtotal, remove wrap to second row — push right */
            .qty-stepper { margin-left: auto; }
            .cart-item-subtotal { min-width: 0; font-size: 1rem; }
            .btn-remove { padding: .4rem .75rem; }
        }

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
        <div class="user-greeting">
            <a href="/profileDisplay" class="nav-avatar" title="My Profile">
                <img src="${not empty profileImage ? profileImage : '/images/default-avatar.svg'}" alt="avatar">
            </a>
            <span class="nav-user-text d-none d-sm-inline">Hello, <strong>${username}</strong></span>
        </div>
        <a href="/" class="btn-nav"><i class="fas fa-home mr-1"></i><span class="d-none d-sm-inline">Home</span></a>
        <a href="/logout" class="btn-nav btn-nav-accent"><i class="fas fa-sign-out-alt mr-1"></i><span class="d-none d-sm-inline">Logout</span></a>
        <button class="theme-toggle" id="themeToggle" aria-label="Toggle theme"><i class="fas fa-moon"></i></button>
    </div>
</nav>

<div class="page-wrap">
    <c:choose>
        <c:when test="${not empty cartItems}">
            <div class="row">
                <!-- Cart items -->
                <div class="col-lg-8">
                    <h1 class="page-title">
                        Your Cart
                        <span id="cart-item-count">${cartItemCount} item<c:if test="${cartItemCount != 1}">s</c:if></span>
                    </h1>

                    <c:forEach var="item" items="${cartItems}">
                        <div class="cart-item">
                            <div class="cart-item-img">
                                <img src="${item.product.image}" alt="${item.product.name}">
                            </div>
                            <div class="cart-item-info">
                                <div class="cart-item-category">${item.product.category.name}</div>
                                <div class="cart-item-name">${item.product.name}</div>
                                <div class="cart-item-unit-price">${currencySymbol}${item.product.price} each</div>
                            </div>

                            <!-- Quantity stepper -->
                            <div class="qty-stepper" data-item-id="${item.id}" data-price="${item.product.price}">
                                <button type="button" class="qty-btn qty-decrease" title="Remove one">
                                    <i class="fas fa-minus" style="font-size:.7rem;"></i>
                                </button>
                                <span class="qty-value">${item.quantity}</span>
                                <button type="button" class="qty-btn qty-increase" title="Add one">
                                    <i class="fas fa-plus" style="font-size:.7rem;"></i>
                                </button>
                            </div>

                            <!-- Row subtotal -->
                            <div class="cart-item-subtotal">${currencySymbol}${item.product.price * item.quantity}</div>

                            <!-- Remove entirely -->
                            <a href="/cart/remove?itemId=${item.id}" class="btn-remove"
                               title="Remove item">
                                <i class="fas fa-trash-alt"></i>
                            </a>
                        </div>
                    </c:forEach>
                </div>

                <!-- Order summary -->
                <div class="col-lg-4 mt-4 mt-lg-0">
                    <div class="summary-card">
                        <h3>Order Summary</h3>
                        <div class="summary-row">
                            <span id="summary-items-label">Items (${cartItemCount})</span>
                            <span id="summary-qty">${cartTotalItems} selected</span>
                        </div>
                        <div class="summary-row">
                            <span>Subtotal</span>
                            <span id="summary-subtotal">${currencySymbol}${cartTotal}</span>
                        </div>
                        <div class="summary-row">
                            <span>Delivery</span>
                            <span style="color:#40916c; font-weight:600;">Free</span>
                        </div>
                        <div class="summary-row total">
                            <span>Total</span>
                            <span id="summary-total">${currencySymbol}${cartTotal}</span>
                        </div>
                        <button class="btn-checkout">
                            <i class="fas fa-lock mr-2"></i>Proceed to Checkout
                        </button>
                        <a href="/cart/clear" class="btn-clear">
                            <i class="fas fa-times mr-1"></i>Clear cart
                        </a>
                    </div>
                </div>
            </div>
        </c:when>
        <c:otherwise>
            <div class="empty-cart">
                <i class="fas fa-shopping-cart"></i>
                <h3>Your cart is empty</h3>
                <p>Looks like you haven't added anything yet. Browse our fresh selection!</p>
                <a href="/" class="btn-shop">
                    <i class="fas fa-store mr-2"></i>Start Shopping
                </a>
            </div>
        </c:otherwise>
    </c:choose>
</div>

<footer>
    &copy; 2026 <strong>FreshMart</strong> &mdash; Fresh produce, delivered daily.
</footer>

<script src="https://code.jquery.com/jquery-3.4.1.slim.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js"></script>
<script src="/js/theme.js"></script>
<script>
(function () {
    var CURRENCY = '${currencySymbol}';

    document.querySelectorAll('.qty-stepper').forEach(function (stepper) {
        var itemId = stepper.dataset.itemId;
        stepper.querySelector('.qty-increase').addEventListener('click', function () {
            updateQty(itemId, 'increase', stepper);
        });
        stepper.querySelector('.qty-decrease').addEventListener('click', function () {
            updateQty(itemId, 'decrease', stepper);
        });
    });

    function updateQty(itemId, action, stepper) {
        fetch('/cart/update?itemId=' + itemId + '&action=' + action)
            .then(function (r) { return r.json(); })
            .then(function (data) {
                if (data.removed) {
                    stepper.closest('.cart-item').remove();
                } else {
                    stepper.querySelector('.qty-value').textContent = data.quantity;
                    stepper.closest('.cart-item').querySelector('.cart-item-subtotal').textContent =
                        CURRENCY + data.subtotal;
                }
                var el;
                el = document.getElementById('summary-items-label');
                if (el) el.textContent = 'Items (' + data.cartItemCount + ')';
                el = document.getElementById('summary-qty');
                if (el) el.textContent = data.cartTotalItems + ' selected';
                el = document.getElementById('summary-subtotal');
                if (el) el.textContent = CURRENCY + data.cartTotal;
                el = document.getElementById('summary-total');
                if (el) el.textContent = CURRENCY + data.cartTotal;
                el = document.getElementById('cart-item-count');
                if (el) el.textContent = data.cartItemCount + (data.cartItemCount === 1 ? ' item' : ' items');
                if (data.cartItemCount === 0) window.location.reload();
            });
    }
})();
</script>
</body>
</html>
