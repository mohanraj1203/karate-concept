Feature: Add Product To Cart API

  # =====================================================
  # Scenario 22 - Advanced | Learning: POST a nested resource
  # Scenario 24 - Advanced | Learning: chain APIs (login->cart->add->get)
  # =====================================================

  Background:
    * url baseUrl
    * def cartData = read('classpath:data/cart-data.json')

  @scenario22 @advanced
  Scenario: Scenario 22 - Add product to cart
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
    And request cartData.addItem
    When method POST
    Then status 200
    And match response.items[0].productId == 3
    And match response.items[0].quantity == 2
    And match response.total == 1998.0

  @scenario24 @advanced
  Scenario: Scenario 24 - Chain APIs end to end at cart level
    # Login -> Create Cart -> Add Product -> Get Cart
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
    And request { productId: 7, quantity: 1 }
    When method POST
    Then status 200

    Given path 'api/carts', cartId
    And header Authorization = 'Bearer ' + token
    When method GET
    Then status 200
    And match response.id == cartId
    And match response.items[0].productName == 'Sony WH-1000XM5'
    And match response.itemCount == 1
