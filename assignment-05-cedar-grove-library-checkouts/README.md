# Assignment 5: Cedar Grove Public Library -- Checkouts

## Topics Covered

- pandas: loading a CSV with parsed date columns, `isna()`/`fillna()` for column-specific missing-data strategies, `groupby()` + `.mean()`/`.sum()` with sorting, `pd.merge()`
- `requests`: calling a real public API ([Open Library](https://openlibrary.org/)), parsing JSON, and a `try`/`except` fallback so the assignment stays completable if the live call fails

## Scenario

Cedar Grove Public Library tracks every checkout in `data/checkouts.csv` -- who checked out which book, when it was due, when (if ever) it came back, and any late fee. Five problems, basic to medium:

1. Load the data and count total checkouts vs. still-checked-out books.
2. Clean it the right way per column: `is_returned` as an explicit boolean instead of dropping rows with no `return_date`, and `late_fee` filled with `0` (no fee ever charged).
3. Average late fee per genre, for returned books only.
4. Look up each book's author and first-publish year with the Open Library API, with a hard-coded fallback if the call fails.
5. Merge in the author data and find total late fees per author.

## Files

- `Assignment_Starter.ipynb` -- the original assignment as given, with `TODO`s and "check yourself" `assert` cells.
- `Assignment_NewanaTandukar.ipynb` -- the completed assignment, run top to bottom with the real Open Library API (all assert checks pass).

## How to Run

```bash
jupyter notebook Assignment_NewanaTandukar.ipynb
```

Or open it directly in VS Code / JupyterLab and run top to bottom, using the `Python 3 (ipykernel)` kernel. Needs `pandas`, `numpy`, and `requests` installed, plus an open internet connection for Problem 4 (it falls back to a hard-coded `BACKUP_BOOK_FACTS` dict if the API call fails, so the assignment is still completable offline).

## What I Learned

The cleaning problem (2) was the clearest lesson: a missing `return_date` here isn't bad data at all, it's a perfectly normal state (the book just hasn't come back yet), so the right move is an explicit `is_returned` boolean rather than `dropna()`-ing those rows away or inventing a fake date -- very different from `late_fee`, where a missing value genuinely does mean "zero," since no fee was ever charged. Problem 4 was the most interesting: the real Open Library API doesn't always return the edition I expected. For *War and Peace* and *Crime and Punishment*, the top search hit was the original Russian edition -- author name in Cyrillic, and a `first_publish_year` for that original release rather than the familiar English translation date. A couple of other titles (*The Great Gatsby*, *The Catcher in the Rye*) came back with an earlier `first_publish_year` than the commonly-cited one too, just from a different edition ranking first. Since none of that raised an exception, my `try`/`except` fallback correctly left those results alone rather than "fixing" them -- a good reminder that a successful API response and a *correct* one aren't always the same thing, and that "best match" from a search endpoint is a heuristic, not a guarantee.

## Challenges Faced

Merging `book_facts_df` back into `checkouts_clean` (Problem 5) tripped me up briefly because `book_facts_df` is indexed by `book_title` rather than having it as a normal column -- `pd.merge(..., on="book_title")` fails until you `reset_index()` first so the title becomes a real column both DataFrames can join on. The other thing I had to slow down on was Problem 4's `try`/`except`: it's tempting to catch bare `Exception`, but the assignment specifically wants `RequestException`/`KeyError`/`IndexError` -- catching everything would also silently swallow real bugs in my own code, not just API failures.
