@exercise20 @hard
Feature: Exercise 20 - Mini end-to-end

  # REQUIREMENT: Login -> create cart -> add product 8 x2 -> create order -> get order.
  # EXPECTED:   order total == 99.99*2 == 199.98, status CREATED on both calls
  # HINTS:
  #   1. Mini version of Scenario 30 - chain every id with "def"
  #   2. Use the reusable login via "call" (see Scenario 25)

  Background:
    * url baseUrl

  Scenario: Mini end-to-end flow
    # TODO:
    # 1. call login.feature for student
    # 2. Create cart, add product 8 x2
    # 3. Create order, verify total 199.98
    # 4. Get order, verify status CREATED
    * print 'Write your solution here - see SOLUTIONS.md only AFTER trying'
