# Day 7: Python for Data Engineering

## Topics Covered

- **Module 1 — Structured data:** pandas basics, reading CSV/Excel/JSON into DataFrames, filtering, `groupby`/`.agg()`, `pd.merge()` joins, and handling missing data with `isna()` / `fillna()` / `dropna()`
- **Module 2 — APIs & semi-structured data:** calling HTTP APIs with `requests`, parsing JSON responses (including `pd.json_normalize()` on nested list/dict shapes), and regex (`re`) for turning raw log lines into a DataFrame
- **Module 3 — Databases:** connecting to PostgreSQL with SQLAlchemy/psycopg2, loading and reading data back, and writing parameterized queries to avoid SQL injection

## Data

The `data/` folder holds the source files used throughout the notebook:

- `customers.xlsx`
- `orders.csv`
- `products.json`
- `shipment_logs.txt` (raw, semi-structured log lines parsed with regex in Module 2)

## Files

- `python-for-data-engineering-assignment.ipynb` — the original class walkthrough notebook, exactly as run live (Modules 1-3, in prose/demo form).
- `python-for-data-engineering-questions.ipynb` — the same material broken into 27 numbered practice exercises (one task prompt per section, e.g. `**9.**`), each followed by an empty code cell to fill in yourself.
- `python-for-data-engineering-solved.ipynb` — worked solutions for every exercise in the questions notebook, under matching headings (e.g. `### 9. GroupBy: total revenue per country`). Module 1's cells were re-run fresh to confirm they work standalone; Module 2/3 cells keep the real outputs captured during the live class session against the mock API and local Postgres, since those services aren't available in every environment this repo is opened in.

## How to Run

One-time setup:

```bash
pip install -r requirements.txt
```

Module 3 also expects a local PostgreSQL instance to connect to. Copy `.env.example` to `.env` and fill in your own local password before running those cells:

```bash
cp .env.example .env
```

Then open whichever notebook you want:

```bash
jupyter notebook python-for-data-engineering-questions.ipynb
```

Or open it directly in VS Code / JupyterLab and run the cells top to bottom, using the `Python 3 (ipykernel)` kernel. Module 2's API cells expect a local mock partner API running (as set up in class); Module 3's cells expect a local PostgreSQL database to be reachable at `localhost:5432`.

## What I Learned

The missing-data section (1.5) was the clearest lesson of Module 1: `discount_pct`, `shipping_cost`, and a missing `customer_id` each needed a genuinely different fix — filling with `0` where missing means "no discount", filling with the median (not the mean) for a right-skewed `shipping_cost`, and dropping rows outright when there's no `customer_id` to attribute the order to. It reinforced that `fillna()` is a business decision about what the missing value *means*, not a one-size-fits-all statistical patch. Module 2's regex exercise on `shipment_logs.txt` showed how a named-group pattern (`(?P<field>...)`) turns unstructured log lines into the same tidy DataFrame shape as a CSV, and `pd.json_normalize(..., record_path=..., meta=...)` was the right tool once an API response nested a list of events inside each order. Module 3's SQL injection demo was the standout: seeing `' OR '1'='1` turn a single-customer lookup into a full table dump made concrete why parameters (`:cid` with SQLAlchemy, `%s` with psycopg2) aren't just a style preference — string-formatting user input directly into SQL is a real, exploitable vulnerability.

## Challenges Faced

Getting Module 3 running locally was the trickiest part, since it depends on a PostgreSQL instance actually being up and reachable — the notebook fails at `engine.connect()` with a connection error if Docker/Postgres isn't running yet, which looks like a code bug at first but is really an environment problem. Keeping the database password out of the notebook (via a `.env` file) also took some care, since it's easy to accidentally hardcode a working password once you're debugging a connection issue and forget to switch back to reading it from the environment.
