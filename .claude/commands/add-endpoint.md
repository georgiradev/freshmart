# /add-endpoint

Add a new endpoint to this Spring Boot MVC project.

**Usage:** `/add-endpoint <HTTP_METHOD> <path> <description>`

**Example:** `/add-endpoint GET /user/cart "Show cart contents for logged-in user"`

## Steps

1. **Determine the controller** based on the path:
   - `/admin/**` → `AdminController.java`
   - `/user/**` or `/` → `UserController.java`
   - New domain → ask whether to create a new controller

2. **Read the target controller file** before editing

3. **Add the endpoint** following existing patterns:
   ```java
   @GetMapping("/path")
   public ModelAndView myHandler(Model model) {
       ModelAndView mv = new ModelAndView("viewName");
       mv.addObject("key", service.getData());
       return mv;
   }
   ```
   - For POST handlers, return `"redirect:/path"` after action
   - For authenticated user data: `SecurityContextHolder.getContext().getAuthentication().getName()`
   - Never use raw JDBC — always go through service layer

4. **Create JSP view** if needed at `src/main/webapp/views/<viewName>.jsp`
   - Include JSTL taglib: `<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>`
   - Iterate collections with `<c:forEach var="item" items="${key}">`
   - Display attributes with `${item.fieldName}`

5. **Update security** if the path needs different access:
   - `/admin/**` is already protected by `SecurityConfiguration` Chain 1 (ROLE_ADMIN)
   - Add public paths to Chain 2's `permitAll()` list if needed

6. **Confirm** the endpoint is reachable at `http://localhost:8080<path>`
