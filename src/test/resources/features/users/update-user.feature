Feature: Update User API

  # =====================================================
  # Scenario 13 - Medium | Learning: PUT a user (own fixture)
  # =====================================================

  Background:
    * url baseUrl

  @scenario13 @medium
  Scenario: Scenario 13 - Update a user
    * def ts = java.lang.System.currentTimeMillis()
    * def payload = { username: '#("upd" + ts)', email: '#("upd" + ts + "@example.com")', password: 'learn123', fullName: 'Before Update' }

    Given path 'api/users'
    And request payload
    When method POST
    Then status 201
    * def userId = response.id

    Given path 'api/users', userId
    And request { email: 'updated@example.com', fullName: 'After Update' }
    When method PUT
    Then status 200
    And match response.id == userId
    And match response.email == 'updated@example.com'
    And match response.fullName == 'After Update'
