Feature: Delete Product API

  # =====================================================
  # Scenario 07 - Beginner | Learning: DELETE
  # Scenario 08 - Beginner | Learning: "status 404" for missing resources
  # =====================================================

  Background:
    * url baseUrl
    * def products = read('classpath:data/products.json')

  @scenario07 @beginner
  Scenario: Scenario 07 - Delete a product
    # Create then delete: keeps the test independent of execution order
    Given path 'api/products'
    And request products.newProduct
    When method POST
    Then status 201
    * def productId = response.id

    Given path 'api/products', productId
    When method DELETE
    Then status 200
    And match response.message == 'Product deleted'

    # Prove it is really gone
    Given path 'api/products', productId
    When method GET
    Then status 404

  @scenario08 @beginner
  Scenario: Scenario 08 - Get product that does not exist
    Given path 'api/products', 99999
    When method GET
    Then status 404
    And match response.error == 'Not Found'
    And match response.message contains '99999'
