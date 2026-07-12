---
name: portfolio-terraform-baseline
description: Snapshot of terraform/ security posture for the portfolio-site (S3+CloudFront) repo as of 2026-07-10, listing what's already correct vs. open gaps
metadata:
  type: project
---

As of 2026-07-10, `terraform/main.tf` (portfolio-site S3 + CloudFront static site) already does the following correctly — do not re-flag these as findings:
- `aws_s3_bucket_public_access_block` fully enabled (all four flags true).
- Uses CloudFront **OAC** (`aws_cloudfront_origin_access_control`), not legacy OAI.
- S3 bucket policy scopes access to CloudFront via `AWS:SourceArn` condition (prevents confused-deputy).
- `viewer_protocol_policy = "redirect-to-https"` enforced on the default cache behavior.
- No hardcoded account IDs/ARNs — account ID is pulled via `data.aws_caller_identity.current`.

Open gaps identified in that same audit (still true unless verified otherwise on re-read):
- No `aws_cloudfront_response_headers_policy` attached — no CSP/X-Frame-Options/HSTS security headers.
- No explicit `aws_s3_bucket_server_side_encryption_configuration` (relies on AWS's automatic default SSE-S3, not enforced/documented in IaC).
- No `aws_s3_bucket_versioning` on the website bucket.
- No CloudFront `logging_config` block and no `aws_s3_bucket_logging` on the website bucket (no audit trail).
- `backend.tf` intentionally ships with the S3/DynamoDB remote backend commented out (bootstrap chicken-and-egg pattern, documented inline) — this is intentional, not a bug, but root `.gitignore` only excludes `.terraform` and does **not** exclude `*.tfstate` or `*.tfvars`, so local state could be committed accidentally. Flag the `.gitignore` gap, not the commented backend itself.
- No `aws_wafv2_web_acl` attached to the CloudFront distribution.
- `viewer_certificate` uses `cloudfront_default_certificate = true`; the `domain_name` variable in `variables.tf` is declared but unused anywhere — likely an incomplete custom-domain feature, not itself a vulnerability.

**Why:** Recorded so future audits of this repo can diff against this baseline instead of re-discovering the same items, and can tell genuinely new issues apart from known/accepted gaps.
**How to apply:** On the next audit of `terraform/`, re-read the files fresh (don't trust this snapshot blindly — verify it still matches), then compare against this list: confirm fixed items are removed from findings, and carry forward any gaps still present.
