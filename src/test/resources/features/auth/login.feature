Feature: Login API

  # =====================================================
  # Scenario 14 - Medium | Learning: extract values with "def"
  # =====================================================

  Background:
    * url baseUrl
    * def users = read('classpath:data/users.json')

  @scenario14 @medium
  Scenario: Scenario 14 - Login and extract token
    Given path 'api/auth/login'
    And request users.validUser
    When method POST
    Then status 200
    And match response.token == '#string'
    And match response.tokenType == 'Bearer'
    # Extract the token into a variable for later requests
    * def token = response.token
    * def username = response.username
    * print 'Logged in as', username, 'token length:', token.length
