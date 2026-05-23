# /run-project

Start, build, or troubleshoot the FreshMart Spring Boot project.

**Usage:** `/run-project [build|run|test|stop]`

## Commands

### Build
```bash
mvn clean package -DskipTests
```
Output JAR: `target/JtSpringProject-0.0.1-SNAPSHOT.jar`

### Run (local — H2 in-memory, no DB setup needed)
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

### Stop (Windows)
```powershell
$pid = (Get-NetTCPConnection -LocalPort 8080).OwningProcess | Select -First 1
Stop-Process -Id $pid -Force
```

## Default Credentials
| Role  | Username | Password |
|-------|----------|----------|
| Admin | `admin`  | `123`    |
| User  | `lisa`   | `765`    |

## Database
- **Local:** H2 in-memory — no setup, schema managed by Flyway migrations in `src/main/resources/db/migration/`
- **Production:** PostgreSQL on Render, activated via `spring.profiles.active=prod`

## Common Startup Errors

| Error | Cause | Fix |
|-------|-------|-----|
| `Port 8080 already in use` | Another process on 8080 | Kill existing process (see Stop above) |
| JSP not found / 404 on views | Wrong working directory | Set IntelliJ run config working directory to `$MODULE_WORKING_DIR$` |
| `FlywayException: Migration checksum mismatch` | Migration file was edited after running | Drop H2 DB (restart resets it) or fix migration |
| `LazyInitializationException` | Entity loaded outside JPA session | Add `spring.jpa.open-in-view=true` or use `FetchType.EAGER` |
| `DataIntegrityViolationException` on startup | ProductDataLoader conflict | Restart — ProductDataLoader uses `findByName` to avoid duplicates |

## Config Files
| File | Purpose |
|------|---------|
| `src/main/resources/application.properties` | Local H2 datasource + JPA |
| `src/main/resources/application.yml` | Currency symbol + full product catalog |
| `src/main/resources/application-prod.yml` | Production PostgreSQL config |

ARGUMENTS: run
