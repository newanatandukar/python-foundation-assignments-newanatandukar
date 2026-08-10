"""
Exercise: Dataset Access Decision (Stretch)
Student: Newana Tandukar
Day: 1
"""

# Details
user_role = "analyst"
dataset_sensitivity = "confidential"
user_clearance_level = 2
has_manager_approval = True

# Map sensitivity levels to the minimum clearance required to view them
sensitivity_requirements = {
    "public": 0,
    "internal": 1,
    "confidential": 2,
    "restricted": 3,
}

required_clearance = sensitivity_requirements[dataset_sensitivity]

# Logic Implementation:
# clearance must be high enough, and restricted data
# additionally requires manager approval regardless of role
if user_clearance_level < required_clearance:
    decision = "Denied"
    reason = "Insufficient clearance level"
elif dataset_sensitivity == "restricted" and not has_manager_approval:
    decision = "Denied"
    reason = "Restricted data requires manager approval"
elif user_role == "analyst" and dataset_sensitivity == "restricted":
    decision = "Denied"
    reason = "Analysts cannot access restricted datasets"
else:
    decision = "Granted"
    reason = "All access requirements met"

# Output
print(f"User role: {user_role}")
print(f"Dataset sensitivity: {dataset_sensitivity}")
print(f"Required clearance: {required_clearance}")
print(f"User clearance: {user_clearance_level}")
print(f"Access decision: {decision}")
print(f"Reason: {reason}")
