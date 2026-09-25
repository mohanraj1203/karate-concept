Feature: Create User API

  # =====================================================
  # Scenario 11 - Medium | Learning: POST a new user (dynamic data)
  # =====================================================

  Background:
    * url baseUrl

  @scenario11 @medium
  Scenario: Scenario 11 - Create a user
    # Timestamp keeps the username unique across re-runs
    * def ts = java.lang.System.currentTimeMillis()
    * def newUser = { username: '#("user" + ts)', email: '#("user" + ts + "@example.com")', password: 'learn123', fullName: 'Karate Learner' }

    Given path 'api/users'
    And request newUser
    When method POST
    Then status 201
    And match response.id == '#number'
    And match response.username == newUser.username
    And match response.email == newUser.email
