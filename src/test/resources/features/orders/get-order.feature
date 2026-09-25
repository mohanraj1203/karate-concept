Feature: Order Workflow API

  # =====================================================
  # Scenario 28 - Advanced | Learning: full order workflow chain
  # =====================================================

  Background:
    * url baseUrl

  @scenario28 @advanced
  Scenario: Scenario 28 - Complete order workflow
    # Login -> Get Product -> Create Cart -> Add Product
    #       -> Calculate Total -> Create Order -> Get Order
    * def login = call read('classpath:features/common/login.feature') { username: 'student', password: 'password123' }
    * def token = login.token

    Given path 'api/products/3'
    When method GET
    Then status 200
    * def productId = response.id
    * def unitPrice = response.price

    Given path 'api/carts'
    And header Authorization = 'Bearer ' + token
    And request {}
    When method POST
    Then status 201
    * def cartId = response.id

    Given path 'api/carts', cartId, 'items'
    And header Authorization = 'Bearer ' + token
    And request { productId: '#(productId)', quantity: 2 }
    When method POST
    Then status 200

    Given path 'api/carts', cartId, 'total'
    And header Authorization = 'Bearer ' + token
    When method GET
    Then status 200
    * def cartTotal = response.total

    Given path 'api/orders'
    And header Authorization = 'Bearer ' + token
    And request { cartId: '#(cartId)' }
    When method POST
    Then status 201
    * def orderId = response.id
    And match response.total == cartTotal

    Given path 'api/orders', orderId
    And header Authorization = 'Bearer ' + token
    When method GET
    Then status 200
    And match response.id == orderId
    And match response.status == 'CREATED'
