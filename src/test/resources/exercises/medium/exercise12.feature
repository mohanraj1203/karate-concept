@exercise12 @medium
Feature: Exercise 12 - Check the version header

  # REQUIREMENT: Every API response must carry X-SmartCart-Version: 1.0.
  # API:        GET /api/products/1
  # EXPECTED:   HTTP 200 and header value '1.0'
  # HINTS:
  #   1. See Scenario 19: responseHeaders['X-SmartCart-Version'][0]

  Background:
    * url baseUrl

  Scenario: Version header is present
    # TODO:
    # 1. GET /api/products/1
    # 2. Verify status 200
    # 3. Verify the X-SmartCart-Version header equals '1.0'
    * print 'Write your solution here - see SOLUTIONS.md only AFTER trying'
