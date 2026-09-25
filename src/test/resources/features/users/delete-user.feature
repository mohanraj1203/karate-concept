Feature: Delete User API

  # =====================================================
  # Scenario 16 - Medium | Learning: "Background" runs before each Scenario
  # =====================================================

  # Everything here runs before EVERY scenario in this file.
  Background:
    * url baseUrl
    * def ts = java.lang.System.currentTimeMillis()

  @scenario16 @medium
  Scenario: Scenario 16 - Background creates fixture, scenario deletes it
    Given path 'api/users'
    And request { username: '#("del" + ts)', email: '#("del" + ts + "@example.com")', password: 'learn123', fullName: 'Temp User' }
    When method POST
    Then status 201
    * def userId = response.id

    Given path 'api/users', userId
    When method DELETE
    Then status 200
    And match response.message == 'User deleted'
