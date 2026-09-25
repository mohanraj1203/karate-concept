@exercise10 @medium
Feature: Exercise 10 - Authenticated profile check

  # REQUIREMENT: Login, then call GET /api/auth/me with the token.
  # APIS:       POST /api/auth/login then GET /api/auth/me
  # EXPECTED:   Both 200; /me returns username 'student'
  # HINTS:
  #   1. Save "* def token = response.token" (see Scenario 14)
  #   2. Send "And header Authorization = 'Bearer ' + token" (see Scenario 15)

  Background:
    * url baseUrl

  Scenario: Fetch my profile with a token
    # TODO:
    # 1. Login as student/password123, save token
    # 2. GET /api/auth/me with the Bearer header
    # 3. Verify username == 'student'
    * print 'Write your solution here - see SOLUTIONS.md only AFTER trying'
