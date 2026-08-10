"""
Exercise: Sales List Analysis
Student: Newana Tandukar
Day: 2
"""

# input/ declaration
monthly_sales = [85000, 120000, 95000, 140000, 75000, 160000]
minimum_price = 100000

# Sorted list from highest to lowest
sorted_sales = sorted(monthly_sales, reverse=True) # High to low

# Values above 100000
sales_above_minimum_price =  [sales_value for sales_value in monthly_sales if sales_value > minimum_price]

# Each amount with 13% tax added
sales_with_tax = [sales_value * 1.13 for sales_value in monthly_sales]

# Total sales amount
total_sales = sum(monthly_sales)

# Average sales amount
average_sales = total_sales / len(monthly_sales)

print("Sorted (high to low):", sorted_sales)
print("Above minimum price:", sales_above_minimum_price)
print("With 13% tax:", sales_with_tax)
print("Total sales:", total_sales)
print("Average sales:", average_sales)
