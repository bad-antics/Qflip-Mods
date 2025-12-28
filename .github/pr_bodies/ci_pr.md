This draft PR adds a CI workflow that runs pytest across Python 3.9–3.11 on pushes and pull requests. It ensures unit tests (e.g., `flipper-pineapple-manager/tests`) are executed before merging other changes.

Notes:
- Caches pip packages to speed up runs
- Runs tests only if the `tests/` directory exists
- Uploads artifacts (optional) for debugging failures
