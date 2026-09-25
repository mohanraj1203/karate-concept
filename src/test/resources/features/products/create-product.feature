Feature: Create Product API

  # =====================================================
  # Scenario 05 - Beginner | Learning: "request" + POST with JSON body
  # Scenario 09 - Beginner | Learning: "status 400" for invalid input
  # =====================================================

  Background:
    * url baseUrl
    * def products = read('classpath:data/products.json')

  @scenario05 @beginner
  Scenario: Scenario 05 - Create a product
    Given path 'api/products'
    And request products.newProduct
    When method POST
    Then status 201
    And match response.id == '#number'
    And match response.name == 'Karate Keyboard'
    And match response.price == 129.99

  @scenario09 @beginner
  Scenario: Scenario 09 - Reject invalid product creation
    Given path 'api/products'
    And request products.invalidProductBadPrice
    When method POST
    Then status 400
    And match response.error == 'Bad Request'
    And match response.message == '#string'
