# SmartCart — Karate Learning Laboratory

A Spring Boot API (`SmartCart`) plus **30 runnable Karate learning scenarios** (beginner → advanced)
and **20 hands-on exercises** (solutions in `SOLUTIONS.md` — attempt first!).

## Prerequisites

- Java 21 (`java -version` must report 21+; the build uses a Java 21 toolchain)
- No Gradle install needed — use the included wrapper (`./gradlew` on macOS/Linux,
  `gradlew.bat` on Windows)
- VS Code with the **Karate Runner** extension (`kirkslota.karate-runner`) for single-scenario runs

## Windows setup

1. **Install Java 21** (e.g. Eclipse Temurin 21 or Oracle JDK 21) and set `JAVA_HOME`:
   - `Settings → System → About → Advanced system settings → Environment Variables`
   - New System variable: `JAVA_HOME = C:\Program Files\Eclipse Adoptium\jdk-21...` (your install path)
   - Add `%JAVA_HOME%\bin` to `Path`.
   - Verify in a **new** terminal: `java -version` must show 21.
2. **Open the project folder** in VS Code (`File → Open Folder…`, pick `TestCase`).
3. **Use `gradlew.bat`** for every command in this guide — replace `./gradlew` with `gradlew.bat`:
   ```bat
   gradlew.bat --version
   gradlew.bat test
   gradlew.bat test -Dkarate.options="--tags @scenario15"
   ```
   Works in both CMD and PowerShell; keep the double quotes as shown.
4. **VS Code Run button** works the same as on macOS — the extension already maps the
   wrapper to `gradlew` on Windows via `.vscode/settings.json`. No extra setup.
5. **Reports** are at `build\karate-reports\karate-summary.html` and
   `build\reports\tests\test\index.html` — open in a browser.
6. **Troubleshooting:**
   - `Port 8080 is already in use` → never run the app and the tests at the same time.
     Find the blocker with `netstat -ano | findstr :8080` and kill it with
     `taskkill /PID <pid> /F`.
   - `'java' is not recognized` → `JAVA_HOME`/`Path` not set — repeat step 1 and open a new terminal.
   - Quoting errors in PowerShell → switch to CMD, or keep the exact double-quote style above.

## Project layout

```text
src/main/java/com/example/smartcart/   # Spring Boot API (products, users, auth, carts, orders)
src/test/java/.../KarateTestRunner.java
src/test/resources/
  karate-config.js                     # baseUrl + env (local/dev)
  features/auth|users|products|cart|orders/common   # 30 learning scenarios
  exercises/easy|medium|hard           # 20 exercises (TODO only, no solutions)
  data/                                # users.json, products.json, cart-data.json, order-data.json
TEST-CASE-GUIDE.md  SOLUTIONS.md  Jenkinsfile
```

## Run everything

```bash
./gradlew test
```

The `KarateTestRunner` is a `@SpringBootTest` that boots the API on port **8080** in the same
JVM, so no manual server startup is needed. Reports land in:

```text
build/karate-reports/karate-summary.html   # open in a browser (Karate HTML report)
build/reports/tests/test/                  # Gradle/JUnit report
```

## Run ONE feature (VS Code Run button)

The **Karate Runner** extension (`kirkslota.karate-runner`) is wired to this project via
`.vscode/settings.json`: clicking **Karate: Run** above a `Feature:` line runs

```bash
./gradlew clean test --tests com.example.smartcart.KarateTestRunner -Dkarate.options="<absolute path to the feature>"
```

and **Karate: Run** above a `Scenario:` line appends `:<line>` so only that scenario runs.
No manual server startup is needed — the Gradle task boots the API itself. If the Run
links don't appear, make sure the extension is enabled for this workspace.

Alternative without the extension: start the app (`./gradlew bootRun`), download `karate.jar`
(same version as `build.gradle`, currently 1.4.1), then
`java -jar karate.jar src/test/resources/features/products/get-product.feature`.

## Run ONE scenario (important for learning)

### Option 1 — VS Code (easiest)

1. Open any `.feature` file, e.g. `src/test/resources/features/products/get-products.feature`
2. Find the scenario (e.g. `Scenario: Scenario 01 - Get all products`)
3. Click **Run** (CodeLens from the Karate Runner extension) above that scenario
4. View output in the VS Code terminal / `build/karate-reports`

> Requires: app running (`./gradlew bootRun` in another terminal) OR the extension configured
> with `karate.config` pointing at `http://localhost:8080`, because standalone runs don't
> boot Spring for you.

### Option 2 — Tags (works with Gradle)

Every scenario has a unique tag (`@scenario01` … `@scenario30`) plus a level tag
(`@beginner` / `@medium` / `@advanced`):

```bash
# exactly one scenario
./gradlew test -Dkarate.options="--tags @scenario01"

# a whole level
./gradlew test -Dkarate.options="--tags @beginner"

# everything EXCEPT advanced
./gradlew test -Dkarate.options="--tags ~@advanced"
```

The runner forwards `karate.options` to Karate (`systemProperty 'karate.options', …` in
`build.gradle`), so tag filtering works out of the box. Quotes around `--tags …` matter.

## Environments (local / dev)

`karate-config.js` reads `karate.env` (default `local`):

```bash
./gradlew test -Dkarate.env=dev
```

Both envs point at `http://localhost:8080` here — edit `karate-config.js` to point `dev`
at your shared server. Combine with tags:

```bash
./gradlew test -Dkarate.env=dev -Dkarate.options="--tags @scenario30"
```

## Learning path

```text
TEST-CASE-GUIDE.md      # what each of the 30 scenarios teaches
src/test/resources/features/**   # run 01 -> 30 in order
src/test/resources/exercises/**  # 7 easy -> 7 medium -> 6 hard, write them yourself
SOLUTIONS.md            # ONLY after attempting
```

## Seed logins

| username | password |
|----------|----------|
| student | password123 |
| admin | admin123 |

## CI

`Jenkinsfile` runs `./gradlew test` and archives `build/karate-reports/**`.
