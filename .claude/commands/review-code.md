# /review-code

Review a file or feature in this project for bugs, security issues, and style consistency.

**Usage:** `/review-code [file-path or feature-name]`

**Examples:**
- `/review-code src/main/java/com/jtspringproject/controller/AdminController.java`
- `/review-code cart feature`
- `/review-code all`

## Checklist Applied During Review

### Correctness
- [ ] JpaRepository methods used correctly (`save`, `findById`, `deleteById`, `existsById`)
- [ ] `Optional` results are unwrapped safely (`.orElse(null)` or `.orElseThrow()`)
- [ ] Entity relationships have correct `FetchType` — lazy by default, `EAGER` only when justified
- [ ] Cascade types are intentional (no accidental `CascadeType.ALL` on owning side)
- [ ] ProductDataLoader syncs catalog on startup — `findByName` must exist on `ProductDao`

### Security
- [ ] No plain-text password storage — use `PasswordEncoder.encode()` on save
- [ ] No raw JDBC — all DB access through JpaRepository DAOs
- [ ] No string concatenation in queries (use derived query methods or `@Query` with `:param`)
- [ ] No sensitive data (password, full profile) exposed in JSON responses
- [ ] Admin endpoints under `/admin/**` (auto-protected), user endpoints under `/**`

### Spring MVC Patterns
- [ ] Controllers call services (not DAOs directly)
- [ ] Services contain business logic (not controllers or DAOs)
- [ ] DAOs are interfaces extending `JpaRepository` — no implementation class
- [ ] Views use JSTL `${...}` not scriptlets `<% %>`
- [ ] POST handlers redirect after action (PRG pattern)
- [ ] AJAX endpoints annotated with `@ResponseBody` and `produces = "application/json"`

### Entity / JPA
- [ ] All entities have `@Getter @Setter @NoArgsConstructor` (Lombok)
- [ ] PK uses `@GeneratedValue(strategy = GenerationType.IDENTITY)`
- [ ] Table names match Flyway migration (`CUSTOMER`, `PRODUCT`, `CATEGORY`, `CART`, `CART_PRODUCT`)
- [ ] No `@Data` on entities (unsafe for JPA — causes issues with `equals`/`hashCode`)

### Frontend / JSP
- [ ] Hover effects on touch elements wrapped in `@media (hover: hover)`
- [ ] Mobile breakpoints present for any multi-column flex layout
- [ ] AJAX cart interactions use `fetch()` — no full-page reloads for add/update
- [ ] DOM manipulation uses `replaceChild` not `innerHTML` when siblings must be preserved

### Code Quality
- [ ] No `System.out.println` (use `@Slf4j` + `log.info/warn/error`)
- [ ] No commented-out dead code
- [ ] Consistent naming: `camelCase` fields, `PascalCase` classes, `UPPER_SNAKE` constants

## Output Format
For each issue found:
- **File:Line** — description of issue
- **Severity:** CRITICAL / HIGH / MEDIUM / LOW
- **Fix:** concrete code change needed
