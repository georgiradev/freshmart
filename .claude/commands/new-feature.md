# /new-feature

Create a complete vertical slice for a new feature in this Spring Boot e-commerce project.

**Usage:** `/new-feature <FeatureName> [description]`

## What to generate

Given `$ARGUMENTS` as the feature name (e.g. `Order`), create:

1. **Entity** — `src/main/java/com/jtspringproject/models/<FeatureName>.java`
   - `@Entity(name = "TABLE_NAME")` with `@Table`
   - `@Id @GeneratedValue(strategy = GenerationType.AUTO)`
   - All fields with getters/setters (no Lombok)
   - Appropriate `@ManyToOne`/`@OneToOne` relationships to existing entities if relevant

2. **DAO** — `src/main/java/com/jtspringproject/dao/<FeatureName>Dao.java`
   - `@Repository`, inject `SessionFactory sessionFactory`
   - CRUD methods: `save`, `getAll`, `getById`, `update`, `delete`
   - All methods `@Transactional` — **never skip this**
   - Use HQL with entity name from `@Entity(name=...)` not class name

3. **Service** — `src/main/java/com/jtspringproject/services/<FeatureName>Service.java`
   - `@Service`, inject the DAO
   - Delegate all operations to DAO
   - Add any business logic / validation here

4. **Admin Controller** — add endpoints to `AdminController.java` or create `<FeatureName>AdminController.java`
   - `@Controller @RequestMapping("/admin/<featurenames>")`
   - GET list, GET add form, POST add, GET update, GET delete
   - All return `ModelAndView` or redirect strings
   - Require ROLE_ADMIN (handled by SecurityConfiguration for `/admin/**`)

5. **JSP Views** — `src/main/webapp/views/<featurenames>.jsp` and `<featurename>Add.jsp`
   - Use JSTL `<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>`
   - List view with delete/edit links
   - Add/edit form

## Constraints
- No Lombok, no Spring Data JPA, no DTOs (match existing project style)
- `SessionFactory` for all DB access
- Passwords never plain text (flag if adding User-related logic)
- Match naming conventions: `AdminController`, `UserController`, `ErrorController`
