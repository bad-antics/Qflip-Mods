# pineflip
pineapple and flipper management

## Dependency updates

- Dependabot is enabled for the `flipper-pineapple-manager` directory and will open weekly PRs for pip dependencies.
- A conservative monthly workflow (`.github/workflows/safe-deps-update.yml`) will create a **draft PR** with pinned dependency updates and run `pip check` and any present test suite; the PR must be reviewed and merged manually.


