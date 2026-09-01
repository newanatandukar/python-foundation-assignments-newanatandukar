import logging
import psycopg

logging.basicConfig(
    filename="etl.log",
    level=logging.INFO,
    format="%(asctime)s | %(levelname)s | %(message)s",
)
logger = logging.getLogger("banking_etl")
print("Logging configured -> etl.log")

try:
    conn = psycopg.connect(
        host="localhost",
        port=5432,
        dbname="banking_db",
        user="newanatandukar",
        password=""
    )
    cursor = conn.cursor()
    logger.info("Connected to banking_db successfully.")
except Exception as e:
    logger.error("Failed to connect to banking_db: %s", e)
    raise


conn.commit()
logger.info("Customer table check/create step complete.")

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

conn.commit()
logger.info("Customer data inserted successfully (%d rows staged).", len(customers_data))

conn.commit()
logger.info("Customer 3 email updated successfully.")

conn.commit()
logger.info("Orders table check/create step complete.")

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


conn.commit()
logger.info("Order data inserted successfully (%d rows staged).", len(orders_data))

try:
    cursor.execute("""
    SELECT
        c.CustomerID,
        c.Name,
        SUM(o.TotalAmount) AS total_spent
    FROM Customer AS c
    INNER JOIN Orders AS o
        ON c.CustomerID = o.CustomerID
    o.Status <> 'Cancelled'
    GROUP BY
        c.CustomerID,
        c.Name
    HAVING SUM(o.TotalAmount) > 1000
    ORDER BY total_spent DESC;
    """)
    rows = cursor.fetchall()
    logger.info("Query executed successfully — %d customers returned.", len(rows))
except Exception as e:
    logger.error("Query failed: %s", e)
    rows = []

print("CUSTOMERS WHO SPENT MORE THAN 1000")

for row in rows:
    line = f"Customer ID: {row[0]} | Name: {row[1]} | Total Spent: {row[2]}"
    print(line)
    logger.info(line)

cursor.close()
conn.close()
logger.info("Database connection closed.")
print("\nDatabase connection closed.")