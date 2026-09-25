Feature: Create Cart API

  # =====================================================
  # Scenario 21 - Advanced | Learning: protected POST, 201 + auth
  # =====================================================

  Background:
    * url baseUrl

  @scenario21 @advanced
  Scenario: Scenario 21 - Create cart
    # Login first: carts are protected resources
    Given path 'api/auth/login'
    And request { username: 'student', password: 'password123' }
    When method POST
    Then status 200
    * def token = response.token

    Given path 'api/carts'
    And header Authorization = 'Bearer ' + token
    And request {}
    When method POST
    Then status 201
    And match response.id == '#number'
    And match response.items == '#[]'
    And match response.total == 0.0
