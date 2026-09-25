@exercise05 @easy
Feature: Exercise 05 - Reject bad product data

  # REQUIREMENT: Try to create a product with price 0 (invalid).
  # API:        POST /api/products
  # BODY:       { name: 'Freebie', description: 'Bad price', price: 0, category: 'accessories', stock: 1 }
  # EXPECTED:   HTTP 400 with error 'Bad Request'
  # HINTS:
  #   1. Same shape as Scenario 09 - only the body changes

  Background:
    * url baseUrl

  Scenario: Reject a product with price 0
    # TODO:
    # 1. POST the body above
    # 2. Verify status is 400
    # 3. Verify response.error == 'Bad Request'
    * print 'Write your solution here - see SOLUTIONS.md only AFTER trying'
