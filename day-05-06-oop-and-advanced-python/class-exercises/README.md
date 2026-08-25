# Day 5-6: Advanced Python & OOP

## Topics Covered

- Comprehensions (list, dict, set, generator expressions)
- Iterators & generators (the iterator protocol, `yield`, lazy evaluation)
- Functional programming (higher-order functions, `lambda`, `map`/`filter`/`reduce`/`sorted`)
- Decorators & properties (closures, `functools.wraps`, `@property`)
- Object-oriented programming (classes, the four pillars, inheritance, ABCs)

## Exercises

Each chapter's practice exercises (Easy / Medium / Hard) and Challenge Project from the Python Mastery Handbook:

1. Comprehensions — cubes/strip/vowels, even-map/word-lengths/sum-of-squares, flatten/invert/log-counts, plus a Mini Log Analyzer challenge
2. Iterators & Generators — manual `next()` draining, `count_up`/`even_numbers` generators, memory comparison, a safe `Number` iterator, `read_chunks`, plus a streaming log pipeline + infinite Fibonacci challenge
3. Functional Programming — lambda vs `def`, `map`/`filter` vs comprehensions, custom sort keys, dispatch tables, `reduce`, plus a Mini Sales Data Pipeline challenge
4. Decorators & Properties — `@shout`/`@banner`, `@timer`, a validated `Temperature` property, `@retry`, stacked decorators, plus a Mini Access-Control System + `BankAccount` challenge
5. OOP — `Book`/`Shape`/`BankAccount` classes, classmethod constructors, multilevel inheritance, abstract `PaymentMethod`, plus a Mini Library Management System challenge

## Files

- `advanced-python-oop-questions.ipynb` — the exact Practice Exercise and Challenge Project prompts from the handbook, one per cell, each followed by an empty code cell to fill in yourself.
- `advanced-python-oop-solved.ipynb` — worked solutions for every exercise in the questions notebook, in the same order and under matching headings (e.g. `### 1. Cubes of 1-10`), already run.

## How to Run

Open either notebook in Jupyter:

```bash
jupyter notebook advanced-python-oop-questions.ipynb
```

Or open it directly in VS Code / JupyterLab and run the cells top to bottom, using the `Python 3 (ipykernel)` kernel. A few cells in Chapters 1 and 2 read `app.log` (included in this folder) to demonstrate log-processing pipelines, so keep it alongside both notebooks.

## What I Learned

Working through all five chapters back to back made the through-line clear: comprehensions, generators, and higher-order functions all lean on the same idea of treating loops and functions as values you compose rather than machinery you spell out by hand. Building a custom iterator by hand (`Number`) and then immediately reaching for `yield` afterward made obvious why generators exist — they write the same `__iter__`/`__next__` protocol for you. Chaining `read_lines -> parse -> only_errors` as three separate generators was the clearest demonstration of laziness: nothing runs until the last generator is actually iterated. Writing the `@requires_role` + `BankAccount` challenge tied decorators and `@property` together in one place, since the property's setter validation and the decorator's permission check are both examples of guarding a boundary without cluttering the core logic.

## Challenges Faced

The trickiest part was the sliding-window generator exercise (Chapter 2), since peeking one value ahead (`next_value = next(gen, None)`) to detect the end of the stream meant the loop condition and the print statement had to be ordered carefully, or the last item would either print twice or not at all. I worked through it by using `next(gen, None)` with a default instead of relying on `StopIteration`, so the loop could end cleanly on `current_value is None`. The other close call was the `Library` challenge project's `checkout`/`borrow` validation — it was easy to check `_checked_out` in the wrong object (the item vs. the member), which would have silently allowed double-borrowing an item.
