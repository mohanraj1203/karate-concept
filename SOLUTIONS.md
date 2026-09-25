# Exercise Solutions

> Only open this file AFTER attempting the exercises yourself.
> Each solution is explained line-by-line so you learn the *why*, not just the *what*.

---

## Exercise 01 — Find all mobile products (`exercises/easy/exercise01.feature`)

```gherkin
Given path 'api/products'
And param category = 'mobile'
When method GET
Then status 200
And match response == '#[2]'
And match each response[*].category == 'mobile'
```

- `path 'api/products'` — base path; `baseUrl` comes from `Background: * url baseUrl`.
- `param category = 'mobile'` — appends `?category=mobile` to the URL.
- `method GET` + `status 200` — the request and its expected code.
- `match response == '#[2]'` — asserts the array has exactly 2 items.
- `match each …` — asserts every item's category equals `mobile`.

## Exercise 02 — Get product and check fields (`exercises/easy/exercise02.feature`)

```gherkin
Given path 'api/products/2'
When method GET
Then status 200
And match response.name == 'Dell XPS 13'
And match response.category == 'laptop'
And match response.price == '#number'
```

- `path` with the full segment fetches one product (Scenario 02 pattern).
- Exact matches (`== 'Dell XPS 13'`) pin known seed data.
- `'#number'` checks the type without hard-coding the price.

## Exercise 03 — Create a product (`exercises/easy/exercise03.feature`)

```gherkin
Given path 'api/products'
And request { name: 'My Tablet', description: 'Exercise tablet', price: 299.99, category: 'tablet', stock: 7 }
When method POST
Then status 201
And match response.id == '#number'
And match response.name == 'My Tablet'
```

- `request { … }` becomes the JSON body (Scenario 05 pattern).
- Creates return **201**, not 200 — the most common beginner mistake.
- The server assigns `id`; we only assert it is a number.

## Exercise 04 — Product not found (`exercises/easy/exercise04.feature`)

```gherkin
Given path 'api/products/777777'
When method GET
Then status 404
And match response.error == 'Not Found'
```

- An ID that can never exist forces the error branch (Scenario 08 pattern).
- Always assert the error body too — status alone is a weak test.

## Exercise 05 — Reject bad product data (`exercises/easy/exercise05.feature`)

```gherkin
Given path 'api/products'
And request { name: 'Freebie', description: 'Bad price', price: 0, category: 'accessories', stock: 1 }
When method POST
Then status 400
And match response.error == 'Bad Request'
```

- Price `0` violates the `price > 0` rule, so the API returns 400 (Scenario 09 pattern).
- Negative tests document the API's validation contract.

## Exercise 06 — Search products by keyword (`exercises/easy/exercise06.feature`)

```gherkin
Given path 'api/products'
And param search = 'sony'
When method GET
Then status 200
And match response[0].name contains 'Sony'
```

- `param search` triggers the keyword filter (Scenario 04 pattern with a different param).
- `contains` is a substring check — robust against exact-name changes.

## Exercise 07 — Validate the whole product list (`exercises/easy/exercise07.feature`)

```gherkin
Given path 'api/products'
When method GET
Then status 200
And match each response == { id: '#number', name: '#string', price: '#number', category: '#string', stock: '#number', description: '#string' }
```

- One `match each` line validates every element's shape (Scenario 10 pattern).
- Type placeholders keep the test green when seed prices change.

---

## Exercise 08 — Login with wrong password (`exercises/medium/exercise08.feature`)

```gherkin
Given path 'api/auth/login'
And request { username: 'student', password: 'nope-wrong' }
When method POST
Then status 401
And match response.error == 'Unauthorized'
```

- Same call as a successful login (Scenario 14), but bad credentials yield **401**.
- Auth failures return JSON too, so `match` still works.

## Exercise 09 — Create and fetch a user (`exercises/medium/exercise09.feature`)

```gherkin
* def ts = java.lang.System.currentTimeMillis()
Given path 'api/users'
And request { username: '#("u" + ts)', email: '#("u" + ts + "@example.com")', password: 'learn123', fullName: 'Ex Nine' }
When method POST
Then status 201
* def userId = response.id
Given path 'api/users', userId
When method GET
Then status 200
And match response.username == 'u' + ts
```

- `ts` makes the username unique so re-runs never hit "Username already exists".
- `* def userId = response.id` captures the server id for the second call.
- `path 'api/users', userId` shows the comma form of `path` (Scenario 11 + 12 combined).

## Exercise 10 — Authenticated profile check (`exercises/medium/exercise10.feature`)

```gherkin
Given path 'api/auth/login'
And request { username: 'student', password: 'password123' }
When method POST
Then status 200
* def token = response.token
Given path 'api/auth/me'
And header Authorization = 'Bearer ' + token
When method GET
Then status 200
And match response.username == 'student'
```

- Step 1 extracts the token (Scenario 14); step 2 spends it (Scenario 15).
- The space in `'Bearer ' + token` is required — missing it gives 401.

## Exercise 11 — Outline over product IDs (`exercises/medium/exercise11.feature`)

```gherkin
Given path 'api/products', <id>
When method GET
Then status 200
And match response.id == <id>
```

(with the given `Examples:` table of 1, 3, 5)

- `<id>` is substituted per row, so this runs 3 times (Scenario 18 pattern).
- Numbers in `Examples:` stay numbers — no quotes around `<id>` in the match.

## Exercise 12 — Check the version header (`exercises/medium/exercise12.feature`)

```gherkin
Given path 'api/products/1'
When method GET
Then status 200
And match responseHeaders['X-SmartCart-Version'][0] == '1.0'
```

- `responseHeaders` is a map of name → array; `[0]` takes the first value (Scenario 19).
- The header is set by the Spring `HeaderInterceptor` on every `/api/**` response.

## Exercise 13 — Response time budget (`exercises/medium/exercise13.feature`)

```gherkin
Given path 'api/users'
When method GET
Then status 200
And assert responseTime < 5000
```

- `responseTime` is Karate's built-in millisecond timer for the last call (Scenario 20).
- `assert` evaluates a raw JavaScript boolean expression.

## Exercise 14 — Update then verify (`exercises/medium/exercise14.feature`)

```gherkin
Given path 'api/products'
And request { name: 'Ex Mouse', description: 'ex', price: 20.0, category: 'accessories', stock: 9 }
When method POST
Then status 201
* def pid = response.id
Given path 'api/products', pid
And request { name: 'Ex Mouse v2', description: 'ex', price: 25.0, category: 'accessories', stock: 9 }
When method PUT
Then status 200
And match response.price == 25.0
And match response.name == 'Ex Mouse v2'
```

- Create-then-update keeps the test independent (Scenario 06 pattern).
- PUT needs the **full** valid body, not just the changed field.

---

## Exercise 15 — Cart total for two lines (`exercises/hard/exercise15.feature`)

```gherkin
Given path 'api/auth/login'
And request { username: 'student', password: 'password123' }
When method POST
Then status 200
* def token = response.token
Given path 'api/carts'
And header Authorization = 'Bearer ' + token
And request {}
When method POST
Then status 201
* def cartId = response.id
Given path 'api/carts', cartId, 'items'
And header Authorization = 'Bearer ' + token
And request { productId: 3, quantity: 1 }
When method POST
Then status 200
Given path 'api/carts', cartId, 'items'
And header Authorization = 'Bearer ' + token
And request { productId: 7, quantity: 2 }
When method POST
Then status 200
Given path 'api/carts', cartId, 'total'
And header Authorization = 'Bearer ' + token
When method GET
Then status 200
And match response.total == 1698.98
And match response.itemCount == 3
```

- Two `POST …/items` calls accumulate lines in one cart (Scenarios 21–23 combined).
- Expected math: `999.00 × 1 + 349.99 × 2 = 1698.98`; the server rounds to 2dp so a direct match is safe.
- `itemCount` is total *quantity* (1 + 2 = 3), not line count.

## Exercise 16 — Reusable login with call (`exercises/hard/exercise16.feature`)

```gherkin
* def login = call read('classpath:features/common/login.feature') { username: 'student', password: 'password123' }
Given path 'api/orders'
And header Authorization = 'Bearer ' + login.token
When method GET
Then status 200
And match response == '#[]'
```

- `call read(…)` runs the shared login and returns `{ token, username, userId }` (Scenario 25).
- `login.token` is used inline — no intermediate `def` needed (though one is fine too).

## Exercise 17 — Schema check on a product (`exercises/hard/exercise17.feature`)

```gherkin
Given path 'api/products/5'
When method GET
Then status 200
And match response ==
"""
{
  id: 5,
  name: 'iPad Air',
  price: 649.0,
  category: 'tablet',
  description: '#string',
  stock: '#number'
}
"""
```

- The `"""` block asserts the whole shape in one readable chunk (Scenario 26 pattern).
- Exact values pin seed data; `#` placeholders cover volatile fields.

## Exercise 18 — JavaScript discount check (`exercises/hard/exercise18.feature`)

```gherkin
Given path 'api/products/7'
When method GET
Then status 200
* def price = response.price
* def discounted = Math.round(price * 0.9 * 100) / 100
And match discounted == 314.99
```

- Values are pulled out of the response into JS variables (Scenario 27 pattern).
- `Math.round(x * 100) / 100` avoids binary float error: `349.99 × 0.9 = 314.99` exactly after rounding.

## Exercise 19 — Cancel an order (`exercises/hard/exercise19.feature`)

```gherkin
* def login = call read('classpath:features/common/login.feature') { username: 'student', password: 'password123' }
* def token = login.token
Given path 'api/carts'
And header Authorization = 'Bearer ' + token
And request {}
When method POST
Then status 201
* def cartId = response.id
Given path 'api/carts', cartId, 'items'
And header Authorization = 'Bearer ' + token
And request { productId: 5, quantity: 1 }
When method POST
Then status 200
Given path 'api/orders'
And header Authorization = 'Bearer ' + token
And request { cartId: '#(cartId)' }
When method POST
Then status 201
And match response.status == 'CREATED'
* def orderId = response.id
Given path 'api/orders', orderId, 'cancel'
And header Authorization = 'Bearer ' + token
When method DELETE
Then status 200
And match response.status == 'CANCELLED'
```

- Setup reuses the cart→order chain from Scenario 28; cancel is `DELETE …/cancel`.
- Both statuses are asserted: `CREATED` after ordering, `CANCELLED` after cancelling.

## Exercise 20 — Mini end-to-end (`exercises/hard/exercise20.feature`)

```gherkin
* def login = call read('classpath:features/common/login.feature') { username: 'student', password: 'password123' }
* def token = login.token
Given path 'api/carts'
And header Authorization = 'Bearer ' + token
And request {}
When method POST
Then status 201
* def cartId = response.id
Given path 'api/carts', cartId, 'items'
And header Authorization = 'Bearer ' + token
And request { productId: 8, quantity: 2 }
When method POST
Then status 200
Given path 'api/orders'
And header Authorization = 'Bearer ' + token
And request { cartId: '#(cartId)' }
When method POST
Then status 201
And match response.total == 199.98
* def orderId = response.id
Given path 'api/orders', orderId
And header Authorization = 'Bearer ' + token
When method GET
Then status 200
And match response.status == 'CREATED'
```

- A compressed Scenario 30: `call` login → cart → add → order → verify.
- `99.99 × 2 = 199.98` — small numbers keep the float math exact.
