Feature: Create Order API

  # =====================================================
  # Scenario 26 - Advanced | Learning: multiline JSON schema match
  # =====================================================

  Background:
    * url baseUrl

  @scenario26 @advanced
  Scenario: Scenario 26 - Create order and validate full schema
    * def login = call read('classpath:features/common/login.feature') { username: 'student', password: 'password123' }
    * def token = login.token

    Given path 'api/carts'
    And header Authorization = 'Bearer ' + token
    And request {}
    When method POST
    Then status 201
    * def cartId = response.id

    Given path 'api/carts', cartId, 'items'
    And header Authorization = 'Bearer ' + token
    And request { productId: 4, quantity: 1 }
    When method POST
    Then status 200

    Given path 'api/orders'
    And header Authorization = 'Bearer ' + token
    And request { cartId: '#(cartId)' }
    When method POST
    Then status 201
    # Reusable JSON schema: every field shape asserted at once
    And match response ==
    """
    {
      id: '#number',
      cartId: '#(cartId)',
      userId: '#number',
      username: 'student',
      status: 'CREATED',
      total: 899.99,
      itemCount: 1,
      items: '#[1]',
      createdAt: '#string'
    }
    """
