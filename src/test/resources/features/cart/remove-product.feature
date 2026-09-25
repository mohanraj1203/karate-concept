Feature: Remove Product From Cart API

  # =====================================================
  # Scenario 25 - Advanced | Learning: "call" a reusable feature
  # =====================================================

  Background:
    * url baseUrl

  @scenario25 @advanced
  Scenario: Scenario 25 - Reuse login via call, then remove item
    # "call" runs features/common/login.feature and returns its result map
    * def login = call read('classpath:features/common/login.feature') { username: 'student', password: 'password123' }
    * def token = login.token
    * print 'Reused token for', login.username

    Given path 'api/carts'
    And header Authorization = 'Bearer ' + token
    And request {}
    When method POST
    Then status 201
    * def cartId = response.id

    Given path 'api/carts', cartId, 'items'
    And header Authorization = 'Bearer ' + token
    And request { productId: 3, quantity: 1 }
    When method POST
    Then status 200
    And match response.itemCount == 1

    Given path 'api/carts', cartId, 'items', 3
    And header Authorization = 'Bearer ' + token
    When method DELETE
    Then status 200
    And match response.items == '#[0]'
    And match response.total == 0.0
