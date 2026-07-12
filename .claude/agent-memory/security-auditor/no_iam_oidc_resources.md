---
name: no-iam-oidc-resources
description: As of 2026-07-10 the repo's terraform/ directory has no IAM roles, policies, or OIDC provider/trust resources, and no .github/workflows exist
metadata:
  type: project
---

As of 2026-07-10, `terraform/` contains only `main.tf`, `variables.tf`, `outputs.tf`, `backend.tf`, `providers.tf` — no `aws_iam_role`, `aws_iam_policy`, `aws_iam_openid_connect_provider`, or similar resources. A repo-wide grep for `iam|oidc|github_actions` across `*.tf` returned no matches, and `.github/workflows/` does not exist yet.

**Why:** The standard security checklist for this agent includes "IAM policies must follow least privilege," "no wildcard in IAM actions/resources," and "OIDC trust policies scoped to repo/branch" — these are structurally not applicable until IAM/OIDC `.tf` files or a GitHub Actions workflow are added to the repo.
**How to apply:** Before flagging IAM/OIDC checklist items as findings, grep for `aws_iam_` and `openid_connect` in `terraform/*.tf` and check for `.github/workflows/*` to confirm whether they now exist — this memory may be stale. If they still don't exist, note IAM/OIDC checklist items as "N/A — no such resources defined yet" rather than skipping silently.
