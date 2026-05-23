# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Commands

```bash
# Build
mvn clean package

# Run
mvn spring-boot:run

# Run tests
mvn test

# Run a single test class
mvn test -Dtest=JtSpringProjectApplicationTests
```

> **IntelliJ IDEA working directory:** Set the run configuration's Working Directory to `$MODULE_WORKING_DIR$` so that JSP views under `src/main/webapp/` are found at runtime.

## Database Setup

Configure `src/main/resources/application.properties` with your MySQL credentials:

```properties
db.url=jdbc:mysql://localhost:3306/ecommjava?createDatabaseIfNotExist=true
db.username=<username>
db.password=<password>
```

Then seed the database:
```bash
mysql -u root -p < basedata.sql
```

Default credentials after seeding: `admin/123` (ROLE_ADMIN), `lisa/765` (ROLE_NORMAL).

## Architecture

### Technology Stack
- Spring Boot 2.6.4, Java 11, Maven
- **Hibernate SessionFactory** (NOT Spring Data JPA) — `HibernateJpaAutoConfiguration` is explicitly excluded in `JtSpringProjectApplication`
- Spring Security with two separate filter chains
- JSP views in `src/main/webapp/views/` (configured via `spring.mvc.view.prefix/suffix`)
- MySQL (`ecommjava` database, port 3306)

### Layer Structure
```
controller/   → AdminController (/admin/**), UserController (/), ErrorController
services/     → Business logic; called by controllers
dao/          → Hibernate SessionFactory DAOs; called by services
models/       → JPA entities (User, Category, Product, Cart, CartProduct)
configuration/→ HibernateConfiguration (DataSource + SessionFactory + TxManager)
              → SecurityConfiguration (two HttpSecurity chains)
```

Controllers return view names (strings) or `ModelAndView` objects — this is **not** a REST API.

### DAO Pattern
All DAOs follow this exact pattern — always use `sessionFactory.getCurrentSession()` and `@Transactional`:

```java
@Repository
public class XyzDao {
    @Autowired private SessionFactory sessionFactory;

    @Transactional
    public Xyz save(Xyz obj) {
        sessionFactory.getCurrentSession().save(obj);
        return obj;
    }
}
```

### Security

Two `@Order`-separated `SecurityFilterChain` beans:
1. **Admin chain** (`@Order(1)`) — matches `/admin/**`; requires `ROLE_ADMIN`; login at `/admin/login`, processes at `/admin/loginvalidate`
2. **User chain** (`@Order(2)`) — matches `/**`; requires `ROLE_USER`; login at `/login`, processes at `/userloginvalidate`

CSRF is **disabled** in both chains. Roles are stored in the DB as `ROLE_ADMIN` / `ROLE_NORMAL` but Spring Security strips the `ROLE_` prefix internally.

`BCryptPasswordEncoder` is registered as a bean (used by Spring Security's `UserDetailsService` to re-encode the raw password for comparison), but passwords are stored **plain text** in the DB.

### Entity → Table Mapping
| Entity | Table | PK |
|---|---|---|
| User | CUSTOMER | id |
| Product | PRODUCT | product_id |
| Category | CATEGORY | category_id |
| Cart | CART | id |
| CartProduct | CART_PRODUCT | id |

### Known Bugs to Avoid Reintroducing
- `ProductDao.updateProduct` is **missing `@Transactional`** — any update must add this annotation
- `deletProduct` / `deletCategory` — method names have a typo (missing 'e'); preserve these names to avoid breaking call sites
- `AdminController.profileDisplay` and `updateUserProfile` use raw JDBC with **hardcoded credentials** (`root`/empty) pointing to a different DB — these are broken and should be replaced with the service layer
- Cart feature is partially implemented (commented-out code in `UserController` and the `Cart` entity)
