Feature: Negative Order And Cart Tests

  # =====================================================
  # Scenario 29 - Advanced | Learning: negative testing, many calls in one Scenario
  # =====================================================

  Background:
    * url baseUrl

  @scenario29 @advanced
  Scenario: Scenario 29 - Advanced negative testing
    # 1. Missing token -> 401
    Given path 'api/carts'
    And request {}
    When method POST
    Then status 401
    And match response.error == 'Unauthorized'

    # 2. Invalid token -> 401
    Given path 'api/carts'
    And header Authorization = 'Bearer this-is-not-a-valid-token'
    And request {}
    When method POST
    Then status 401

    # Get a real token + cart for the remaining checks
    * def login = call read('classpath:features/common/login.feature') { username: 'student', password: 'password123' }
    * def token = login.token

    Given path 'api/carts'
    And header Authorization = 'Bearer ' + token
    And request {}
    When method POST
    Then status 201
    * def cartId = response.id

    # 3. Invalid product -> 404
    Given path 'api/carts', cartId, 'items'
    And header Authorization = 'Bearer ' + token
    And request { productId: 99999, quantity: 1 }
    When method POST
    Then status 404
    And match response.error == 'Not Found'

    # 4. Invalid quantity -> 400
    Given path 'api/carts', cartId, 'items'
    And header Authorization = 'Bearer ' + token
    And request { productId: 3, quantity: 0 }
    When method POST
    Then status 400
    And match response.message contains 'quantity'

    # 5. Missing request field -> 400
    Given path 'api/orders'
    And header Authorization = 'Bearer ' + token
    And request {}
    When method POST
    Then status 400
    And match response.message contains 'cartId'

    # 6. Order that does not exist -> 404
    Given path 'api/orders/999999'
    And header Authorization = 'Bearer ' + token
    When method GET
    Then status 404
