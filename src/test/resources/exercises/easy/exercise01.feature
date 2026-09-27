    @exercise01 @easy
Feature: Exercise 01 - Find products by category

    # REQUIREMENT: Find all mobile products.
    # API:        GET /api/products?category=mobile
    # EXPECTED:   HTTP 200, exactly 2 products, each with category == 'mobile'
    # HINTS:
    #   1. Start with "Given path 'api/products'" (see Scenario 04)
    #   2. Add "And param category = 'mobile'"
    #   3. Verify status 200
    #   4. Verify with "match each response[*].category == 'mobile'"
    Give path 'api/products'
    And param category='mobile'
    when method GET
    Then status 200
    AND match each response[*].category == 'mobile'

  Background:
    * url baseUrl

  Scenario: Find all mobile products
    # TODO:
    # 1. Send GET request with the category query parameter
    # 2. Verify status is 200
    # 3. Verify exactly 2 products are returned
    # 4. Verify every product has category 'mobile'
    # Give path 'api/products'
    # And param category='mobile'
    # when method GET
    # Then status 200
    # AND match each response[*].category == 'mobile'
    

    * print 'Write your solution here - see SOLUTIONS.md only AFTER trying'
