@exercise03 @easy
Feature: Exercise 03 - Create a product

  # REQUIREMENT: Create a new tablet product.
  # API:        POST /api/products
  # BODY:       { name: 'My Tablet', description: 'Exercise tablet', price: 299.99, category: 'tablet', stock: 7 }
  # EXPECTED:   HTTP 201, response contains a numeric id and the same name
  # HINTS:
  #   1. Use "And request { ... }" with the body above (see Scenario 05)
  #   2. Expect status 201, not 200

  Background:
    * url baseUrl

  Scenario: Create a tablet product
    # TODO:
    # 1. POST the body above to /api/products
    # 2. Verify status is 201
    # 3. Verify response.id is a number and response.name == 'My Tablet'
    * print 'Write your solution here - see SOLUTIONS.md only AFTER trying'
