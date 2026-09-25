function fn() {
  var env = karate.env; // 'local' (default) or 'dev'
  if (!env) {
    env = 'local';
  }

  var config = {
    env: env,
    baseUrl: 'http://localhost:8080'
  };

  if (env == 'dev') {
    // Example: point to a shared dev environment
    // Override with: ./gradlew test -Dkarate.env=dev
    // or:           ./gradlew test -Dkarate.options="--tags @scenario01" -Dkarate.env=dev
    config.baseUrl = 'http://localhost:8080';
  }

  // Global Karate configuration
  karate.configure('connectTimeout', 5000);
  karate.configure('readTimeout', 5000);
  karate.configure('logPrettyRequest', true);
  karate.configure('logPrettyResponse', true);

  return config;
}
