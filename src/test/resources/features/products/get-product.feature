Feature: Get Single Product API

  # =====================================================
  # Scenario 02 - Beginner | Learning: "path" for URL segments
  # Scenario 03 - Beginner | Learning: "match" for field validation
  # =====================================================

  Background:
    * url baseUrl

  @scenario02 @beginner
  Scenario: Scenario 02 - Get product by valid ID
    Given path 'api/products/1'
    When method GET
    Then status 200
    And match response.id == 1

  @scenario03 @beginner
  Scenario: Scenario 03 - Validate product fields with match
    Given path 'api/products', 3
    # comma form of path appends another segment: /api/products/3
    When method GET
    Then status 200
    And match response.id == 3
    And match response.name == 'iPhone 15'
    And match response.price == 999.0
    And match response.category == 'mobile'
    And match response.name == '#string'
    And match response.price == '#number'
    And match response.stock == '#number'
