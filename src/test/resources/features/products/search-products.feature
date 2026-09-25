Feature: Search Products API

  # =====================================================
  # Scenario 04 - Beginner | Learning: "param" for query strings
  # Scenario 18 - Medium   | Learning: Scenario Outline + Examples
  # Scenario 20 - Medium   | Learning: Validate response time
  # =====================================================

  Background:
    * url baseUrl

  @scenario04 @beginner
  Scenario: Scenario 04 - Search products using query parameters
    Given path 'api/products'
    And param category = 'mobile'
    When method GET
    Then status 200
    And match response == '#[2]'
    And match each response[*].category == 'mobile'

  @scenario18 @medium
  Scenario Outline: Scenario 18 - Search products for many categories
    Given path 'api/products'
    And param category = '<category>'
    When method GET
    Then status 200
    And match each response[*].category == '<category>'

    Examples:
      | category |
      | laptop   |
      | mobile   |
      | tablet   |

  @scenario20 @medium
  Scenario: Scenario 20 - Validate response time
    Given path 'api/products'
    And param search = 'phone'
    When method GET
    Then status 200
    # Karate exposes the last response time in milliseconds
    And assert responseTime < 5000
    * print 'Response took', responseTime, 'ms'
