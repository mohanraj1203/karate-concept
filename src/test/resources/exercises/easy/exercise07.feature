@exercise07 @easy
Feature: Exercise 07 - Validate the whole product list

  # REQUIREMENT: Get all products and check every item has a valid shape.
  # API:        GET /api/products
  # EXPECTED:   HTTP 200, every item has numeric id/price and string name/category
  # HINTS:
  #   1. Use "match each" (see Scenario 10)

  Background:
    * url baseUrl

  Scenario: Every product has valid fields
    # TODO:
    # 1. GET /api/products
    # 2. Verify status is 200
    # 3. Use "match each" to check id, name, price, category types
    * print 'Write your solution here - see SOLUTIONS.md only AFTER trying'
