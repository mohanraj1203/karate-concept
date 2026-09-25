Feature: Get User API

  # =====================================================
  # Scenario 12 - Medium | Learning: GET a user, reuse seed data
  # =====================================================

  Background:
    * url baseUrl

  @scenario12 @medium
  Scenario: Scenario 12 - Get a user by ID
    Given path 'api/users/1'
    When method GET
    Then status 200
    And match response.id == 1
    And match response.username == 'student'
    And match response.email == '#string'
