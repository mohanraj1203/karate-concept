package com.example.smartcart;

import com.intuit.karate.junit5.Karate;
import org.springframework.boot.test.context.SpringBootTest;

/**
 * Karate JUnit5 runner.
 *
 * <p>The {@code @SpringBootTest} annotation boots the SmartCart API on port 8080
 * in the same JVM before Karate executes, so {@code ./gradlew test} works with
 * no manual server startup.
 */
@SpringBootTest(webEnvironment = SpringBootTest.WebEnvironment.DEFINED_PORT)
public class KarateTestRunner {

    @Karate.Test
    Karate runAll() {
        // NOTE: no .relativeTo(getClass()) here on purpose.
        // The VS Code Karate extension passes an ABSOLUTE feature path via
        // -Dkarate.options="<abs path>.feature[:line]". With relativeTo(),
        // Karate prefixes that path with the runner's package and fails with
        // "not found: com/example/smartcart//Users/...". Resolving from the
        // classpath root keeps both ./gradlew test and IDE runs working.
        return Karate.run("classpath:exercises");
    }
}
