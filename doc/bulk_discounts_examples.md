# Bulk Discounts

Bulk Discounts are subject to the following criteria:
 - Bulk discounts should have a percentage discount as well as a quantity threshold
 - Bulk discounts should belong to a Merchant
 - A Bulk discount is eligible for all items that the merchant sells. Bulk discounts for one merchant should not affect items sold by another merchant
 - Merchants can have multiple bulk discounts
  - If an item meets the quantity threshold for multiple bulk discounts, only the one with the greatest percentage discount should be applied
 - Bulk discounts should apply on a per-item basis
  - If the quantity of an item ordered meets or exceeds the quantity threshold, then the percentage discount should apply to that item only. Other items that did not meet the quantity threshold will not be affected.
  - The quantities of items ordered cannot be added together to meet the quantity thresholds, e.g. a customer cannot order 1 of Item A and 1 of Item B to meet a quantity threshold of 2. They must order 2 or Item A and/or 2 of Item B

## Examples

### Example 1

 - Merchant A has one Bulk Discount
  - Bulk Discount A is 20% off 10 items
 - Invoice A includes two of Merchant A’s items
  - Item A is ordered in a quantity of 5
  - Item B is ordered in a quantity of 5

In this example, no bulk discounts should be applied.

### Example 2

 - Merchant A has one Bulk Discount
  - Bulk Discount A is 20% off 10 items
 - Invoice A includes two of Merchant A’s items
  - Item A is ordered in a quantity of 10
  - Item B is ordered in a quantity of 5

In this example, Item A should be discounted at 20% off. Item B should not be discounted.

### Example 3

 - Merchant A has two Bulk Discounts
  - Bulk Discount A is 20% off 10 items
  - Bulk Discount B is 30% off 15 items
 - Invoice A includes two of Merchant A’s items
  - Item A is ordered in a quantity of 12
  - Item B is ordered in a quantity of 15

In this example, Item A should discounted at 20% off, and Item B should discounted at 30% off.

### Example 4

 - Merchant A has two Bulk Discounts
  - Bulk Discount A is 20% off 10 items
  - Bulk Discount B is 15% off 15 items
 - Invoice A includes two of Merchant A’s items
  - Item A is ordered in a quantity of 12
  - Item B is ordered in a quantity of 15

In this example, Both Item A and Item B should discounted at 20% off. Additionally, there is no scenario where Bulk Discount B can ever be applied.

### Example 5

 - Merchant A has two Bulk Discounts
  - Bulk Discount A is 20% off 10 items
  - Bulk Discount B is 30% off 15 items
 - Merchant B has no Bulk Discounts
 - Invoice A includes two of Merchant A’s items
  - Item A1 is ordered in a quantity of 12
  - Item A2 is ordered in a quantity of 15
 - Invoice A also includes one of Merchant B’s items
  - Item B is ordered in a quantity of 15

In this example, Item A1 should discounted at 20% off, and Item A2 should discounted at 30% off. Item B should not be discounted.
