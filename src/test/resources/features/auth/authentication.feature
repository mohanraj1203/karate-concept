Feature: Authenticated Requests

  # =====================================================
  # Scenario 15 - Medium | Learning: send "Authorization: Bearer <token>"
  # Scenario 17 - Medium | Learning: variables with "def"
  # =====================================================

  Background:
    * url baseUrl
    * def users = read('classpath:data/users.json')
  @scenario15 @medium
  Scenario: Scenario 15 - Use authentication token
    # Step 1: login to get a token
    Given path 'api/auth/login'
    And request users.validUser
    When method POST
    Then status 200
    * def token = response.token

    # Step 2: use the token on a protected endpoint
    Given path 'api/auth/me'
    And header Authorization = 'Bearer ' + token
    When method GET
    Then status 200
    And match response.username == 'student'

  @scenario17 @medium
  Scenario: Scenario 17 - Use variables to build requests
    * def productId = 1
    * def expectedName = 'MacBook Pro 14'
    * def loginBody = { username: 'student', password: 'password123' }

    Given path 'api/auth/login'
    And request loginBody
    When method POST
    Then status 200
    * def myToken = response.token

    Given path 'api/products', productId
    And header Authorization = 'Bearer ' + myToken
    When method GET
    Then status 200
    And match response.name == expectedName
