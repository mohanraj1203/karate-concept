@exercise19 @hard
Feature: Exercise 19 - Cancel an order

  # REQUIREMENT: Build a cart with one item, order it, then cancel it.
  # STEPS: login -> create cart -> add { productId: 5, quantity: 1 }
  #        -> POST /api/orders { cartId } -> DELETE /api/orders/{id}/cancel
  # EXPECTED: order 201 with status CREATED; cancel 200 with status CANCELLED
  # HINTS:
  #   1. Cancel uses: "Given path 'api/orders', orderId, 'cancel'" + "When method DELETE"

  Background:
    * url baseUrl

  Scenario: Create then cancel an order
    # TODO:
    # 1. Login, create cart, add product 5 x1, create order
    # 2. DELETE /api/orders/{id}/cancel with the token
    # 3. Verify status CANCELLED
    * print 'Write your solution here - see SOLUTIONS.md only AFTER trying'
