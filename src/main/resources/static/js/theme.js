document.addEventListener('DOMContentLoaded', function () {
    var toggles = document.querySelectorAll('.theme-toggle, .theme-toggle-float');
    if (!toggles.length) return;

    function syncIcons() {
        var theme = document.documentElement.getAttribute('data-theme') || 'light';
        toggles.forEach(function (btn) {
            var icon = btn.querySelector('i');
            if (icon) {
                icon.className = theme === 'dark' ? 'fas fa-sun' : 'fas fa-moon';
            }
        });
    }

    syncIcons();

    toggles.forEach(function (btn) {
        btn.addEventListener('click', function () {
            var current = document.documentElement.getAttribute('data-theme') || 'light';
            var next = current === 'dark' ? 'light' : 'dark';
            document.documentElement.setAttribute('data-theme', next);
            localStorage.setItem('freshmart-theme', next);
            syncIcons();
        });
    });
});
