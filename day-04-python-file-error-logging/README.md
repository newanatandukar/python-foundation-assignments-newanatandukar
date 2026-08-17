# Day 4: File Handling, Error Handling & Logging

## Topics Covered

- File I/O with the `with` statement (read/write text files)
- The `csv` module (`csv.writer`, `csv.DictReader`)
- The `json` module (`json.load`, `json.dump`)
- Custom exceptions (subclassing `Exception`)
- `try` / `except` / `else` / `finally`
- The `logging` module (`FileHandler`, log levels, formatters)

## Exercises

1. Line & Word Counter (file handling)
2. Inventory Value from CSV (`csv` module)
3. Filtering a JSON Library Catalog (`json` module)
4. Custom Exception for User Registration (`InvalidAgeError`)
5. Order Pipeline with Logging (file + error handling + logging integration)

## How to Run

Open the notebook in Jupyter:

```bash
jupyter notebook newana_tandukar_file-handling-error-logging-assignment.ipynb
```

Or open it directly in VS Code / JupyterLab and run the cells top to bottom, using the `Python 3 (ipykernel)` kernel. Each question's setup cell writes its own sample data file (`diary.txt`, `products.csv`, `library.json`, `orders.csv`) to this folder before the answer cell reads it back — run the notebook in order for this to work. Question 5 also writes `orders_clean.json` and `orders_pipeline.log` as part of its output.

## What I Learned

Working through the CSV and JSON questions made it obvious why you can't trust the types coming out of either format — every CSV field is a string until you convert it yourself, and a JSON list of dicts still needs the same filtering logic as any other list of dicts. The custom exception exercise showed why it's worth raising a specific exception type (`InvalidAgeError`) instead of a generic `ValueError` — it let `try_register` handle "this age is out of range" and "this input couldn't be converted at all" as two clearly different failure cases instead of collapsing them into one message. Question 5 tied everything together: reading a CSV row by row, validating and converting each field, logging successes at `INFO` and failures at `ERROR`, and still producing a clean JSON output even though two of the four input rows were bad.

## Challenges Faced

The logging setup in Question 5 was the trickiest part — `logging.getLogger("orders")` returns the *same* logger object every time it's called, so re-running the cell in the notebook kept stacking a new `FileHandler` onto the old ones, which meant every log line got written multiple times. I fixed it by clearing `logger.handlers` at the start of `process_orders` before attaching a fresh handler, so re-running the function in the same kernel session always produces a clean, single copy of the log file.
