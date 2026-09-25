@exercise06 @easy
Feature: Exercise 06 - Search products by keyword

  # REQUIREMENT: Search for products containing 'sony'.
  # API:        GET /api/products?search=sony
  # EXPECTED:   HTTP 200, at least 1 result, first result name contains 'Sony'
  # HINTS:
  #   1. Use "And param search = 'sony'" (see Scenario 04)
  #   2. "match response[0].name contains 'Sony'"

  Background:
    * url baseUrl

  Scenario: Search for sony products
    # TODO:
    # 1. GET /api/products with param search = 'sony'
    # 2. Verify status is 200
    # 3. Verify response[0].name contains 'Sony'
    * print 'Write your solution here - see SOLUTIONS.md only AFTER trying'
