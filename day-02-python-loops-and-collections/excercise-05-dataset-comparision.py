"""
Exercise: Data Comparision
Student: Newana Tandukar
Day: 2
"""

# input
dataset_a = {
    "customer",
    "sales",
    "product",
    "employee"
}

dataset_b = {
    "sales",
    "product",
    "supplier",
    "inventory"
}

# All unique dataset names (union)
all_datasets = dataset_a | dataset_b
print("All unique dataset names:\n", all_datasets)

# Datasets found in both groups (intersection)
common_datasets = dataset_a & dataset_b
print("\nDatasets in both groups:", common_datasets)

# Datasets only in dataset_a (difference)
only_in_dataset_a = dataset_a - dataset_b
print("\nDatasets only in dataset_a:", only_in_dataset_a)

# Datasets only in dataset_b (difference)
only_in_dataset_b = dataset_b - dataset_a
print("\nDatasets only in dataset_b:", only_in_dataset_b)
