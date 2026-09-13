# Python Foundation Assignments

## Student Information

- Name: Newana Tandukar
- Cohort: #batch-16-1st-month-training
- Track Interest: Data Engineering

## About This Repository

This repository contains my assignments and practice exercises from the Python Foundation training.

## How to Run

Each day's folder contains a mix of plain `.py` scripts and, where noted, a Jupyter notebook covering few exercises.

**Run a `.py` script:**

```bash
python exercise-01-sales-summary.py
```

**Run a Jupyter notebook (`.ipynb`):**

```bash
jupyter notebook path/to/notebook.ipynb
```

Then run the cells from the browser UI. Notebooks can also be opened directly in VS Code or JupyterLab — select the `Python 3 (ipykernel)` kernel when prompted.

Both `.py` files and notebooks run on the same Python installation (managed via `pyenv`), so output should match regardless of which one you run.

## Database (Docker)

PostgreSQL runs in Docker instead of a local install. Start it with:

```bash
docker compose up -d
```

This starts a `postgres:16` container (`de-postgres`) on `localhost:5432` with data persisted in the `postgres_data` named volume, matching the credentials in `.env`. Stop it with `docker compose down` (data persists in the volume; add `-v` to wipe it).

## Assignment Progress

- [x] Day 1: Python Foundations
- [x] Day 2: Loops & Collections
- [x] Day 3: Functions & Modules
- [x] Day 4: File Handling, Error Handling & Logging
- [x] Day 5-6: Advanced Python & OOP
- [x] Day 7: Python for Data Engineering
- [x] Assignment 5: Cedar Grove Public Library: Checkouts
- [x] Assignment 6: SQL Operators
