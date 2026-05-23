# /fix-security

Audit and fix security issues in this Spring Boot e-commerce project.

**Usage:** `/fix-security [scope]`

Scope can be: `passwords`, `validation`, `jdbc`, `csrf`, `all` (default: `all`)

## Known Issues to Address

### 1. Plain-text Passwords (`passwords`)
- Location: `UserService.java` — `addUser()` saves password as-is
- Location: `UserDao.java` — `getUser()` compares plain text
- Fix: inject `BCryptPasswordEncoder` (already a bean in `SecurityConfiguration`) into `UserService`, hash on save, use `passwordEncoder.matches()` on login
- Also update `basedata.sql` seed passwords to BCrypt hashes

### 2. Raw JDBC with Hardcoded Credentials (`jdbc`)
- Location: `AdminController.java` — `profileDisplay()` and `updateUserProfile()`
- Fix: remove raw JDBC code, route through `UserService.getUserByUsername()` and a new `UserService.updateUser()` method
- The `UserDao` already has `getUserByUsername()` — just wire it up

### 3. Input Validation (`validation`)
- Add Bean Validation to entity fields: `@NotBlank`, `@Size`, `@Email`, `@Min`
- Add `@Valid` to controller method parameters
- Add `BindingResult` handling and redirect with error messages

### 4. CSRF (`csrf`)
- Evaluate whether to enable CSRF (requires `<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>` in every JSP form)
- Or document why it's intentionally disabled (e.g., internal tool)

### 5. SQL Injection in JDBC (`jdbc`)
- Same JDBC code in AdminController uses string concatenation
- Fix by removing that code (covered by item 2)

## After Fixing
- Re-run `mvn test` to ensure nothing broke
- Test login flows: admin login, user login, registration
- Verify profile update still works
