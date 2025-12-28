# pineflip
pineapple and flipper management

## Automation

This repository includes a scheduled GitHub Actions workflow `.github/workflows/auto-deps-update.yml` that runs daily (03:00 UTC) and can be manually triggered. The workflow attempts to safely upgrade pinned dependencies in `flipper-pineapple-manager/requirements.txt`, create a branch like `auto/deps-update-<run_id>`, and open a pull request for review. You can disable or modify the schedule by editing or removing that workflow.

