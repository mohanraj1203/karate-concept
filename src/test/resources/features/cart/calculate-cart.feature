Feature: Calculate Cart Total API

  # =====================================================
  # Scenario 23 - Advanced | Learning: totals endpoint
  # Scenario 27 - Advanced | Learning: JavaScript for calculation
  # =====================================================

  Background:
    * url baseUrl

  @scenario23 @advanced
  Scenario: Scenario 23 - Calculate cart total
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
    * def cartId = response.id

    Given path 'api/carts', cartId, 'items'
    And header Authorization = 'Bearer ' + token
    And request { productId: 3, quantity: 2 }
    When method POST
    Then status 200

    Given path 'api/carts', cartId, 'total'
    And header Authorization = 'Bearer ' + token
    When method GET
    Then status 200
    And match response.cartId == cartId
    And match response.total == 1998.0
    And match response.itemCount == 2

  @scenario27 @advanced
  Scenario: Scenario 27 - Use JavaScript to validate the total
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
    * def cartId = response.id

    Given path 'api/carts', cartId, 'items'
    And header Authorization = 'Bearer ' + token
    And request { productId: 8, quantity: 3 }
    When method POST
    Then status 200

    Given path 'api/carts', cartId, 'total'
    And header Authorization = 'Bearer ' + token
    When method GET
    Then status 200
    # JavaScript: recompute the expected total with rounding, then compare
    * def price = response.items[0].price
    * def qty = response.items[0].quantity
    * def expected = Math.round(price * qty * 100) / 100
    * print 'price=', price, 'qty=', qty, 'expected=', expected
    And match response.total == expected
    And match response.itemCount == qty
