Feature: Update Product API

  # =====================================================
  # Scenario 06 - Beginner | Learning: PUT for updates
  # =====================================================

  Background:
    * url baseUrl
    * def products = read('classpath:data/products.json')

  @scenario06 @beginner
  Scenario: Scenario 06 - Update a product
    # Create our own fixture so we never disturb seed data
    Given path 'api/products'
    And request products.newProduct
    When method POST
    Then status 201
    * def productId = response.id

    Given path 'api/products', productId
    And request products.updatedProduct
    When method PUT
    Then status 200
    And match response.id == productId
    And match response.name == 'Karate Keyboard Pro'
    And match response.price == 149.99
