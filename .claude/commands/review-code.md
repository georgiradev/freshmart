# /review-code

Review a file or feature in this project for bugs, security issues, and style consistency.

**Usage:** `/review-code [file-path or feature-name]`

**Examples:**
- `/review-code src/main/java/com/jtspringproject/controller/AdminController.java`
- `/review-code cart feature`
- `/review-code all`

## Checklist Applied During Review

### Correctness
- [ ] All DAO mutating methods have `@Transactional`
- [ ] No missing `@Transactional` on update/delete methods (known bug in ProductDao)
- [ ] Entity relationships correctly mapped (cascade types intentional)
- [ ] HQL uses `@Entity(name=...)` value, not Java class name

### Security
- [ ] No plain-text password storage or comparison
- [ ] No raw JDBC with hardcoded credentials
- [ ] No string concatenation in queries (SQL injection)
- [ ] No sensitive data exposed in JSP views
- [ ] Admin endpoints protected by ROLE_ADMIN

### Spring MVC Patterns
- [ ] Controllers call services (not DAOs directly)
- [ ] Services contain business logic (not controllers)
- [ ] DAOs only do DB operations
- [ ] Views use JSTL `${...}` not scriptlets `<% %>`
- [ ] Redirects after POST (PRG pattern)

### Code Quality
- [ ] No `System.out.println` (use logger)
- [ ] No commented-out dead code left in place
- [ ] No typos in method names (known: `deletProduct`, `deletCategory`)
- [ ] Consistent naming: `camelCase` fields, `PascalCase` classes

## Output Format
For each issue found:
- **File:Line** — description of issue
- **Severity:** CRITICAL / HIGH / MEDIUM / LOW
- **Fix:** concrete code change needed
