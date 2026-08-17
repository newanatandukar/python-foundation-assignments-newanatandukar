# Day 3: Functions & Modules

## Topics Covered

- Function definitions and default arguments
- Variable-length arguments (`*args`)
- Returning multiple values from a function
- Built-in functions (`min`, `max`, `sum`, `sorted`)
- Variable scope and the `global` keyword
- Writing and importing a custom module
- Standard library modules (`random`, `datetime`)

## Exercises

1. Simple Interest Calculator (default arguments)
2. Class Average (`*args`)
3. Analyze Numbers (multiple return values + built-ins)
4. Shared Booking Counter (scope & `global`)
5. Temperature Report Module (custom module + `random` + `datetime`)

## How to Run

Open the notebook in Jupyter:

```bash
jupyter notebook functions-and-modules-assignment.ipynb
```

Or open it directly in VS Code / JupyterLab and run the cells top to bottom, using the `Python 3 (ipykernel)` kernel. Running the Part A cell of Question 5 writes `temperature_utils.py` to this folder, which the Part B cell then imports — run the notebook in order for this to work.

## What I Learned

Default arguments and `*args` made it clear how much flexibility Python functions can offer without needing separate overloaded versions, and returning a tuple of four values from `analyze_numbers` showed how natural it is to hand back several related results at once instead of building a class just to bundle them. The booking counter exercise made the purpose of the `global` keyword concrete — without it, `book_seats` and `reset_bookings` would each create their own local `total_seats_booked` instead of updating the shared one. Writing `temperature_utils.py` as a real file and importing it back into the notebook also tied together how modules, the standard library, and my own code work together in the same script.

## Challenges Faced

The trickiest part was Question 5, since it required writing a `.py` file to disk from within the notebook and then importing it in a later cell — if the module cell isn't re-run after editing its functions, or if it's run out of order, the notebook silently reuses a stale version of `temperature_utils.py` because Python caches imported modules. I worked through it by keeping the module-writing cell and the import cell separate and re-running the whole notebook top to bottom to confirm the final version of the module was the one actually being used.
