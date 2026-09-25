@exercise14 @medium
Feature: Exercise 14 - Update then verify

  # REQUIREMENT: Create a product, update its price, verify the change.
  # APIS:       POST /api/products then PUT /api/products/{id}
  # BODY (create): { name: 'Ex Mouse', description: 'ex', price: 20.0, category: 'accessories', stock: 9 }
  # BODY (update): same object with price 25.0 and name 'Ex Mouse v2'
  # EXPECTED:   POST -> 201; PUT -> 200 with price 25.0
  # HINTS:
  #   1. See Scenario 06 for the create-then-update pattern

  Background:
    * url baseUrl

  Scenario: Update a product price
    # TODO:
    # 1. POST the create body, save response.id
    # 2. PUT the update body to /api/products/{id}
    # 3. Verify price == 25.0 and name == 'Ex Mouse v2'
    * print 'Write your solution here - see SOLUTIONS.md only AFTER trying'
