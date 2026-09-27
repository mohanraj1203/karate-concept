@exercise02 @easy
Feature: Exercise 02 - Get product and check fields

  # REQUIREMENT: Get product 2 and validate its fields.
  # API:        GET /api/products/2
  # EXPECTED:   HTTP 200, name 'Dell XPS 13', category 'laptop', price is a number
  # HINTS:
  #   1. Use "Given path 'api/products/2'" (see Scenario 02)
  #   2. Use "match" for each field (see Scenario 03)
  Given path 'api/products/2'
  When method GET 
  Then status 200
  And match response.id == 2
  And match response.name == 'Dell XPS 13'
  And match response.category == 'laptop'
  And match response.price == '#number'

  

  Background:
    * url baseUrl

  Scenario: Get product 2 and validate fields
    # TODO:
    # 1. Send GET request to /api/products/2
    # 2. Verify status is 200
    # 3. Verify name == 'Dell XPS 13'
    # 4. Verify category == 'laptop' and price is a number
    * print 'Write your solution here - see SOLUTIONS.md only AFTER trying'
