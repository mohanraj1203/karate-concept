@exercise18 @hard
Feature: Exercise 18 - JavaScript discount check

  # REQUIREMENT: Get product 7 (349.99), compute a 10% discount in JS, verify it.
  # API:        GET /api/products/7
  # EXPECTED:   discounted == Math.round(price * 0.9 * 100) / 100 == 314.99
  # HINTS:
  #   1. See Scenario 27: "* def expected = Math.round(...) / 100"

  Background:
    * url baseUrl

  Scenario: Compute a discount with JavaScript
    # TODO:
    # 1. GET /api/products/7, save response.price
    # 2. Compute discounted = Math.round(price * 0.9 * 100) / 100
    # 3. Match discounted == 314.99
    * print 'Write your solution here - see SOLUTIONS.md only AFTER trying'
