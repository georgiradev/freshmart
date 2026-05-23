# /run-project

Start, build, or troubleshoot the Spring Boot e-commerce project.

**Usage:** `/run-project [build|run|test|reset-db]`

## Commands

### Build
```bash
mvn clean package -DskipTests
```
Output JAR: `target/JtSpringProject-0.0.1-SNAPSHOT.jar`

### Run (dev mode with hot reload)
```bash
mvn spring-boot:run
```
Access: http://localhost:8080

### Run JAR
```bash
java -jar target/JtSpringProject-0.0.1-SNAPSHOT.jar
```

### Tests
```bash
mvn test
```

### Reset Database
```bash
mysql -u root -p ecommjava < basedata.sql
```
Seeds: 9 categories, 2 users (admin/123, lisa/765), 2 products

## Common Startup Errors

| Error | Cause | Fix |
|-------|-------|-----|
| `Access denied for user 'root'` | Wrong DB password | Update `db.password` in `application.properties` |
| `Communications link failure` | MySQL not running | Start MySQL service |
| `Port 8080 already in use` | Another process on 8080 | `kill $(lsof -t -i:8080)` or change `server.port` |
| JSP not found / 404 on views | Wrong working directory in IntelliJ | Set working directory to `$MODULE_WORKING_DIR$` |
| `HibernateJpaAutoConfiguration` error | Wrong Spring Boot config | Ensure `@SpringBootApplication(exclude = HibernateJpaAutoConfiguration.class)` |
| Lazy loading exception | Entity loaded outside session | `enable_lazy_load_no_trans=true` is set — check if session closed early |

## Database Connection Config
File: `src/main/resources/application.properties`
```properties
db.url=jdbc:mysql://localhost:3306/ecommjava?createDatabaseIfNotExist=true
db.username=root
db.password=root_password
```
