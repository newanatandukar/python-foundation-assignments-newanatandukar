# Day 2: Loops & Collections

## Topics Covered

- `for` and `while` loops, `break` / `continue`
- List comprehensions
- Lists (sorting, filtering, aggregating)
- Sets and set operations (union, intersection, difference)
- Dictionaries and dictionary comprehensions
- Nested dictionaries
- Functions and input validation

## Exercises

1. Batch Processor
2. Retry Simulation
3. Clean Numeric Values (script + notebook)
4. Sales List Analysis
5. Dataset Comparison
6. Student Score Dictionary
7. Nested Order Summary
8. Contact Book Menu (stretch)

## How to Run

Run a `.py` file with:

```bash
python exercise-01-batch-processor.py
```

Run the notebook with Jupyter:

```bash
jupyter notebook excercise-03-clean-numeric-values.ipynb
```

Or open the `.ipynb` file in VS Code / JupyterLab and run the cells directly, using the `Python 3 (ipykernel)` kernel.

## What I Learned

Loops made it possible to process a batch or a dictionary item by item instead of writing repetitive code, and `continue`/`break` gave fine control over skipping or stopping early (batch checkpoints, retry simulation). Comparing the `for` loop version of Clean Numeric Values with the list comprehension version showed how the same filtering logic can be written more compactly, and working with sets and nested dictionaries made it clear how useful Python's built-in collections are for real dataset comparisons and order summaries.

## Challenges Faced

`isinstance(values, bool)` tripped me up at first because `bool` is a subclass of `int` in Python, so a plain `isinstance(values, int)` check silently let `True`/`False` through as valid numbers. I fixed it by explicitly excluding booleans in the loop version, and confirmed in the list comprehension version that it wasn't needed there since that input list had no boolean values to begin with.
