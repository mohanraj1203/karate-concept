@exercise15 @hard
Feature: Exercise 15 - Cart total for two lines

  # REQUIREMENT: Build a cart with 2 different products and check the total.
  # STEPS: login -> create cart -> add { productId: 3, quantity: 1 }
  #        -> add { productId: 7, quantity: 2 } -> GET total
  # EXPECTED: total == 999.00*1 + 349.99*2 == 1698.98, itemCount == 3
  # HINTS:
  #   1. See Scenarios 21-23 for each step
  #   2. Floating point: compare against 1698.98 directly (server rounds to 2dp)

  Background:
    * url baseUrl

  Scenario: Two-line cart total
    # TODO:
    # 1. Login and create a cart
    # 2. Add both lines
    # 3. GET the total and verify 1698.98 and itemCount 3
    * print 'Write your solution here - see SOLUTIONS.md only AFTER trying'
