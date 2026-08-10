"""
Exercise: Nested Order Summary
Student: Newana Tandukar
Day: 2
"""

#input
orders = {
    "ORD-001": {
        "customer": "Anisha",
        "amount": 2500,
        "status": "Completed"
    },
    "ORD-002": {
        "customer": "Ravi",
        "amount": 1800,
        "status": "Pending"
    },
    "ORD-003": {
        "customer": "Maya",
        "amount": 3200,
        "status": "Completed"
    }
}

# Print every order ID and customer
print("Customer Order details")
for order_id, details in orders.items():
    print(f" {order_id}: {details['customer']}")

# Print only completed orders
print("Completed orders:")
for order_id, details in orders.items():
    if details["status"] == "Completed":
        print(f"{order_id}: {details['customer']} - {details['amount']}")

# Total amount of completed orders and
# Count pending orders
pending_count = 0
total_completed_amount = 0

for details in orders.values():
    if details["status"] == "Completed":
        total_completed_amount += details["amount"]
    else:
        pending_count += 1
print("\n Pending orders count:", pending_count)
print("\nTotal completed amount: ", total_completed_amount)


# Add a new order
orders["ORD-004"] = {
    "customer": "Sagar",
    "amount": 1500,
    "status": "Pending"
}
print("\nUpdated orders:")
for order_id, details in orders.items():
    print(f" {order_id}: {details}")
