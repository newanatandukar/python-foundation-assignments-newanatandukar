"""
Exercise: File Validator
Student: Newana Tandukar
Day: 1
"""

# Accepted file types for the pipeline
valid_extensions = (".csv", ".json", ".parquet")

# Input
file_name = input("Enter a file name: ")
file_name = file_name.strip().lower()

# Validation Logic
if file_name.endswith(valid_extensions):
    print(f"'{file_name}' is a valid file type.")
else:
    print(f"'{file_name}' is not a valid file type. Accepted types: .csv, .json, .parquet")
