import psycopg

conn = psycopg.connect(
    host="localhost",
    port=5432,
    dbname="banking_db",
    user="newanatandukar",
    password=""
)

cursor = conn.cursor()

print("\nConnected to banking_db.")

# cursor.execute("""
# CREATE TABLE IF NOT EXISTS Customer (
#     CustomerID INT PRIMARY KEY,
#     Name VARCHAR(50),
#     Email VARCHAR(100),
#     Phone VARCHAR(15),
#     City VARCHAR(50),
#     CustomerType VARCHAR(30)
# );
# """)

conn.commit()

print("Customer table created successfully.")

customers_data = [
    (1, 'Ravi Sharma', 'ravi.sharma@gmail.com', '9812345001', 'Kathmandu', 'Individual'),
    (2, 'Green Leaf Restaurant', 'contact@greenleaf.com', '9812345002', 'Pokhara', 'Business (B2B)'),
    (3, 'HR Department', 'hr@company.com', '9812345003', 'Kathmandu', 'Internal'),
    (4, 'Kathmandu Metro Office', 'info@ktmmetro.gov.np', '9812345004', 'Kathmandu', 'Government'),
    (5, 'Sita Gurung', 'sita.gurung@yahoo.com', '9812345005', 'Lalitpur', 'Loyal/Repeat'),
    (6, 'Anil Thapa', 'anil.thapa@outlook.com', '9812345006', 'Biratnagar', 'New Customer'),
    (7, 'Maya Karki', 'maya.karki@gmail.com', '9812345007', 'Bhaktapur', 'Impulse'),
    (8, 'Suresh Rana', 'suresh.rana@gmail.com', '9812345008', 'Butwal', 'Discount/Bargain'),
    (9, 'Nisha Adhikari', 'nisha.adhikari@gmail.com', '9812345009', 'Dharan', 'Need-Based'),
    (10, 'Bikash Basnet', 'bikash.basnet@gmail.com', '9812345010', 'Chitwan', 'Wandering/Browsing')
]

# cursor.executemany("""
# INSERT INTO Customer
# (
#     CustomerID,
#     Name,
#     Email,
#     Phone,
#     City,
#     CustomerType
# )
# VALUES (%s, %s, %s, %s, %s, %s)
# ON CONFLICT (CustomerID) DO NOTHING;
# """, customers_data)

conn.commit()

print("Customer data inserted successfully.")

# cursor.execute("""
# UPDATE Customer
# SET Email = %s
# WHERE CustomerID = %s;
# """, ("hr-new@company.com", 3))

conn.commit()

print("Customer 3 email updated successfully.")

# cursor.execute("""
# CREATE TABLE IF NOT EXISTS Orders (
#     OrderID INT PRIMARY KEY,
#     CustomerID INT NOT NULL,
#     TotalAmount NUMERIC(10, 2) NOT NULL,
#     Status VARCHAR(30) NOT NULL,
#     OrderDate DATE,
#     FOREIGN KEY (CustomerID)
#         REFERENCES Customer(CustomerID)
# );
# """)

conn.commit()

print("Orders table created successfully.")

orders_data = [
    (1, 1, 800.00, 'Completed', '2026-01-10'),
    (2, 1, 500.00, 'Completed', '2026-01-15'),
    (3, 2, 2500.00, 'Completed', '2026-02-05'),
    (4, 2, 700.00, 'Cancelled', '2026-02-10'),
    (5, 3, 1200.00, 'Completed', '2026-03-01'),
    (6, 4, 2000.00, 'Cancelled', '2026-03-05'),
    (7, 5, 1500.00, 'Completed', '2026-03-10'),
    (8, 5, 900.00, 'Completed', '2026-03-15'),
    (9, 6, 600.00, 'Completed', '2026-04-01'),
    (10, 7, 1800.00, 'Completed', '2026-04-05'),
    (11, 8, 1100.00, 'Completed', '2026-04-10'),
    (12, 8, 500.00, 'Cancelled', '2026-04-15'),
    (13, 9, 300.00, 'Completed', '2026-05-01'),
    (14, 10, 2200.00, 'Completed', '2026-05-05')
]

# cursor.executemany("""
# INSERT INTO Orders
# (
#     OrderID,
#     CustomerID,
#     TotalAmount,
#     Status,
#     OrderDate
# )
# VALUES (%s, %s, %s, %s, %s)
# ON CONFLICT (OrderID) DO NOTHING;
# """, orders_data)

conn.commit()

print("Order data inserted successfully.")

# cursor.execute("""
# SELECT
#     c.CustomerID,
#     c.Name,
#     COUNT(o.OrderID) AS total_orders
# FROM Customer AS c
# INNER JOIN Orders AS o
#     ON c.CustomerID = o.CustomerID
# WHERE o.Status <> 'Pending'
# GROUP BY
#     c.CustomerID,
#     c.Name
# HAVING COUNT(o.OrderID) > 1
# ORDER BY total_orders DESC;
# """)

cursor.execute("""
SELECT
    c.CustomerID,
    c.Name,
    SUM(o.TotalAmount) AS total_spent
FROM Customer AS c
INNER JOIN Orders AS o
    ON c.CustomerID = o.CustomerID
WHERE o.Status <> 'Cancelled'
GROUP BY
    c.CustomerID,
    c.Name
HAVING SUM(o.TotalAmount) > 1000
ORDER BY total_spent DESC;
""")

rows = cursor.fetchall()

print("\n" + "=" * 70)
print("CUSTOMERS WHO SPENT MORE THAN 1000")
print("=" * 70)

for row in rows:
    print(
        "Customer ID:", row[0],
        "| Name:", row[1],
        "| Total Spent:", row[2]
    )

rows = cursor.fetchall()

cursor.close()
conn.close()

print("\nDatabase connection closed.")