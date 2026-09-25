@exercise16 @hard
Feature: Exercise 16 - Reusable login with call

  # REQUIREMENT: Use the shared login feature, then list orders.
  # STEPS: call login.feature -> GET /api/orders with the token
  # EXPECTED: 200 and response is an array
  # HINTS:
  #   1. See Scenario 25:
  #      "* def login = call read('classpath:features/common/login.feature') { username: 'student', password: 'password123' }"

  Background:
    * url baseUrl

  Scenario: List orders with a reused login
    # TODO:
    # 1. Call the reusable login feature
    # 2. GET /api/orders with 'Bearer ' + login.token
    # 3. Verify status 200 and response is an array
    * print 'Write your solution here - see SOLUTIONS.md only AFTER trying'
