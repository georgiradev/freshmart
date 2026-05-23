# /add-endpoint

Add a new endpoint to this Spring Boot MVC project.

**Usage:** `/add-endpoint <HTTP_METHOD> <path> <description>`

**Example:** `/add-endpoint GET /cart "Show cart contents for logged-in user"`

## Steps

1. **Determine the controller** based on the path:
   - `/admin/**` → `AdminController.java`
   - `/` or user paths → `UserController.java`
   - New domain → consider a new `@Controller` class

2. **Read the target controller** before editing

3. **Add the endpoint** following existing patterns:

   ### Standard MVC (returns view)
   ```java
   @GetMapping("/path")
   public ModelAndView myHandler() {
       ModelAndView mv = new ModelAndView("viewName");
       mv.addObject("key", service.getData());
       return mv;
   }
   ```
   - POST handlers redirect after action: `return "redirect:/path";`
   - Get current user: `SecurityContextHolder.getContext().getAuthentication().getName()`
   - Never use raw JDBC — always go through the service layer

   ### AJAX endpoint (returns JSON)
   ```java
   @ResponseBody
   @PostMapping(value = "/some/ajax", produces = "application/json")
   public Map<String, Object> ajaxHandler(@RequestParam int id) {
       Map<String, Object> result = new HashMap<>();
       result.put("key", value);
       return result;
   }
   ```

4. **Create JSP view** if needed at `src/main/webapp/views/<viewName>.jsp`
   - Include JSTL: `<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>`
   - Iterate with `<c:forEach var="item" items="${key}">`
   - Display with `${item.fieldName}`
   - Match FreshMart design: cream background (`#f8f5f0`), green-dark navbar (`#1b4332`)

5. **Update security** if the path needs a different access level:
   - `/admin/**` is already protected (ROLE_ADMIN) by SecurityConfiguration Chain 1
   - Add public paths to Chain 2's `permitAll()` list in `SecurityConfiguration.java`
   - Both chains have CSRF disabled

6. **Global model attributes** — `username`, `profileImage`, `currencySymbol`, `cartMap` are injected by `GlobalModelAttributes.java` into every view automatically

7. **Confirm** at `http://localhost:8080<path>`
