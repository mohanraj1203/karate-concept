@exercise17 @hard
Feature: Exercise 17 - Schema check on a product

  # REQUIREMENT: GET product 5 and validate the full JSON shape at once.
  # API:        GET /api/products/5
  # EXPECTED:   { id: 5, name: 'iPad Air', price: 649.0, category: 'tablet',
  #               description: '#string', stock: '#number' } with status 200
  # HINTS:
  #   1. See Scenario 26 for the multiline """ schema match

  Background:
    * url baseUrl

  Scenario: Product matches full schema
    # TODO:
    # 1. GET /api/products/5
    # 2. Match the whole response against the schema above
    * print 'Write your solution here - see SOLUTIONS.md only AFTER trying'
