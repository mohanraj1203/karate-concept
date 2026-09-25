@exercise13 @medium
Feature: Exercise 13 - Response time budget

  # REQUIREMENT: Listing users must answer in under 5 seconds.
  # API:        GET /api/users
  # EXPECTED:   HTTP 200 and responseTime < 5000
  # HINTS:
  #   1. See Scenario 20: "assert responseTime < 5000"

  Background:
    * url baseUrl

  Scenario: User list is fast enough
    # TODO:
    # 1. GET /api/users
    # 2. Verify status 200
    # 3. Assert responseTime < 5000
    * print 'Write your solution here - see SOLUTIONS.md only AFTER trying'
