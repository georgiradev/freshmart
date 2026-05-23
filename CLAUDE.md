# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Commands

```bash
# Build
mvn clean package

# Run (H2 in-memory DB — no setup needed locally)
mvn spring-boot:run

# Run tests
mvn test

# Run a single test class
mvn test -Dtest=JtSpringProjectApplicationTests
```

> **IntelliJ IDEA working directory:** Set the run configuration's Working Directory to `$MODULE_WORKING_DIR$` so that JSP views under `src/main/webapp/` are found at runtime.

## Local Database

Uses **H2 in-memory** by default — no database setup required. Just run and go.

Config in `src/main/resources/application.properties`:
```properties
spring.datasource.url=jdbc:h2:mem:ecommjava;DB_CLOSE_DELAY=-1;MODE=MySQL
spring.datasource.username=sa
spring.datasource.password=
```

Schema and seed data are managed by **Flyway** (`src/main/resources/db/migration/`).
- `V1__create_schema.sql` — tables
- `V2__seed_data.sql` — seed rows (admin/123, lisa/765)
- `V3–V8` — incremental migrations

Default credentials: `admin/123` (ROLE_ADMIN), `lisa/765` (ROLE_NORMAL).

## Architecture

### Technology Stack
- Spring Boot 3.5.x, Java 25 (Java 21 in Docker/production), Maven
- **Spring Data JPA** (`JpaRepository` interfaces) — NOT Hibernate SessionFactory
- Spring Boot auto-configures DataSource, EntityManagerFactory, TransactionManager
- **Flyway** manages schema and seed data; `spring.jpa.hibernate.ddl-auto=validate`
- **Lombok** on all entities: `@Getter @Setter @NoArgsConstructor`
- Spring Security with two separate filter chains
- JSP views in `src/main/webapp/views/`
- H2 locally · PostgreSQL on Render (activated via `spring.profiles.active=prod`)

### Layer Structure
```
controller/      → AdminController (/admin/**), UserController (/), ErrorController
services/        → Business logic; called by controllers
dao/             → JpaRepository interfaces; called by services
models/          → JPA entities (User, Category, Product, Cart, CartProduct)
configuration/   → SecurityConfiguration, PasswordEncoderConfig
                   WebMvcConfig, GlobalModelAttributes, ProductDataLoader
                   CatalogProperties (binds application.yml catalog)
```

Controllers return view names (strings) or `ModelAndView` — this is **not** a REST API.
Exception: AJAX endpoints in `UserController` return `@ResponseBody Map<String, Object>` JSON.

### Repository Pattern (Spring Data JPA)
```java
@Repository
public interface XyzDao extends JpaRepository<Xyz, Integer> {
    Optional<Xyz> findByFieldName(String value);
    boolean existsByFieldName(String value);
}
```

### Service Pattern
```java
@Service
public class XyzService {
    private final XyzDao xyzDao;
    @Autowired public XyzService(XyzDao xyzDao) { this.xyzDao = xyzDao; }

    public Xyz getById(int id) { return xyzDao.findById(id).orElse(null); }
    public Xyz save(Xyz obj)   { return xyzDao.save(obj); }
    public boolean delete(int id) {
        if (!xyzDao.existsById(id)) return false;
        xyzDao.deleteById(id); return true;
    }
}
```

### Entity Pattern
```java
@Entity
@Table(name = "TABLE_NAME")
@Getter @Setter @NoArgsConstructor
public class Xyz {
    @Id @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;
    // fields...
}
```

### Security

Two `@Order`-separated `SecurityFilterChain` beans in `SecurityConfiguration.java`:
1. **Admin chain** (`@Order(1)`) — matches `/admin/**`; requires `ROLE_ADMIN`; login at `/admin/login`, processes at `/admin/loginvalidate`
2. **User chain** (`@Order(2)`) — matches `/**`; requires `ROLE_USER`; login at `/login`, processes at `/userloginvalidate`

CSRF is **disabled** in both chains.
Passwords: BCrypt via `DelegatingPasswordEncoder`; seed data uses `{noop}` prefix for plain-text.
`PasswordEncoderConfig.java` holds the `PasswordEncoder` bean (separate from `SecurityConfiguration` to avoid circular dependency).

### Catalog Configuration

Products and currency are defined in `application.yml` — no SQL edits needed:
```yaml
app:
  currency:
    symbol: "€"

catalog:
  products:
    - name: "Apple"
      description: "Fresh and juicy"
      price: 3
      weight: 76
      category: "Fruits"
      image: "/images/products/apple.svg"
```
`ProductDataLoader` (an `ApplicationRunner`) syncs this catalog into the DB on every startup.

### Entity → Table Mapping
| Entity      | Table        | PK           | Strategy |
|-------------|-------------|--------------|----------|
| User        | CUSTOMER     | id           | IDENTITY |
| Product     | PRODUCT      | product_id   | IDENTITY |
| Category    | CATEGORY     | category_id  | IDENTITY |
| Cart        | CART         | id           | IDENTITY |
| CartProduct | CART_PRODUCT | id           | IDENTITY |

### AJAX Endpoints
Cart operations use `fetch()` — no page reload:
- `POST /cart/add/ajax?productId=X` → JSON `{itemId, quantity, cartItemCount}`
- `GET /cart/update?itemId=X&action=increase|decrease` → JSON `{quantity, removed, subtotal, cartTotal, cartItemCount, cartTotalItems}`

### Production Deployment
- Deployed on **Render** via Docker (`Dockerfile`) and `render.yaml` blueprint
- Profile `prod` activates `application-prod.yml` (PostgreSQL)
- Environment variables: `DB_HOST`, `DB_PORT`, `DB_NAME`, `DB_USER`, `DB_PASSWORD`, `PORT`
