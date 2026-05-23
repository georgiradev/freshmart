# /new-feature

Create a complete vertical slice for a new feature in this Spring Boot e-commerce project.

**Usage:** `/new-feature <FeatureName> [description]`

## What to generate

Given `$ARGUMENTS` as the feature name (e.g. `Order`), create:

1. **Flyway migration** — `src/main/resources/db/migration/V<next>__add_<featurename>.sql`
   - `CREATE TABLE` matching the entity fields
   - Follow existing migration naming: `V1`, `V2`, … check current highest version first

2. **Entity** — `src/main/java/com/jtspringproject/models/<FeatureName>.java`
   ```java
   @Entity
   @Table(name = "TABLE_NAME")
   @Getter @Setter @NoArgsConstructor
   public class FeatureName {
       @Id @GeneratedValue(strategy = GenerationType.IDENTITY)
       private int id;
       // fields with appropriate JPA annotations
       // @ManyToOne / @OneToMany for relationships
   }
   ```

3. **Repository (DAO)** — `src/main/java/com/jtspringproject/dao/<FeatureName>Dao.java`
   ```java
   @Repository
   public interface FeatureNameDao extends JpaRepository<FeatureName, Integer> {
       Optional<FeatureName> findByName(String name);  // derived queries as needed
   }
   ```

4. **Service** — `src/main/java/com/jtspringproject/services/<FeatureName>Service.java`
   ```java
   @Service
   public class FeatureNameService {
       private final FeatureNameDao dao;
       @Autowired public FeatureNameService(FeatureNameDao dao) { this.dao = dao; }

       public List<FeatureName> getAll() { return dao.findAll(); }
       public FeatureName getById(int id) { return dao.findById(id).orElse(null); }
       public FeatureName save(FeatureName obj) { return dao.save(obj); }
       public boolean delete(int id) {
           if (!dao.existsById(id)) return false;
           dao.deleteById(id); return true;
       }
   }
   ```

5. **Controller** — add endpoints to `AdminController.java` or create `<FeatureName>Controller.java`
   - `@Controller @RequestMapping("/admin/<featurenames>")`
   - GET list, GET add form, POST add, GET update form, POST update, GET delete
   - All return `ModelAndView` or redirect strings
   - Use `SecurityContextHolder.getContext().getAuthentication().getName()` for current user
   - Admin endpoints are auto-protected by SecurityConfiguration for `/admin/**`

6. **JSP Views** — `src/main/webapp/views/<featurenames>.jsp` and `<featurename>Add.jsp`
   - Use `<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>`
   - Match the FreshMart design: green-dark navbar, cream background, white cards
   - Iterate with `<c:forEach>`, display with `${item.fieldName}`

## Constraints
- Use **Spring Data JPA** (`JpaRepository`) — not Hibernate SessionFactory
- Use **Lombok** on entities: `@Getter @Setter @NoArgsConstructor` (not `@Data`)
- **Always add a Flyway migration** for new tables — never rely on `ddl-auto=create`
- `spring.jpa.hibernate.ddl-auto=validate` — Hibernate validates schema against DB
- Passwords never plain text; use `{noop}prefix` only in migration seeds
- Controllers call services; services call DAOs — never skip layers
