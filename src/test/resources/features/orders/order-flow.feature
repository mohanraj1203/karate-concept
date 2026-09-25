Feature: SmartCart End To End

  # =====================================================
  # Scenario 30 - Advanced | Learning: full E2E (hardest test)
  # Create User -> Login -> Create Cart -> Get Product
  #   -> Add Product -> Calculate Total -> Create Order -> Get Order
  # =====================================================

  Background:
    * url baseUrl

  @scenario30 @advanced
  Scenario: Scenario 30 - Complete end-to-end SmartCart test
    # 1. Create a brand-new user (unique every run)
    * def ts = java.lang.System.currentTimeMillis()
    * def e2eUser = { username: '#("e2e" + ts)', email: '#("e2e" + ts + "@example.com")', password: 'e2e12345', fullName: 'E2E Shopper' }

    Given path 'api/users'
    And request e2eUser
    When method POST
    Then status 201
    * def newUsername = response.username

    # 2. Login as the new user (reusable feature via call)
    * def login = call read('classpath:features/common/login.feature') { username: '#(newUsername)', password: 'e2e12345' }
    * def token = login.token

    # 3. Create cart
    Given path 'api/carts'
    And header Authorization = 'Bearer ' + token
    And request {}
    When method POST
    Then status 201
    * def cartId = response.id

    # 4. Get product
    Given path 'api/products/3'
    When method GET
    Then status 200
    * def productId = response.id

    # 5. Add product
    Given path 'api/carts', cartId, 'items'
    And header Authorization = 'Bearer ' + token
    And request { productId: '#(productId)', quantity: 2 }
    When method POST
    Then status 200
    And match response.itemCount == 2

    # 6. Calculate total with JavaScript cross-check
    Given path 'api/carts', cartId, 'total'
    And header Authorization = 'Bearer ' + token
    When method GET
    Then status 200
    * def expected = Math.round(response.items[0].price * response.items[0].quantity * 100) / 100
    And match response.total == expected

    # 7. Create order, validate schema
    Given path 'api/orders'
    And header Authorization = 'Bearer ' + token
    And request { cartId: '#(cartId)' }
    When method POST
    Then status 201
    * def orderId = response.id
    And match response ==
    """
    {
      id: '#number',
      cartId: '#(cartId)',
      userId: '#number',
      username: '#(newUsername)',
      status: 'CREATED',
      total: '#(expected)',
      itemCount: 2,
      items: '#[1]',
      createdAt: '#string'
    }
    """

    # 8. Get order
    Given path 'api/orders', orderId
    And header Authorization = 'Bearer ' + token
    When method GET
    Then status 200
    And match response.id == orderId
    And match response.status == 'CREATED'
    And match response.total == expected
