@exercise09 @medium
Feature: Exercise 09 - Create and fetch a user

  # REQUIREMENT: Create a user, then fetch it back by id.
  # APIS:       POST /api/users then GET /api/users/{id}
  # EXPECTED:   POST -> 201 with numeric id; GET -> 200 with the same username
  # HINTS:
  #   1. Build a unique username with a timestamp (see Scenario 11):
  #      "* def ts = java.lang.System.currentTimeMillis()"
  #   2. Save "* def userId = response.id" then reuse it in the path

  Background:
    * url baseUrl

  Scenario: Create then fetch a user
    # TODO:
    # 1. POST a new unique user
    # 2. Save the returned id
    # 3. GET /api/users/{id} and verify the username matches
    * print 'Write your solution here - see SOLUTIONS.md only AFTER trying'
