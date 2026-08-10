"""
Exercise: Batch Processor
Student: Newana Tandukar
Day: 2
"""

for batch_number in range(1,11): # range(start, stop) provides the range from start to stop - 1

    checkpoint_reached = batch_number % 3 == 0

    print(f"Processing batch {batch_number}")
    if checkpoint_reached:
        print("\nCheckpoint reached\n")
