@exercise04 @easy
Feature: Exercise 04 - Product not found

  # REQUIREMENT: Request a product that cannot exist.
  # API:        GET /api/products/777777
  # EXPECTED:   HTTP 404 with error 'Not Found'
  # HINTS:
  #   1. Same shape as Scenario 08 - only the ID changes

  Background:
    * url baseUrl

  Scenario: Get a product that does not exist
    # TODO:
    # 1. GET /api/products/777777
    # 2. Verify status is 404
    # 3. Verify response.error == 'Not Found'
    * print 'Write your solution here - see SOLUTIONS.md only AFTER trying'
