# TEST-CASE-GUIDE — 30 Karate Learning Scenarios

File locations are relative to `src/test/resources/features/`.
Run one tag with: `./gradlew test -Dkarate.options="--tags @scenario05"`
Run a level with: `./gradlew test -Dkarate.options="--tags @beginner"`

---

## BEGINNER (Scenarios 01–10) — products, no login needed

### Scenario 01 — Get all products — @scenario01 @beginner
File: `products/get-products.feature` — API: `GET /api/products`
Learn: `Given / When / Then`, `method GET`, `status`.
Syntax: `Given path 'api/products'` → `When method GET` → `Then status 200`.
Expected: 200 + non-empty JSON array. Observe: how Karate maps the URL to `baseUrl` from `karate-config.js`.

### Scenario 02 — Get product by ID — @scenario02 @beginner
File: `products/get-product.feature` — API: `GET /api/products/1`
Learn: `path` for URL segments.
Syntax: `Given path 'api/products/1'`.
Expected: 200, `response.id == 1`. Observe: path strings vs comma form (`path 'api/products', 3`).

### Scenario 03 — Validate product fields — @scenario03 @beginner
File: `products/get-product.feature` — API: `GET /api/products/3`
Learn: `match` (exact values + type placeholders `#string`, `#number`).
Expected: 200, name `iPhone 15`, price `999.0`. Observe: exact match vs fuzzy `#` matchers.

### Scenario 04 — Search with query params — @scenario04 @beginner
File: `products/search-products.feature` — API: `GET /api/products?category=mobile`
Learn: `param` builds the query string.
Expected: 200, 2 items, every `category == 'mobile'`. Observe: Karate URL-encodes params for you.

### Scenario 05 — Create a product — @scenario05 @beginner
File: `products/create-product.feature` — API: `POST /api/products`
Learn: `request` + `method POST` + reading `data/products.json`.
Expected: 201 + numeric id. Observe: create returns 201, and the body comes from a data file, not hard-coded.

### Scenario 06 — Update a product — @scenario06 @beginner
File: `products/update-product.feature` — API: `PUT /api/products/{id}`
Learn: `method PUT`; create-your-own-fixture pattern.
Expected: 200 with updated name/price. Observe: the test POSTs first so it never depends on seed data.

### Scenario 07 — Delete a product — @scenario07 @beginner
File: `products/delete-product.feature` — API: `DELETE /api/products/{id}`
Learn: `method DELETE`; verify deletion with a follow-up GET → 404.
Expected: 200 `Product deleted`, then 404. Observe: two HTTP calls inside one scenario.

### Scenario 08 — Product not found — @scenario08 @beginner
File: `products/delete-product.feature` — API: `GET /api/products/99999`
Learn: `status 404` + error-body matching.
Expected: 404, `error == 'Not Found'`. Observe: error responses are still JSON you can match.

### Scenario 09 — Invalid product rejected — @scenario09 @beginner
File: `products/create-product.feature` — API: `POST /api/products` (bad price)
Learn: `status 400` for validation failures.
Expected: 400, `error == 'Bad Request'`. Observe: negative tests assert the *error message*, not just the code.

### Scenario 10 — Validate a JSON array — @scenario10 @beginner
File: `products/get-products.feature` — API: `GET /api/products`
Learn: `match each` applies one assertion to every array element.
Expected: 200, every item matches the product shape. Observe: one line validates the whole list.

---

## MEDIUM (Scenarios 11–20) — users, auth, Karate power features

### Scenario 11 — Create a user — @scenario11 @medium
File: `users/create-user.feature` — API: `POST /api/users`
Learn: unique test data via `java.lang.System.currentTimeMillis()`.
Expected: 201 + numeric id. Observe: timestamps prevent duplicate-username failures on re-runs.

### Scenario 12 — Get a user by ID — @scenario12 @medium
File: `users/get-user.feature` — API: `GET /api/users/1`
Learn: reusing stable seed data (`student`).
Expected: 200, username `student`. Observe: reads are safe against seed data; writes use temp fixtures.

### Scenario 13 — Update a user — @scenario13 @medium
File: `users/update-user.feature` — API: `PUT /api/users/{id}`
Learn: partial-update body + id reuse via `def`.
Expected: 200 with new email/fullName. Observe: `* def userId = response.id` chains calls.

### Scenario 14 — Login and extract token — @scenario14 @medium
File: `auth/login.feature` — API: `POST /api/auth/login`
Learn: `* def token = response.token`.
Expected: 200, `tokenType == 'Bearer'`. Observe: extraction is the gateway to every protected API.

### Scenario 15 — Use the token — @scenario15 @medium
File: `auth/authentication.feature` — API: `GET /api/auth/me`
Learn: `And header Authorization = 'Bearer ' + token`.
Expected: 200, username `student`. Observe: the header line is the only difference between open and secured calls.

### Scenario 16 — Background — @scenario16 @medium
File: `users/delete-user.feature` — API: `POST` + `DELETE /api/users/{id}`
Learn: `Background:` runs before *each* scenario in the file.
Expected: 201 then 200 `User deleted`. Observe: shared setup (url, timestamps) lives in one place.

### Scenario 17 — Variables — @scenario17 @medium
File: `auth/authentication.feature` — APIs: login + `GET /api/products/{id}`
Learn: `* def` for ids, names, bodies, tokens.
Expected: 200 + `name == expectedName`. Observe: variables remove magic values from steps.

### Scenario 18 — Scenario Outline — @scenario18 @medium
File: `products/search-products.feature` — API: `GET /api/products?category=<category>`
Learn: `Scenario Outline:` + `Examples:` table runs once per row.
Expected: 3 runs (laptop/mobile/tablet), all 200. Observe: data-driven testing with zero duplication.

### Scenario 19 — Response headers — @scenario19 @medium
File: `products/get-products.feature` — API: `GET /api/products`
Learn: `match header …` and the `responseHeaders` map.
Expected: JSON content-type + `X-SmartCart-Version: 1.0`. Observe: headers come from the Spring `HeaderInterceptor`.

### Scenario 20 — Response time — @scenario20 @medium
File: `products/search-products.feature` — API: `GET /api/products?search=phone`
Learn: built-in `responseTime` (ms) + `assert`.
Expected: 200 and `responseTime < 5000`. Observe: performance budgets as one-line assertions.

---

## ADVANCED (Scenarios 21–30) — carts, orders, end-to-end

### Scenario 21 — Create cart — @scenario21 @advanced
File: `cart/create-cart.feature` — API: `POST /api/carts` (auth required)
Learn: protected POST, 201, empty-cart shape (`items == '#[]'`, `total == 0.0`).
Expected: 201. Observe: without a token this returns 401 (see Scenario 29).

### Scenario 22 — Add product to cart — @scenario22 @advanced
File: `cart/add-product.feature` — API: `POST /api/carts/{id}/items`
Learn: nested-resource paths; multi-segment `path` with variables.
Expected: 200, quantity 2, total `1998.0`. Observe: totals are server-computed, never trusted from the client.

### Scenario 23 — Calculate cart total — @scenario23 @advanced
File: `cart/calculate-cart.feature` — API: `GET /api/carts/{id}/total`
Learn: dedicated totals endpoint (`cartId`, `total`, `itemCount`, `items`).
Expected: `total == 1998.0`, `itemCount == 2`. Observe: totals endpoint vs embedded cart total.

### Scenario 24 — Chain APIs — @scenario24 @advanced
File: `cart/add-product.feature` — flow: login → create cart → add → get cart
Learn: chaining 4 calls with `def` ids across steps.
Expected: all 200/201, `itemCount == 1`. Observe: each step's output feeds the next step's input.

### Scenario 25 — Reusable login via call — @scenario25 @advanced
File: `cart/remove-product.feature` — API: `DELETE /api/carts/{id}/items/{productId}`
Learn: `call read('classpath:features/common/login.feature') {...}` returns `{ token, username, userId }`.
Expected: item removed, `total == 0.0`. Observe: `call` kills login copy-paste across all secured tests.

### Scenario 26 — JSON schema match — @scenario26 @advanced
File: `orders/create-order.feature` — API: `POST /api/orders`
Learn: multiline `"""` schema asserting every field at once.
Expected: 201, status `CREATED`, total `899.99`. Observe: schema + exact-value matchers mixed in one block.

### Scenario 27 — JavaScript validation — @scenario27 @advanced
File: `cart/calculate-cart.feature` — API: `GET /api/carts/{id}/total`
Learn: JS expressions (`Math.round(...*100)/100`) to dodge float error.
Expected: computed `expected == response.total`. Observe: Karate steps and real JavaScript interoperate freely.

### Scenario 28 — Order workflow — @scenario28 @advanced
File: `orders/get-order.feature` — flow: login → get product → create cart → add → total → create order → get order
Learn: 7-step workflow; cross-checking order total against cart total.
Expected: order `CREATED`, totals agree. Observe: the longest chain so far — every id threaded through.

### Scenario 29 — Negative testing — @scenario29 @advanced
File: `orders/cancel-order.feature` — six checks in one scenario
Learn: 401 (missing/bad token), 404 (bad product/order), 400 (bad quantity, missing `cartId`).
Expected: each failure asserts code + error body. Observe: one scenario, many `Given/When/Then` rounds — realistic hardening.

### Scenario 30 — Full SmartCart E2E — @scenario30 @advanced
File: `orders/order-flow.feature` — flow: create user → login → create cart → get product → add → total → create order → get order
Learn: everything combined: unique users, `call`, JS math, schema, chaining.
Expected: 8 steps green, order total equals JS-computed total. Observe: this is the capstone — if you understand it, you can write any Karate suite.
