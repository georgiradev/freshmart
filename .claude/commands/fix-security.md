# /fix-security

Audit and fix security issues in this Spring Boot e-commerce project.

**Usage:** `/fix-security [scope]`

Scope options: `passwords`, `validation`, `xss`, `csrf`, `all` (default: `all`)

## Current Security Posture

### Passwords — RESOLVED
- BCrypt via `DelegatingPasswordEncoder`
- Seed data in Flyway uses `{noop}` prefix (plain-text wrapped for migration only)
- New registrations are hashed via `PasswordEncoder` in `UserService`
- `PasswordEncoderConfig.java` holds the `PasswordEncoder` bean (avoids circular dep)

### Raw JDBC — RESOLVED
- Old `AdminController.profileDisplay` raw JDBC has been replaced with service layer calls
- All DB access goes through `JpaRepository` DAOs → services → controllers

### CSRF — INTENTIONALLY DISABLED
- Both security chains have CSRF disabled
- Acceptable for an internal/demo application
- To enable: add `<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>` to every JSP form

## Remaining Issues to Address

### 1. Input Validation (`validation`)
- Entities have no `@NotBlank`, `@Size`, `@Email`, `@Min` constraints
- Controllers don't use `@Valid` + `BindingResult`
- Fix: add Bean Validation annotations to entity fields, add `@Valid` to controller params

### 2. XSS in JSP (`xss`)
- Some JSP views output `${variable}` without escaping
- Fix: use `<c:out value="${variable}"/>` for user-supplied content, or ensure JSTL EL escaping is on

### 3. Sensitive Data Exposure
- Admin panel at `/admin/**` is protected but no rate limiting on login endpoints
- Profile images are stored as base64 strings in DB — large payloads possible

## After Fixing
- Run `mvn test` to ensure nothing broke
- Test login flows: admin login (`admin/123`), user login (`lisa/765`), registration
- Test cart add/update with invalid product IDs
- Test admin CRUD with boundary inputs
