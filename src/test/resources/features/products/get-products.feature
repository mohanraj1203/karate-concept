Feature: Get All Products API

  # =====================================================
  # Scenario 01 - Beginner | Learning: Basic GET request
  # Scenario 10 - Beginner | Learning: Validate a JSON array with "match each"
  # Scenario 19 - Medium   | Learning: Validate response headers
  # =====================================================

  Background:
    * url baseUrl

  @scenario01 @beginner
  Scenario: Scenario 01 - Get all products
    Given path 'api/products'
    When method GET
    Then status 200
    And match response == '#[]'
    And assert response.length > 0

  @scenario10 @beginner
  Scenario: Scenario 10 - Validate every product in the list
    Given path 'api/products'
    When method GET
    Then status 200
    # "match each" applies the same assertion to every array element
    And match each response == { id: '#number', name: '#string', price: '#number', category: '#string', stock: '#number', description: '#string' }
    And match each response[*].price == '#number'
    And match response[*].name contains 'iPhone 15'

  @scenario19 @medium
  Scenario: Scenario 19 - Validate response headers
    Given path 'api/products'
    When method GET
    Then status 200
    # Built-in "header" match (case-insensitive name)
    And match header Content-Type contains 'application/json'
    # Raw header map added by our Spring interceptor (HeaderInterceptor)
    And match responseHeaders['X-SmartCart-Version'][0] == '1.0'
    And match responseHeaders['X-Response-Time-ms'][0] == '#string'
