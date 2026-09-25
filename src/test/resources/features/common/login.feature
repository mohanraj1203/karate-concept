Feature: Reusable Login

  # This feature is NEVER run directly for learning credit.
  # It is called from other features with:
  #   * call read('classpath:features/common/login.feature') { username: 'student', password: 'password123' }
  # It returns: { token: '...', username: '...', userId: ... }

  # Tagged @ignore so the JUnit runner never executes it standalone
  # (it has no credentials of its own). It still runs fine via "call".
  @ignore
  Scenario: Login and return token
    Given url baseUrl
    And path 'api/auth/login'
    And request { username: '#(username)', password: '#(password)' }
    When method POST
    Then status 200
    And match response.token == '#string'
    # A called feature returns ALL variables in scope as a map,
    # so the caller gets { token, username, userId } automatically.
    * def token = response.token
    * def username = response.username
    * def userId = response.userId
