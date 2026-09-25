@exercise11 @medium
Feature: Exercise 11 - Outline over product IDs

  # REQUIREMENT: Fetch products 1, 3 and 5 with one Scenario Outline.
  # API:        GET /api/products/<id>
  # EXPECTED:   Each returns 200 with response.id equal to the requested id
  # HINTS:
  #   1. Copy the structure of Scenario 18 (Scenario Outline + Examples)
  #   2. Use "Given path 'api/products', <id>"

  Background:
    * url baseUrl

  Scenario Outline: Fetch several products by id
    # TODO:
    # 1. GET /api/products/<id>
    # 2. Verify status 200 and response.id == <id>
    * print 'Write your solution here - see SOLUTIONS.md only AFTER trying'

    Examples:
      | id |
      | 1  |
      | 3  |
      | 5  |
