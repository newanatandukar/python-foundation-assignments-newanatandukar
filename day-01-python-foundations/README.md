# Day 1: Python Foundations

## Topics Covered

- Variables
- Data types
- String methods
- Operators
- Conditional statements

## Exercises

1. Sales Summary
2. Data Quality Checker
3. File Validator
4. Customer Record Cleaner
5. Pipeline Health Status
6. Dataset Access Decision

## How to Run

Run each file using:

```bash
python exercise-01-sales-summary.py
```

## What I Learned

I learned how to use f-strings to format numbers and build clear, readable output, and how string methods like `.strip()`, `.title()`, and `.lower()` are essential for cleaning messy real-world data. Writing conditional logic for the pipeline health and access decision exercises also helped me understand how to translate business rules (thresholds, percentages, statuses) directly into `if`/`elif`/`else` code.

## Challenges Faced

The trickiest part was deciding where to normalize data (e.g., lowercasing an email vs. title-casing a name) since applying the wrong string method silently produces incorrect output without raising an error. I worked through it by testing each transformation on the sample data individually and checking the printed result against what I expected before moving on to the next exercise.
