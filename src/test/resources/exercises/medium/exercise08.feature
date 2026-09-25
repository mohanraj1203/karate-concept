@exercise08 @medium
Feature: Exercise 08 - Login with wrong password

  # REQUIREMENT: Login must fail with a wrong password.
  # API:        POST /api/auth/login { username: 'student', password: 'nope-wrong' }
  # EXPECTED:   HTTP 401 with error 'Unauthorized'
  # HINTS:
  #   1. Same shape as Scenario 14 - only status and body assertions change

  Background:
    * url baseUrl

  Scenario: Login fails with wrong password
    # TODO:
    # 1. POST the bad credentials above
    # 2. Verify status is 401
    # 3. Verify response.error == 'Unauthorized'
    * print 'Write your solution here - see SOLUTIONS.md only AFTER trying'
